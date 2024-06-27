Return-Path: <linux-fsdevel+bounces-22672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195D091AFBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886DA1F23348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5345C16;
	Thu, 27 Jun 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyfXG026"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C28C8F3;
	Thu, 27 Jun 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516799; cv=none; b=Y/RSxXt7OoqeDqnC1VCLGKqLLuNMXDQZi5xfHKTnAOe5Piq2KKvxH3kdsZ/r6xD9dgkZrjVwcxoVNG9TyJhwSeP2u28j5+BSPmRvqbKHNfaJfbGua+IAaUACqp3CtpVJZgK5NNbCuH6+JIxnr2Y/gSnCvbGQQx41NwK9l0R+G9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516799; c=relaxed/simple;
	bh=pA7dcb/Rc639uHoTvIABLBEo3Y9RbnpDtFg35agyvzs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En2c+BJfDvntLUObBsJSC/BY2vrH7dMZpstV5fopRk1G+zEsKkMGhCUe7Z8TTF5HDoLESza1srv/zfAOS5bDaW+qubP8a0MsPi26z6D+AADuqfza6RPZJnAS4OhJA00gcms5AyPXrfoUZBKsbJ5GyiSWb5bxQ2yzU/BC0EjP/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyfXG026; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-363826fbcdeso6012715f8f.0;
        Thu, 27 Jun 2024 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719516796; x=1720121596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6dv0h7ZpGrbtyUhSgUMY22uFhyPWIrX8D0BLFs9pOd8=;
        b=gyfXG026PpoDY7zG6ogZML0Md3wZucuKH23/VVDSEQ1xERHtu7hb5HOFz9xxJyDkXN
         HxeCybAxGaw87yiQJb3KPZBj1IbI4JhwM667vjApyuO2RfD/NwqYnI7nlleZVz9yMIbE
         wGJCQWjdQOZvfWrv9OJEEpP96D/hmaB3g6G0NWfthv7JMlyisvm+RsItEz9d9X1Sw8fj
         FPUw0IXLm4gRW5H5sXgf0U9qTRgcWcceLB/xyCqEyKWpZFNh5ARYXwswCvi+ZrTxgYkr
         jIBbWtvILIkhP54PTIVYQWi0fh6tBbBqJCLOwj+7QhScdoxsw3SLf8Chla+YX2/qKbrq
         uBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516796; x=1720121596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dv0h7ZpGrbtyUhSgUMY22uFhyPWIrX8D0BLFs9pOd8=;
        b=O5iBYMhtKpu3iahqlTwEyM86DqINvcjAKdmYK9wktoSKHBwmjs1QlKBorFCsi2SCqm
         QBzNY7qWeltfUF6LlBcfe5YRC0vvBSb1elVEXsDzcNzSZy0p1S1gOmcaEUTw7GvJH1xb
         J6ZflFqUphLut/fNmoX+rZ+eh1MoPl5Gci7Yq7McvS61w0CjWJ4dR3DnQvR7kbanKqVf
         WAPsSoNHHSxfNGFvJLBvVxAv2+ubtoA9J0IpqaBXA6jrGJfA+uxRa+nqhnG0OT2oBe0x
         9XXvGHYgNbn32DuhHiJIrRRU29hDLAbmMLSQWFhsGHVv+jSoltITtiaxmR8g9JjVB/tU
         qr1A==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZP3nE36/KxcnzOOuQzIGzFMyyn585tMowp3fDz3JdKU2FdWghqroQndrFB1zZ8PCXUQ1EdgM2xvotg42syVnVhuucM7+1abKFlRNADcS8dV8L86EwOVDHopMW+2Pz6jsFn6wJ2IHRQZTOw==
X-Gm-Message-State: AOJu0YwDmCXFlcmlvPqjuo3VftmrEAZr9z5Hy1FEh9A7KoSzy5rCvFiK
	/3PZKgWEIY6Uf3dgQcONYdnsTqU3Bsdl5fnAz79lvpM0bzxHS4/V
X-Google-Smtp-Source: AGHT+IFyIxVWGbpEBoxmoaMpNj/vL4JI2RqcOmsmmMY4OaTB9GpE5AgHMSrm6flrakLx37QA/tv+fQ==
X-Received: by 2002:a5d:6485:0:b0:366:e9ec:ca64 with SMTP id ffacd0b85a97d-366e9eccabamr12279659f8f.54.1719516796035;
        Thu, 27 Jun 2024 12:33:16 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba0bsm131000f8f.69.2024.06.27.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:33:15 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:33:14 +0100
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
Subject: Re: [RFC PATCH 2/7] mm: move vma_modify() and helpers to internal
 header
Message-ID: <2efff6f0-91b8-45e5-bd3b-9cb304579140@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <2fb403aba2b847bfbc0bcf7e61cb830813b0853a.1719481836.git.lstoakes@gmail.com>
 <y6c7ojrdegke6klyw4dxsduza65n6lxy2eermku4rwx2cwbdil@muvorxujta6e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y6c7ojrdegke6klyw4dxsduza65n6lxy2eermku4rwx2cwbdil@muvorxujta6e>

On Thu, Jun 27, 2024 at 01:25:55PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > These are core VMA manipulation functions which ultimately invoke VMA
> > splitting and merging and should not be directly accessed from outside of
> > mm/ functionality.
> >
> > We ultimately intend to ultimately move these to a VMA-specific internal
> > header.
>
> Too (two?) ultimate of a statement.

Ultimately this was the ultimate example of me ultimately rewriting a
sentence to say ultimate while forgetting that I also said ultimate
ultimately later on in the same sentence, leading to a penultimate
ultimate.

You offer me an ultimatum on fixing this in order to receive positive
review, so ultimately I shall relent and do so on the next respin.

>
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  include/linux/mm.h | 60 ---------------------------------------------
> >  mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+), 60 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5f1075d19600..4d2b5538925b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
> >  	unsigned long addr, unsigned long len, pgoff_t pgoff,
> >  	bool *need_rmap_locks);
> >  extern void exit_mmap(struct mm_struct *);
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name);
> > -
> > -/* We are about to modify the VMA's flags. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags(struct vma_iterator *vmi,
> > -		  struct vm_area_struct *prev,
> > -		  struct vm_area_struct *vma,
> > -		  unsigned long start, unsigned long end,
> > -		  unsigned long new_flags)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> > -			  anon_vma_name(vma));
> > -}
> > -
> > -/* We are about to modify the VMA's flags and/or anon_name. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags_name(struct vma_iterator *vmi,
> > -		       struct vm_area_struct *prev,
> > -		       struct vm_area_struct *vma,
> > -		       unsigned long start,
> > -		       unsigned long end,
> > -		       unsigned long new_flags,
> > -		       struct anon_vma_name *new_name)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> > -}
> > -
> > -/* We are about to modify the VMA's memory policy. */
> > -static inline struct vm_area_struct
> > -*vma_modify_policy(struct vma_iterator *vmi,
> > -		   struct vm_area_struct *prev,
> > -		   struct vm_area_struct *vma,
> > -		   unsigned long start, unsigned long end,
> > -		   struct mempolicy *new_pol)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> > -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > -}
> > -
> > -/* We are about to modify the VMA's flags and/or uffd context. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > -		       struct vm_area_struct *prev,
> > -		       struct vm_area_struct *vma,
> > -		       unsigned long start, unsigned long end,
> > -		       unsigned long new_flags,
> > -		       struct vm_userfaultfd_ctx new_ctx)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> > -}
> >
> >  static inline int check_data_rlimit(unsigned long rlim,
> >  				    unsigned long new,
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 2ea9a88dcb95..c8177200c943 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					struct vm_area_struct *vma,
> >  					unsigned long delta);
> >
> > +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > +				  struct vm_area_struct *prev,
> > +				  struct vm_area_struct *vma,
> > +				  unsigned long start, unsigned long end,
> > +				  unsigned long vm_flags,
> > +				  struct mempolicy *policy,
> > +				  struct vm_userfaultfd_ctx uffd_ctx,
> > +				  struct anon_vma_name *anon_name);
> > +
> > +/* We are about to modify the VMA's flags. */
> > +static inline struct vm_area_struct
> > +*vma_modify_flags(struct vma_iterator *vmi,
> > +		  struct vm_area_struct *prev,
> > +		  struct vm_area_struct *vma,
> > +		  unsigned long start, unsigned long end,
> > +		  unsigned long new_flags)
> > +{
> > +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > +			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> > +			  anon_vma_name(vma));
> > +}
> > +
> > +/* We are about to modify the VMA's flags and/or anon_name. */
> > +static inline struct vm_area_struct
> > +*vma_modify_flags_name(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct anon_vma_name *new_name)
> > +{
> > +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > +			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> > +}
> > +
> > +/* We are about to modify the VMA's memory policy. */
> > +static inline struct vm_area_struct
> > +*vma_modify_policy(struct vma_iterator *vmi,
> > +		   struct vm_area_struct *prev,
> > +		   struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   struct mempolicy *new_pol)
> > +{
> > +	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> > +			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +}
> > +
> > +/* We are about to modify the VMA's flags and/or uffd context. */
> > +static inline struct vm_area_struct
> > +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct vm_userfaultfd_ctx new_ctx)
> > +{
> > +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > +			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> > +}
> > +
> >  enum {
> >  	/* mark page accessed */
> >  	FOLL_TOUCH = 1 << 16,
> > --
> > 2.45.1
> >

