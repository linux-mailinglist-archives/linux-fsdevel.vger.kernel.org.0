Return-Path: <linux-fsdevel+bounces-14373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4387B47A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EB21C21343
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B073E5A10F;
	Wed, 13 Mar 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Y2rEfMzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134759B4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369642; cv=none; b=L1LPBcsTtTz94ZLT3ZjCLzJ9e1A77cM2it5cUoVJW4KmfPHsfcBo7RP8RIKzDtdvbC2+8wLzPZf+1LvNSu0aUo6/It5/74A2LC96Haevg/8Hl6Uxkr9GqwTmOhUapQH6v/IxNzyVrOXGMgBxnah5SQdKsLF0l3/hr3111QmEJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369642; c=relaxed/simple;
	bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxKceRxef5cthCSvi0CXUu6fjvzxLtJvYOk+ZvKuWH8NPOOZMHHdz7oR45li4i1FKGmIoRf+FqIDRp4x/YZxcl1fsTrDIb7wZRQRU7BCt4B+wHdDiUSNP5u4cqOM5H/Md+ig8oJYWIVqoV3kMmX9AkjUpsuQqYBTZwZ1R3wbzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Y2rEfMzt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a3c48e70fso4431097b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710369639; x=1710974439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
        b=Y2rEfMztPEsb9qwtGHekpWLd7XCm2JaYlw6xqc/h8v56GK+Mi81Z+u+NcxWSVrK9W6
         AdjMs770/f3GwXDbzbo+6XUybV/2A1sZc4t3mGZM9EBpJA2Ddm7mHNnO5OK3HoxivVzG
         WL/YpVWet0HxlPILL9DFSgzrB3kiua9VIqEi0GXhct7XExq+B5iNqmowgXC658ZKDChw
         Bejtcil3V4/1txuryERZGwJdvzJaUTZwoyRJh0P8pEI23nW8T78UECQoRWufz2UIoBFq
         e/jmzKLevvRCA1MFVBXN+8g6W6f8vevm7/0uK6eODBa2cGFM9rxO3wP316TBNlkEJV5d
         yRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369639; x=1710974439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
        b=KlaaaPlMTPIsLG/o5oetDdJmeajb2vcWUs+xWn5govjUbDNbLCE1iU0P2StR6ghOHp
         2FGtoeNk8qfDEsmUdzCD4Exuomh62wLsVV0mdotz4iSKQ8zG0KGFQCiulfxYepSknAuU
         MPtdUjtIk206MV8RQ5pBIWBM87vruZM2H1Ls9Csf051n7Cj8zA94U/9fWkkgMUq62yK6
         hK6ArkoU/w80uaBSaNpMaX3U4BRtRvhjLdwWiRgJCsaS1iE973et8xLedGLJJY+E8cAH
         d6Our5XSDKjivu3RV6zMyab0ccxw69kdOicZRDEMmsDA6lDRaTI+F+brMYWHFZJ+5p1H
         XjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAZCeAiPe+X+pCkB/QVmc44AFwbCZ3Tmkd2U8E+9Krhr6hLvLQUFLEnIjWpoVUwkAMjIzAUTugctnwMsbO31IiNlJEIzpf2hq5fOXeBQ==
X-Gm-Message-State: AOJu0Yzamjc+qg+sF53FGp/OyMAo4TFgJ61Cxfb0SQstTeYkbnQto+gf
	fRZMxCf2FaLK1ZQZiAwJfbtIYO2CX0Oq9jTlJKkufu6a/wJmGUpe9DL1ywKo6Lp4UGVr3DJ7WSB
	dhHoeRS9fOHlki2dlDaZsNzSTtbZp2YAfovzGog==
X-Google-Smtp-Source: AGHT+IEE4G/qpX58EhUm1MonVHMQobSiJgTN5F+R/XDKRvfIgvrnS2HXR6msMnAV4g83xTteuIsqwqymEt+VSwymYE8=
X-Received: by 2002:a81:7105:0:b0:608:13ee:8f3f with SMTP id
 m5-20020a817105000000b0060813ee8f3fmr15835ywc.27.1710369639489; Wed, 13 Mar
 2024 15:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com> <20240220214558.3377482-2-souravpanda@google.com>
In-Reply-To: <20240220214558.3377482-2-souravpanda@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 18:40:03 -0400
Message-ID: <CA+CK2bAM4Xe7BT3TFZT-+3qQTFGgkYBiYY=oVkdqMN8gyJg_0g@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:46=E2=80=AFPM Sourav Panda <souravpanda@google.co=
m> wrote:
>
> Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> to /proc/meminfo. This information can be used by users to see how
> much memory is being used by per-page metadata, which can vary
> depending on build configuration, machine architecture, and system
> use.
>
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. In this patch, exported
> field nr_memmap in /sys/devices/system/node/nodeN/vmstat would
> exclusively track buddy allocations while nr_memmap_boot would
> exclusively track memblock allocations. Furthermore, Memmap in
> /proc/meminfo would exclusively track buddy allocations allowing it to
> be compared against MemTotal.
>
> This memory depends on build configurations, machine architectures, and
> the way system is used:
>
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
>
> Utility for userspace:
>
> Application Optimization: Depending on the kernel version and command
> line options, the kernel would relinquish a different number of pages
> (that contain struct pages) when a hugetlb page is reserved (e.g., 0, 6
> or 7 for a 2MB hugepage). The userspace application would want to know
> the exact savings achieved through page metadata deallocation without
> dealing with the intricacies of the kernel.
>
> Observability: Struct page overhead can only be calculated on-paper at
> boot time (e.g., 1.5% machine capacity). Beyond boot once hugepages are
> reserved or memory is hotplugged, the computation becomes complex.
> Per-page metrics will help explain part of the system memory overhead,
> which shall help guide memory optimizations and memory cgroup sizing.
>
> Debugging: Tracking the changes or absolute value in struct pages can
> help detect anomalies as they can be correlated with other metrics in
> the machine (e.g., memtotal, number of huge pages, etc).
>
> page_ext overheads: Some kernel features such as page_owner
> page_table_check that use page_ext can be optionally enabled via kernel
> parameters. Having the total per-page metadata information helps users
> precisely measure impact.
>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

