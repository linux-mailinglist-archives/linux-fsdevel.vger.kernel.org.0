Return-Path: <linux-fsdevel+bounces-50777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E5ACF7AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3708A17AE2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41ED27AC4D;
	Thu,  5 Jun 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ux245dRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2724315A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151023; cv=none; b=BHcnECusgUD6/0wsSYlv4PiH/Oii7nk2yTHDa+P5stPM+geBzFiKrV54rGbGh1mtw8IIQYkU4cStLtnNjUGRNYsUw2xhCqLt+xod8S0k+GN7LAU8i/qSjpuJKVj7vYUneGvkuyXAWF3VGUkmC8BUfajRCAJ1NPBaMtyRGoL/BlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151023; c=relaxed/simple;
	bh=xC18f4vljP7IWg7QT+Q9d61uvZ7VOqg0LzFEl7gjPmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkuQ1Y/IKm36fYqesBJnfdkC5GW68ZJZ3r2eE1SOTq8SXinZ/bhzvXIVSBMH38B7gMhzGkT//+bt15f+TB6cQ7phSH3v6WhIJpTM55LmsxHLTMwRxBtFF8lUMZsnO2MpG9SIMcSppfuN8oFzEFpGPhZFSQSdms+nwf9qjjgAQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ux245dRL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747d84fe5f8so752163b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749151021; x=1749755821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdt+NTF9J8z5h3nw/qHtHa3JaF0BNQRi8vFlUQ8H5zM=;
        b=ux245dRLzi+m+8RhpmtgPfZB1q4PUl6ZtNkJd8e4kHkwRkHpUCXdGfI5U0fsxOlnc0
         dFUAmO1YCrnQ0w0WntMnQbOU4mobIPWas8xyMF+F2W2hr32nsD/dlrPOMhbkaVjmqQnt
         HtMh/e+NByZ1tvVzaT8UMeY6cio7VZi7o6bKWZy/MI+ukNZBsSAChV8jlL49iovCwFYg
         L+qY+GTqlM79iGQ0J5d03Hoa2bO9vT61ODqOMY7HNhydx3KNtJ1LMKACZV3hJvYMuM/t
         WZxA4AJu6RLH/hwUxXm+TcxuIpM32bi5wHsXnjqkYqWWK+YCVFjC1DOFsGRF3FXsPsQU
         FR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151021; x=1749755821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdt+NTF9J8z5h3nw/qHtHa3JaF0BNQRi8vFlUQ8H5zM=;
        b=c32X7WbSA3uej8QAGmPj+CDmH7AK32cY6tbm4Qh6e7SYrBq5wMAqVqVrBiwmd/35F7
         Kd1DoGTBelkMDqgdb/ql1OviJ5AIZzYGD+rYI+W6/91vouD+FYI5AuHi9vsfOVoZ5LOU
         vZtl3wMEA7UY8btZmGvKTSJZSbZwgqn8NVnYSw8y0nff3krw1jzHgw/Umt3fsgfUcMYl
         lrn5fz0rhc28gFlwv1bUIeNxH8eSoVOsiILXY275oD0QOjp0o+lVAHBqS1vbmvKJuRQv
         42sny/qvGB2BzNgUOrQ/x3ENnlFwNkwUPmXAUhh0jK+vqJ7sLt8kAa4RdZH6I0dvi0JN
         B9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaFNZwDOOiYnv1GJkbdHp66WGxo3X38stJNDSPR003ffYS+7PkyPzlzDqJ7NbmHVUH5NClcRe7nXykvMMq@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyldRAhXkGbvSlSRmSDRWmTfM9myfLKp8nWFOaNTO+2eiWwop
	L6Z1oosq5TR066N1qoGBIcCamv5aXbePMt11qCTxLDOg+9ZEjAZDbc3D1XGQxi/cVQws4N/8KLl
	UH1nSDLp6CgKeIe08NYloIRcRow==
X-Google-Smtp-Source: AGHT+IH8htB84vea5MhC0iZOF6Zxpq5a9Lmv6Or6O2Uq8VlBTS29CnJcDsUC/JtlL3nBkV61UZOUO9/cw62YUQKDXQ==
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:746:2747:e782])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc6:b0:742:a23e:2a68 with SMTP id d2e1a72fcca58-7482806455cmr981739b3a.15.1749151020845;
 Thu, 05 Jun 2025 12:17:00 -0700 (PDT)
Date: Thu, 05 Jun 2025 12:16:59 -0700
In-Reply-To: <558a649d-d419-46e2-adb8-4027e105c1ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <558a649d-d419-46e2-adb8-4027e105c1ce@linux.intel.com>
Message-ID: <diqzo6v2huc4.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
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
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/15/2025 7:42 AM, Ackerley Tng wrote:
> [...]
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
>
> What if a huge page whose attribute is shared?
>

This checks if there are any shared pages in the range [folio->index,
folio->index + to_nr_pages), so if the entire huge page is shared this
function should also return true.

folio->index is the start of the merged huge page, and to_nr_pages is
the number of pages in the merged huge page, so this should be querying
exactly the entire huge page.

Note to self: rename kvm_gmem_has_some_shared() to
kvm_gmem_has_any_shared() in the next revision.

Hope I answered your question! Let me know if I misunderstood your question.

>> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
>> +
>> +	return 0;
>> +}
>> +
> [...]
>>   
>>   static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
>> @@ -563,11 +1005,16 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>   		return folio;
>>   
>>   	if (kvm_gmem_has_custom_allocator(inode)) {
>> -		void *p = kvm_gmem_allocator_private(inode);
>> +		size_t nr_pages;
>> +		void *p;
>>   
>> +		p = kvm_gmem_allocator_private(inode);
>>   		folio = kvm_gmem_allocator_ops(inode)->alloc_folio(p);
>>   		if (IS_ERR(folio))
>>   			return folio;
>> +
>> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
>> +		index_floor = round_down(index, nr_pages);
>>   	} else {
>>   		gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>>   
>> @@ -580,10 +1027,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>   			folio_put(folio);
>>   			return ERR_PTR(ret);
>>   		}
>> +
>> +		index_floor = index;
>>   	}
>>   	allocated_size = folio_size(folio);
>>   
>> -	index_floor = round_down(index, folio_nr_pages(folio));
>>   	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index_floor);
>>   	if (ret) {
>>   		folio_put(folio);
>> @@ -600,6 +1048,13 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>   		return ERR_PTR(ret);
>>   	}
>>   
>> +	/* Leave just filemap's refcounts on folio. */
>> +	folio_put(folio);
>> +
>> +	ret = kvm_gmem_try_split_folio_in_filemap(inode, folio);
>
> When !CONFIG_KVM_GMEM_SHARED_MEM, kvm_gmem_try_split_folio_in_filemap() is
> undefined.
>

Will fix this in the next revision. Thanks!

>> +	if (ret)
>> +		goto err;
>> +
>>   	spin_lock(&inode->i_lock);
>>   	inode->i_blocks += allocated_size / 512;
>>   	spin_unlock(&inode->i_lock);
>>
> [...]

