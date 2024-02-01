Return-Path: <linux-fsdevel+bounces-9798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52741844FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55E51F26379
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1493B182;
	Thu,  1 Feb 2024 03:30:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23423A8C5;
	Thu,  1 Feb 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758241; cv=none; b=hcYvPoR8W/2uCg5nc9z9glehCFcB7hL9dfV91r7N/jk36t2iDqYBb9Aiw6311tHYJ1g7psv0EX6dbjSbINqhiNwxgNQhNX8ZUHkkT1dktNcN4gACkQxM0YYtlwmQs6hBpzRpZkDOJRTsEQkGv7DNzIPpOmuViUSmdRKwqQntFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758241; c=relaxed/simple;
	bh=0U0DRnxOD6IVrdCQPmo32znrfxpOuyUvuYMn1ho150w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaU7UBeSPkm44jP2ZtQEVGGnbP0izIzyynUNf9/F/ulAMjwZtz2pXX5F2Z421wb4pV7gzH9KaGoqDUZswXuEXTNzjuyVQTeSVIPLW7fpdW7iuP7GDv0Ir8ARsg5p1rUq+j+c8b+zL1JuNpg3KYGrG+NZSkeqdZNeS45+jXdD44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B63DA7;
	Wed, 31 Jan 2024 19:31:21 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DADF33F738;
	Wed, 31 Jan 2024 19:30:26 -0800 (PST)
Message-ID: <08a4971e-c31d-46f7-afbc-7404bd9a293f@arm.com>
Date: Thu, 1 Feb 2024 09:00:23 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/35] mm: Call arch_swap_prepare_to_restore()
 before arch_swap_restore()
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-13-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-13-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> arm64 uses arch_swap_restore() to restore saved tags before the page is
> swapped in and it's called in atomic context (with the ptl lock held).
> 
> Introduce arch_swap_prepare_to_restore() that will allow an architecture to
> perform extra work during swap in and outside of a critical section.
> This will be used by arm64 to allocate a buffer in memory where to
> temporarily save tags if tag storage is not available for the page being
> swapped in.

Just wondering if tag storage will always be unavailable for tagged pages
being swapped in ? OR there are cases where allocation might not even be
required ? This prepare phase needs to be outside the critical section -
only because there might be memory allocations ?

