Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD94461B2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 16:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbhK2PmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 10:42:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59916 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbhK2PkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:40:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50954CE131F;
        Mon, 29 Nov 2021 15:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA2C53FCE;
        Mon, 29 Nov 2021 15:36:44 +0000 (UTC)
Date:   Mon, 29 Nov 2021 15:36:41 +0000
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
Message-ID: <YaTziROgnFwB6Ddj@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com>
 <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com>
 <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:33:42PM +0100, Andreas Gruenbacher wrote:
> On Mon, Nov 29, 2021 at 1:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Sat, Nov 27, 2021 at 07:05:39PM +0100, Andreas Gruenbacher wrote:
> > > We also still have fault_in_safe_writeable which is more difficult to
> > > fix, and fault_in_readable which we don't want to leave behind broken,
> > > either.
> >
> > fault_in_safe_writeable() can be done by using get_user() instead of
> > put_user() for arm64 MTE and probably SPARC ADI (an alternative is to
> > read the in-memory tags and compare them with the pointer).
> 
> So we'd keep the existing fault_in_safe_writeable() logic for the
> actual fault-in and use get_user() to check for sub-page faults? If
> so, then that should probably also be hidden in arch code.

That's what this series does when it probes the whole range in
fault_in_writeable(). The main reason was that it's more efficient to do
a read than a write on a large range (the latter dirtying the cache
lines).

> > For CHERI, that's different again since the fault_in_safe_writeable capability
> > encodes the read/write permissions independently.
> >
> > However, do we actually want to change the fault_in_safe_writeable() and
> > fault_in_readable() functions at this stage? I could not get any of them
> > to live-lock, though I only tried btrfs, ext4 and gfs2. As per the
> > earlier discussion, normal files accesses are guaranteed to make
> > progress. The only problematic one was O_DIRECT which seems to be
> > alright for the above filesystems (the fs either bails out after several
> > attempts or uses GUP to read which skips the uaccess altogether).
> 
> Only gfs2 uses fault_in_safe_writeable(). For buffered reads, progress
> is guaranteed because failures are at a byte granularity.
> 
> O_DIRECT reads and writes happen in device block size granularity, but
> the pages are grabbed with get_user_pages() before the copying
> happens. So by the time the copying happens, the pages are guaranteed
> to be resident, and we don't need to loop around fault_in_*().

For file reads, I couldn't triggered any mismatched tag faults with gfs2
and O_DIRECT, so it matches your description above. For file writes it
does trigger such faults, so I suspect it doesn't always use
get_user_pages() for writes. No live-lock though with the vanilla
kernel. My test uses a page with some mismatched tags in the middle.

ext4: no tag faults with O_DIRECT read/write irrespective of whether the
user buffer is page aligned or not.

btrfs: O_DIRECT file writes - no faults on page-aligned buffers, faults
on unaligned; file reads - tag faults on both aligned/unaligned buffers.
No live-lock.

So, some tag faults still happen even with O_DIRECT|O_SYNC but the
filesystems too care of continuous faulting.

> You've mentioned before that copying to/from struct page bypasses
> sub-page fault checking. If that is the case, then the checking
> probably needs to happen in iomap_dio_bio_iter and dio_refill_pages
> instead.

It's too expensive and not really worth it. With a buffered access, the
uaccess takes care of checking at the time of load/store (the hardware
does this for us). With a GUP, the access is done via the kernel mapping
with a match-all tag to avoid faults (kernel panic). We set the ABI
expectation some time ago that kernel accesses to user memory may not
always be tag-checked if the access is done via a GUP'ed page.

> > Happy to address them if there is a real concern, I just couldn't trigger it.
> 
> Hopefully it should now be clear why you couldn't. One way of
> reproducing with fault_in_safe_writeable() would be to use that in
> btrfs instead of fault_in_writeable(), of course.

Yes, that would trigger it again. I guess if we want to make this API
safer in general, we can add the checks to the other functions. Only
probing a few bytes at the start shouldn't cause a performance issue.

Thanks.

-- 
Catalin
