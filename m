Return-Path: <linux-fsdevel+bounces-52677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90E2AE5B78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB06C1BC2936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B3226D00;
	Tue, 24 Jun 2025 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IOL4zxnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116F21B9F6;
	Tue, 24 Jun 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738583; cv=none; b=EbIgIrY0Nc7zqbgYdAfNI0ZZWlC7tK6gMv4l5bDfzxbxX2bw8FqlB5TLTQByF8an0VQRG5kG7kkLKZNnpUlgg5n1Vc9LHYflsTWaXpITBAazcih6B9Ph0Jy810/s0W/btYyVvIJJGzK1J/TE3Jetyue3VGOYoM5bQPbyO+8k5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738583; c=relaxed/simple;
	bh=5G65DW5QVEJiCP6BevqgcMH4BJprL0i7tiSazmp4+XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxqnssdI9dhQ2FRis+EHfFp4Hm3bJrZos2lz1w9aOektwHqqzg5iL2cA6lUkk3ZviLHjZj9fooZrWi9KqCQw1t6qsgx0a2cOIFtii83e7v7nFq3lGhurxhsz7wmQUoefRl+qB6Iho25uDiNdBWh4QTLJ4gBUtsc/C5RXbccjtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IOL4zxnU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750738571; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=rax2iaNWOHCKSTHeRONdpsloXVAQJACyDqlDlmBHKYA=;
	b=IOL4zxnUhxUMIfdtwOPU4ubp9N+hGmb4m52ei0x5WEB8nWp4ESIgh4FpP/qRvd+Gf9WxzgGyBn/T2Rfemf9tsCa+MQBD4fHFyUR3LTmz8LYh6XtqtMf8unx5DFn0ZALwXJCkFcNuvC+1mn1d2l/idKvXWY/enCK4rSeZOI9ZjBY=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wef2ct8_1750738566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 12:16:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Shivank Garg <shivankg@amd.com>
Cc: <seanjc@google.com>,  <david@redhat.com>,  <vbabka@suse.cz>,
  <willy@infradead.org>,  <akpm@linux-foundation.org>,  <shuah@kernel.org>,
  <pbonzini@redhat.com>,  <brauner@kernel.org>,  <viro@zeniv.linux.org.uk>,
  <ackerleytng@google.com>,  <paul@paul-moore.com>,  <jmorris@namei.org>,
  <serge@hallyn.com>,  <pvorel@suse.cz>,  <bfoster@redhat.com>,
  <tabba@google.com>,  <vannapurve@google.com>,  <chao.gao@intel.com>,
  <bharata@amd.com>,  <nikunj@amd.com>,  <michael.day@amd.com>,
  <yan.y.zhao@intel.com>,  <Neeraj.Upadhyay@amd.com>,
  <thomas.lendacky@amd.com>,  <michael.roth@amd.com>,  <aik@amd.com>,
  <jgg@nvidia.com>,  <kalyazin@amazon.com>,  <peterx@redhat.com>,
  <jack@suse.cz>,  <rppt@kernel.org>,  <hch@infradead.org>,
  <cgzones@googlemail.com>,  <ira.weiny@intel.com>,  <rientjes@google.com>,
  <roypat@amazon.co.uk>,  <ziy@nvidia.com>,  <matthew.brost@intel.com>,
  <joshua.hahnjy@gmail.com>,  <rakie.kim@sk.com>,  <byungchul@sk.com>,
  <gourry@gourry.net>,  <kent.overstreet@linux.dev>,  <apopple@nvidia.com>,
  <chao.p.peng@intel.com>,  <amit@infradead.org>,  <ddutile@redhat.com>,
  <dan.j.williams@intel.com>,  <ashish.kalra@amd.com>,  <gshan@redhat.com>,
  <jgowans@amazon.com>,  <pankaj.gupta@amd.com>,  <papaluri@amd.com>,
  <yuzhao@google.com>,  <suzuki.poulose@arm.com>,
  <quic_eberman@quicinc.com>,  <aneeshkumar.kizhakeveetil@arm.com>,
  <linux-fsdevel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-security-module@vger.kernel.org>,
  <kvm@vger.kernel.org>,  <linux-kselftest@vger.kernel.org>,
  <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH v8 5/7] KVM: guest_memfd: Add slab-allocated inode
 cache
In-Reply-To: <20250618112935.7629-6-shivankg@amd.com> (Shivank Garg's message
	of "Wed, 18 Jun 2025 11:29:33 +0000")
References: <20250618112935.7629-1-shivankg@amd.com>
	<20250618112935.7629-6-shivankg@amd.com>
Date: Tue, 24 Jun 2025 12:16:06 +0800
Message-ID: <87ecv9ojuh.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Shivank Garg <shivankg@amd.com> writes:

> Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
> inode cache for guest memory backing, similar to how shmem handles inodes.
>
> This adds the necessary allocation/destruction functions and prepares
> for upcoming guest_memfd NUMA policy support changes.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  virt/kvm/guest_memfd.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 159df462d193..5a1ce6f5e287 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -17,6 +17,15 @@ struct kvm_gmem {
>  	struct list_head entry;
>  };
>  
> +struct kvm_gmem_inode_info {
> +	struct inode vfs_inode;
> +};
> +
> +static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
> +{
> +	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
> +}
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -392,8 +401,33 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> +static struct kmem_cache *kvm_gmem_inode_cachep;
> +
> +static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
> +{
> +	struct kvm_gmem_inode_info *info;
> +
> +	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
> +	if (!info)
> +		return NULL;
> +
> +	return &info->vfs_inode;
> +}
> +
> +static void kvm_gmem_destroy_inode(struct inode *inode)
> +{
> +}
> +
> +static void kvm_gmem_free_inode(struct inode *inode)
> +{
> +	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
> +}
> +
>  static const struct super_operations kvm_gmem_super_operations = {
>  	.statfs		= simple_statfs,
> +	.alloc_inode	= kvm_gmem_alloc_inode,
> +	.destroy_inode	= kvm_gmem_destroy_inode,
> +	.free_inode	= kvm_gmem_free_inode,
>  };
>  
>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> @@ -426,10 +460,26 @@ static int kvm_gmem_init_mount(void)
>  	return 0;
>  }
>  
> +static void kvm_gmem_init_inode(void *foo)
> +{
> +	struct kvm_gmem_inode_info *info = foo;
> +
> +	inode_init_once(&info->vfs_inode);
> +}
> +
> +static void kvm_gmem_init_inodecache(void)
> +{
> +	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
> +						  sizeof(struct kvm_gmem_inode_info),
> +						  0, SLAB_ACCOUNT,
> +						  kvm_gmem_init_inode);

Check the return value?

And, I'm not a big fan of (logically) one line function encapsulation.

> +}
> +
>  int kvm_gmem_init(struct module *module)
>  {
>  	kvm_gmem_fops.owner = module;
>  
> +	kvm_gmem_init_inodecache();
>  	return kvm_gmem_init_mount();

kmem_cache_destroy(kvm_gmem_inode_cachep) if kvm_gmem_init_mount()
return with error?

>  }
>  
> @@ -437,6 +487,7 @@ void kvm_gmem_exit(void)
>  {
>  	kern_unmount(kvm_gmem_mnt);
>  	kvm_gmem_mnt = NULL;
> +	kmem_cache_destroy(kvm_gmem_inode_cachep);
>  }
>  
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,

---
Best Regards,
Huang, Ying

