Return-Path: <linux-fsdevel+bounces-50776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFDACF7A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95DE3AFD12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF427C864;
	Thu,  5 Jun 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtcsWEeC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101C2798EA
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749150613; cv=none; b=XwL++AROr/rSdXjlENSK0Qg2HgseZjfXklV3txgOdCbGOuPTyPpF91bfclyacQNaA+nVROpPMiilg2l40iun5MBZwizZmlIXweLxk/loehm3N0+j+apq/IUSPjubCPzXyP9YbGayBLxMO98qtNpxng3trD66E3JK0/s0RSeZPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749150613; c=relaxed/simple;
	bh=8gf0qUcbhq07ZHPc9LwsEHzm1CGw9PUN6pUqovvVc9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YUbLQn68pMKfHK7YeHfisvefdjIIG/89dQOzdc20/ZqgWWS0MrxvChDZ9lkL25etGkd4i9NQbgczC7+1Aacygao5MjHMgRj6h3ETEKoonpvviHQXi7cOK6JL0crAswV/Ghq9coaAlVtHHGmXy+Kb8w8/6r1OYMyrK40mo2oqsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtcsWEeC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so1363784a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749150610; x=1749755410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjNHQkrozoEk7wT4tVqIYEicLqYUUYc18Y54oROkfGA=;
        b=BtcsWEeCyvy51tmNNnob2OzO8vR1GLCU2jrtQFXM65WG2udpwFwE2KHVf4VFEG+aIa
         B+mHBS02O93Cr1hJfDiCBWlywP1O7nfJYII+VqtGfYDNAFWWO9cGXNqj+NK6v1/55zHe
         f9EzN2jW5UWcse5HF4+jB8Ya/PR+8b1tyVoZZ6oWoEibDb95VxyRjctFbxHSfkivKP2/
         pCZ1sO+ozXf1JbN+Fhs2YXGL0mwkYmyznwKuUeKIV3fHqtx50vpOJLxhmhcjCKRXfnzW
         sVstB6SzZjfJcpUKcdg9sfBOoi4cfn63UUhTmPu456NF++vF1M5lIQsBiiMfZBpSYKvE
         n7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749150610; x=1749755410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjNHQkrozoEk7wT4tVqIYEicLqYUUYc18Y54oROkfGA=;
        b=WfMar3+14oi/CiibPXo17qCm1YJlbU4HSdAP/ZWw3wtOG+JKplGmCaYMsGOCIGNNSP
         6BnJJvJ/1GCboHsKfHDLli27o/7t7zSXIFlMoIFyTg0yDjTIu3SskpjJF5b/k69TgKsF
         9OlskHVcFL3WLLAHTSWVA2PylzYv2OHeW7EGC/xJdOK/wSW1t5w3DtVeuN+fateP/n4W
         nbvoXwdtQ7hpOpsVfWgIOG9/zY+eVbZtO+0Jj3ysT2h3bfW3DNhG+ntOx6i8tV4fQKBH
         IygmWnhN3LwFH2ca4jLVjoVSCZ6k2osFodAZosz0vsq19DE3/dR3S5tHh0Zp+8e9Jms4
         e0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVei6dRunwkGnxnrdQuR368Kx/QHJs23N33/1ti324TymTUMYUH+lKBFN83PNINiQedB1kqb36y/wMtUlp4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi++LB3MSC7Ra+oTZK8C/dchEY8hKDd+W/eMQsTkBlBwC6HZmI
	oWTgpD2x7Wz1BIuS0YV/vPrX1Lr8aQWBc5A5AFbkSSoOf/23MYnQ94inbK22977l+1L47wb26tS
	aL75EVwE+JbgOIFt/vSTCD5m8tA==
X-Google-Smtp-Source: AGHT+IFnhG2YRphukgOvoQL4/6YO64uBmqe4RoJYJKWTqXdR6Q02e+Ak2PxwVOn1uZe9hOdMItX6imdxj2tL8shi7Q==
X-Received: from pfud19.prod.google.com ([2002:a05:6a00:10d3:b0:747:b682:5cc0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7484:b0:201:85f4:ade6 with SMTP id adf61e73a8af0-21ee68997bcmr454718637.27.1749150610013;
 Thu, 05 Jun 2025 12:10:10 -0700 (PDT)
Date: Thu, 05 Jun 2025 12:10:08 -0700
In-Reply-To: <aDV7vZ72S+uJDgmn@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <aDV7vZ72S+uJDgmn@yzhao56-desk.sh.intel.com>
Message-ID: <diqztt4uhunj.fsf@ackerleytng-ctop.c.googlers.com>
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

Hi Yan,

Thanks for your thorough reviews and your alternative suggestion in the
other discussion at [1]! I'll try to bring the conversion-related parts
of that discussion over here.

>>  static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>>  				  size_t nr_pages, bool shared,
>>  				  pgoff_t *error_index)

The guiding principle I was using for the conversion ioctls is

* Have the shareability updates and any necessary page restructuring
  (aka splitting/merging) either fully complete for not at all by the
  time the conversion ioctl returns.
* Any unmapping (from host or guest page tables) will not be re-mapped
  on errors.
* Rollback undoes changes if conversion failed, and in those cases any
  errors are turned into WARNings.

The rationale is that we want page sizes to be in sync with shareability
so that any faults after the (successful or failed) conversion will not
wrongly map in a larger page than allowed and cause any host crashes.

We considered 3 places where the memory can be mapped for conversions:

1. Host page tables
2. Guest page tables
3. IOMMU page tables

Unmapping from host page tables is the simplest case. We unmap any
shared ranges from the host page tables. Any accesses after the failed
conversion would just fault the memory back in and proceed as usual.

guest_memfd memory is not unmapped from IOMMUs in conversions. This case
is handled because IOMMU mappings hold refcounts. After unmapping from
the host, we check for unexpected refcounts and fail if there are
unexpected refcounts.

We also unmap from guest page tables. Considering failed conversions, if
the pages are shared, we're good since the next time the guest accesses
the page, the page will be faulted in as before.

If the pages are private, on the next guest access, the pages will be
faulted in again as well. This is fine for software-protected VMs IIUC.

For TDX (and SNP) IIUC the memory would have been cleared, and the
memory would also need to be re-accepted. I was thinking that this is by
design, since when a TDX guest requests a conversion it knows that the
contents is not to be used again.

The userspace VMM is obligated to keep trying convert and if it gives
up, userspace VMM should inform the guest that the conversion
failed. The guest should handle conversion failures too and not assume
that conversion always succeeds.

Putting TDX aside for a moment, so far, there are a few ways this
conversion could fail:

a. Unexpected refcounts. Userspace should clear up the unexpected
   refcounts and report failure to the guest if it can't for whatever
   reason.
b. ENOMEM because (i) we ran out of memory updating the shareability
   maple_tree or (ii) since splitting involves allocating more memory
   for struct pages and we ran out of memory there. In this case the
   userspace VMM gets -ENOMEM and can make more memory available and
   then retry, or if it can't, also report failure to the guest.

TDX introduces TDX-specific conversion failures (see discussion at
[1]), which this series doesn't handle, but I think we still have a line
of sight to handle new errors.

In the other thread [1], I was proposing to have guest_memfd decide what
to do on errors, but I think that might be baking more TDX-specific
details into guest_memfd/KVM, and perhaps this is better:

We could return the errors to userspace and let userspace determine what
to do. For retryable errors (as determined by userspace), it should do
what it needs to do, and retry. For errors like TDX being unable to
reclaim the memory, it could tell guest_memfd to leak that memory.

If userspace gives up, it should report conversion failure to the guest
if userspace thinks the guest can continue (to a clean shutdown or
otherwise). If something terrible happened during conversion, then
userspace might have to exit itself or shutdown the host.

In [2], for TDX-specific conversion failures, you proposed prepping to
eliminate errors and exiting early on failure, then actually
unmapping. I think that could work too.

I'm a little concerned that prepping could be complicated, since the
nature of conversion depends on the current state of shareability, and
there's a lot to prepare, everything from counting memory required for
maple_tree allocation (and merging ranges in the maple_tree), and
counting the number of pages required for undoing vmemmap optimization
in the case of splitting...

And even after doing all the prep to eliminate errors, the unmapping
could fail in TDX-specific cases anyway, which still needs to be
handled.

Hence I'm hoping you'll consider to let TDX-specific failures be
built-in and handled alongside other failures by getting help from the
userspace VMM, and in the worst case letting the guest know the
conversion failed.

I also appreciate comments or suggestions from anyone else!

[1] https://lore.kernel.org/all/diqzfrgfp95d.fsf@ackerleytng-ctop.c.googlers.com/
[2] https://lore.kernel.org/all/aEEEJbTzlncbRaRA@yzhao56-desk.sh.intel.com/

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
> Could kvm_gmem_shareability_apply() fail here?
>

Yes, it could. If shareability cannot be updated, then we probably ran
out of memory. Userspace VMM will probably get -ENOMEM set on some
earlier ret and should handle that accordingly.

On -ENOMEM in a rollback, the host is in a very tough spot anyway, and a
clean guest shutdown may be the only way out, hence this is a WARN and
not returned to userspace.

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
> Why does the failure of __kvm_gmem_filemap_add_folio() here lead to rollback,    
> while the failure of the one under rollback only triggers WARN_ON()?
>

Mostly because I don't really have a choice on rollback. On rollback we
try to restore the merged folio back into the filemap, and if we
couldn't, the host is probably in rather bad shape in terms of memory
availability and there may not be many options for the userspace VMM.

Perhaps the different possible errors from
__kvm_gmem_filemap_add_folio() in both should be handled differently. Do
you have any suggestions on that?

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
> guestmem_hugetlb_split_folio() is possible to fail. e.g.
> After the stash is freed by guestmem_hugetlb_unstash_free_metadata() in
> guestmem_hugetlb_merge_folio(), it's possible to get -ENOMEM for the stash
> allocation in guestmem_hugetlb_stash_metadata() in
> guestmem_hugetlb_split_folio().
>
>

Yes. This is also on the error path. In line with all the other error
and rollback paths, I don't really have other options at this point,
since on error, I probably ran out of memory, so I try my best to
restore the original state but give up with a WARN otherwise.

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
> kvm_gmem_try_split_folio_in_filemap()?
>

Here we know for sure that this was a private-to-shared
conversion. Hence, we know that there are at least some shared parts in
this huge page and we can skip checking that. 

>> +		else
>> +			ret = kvm_gmem_try_merge_folio_in_filemap(inode, f);
>> +

For merge, we don't know if the entire huge page might perhaps contain
some other shared subpages, hence we "try" to merge by first checking
against shareability to find shared subpages.

>> +		if (ret)
>> +			goto rollback;
>> +	}
>> +	return ret;
>> +
>> +rollback:
>> +	for (index -= to_nr_pages; index >= start; index -= to_nr_pages) {

Note to self: the first index -= to_nr_pages was meant to skip the index
that caused the failure, but this could cause an underflow if index = 0
when entering rollback. Need to fix this in the next revision.

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
> Is it safe to just leave WARN_ON()s in the rollback case?
>

Same as above. I don't think we have much of a choice.

> Besides, are the kvm_gmem_merge_folio_in_filemap() and
> kvm_gmem_split_folio_in_filemap() here duplicated with the
> kvm_gmem_split_folio_in_filemap() and kvm_gmem_try_merge_folio_in_filemap() in
> the following "r = kvm_gmem_convert_execute_work(inode, work, !shared)"?
>

This handles the case where some pages in the range [start, start +
nr_pages) were split and the failure was halfway through. I could call
kvm_gmem_convert_execute_work() with !shared but that would go over all
the folios again from the start.

>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +#else
>> +
>> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
>> +						      struct folio *folio)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>> +						pgoff_t start, size_t nr_pages,
>> +						bool is_split_operation)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>  

