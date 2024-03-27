Return-Path: <linux-fsdevel+bounces-15450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314388EB37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B2BB3E74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64A12E1D4;
	Wed, 27 Mar 2024 15:46:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995E84D31;
	Wed, 27 Mar 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554375; cv=none; b=dIpKr8dWquD2nc370ALlv9WImmhT+dGGdk1hbxo0VknLAuyq8daf/PwwNSbuRicmNdUTvRG4e1x84nLKl5nmFsllSvFGds/pyaGcru9RhGdqbPTICH2LeuiBMbKHEM02WyT0WeldHmjCxh20SlO23hKjbQYLdHVGl4icVffoEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554375; c=relaxed/simple;
	bh=94RLfShSwR6aZg3VILaQyN2svkE6DuMu31PfIh9ghO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ2uzXmZcNEvq37tBbXEnu463QpAnOLZNWaxWoo3t2kZ7aBZkEWF1WbYFgqJzWdZcXONS/ylrTcHY/gTYBaooh4ZpJljHQeH0s1Vuhxs3byeO7gQWeRR1pEB/3H3y0zWDFYxCYomO+RbIlGIWO5XucDJZm+0mPmadv5UubzXhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC782F4;
	Wed, 27 Mar 2024 08:46:46 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25BC83F64C;
	Wed, 27 Mar 2024 08:46:09 -0700 (PDT)
Message-ID: <8727a618-30c4-4a13-b0e9-eccc3fd67c73@arm.com>
Date: Wed, 27 Mar 2024 15:46:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> 
> Some of them look like mm-unstable issue, For example, arm64 fails with
> 
>   CC      arch/arm64/mm/extable.o
> In file included from ./include/linux/hugetlb.h:828,
>                  from security/commoncap.c:19:
> ./arch/arm64/include/asm/hugetlb.h:25:34: error: redefinition of
> 'arch_clear_hugetlb_flags'
>    25 | #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/hugetlb.h:840:20: note: in expansion of macro
> 'arch_clear_hugetlb_flags'
>   840 | static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/arm64/include/asm/hugetlb.h:21:20: note: previous definition of
> 'arch_clear_hugetlb_flags' with t
> ype 'void(struct folio *)'
>    21 | static inline void arch_clear_hugetlb_flags(struct folio *folio)
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/hugetlb.h:828,
>                  from mm/filemap.c:37:
> ./arch/arm64/include/asm/hugetlb.h:25:34: error: redefinition of
> 'arch_clear_hugetlb_flags'
>    25 | #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/hugetlb.h:840:20: note: in expansion of macro
> 'arch_clear_hugetlb_flags'
>   840 | static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/arm64/include/asm/hugetlb.h:21:20: note: previous definition of
> 'arch_clear_hugetlb_flags' with type 'void(struct folio *)'
>    21 | static inline void arch_clear_hugetlb_flags(struct folio *folio)

see: https://lore.kernel.org/linux-mm/ZgQvNKGdlDkwhQEX@casper.infradead.org/


