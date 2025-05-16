Return-Path: <linux-fsdevel+bounces-49308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B3ABA600
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606EEA0243F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E13280026;
	Fri, 16 May 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swf0vnjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A127F758
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435397; cv=none; b=N0m7At6jlfKJ+mgBKWg6HXrlzBsC/MWv/s0vzNd5ANd1a9ps0tSThSFuKhx5Gw4ecVqiUCprDj/iN1pj7uxv14s4Mhrw5jluWctDLKUaVvuY+gpVUVA1JOalywJVo2NT7WhpCE0LuZJUz/zJDAOBjqLAE25+hrN4SzM+ONcyWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435397; c=relaxed/simple;
	bh=hfabRiLljbl1HANiIdfWAP98Xpico/Kdype+mEpmFZk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PYIKVcseeyGJfVZipXIlDW6R21ccZik9hryKykfdtmU1fuHpxw5c4rk1Ba+uH7PBVBFRvr3pqlA/MBYtUU1ssI1YXGcs9TmgLnq5E4q/3H0zrZhnj3X4r7RLuMPaDmxHYAEz7NelSRhNbnwVX1TBJp0+1PBb0sp9BGLKqB3/IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swf0vnjs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7425fc3357aso3371862b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747435395; x=1748040195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UwP/Vx2iaUwHKjVIPmZoWWF77us3LDnzfoBHKI6jETg=;
        b=swf0vnjsKIMT2fTQe+sqHWGAX7MA6kIAcyVNygFs2ygYb+D4ykhk3aqjHm9t2V0SIO
         nSX1HuUPwzXuj216CoOV/Iv7RUMahF4PiK+SqFLf6GYzk+ckYmcU4bW45jx9fGqjaidE
         aNQ5AZie7LkJ7PH5i5ZEGHwLOGnxlkBW4LSZAbrJfs4tb7Vd+84yc+/m0oRFWnDprtoF
         zl4Q6In/9U7jj42AjavRC6d6RN2uMJkvg6bWmtMPQ3G49vkpIf8gfk/i0FENlRxCeYwQ
         3pdFqI2ydVnXNXuEMk6u2pXIvrmSiIaqbO37CFvxAqEdN1ASMIGp7HsGiNnt9pAwiPs1
         Kyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747435395; x=1748040195;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwP/Vx2iaUwHKjVIPmZoWWF77us3LDnzfoBHKI6jETg=;
        b=VLN3YY++GSQolTSbbNq0wUubI7EhZOHQ+N6Ib/jPyy8zJwOQGUmScktCTLzvTYW7i2
         CAl+2rEfN1VNwr7xO3oynG8a9uFVSAsuZyxx2EZ1ug472fJ1Sv9uSj8bfbCixGEwoWlM
         My1VNUBCUI9ILCgpKXMkIoZxkDeBr6G69eb9Snf/6A2WN+8HR9xc7w4PggrHrgNqp8Mt
         9EZGbV77c2jPRNosBJPADyq4/X4vqXg5NRfntIQtcTUZlu1AWUVlXWjYgSGunSRNys2H
         ysnEPg/RuznCqS0AtWGqyVPYBadHFguoduY45aMSsJMtCmBx96RCFhYnJ99v9d47PAkp
         itYw==
X-Forwarded-Encrypted: i=1; AJvYcCUao55QIVLl5DjqCWTct3j5mRFX24s0jAGAcAuA90EYFuOULbn6xtWK4/cz4mMbFa0BUuqBxOhb6PCDli4X@vger.kernel.org
X-Gm-Message-State: AOJu0YxMV+3S+xb/ECMaehKca4AH8VTrGYMCuzENVtHc+nvOOXgpOJMh
	TiBfT8id1o26dmCUMYztEU/RAzIKkrpqj2Wsqsof4nWXLo2Jup3SNrNghYaQIchScy9SRTd/RfA
	Rzv+K6XzEsQqjZUcOmqhrQX6rQg==
X-Google-Smtp-Source: AGHT+IG6+sFRSJbWE22FTz4ijWTukSwix/9j770r9PlxkRLB52VwmrOJ/kpeM4pmmDos7Oer2aGmJhNogxMLy5V/6g==
X-Received: from pfbik5.prod.google.com ([2002:a05:6a00:8d05:b0:73c:29d8:b795])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10c6:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-742a97aa35emr6301726b3a.6.1747435395246;
 Fri, 16 May 2025 15:43:15 -0700 (PDT)
Date: Fri, 16 May 2025 15:43:14 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com> (message from
 Ackerley Tng on Wed, 14 May 2025 16:41:39 -0700)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzbjrsfa7x.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Ackerley Tng <ackerleytng@google.com>
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
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> <snip>
>
> Here are some remaining issues/TODOs:
>
> 1. Memory error handling such as machine check errors have not been
>    implemented.
> 2. I've not looked into preparedness of pages, only zeroing has been
>    considered.
> 3. When allocating HugeTLB pages, if two threads allocate indices
>    mapping to the same huge page, the utilization in guest_memfd inode's
>    subpool may momentarily go over the subpool limit (the requested size
>    of the inode at guest_memfd creation time), causing one of the two
>    threads to get -ENOMEM. Suggestions to solve this are appreciated!
> 4. max_usage_in_bytes statistic (cgroups v1) for guest_memfd HugeTLB
>    pages should be correct but needs testing and could be wrong.
> 5. memcg charging (charge_memcg()) for cgroups v2 for guest_memfd
>    HugeTLB pages after splitting should be correct but needs testing and
>    could be wrong.
> 6. Page cache accounting: When a hugetlb page is split, guest_memfd will
>    incur page count in both NR_HUGETLB (counted at hugetlb allocation
>    time) and NR_FILE_PAGES stats (counted when split pages are added to
>    the filemap). Is this aligned with what people expect?
>

For people who might be testing this series with non-Coco VMs (heads up,
Patrick and Nikita!), this currently splits the folio as long as some
shareability in the huge folio is shared, which is probably unnecessary?

IIUC core-mm doesn't support mapping at 1G but from a cursory reading it
seems like the faulting function calling kvm_gmem_fault_shared() could
possibly be able to map a 1G page at 4K.

Looks like we might need another flag like
GUEST_MEMFD_FLAG_SUPPORT_CONVERSION, which will gate initialization of
the shareability maple tree/xarray.

If shareability is NULL for the entire hugepage range, then no splitting
will occur.

For Coco VMs, this should be safe, since if this flag is not set,
kvm_gmem_fault_shared() will always not be able to fault (the
shareability value will be NULL.

> Here are some optimizations that could be explored in future series:
>
> 1. Pages could be split from 1G to 2M first and only split to 4K if
>    necessary.
> 2. Zeroing could be skipped for Coco VMs if hardware already zeroes the
>    pages.
>
> <snip>

