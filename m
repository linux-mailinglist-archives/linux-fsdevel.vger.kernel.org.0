Return-Path: <linux-fsdevel+bounces-9626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE8843700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462971C266E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427003EA66;
	Wed, 31 Jan 2024 06:54:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AA55C16;
	Wed, 31 Jan 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684049; cv=none; b=Tzi/JYdUl4ByHEyOE6a+Bz9Fz3XmmwgRKIXBH8rXDiJ4RWkRRmy5phRg4pKSrkJqSNgeyCmuKMXlWdBjbnnoKaAytodKo/odTa9oQt1wpbgKOXcyEXq6FsPPnUKJm2xU7xTZvuGRJv/SB3x8JKoTQbn8Hf+WpYZ1sJBmyZiAnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684049; c=relaxed/simple;
	bh=Zdw5BUWFSFm+QflhlaaAobfZNFzFMokg/6LaDvxnxVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEMQ1dT+Q3XnuRm+klkE1WzonKDXYMbB3PRnwMfxjwjhofBphcu2O2/WQW3bpLjg88kkrXSNY7pUZ+ccCH94Nb7P60dJU1kbJC1Bc8uuwDasPBfTLwgrxKznfrsuwg4ZdwawaYc1QsW0jZY7dRu1bhv8aEqEpwkiPHKHqzlkn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D5ADA7;
	Tue, 30 Jan 2024 22:54:50 -0800 (PST)
Received: from [10.163.41.195] (unknown [10.163.41.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9C73F5A1;
	Tue, 30 Jan 2024 22:53:53 -0800 (PST)
Message-ID: <7612b843-cd31-4917-87c0-c26802c5bef2@arm.com>
Date: Wed, 31 Jan 2024 12:23:51 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio
 allocation when VMA is known
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-12-alexandru.elisei@arm.com>
 <1e03aec4-705a-41b6-b258-0b8944d9dc0c@arm.com> <Zbje4T5tZ5k707Wg@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zbje4T5tZ5k707Wg@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 17:04, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 03:25:20PM +0530, Anshuman Khandual wrote:
>>
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
>>> When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
>>> the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
>>> set in vma_alloc_zeroed_movable_folio().
>>>
>>> Expand this to be more generic by adding an arch hook that modifes the gfp
>>> flags for an allocation when the VMA is known.
>>>
>>> Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZERO
>>> is also set; from that point of view, the current behaviour is unchanged,
>>> even though the arm64 flag is set in more places.  When arm64 will have
>>> support to reuse the tag storage for data allocation, the uses of the
>>> __GFP_ZEROTAGS flag will be expanded to instruct the page allocator to try
>>> to reserve the corresponding tag storage for the pages being allocated.
>> Right but how will pushing __GFP_ZEROTAGS addition into gfp_t flags further
>> down via a new arch call back i.e arch_calc_vma_gfp() while still maintaining
>> (vma->vm_flags & VM_MTE) conditionality improve the current scenario. Because
> I'm afraid I don't follow you.

I was just asking whether the overall scope of __GFP_ZEROTAGS flag is being
increased to cover more core MM paths through this patch. I think you have
already answered that below.

> 
>> the page allocator could have still analyzed alloc flags for __GFP_ZEROTAGS
>> for any additional stuff.
>>
>> OR this just adds some new core MM paths to get __GFP_ZEROTAGS which was not
>> the case earlier via this call back.
> Before this patch: vma_alloc_zeroed_movable_folio() sets __GFP_ZEROTAGS.
> After this patch: vma_alloc_folio() sets __GFP_ZEROTAGS.

Understood.

> 
> This patch is about adding __GFP_ZEROTAGS for more callers.

Right, I guess that is the real motivation for this patch. But just wondering
does this cover all possible anon fault paths for converting given vma_flag's
VM_MTE flag into page alloc flag __GFP_ZEROTAGS ? Aren't there any other file
besides (mm/shmem.c) which needs to be changed to include arch_calc_vma_gfp() ?

