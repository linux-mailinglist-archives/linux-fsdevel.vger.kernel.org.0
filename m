Return-Path: <linux-fsdevel+bounces-22519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFD9184A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6046728A7C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F4185E46;
	Wed, 26 Jun 2024 14:42:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C5C136;
	Wed, 26 Jun 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412966; cv=none; b=uRUWVjt3d3fH0EA6lnu4r+TTNS7I5ET3RCfggIzlYj5Kfor9MCLLCJEHjWmjwQFLxnlrOhZkTqQuCB4EhtRlup4SggFltz9d3CzDdytirS4id8uOQgrMcF7U7Jl2+fNSFTjnDnrw4/Rn4h29Eto8MY1LkVpCJi1MYwtB59Xf5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412966; c=relaxed/simple;
	bh=YLipMsYs0Zq9/DKfc/8KK/wKlFN3lUZx4uL6yu2uYIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN8TQuaYQT1U7AU2zNKRVqTay+V0aNqRDFiTEMdIHwrGRBYzktYvgioYI33efUzAVE1oQXE9F7OAgziN2O92Rggig7eK1HHlM8DDAlSfk70wVvsGbPZr/e2JAe57Q3nq1g7a/5FP6RS8eIduqUzDeFnmzeyat6nB6YjHoaHW4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8217339;
	Wed, 26 Jun 2024 07:43:07 -0700 (PDT)
Received: from [10.57.73.149] (unknown [10.57.73.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 767073F766;
	Wed, 26 Jun 2024 07:42:40 -0700 (PDT)
Message-ID: <e7167166-2682-4ff6-89dd-6ef2ec4621b8@arm.com>
Date: Wed, 26 Jun 2024 15:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>,
 akpm@linux-foundation.org, willy@infradead.org
Cc: vbabka@suse.cz, svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
 baohua@kernel.org, peterx@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Barry Song <21cnbao@gmail.com>
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
 <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 15:40, Zi Yan wrote:
> On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
>> On 26/06/2024 04:06, Zi Yan wrote:
>>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>
>>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>>>> pages, which means of any order, but KPF_THP should only be set
>>>> when the folio is a 2M pmd mappable THP. 
>>
>> Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
>> currently configured?
>>
>> I would argue that mTHP is still THP so should still have the flag. And since
>> these smaller mTHP sizes are disabled by default, only mTHP-aware user space
>> will be enabling them, so I'll naively state that it should not cause compat
>> issues as is.
>>
>> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
>> sizes to function correctly. So that would need to be reworked if making this
>> change.
> 
> + more folks working on mTHP
> 
> I agree that mTHP is still THP, but we might want different
> stats/counters for it, since people might want to keep the old THP counters
> consistent. See recent commits on adding mTHP counters:
> ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback
> counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous shmem")
> 
> and changes to make THP counter to only count PMD THP:
> 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable() for
> THP split statistics")
> 
> In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
> adjustment on tools/mm/thpmaps.

That would work for me, assuming we have KPF bits to spare?


