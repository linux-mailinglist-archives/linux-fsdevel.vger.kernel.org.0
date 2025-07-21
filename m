Return-Path: <linux-fsdevel+bounces-55591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39806B0C389
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4D167610
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9A2BF3F4;
	Mon, 21 Jul 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Y0U/RV7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2shmLIXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZiNxp/l1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X5eysvCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FD2BE02E
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098287; cv=none; b=pYAtyWRZnVwW/EfYvRq2JQvSbbuG3AfZe+khEVYMNg5P8By7CUUlAfJz4k0RUerEyQxvpoRHm2MXFhpCSfatSLjr1rPUCd83EZYau6wE7lT9t4vzA9J5anZJjsEnGvYpBlPcrsd4V2Pb/oPGO6NtsG/72A9zw2i0ZCEKJ+HW1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098287; c=relaxed/simple;
	bh=y2ZY6q5DHvBrjnCU7EvVvqgu4wCoeygwatNPsmLRFaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbZ63Q6koAUnmXwxbiMogPSjbPIAzUFm0ZmV5uYwjU9LJzSwsXJQNl8wrX7P5py5HZ94b+AsRERwo8mi0Ftmx4z59fUk2XQVy228frGN9orCnDE5lZvBRulxMOHo3OnBBRlp0ItrqJI68C7+WyweZDpvhNis61JsGZBZoRR9q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Y0U/RV7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2shmLIXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZiNxp/l1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X5eysvCX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC56C21B43;
	Mon, 21 Jul 2025 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753098283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUmNYP0zD96NJMt2QiJF3yH4rGim2UQsUeVCtMOyHVk=;
	b=1Y0U/RV7y6jdLP39ld2T8fNtJm+RxB2r5KWi4u6f3i9FKz0/m+UqO5x+6ljcTc8SLLFC+N
	fswGbzhRxaU5AldqhJbY4bJg6Bpt2nTbWar2tbpkLM0ZX+uAs5b3VW5pjGWdQgugTJhesP
	9porNnODmkQBr/jpgB1JUihfnMYSxfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753098283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUmNYP0zD96NJMt2QiJF3yH4rGim2UQsUeVCtMOyHVk=;
	b=2shmLIXcpt9sF7Gt05RDg5czHIluPVLQifJKYHwvlyvefDzErx5HKJh6cq4MpMOzfLO5OT
	h8TO/AohfNI3FhCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZiNxp/l1";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X5eysvCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753098282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUmNYP0zD96NJMt2QiJF3yH4rGim2UQsUeVCtMOyHVk=;
	b=ZiNxp/l1ik8lvzeCSoaGr/IzgCefVwK2VlvCYGdFMoEyTbfIaODdp3+z92+wGWZYZAYbEx
	8T3k/Tsh0SfiuLyfJ5m6n9PLCbVG9ANUT8qS9v9MUGfl0O4jCmT9MbwV8ZSLILVcGN8sRf
	A570qiXiMTa2Hguvs3tzK3kLMR1oosg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753098282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUmNYP0zD96NJMt2QiJF3yH4rGim2UQsUeVCtMOyHVk=;
	b=X5eysvCXZRU7ogAWyK98TQUiKwA56IzcSvOJO9ZMkfcYWm4BFBhRZjf8LxR8pPClwbLFA9
	XdraXbSvp72r9tBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71EF813A88;
	Mon, 21 Jul 2025 11:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nelPGyoofmjUMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Jul 2025 11:44:42 +0000
Message-ID: <78f3032d-dfa4-4907-be42-6a7e8a34371e@suse.cz>
Date: Mon, 21 Jul 2025 13:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <20250713174339.13981-8-shivankg@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250713174339.13981-8-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DC56C21B43
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,paul-moore.com,namei.org,hallyn.com,suse.cz,redhat.com,intel.com,amd.com,nvidia.com,amazon.com,kernel.org,infradead.org,googlemail.com,amazon.co.uk,gmail.com,sk.com,gourry.net,linux.dev,linux.alibaba.com,arm.com,quicinc.com,vger.kernel.org,kvack.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[66];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

On 7/13/25 19:43, Shivank Garg wrote:
> Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
> inode cache for guest memory backing, similar to how shmem handles inodes.
> 
> This adds the necessary allocation/destruction functions and prepares
> for upcoming guest_memfd NUMA policy support changes.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  virt/kvm/guest_memfd.c | 58 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index dabcc2317291..989e2b26b344 100644
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
> @@ -426,17 +460,37 @@ static int kvm_gmem_init_mount(void)
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
>  int kvm_gmem_init(struct module *module)
>  {
> -	kvm_gmem_fops.owner = module;
> +	int ret;
>  
> -	return kvm_gmem_init_mount();
> +	kvm_gmem_fops.owner = module;
> +	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
> +						  sizeof(struct kvm_gmem_inode_info),
> +						  0, SLAB_ACCOUNT,
> +						  kvm_gmem_init_inode);

Since this is new code, please use the new variant of kmem_cache_create()
that takes the args parameter.

> +	if (!kvm_gmem_inode_cachep)
> +		return -ENOMEM;
> +	ret = kvm_gmem_init_mount();
> +	if (ret) {
> +		kmem_cache_destroy(kvm_gmem_inode_cachep);
> +		return ret;
> +	}
> +	return 0;
>  }
>  
>  void kvm_gmem_exit(void)
>  {
>  	kern_unmount(kvm_gmem_mnt);
>  	kvm_gmem_mnt = NULL;
> +	kmem_cache_destroy(kvm_gmem_inode_cachep);
>  }
>  
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,


