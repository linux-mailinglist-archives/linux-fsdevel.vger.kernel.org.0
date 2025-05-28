Return-Path: <linux-fsdevel+bounces-49987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50BAC6E25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FE9166548
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E028DB4A;
	Wed, 28 May 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaCfKUID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B899288C19
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450380; cv=none; b=kSa47884GKuGmB6KLcMTA7c+EfvAt4EY0UclZRg5BKV0z5JAZ0w3TOV6eytgznBCDDObk707C08PknQnVcq7GrOS8ZLMvMOG9jgCQGcyZm8FReEfbLTR1mtlJE7nOXTpMH0gBeOdR1cvdRGWSuy38Z50DexniSgSC5HaLldj0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450380; c=relaxed/simple;
	bh=9ZFIKNoaGAoZluGUowCky6Ngnpz41IO5N/0CSvVPfsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZSo4lvx440EblPFzuErfdZFu6/pRVqzRpYD99635KL0GY5r6fQimFymrQl+E757gBZbcw142rH7o79AkYtGJTLQlEY7zdygqHBroqi1E06VP5LwOWTSr2pYTWo8Yd4GzU2VA1bHB7PID73xlmPJZDtCZK+5a/1NYjTVH7nTkvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaCfKUID; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2371b50cabso54199a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748450377; x=1749055177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/rSTqNkaK2DiSNfaEAiTgoamlZ5in/WoXI2qFgjt4=;
        b=EaCfKUIDMqq78MjqgxE6vs6E9C91Gx7CFpQCpGpiESrnK4wBxmJOVtUbyE1cTU1C8Z
         nBKetPvfOsnUXH+LhEcbIUaSY/e9Fd7kkQ9XeRnU+q9x9GmirTjjLz4ja6hsf3iunBpW
         uzhY1k27QVWNZnG0kyNMuI3tK8ZnnTAtgYKvih61T96IJKIGVoB/L3lqq/PNL8MekqvI
         9+cf1eIGnBJKX0NCeSv7vBGDPwhy/w5N7N3GxIHRJSC9/enQKMP/9HHCcXY1RwthE2Gc
         VdGUfEuvc0+rj/Uqhea/h1ytjdiJ6amJveLUzs5c5EURcHd0MQwHDyFLgAqURyn4Uc9U
         x5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450377; x=1749055177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/rSTqNkaK2DiSNfaEAiTgoamlZ5in/WoXI2qFgjt4=;
        b=CKz3W+sGlJBw6txK7oZVpE1c+MbZWle4QEBZ/yzFUIpK8OoL6OXGmZg7OvOspTvj+P
         5rX14UKq7Xig/ibC0DienHt80yCO/puDAif6gVzgXatYXwwdhVz2aeTwXI9uSIT1/xBv
         SSRLzz/TUpW16PcSh9213G63iEe8hW989DGWBiHLrrqEcM3EX8mGF9FUwBhBJQIpUMVV
         zJ474i5/6SGbbRZHlWvF5HrT5h10ixU/bqqMuyif3XSVADuY/fYgW+8H/uttOKEeYgce
         AVuCy+U2OGcUXy/6mtO06/SvqoDvPlt2PPcCcGeeRB6gbRQ0fPBRno1SYrJqhLBBOJM+
         pXXw==
X-Forwarded-Encrypted: i=1; AJvYcCXC2aJMqIibcT1PFgAd0Zg0Td8zfQr2bVS5lweODGx8g5VGenQPg5b45EDdyacJ4pfiI3CetIKHEhx2mOgP@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrC6U8o6Mt9GHKsZ8qSDymAZDBfGc+MVuYGE+87Q0/JZ3uvZ2
	HtlYbf9olbb7ZAQc6xo6dTyLZRi7QJm9iuXH32AcqMu15FpLZd7sHjnW/T8LpoRC8DFMQKG0JOW
	l0kVfpA+81HZBuckwef4Dkfk5Mg==
X-Google-Smtp-Source: AGHT+IFNpKZD9lN4cOQmrQeE/v6mJ+Aez5Zu8/h2NScD8jBwFV5IrxK/YzUb/E+mnOr3jMtt3fLdteDpb1Js1lKinQ==
X-Received: from plhs4.prod.google.com ([2002:a17:903:3204:b0:223:5693:a4e9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a67:b0:234:d7b2:2ac2 with SMTP id d9443c01a7336-234d7b22c20mr46594455ad.22.1748450376728;
 Wed, 28 May 2025 09:39:36 -0700 (PDT)
Date: Wed, 28 May 2025 09:39:35 -0700
In-Reply-To: <aDbswJwGRe5a4Lzf@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <625bd9c98ad4fd49d7df678f0186129226f77d7d.1747264138.git.ackerleytng@google.com>
 <aDbswJwGRe5a4Lzf@yzhao56-desk.sh.intel.com>
Message-ID: <diqz34co8zaw.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 39/51] KVM: guest_memfd: Merge and truncate on fallocate(PUNCH_HOLE)
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

> On Wed, May 14, 2025 at 04:42:18PM -0700, Ackerley Tng wrote:
>> Merge and truncate on fallocate(PUNCH_HOLE), but if the file is being
>> closed, defer merging to folio_put() callback.
>> 
>> Change-Id: Iae26987756e70c83f3b121edbc0ed0bc105eec0d
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 68 insertions(+), 8 deletions(-)
>> 
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index cb426c1dfef8..04b1513c2998 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -859,6 +859,35 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>>  	return ret;
>>  }
>>  
>> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
>> +					   size_t nr_pages)
>> +{
>> +	struct folio *f;
>> +	pgoff_t unused;
>> +	long num_freed;
>> +
>> +	unmap_mapping_pages(inode->i_mapping, index, nr_pages, false);
>> +
>> +	if (!kvm_gmem_has_safe_refcount(inode->i_mapping, index, nr_pages, &unused))

Yan, thank you for your reviews!

> Why is kvm_gmem_has_safe_refcount() checked here, but not in
> kvm_gmem_zero_range() within kvm_gmem_truncate_inode_range() in patch 33?
>

The contract for guest_memfd with HugeTLB pages is that if holes are
punched in any ranges less than a full huge page, no pages are removed
from the filemap. Those ranges are only zeroed.

In kvm_gmem_zero_range(), we never remove any folios, and so there is no
need to merge. If there's no need to merge, then we don't need to check
for a safe refcount, and can just proceed to zero.

kvm_gmem_merge_truncate_indices() is only used during hole punching and
not when the file is closed. Hole punch vs file closure is checked using
mapping_exiting(inode->i_mapping).

During a hole punch, we will only allow truncation if there are no
unexpected refcounts on any subpages, hence this
kvm_gmem_has_safe_refcount() check.

>> +		return -EAGAIN;
>> +
>
> Rather than merging the folios, could we simply call kvm_gmem_truncate_indices()
> instead?
>
> num_freed = kvm_gmem_truncate_indices(inode->i_mapping, index, nr_pages);
> return num_freed;
>

We could do this too, but then that would be deferring the huge page
merging to the folio_put() callback and eventually the kernel worker
thread.

My goal here is to try to not to defer merging and freeing as much as
possible so that most of the page/memory operations are
synchronous, because synchronous operations are more predictable.

As an example of improving predictability, in one of the selftests, I do
a hole punch and then try to allocate again. Because the merging and
freeing of the HugeTLB page sometimes takes too long, the allocation
sometimes fails: the guest_memfd's subpool hadn't yet received the freed
page back. With a synchronous truncation, the truncation may take
longer, but the selftest predictably passes.

>> +	f = filemap_get_folio(inode->i_mapping, index);
>> +	if (IS_ERR(f))
>> +		return 0;
>> +
>> +	/* Leave just filemap's refcounts on the folio. */
>> +	folio_put(f);
>> +
>> +	WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
>> +
>> +	num_freed = folio_nr_pages(f);
>> +	folio_lock(f);
>> +	truncate_inode_folio(inode->i_mapping, f);
>> +	folio_unlock(f);
>> +
>> +	return num_freed;
>> +}
>> +
>>  #else
>>  
>>  static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
>> @@ -874,6 +903,12 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>>  	return 0;
>>  }
>>  
>> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
>> +					   size_t nr_pages)
>> +{
>> +	return 0;
>> +}
>> +
>>  #endif
>>  
>>  #else
>> @@ -1182,8 +1217,10 @@ static long kvm_gmem_truncate_indices(struct address_space *mapping,
>>   *
>>   * Removes folios beginning @index for @nr_pages from filemap in @inode, updates
>>   * inode metadata.
>> + *
>> + * Return: 0 on success and negative error otherwise.
>>   */
>> -static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>> +static long kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>>  						  pgoff_t index,
>>  						  size_t nr_pages)
>>  {
>> @@ -1191,19 +1228,34 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>>  	long num_freed;
>>  	pgoff_t idx;
>>  	void *priv;
>> +	long ret;
>>  
>>  	priv = kvm_gmem_allocator_private(inode);
>>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>>  
>> +	ret = 0;
>>  	num_freed = 0;
>>  	for (idx = index; idx < index + nr_pages; idx += nr_per_huge_page) {
>> -		num_freed += kvm_gmem_truncate_indices(
>> -			inode->i_mapping, idx, nr_per_huge_page);
>> +		if (mapping_exiting(inode->i_mapping) ||
>> +		    !kvm_gmem_has_some_shared(inode, idx, nr_per_huge_page)) {
>> +			num_freed += kvm_gmem_truncate_indices(
>> +				inode->i_mapping, idx, nr_per_huge_page);
>> +		} else {
>> +			ret = kvm_gmem_merge_truncate_indices(inode, idx,
>> +							      nr_per_huge_page);
>> +			if (ret < 0)
>> +				break;
>> +
>> +			num_freed += ret;
>> +			ret = 0;
>> +		}
>>  	}
>>  
>>  	spin_lock(&inode->i_lock);
>>  	inode->i_blocks -= (num_freed << PAGE_SHIFT) / 512;
>>  	spin_unlock(&inode->i_lock);
>> +
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -1252,8 +1304,10 @@ static void kvm_gmem_zero_range(struct address_space *mapping,
>>   *
>>   * Removes full (huge)pages from the filemap and zeroing incomplete
>>   * (huge)pages. The pages in the range may be split.
>> + *
>> + * Return: 0 on success and negative error otherwise.
>>   */
>> -static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>> +static long kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>>  					  loff_t lend)
>>  {
>>  	pgoff_t full_hpage_start;
>> @@ -1263,6 +1317,7 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>>  	pgoff_t start;
>>  	pgoff_t end;
>>  	void *priv;
>> +	long ret;
>>  
>>  	priv = kvm_gmem_allocator_private(inode);
>>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> @@ -1279,10 +1334,11 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>>  		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
>>  	}
>>  
>> +	ret = 0;
>>  	if (full_hpage_end > full_hpage_start) {
>>  		nr_pages = full_hpage_end - full_hpage_start;
>> -		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
>> -						      nr_pages);
>> +		ret = kvm_gmem_truncate_inode_aligned_pages(
>> +			inode, full_hpage_start, nr_pages);
>>  	}
>>  
>>  	if (end > full_hpage_end && end > full_hpage_start) {
>> @@ -1290,6 +1346,8 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>>  
>>  		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
>>  	}
>> +
>> +	return ret;
>>  }
>>  
>>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>> @@ -1298,6 +1356,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  	pgoff_t start = offset >> PAGE_SHIFT;
>>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>>  	struct kvm_gmem *gmem;
>> +	long ret;
>>  
>>  	/*
>>  	 * Bindings must be stable across invalidation to ensure the start+end
>> @@ -1308,8 +1367,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  	list_for_each_entry(gmem, gmem_list, entry)
>>  		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
>>  
>> +	ret = 0;
>>  	if (kvm_gmem_has_custom_allocator(inode)) {
>> -		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
>> +		ret = kvm_gmem_truncate_inode_range(inode, offset, offset + len);
>>  	} else {
>>  		/* Page size is PAGE_SIZE, so use optimized truncation function. */
>>  		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
>> @@ -1320,7 +1380,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  
>>  	filemap_invalidate_unlock(inode->i_mapping);
>>  
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>> -- 
>> 2.49.0.1045.g170613ef41-goog
>> 

