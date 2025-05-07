Return-Path: <linux-fsdevel+bounces-48327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D011AAD5B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623411C07089
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521B1FECCD;
	Wed,  7 May 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgXw7fYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F835182D2;
	Wed,  7 May 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598185; cv=none; b=djLO8HSpGiu2mJgR5kwqQ8vKYA4uKt64YCZrNH5ToNRKteC08orroS6GNktkziwafpcxFFAji+kSyAQ8DvTktHLSAul8F6S5ukgZiduSJnREordR/6oObajxT4R0lKfhVrjZZUt1D48YN0IcJ8PIqoXh5g5B/Q3qa/owfWqq4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598185; c=relaxed/simple;
	bh=OlQ3/kKW5MYGe5tgiUmLTmGp9Kk6UH7ZYoweCTKK+Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuN38Q+gl1MAPYB5GmpARs9e4Ah2W3HFRC4ky8kT5f9W+PaeVW4oEf7hS768Q3OeA6s3K1iVNOT/SKDzdzKs2jraEsRs24sKIL2Cwb07bM8fhQDT6Tbff7FA7uG62dAimipvkOR8FQHkjElYHry8io3hqeGjQ9F57B2RxIvip7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgXw7fYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6356C4CEE7;
	Wed,  7 May 2025 06:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746598184;
	bh=OlQ3/kKW5MYGe5tgiUmLTmGp9Kk6UH7ZYoweCTKK+Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgXw7fYYyPWrhR+g4yqjQidjaU5sPh3CwA23eu0zSWlt8rcn5T7eBv9zYWLZrjBlr
	 cwC2e7h8dHepo0xi+JAcAWQ5HLZM79zYoB7S0z/Thh/KjQAYrmMe+kjlXVciztu2gh
	 ifDoUXWxPFrPxaihin0P/GvX2VvT9IX4SsMoHAFHUvVTcgXxLzmn+fFcFhb1zMCOiS
	 R/n87FrixZw2krbGncZYUd3crnDI75QKeG4ZyxTun26AyN1TATFp9v8bwtyrvTBiZ/
	 5hbRX7woHiwfAtb5RP3D1ZHpGP+5/iBsK7vvT5Cg736neDYbqcorbCK8MhRBy8Pqmj
	 jFqlKdcwonZCg==
Date: Wed, 7 May 2025 09:09:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
Message-ID: <aBr5H3DZiJVzfd0v@kernel.org>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
 <987b620592ad6a472281039c07cc1d67e48d864f.1746116777.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <987b620592ad6a472281039c07cc1d67e48d864f.1746116777.git.lorenzo.stoakes@oracle.com>

On Thu, May 01, 2025 at 06:25:28PM +0100, Lorenzo Stoakes wrote:
> Secretmem has a simple .mmap() hook which is easily converted to the new
> .mmap_prepare() callback.
> 
> Importantly, it's a rare instance of an driver that manipulates a VMA which
> is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
> flags which may adjust mergeability, meaning the retry merge logic might
> impact whether or not the VMA is merged.
> 
> By using .mmap_prepare() there's no longer any need to retry the merge
> later as we can simply set the correct flags from the start.
> 
> This change therefore allows us to remove the retry merge logic in a
> subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/secretmem.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1b0a214ee558..f98cf3654974 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	unsigned long len = vma->vm_end - vma->vm_start;
> +	unsigned long len = desc->end - desc->start;
>  
> -	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
>  		return -EINVAL;
>  
> -	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> +	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
>  		return -EAGAIN;
>  
> -	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
> -	vma->vm_ops = &secretmem_vm_ops;
> +	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
> +	desc->vm_ops = &secretmem_vm_ops;
>  
>  	return 0;
>  }
> @@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
>  
>  static const struct file_operations secretmem_fops = {
>  	.release	= secretmem_release,
> -	.mmap		= secretmem_mmap,
> +	.mmap_prepare	= secretmem_mmap_prepare,
>  };
>  
>  static int secretmem_migrate_folio(struct address_space *mapping,
> -- 
> 2.49.0
> 

-- 
Sincerely yours,
Mike.

