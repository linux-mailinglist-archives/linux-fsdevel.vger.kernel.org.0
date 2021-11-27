Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0545FF6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhK0Ots (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 09:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhK0Ors (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:47:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC3C06174A;
        Sat, 27 Nov 2021 06:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC853B81B05;
        Sat, 27 Nov 2021 14:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49994C53FAD;
        Sat, 27 Nov 2021 14:33:15 +0000 (UTC)
Date:   Sat, 27 Nov 2021 14:33:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YaJBp37+WUeDpZIM@arm.com>
References: <YaAROdPCqNzSKCjh@arm.com>
 <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211126222945.549971-1-agruenba@redhat.com>
 <YaFmaJqyie6KZ2bY@arm.com>
 <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 04:52:16AM +0100, Andreas Gruenbacher wrote:
> On Sat, Nov 27, 2021 at 12:06 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Nov 26, 2021 at 11:29:45PM +0100, Andreas Gruenbacher wrote:
> > > On Thu, Nov 25, 2021 at 11:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > As per Linus' reply, we can work around this by doing
> > > > a sub-page fault_in_writable(point_of_failure, align) where 'align'
> > > > should cover the copy_to_user() impreciseness.
> > > >
> > > > (of course, fault_in_writable() takes the full size argument but behind
> > > > the scene it probes the 'align' prefix at sub-page fault granularity)
> > >
> > > That doesn't make sense; we don't want fault_in_writable() to fail or
> > > succeed depending on the alignment of the address range passed to it.
> >
> > If we know that the arch copy_to_user() has an error of say maximum 16
> > bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
> > to probe the first 16 bytes rather than 1.
> 
> That isn't going to help one bit:

Not on its own but it does allow the restarted loop to use
fault_in_writeable() on the address where copy_to_user() stopped,
without the need to be byte-precise in the latter.

> [raw_]copy_to_user() is allowed to
> copy as little or as much as it wants as long as it follows the rules
> documented in include/linux/uaccess.h:
> 
> [] If copying succeeds, the return value must be 0.  If some data cannot be
> [] fetched, it is permitted to copy less than had been fetched; the only
> [] hard requirement is that not storing anything at all (i.e. returning size)
> [] should happen only when nothing could be copied.  In other words, you don't
> [] have to squeeze as much as possible - it is allowed, but not necessary.
> 
> When fault_in_writeable() tells us that an address range is accessible
> in principle, that doesn't mean that copy_to_user() will allow us to
> access it in arbitrary chunks.

Ignoring sub-page faults, my interpretation of the fault_in_writeable()
semantics is that an arbitrary copy_to_user() within the faulted in
range will *eventually* either succeed or the fault_in() fails. There
are some theoretical live-lock conditions like a concurrent thread
changing the permission (mprotect) in a way that fault_in() always
succeeds and copy_to_user() always fails. Fortunately that's just
theoretical.

The above interpretation doesn't hold with sub-page faults because of
the way fault_in_writeable() is probing - one byte per page. This series
takes the big hammer approach of making the liveness assumption above
work in the presence of sub-page faults. I'm fine with this since, from
my tests so far, only the btrfs search_ioctl() is affected and
fault_in_writeable() is not used anywhere else that matters (some
highmem stuff we don't have on arm64).

> It's also not the case that fault_in_writeable(addr, size) is always
> followed by copy_to_user(addr, ..., size) for the exact same address
> range, not even in this case.

I agree, that's not a requirement. But there are some expectations of
how the fault_in_writeable()/copy_to_user() pair is used, typically:

a) pre-fault before the uaccess with the copy_to_user() within the range
   faulted in or

b) copy_to_user() attempted with a subsequent fault_in_writeable() on
   the next address that the uaccess failed to write to.

You can have a combination of the above but not completely disjoint
ranges.

For liveness properties, in addition, fault_in_writeable() needs to
reproduce the fault conditions of the copy_to_user(). If your algorithm
uses something like (a), you'd need to probe the whole range at sub-page
granularity (this series. If you go for something like (b), either
copy_to_user() is exact or fault_in_writeable() compensates for the
uaccess inexactness.

> These alignment restrictions have nothing to do with page or sub-page
> faults.

My point wasn't alignment faults (different set of problems, though on
arm64 one needs a device memory type in user space). Let's say we have a
user buffer:

	char mem[32];

and mem[0..15] has MTE tag 0, mem[16..31] has tag 1, on arm64 a
copy_to_user(mem, kbuf, 32) succeeds in writing 16 bytes. However, a
copy_to_user(mem + 8, kbuf, 24) only writes 1 byte even if 8 could have
been written (that's in line with the uaccess requirements you quoted
above).

If we know for an arch the maximum delta between the reported
copy_to_user() fault address and the real one (if byte-copy), we can
tweak fault_in_writeable() slightly to probe this prefix at sub-page
granularity and bail out. No need for an exact copy_to_user().

> I'm also fairly sure that passing in an unaligned buffer will send
> search_ioctl into an endless loop on architectures with copy_to_user()
> alignment restrictions; there don't seem to be any buffer alignment
> checks.

On such architectures, copy_to_user() should take care of doing aligned
writes. I don't think it's for the caller to guarantee anything here as
it doesn't know what the underlying uaccess implementation does. On
arm64, since the architecture can do unaligned writes to Normal memory,
the uaccess optimises the read to be aligned and the write may be
unaligned (write-combining in the hardware buffers sorts this out).

Thanks.

-- 
Catalin
