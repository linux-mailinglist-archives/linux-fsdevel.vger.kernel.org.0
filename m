Return-Path: <linux-fsdevel+bounces-45207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D7A74A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 14:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4235A16F84D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BC1494D9;
	Fri, 28 Mar 2025 13:09:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3513D51E;
	Fri, 28 Mar 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167396; cv=none; b=C6Q6SHVeFhFgH7Hin7LasWFjoez011JA7pt00xfv907w9bi25YRZXM+xNxdx7D5rvcupusZ0UxohMmzQlzwl+GetvGQkqLcS6Y6oxYjExeMWy0YUM81AWiVeYj7zxjpB7N4ZNDInwY4FBFdYxh+mvdpxhKXxVod2fomdNURRffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167396; c=relaxed/simple;
	bh=KOzemAehihq7hY9k8MG4mPWqkmYrZSLFPPIiW7ChcBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPffRpkhpsKYbEovsoiUuqFKI77flqGX1bWFtnIx0rd2IEl02UqCuQ0S9zupMYnVzI8utxpPdnueZTxPJW3vwnzuCRjg+Yt3WsMD5PIMQwA2ZHVji6RkhjaQrdMxIL1m/ZLLyZ+DMAOKof87GQvTHfjZjOxDfUdO/hsTywg9Zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6411007;
	Fri, 28 Mar 2025 06:09:58 -0700 (PDT)
Received: from [10.57.87.112] (unknown [10.57.87.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45A2B3F63F;
	Fri, 28 Mar 2025 06:09:51 -0700 (PDT)
Message-ID: <dfc06a39-3d92-4995-ab06-c552e351f7c8@arm.com>
Date: Fri, 28 Mar 2025 13:09:49 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
 <731D8D6E-52A0-4144-A2BB-7243BFACC92D@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <731D8D6E-52A0-4144-A2BB-7243BFACC92D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/03/2025 20:07, Zi Yan wrote:
> On 27 Mar 2025, at 12:44, Matthew Wilcox wrote:
> 
>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>>> So let's special-case the read(ahead) logic for executable mappings. The
>>> trade-off is performance improvement (due to more efficient storage of
>>> the translations in iTLB) vs potential read amplification (due to
>>> reading too much data around the fault which won't be used), and the
>>> latter is independent of base page size. I've chosen 64K folio size for
>>> arm64 which benefits both the 4K and 16K base page size configs and
>>> shouldn't lead to any read amplification in practice since the old
>>> read-around path was (usually) reading blocks of 128K. I don't
>>> anticipate any write amplification because text is always RO.
>>
>> Is there not also the potential for wasted memory due to ELF alignment?
>> Kalesh talked about it in the MM BOF at the same time that Ted and I
>> were discussing it in the FS BOF.  Some coordination required (like
>> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
>> there?)
>>
>>> +#define arch_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
>>
>> I don't think the "arch" really adds much value here.
>>
>> #define exec_folio_order()	get_order(SZ_64K)
> 
> How about AMD’s PTE coalescing, which does PTE compression at
> 16KB or 32KB level? It covers 4 16KB and 2 32KB, at least it will
> not hurt AMD PTE coalescing. Starting with 64KB across all arch
> might be simpler to see the performance impact. Just a comment,
> no objection. :)

exec_folio_order() is defined per-architecture and SZ_64K is the arm64 preferred
size. At the moment x86 is not opted in, but they could choose to opt in with
32K (or whatever else makese sense) if the HW supports coalescing.

I'm not sure if you thought this was global and are arguing against that, or if
you are arguing for it to be global because it will more easily show us
performance regressions earlier if x86 is doing this too?

> 
> Best Regards,
> Yan, Zi


