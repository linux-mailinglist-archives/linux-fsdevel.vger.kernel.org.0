Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9445FFD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355357AbhK0P01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhK0PY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:24:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BEC06173E;
        Sat, 27 Nov 2021 07:21:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E0E660AD8;
        Sat, 27 Nov 2021 15:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D1AC53FBF;
        Sat, 27 Nov 2021 15:21:09 +0000 (UTC)
Date:   Sat, 27 Nov 2021 15:21:06 +0000
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
Message-ID: <YaJM4n31gDeVzUGA@arm.com>
References: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
 <YaAROdPCqNzSKCjh@arm.com>
 <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211127123958.588350-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 01:39:58PM +0100, Andreas Gruenbacher wrote:
> On Sat, Nov 27, 2021 at 4:52 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On Sat, Nov 27, 2021 at 12:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > If we know that the arch copy_to_user() has an error of say maximum 16
> > > bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
> > > to probe the first 16 bytes rather than 1.
> >
> > That isn't going to help one bit: [raw_]copy_to_user() is allowed to
> > copy as little or as much as it wants as long as it follows the rules
> > documented in include/linux/uaccess.h:
> >
> > [] If copying succeeds, the return value must be 0.  If some data cannot be
> > [] fetched, it is permitted to copy less than had been fetched; the only
> > [] hard requirement is that not storing anything at all (i.e. returning size)
> > [] should happen only when nothing could be copied.  In other words, you don't
> > [] have to squeeze as much as possible - it is allowed, but not necessary.
> >
> > When fault_in_writeable() tells us that an address range is accessible
> > in principle, that doesn't mean that copy_to_user() will allow us to
> > access it in arbitrary chunks. It's also not the case that
> > fault_in_writeable(addr, size) is always followed by
> > copy_to_user(addr, ..., size) for the exact same address range, not
> > even in this case.
> >
> > These alignment restrictions have nothing to do with page or sub-page faults.
> >
> > I'm also fairly sure that passing in an unaligned buffer will send
> > search_ioctl into an endless loop on architectures with copy_to_user()
> > alignment restrictions; there don't seem to be any buffer alignment
> > checks.
> 
> Let me retract that ...
> 
> The description in include/linux/uaccess.h leaves out permissible
> reasons for fetching/storing less than requested. Thinking about it, if
> the address range passed to one of the copy functions includes an
> address that faults, it kind of makes sense to allow the copy function
> to stop short instead of copying every last byte right up to the address
> that fails.
> 
> If that's the only reason, then it would be great to have that included
> in the description.  And then we can indeed deal with the alignment
> effects in fault_in_writeable().

Ah, I started replying last night, sent it today without seeing your
follow-up.

> > > I attempted the above here and works ok:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix
> > >
> > > but too late to post it this evening, I'll do it in the next day or so
> > > as an alternative to this series.
> 
> I've taken a quick look.  Under the assumption that alignment effects
> are tied to page / sub-page faults, I think we can really solve this
> generically as Willy has proposed.

I think Willy's proposal stopped at the page boundary, it should go
beyond.

> Maybe as shown below; no need for arch-specific code.
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2c51e9748a6a..a9b3d916b625 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1658,6 +1658,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>  }
>  #endif /* !CONFIG_MMU */
>  
> +#define SUBPAGE_FAULT_SIZE 16
> +
>  /**
>   * fault_in_writeable - fault in userspace address range for writing
>   * @uaddr: start of address range
> @@ -1673,8 +1675,19 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>  	if (unlikely(size == 0))
>  		return 0;
>  	if (!PAGE_ALIGNED(uaddr)) {
> +		if (SUBPAGE_FAULT_SIZE &&
> +		    !IS_ALIGNED((unsigned long)uaddr, SUBPAGE_FAULT_SIZE)) {
> +			end = PTR_ALIGN(uaddr, SUBPAGE_FAULT_SIZE);
> +			if (end - uaddr < size) {
> +				if (unlikely(__put_user(0, uaddr) != 0))
> +					return size;
> +				uaddr = end;
> +				if (unlikely(!end))
> +					goto out;
> +			}
> +		}
>  		if (unlikely(__put_user(0, uaddr) != 0))
> -			return size;
> +			goto out;
>  		uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
>  	}
>  	end = (char __user *)PAGE_ALIGN((unsigned long)start + size);

That's similar, somehow, to the arch-specific probing in one of my
patches: [1]. We could do the above if we can guarantee that the maximum
error margin in copy_to_user() is smaller than SUBPAGE_FAULT_SIZE. For
arm64 copy_to_user(), it is fine, but for copy_from_user(), if we ever
need to handle fault_in_readable(), it isn't (on arm64 up to 64 bytes
even if aligned: reads of large blocks are done in 4 * 16 loads, and if
one of them fails e.g. because of the 16-byte sub-page fault, no write
is done, hence such larger than 16 delta).

If you want something in the generic fault_in_writeable(), we probably
need a loop over UACCESS_MAX_WRITE_ERROR in SUBPAGE_FAULT_SIZE
increments. But I thought I'd rather keep this in the arch-specific
code.

Of course, the above fault_in_writeable() still needs the btrfs
search_ioctl() counterpart to change the probing on the actual fault
address or offset.

In the general case (uaccess error margin larger), I'm not entirely
convinced we can skip the check if PAGE_ALIGNED(uaddr). I should
probably get this logic through CBMC (or TLA+), I can't think it
through.

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=devel/btrfs-live-lock-fix&id=af7e96d9e9537d9f9cc014f388b7b2bb4a5bc343

-- 
Catalin
