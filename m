Return-Path: <linux-fsdevel+bounces-49469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F0ABCDB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07F28A0376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 03:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7009625742C;
	Tue, 20 May 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fttrDcfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAA22083
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710892; cv=none; b=FlzBkCfjJA1l4u8y2XdlUhBaYCoAomNey/RSupf4Ib2oKQxryzXr/55Muzzdn/BIpnumHKKUmFB+mKRX4WwVU+Cy4hKYlrKpmooxq8DjWe6d/BbV46YYkWR+a9jS3dAVWrdqmvYWjVG9Wg75xEqWPozfvcGOCeH29Xzos3GpYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710892; c=relaxed/simple;
	bh=8yP9votE2n3qsL2Yy1fAJC70/ErMwI6dGO6WKJ/47bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uurIObcAfwWtlTjYAc1HB8mAC2gQEp+4PyqWMw6hDr3n3Hmv+ek09D0g9cpsdGniKDoxQaxT18adpE6sQcCTFSXLcnwpK++Hk8ivk4qAFXQ8owWUXzvKnxbZ6Vf70W+f2uAoMJ4hEI7AMoFrYazi2fxifbApZIJSlvNi0epzefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fttrDcfc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5feb16f-d524-42ce-bdf0-f09a9ca4ccda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747710886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xQ8ssiJ7fvRSUIxZ9ztIIzARxp5AAUjQx0+oVmK16E=;
	b=fttrDcfcbFqiQEn+PH7deu1o/UtLRdg7hcIDyvJEB0tyyu3+xE7Dbv4vVTo34J7ljeUrDn
	fAJJpXqXmtuZnw0LFWgll1u+xNUx79zwM/46FbJZppj4BOluNomiFzhRWTEGpsEDNd56jv
	krRebwWNTvp7Dzp6ayqBq9zzsXWE/eo=
Date: Tue, 20 May 2025 11:14:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm: ksm: have KSM VMA checks not require a VMA
 pointer
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <daf12021354ce7302ad90b42790d8776173b3a81.1747431920.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <daf12021354ce7302ad90b42790d8776173b3a81.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> In subsequent commits we are going to determine KSM eligibility prior to a
> VMA being constructed, at which point we will of course not yet have access
> to a VMA pointer.
> 
> It is trivial to boil down the check logic to be parameterised on
> mm_struct, file and VMA flags, so do so.
> 
> As a part of this change, additionally expose and use file_is_dax() to
> determine whether a file is being mapped under a DAX inode.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good to me.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   include/linux/fs.h |  7 ++++++-
>   mm/ksm.c           | 32 ++++++++++++++++++++------------
>   2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 09c8495dacdb..e1397e2b55ea 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3691,9 +3691,14 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
>   
>   extern int file_update_time(struct file *file);
>   
> +static inline bool file_is_dax(const struct file *file)
> +{
> +	return file && IS_DAX(file->f_mapping->host);
> +}
> +
>   static inline bool vma_is_dax(const struct vm_area_struct *vma)
>   {
> -	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> +	return file_is_dax(vma->vm_file);
>   }
>   
>   static inline bool vma_is_fsdax(struct vm_area_struct *vma)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8583fb91ef13..08d486f188ff 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -677,28 +677,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>   	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>   }
>   
> -static bool vma_ksm_compatible(struct vm_area_struct *vma)
> +static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>   {
> -	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
> -			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
> -			     VM_MIXEDMAP| VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> +			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> +			VM_MIXEDMAP | VM_DROPPABLE))
>   		return false;		/* just ignore the advice */
>   
> -	if (vma_is_dax(vma))
> +	if (file_is_dax(file))
>   		return false;
>   
>   #ifdef VM_SAO
> -	if (vma->vm_flags & VM_SAO)
> +	if (vm_flags & VM_SAO)
>   		return false;
>   #endif
>   #ifdef VM_SPARC_ADI
> -	if (vma->vm_flags & VM_SPARC_ADI)
> +	if (vm_flags & VM_SPARC_ADI)
>   		return false;
>   #endif
>   
>   	return true;
>   }
>   
> +static bool vma_ksm_compatible(struct vm_area_struct *vma)
> +{
> +	return ksm_compatible(vma->vm_file, vma->vm_flags);
> +}
> +
>   static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>   		unsigned long addr)
>   {
> @@ -2696,14 +2701,17 @@ static int ksm_scan_thread(void *nothing)
>   	return 0;
>   }
>   
> -static void __ksm_add_vma(struct vm_area_struct *vma)
> +static bool __ksm_should_add_vma(const struct file *file, vm_flags_t vm_flags)
>   {
> -	unsigned long vm_flags = vma->vm_flags;
> -
>   	if (vm_flags & VM_MERGEABLE)
> -		return;
> +		return false;
> +
> +	return ksm_compatible(file, vm_flags);
> +}
>   
> -	if (vma_ksm_compatible(vma))
> +static void __ksm_add_vma(struct vm_area_struct *vma)
> +{
> +	if (__ksm_should_add_vma(vma->vm_file, vma->vm_flags))
>   		vm_flags_set(vma, VM_MERGEABLE);
>   }
>   

