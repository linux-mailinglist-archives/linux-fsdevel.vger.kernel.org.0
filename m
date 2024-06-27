Return-Path: <linux-fsdevel+bounces-22673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D4B91AFC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45700283BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45250297;
	Thu, 27 Jun 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtzDj4Wh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E433C9;
	Thu, 27 Jun 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517133; cv=none; b=UzD41pCF4ljKMqDTgkGGUnt+EcMl7aq0nTXvjdPDGrzUO+jDLkazDe8WO3/MKo8XVNFDs0riYp3aigRseUGfQGalsGXX0JbKYWpB9vRvY9WQ/wxj9ucLl/vOCliSvr7q/h7pv01Wyi0F70ZPE9ZjvLPE7MSSE+P1c7N/TRr6/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517133; c=relaxed/simple;
	bh=1YZxpg5HfpEnTaGgTc/WkzPogkD6J5GgWqE784yWZG8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+wDnhjPgyO4MC2TP1s9tyyCz/PGMse0+k8DM7e8Z+KdUMV8l81gzI6u+9EveQwVAnNzXjBInJRcCyFDMb309SN0l0Y2hKbgeCffKC49SDRyEm2KbCEIT4oRZDlvWhWcUT07WB5+fCNzRverFmsvXOsRXLOcEOjRl8R5V0v9ZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtzDj4Wh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so36872755e9.0;
        Thu, 27 Jun 2024 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719517129; x=1720121929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NLJfqsFcOHvKNXK7I50zdH/4C4TLlyZL7yB7AkwTj0=;
        b=RtzDj4Whv3a3oVtiPD6IDP12+CFxbemGiteUug0us9wh7CVYtEY7RnY9RXL8yHCZhi
         nzNfGNKQombvDE+xz7YdRy67zM/Nk3qvCCY/njzKXOFbIZk5ZCXfZeHezy+XrWYSkV8p
         X0e+8niEUJ6/gY+syAnPGLx+QOuyofSOBPs5ZCiHOlVwAIFqxoaOiXbY7KZdZSCAASZs
         e0460JeQmRCIZ3uB2ERVLMYEt3mFZ8rZiCaWWVNNgIOW6OGEiHqQyEggQcktx3Ic4p7y
         HleJfe0qfHxUq2Mm05TQo0VSF4sLF7dp+mEyjmb4JeWHUuQUn1PDkFLHKl2gGsJHZGrI
         98LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719517129; x=1720121929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NLJfqsFcOHvKNXK7I50zdH/4C4TLlyZL7yB7AkwTj0=;
        b=EPjoL+ht9jEybQTFRIs6uzT7Rlydy0z4Hjxzknmkb/144mZnhmpG0jTlpTrXP8CM3z
         bQa5kNxGeLhAH5wZ44409zmFWAmDwlDm8UKIVIqSun/ZxJ/M/KyVbKdoSISm65b7xQzF
         DEyoBcKPa0lXRbNbrNf6pGoDLKhMdtz3Npajg7AQaEohqbMLx2TKmoOAKgCK59wvx/tg
         XJM+8PfakbCF4K1pHtkRhriiEY04zPVYmAYkt1g6yj8KxTX0IcKosRZ/RT5czWYjIblX
         yf/1U24iRYambf9stlhpLPBqlsfiuJWamMK/yqVZFM87E+xZjKJV8f8IpWQJIoPcHMl2
         hmeA==
X-Forwarded-Encrypted: i=1; AJvYcCUmvEwFYDUxtN71yw9e7ITX+VRxevFaUqMkmHQXjLcMxA9bpwqIFiIA/b8zxeWMLArqbMcGHISXJLWjm1C1PVkErkej/Emh+SCK+7BJkjHsZAZwwtHXvLHVQktZS38NHA84IMS3fenJP/5wMg==
X-Gm-Message-State: AOJu0YwGbTzran4zd6sBE48QJzlPW+vn8YRaI+FgxAgcb+dUzQeSMz2x
	usaFiQduewrEgFO+XQVGdVJBHEPrW7WJHWXXSQGyOleSWVqsnriY
X-Google-Smtp-Source: AGHT+IHnGQ/X4kqKjeCk/PpAvVamiIfefvKEnfvZX1JBFIbnEJRvWCpE1eC8cjFYXMlxXgHpMbkUVg==
X-Received: by 2002:a5d:6a09:0:b0:35f:26e7:f978 with SMTP id ffacd0b85a97d-366e7a3752bmr9877768f8f.37.1719517129033;
        Thu, 27 Jun 2024 12:38:49 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1412sm149864f8f.53.2024.06.27.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:38:47 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:38:47 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 3/7] mm: unexport vma_expand() / vma_shrink()
Message-ID: <057aa98a-bab6-4d0c-838b-6ab8acb5bb7f@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <8c548bb3d0286bfaef2cd5e67d7bf698967a52a1.1719481836.git.lstoakes@gmail.com>
 <gj5ugtuztq2h5uxkbeizl2jwl2r5cj7sev2qhokzjiqkhwbr2t@67rwpanaw5vk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gj5ugtuztq2h5uxkbeizl2jwl2r5cj7sev2qhokzjiqkhwbr2t@67rwpanaw5vk>

On Thu, Jun 27, 2024 at 01:45:34PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > The vma_expand() and vma_shrink() functions are core VMA manipulaion
> > functions which ultimately invoke VMA split/merge. In order to make these
> > testable, it is convenient to place all such core functions in a header
> > internal to mm/.
> >
>
> The sole user doesn't cause a split or merge, it relocates a vma by
> 'sliding' the window of the vma by expand/shrink with the moving of page
> tables in the middle of the slide.
>
> It slides to relocate the vma start/end and keep the vma pointer
> constant.

Yeah sorry, I actually don't know why I said this (I did say ultimately
again as well!), as you say and I was in fact aware of, this doesn't invoke
split/merge. I will put this down to me being tired when I wrote this :)

Will fix.

>
> > In addition, it is safer to abstract direct access to such functionality so
> > we can better control how other parts of the kernel use them, which
> > provides us the freedom to change how this functionality behaves as needed
> > without having to worry about how this functionality is used elsewhere.
> >
> > In order to service both these requirements, we provide abstractions for
> > the sole external user of these functions, shift_arg_pages() in fs/exec.c.
> >
> > We provide vma_expand_bottom() and vma_shrink_top() functions which better
> > match the semantics of what shift_arg_pages() is trying to accomplish by
> > explicitly wrapping the safe expansion of the bottom of a VMA and the
> > shrinking of the top of a VMA.
> >
> > As a result, we place the vma_shrink() and vma_expand() functions into
> > mm/internal.h to unexport them from use by any other part of the kernel.
>
> There is no point to have vma_shrink() have a wrapper since this is the
> only place it's ever used.  So we're wrapping a function that's only
> called once.

Yeah that was a sketchy part of this change, I feel the vma_expand() case
is a lot more defensible, the vma_shrink() one, well I expected I might get
some feedback on anyway :)

This was obviously to try to find a way to abstract these away from fs/ in
some vaguely sensible fashion while retaining functionality.

>
> I'd rather a vma_relocate() do everything in this function than wrap
> them.  The only other think it does is the page table moving and freeing
> - which we have to do in the vma code.  We;d expose something we want no
> one to use - but we already have two of those here..

Right, I think I was trying to avoid _the whole thing_ as it's so specific
and not so nice to make available, but at the same time, it is perhaps the
only way forward reasonably to avoid the vma_shrink() micro-wrapper.

So yeah, will rework with a vma_relocate() or similar. As you say, we can't
really get away from exposing something nasty here.

>
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/exec.c          | 26 +++++--------------
> >  include/linux/mm.h |  9 +++----
> >  mm/internal.h      |  6 +++++
> >  mm/mmap.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 82 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 40073142288f..1cb3bf323e0f 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -700,25 +700,14 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
> >  	unsigned long length = old_end - old_start;
> >  	unsigned long new_start = old_start - shift;
> >  	unsigned long new_end = old_end - shift;
> > -	VMA_ITERATOR(vmi, mm, new_start);
> > +	VMA_ITERATOR(vmi, mm, 0);
> >  	struct vm_area_struct *next;
> >  	struct mmu_gather tlb;
> > +	int ret;
> >
> > -	BUG_ON(new_start > new_end);
> > -
> > -	/*
> > -	 * ensure there are no vmas between where we want to go
> > -	 * and where we are
> > -	 */
> > -	if (vma != vma_next(&vmi))
> > -		return -EFAULT;
> > -
> > -	vma_iter_prev_range(&vmi);
> > -	/*
> > -	 * cover the whole range: [new_start, old_end)
> > -	 */
> > -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > -		return -ENOMEM;
> > +	ret = vma_expand_bottom(&vmi, vma, shift, &next);
> > +	if (ret)
> > +		return ret;
> >
> >  	/*
> >  	 * move the page tables downwards, on failure we rely on
> > @@ -730,7 +719,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
> >
> >  	lru_add_drain();
> >  	tlb_gather_mmu(&tlb, mm);
> > -	next = vma_next(&vmi);
> > +
> >  	if (new_end > old_start) {
> >  		/*
> >  		 * when the old and new regions overlap clear from new_end.
> > @@ -749,9 +738,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
> >  	}
> >  	tlb_finish_mmu(&tlb);
> >
> > -	vma_prev(&vmi);
> >  	/* Shrink the vma to just the new range */
> > -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > +	return vma_shrink_top(&vmi, vma, shift);
> >  }
> >
> >  /*
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4d2b5538925b..e3220439cf75 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3273,11 +3273,10 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
> >
> >  /* mmap.c */
> >  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> > -extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		      unsigned long start, unsigned long end, pgoff_t pgoff,
> > -		      struct vm_area_struct *next);
> > -extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		       unsigned long start, unsigned long end, pgoff_t pgoff);
> > +extern int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +			     unsigned long shift, struct vm_area_struct **next);
> > +extern int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +			  unsigned long shift);
> >  extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
> >  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> >  extern void unlink_file_vma(struct vm_area_struct *);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c8177200c943..f7779727bb78 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
> >  			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> >  }
> >
> > +int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +	       unsigned long start, unsigned long end, pgoff_t pgoff,
> > +		      struct vm_area_struct *next);
> > +int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +	       unsigned long start, unsigned long end, pgoff_t pgoff);
> > +
> >  enum {
> >  	/* mark page accessed */
> >  	FOLL_TOUCH = 1 << 16,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e42d89f98071..574e69a04ebe 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3940,6 +3940,71 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >  	mutex_unlock(&mm_all_locks_mutex);
> >  }
> >
> > +/*
> > + * vma_expand_bottom() - Expands the bottom of a VMA downwards. An error will
> > + *                       arise if there is another VMA in the expanded range, or
> > + *                       if the expansion fails. This function leaves the VMA
> > + *                       iterator, vmi, positioned at the newly expanded VMA.
> > + * @vmi: The VMA iterator.
> > + * @vma: The VMA to modify.
> > + * @shift: The number of bytes by which to expand the bottom of the VMA.
> > + * @next: Output parameter, pointing at the VMA immediately succeeding the newly
> > + *        expanded VMA.
> > + *
> > + * Returns: 0 on success, an error code otherwise.
> > + */
> > +int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +		      unsigned long shift, struct vm_area_struct **next)
> > +{
> > +	unsigned long old_start = vma->vm_start;
> > +	unsigned long old_end = vma->vm_end;
> > +	unsigned long new_start = old_start - shift;
> > +	unsigned long new_end = old_end - shift;
> > +
> > +	BUG_ON(new_start > new_end);
> > +
> > +	vma_iter_set(vmi, new_start);
> > +
> > +	/*
> > +	 * ensure there are no vmas between where we want to go
> > +	 * and where we are
> > +	 */
> > +	if (vma != vma_next(vmi))
> > +		return -EFAULT;
> > +
> > +	vma_iter_prev_range(vmi);
> > +
> > +	/*
> > +	 * cover the whole range: [new_start, old_end)
> > +	 */
> > +	if (vma_expand(vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > +		return -ENOMEM;
> > +
> > +	*next = vma_next(vmi);
> > +	vma_prev(vmi);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * vma_shrink_top() - Reduce an existing VMA's memory area by shift bytes from
> > + *                    the top of the VMA.
> > + * @vmi: The VMA iterator, must be positioned at the VMA.
> > + * @vma: The VMA to modify.
> > + * @shift: The number of bytes by which to shrink the VMA.
> > + *
> > + * Returns: 0 on success, an error code otherwise.
> > + */
> > +int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +		   unsigned long shift)
> > +{
> > +	if (shift >= vma->vm_end - vma->vm_start)
> > +		return -EINVAL;
> > +
> > +	return vma_shrink(vmi, vma, vma->vm_start, vma->vm_end - shift,
> > +			  vma->vm_pgoff);
> > +}
> > +
> >  /*
> >   * initialise the percpu counter for VM
> >   */
> > --
> > 2.45.1
> >

