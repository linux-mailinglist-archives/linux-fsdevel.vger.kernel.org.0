Return-Path: <linux-fsdevel+bounces-65714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C0C0E323
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F2418933D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E374306B30;
	Mon, 27 Oct 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZnsBY5q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="buInvN6u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZnsBY5q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="buInvN6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A2306B1B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573404; cv=none; b=ND7XCzs/EKd0HdnF1DlJtbHw//LtA00KROv5oqGU6qx4dmh+Gpgj+d6hNB+Wic8XB//YVp5Xs2zPzAU972CU/8k4Fjd/comphFC0/Gwx5a8cc0/ZoxYA1nI+6YkGr4yXjjRDMquGlEgeg+x8Gsf1a9ie9m+zW2Ju5lgbybJvcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573404; c=relaxed/simple;
	bh=Uq4z9N9k0Eq4+OZkPjdcMiH895Y/0vflcREhIMMB240=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmVJpRpcLBrqdV1Ur+hNStO1CKdXrtbtkKgGWvgluP0wwM2Bgy02ubmB+xTNuenB5kS8pZm7zdjnjj1cXh0F/cKBpe9VLLFpyurbkSCVdjAn+5uzhcq6fX11pkUy6/5amFLosiKfkb1K418Utw0ayHQHZ4I3TP6HneArExTBPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZnsBY5q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=buInvN6u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZnsBY5q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=buInvN6u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 013E6219EE;
	Mon, 27 Oct 2025 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761573400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIeIX1/GfDr+PgyE+6keWOlaywVCkkDhuvCBLGIQkjk=;
	b=JZnsBY5qPwthR5hhTqYWrvQ/1mdrWii+uV53ENK75DAwpaEmMVkY1w7ma9zUR4EfrKgGya
	1OrddNE4houLjN+9NGiRv9Ozd+8+MPUs0gH+ZJvybrkKGQNKF9vc/lj/pE7n1YpSY9MF++
	l6yXlVy8urdAKGUKAYjeRP/k3qZVpjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761573400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIeIX1/GfDr+PgyE+6keWOlaywVCkkDhuvCBLGIQkjk=;
	b=buInvN6u02YGaAWTrVv2bmsTWV0J4zrRKFc7h2f43S8FkaJ1xi2XImub14diqk0DM0Cfe/
	2JuLCmtx1z16oXCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JZnsBY5q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=buInvN6u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761573400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIeIX1/GfDr+PgyE+6keWOlaywVCkkDhuvCBLGIQkjk=;
	b=JZnsBY5qPwthR5hhTqYWrvQ/1mdrWii+uV53ENK75DAwpaEmMVkY1w7ma9zUR4EfrKgGya
	1OrddNE4houLjN+9NGiRv9Ozd+8+MPUs0gH+ZJvybrkKGQNKF9vc/lj/pE7n1YpSY9MF++
	l6yXlVy8urdAKGUKAYjeRP/k3qZVpjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761573400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIeIX1/GfDr+PgyE+6keWOlaywVCkkDhuvCBLGIQkjk=;
	b=buInvN6u02YGaAWTrVv2bmsTWV0J4zrRKFc7h2f43S8FkaJ1xi2XImub14diqk0DM0Cfe/
	2JuLCmtx1z16oXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59550136CF;
	Mon, 27 Oct 2025 13:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R598FRd6/2jGbAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 27 Oct 2025 13:56:39 +0000
Message-ID: <ce78da49-2525-44af-9cb8-301bf6a4658a@suse.cz>
Date: Mon, 27 Oct 2025 14:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 09/37] KVM: guest_memfd: Skip LRU for guest_memfd
 folios
Content-Language: en-US
To: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
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
 <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 013E6219EE
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
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,alien8.de,kernel.org,intel.com,lwn.net,redhat.com,google.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,ziepe.ca,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLit8ednp7j3q8s7mp5dsi7bwe)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Spam-Score: -3.01

On 10/17/25 22:11, Ackerley Tng wrote:
> filemap_add_folio(), called from filemap_grab_folio(), adds folios to
> an LRU list. This is unnecessary for guest_memfd, which does not
> participate in swapping.

IIRC guest_memfd mappings are unevictable. That should mean they are not
ultimately added to a list (see lruvec_add_folio()).

> In addition, the LRU list takes a reference count on the folio. With

IIUC the refcount is temporary while being on the percpu
&cpu_fbatches.lru_add, added by __folio_batch_add_and_move(). When flushed
via folio_batch_move_lru(), the refcount is removed and there's only the LRU
folio flag that remains. The fbatch flushing can be triggered if you see an
unexpected refcount increase. So it might be feasible to do without this
patch (maybe it was already tried and there were substantial issues, in
which case should be mentioned).

> shared-to-private memory conversions for KVM guests dependent on folio
> refcounts, this extra reference can cause conversions to fail due to
> unexpected refcounts.
> 
> Rework kvm_gmem_get_folio() to manually allocate and insert the folio
> into the page cache without placing it on the LRU. This is done by
> calling __filemap_add_folio() directly.
> 
> The folio is then marked unevictable to avoid participation in
> swapping. The ->free_folio() handler is modified to unset the
> unevictable flag when the folio is released from guest_memfd.
> 
> This change ensures that LRU lists no longer take refcounts on
> guest_memfd folios, significantly reducing the chance of elevated
> refcounts during conversion.
> 
> To facilitate this, __filemap_add_folio is exported for KVM's use.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  mm/filemap.c           |  1 +
>  mm/memcontrol.c        |  2 ++
>  virt/kvm/guest_memfd.c | 60 +++++++++++++++++++++++++++++++++---------
>  3 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 03f223be575ca..60c7c95bbd7e6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -954,6 +954,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  	return xas_error(&xas);
>  }
>  ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
> +EXPORT_SYMBOL_FOR_MODULES(__filemap_add_folio, "kvm");
>  
>  int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  				pgoff_t index, gfp_t gfp)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dd7fbed5a942..fe8629414d0a9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4721,6 +4721,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(__mem_cgroup_charge, "kvm");
>  
>  /**
>   * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
> @@ -4893,6 +4894,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>  	uncharge_folio(folio, &ug);
>  	uncharge_batch(&ug);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(__mem_cgroup_uncharge, "kvm");
>  
>  void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
>  {
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2a9e9220a48aa..dab2b3ce78bc8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -148,6 +148,41 @@ static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
>  #endif
>  }
>  
> +static struct folio *__kvm_gmem_get_folio(struct address_space *mapping,
> +					  pgoff_t index,
> +					  struct mempolicy *policy)
> +{
> +	const gfp_t gfp = mapping_gfp_mask(mapping);
> +	struct folio *folio;
> +	int err;
> +
> +	folio = filemap_lock_folio(mapping, index);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	folio = filemap_alloc_folio(gfp, 0, policy);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = mem_cgroup_charge(folio, NULL, gfp);
> +	if (err)
> +		goto err_put;
> +
> +	__folio_set_locked(folio);
> +
> +	err = __filemap_add_folio(mapping, folio, index, gfp, NULL);
> +	if (err) {
> +		__folio_clear_locked(folio);
> +		goto err_put;
> +	}
> +
> +	return folio;
> +
> +err_put:
> +	folio_put(folio);
> +	return ERR_PTR(err);
> +}
> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -160,6 +195,7 @@ static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> +	struct address_space *mapping = inode->i_mapping;
>  	struct mempolicy *policy;
>  	struct folio *folio;
>  
> @@ -167,16 +203,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	 * Fast-path: See if folio is already present in mapping to avoid
>  	 * policy_lookup.
>  	 */
> -	folio = filemap_lock_folio(inode->i_mapping, index);
> +	folio = filemap_lock_folio(mapping, index);
>  	if (!IS_ERR(folio))
>  		return folio;
>  
>  	policy = kvm_gmem_get_folio_policy(GMEM_I(inode), index);
> -	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> -					 FGP_LOCK | FGP_CREAT,
> -					 mapping_gfp_mask(inode->i_mapping), policy);
> -	mpol_cond_put(policy);
>  
> +	do {
> +		folio = __kvm_gmem_get_folio(mapping, index, policy);
> +	} while (IS_ERR(folio) && PTR_ERR(folio) == -EEXIST);
> +
> +	mpol_cond_put(policy);
>  	return folio;
>  }
>  
> @@ -588,24 +625,21 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  	return MF_DELAYED;
>  }
>  
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -	struct page *page = folio_page(folio, 0);
> -	kvm_pfn_t pfn = page_to_pfn(page);
> -	int order = folio_order(folio);
> +	folio_clear_unevictable(folio);
>  
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> -}
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +	kvm_arch_gmem_invalidate(folio_pfn(folio),
> +				 folio_pfn(folio) + folio_nr_pages(folio));
>  #endif
> +}
>  
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  	.error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	.free_folio = kvm_gmem_free_folio,
> -#endif
>  };
>  
>  static int kvm_gmem_setattr(struct mnt_idmap *idmap, struct dentry *dentry,


