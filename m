Return-Path: <linux-fsdevel+bounces-68026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD9C513EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECEF189D712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671112FE050;
	Wed, 12 Nov 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n05MXCnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7023BD1B;
	Wed, 12 Nov 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937916; cv=none; b=O/T8I4qbNogrTZjCMvA+262k8tuJHd+jTu7Q7/rtUGTOSIwMlPlriB8nqq/C6NRpB84h/jA1ZYD8WDSZN7o4c7Dd1Xl69LtxOBEHPwH9UZcEj0mBezE+LiVGSQmtxD5PoWGp1zvTGJNmQQJfRSngkP1FEkW4kLxot8bERHRJ49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937916; c=relaxed/simple;
	bh=zRDQF4ySYQusOHzc2T1tZsRtG0bPI5An+rv/0D9ldPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bErVRvqILX+JcKL5a/B/8vy2cB+G9lDrtsLWCYlZwx+eADyCC/hRjQktjuUlXfmAg21LyYX0JJ/+BLlZySzzMUlWK7OtUjwIHCeSOfkQgEHbYaIYuzpjGdQnvLvn0WlJs8qTr/CBFwF5LIUJnyhlKokSLPr4A2990/D3q8aPzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n05MXCnw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762937915; x=1794473915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zRDQF4ySYQusOHzc2T1tZsRtG0bPI5An+rv/0D9ldPA=;
  b=n05MXCnwoF3FDYv3miQrqUY/syKVpHg561KFlQRaJfHD0mvgOQwmEDx3
   uDTk+hD9pCTsCpfbGV/KX63xlUjQAQkeSHAWa54xUlUvthEU7YE4XlJqD
   hmXwdPlRfKkTZ785dPturti7hAhdBC1MGU+aTQU29/7IzUWTh+6gK16TY
   //rxvqTMs6KwNex5XFBMXG1aEhDowAZWdusbHmm3BRJRYCdT7sl2+K3wP
   NZW6vrQPgmVEo9dQoXt7YgzYn48R3bz2c8IOfUD9INWHKh5tX+u09uygY
   E4erDzqbw3BmDGtKSnfmnYxATluz3K9qTLgK3/NLZ73LKvBce5p+xhfZM
   Q==;
X-CSE-ConnectionGUID: IgU1RCQSRgSkJELES+VqJw==
X-CSE-MsgGUID: 4QwU3wrkT5WjpL55VeY8Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="52556509"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="52556509"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:58:33 -0800
X-CSE-ConnectionGUID: pRO6tdWeROitpi6xfJxcsA==
X-CSE-MsgGUID: jwxmFvxbSl+/qGbeC5NoOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189343307"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:58:13 -0800
Message-ID: <ab3f297e-44d5-4f42-aa17-f2e7c135580e@linux.intel.com>
Date: Wed, 12 Nov 2025 16:58:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: Ackerley Tng <ackerleytng@google.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org,
 chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net,
 dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com,
 dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com,
 fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org,
 hpa@zytor.com, hughd@google.com, ira.weiny@intel.com,
 isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
 jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com,
 jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com,
 kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maobibo@loongson.cn,
 mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
 mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com,
 mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, peterx@redhat.com, pgonda@google.com, prsampat@amd.com,
 pvorel@suse.cz, qperret@google.com, richard.weiyang@gmail.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com,
 shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
 steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
 vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
 wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
 wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
 yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1760731772.git.ackerleytng@google.com>
 <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/2025 4:11 AM, Ackerley Tng wrote:
[...]
>
> +static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
> +{
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
> +	u64 attrs;
> +	int r;
> +
> +	inode->i_op = &kvm_gmem_iops;
> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
> +	inode->i_mode |= S_IFREG;
> +	inode->i_size = size;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +	mapping_set_inaccessible(inode->i_mapping);
> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
AS_UNMOVABLE has been removed and got merged into AS_INACCESSIBLE, not sure if
it's better to use "Inaccessible" instead of "Unmovable"

> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	gi->flags = flags;
> +
> +	mt_set_external_lock(&gi->attributes,
> +			     &inode->i_mapping->invalidate_lock);
> +
> +	/*
> +	 * Store default attributes for the entire gmem instance. Ensuring every
> +	 * index is represented in the maple tree at all times simplifies the
> +	 * conversion and merging logic.
> +	 */
> +	attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +
> +	/*
> +	 * Acquire the invalidation lock purely to make lockdep happy. There
> +	 * should be no races at this time since the inode hasn't yet been fully
> +	 * created.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return r;
> +}
> +
[...]
> @@ -925,13 +986,39 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>
>   	mpol_shared_policy_init(&gi->policy, NULL);
>
> +	/*
> +	 * Memory attributes are protected the filemap invalidation lock, but
                                      ^
                                 protected by
> +	 * the lock structure isn't available at this time.  Immediately mark
> +	 * maple tree as using external locking so that accessing the tree
> +	 * before its fully initialized results in NULL pointer dereferences
> +	 * and not more subtle bugs.
> +	 */
> +	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
> +
>   	gi->flags = 0;
>   	return &gi->vfs_inode;
>   }
>
>   static void kvm_gmem_destroy_inode(struct inode *inode)
>   {
> -	mpol_free_shared_policy(&GMEM_I(inode)->policy);
> +	struct gmem_inode *gi = GMEM_I(inode);
> +
> +	mpol_free_shared_policy(&gi->policy);
> +
> +	/*
> +	 * Note!  Checking for an empty tree is functionally necessary to avoid
> +	 * explosions if the tree hasn't been initialized, i.e. if the inode is

It makes sense to skip __mt_destroy() when mtree is empty.
But what explosions it could trigger if mtree is empty?
It seems __mt_destroy() can handle the case if the external lock is not set.


> +	 * being destroyed before guest_memfd can set the external lock.
> +	 */
> +	if (!mtree_empty(&gi->attributes)) {
> +		/*
> +		 * Acquire the invalidation lock purely to make lockdep happy,
> +		 * the inode is unreachable at this point.
> +		 */
> +		filemap_invalidate_lock(inode->i_mapping);
> +		__mt_destroy(&gi->attributes);
> +		filemap_invalidate_unlock(inode->i_mapping);
> +	}
>   }
>
>   static void kvm_gmem_free_inode(struct inode *inode)
> --
> 2.51.0.858.gf9c4a03a3a-goog


