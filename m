Return-Path: <linux-fsdevel+bounces-42865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF7A4A048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A513AEDCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5241F4CBC;
	Fri, 28 Feb 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Twf2/ZEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F91F4CBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763540; cv=none; b=b/uKxu6BP/g3wDc3KXKleNGL9FFoAi5zlTAFPomcY8IrFM4fkF/yzn7lZaxSPDE0ivYNabFp2d6uAB2Bj4UdRahM/irbjTjog30AgSFBLhCx3M7VR4bKqSv9umHtw+53GJac0A3qA0o14Dn2H7Wh20nGWIaw4xN4oX74Zy/JdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763540; c=relaxed/simple;
	bh=1TiCYUZ0vAqCAZx3Sr7pnzlY5Thqhl5/A1sQyss2dIM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=YyjgA1TrBhjm5CHET3QbwU/6tx1IPnvsGGApvzScrnl8GyEAnmmMxZ+PP527OsaNjxP8erkJ+I/rTbZ+D8IyR0tHgdw+5cfsQbBSEm2ucoxa7Z4Tkyh1CN0qxtxBpVrk3mL53+KHPYJzQ0zgFF+y335Egqqjb+kl8D6fdbAWqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Twf2/ZEI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso8186683a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740763538; x=1741368338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGWX9JyCXcF3HXXuHfM2kyrS8sFlOh2/32kcia7ZZ1o=;
        b=Twf2/ZEIJFIylO/sTaWUTTOgo/ytwvSosbNuMyPDrPcA+RKo31wiPB2M2ewqz2kU/3
         NphnfFcIBFG9soqMuZTLf2yNvLqVoeTXUhp9xa4yk8yvHhj9V1y/vZDMGEWrozTu708B
         9uWmy2LsZ0JFceEEf/RPzuNQ3zqi54Ui8BbPME9v2cqdtgOKtGE73CUoZ6Rh4X2kmPOs
         n1EavoLoCN0qhg4mgh90qoMkfNZYvyaYWtdwCnMD8rbZhEltZjgvvXezhwZKaBm6kU3f
         I1GsXow+9MGcVssGLceYggicrcMubVwFv17ojEIkHOy7hNsdMn2hbUpZIZyTYMhF/ElU
         mbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740763538; x=1741368338;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGWX9JyCXcF3HXXuHfM2kyrS8sFlOh2/32kcia7ZZ1o=;
        b=Wxpa6BeB+lcymzlNTt8YA3Tz8vo8UwqmSeYXaRJlXwwkjmqPqudYoIZdEJeBuWcUaV
         DMZn25jH8UKZ+47tK7Iyo04Hnl+Cm1eVFh6oIL8BuLljsrSS6eT52t7UnuQpMAxAWaNh
         KPUc/BvJNybk5CiH+g0Gl+I0LWEuUxn7LHxHQ3vlCVIAqTx0g4py5Rk85bei1tipjhaZ
         PJmcKPodvhYk2KhsDLyfry2832Q4R7Zdp8vfXPlVINNsBU33SE4lBskkIPii8/nk2bCq
         aGdLhfpMCX5VnkOgNWEftFH+FXWeGpEfKittU6A1Tb0TqSyB7Znq3eco/VA8BiCQK3Z2
         lu4g==
X-Forwarded-Encrypted: i=1; AJvYcCVmR+gDKzwV6M9hPnaK4F8Fd6wW1d15CyYVvD9tuGN4zqTOXS6eOCy9Y4i7Ukk8uPYemvR02pHf17tWUUmH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aDFGElr+eqtYXPTkCrCICp0W+lk7P3jfDQ6zqfkGph7x/02h
	MKUmTVfWpUN2nANCJsnq5htkO5CKXacoTLGWlYWcVe+ISvVYuaviohjO7OEPpUlStD6xoKI5ifr
	naPJwRG7+g5d7WUkzDCPEWg==
X-Google-Smtp-Source: AGHT+IEVamZ4Dk4Q9ektIiuhDOuGpmOLJiM7+w7jPIdHbpsjyMEUWr13Zn8uzbBWjARX1bXsyUzJf2To/ZLRvVhVPg==
X-Received: from pjn11.prod.google.com ([2002:a17:90b:570b:b0:2f5:4762:e778])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c6:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2febab2ed89mr6434291a91.5.1740763537744;
 Fri, 28 Feb 2025 09:25:37 -0800 (PST)
Date: Fri, 28 Feb 2025 17:25:36 +0000
In-Reply-To: <20250226082549.6034-5-shivankg@amd.com> (message from Shivank
 Garg on Wed, 26 Feb 2025 08:25:48 +0000)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
From: Ackerley Tng <ackerleytng@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, seanjc@google.com, david@redhat.com, vbabka@suse.cz, 
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shivankg@amd.com, 
	tabba@google.com
Content-Type: text/plain; charset="UTF-8"

Shivank Garg <shivankg@amd.com> writes:

> Previously, guest-memfd allocations followed local NUMA node id in absence
> of process mempolicy, resulting in arbitrary memory allocation.
> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
> in the VMM.
>
> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
> operation. This allows the VMM to map the memory and use mbind() to set
> the desired NUMA policy. The policy is then retrieved via
> mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
> ensure that allocations follow the specified memory policy.
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
>  virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f18176976ae3..b3a8819117a0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -2,6 +2,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/falloc.h>
>  #include <linux/kvm_host.h>
> +#include <linux/mempolicy.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
>
> @@ -11,8 +12,12 @@ struct kvm_gmem {
>  	struct kvm *kvm;
>  	struct xarray bindings;
>  	struct list_head entry;
> +	struct shared_policy policy;
>  };
>

struct shared_policy should be stored on the inode rather than the file,
since the memory policy is a property of the memory (struct inode),
rather than a property of how the memory is used for a given VM (struct
file).

When the shared_policy is stored on the inode, intra-host migration [1]
will work correctly, since the while the inode will be transferred from
one VM (struct kvm) to another, the file (a VM's view/bindings of the
memory) will be recreated for the new VM.

I'm thinking of having a patch like this [2] to introduce inodes.

With this, we shouldn't need to pass file pointers instead of inode
pointers.

> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
> +						   pgoff_t index);
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -99,7 +104,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(file_inode(file)->i_mapping, index);
> +	struct kvm_gmem *gmem = file->private_data;
> +	struct inode *inode = file_inode(file);
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
> +	policy = kvm_gmem_get_pgoff_policy(gmem, index);
> +	folio = filemap_grab_folio_mpol(inode->i_mapping, index, policy);
> +	mpol_cond_put(policy);
> +
> +	return folio;
>  }
>
>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -291,6 +314,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	mutex_unlock(&kvm->slots_lock);
>
>  	xa_destroy(&gmem->bindings);
> +	mpol_free_shared_policy(&gmem->policy);
>  	kfree(gmem);
>
>  	kvm_put_kvm(kvm);
> @@ -312,8 +336,57 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  {
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
> +#ifdef CONFIG_NUMA
> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kvm_gmem *gmem = file->private_data;
> +
> +	return mpol_set_shared_policy(&gmem->policy, vma, new);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> +		unsigned long addr, pgoff_t *pgoff)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kvm_gmem *gmem = file->private_data;
> +
> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	return mpol_shared_policy_lookup(&gmem->policy, *pgoff);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
> +						   pgoff_t index)
> +{
> +	struct mempolicy *mpol;
> +
> +	mpol = mpol_shared_policy_lookup(&gmem->policy, index);
> +	return mpol ? mpol : get_task_policy(current);
> +}
> +#else
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
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
> +	file_accessed(file);
> +	vma->vm_ops = &kvm_gmem_vm_ops;
> +	return 0;
> +}
>
>  static struct file_operations kvm_gmem_fops = {
> +	.mmap		= kvm_gmem_mmap,
>  	.open		= generic_file_open,
>  	.release	= kvm_gmem_release,
>  	.fallocate	= kvm_gmem_fallocate,
> @@ -446,6 +519,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	kvm_get_kvm(kvm);
>  	gmem->kvm = kvm;
>  	xa_init(&gmem->bindings);
> +	mpol_shared_policy_init(&gmem->policy, NULL);
>  	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>
>  	fd_install(fd, file);

[1] https://lore.kernel.org/lkml/cover.1691446946.git.ackerleytng@google.com/T/
[2] https://lore.kernel.org/all/d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com/

