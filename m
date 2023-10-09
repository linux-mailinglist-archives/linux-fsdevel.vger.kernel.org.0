Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF87BE91D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbjJISTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjJISTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:19:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0331A3;
        Mon,  9 Oct 2023 11:19:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066692ad35so44998375e9.1;
        Mon, 09 Oct 2023 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875570; x=1697480370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++ijn284zfH6P1kONLuhHN+YYK1WM6GxC/tHCJj4268=;
        b=maHEKC8tZEnXWONy6MirLMJqrfRnWCP9EoVHLrZjZbB9jq3wikk1R7jyV6mse0eeDP
         UNbHUp2k4aDw1UYo2WL4LQXhrJphFNzjyRqGgXr6AW3j4ufwxbVgX5T0VdEpDgAlPb9X
         q4hKDN3METCtCkVG8uK93HHp/mLqtdL1y/QgWpGTN5LTPxIpm4JVnmgTMexM6MLHifUb
         xBOINyJdzJ04qRysgK+f0pgyS7AKgg1CvOl8GPazA4v2UZ3XK1G/KPe7hMKMcvd4JH9v
         R+3avMt9SXG1Q+SGF0ihz9s6vtTobzkIqNuVsT7zc6zgH0VxV9Kx+Sj67Mwe21zOblqm
         CkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875570; x=1697480370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++ijn284zfH6P1kONLuhHN+YYK1WM6GxC/tHCJj4268=;
        b=gM71h41nqwCb80C/6eydTFYCL3ggho3rM6qs7pZATrmAcKS/YSxB/kgaDX7m3054bP
         fCEDF956iEZj28mYjSRaf32g5lbr2z+TGwzmkL8P2TbW2YMHLKjKSNHfxkGSjPKyTQVg
         /cbD3QFWRy4DlxIb8UqvTZTxqyLA4bmoMRoLaU+Io1u6C4GLYrZCXaaabVwWBlMhjBjz
         sEcwdKgcOR4WSXc1IvQBfLfOlYSXA4Jp70MKXWfJ0cQArFfAXBT0bWG4kAePJAVm8Piv
         ABGVnT2OsRh5L55B150OfMTPmOakWkmCkWoqp6i3mmNfxyqjLkMAFArYcxgKIYn9doOA
         St0A==
X-Gm-Message-State: AOJu0Yy+BC158xa3jlJ68qQIhvhQTxjtBLM8Fz2M9zyJFA3xVujyWbii
        okMN0iJ7MNpx5sub03Ae8v0=
X-Google-Smtp-Source: AGHT+IHSRLck2Pb7IQLpIWXEUMb/xfnErOkkK568VmsUtVQM+T+bQElHaXCDuYfJcfc70QcgkvHKHQ==
X-Received: by 2002:a7b:c40f:0:b0:403:bb04:2908 with SMTP id k15-20020a7bc40f000000b00403bb042908mr14196717wmi.23.1696875569774;
        Mon, 09 Oct 2023 11:19:29 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0032327b70ef6sm10400770wrn.70.2023.10.09.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:19:28 -0700 (PDT)
Date:   Mon, 9 Oct 2023 19:19:27 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: abstract the vma_merge()/split_vma() pattern for
 mprotect() et al.
Message-ID: <5f5274b8-f2fe-4e4a-850b-2a383778c4d3@lucifer.local>
References: <cover.1696795837.git.lstoakes@gmail.com>
 <e5b228493b81d00fe3d82bd464976348df353733.1696795837.git.lstoakes@gmail.com>
 <6feb6f37-dfb9-0fe1-1303-2744ad2758d9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6feb6f37-dfb9-0fe1-1303-2744ad2758d9@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:22:33PM +0200, Vlastimil Babka wrote:
> On 10/8/23 22:23, Lorenzo Stoakes wrote:
> > mprotect() and other functions which change VMA parameters over a range
> > each employ a pattern of:-
> >
> > 1. Attempt to merge the range with adjacent VMAs.
> > 2. If this fails, and the range spans a subset of the VMA, split it
> > accordingly.
> >
> > This is open-coded and duplicated in each case. Also in each case most of
> > the parameters passed to vma_merge() remain the same.
> >
> > Create a new static function, vma_modify(), which abstracts this operation,
> > accepting only those parameters which can be changed.
> >
> > To avoid the mess of invoking each function call with unnecessary
> > parameters, create wrapper functions for each of the modify operations,
> > parameterised only by what is required to perform the action.
>
> Nice!

Thanks :)

>
> > Note that the userfaultfd_release() case works even though it does not
> > split VMAs - since start is set to vma->vm_start and end is set to
> > vma->vm_end, the split logic does not trigger.
> >
> > In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> > - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> > instance, this invocation will remain unchanged.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/userfaultfd.c   | 53 +++++++++-----------------
> >  include/linux/mm.h | 23 ++++++++++++
> >  mm/madvise.c       | 25 ++++---------
> >  mm/mempolicy.c     | 20 ++--------
> >  mm/mlock.c         | 24 ++++--------
> >  mm/mmap.c          | 93 ++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/mprotect.c      | 27 ++++----------
> >  7 files changed, 157 insertions(+), 108 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index a7c6ef764e63..9e5232d23927 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
> >  			continue;
> >  		}
> >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > -		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
> > -				 new_flags, vma->anon_vma,
> > -				 vma->vm_file, vma->vm_pgoff,
> > -				 vma_policy(vma),
> > -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > +		prev = vma_modify_uffd(&vmi, prev, vma, vma->vm_start,
> > +				       vma->vm_end, new_flags,
> > +				       NULL_VM_UFFD_CTX);
> > +
> >  		if (prev) {
> >  			vma = prev;
> >  		} else {
> > @@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	unsigned long start, end, vma_end;
> >  	struct vma_iterator vmi;
> >  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> > -	pgoff_t pgoff;
> >
> >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> >
> > @@ -1484,26 +1482,18 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		vma_end = min(end, vma->vm_end);
> >
> >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, pgoff,
> > -				 vma_policy(vma),
> > -				 ((struct vm_userfaultfd_ctx){ ctx }),
> > -				 anon_vma_name(vma));
> > +		prev = vma_modify_uffd(&vmi, prev, vma, start, vma_end,
> > +				       new_flags,
> > +				       ((struct vm_userfaultfd_ctx){ ctx }));
> >  		if (prev) {
>
> This will hit also for IS_ERR(prev), no?
>
> >  			/* vma_merge() invalidated the mas */
> >  			vma = prev;
> >  			goto next;
> >  		}
> > -		if (vma->vm_start < start) {
> > -			ret = split_vma(&vmi, vma, start, 1);
> > -			if (ret)
> > -				break;
> > -		}
> > -		if (vma->vm_end > end) {
> > -			ret = split_vma(&vmi, vma, end, 0);
> > -			if (ret)
> > -				break;
> > +
> > +		if (IS_ERR(prev)) {
>
> So here's too late to test for it. AFAICS the other usages are like this as
> well.

Oh dear :) yes you're right, I will rework this in v2 for all cases.

>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a7b667786cde..c069813f215f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3253,6 +3253,29 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
> >  	unsigned long addr, unsigned long len, pgoff_t pgoff,
> >  	bool *need_rmap_locks);
> >  extern void exit_mmap(struct mm_struct *);
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags);
> > +struct vm_area_struct *vma_modify_flags_name(struct vma_iterator *vmi,
> > +					     struct vm_area_struct *prev,
> > +					     struct vm_area_struct *vma,
> > +					     unsigned long start,
> > +					     unsigned long end,
> > +					     unsigned long new_flags,
> > +					     struct anon_vma_name *new_name);
> > +struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
> > +					 struct vm_area_struct *prev,
> > +					 struct vm_area_struct *vma,
> > +					 unsigned long start, unsigned long end,
> > +					 struct mempolicy *new_pol);
> > +struct vm_area_struct *vma_modify_uffd(struct vma_iterator *vmi,
> > +				       struct vm_area_struct *prev,
> > +				       struct vm_area_struct *vma,
> > +				       unsigned long start, unsigned long end,
> > +				       unsigned long new_flags,
> > +				       struct vm_userfaultfd_ctx new_ctx);
>
> Could these be instead static inline wrappers, and vma_modify exported
> instead of static?

I started by trying this but sadly the vma_policy() helper needs the
mempolicy header and trying to important that into mm.h produces a horror
show of things breaking.

As discussed via IRC, will look to see whether we can sensibly move this
define into mm_types.h and then we can shift these.

>
> Maybe we could also move this to mm/internal.h? Which would mean
> fs/userfaultfd.c would have to start including it, but as it's already so
> much rooted in mm, it shouldn't be wrong?

I'm not a fan of trying to have fs/userfaultfd.c to important
mm/internal.h, seems like a bridge too far there. I think it's a bit odd
that the fs bit invokes mm bits but the mm bit doesn't, but this might be
an artifact of how uffd is implemented.

I do in principle like the idea, as we can then seriously shift what I
consider to be impl details (mergey/splitty) to being as internal as we can
make it, but I think perhaps it's something we can address later if it
makes sense to move some uffd bits around.

>
> >
> >  static inline int check_data_rlimit(unsigned long rlim,
> >  				    unsigned long new,
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index a4a20de50494..73024693d5c8 100644
>
