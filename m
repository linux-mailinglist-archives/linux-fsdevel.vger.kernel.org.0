Return-Path: <linux-fsdevel+bounces-59974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA8B3FD62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F727ADF98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E42F6175;
	Tue,  2 Sep 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilRqU59C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7D279DA6;
	Tue,  2 Sep 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811404; cv=none; b=p4lDYsn4Htgi3E2xmV6CyITRJ7WgkZ9hzAZuWGSoNjxbpZM5OCjl7Em9jPHNXvhYrujpsIaQBR/i2UmlVouI0Ic5aAFFAGHym6MTwHtNujDrp070u9F+w3eR+p3HyboZj6ss7hddH1bncHfUFNCEwPUuVKhv+/frayTGMnH1qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811404; c=relaxed/simple;
	bh=aekmsuo4DYTq3fjI6yMhWLLWs+yu4Y3O3M4fmojBK7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUkXQMuiDsGDeF9zke63EvZZx94TGdACt4r0zRl+raKBHQK+Q5VpVXagY0Pnyod3HjHNYTHUMROQR8UKCKJusnU+AGas/K3pKQDyEGsMRKGJPpudFkS/kIpfxklQI+iqNYL/ugEL8z3Z00KSrB6EjkUBOeI2uUZKiL9EKTNcXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilRqU59C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7535CC4CEED;
	Tue,  2 Sep 2025 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756811403;
	bh=aekmsuo4DYTq3fjI6yMhWLLWs+yu4Y3O3M4fmojBK7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilRqU59CIPr3TT5edP4S6yd9uHnB2jfenfsrgEzCnRIfDAMweT4Nq007YBhdSPwm+
	 riUp0t1INxa4FHJZewJrIhsLcmNg1GqCQXf/DenhPmjVmJWPfPbeHAl/zCvaGlIJIp
	 P8QKvgdAan3kg0xeZ8EGwmm5Yrg4bnrijGk8qAqtPjr+aaFqB9qy4sajaKOA33ncyb
	 uKAsEowXQKjlyVFD2DqSQ0iQszxUHmxTJHkoRXStLQLrZaFyDAVU9p3LzE3c17x8Zk
	 36fLkbrWKT0BGuLG8YKxRSLQbqZjmsPfECh9SlRl+pZ9+iL9oz3hVY1DuW6qkwa9Ng
	 X5vY1HviFFeug==
Date: Tue, 2 Sep 2025 13:09:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <20250902-kapital-waghalsige-7e043061b0a3@brauner>
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>

On Tue, Sep 02, 2025 at 11:45:33AM +0100, Lorenzo Stoakes wrote:
> In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
> nested file systems") we introduced the ability for 'nested' drivers and

Fwiw, they're called "stacked filesystems" or "stacking filesystems" such
as overlayfs. I would recommend you use that terminology going forward
so we don't confuse each other.

You've used "nested" here and in the code doc for
compat_vma_mmap_prepare() you used "'wrapper' file systems".

Otherwise seems fine,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> file systems to correctly invoke the f_op->mmap_prepare() handler from an
> f_op->mmap() handler via a compatibility layer implemented in
> compat_vma_mmap_prepare().
> 
> This invokes vma_to_desc() to populate vm_area_desc fields according to
> those found in the (not yet fully initialised) VMA passed to f_op->mmap().
> 
> However this function implicitly assumes that the struct file which we are
> operating upon is equal to vma->vm_file. This is not a safe assumption in
> all cases.
> 
> This is not an issue currently, as so far we have only implemented
> f_op->mmap_prepare() handlers for some file systems and internal mm uses,
> and the only nested f_op->mmap() operations that can be performed upon
> these are those in backing_file_mmap() and coda_file_mmap(), both of which
> use vma->vm_file.
> 
> However, moving forward, as we convert drivers to using
> f_op->mmap_prepare(), this will become a problem.
> 
> Resolve this issue by explicitly setting desc->file to the provided file
> parameter and update callers accordingly.
> 
> We also need to adjust set_vma_from_desc() to account for this fact, and
> only update the vma->vm_file field if the f_op->mmap_prepare() caller
> reassigns it.
> 
> We may in future wish to add a new field to struct vm_area_desc to account
> for this 'nested mmap invocation' case, but for now it seems unnecessary.
> 
> While we are here, also provide a variant of compat_vma_mmap_prepare() that
> operates against a pointer to any file_operations struct and does not
> assume that the file_operations struct we are interested in is file->f_op.
> 
> This function is __compat_vma_mmap_prepare() and we invoke it from
> compat_vma_mmap_prepare() so that we share code between the two functions.
> 
> This is important, because some drivers provide hooks in a separate struct,
> for instance struct drm_device provides an fops field for this purpose.
> 
> Also update the VMA selftests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/fs.h               |  2 ++
>  mm/util.c                        | 33 +++++++++++++++++++++++---------
>  mm/vma.h                         | 14 ++++++++++----
>  tools/testing/vma/vma_internal.h | 19 +++++++++++-------
>  4 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..3e7160415066 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2279,6 +2279,8 @@ static inline bool can_mmap_file(struct file *file)
>  	return true;
>  }
>  
> +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma);
>  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
>  
>  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
> diff --git a/mm/util.c b/mm/util.c
> index bb4b47cd6709..83fe15e4483a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1133,6 +1133,29 @@ void flush_dcache_folio(struct folio *folio)
>  EXPORT_SYMBOL(flush_dcache_folio);
>  #endif
>  
> +/**
> + * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
> + * for details. This is the same operation, only with a specific file operations
> + * struct which may or may not be the same as vma->vm_file->f_op.
> + * @f_op - The file operations whose .mmap_prepare() hook is specified.
> + * @vma: The VMA to apply the .mmap_prepare() hook to.
> + * Returns: 0 on success or error.
> + */
> +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, file, &desc);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(__compat_vma_mmap_prepare);
> +
>  /**
>   * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
>   * existing VMA
> @@ -1161,15 +1184,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
>   */
>  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>  {
> -	struct vm_area_desc desc;
> -	int err;
> -
> -	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> -	if (err)
> -		return err;
> -	set_vma_from_desc(vma, &desc);
> -
> -	return 0;
> +	return __compat_vma_mmap_prepare(file->f_op, file, vma);
>  }
>  EXPORT_SYMBOL(compat_vma_mmap_prepare);
>  
> diff --git a/mm/vma.h b/mm/vma.h
> index bcdc261c5b15..9b21d47ba630 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -230,14 +230,14 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>   */
>  
>  static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc)
> +		struct file *file, struct vm_area_desc *desc)
>  {
>  	desc->mm = vma->vm_mm;
>  	desc->start = vma->vm_start;
>  	desc->end = vma->vm_end;
>  
>  	desc->pgoff = vma->vm_pgoff;
> -	desc->file = vma->vm_file;
> +	desc->file = file;
>  	desc->vm_flags = vma->vm_flags;
>  	desc->page_prot = vma->vm_page_prot;
>  
> @@ -248,7 +248,7 @@ static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
>  }
>  
>  static inline void set_vma_from_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc)
> +		struct file *orig_file, struct vm_area_desc *desc)
>  {
>  	/*
>  	 * Since we're invoking .mmap_prepare() despite having a partially
> @@ -258,7 +258,13 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
>  
>  	/* Mutable fields. Populated with initial state. */
>  	vma->vm_pgoff = desc->pgoff;
> -	if (vma->vm_file != desc->file)
> +	/*
> +	 * The desc->file may not be the same as vma->vm_file, but if the
> +	 * f_op->mmap_prepare() handler is setting this parameter to something
> +	 * different, it indicates that it wishes the VMA to have its file
> +	 * assigned to this.
> +	 */
> +	if (orig_file != desc->file && vma->vm_file != desc->file)
>  		vma_set_file(vma, desc->file);
>  	if (vma->vm_flags != desc->vm_flags)
>  		vm_flags_set(vma, desc->vm_flags);
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 6f95ec14974f..4ceb4284b6b9 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1411,25 +1411,30 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  
>  /* Declared in vma.h. */
>  static inline void set_vma_from_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc);
> -
> +		struct file *orig_file, struct vm_area_desc *desc);
>  static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc);
> +		struct file *file, struct vm_area_desc *desc);
>  
> -static int compat_vma_mmap_prepare(struct file *file,
> -		struct vm_area_struct *vma)
> +static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma)
>  {
>  	struct vm_area_desc desc;
>  	int err;
>  
> -	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
>  	if (err)
>  		return err;
> -	set_vma_from_desc(vma, &desc);
> +	set_vma_from_desc(vma, file, &desc);
>  
>  	return 0;
>  }
>  
> +static inline int compat_vma_mmap_prepare(struct file *file,
> +		struct vm_area_struct *vma)
> +{
> +	return __compat_vma_mmap_prepare(file->f_op, file, vma);
> +}
> +
>  /* Did the driver provide valid mmap hook configuration? */
>  static inline bool can_mmap_file(struct file *file)
>  {
> -- 
> 2.50.1
> 

