Return-Path: <linux-fsdevel+bounces-46205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F474A8452C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6872717AA7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959228C5B4;
	Thu, 10 Apr 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9ETxxgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC792857FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292441; cv=none; b=CHLzjIGb+0KN1b35XGri2toTgfGsuIbdoGLMA2kcBo4LIdyNLfXJZKBGQMoZn/p1OWAAUsQxbLinqLriYpL0JsM3TsE/2wvPDS48AEyMuAZXaJrQ4zi+gx06PkH9Fw9MO+gFWX0l7/3RrVl6kC8U5IxJvz/F+jpwuvGChRHFIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292441; c=relaxed/simple;
	bh=RyXiF/jkRIj400dJ7AmDNhGbCH7VL8l8ltE6ndzB2ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nz1vsawBMcZxV4sftyZ9dzeJ6taDOE1WABuj2OTggMhyY2qyXkBslA9w2XQJDk+OGfu67EO5fMc4EHY09lc0K4FRDYb80UrFTplmtmGSIwvEv9fZ9YqTdZgCN2zDpzcD5sNgpec59zp+7AbjY3phcjwWKz+S8sJqD28dw9cdrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9ETxxgc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c89461d1so1169745b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292436; x=1744897236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAdkgo+26TLCNZdpvTsQI8wpHzhqkKGWGAXIQv7DOuE=;
        b=B9ETxxgcpob74poHujyQ6niCcx87Bg925/BVqnEMQ15WZIXIdaywXzbPrhK77jEHo7
         mAL0pAB7fXO01+v0aY+q+61QbzkPMDau0h2zqnQai15oynUogkauwlgID+wUHYjHiDMU
         q7CMVskcTB6FYdZ8v6uoPehyBidXTn7AqEdt8Gh9T7WB3xn/ux824PwpkMPRb1YlDr++
         rOasQmFgnJWaWvZQZE2k93SSZPuBM1D7h4fBiKi5hu8lvT3yquZEtfLp6/NjqFm26VOS
         tVu8LHdHZsqUaE3cQszQMjPXcrjZpTexiTQhxYISVv4b2jsuKeS/KE5vUMZk6Dt/QLBe
         Z9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292436; x=1744897236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAdkgo+26TLCNZdpvTsQI8wpHzhqkKGWGAXIQv7DOuE=;
        b=fNA8GlJyG/hXHkt/HU+3oKFNVnWzrh2YrPrzpUUSAa3fpV4WAv2k+KseS7cEAqH+BL
         sIrFM73WslHBboe8a+F6ca+vU4KYN68dw8YZfaQ7tEYPLX1u4QCkVYuLQJjN5S84GEcv
         ZgXjZtxE/1BYMZ5LB7nFc4C+cU7uL44UPPedA/jzfZupdf+PNrwx2hSPjwsWQM2xnfzM
         Mg3aMobrFB0WIZk10GWdFfZAFp98W+v2ykqS8zQiVIfCDKyRstXvVUXM0XFIFq307yqb
         01TIUK/KKm0NralUe8Jz2XV1V5lv3do4nCOm2kxkPfc7OfIA+yA9rlddQ4yTPZhGml3Q
         be1A==
X-Forwarded-Encrypted: i=1; AJvYcCUaz/CS6PvGbhLx44sGEW7zYcxr98Ogw3jvGPVe4XIYv15R92qSJj5LdhkeSYBiNZpKR0YRWAULL6U0cuKi@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUOxPiTujblwE+crrfpuDS/tTW6heVeujZPFWmhc5yG5ZRXIe
	3AQdnQPc3Jj0D4i3AKc9S/QabPr0dVgvZ1x8O8qgdcjHWHoKJ4uIgxlYrherMuHZ1oGG0bLKY74
	lIcD8ZVOXEmqGi/fSO+5rLQ==
X-Google-Smtp-Source: AGHT+IHA1HgsCl6z98FoXuuYkPI1df6L0N/s2mcX4Y5/lnvzb/BxqximvQNI8RQed9Y9suGb1/1qvHayYMY3eco6Ww==
X-Received: from pfbgj26.prod.google.com ([2002:a05:6a00:841a:b0:736:3d80:7076])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:244c:b0:732:a24:7354 with SMTP id d2e1a72fcca58-73bc09faeb8mr2766392b3a.4.1744292436406;
 Thu, 10 Apr 2025 06:40:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:40:34 -0700
In-Reply-To: <20250408112402.181574-8-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408112402.181574-1-shivankg@amd.com> <20250408112402.181574-8-shivankg@amd.com>
Message-ID: <diqz7c3s5e3x.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH RFC v7 7/8] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
From: Ackerley Tng <ackerleytng@google.com>
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com, vbabka@suse.cz, 
	willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org, 
	pbonzini@redhat.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, shivankg@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Shivank Garg <shivankg@amd.com> writes:

> Previously, guest-memfd allocations followed local NUMA node id in absence
> of process mempolicy, resulting in arbitrary memory allocation.
> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
> in the VMM.
>
> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
> operation. This allows the VMM to map the memory and use mbind() to set the
> desired NUMA policy. The policy is stored in the inode structure via
> kvm_gmem_inode_info, as memory policy is a property of the memory (struct
> inode) itself. The policy is then retrieved via mpol_shared_policy_lookup()
> and passed to filemap_grab_folio_mpol() to ensure that allocations follow
> the specified memory policy.
>
> This enables the VMM to control guest memory NUMA placement by calling
> mbind() on the mapped memory regions, providing fine-grained control over
> guest memory allocation across NUMA nodes.
>
> The policy change only affect future allocations and does not migrate
> existing memory. This matches mbind(2)'s default behavior which affects
> only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
> flags, which are not supported for guest_memfd as it is unmovable.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  virt/kvm/guest_memfd.c | 75 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 0ccbb152483a..233d3fd5781c 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/falloc.h>
>  #include <linux/kvm_host.h>
> +#include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
> @@ -19,6 +20,7 @@ struct kvm_gmem {
>  };
>  
>  struct kvm_gmem_inode_info {
> +	struct shared_policy policy;
>  	struct inode vfs_inode;
>  };

What are the pros and cons that you see of storing struct shared_policy
in a containing struct kvm_gmem_inode_info, as opposed to storing it in
inode->i_private?

I've just been using inode->i_private for sharability and hugetlb
metadata and didn't consider this option.

Could one reason be that struct shared_policy is a requirement for all
inodes (not a CONFIG flag) but sharability and hugetlb metadata are both
configurable, possibly at runtime?

>  
> @@ -27,6 +29,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
>  	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
>  }
>  
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index);
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -113,7 +118,24 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	struct mempolicy *policy;
> +	struct folio *folio;
> +
> +	/*
> +	 * Fast-path: See if folio is already present in mapping to avoid
> +	 * policy_lookup.
> +	 */
> +	folio = __filemap_get_folio(inode->i_mapping, index,
> +				    FGP_LOCK | FGP_ACCESSED, 0);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
> +	folio = filemap_grab_folio_mpol(inode->i_mapping, index, policy,
> +					NO_INTERLEAVE_INDEX);
> +	mpol_cond_put(policy);
> +
> +	return folio;
>  }
>  
>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -336,12 +358,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>  	if (!info)
>  		return NULL;
>  
> +	mpol_shared_policy_init(&info->policy, NULL);
> +
>  	return &info->vfs_inode;
>  }
>  
>  static void kvm_gmem_destroy_inode(struct inode *inode)
>  {
> -
> +	mpol_free_shared_policy(&KVM_GMEM_I(inode)->policy);
>  }
>  
>  static void kvm_gmem_free_inode(struct inode *inode)
> @@ -384,7 +408,54 @@ static void kvm_gmem_init_mount(void)
>  	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
>  }
>  
> +#ifdef CONFIG_NUMA
> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> +					     unsigned long addr, pgoff_t *pgoff)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index)
> +{
> +	struct mempolicy *mpol;
> +
> +	mpol = mpol_shared_policy_lookup(&info->policy, index);
> +	return mpol ? mpol : get_task_policy(current);
> +}
> +#else
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_NUMA */
> +
> +static const struct vm_operations_struct kvm_gmem_vm_ops = {
> +#ifdef CONFIG_NUMA
> +	.get_policy	= kvm_gmem_get_policy,
> +	.set_policy	= kvm_gmem_set_policy,
> +#endif
> +};
> +
> +static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops = &kvm_gmem_vm_ops;
> +	return 0;
> +}
> +
>  static struct file_operations kvm_gmem_fops = {
> +	.mmap		= kvm_gmem_mmap,
>  	.open		= generic_file_open,
>  	.release	= kvm_gmem_release,
>  	.fallocate	= kvm_gmem_fallocate,
> -- 
> 2.34.1

