Return-Path: <linux-fsdevel+bounces-22605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E291A1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 10:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C792813D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6B137930;
	Thu, 27 Jun 2024 08:40:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB071292CE;
	Thu, 27 Jun 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477600; cv=none; b=SP9RJjBuxDjJnr1W+8AU7qvIcjHCXab5N0A47bOa4ucfLIZTITYf9QkN/3rFqDd0+608iSBZA/lcnsxcp98yeFb12SkSwRbZK+yQOdb3a93wtizWUFlnCgSOlga0Wmzx2oM6BPghmZSCqGEz+Iv0fw1TuobCMoi5NXsXBK0E/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477600; c=relaxed/simple;
	bh=wbbsfnyEXiw1I4uQYeXCIgF8aY+i4tJ6NIwIHja17Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWG6sLTeNVrq9DLrH1Z/7nL4GIdHd7MfEesIxVST0FYkhDNAoBVZbiQPlmo4msLaqY882BWRxp4he3EgQjbpoQNznrd8k6umK10f1qvjDyPZie7Vygt5uupC+pUxk9RGbOBjuIeRMz6D+CXDs3+TiN9Cd9eCgbaZ3sY/BTyHRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF71367;
	Thu, 27 Jun 2024 01:40:21 -0700 (PDT)
Received: from [10.1.32.171] (XHFQ2J9959.cambridge.arm.com [10.1.32.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 626863F6A8;
	Thu, 27 Jun 2024 01:39:54 -0700 (PDT)
Message-ID: <fceebb14-49de-4bfb-8a3a-3ce9c7dee0e6@arm.com>
Date: Thu, 27 Jun 2024 09:39:52 +0100
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
To: Barry Song <21cnbao@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org,
 willy@infradead.org, vbabka@suse.cz, svetly.todorov@memverge.com,
 ran.xiaokai@zte.com.cn, peterx@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
 <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
 <CAGsJ_4wCymN=YQt7cDBZ-xB8Kr4C7hSnDaWNevnhiNC76pXd-A@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wCymN=YQt7cDBZ-xB8Kr4C7hSnDaWNevnhiNC76pXd-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/06/2024 05:10, Barry Song wrote:
> On Thu, Jun 27, 2024 at 2:40 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
>>> On 26/06/2024 04:06, Zi Yan wrote:
>>>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
>>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>
>>>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>>>>> pages, which means of any order, but KPF_THP should only be set
>>>>> when the folio is a 2M pmd mappable THP.
>>>
>>> Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
>>> currently configured?
>>>
>>> I would argue that mTHP is still THP so should still have the flag. And since
>>> these smaller mTHP sizes are disabled by default, only mTHP-aware user space
>>> will be enabling them, so I'll naively state that it should not cause compat
>>> issues as is.
>>>
>>> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
>>> sizes to function correctly. So that would need to be reworked if making this
>>> change.
>>
>> + more folks working on mTHP
>>
>> I agree that mTHP is still THP, but we might want different
>> stats/counters for it, since people might want to keep the old THP counters
>> consistent. See recent commits on adding mTHP counters:
>> ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback
>> counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous shmem")
>>
>> and changes to make THP counter to only count PMD THP:
>> 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable() for
>> THP split statistics")
>>
>> In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
>> adjustment on tools/mm/thpmaps.
> 
> It seems we have to do this though I think keeping KPF_THP and adding a
> separate bit like KPF_PMD_MAPPED makes more sense. but those tools
> relying on KPF_THP need to realize this and check the new bit , which is
> not done now.
> whether the mTHP's name is mTHP or THP will make no difference for
> this case:-)

I don't quite follow your logic for that last part; If there are 2 separate
bits; KPF_THP and KPF_MTHP, and KPF_THP is only set for PMD-sized THP, that
would be a safe/compatible approach, right? Where as your suggestion requires
changes to existing tools to work.

Thinking about this a bit more, I wonder if PKF_MTHP is the right name for a new
flag; We don't currently expose the term "mTHP" to user space. I can't think of
a better name though.

I'd still like to understand what is actually broken that this change is fixing.
Is the concern that a user could see KPF_THP and advance forward by
"/sys/kernel/mm/transparent_hugepage/hpage_pmd_size / getpagesize()" entries?

> 
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
>>
> 
> Thanks
> Barry


