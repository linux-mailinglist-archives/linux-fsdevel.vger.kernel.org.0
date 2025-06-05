Return-Path: <linux-fsdevel+bounces-50771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E18ACF5B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3421189ABCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D327A13D;
	Thu,  5 Jun 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01L2N+HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F30278153
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145817; cv=none; b=I2vHM3Ja9qN4M4c4Os+iybuCxqBL4nFC8iNc7s0dEcWVAYtTFsuAV9IeGZ5zUh7HGHWHMM8xeS5o8u41UP1dYyAPSERkrHl1DmHMzui8B6DQ1ZowRu+X4z4Q2l+RRx2xzHyQYrz+yQ4cMC1MyYv40z/z+MonWaOteKJxiQrvksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145817; c=relaxed/simple;
	bh=iHQF4Dourp1B1nMiwyaRmIVLvNsBf3nWKP7wfNzjNHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZPngZDXIY9dJryJBzSQghU3vKzgvZ2E92TuLIKgJFkoU7OesR4U8gZCojM0x05OFkz2F6d8T4AQbGvk0C7X6/x5nF94ilJ1KCd3mvbUn7ZfVtOA6ZVf7VDThpcflvsJ1/9NgbWtwtv8MfbEF2c8UdzYoiB8RchP/3QTC49aZJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01L2N+HS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3122368d82bso1907653a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749145814; x=1749750614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hu5vz5+P98piBMEjaLWv8oEfWhjCynYV2VVURu/d67g=;
        b=01L2N+HS03dAIGmCDJxyRPP2Vi2xouDjtebTQkGLY2tfCdDu9W0aLeEfvHe/0lShWP
         jZ0pbl6mzJA4RGl+atsayeFmttW7lGiY3oKWwYH9FHUWKH4/QWPdETbsgrAT2GejWknN
         5pbBNnEBuJvnz+hOYIRBc/xuvw/Mpl9qy0rSOEbISRFa195x+h3kdsEV7Je9GIRJCw0q
         r1R8IMWP2Onyf1ZFrTYTaty1SM9xgRuaZRbX/MVp/5IYCPRGVpLg8TtBC9fJAeKbRT/C
         /RRZnowU0P8++IgpWqvVTSKhnGP4Xz1mhdN6R1SsIThjS4W2GmO1iRMYh0CXpZn/nlOG
         JlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145814; x=1749750614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu5vz5+P98piBMEjaLWv8oEfWhjCynYV2VVURu/d67g=;
        b=cVvFOIex+RcfuC+7HlwVHwZGs9JgHP7PHjkTMEBTK3dxxy8bsTG6AbdU2KvDNrbrHe
         GnYmD+Ql9VO4b2xUVOBpCQI9xhhNqa7S3sVfKfJHYOafLyfrozwp+h4nBJOCy2Y88b9t
         /jKSutitet5GirjkeetQhnqhvAIiRtF4mLJxZHHZookq/r/XcEEVV4PJz8n5KGi2jxcA
         Jy+wNeFXrsAHTmh4oyxQq+Hr9LjQd9FQ/EkY/uVxBKoPbk7oHhPmyLH2Z8C384v6YolD
         8DE+XVIoqmujBO7POpyZFlkaowT8TYI+8i+CrsHhLVSS00CrtEm1XHOhDTcPL+X7Scuk
         CZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoWK9ELtLMZq6amn4iqZqt5Gkw/Av2hnAEpYWy8pc0/aNBa2bpkUc6fr+rBtmYae4J6kbMm/z530a1UltW@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZ4j9+x8sWAl0PcbRexO4tODZuCSCINhahdpNyfZTATRYh7l0
	dGWgk+8Ag89xKjZBld44+J+qr63PDtx5V0uVNgDNUWSs5fR7M3Fs0jKT+ZU3AyTo/dOdpP3kg0M
	qfK3S9MXPnylc10M4htH7f5cfWA==
X-Google-Smtp-Source: AGHT+IHK6zVUSY7vSWVpyGjXKfRpbP1oaw/sp3io8k5QV/4JgWT1gfwkZ+HsH1HbzqeLOACNzC0fcp9+sUgYbJaoAA==
X-Received: from pjbmd8.prod.google.com ([2002:a17:90b:23c8:b0:313:274d:3007])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3950:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-31347682102mr644405a91.22.1749145813894;
 Thu, 05 Jun 2025 10:50:13 -0700 (PDT)
Date: Thu, 05 Jun 2025 10:50:12 -0700
In-Reply-To: <aDU/0+XLZKv5kae7@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <aDU/0+XLZKv5kae7@yzhao56-desk.sh.intel.com>
Message-ID: <diqzy0u6hycr.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, May 14, 2025 at 04:42:17PM -0700, Ackerley Tng wrote:

[...]

>> +static pgoff_t kvm_gmem_compute_invalidate_bound(struct inode *inode,
>> +						 pgoff_t bound, bool start)
>> +{
>> +	size_t nr_pages;
>> +	void *priv;
>> +
>> +	if (!kvm_gmem_has_custom_allocator(inode))
>> +		return bound;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +
>> +	if (start)
>> +		return round_down(bound, nr_pages);
>> +	else
>> +		return round_up(bound, nr_pages);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_start(struct inode *inode,
>> +						 pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, true);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_end(struct inode *inode,
>> +					       pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, false);
>> +}
>> +
>>  static int kvm_gmem_shareability_apply(struct inode *inode,
>>  				       struct conversion_work *work,
>>  				       enum shareability m)
>> @@ -299,35 +428,53 @@ static void kvm_gmem_convert_invalidate_begin(struct inode *inode,
>>  					      struct conversion_work *work)
>>  {
>>  	struct list_head *gmem_list;
>> +	pgoff_t invalidate_start;
>> +	pgoff_t invalidate_end;
>>  	struct kvm_gmem *gmem;
>> -	pgoff_t end;
>> +	pgoff_t work_end;
>>  
>> -	end = work->start + work->nr_pages;
>> +	work_end = work->start + work->nr_pages;
>> +	invalidate_start = kvm_gmem_compute_invalidate_start(inode, work->start);
>> +	invalidate_end = kvm_gmem_compute_invalidate_end(inode, work_end);

The invalidation range is broadened to include the full range to take
care of this race [1] reported for the conversion flow that uses
KVM_SET_MEMORY_ATTRIBUTES ioctl, so I also repeated the broadening for
this guest_memfd conversion ioctl.

> Could we just notify the exact gfn range and let KVM adjust the invalidate
> range?
>

How do we get KVM to adjust the invalidate range?

> Then kvm_gmem_invalidate_begin() can asks KVM to do EPT splitting before any
> kvm_mmu_unmap_gfn_range() is performed.
>
>

In this snapshot of my WIP of putting this HugeTLB support with TDX huge
page EPT support [2], I was thinking to combine EPT splitting together
with unmap, and leaving the invalidate to be a separate part. (See
kvm_gmem_unmap_private().) I did it this way so that the EPT splitting
is range is the unmapping range, and only the invalidation range is
broadened.

What do you think of that?

>>  	gmem_list = &inode->i_mapping->i_private_list;
>>  	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_begin(gmem, work->start, end);
>> +		kvm_gmem_invalidate_begin(gmem, invalidate_start, invalidate_end);
>>  }
>>  
>>  static void kvm_gmem_convert_invalidate_end(struct inode *inode,
>>  					    struct conversion_work *work)
>>  {
>>  	struct list_head *gmem_list;
>> +	pgoff_t invalidate_start;
>> +	pgoff_t invalidate_end;
>>  	struct kvm_gmem *gmem;
>> -	pgoff_t end;
>> +	pgoff_t work_end;
>>  
>> -	end = work->start + work->nr_pages;
>> +	work_end = work->start + work->nr_pages;
>> +	invalidate_start = kvm_gmem_compute_invalidate_start(inode, work->start);
>> +	invalidate_end = kvm_gmem_compute_invalidate_end(inode, work_end);
>>  
>>  	gmem_list = &inode->i_mapping->i_private_list;
>>  	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_end(gmem, work->start, end);
>> +		kvm_gmem_invalidate_end(gmem, invalidate_start, invalidate_end);
>>  }
>>  
>>  static int kvm_gmem_convert_should_proceed(struct inode *inode,
>>  					   struct conversion_work *work,
>>  					   bool to_shared, pgoff_t *error_index)
>>  {
>> -	if (!to_shared) {
>> +	if (to_shared) {
>> +		struct list_head *gmem_list;
>> +		struct kvm_gmem *gmem;
>> +		pgoff_t work_end;
>> +
>> +		work_end = work->start + work->nr_pages;
>> +
>> +		gmem_list = &inode->i_mapping->i_private_list;
>> +		list_for_each_entry(gmem, gmem_list, entry)
>> +			kvm_gmem_unmap_private(gmem, work->start, work_end);
>> +	} else {
>>  		unmap_mapping_pages(inode->i_mapping, work->start,
>>  				    work->nr_pages, false);
>>  
>> @@ -340,6 +487,27 @@ static int kvm_gmem_convert_should_proceed(struct inode *inode,
>>  	return 0;
>>  }
>>  
>> +static int kvm_gmem_convert_execute_work(struct inode *inode,
>> +					 struct conversion_work *work,
>> +					 bool to_shared)
>> +{
>> +	enum shareability m;
>> +	int ret;
>> +
>> +	m = to_shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
>> +	ret = kvm_gmem_shareability_apply(inode, work, m);
>> +	if (ret)
>> +		return ret;
>> +	/*
>> +	 * Apply shareability first so split/merge can operate on new
>> +	 * shareability state.
>> +	 */
>> +	ret = kvm_gmem_restructure_folios_in_range(
>> +		inode, work->start, work->nr_pages, to_shared);
>> +
>> +	return ret;
>> +}
>> +
>>  static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>>  				  size_t nr_pages, bool shared,
>>  				  pgoff_t *error_index)
>> @@ -371,18 +539,21 @@ static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>>  
>>  	list_for_each_entry(work, &work_list, list) {
>>  		rollback_stop_item = work;
>> -		ret = kvm_gmem_shareability_apply(inode, work, m);
>> +
>> +		ret = kvm_gmem_convert_execute_work(inode, work, shared);
>>  		if (ret)
>>  			break;
>>  	}
>>  
>>  	if (ret) {
>> -		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
>>  		list_for_each_entry(work, &work_list, list) {
>> +			int r;
>> +
>> +			r = kvm_gmem_convert_execute_work(inode, work, !shared);
>> +			WARN_ON(r);
>> +
>>  			if (work == rollback_stop_item)
>>  				break;
>> -
>> -			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
>>  		}
>>  	}
>>  
>> @@ -434,6 +605,277 @@ static int kvm_gmem_ioctl_convert_range(struct file *file,
>>  	return ret;
>>  }
>>  
>> +#ifdef CONFIG_KVM_GMEM_HUGETLB
>> +
>> +static inline void __filemap_remove_folio_for_restructuring(struct folio *folio)
>> +{
>> +	struct address_space *mapping = folio->mapping;
>> +
>> +	spin_lock(&mapping->host->i_lock);
>> +	xa_lock_irq(&mapping->i_pages);
>> +
>> +	__filemap_remove_folio(folio, NULL);
>> +
>> +	xa_unlock_irq(&mapping->i_pages);
>> +	spin_unlock(&mapping->host->i_lock);
>> +}
>> +
>> +/**
>> + * filemap_remove_folio_for_restructuring() - Remove @folio from filemap for
>> + * split/merge.
>> + *
>> + * @folio: the folio to be removed.
>> + *
>> + * Similar to filemap_remove_folio(), but skips LRU-related calls (meaningless
>> + * for guest_memfd), and skips call to ->free_folio() to maintain folio flags.
>> + *
>> + * Context: Expects only the filemap's refcounts to be left on the folio. Will
>> + *          freeze these refcounts away so that no other users will interfere
>> + *          with restructuring.
>> + */
>> +static inline void filemap_remove_folio_for_restructuring(struct folio *folio)
>> +{
>> +	int filemap_refcount;
>> +
>> +	filemap_refcount = folio_nr_pages(folio);
>> +	while (!folio_ref_freeze(folio, filemap_refcount)) {
>> +		/*
>> +		 * At this point only filemap refcounts are expected, hence okay
>> +		 * to spin until speculative refcounts go away.
>> +		 */
>> +		WARN_ONCE(1, "Spinning on folio=%p refcount=%d", folio, folio_ref_count(folio));
>> +	}
>> +
>> +	folio_lock(folio);
>> +	__filemap_remove_folio_for_restructuring(folio);
>> +	folio_unlock(folio);
>> +}
>> +
>> +/**
>> + * kvm_gmem_split_folio_in_filemap() - Split @folio within filemap in @inode.
>> + *
>> + * @inode: inode containing the folio.
>> + * @folio: folio to be split.
>> + *
>> + * Split a folio into folios of size PAGE_SIZE. Will clean up folio from filemap
>> + * and add back the split folios.
>> + *
>> + * Context: Expects that before this call, folio's refcount is just the
>> + *          filemap's refcounts. After this function returns, the split folios'
>> + *          refcounts will also be filemap's refcounts.
>> + * Return: 0 on success or negative error otherwise.
>> + */
>> +static int kvm_gmem_split_folio_in_filemap(struct inode *inode, struct folio *folio)
>> +{
>> +	size_t orig_nr_pages;
>> +	pgoff_t orig_index;
>> +	size_t i, j;
>> +	int ret;
>> +
>> +	orig_nr_pages = folio_nr_pages(folio);
>> +	if (orig_nr_pages == 1)
>> +		return 0;
>> +
>> +	orig_index = folio->index;
>> +
>> +	filemap_remove_folio_for_restructuring(folio);
>> +
>> +	ret = kvm_gmem_allocator_ops(inode)->split_folio(folio);
>> +	if (ret)
>> +		goto err;
>> +
>> +	for (i = 0; i < orig_nr_pages; ++i) {
>> +		struct folio *f = page_folio(folio_page(folio, i));
>> +
>> +		ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, f,
>> +						   orig_index + i);
>> +		if (ret)
>> +			goto rollback;
>> +	}
>> +
>> +	return ret;
>> +
>> +rollback:
>> +	for (j = 0; j < i; ++j) {
>> +		struct folio *f = page_folio(folio_page(folio, j));
>> +
>> +		filemap_remove_folio_for_restructuring(f);
>> +	}
>> +
>> +	kvm_gmem_allocator_ops(inode)->merge_folio(folio);
>> +err:
>> +	WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, folio, orig_index));
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
>> +						      struct folio *folio)
>> +{
>> +	size_t to_nr_pages;
>> +	void *priv;
>> +
>> +	if (!kvm_gmem_has_custom_allocator(inode))
>> +		return 0;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
>> +
>> +	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))
> If the guest_memfd is configured with GUESTMEM_HUGETLB_FLAG_1GB, it seems that
> whenever there's a shared page within a 1GB range, the folio will always be
> split into 4KB folios. Is it good?
>

It is not the best, but okay as an initial step.

We want to work on splitting 1G to 2M (as many 2M pages as possible)
then to 4K. I believe the agreement with the community is that the
1G->2M->4K splitting is an optimization for the patch series after this
one.

>> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * kvm_gmem_merge_folio_in_filemap() - Merge @first_folio within filemap in
>> + * @inode.
>> + *
>> + * @inode: inode containing the folio.
>> + * @first_folio: first folio among folios to be merged.
>> + *
>> + * Will clean up subfolios from filemap and add back the merged folio.
>> + *
>> + * Context: Expects that before this call, all subfolios only have filemap
>> + *          refcounts. After this function returns, the merged folio will only
>> + *          have filemap refcounts.
>> + * Return: 0 on success or negative error otherwise.
>> + */
>> +static int kvm_gmem_merge_folio_in_filemap(struct inode *inode,
>> +					   struct folio *first_folio)
>> +{
>> +	size_t to_nr_pages;
>> +	pgoff_t index;
>> +	void *priv;
>> +	size_t i;
>> +	int ret;
>> +
>> +	index = first_folio->index;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +	if (folio_nr_pages(first_folio) == to_nr_pages)
>> +		return 0;
>> +
>> +	for (i = 0; i < to_nr_pages; ++i) {
>> +		struct folio *f = page_folio(folio_page(first_folio, i));
>> +
>> +		filemap_remove_folio_for_restructuring(f);
>> +	}
>> +
>> +	kvm_gmem_allocator_ops(inode)->merge_folio(first_folio);
>> +
>> +	ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, first_folio, index);
>> +	if (ret)
>> +		goto err_split;
>> +
>> +	return ret;
>> +
>> +err_split:
>> +	WARN_ON(kvm_gmem_allocator_ops(inode)->split_folio(first_folio));
>> +	for (i = 0; i < to_nr_pages; ++i) {
>> +		struct folio *f = page_folio(folio_page(first_folio, i));
>> +
>> +		WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, f, index + i));
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int kvm_gmem_try_merge_folio_in_filemap(struct inode *inode,
>> +						      struct folio *first_folio)
>> +{
>> +	size_t to_nr_pages;
>> +	void *priv;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +
>> +	if (kvm_gmem_has_some_shared(inode, first_folio->index, to_nr_pages))
>> +		return 0;
>> +
>> +	return kvm_gmem_merge_folio_in_filemap(inode, first_folio);
>> +}
>> +
>> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>> +						pgoff_t start, size_t nr_pages,
>> +						bool is_split_operation)
>> +{
>> +	size_t to_nr_pages;
>> +	pgoff_t index;
>> +	pgoff_t end;
>> +	void *priv;
>> +	int ret;
>> +
>> +	if (!kvm_gmem_has_custom_allocator(inode))
>> +		return 0;
>> +
>> +	end = start + nr_pages;
>> +
>> +	/* Round to allocator page size, to check all (huge) pages in range. */
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +
>> +	start = round_down(start, to_nr_pages);
>> +	end = round_up(end, to_nr_pages);
>> +
>> +	for (index = start; index < end; index += to_nr_pages) {
>> +		struct folio *f;
>> +
>> +		f = filemap_get_folio(inode->i_mapping, index);
>> +		if (IS_ERR(f))
>> +			continue;
>> +
>> +		/* Leave just filemap's refcounts on the folio. */
>> +		folio_put(f);
>> +
>> +		if (is_split_operation)
>> +			ret = kvm_gmem_split_folio_in_filemap(inode, f);
> The split operation is performed after kvm_gmem_unmap_private() within
> kvm_gmem_convert_should_proceed(), right?
>
> So, it seems that that it's not necessary for TDX to avoid holding private page
> references, as TDX must have released the page refs after
> kvm_gmem_unmap_private() (except when there's TDX module or KVM bug).
>

I agree with your assessment in the follow up email.

We don't want to unmap more than the requested conversion range to avoid
extra churn. If TDX holds refcounts on mapped pages, the subpages that
are still mapped will contribute to the refcount of the huge page, and
we can't split a page that has refcounts because we don't know how the
refcounts are distributed over the subpages.

I guess technically if the refcounts are divisible across nr_pages, we
could still split, but if we have a 1G page, but only some of the 1G
subpages are mapped into TDX EPTs, then we would have a refcount that we
don't know how to divide out.

>> +		else
>> +			ret = kvm_gmem_try_merge_folio_in_filemap(inode, f);
>> +
>> +		if (ret)
>> +			goto rollback;
>> +	}
>> +	return ret;
>> +
>> +rollback:
>> +	for (index -= to_nr_pages; index >= start; index -= to_nr_pages) {
>> +		struct folio *f;
>> +
>> +		f = filemap_get_folio(inode->i_mapping, index);
>> +		if (IS_ERR(f))
>> +			continue;
>> +
>> +		/* Leave just filemap's refcounts on the folio. */
>> +		folio_put(f);
>> +
>> +		if (is_split_operation)
>> +			WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
>> +		else
>> +			WARN_ON(kvm_gmem_split_folio_in_filemap(inode, f));
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +#else
>> +

[...]

[1] https://lore.kernel.org/all/Z__AAB_EFxGFEjDR@google.com/
[2] https://github.com/googleprodkernel/linux-cc/commits/wip-tdx-gmem-conversions-hugetlb-2mept/


