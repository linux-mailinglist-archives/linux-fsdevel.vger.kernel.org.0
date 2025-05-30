Return-Path: <linux-fsdevel+bounces-50243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22DAC9664
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50CE179FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8428312B;
	Fri, 30 May 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMrPm9wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACE2367CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635814; cv=none; b=E0OC9DNNgRjtFxW+UlqP8muzCH0RGs0YWfIxUkC38yiFG2gdjU2EjAFn5f641STVwJWhA3WghMo0tu0MiwpTskTuhekdIJCGyYGyStoG2ApzZyJq75lDuidUU9CliG7qf/eqPJslfnCBFeD+heH7v5ko3KpsDT6DA2YYl9Iw5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635814; c=relaxed/simple;
	bh=sCz7MeL/oYeoSs34ihneRltpADK2meyF+jNWc8Z6cWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7J5QYqrzfUObTVX0Q2nseEVcA3JwEmuEcfEFb5en6XH63knIX3Xid+frVI/EDKHyPk24temSgGL7N3h3BpPqp8lM21YHwyi20hDWCSueAV1sSnrBsWG1TABDr8O+aLOGYnP59oc1NfS/jhq+WzegTHXCd6E/zENJlV14Rj2WsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMrPm9wX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742cc20e11eso1708920b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748635812; x=1749240612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kh+gaDGepzKIFDoI7schH9Ybo0vZBkZOnYUUHBSj/0=;
        b=PMrPm9wXRX7DafBq9f4okJ8qQjEKctMUIpLFoghdTvuAnr6oGXk2bbOSq8HxEd3BSX
         EbwRJjHNbPAsabHr9WYNJVHHmSyONI7vraMjWAGAPojKhUdtOS9tf61H7Vovv7DVPhlo
         iCGfFkifcHvkZOAKeWjx/AUHHM5nSRJHMsfUs1hAVeQa66ZbztoTie8g4anNhXDFEL6J
         6mPej7mcZq8C1O9dTh/+nfqoFsjAkqYtGKuPnoVry8igkn6CCFHMvV0ZDcpOMVVND/bE
         XNwpvNANRX+DMSyJx4LMKM5QVPpkidwjtxaZbF1mm7ysj7t+QIK8HVQTDYwb4kur2W0T
         9xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748635812; x=1749240612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kh+gaDGepzKIFDoI7schH9Ybo0vZBkZOnYUUHBSj/0=;
        b=I4oHmPxIVcA7D6NDy9di393VvdHzIdeN5Uu2+XUhFIDU9z7YYPW+Sl5oZiE7HIKhH6
         0yrS+yIy5Rff9rBSwgbc0PqRGWEVP53LlqNYdZdV1etJMJxGlwMN/1wCYhhOMhbbTlZm
         hvfHCShspzVr8vxXcizCFZycGx07Wr688owKaGPfc0LmneX6yGre4XtLulKnxJswT60Y
         Lz8GG1Xdid+GOJXEhZL3l3q4S7xDJUjIdwzG0ZgXr7bn8WiVSF25NOLcpLxbrPEGLj2F
         7L9HcOjcN5Fkeqng1SGdF4kP7YaQt09cW/BEDaoNN4vdcRjgo5fQYtxvz1gUAadBMm2v
         2Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCViwL0lEM07ncG1q5NbCSX7eEzQWEKc0E14xThyG+b1mdO3/09Lh445F2MMiRYK/extEOQD54BiSmt0J891@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGYQvnAqLQNwZI+7cqhD7cgw4BcpLN1IFgvEYKaoMUxCO94Kr
	8mKZuCqr60HMQApxwGhXTZ7aodsKrNc43EKH5EvSeVC7QaXW228jZUOkM9XmGyEkefM48X0dtW5
	27tMMOx1TeKyR/4fw4JZ7TMGL/Q==
X-Google-Smtp-Source: AGHT+IEENihy0JLERsyg+Y4ZI07pawEu8Q9Kn+O3sBJa0gI+9nXyHfIoB0NTCHwNarZTFZbWxcdX0N6pLApDjLeLOQ==
X-Received: from pfbih20.prod.google.com ([2002:a05:6a00:8c14:b0:73c:29d8:b795])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d2:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-747c1c3da28mr5099597b3a.18.1748635812216;
 Fri, 30 May 2025 13:10:12 -0700 (PDT)
Date: Fri, 30 May 2025 13:10:11 -0700
In-Reply-To: <b66c38ba-ca16-44c5-b498-7c8eb533d805@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <b66c38ba-ca16-44c5-b498-7c8eb533d805@linux.intel.com>
Message-ID: <diqzsekl6esc.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>
> [...]
>> +
>> +static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>> +				  size_t nr_pages, bool shared,
>> +				  pgoff_t *error_index)
>> +{
>> +	struct conversion_work *work, *tmp, *rollback_stop_item;
>> +	LIST_HEAD(work_list);
>> +	struct inode *inode;
>> +	enum shareability m;
>> +	int ret;
>> +
>> +	inode = file_inode(file);
>> +
>> +	filemap_invalidate_lock(inode->i_mapping);
>> +
>> +	m = shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
>> +	ret = kvm_gmem_convert_compute_work(inode, start, nr_pages, m, &work_list);
>> +	if (ret || list_empty(&work_list))
>> +		goto out;
>> +
>> +	list_for_each_entry(work, &work_list, list)
>> +		kvm_gmem_convert_invalidate_begin(inode, work);
>> +
>> +	list_for_each_entry(work, &work_list, list) {
>> +		ret = kvm_gmem_convert_should_proceed(inode, work, shared,
>> +						      error_index);
>
> Since kvm_gmem_invalidate_begin() begins to handle shared memory,
> kvm_gmem_convert_invalidate_begin() will zap the table.
> The shared mapping could be zapped in kvm_gmem_convert_invalidate_begin() even
> when kvm_gmem_convert_should_proceed() returns error.
> The sequence is a bit confusing to me, at least in this patch so far.
>

It is true that zapping of pages from the guest page table will happen
before we figure out whether conversion is allowed.

For a shared-to-private conversion, we will definitely unmap from the
host before checking if conversion is allowed, and there's no choice
there since conversion is allowed if there are no unexpected refcounts,
and the way to eliminate expected refcounts is to unmap from the host.

Since we're unmapping before checking if conversion is allowed, I
thought it would be fine to also zap from guest page tables before
checking if conversion is allowed.

Conversion is not meant to happen very regularly, and even if it is
unmapped or zapped, the next access will fault in the page anyway, so
there is a performance but not a functionality impact.

Hope that helps. Is it still odd to zap before checking if conversion
should proceed?

>> +		if (ret)
>> +			goto invalidate_end;
>> +	}
>> +
>> +	list_for_each_entry(work, &work_list, list) {
>> +		rollback_stop_item = work;
>> +		ret = kvm_gmem_shareability_apply(inode, work, m);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	if (ret) {
>> +		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
>> +		list_for_each_entry(work, &work_list, list) {
>> +			if (work == rollback_stop_item)
>> +				break;
>> +
>> +			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
>> +		}
>> +	}
>> +
>> +invalidate_end:
>> +	list_for_each_entry(work, &work_list, list)
>> +		kvm_gmem_convert_invalidate_end(inode, work);
>> +out:
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +
>> +	list_for_each_entry_safe(work, tmp, &work_list, list) {
>> +		list_del(&work->list);
>> +		kfree(work);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> [...]
>> @@ -186,15 +490,26 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>>   	unsigned long index;
>>   
>>   	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
>> +		enum kvm_gfn_range_filter filter;
>>   		pgoff_t pgoff = slot->gmem.pgoff;
>>   
>> +		filter = KVM_FILTER_PRIVATE;
>> +		if (kvm_gmem_memslot_supports_shared(slot)) {
>> +			/*
>> +			 * Unmapping would also cause invalidation, but cannot
>> +			 * rely on mmu_notifiers to do invalidation via
>> +			 * unmapping, since memory may not be mapped to
>> +			 * userspace.
>> +			 */
>> +			filter |= KVM_FILTER_SHARED;
>> +		}
>> +
>>   		struct kvm_gfn_range gfn_range = {
>>   			.start = slot->base_gfn + max(pgoff, start) - pgoff,
>>   			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
>>   			.slot = slot,
>>   			.may_block = true,
>> -			/* guest memfd is relevant to only private mappings. */
>> -			.attr_filter = KVM_FILTER_PRIVATE,
>> +			.attr_filter = filter,
>>   		};
>>   
>>   		if (!found_memslot) {
>> @@ -484,11 +799,49 @@ EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
>>   #define kvm_gmem_mmap NULL
>>   #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>>   
> [...]

