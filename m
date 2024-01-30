Return-Path: <linux-fsdevel+bounces-9484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A01841B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F501C24E05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC037716;
	Tue, 30 Jan 2024 04:34:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8C376F2;
	Tue, 30 Jan 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589262; cv=none; b=GBOYmue34Im2NIjgczqPnuDi+tIYHKb1GV/L++72sVh+ttgXYS+zamGTq/EodtkE/p+0BVIDDXknvXC6g2sIfVnKWjMcNRL5mCEEbnEfqlXg+J2O8WGop/8w3+B2MQtlfsKRs4jleS+nH7lhASEwaziDra7TT+rRLbdOZvH9zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589262; c=relaxed/simple;
	bh=0F5mFah0QNd5K10CodthfzW/RM1sMIaJbOS1PHFaycA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJZPbOBm2hPXH1PzWMK93ZydkpV/F+3BGnfCO4+YuArImbgAlMLsxgn2HiJA+8P7c7LCDXBS74LwQM8YAzf3MpAQAyS1NgkivuP1u1ACL8z7Y0wxjZB4cIb3LFboiCLjhmvCcND5I/z1YVs3OQL1NZJKGlxb/6F/J5ymiChgCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC74DA7;
	Mon, 29 Jan 2024 20:35:03 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3CB3F762;
	Mon, 29 Jan 2024 20:34:06 -0800 (PST)
Message-ID: <3983416f-b613-42c7-bb42-d3ab268ea1be@arm.com>
Date: Tue, 30 Jan 2024 10:04:02 +0530
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbeQBDwe8zc_pLDZ@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 17:16, Alexandru Elisei wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 02:31:23PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> The patch f945116e4e19 ("mm: page_alloc: remove stale CMA guard code")
>>> removed the CMA filter when allocating from the MIGRATE_MOVABLE pcp list
>>> because CMA is always allowed when __GFP_MOVABLE is set.
>>>
>>> With the introduction of the arch_alloc_cma() function, the above is not
>>> true anymore, so bring back the filter.
>>
>> This makes sense as arch_alloc_cma() now might prevent ALLOC_CMA being
>> assigned to alloc_flags in gfp_to_alloc_flags_cma().
> 
> Can I add your Reviewed-by tag then?

I think all these changes need to be reviewed in their entirety
even though some patches do look good on their own. For example
this patch depends on whether [PATCH 03/35] is acceptable or not.

I would suggest separating out CMA patches which could be debated
and merged regardless of this series.

