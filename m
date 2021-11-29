Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC94616B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbhK2Nk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377936AbhK2Ni7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:38:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DE2C09B123;
        Mon, 29 Nov 2021 04:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E31B9CE113E;
        Mon, 29 Nov 2021 12:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F21EC53FAD;
        Mon, 29 Nov 2021 12:16:19 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:16:16 +0000
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
Message-ID: <YaTEkAahkCwuQdPN@arm.com>
References: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
 <YaAROdPCqNzSKCjh@arm.com>
 <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com>
 <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 07:05:39PM +0100, Andreas Gruenbacher wrote:
> On Sat, Nov 27, 2021 at 4:21 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > That's similar, somehow, to the arch-specific probing in one of my
> > patches: [1]. We could do the above if we can guarantee that the maximum
> > error margin in copy_to_user() is smaller than SUBPAGE_FAULT_SIZE. For
> > arm64 copy_to_user(), it is fine, but for copy_from_user(), if we ever
> > need to handle fault_in_readable(), it isn't (on arm64 up to 64 bytes
> > even if aligned: reads of large blocks are done in 4 * 16 loads, and if
> > one of them fails e.g. because of the 16-byte sub-page fault, no write
> > is done, hence such larger than 16 delta).
> >
> > If you want something in the generic fault_in_writeable(), we probably
> > need a loop over UACCESS_MAX_WRITE_ERROR in SUBPAGE_FAULT_SIZE
> > increments. But I thought I'd rather keep this in the arch-specific code.
> 
> I see, that's even crazier than I'd thought. The looping / probing is
> still pretty generic, so I'd still consider putting it in the generic
> code.

In the arm64 probe_subpage_user_writeable(), the loop is skipped if
!system_supports_mte() (static label). It doesn't make much difference
for search_ioctl() in terms of performance but I'd like the arch code to
dynamically decide when to probe. An arch_has_subpage_faults() static
inline function would solve this.

However, the above assumes that the only way of probing is by doing a
get_user/put_user(). A non-destructive probe with MTE would be to read
the actual tags in memory and compare them with the top byte of the
pointer.

There's the CHERI architecture as well. Although very early days for
arm64, we do have an incipient port (https://www.morello-project.org/).
The void __user * pointers are propagated inside the kernel as 128-bit
capabilities. A fault_in() would check whether the address (bottom
64-bit) is within the range and permissions specified in the upper
64-bit of the capability. There is no notion of sub-page fault
granularity here and no need to do a put_user() as the check is just
done on the pointer/capability.

Given the above, my preference is to keep the probing arch-specific.

> We also still have fault_in_safe_writeable which is more difficult to
> fix, and fault_in_readable which we don't want to leave behind broken,
> either.

fault_in_safe_writeable() can be done by using get_user() instead of
put_user() for arm64 MTE and probably SPARC ADI (an alternative is to
read the in-memory tags and compare them with the pointer). For CHERI,
that's different again since the capability encodes the read/write
permissions independently.

However, do we actually want to change the fault_in_safe_writeable() and
fault_in_readable() functions at this stage? I could not get any of them
to live-lock, though I only tried btrfs, ext4 and gfs2. As per the
earlier discussion, normal files accesses are guaranteed to make
progress. The only problematic one was O_DIRECT which seems to be
alright for the above filesystems (the fs either bails out after several
attempts or uses GUP to read which skips the uaccess altogether).

Happy to address them if there is a real concern, I just couldn't
trigger it.

> > Of course, the above fault_in_writeable() still needs the btrfs
> > search_ioctl() counterpart to change the probing on the actual fault
> > address or offset.
> 
> Yes, but that change is relatively simple and it eliminates the need
> for probing the entire buffer, so it's a good thing. Maybe you want to
> add this though:
> 
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2202,3 +2202,3 @@ static noinline int search_ioctl(struct inode *inode,
>         unsigned long sk_offset = 0;
> -       char __user *fault_in_addr;
> +       char __user *fault_in_addr, *end;
> 
> @@ -2230,6 +2230,6 @@ static noinline int search_ioctl(struct inode *inode,
>         fault_in_addr = ubuf;
> +       end = ubuf + *buf_size;
>         while (1) {
>                 ret = -EFAULT;
> -               if (fault_in_writeable(fault_in_addr,
> -                                      *buf_size - (fault_in_addr - ubuf)))
> +               if (fault_in_writeable(fault_in_addr, end - fault_in_addr))
>                         break;

Thanks, I'll add it.

-- 
Catalin
