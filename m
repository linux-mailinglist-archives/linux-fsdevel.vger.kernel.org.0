Return-Path: <linux-fsdevel+bounces-9483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99C841AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480901F25BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB482381AB;
	Tue, 30 Jan 2024 04:26:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74593770A;
	Tue, 30 Jan 2024 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706588789; cv=none; b=PzLr9SHLrYjg573GOjr6XRR6i6C1pSxIAROa6MvpLEZLvwncH4B1npOre0tyVQlxwZDcdMQahvl64tCmI+ptmI18Zsz0ljMboRCI8anPFgbXoRWlouo7wekX/LO6TVhmBne4VvNTVZBxvb1UkC/xtdsT5sPF9oGvefqxoItXw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706588789; c=relaxed/simple;
	bh=OmsH5cVGc67ZoutoHVLZlyvRi+VnnD7tEU5XBBF9WIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBsMLQjTnM78Q0EYcSC5zuK//NZTY5Vcacyj51FIDgVmJzOXv+/C++KNp19F1quNFVq9fmaKUKTYXiC6aOf5BvKm3hyXfm3dyjOkswwFEjMhXV1eWBfJfyy7Rw0HqwXvxJBX6jEbwleoVItDf1oZRcx2wqCWqxpjUGxC7fR7xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D28DA7;
	Mon, 29 Jan 2024 20:27:10 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CBB3F762;
	Mon, 29 Jan 2024 20:26:13 -0800 (PST)
Message-ID: <3fbfb5fc-83a4-49da-ba75-9b671ffe0569@arm.com>
Date: Tue, 30 Jan 2024 09:56:10 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/35] mm: page_alloc: Add gfp_flags parameter to
 arch_alloc_page()
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
 <20240125164256.4147-2-alexandru.elisei@arm.com>
 <de0c74b3-0c7d-4f21-8454-659e8b616ea7@arm.com> <ZbePA2dGE6Vs-58t@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbePA2dGE6Vs-58t@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 17:11, Alexandru Elisei wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 11:18:59AM +0530, Anshuman Khandual wrote:
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> Extend the usefulness of arch_alloc_page() by adding the gfp_flags
>>> parameter.
>> Although the change here is harmless in itself, it will definitely benefit
>> from some additional context explaining the rationale, taking into account
>> why-how arch_alloc_page() got added particularly for s390 platform and how
>> it's going to be used in the present proposal.
> arm64 will use it to reserve tag storage if the caller requested a tagged
> page. Right now that means that __GFP_ZEROTAGS is set in the gfp mask, but
> I'll rename it to __GFP_TAGGED in patch #18 ("arm64: mte: Rename
> __GFP_ZEROTAGS to __GFP_TAGGED") [1].
> 
> [1] https://lore.kernel.org/lkml/20240125164256.4147-19-alexandru.elisei@arm.com/

Makes sense, but please do update the commit message explaining how
new gfp mask argument will be used to detect tagged page allocation
requests, further requiring tag storage allocation.

