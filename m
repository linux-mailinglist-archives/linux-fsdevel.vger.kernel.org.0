Return-Path: <linux-fsdevel+bounces-65710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F42C0E03C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F00A3AF37B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C12C11D6;
	Mon, 27 Oct 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TM9vO7Jc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85Ixpc4J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Neqw/yzt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5zhOPEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4028727B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571656; cv=none; b=iJ4IZWFQRR6fplc5qMuWg3R0zwp67JY6JqT9Zw8yx13Ok5VQoqB9xs8NbFCZHbqJ2C/uPJwlPqNRPNwqkKOElzW63AVtyBnu1ogd0WfotP0EEGH895UUCRqvaek0AKAcRcnJGny5SbFThE6jULRGZWX6ZX5aj8myLZJ++ntRzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571656; c=relaxed/simple;
	bh=o5Ho7ZZ2WaFp0JzdWDL0uVeZ8dGhvbT/ojp1hVOm93I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEYJF2PkVwmImX8F/XRJsTXC4kuSO9/c75OhNkDs7448KcvQgVIZhU3rbOvPj8Kifvc/s7WOC9WjFRSGTD8l1PRYIQBvAjRNSEQzqJn6p0HPSG9v1BjwmC9Zka4M9dyku8iZ29m5PsDrEInFYdtTa+kwXXHw0NdJY5Yk7ksKmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TM9vO7Jc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85Ixpc4J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Neqw/yzt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5zhOPEQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF540219E4;
	Mon, 27 Oct 2025 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761571651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5XpAc/wnKhW7u09JNrLPt9PaFPUwXBy6MclCMVEFG2c=;
	b=TM9vO7Jc61kw+VXUhOQ+PGjaEbab7kI7IqQsWiI8Becj2jWF0T18ysXykCJva50100qZiV
	KxZS/IYk5nxsFp6WBXD0QGjZtXB7J+QsgAyu4CLo+QaJKwPfCZmam4WTXqa6eI4ABpLRp5
	VFCL6kLowFxDpMiOc6vWqgGf19tN7GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761571651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5XpAc/wnKhW7u09JNrLPt9PaFPUwXBy6MclCMVEFG2c=;
	b=85Ixpc4JK9GwDRQJK1w6m0apKLDqjn/tLJKiqOW/a2SWTiwaaxcoQIeZxANpbukVMYAZUC
	Cq9BrhPHp0AEVPBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Neqw/yzt";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N5zhOPEQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761571650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5XpAc/wnKhW7u09JNrLPt9PaFPUwXBy6MclCMVEFG2c=;
	b=Neqw/yzt5jkjQeyE88ZObAB5rNiQRIMgkO1G/L0izC2JO31t3R8ruwVCycwb9ObjVlA3lC
	NTdrolCFr07dGsBUvQQI10lxfPW+Paamqcryxl8G5O7pUW/xYZi2+FFmEIEyYZWKoN7Pm8
	FuVlvhMX17+Qxsh8z81l6vY52dMCbA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761571650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5XpAc/wnKhW7u09JNrLPt9PaFPUwXBy6MclCMVEFG2c=;
	b=N5zhOPEQviM9fOW+4dNYU4eUhqEyCo0EbRr9vYHizE0xAZESli17qpj+4h+HXMWzK0upNn
	dbhf1I3lAqr0C5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38112136CF;
	Mon, 27 Oct 2025 13:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /r5bDUJz/2gfTwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 27 Oct 2025 13:27:30 +0000
Message-ID: <33d350d9-b247-4181-b8c8-5e879acd35fe@suse.cz>
Date: Mon, 27 Oct 2025 14:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
Content-Language: en-US
To: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
 brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
 corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
 fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org,
 hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com,
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
 viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
 will@kernel.org, willy@infradead.org, wyihan@google.com,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1760731772.git.ackerleytng@google.com>
 <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CF540219E4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,alien8.de,kernel.org,intel.com,lwn.net,redhat.com,google.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,ziepe.ca,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[98];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLit8ednp7j3q8s7mp5dsi7bwe)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 10/17/25 22:11, Ackerley Tng wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Start plumbing in guest_memfd support for in-place private<=>shared
> conversions by tracking attributes via a maple tree.  KVM currently tracks
> private vs. shared attributes on a per-VM basis, which made sense when a
> guest_memfd _only_ supported private memory, but tracking per-VM simply
> can't work for in-place conversions as the shareability of a given page
> needs to be per-gmem_inode, not per-VM.
> 
> Use the filemap invalidation lock to protect the maple tree, as taking the
> lock for read when faulting in memory (for userspace or the guest) isn't
> expected to result in meaningful contention, and using a separate lock
> would add significant complexity (avoid deadlock is quite difficult).

+Cc Liam and maple-tree list, especially for this part.

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  virt/kvm/guest_memfd.c | 119 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 103 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b22caa8b530ab..26cec833766c3 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/maple_tree.h>
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> @@ -32,6 +33,7 @@ struct gmem_inode {
>  	struct inode vfs_inode;
> 
>  	u64 flags;
> +	struct maple_tree attributes;
>  };
> 
>  static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> @@ -54,6 +56,23 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>  }
> 
> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> +{
> +	void *entry = mtree_load(&GMEM_I(inode)->attributes, index);
> +
> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
> +}
> +
> +static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> +{
> +	return kvm_gmem_get_attributes(inode, index) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +
> +static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> +{
> +	return !kvm_gmem_is_private_mem(inode, index);
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -415,10 +434,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return VM_FAULT_SIGBUS;
> 
> -	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> -		return VM_FAULT_SIGBUS;
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
> +		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	else
> +		folio = ERR_PTR(-EACCES);
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
> 
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		if (PTR_ERR(folio) == -EAGAIN)
>  			return VM_FAULT_RETRY;
> @@ -572,6 +594,46 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  	return true;
>  }
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
>  static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  {
>  	static const char *name = "[kvm-gmem]";
> @@ -602,16 +664,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  		goto err_fops;
>  	}
> 
> -	inode->i_op = &kvm_gmem_iops;
> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
> -	inode->i_mode |= S_IFREG;
> -	inode->i_size = size;
> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> -	mapping_set_inaccessible(inode->i_mapping);
> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> -
> -	GMEM_I(inode)->flags = flags;
> +	err = kvm_gmem_init_inode(inode, size, flags);
> +	if (err)
> +		goto err_inode;
> 
>  	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>  	if (IS_ERR(file)) {
> @@ -798,9 +853,13 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
> 
> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> +	if (IS_ERR(folio)) {
> +		r = PTR_ERR(folio);
> +		goto out;
> +	}
> 
>  	if (!is_prepared)
>  		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> @@ -812,6 +871,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	else
>  		folio_put(folio);
> 
> +out:
> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
> @@ -925,13 +986,39 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
> 
>  	mpol_shared_policy_init(&gi->policy, NULL);
> 
> +	/*
> +	 * Memory attributes are protected the filemap invalidation lock, but
> +	 * the lock structure isn't available at this time.  Immediately mark
> +	 * maple tree as using external locking so that accessing the tree
> +	 * before its fully initialized results in NULL pointer dereferences
> +	 * and not more subtle bugs.
> +	 */
> +	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
> +
>  	gi->flags = 0;
>  	return &gi->vfs_inode;
>  }
> 
>  static void kvm_gmem_destroy_inode(struct inode *inode)
>  {
> -	mpol_free_shared_policy(&GMEM_I(inode)->policy);
> +	struct gmem_inode *gi = GMEM_I(inode);
> +
> +	mpol_free_shared_policy(&gi->policy);
> +
> +	/*
> +	 * Note!  Checking for an empty tree is functionally necessary to avoid
> +	 * explosions if the tree hasn't been initialized, i.e. if the inode is
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
>  }
> 
>  static void kvm_gmem_free_inode(struct inode *inode)
> --
> 2.51.0.858.gf9c4a03a3a-goog


