Return-Path: <linux-fsdevel+bounces-50208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395ABAC8B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E93173C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49E221287;
	Fri, 30 May 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELy/DXVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBE21E082
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599021; cv=none; b=TUKw5wkZNTcEdQB9ReQn9kXOW0WS7+6Qo0R0D1y89YF5UcdV+5jtOxE16SHHdGWrukI9ekOMVf0kQNS0XijRwyKT1XZHuxixe0QejW82A1ocVrk7rteTVHbrfXSwS6fh1/C0/5BQd1apWotoMkH0Hpp7+KoUx6FUEhXZy+gdOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599021; c=relaxed/simple;
	bh=PJCzMF/AUy2/duUrlV1Bk5x2yxDWOMYK54ncBNFmZC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jnj7Owhe3iloiG1bo1szyQssAeB/fxRqliBed9S6C0WF5Ncx7O9f9alO++JSXQA+UlI91KCVaFjY06V7lQkXvyNBHjxsifiWx/sbyEN2eb8J9ZSNe9BTUOwBhOHukcnt0/YDp/c+wqeg7z9dHN45eQfHbkcjahywOQ5LVu8u2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELy/DXVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748599018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4aYP3vlLEMaaRLnDxd7KrLA3fGNslSBV9pk/D+1+TUs=;
	b=ELy/DXVEAxpb00YckAeL2feBLIKLBz510uFbl6tItN1VYldLCPY1llZFoO4wbZPdJAm8L1
	5JhV9y47tX/507hrHp4Q8a89y0RSLTERgZrNDvOJGlx68CnhXdyh74ODMbPR8+H+Cwhbs+
	mHrwgPYDR+KqTBAn1TXrV2UtU3SiS+g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-RIlKmMvxOoa5T_byO0o8zQ-1; Fri, 30 May 2025 05:56:56 -0400
X-MC-Unique: RIlKmMvxOoa5T_byO0o8zQ-1
X-Mimecast-MFC-AGG-ID: RIlKmMvxOoa5T_byO0o8zQ_1748599015
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-445135eb689so9100425e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599015; x=1749203815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4aYP3vlLEMaaRLnDxd7KrLA3fGNslSBV9pk/D+1+TUs=;
        b=MenKzHrQLmwU+D3M3H9yivI0fcQbxLOfzh9+AWiTKjDEmntMbBcvEg7NjZ+B+YxID/
         RNQQkdq+fLCy4Ru7aAGlqHdHW/rqZJPn3Mb9Nd0RM5b5D+ljB5iApALcBafnXbZDwXzc
         6Ee8Pm6qdMo+Xb7FqIFHQM89P34CvzHvSs0g1XDmn2k9yOPDR5+JrCM+UkEGSQoCiVIP
         L3um7G6s8wpc/Skexv/01E5gnfwszgGeXvt3OnS40mGLu0HE4JXlZ2TgQG6fewpcdEJW
         nSC0GShnFGEZ2ZeC/jtcDU991ZuoMGJO5EImE3sfyn/p2TEEDVE8UxyPx8Tp/TQfru56
         CQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQO0ZA3BYAD9FP4+7WTEU6H0GB9pKPeudFBmwXXq7cgUsyaQIcwUe+1/8tITmBekwjFgyUbVR+tbzqNddq@vger.kernel.org
X-Gm-Message-State: AOJu0YybYRA1usQD3d3pHMapvSGUKMfgQZwUVn1GKi5fYpT9karioeSX
	kyNQ/RAx9R+K6YPqeqGZcChf1p8Qdv9rUwVxNW5Z+4f/tUsiemSC3+UYxZ/e5l2XXSeTcmGZqqY
	KRjy+HDVNr28OV7RaDbVPymWPwdo+VnCQApiKzX5Kky56rCjYEc1a6h1aOlfy2d6zCUs=
X-Gm-Gg: ASbGnctqu3TMRmD/7WZeXbO18EA+JLmizUBlD8fa4dYIXogkq81NpuFeGpzquqezntT
	tbTWHoSWHeeSQM1qeWBaSxMBMSOpRKYtNmWi9jJJZH6pgyKfk8gRdjv8rrGIW8b0uq13xG+8DUF
	wp+HOu+yJ0DmVOd7rAnQXxKDkJJ36zwjUXPaOInBfNDKC0/3u0qTm6Q5aGLC2Myz0PFG9lM36Wf
	cfQYrbGIGnV8nA6elBCRNAQACH0oSiqj3ejzy3J12Z/4eE3dM6l/e/qFvpqWCsgFABzN9uDSgIQ
	CTFLjLZfrFo2yst8vwD31xlWCTuc6/j9Leq6m4nAZpECjk5STzXNcMHVc4Exaqcl96l4O6oModD
	Zutfr7rpB7qMnBhV5P2TCQxVqf5lOy537lia/p59AGCjG7V/WdQ==
X-Received: by 2002:a05:6000:4282:b0:3a4:ea80:422d with SMTP id ffacd0b85a97d-3a4f7a02343mr1874971f8f.9.1748599015314;
        Fri, 30 May 2025 02:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnd78WFlyh8+jhQ/np4f6foO4xxrbS+AsAYm7tB70oDbzdcAg+X/BtNxRGUac3hxdHeradPQ==
X-Received: by 2002:a05:6000:4282:b0:3a4:ea80:422d with SMTP id ffacd0b85a97d-3a4f7a02343mr1874943f8f.9.1748599014817;
        Fri, 30 May 2025 02:56:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6d0dbsm4287688f8f.40.2025.05.30.02.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:56:54 -0700 (PDT)
Message-ID: <081775ba-276f-4bbd-a18a-175cf1f217e9@redhat.com>
Date: Fri, 30 May 2025 11:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
To: Bo Li <libo.gcs85@bytedance.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 kees@kernel.org, akpm@linux-foundation.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, peterz@infradead.org
Cc: dietmar.eggemann@arm.com, hpa@zytor.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, jannh@google.com, pfalcato@suse.de, riel@surriel.com,
 harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, duanxiongchun@bytedance.com, yinhongbo@bytedance.com,
 dengliang.1214@bytedance.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, songmuchun@bytedance.com, yuanzhu@bytedance.com,
 chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> 
> ## Address space sharing
> 
> For address space sharing, RPAL partitions the entire userspace virtual
> address space and allocates non-overlapping memory ranges to each process.
> On x86_64 architectures, RPAL uses a memory range size covered by a
> single PUD (Page Upper Directory) entry, which is 512GB. This restricts
> each process’s virtual address space to 512GB on x86_64, sufficient for
> most applications in our scenario. The rationale is straightforward:
> address space sharing can be simply achieved by copying the PUD from one
> process’s page table to another’s. So one process can directly use the
> data pointer to access another's memory.
> 
> 
>   |------------| <- 0
>   |------------| <- 512 GB
>   |  Process A |
>   |------------| <- 2*512 GB
>   |------------| <- n*512 GB
>   |  Process B |
>   |------------| <- (n+1)*512 GB
>   |------------| <- STACK_TOP
>   |  Kernel    |
>   |------------|

Oh my.

It reminds me a bit about mshare -- just that mshare tries to do it in a 
less hacky way..

> 
> ## RPAL call
> 
> We refer to the lightweight userspace context switching mechanism as RPAL
> call. It enables the caller (or sender) thread of one process to directly
> switch to the callee (or receiver) thread of another process.
> 
> When Process A’s caller thread initiates an RPAL call to Process B’s
> callee thread, the CPU saves the caller’s context and loads the callee’s
> context. This enables direct userspace control flow transfer from the
> caller to the callee. After the callee finishes data processing, the CPU
> saves Process B’s callee context and switches back to Process A’s caller
> context, completing a full IPC cycle.
> 
> 
>   |------------|                |---------------------|
>   |  Process A |                |  Process B          |
>   | |-------|  |                | |-------|           |
>   | | caller| --- RPAL call --> | | callee|    handle |
>   | | thread| <------------------ | thread| -> event  |
>   | |-------|  |                | |-------|           |
>   |------------|                |---------------------|
> 
> # Security and compatibility with kernel subsystems
> 
> ## Memory protection between processes
> 
> Since processes using RPAL share the address space, unintended
> cross-process memory access may occur and corrupt the data of another
> process. To mitigate this, we leverage Memory Protection Keys (MPK) on x86
> architectures.
> 
> MPK assigns 4 bits in each page table entry to a "protection key", which
> is paired with a userspace register (PKRU). The PKRU register defines
> access permissions for memory regions protected by specific keys (for
> detailed implementation, refer to the kernel documentation "Memory
> Protection Keys"). With MPK, even though the address space is shared
> among processes, cross-process access is restricted: a process can only
> access the memory protected by a key if its PKRU register is configured
> with the corresponding permission. This ensures that processes cannot
> access each other’s memory unless an explicit PKRU configuration is set.
> 
> ## Page fault handling and TLB flushing
> 
> Due to the shared address space architecture, both page fault handling and
> TLB flushing require careful consideration. For instance, when Process A
> accesses Process B’s memory, a page fault may occur in Process A's
> context, but the faulting address belongs to Process B. In this case, we
> must pass Process B's mm_struct to the page fault handler.

In an mshare region, all faults would be rerouted to the mshare MM 
either way.

> 
> TLB flushing is more complex. When a thread flushes the TLB, since the
> address space is shared, not only other threads in the current process but
> also other processes that share the address space may access the
> corresponding memory (related to the TLB flush). Therefore, the cpuset used
> for TLB flushing should be the union of the mm_cpumasks of all processes
> that share the address space.

Oh my.

It all reminds me of mshare, just the context switch handling is 
different (and significantly ... more problematic).

Maybe something could be built on top of mshare, but I'm afraid the real 
magic is the address space sharing combined with the context switching 
... which sounds like a big can of worms.

So in the current form, I understand all the NACKs.

-- 
Cheers,

David / dhildenb


