Return-Path: <linux-fsdevel+bounces-9612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD649843478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 04:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F12288186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0512B79;
	Wed, 31 Jan 2024 03:27:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15703107A8;
	Wed, 31 Jan 2024 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706671657; cv=none; b=splrjT7XSDxUXRe1XkAUmSGnRXEUFPRCmPrvg7AAyJVrAVczIlSBEkOJ2qXPGupnJ6Gr4ETU1mgsjY7SuVLksZD8IhRM27tZxHc2S/ihEoXqhIaj+6opw4V+rQBNMAIgGmboldp/cQv6mbxDmJv8AkgmNhLfQE571D+bUK11Vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706671657; c=relaxed/simple;
	bh=fYqycNloGpwsMkxeexPEkQZeco4zUIcyy5vzedaRkTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVdvCLZ6af9MyoWc91Gy6DxPfE8ttE2IgWcBZEucSD24gxeZCxBzxLMPsCaU/0UYES7u0aBhmWjGgfWZL7E1O/qcW4MvZrJcSLboauh6vRlKf6hzFjr2/mOr3lPON5DEEmmLwCxT+KLUTkysVEof2ZW5gq2T3UKeyYPwN8xJsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D55EDA7;
	Tue, 30 Jan 2024 19:28:17 -0800 (PST)
Received: from [10.163.41.195] (unknown [10.163.41.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBBE3F5A1;
	Tue, 30 Jan 2024 19:27:21 -0800 (PST)
Message-ID: <edab95e6-e09f-4aab-a506-4ea011b1372b@arm.com>
Date: Wed, 31 Jan 2024 08:57:19 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/35] mm: page_alloc: Partially revert "mm:
 page_alloc: remove stale CMA guard code"
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
 <20240125164256.4147-5-alexandru.elisei@arm.com>
 <966a1a84-76dc-40da-bde2-251d2a81ee31@arm.com> <ZbeQBDwe8zc_pLDZ@raptor>
 <3983416f-b613-42c7-bb42-d3ab268ea1be@arm.com> <ZbjkFujWTs9zqkeD@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbjkFujWTs9zqkeD@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 17:27, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 10:04:02AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 1/29/24 17:16, Alexandru Elisei wrote:
>>> Hi,
>>>
>>> On Mon, Jan 29, 2024 at 02:31:23PM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>>>> The patch f945116e4e19 ("mm: page_alloc: remove stale CMA guard code")
>>>>> removed the CMA filter when allocating from the MIGRATE_MOVABLE pcp list
>>>>> because CMA is always allowed when __GFP_MOVABLE is set.
>>>>>
>>>>> With the introduction of the arch_alloc_cma() function, the above is not
>>>>> true anymore, so bring back the filter.
>>>>
>>>> This makes sense as arch_alloc_cma() now might prevent ALLOC_CMA being
>>>> assigned to alloc_flags in gfp_to_alloc_flags_cma().
>>>
>>> Can I add your Reviewed-by tag then?
>>
>> I think all these changes need to be reviewed in their entirety
>> even though some patches do look good on their own. For example
>> this patch depends on whether [PATCH 03/35] is acceptable or not.
>>
>> I would suggest separating out CMA patches which could be debated
>> and merged regardless of this series.
> 
> Ah, I see, makes sense. Since basically all the core mm changes are there
> to enable dynamic tag storage for arm64, I'll hold on until the series
> stabilises before separating the core mm from the arm64 patches.

Fair enough but at least could you please separate out this particular
patch right away and send across. 

mm: cma: Don't append newline when generating CMA area name

