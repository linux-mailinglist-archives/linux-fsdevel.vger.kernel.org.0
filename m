Return-Path: <linux-fsdevel+bounces-9619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EF084365B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930B6287024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34B3E479;
	Wed, 31 Jan 2024 06:00:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F93DBB7;
	Wed, 31 Jan 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680802; cv=none; b=t76wzt0gx18c7s/o1Zv72GPuaw9ToCWlzQqDW4QsH/u59KnjY/h7X8iNIMGPiNiQIZKJ6jCnhwUA+0xN4dWQHfhHHdXDhIu215OOusUguMJ1xRw2olkZ3RjyFuG6ayA49FiRfcA0hm8+g2RUF8+omzKH/jBa54HIVwr7qs9ySuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680802; c=relaxed/simple;
	bh=LfvQ3qAas7dc9Kho/inAFjp0k7QeB/Phd/4o/C6refo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCoTf3pTKm0ARbVDwOAX7Pu0qN1yhGurjYc67U5p9jHVXUImKjzgWYGHmuEUgF/RnLFjlLsuOFV+XqCuFPC5RiU3KTLXNMOHvrm3mEGnjdiMSkfVar62AL3PxTRySqwT6Gje7Lhu0MFbf38Om0uCiKlSa+a9Dr2I9BKhulF81dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EAFADA7;
	Tue, 30 Jan 2024 22:00:37 -0800 (PST)
Received: from [10.163.41.195] (unknown [10.163.41.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16933F738;
	Tue, 30 Jan 2024 21:59:41 -0800 (PST)
Message-ID: <1fcf38b4-b0ff-40ec-8ac0-730c8bfd57ff@arm.com>
Date: Wed, 31 Jan 2024 11:29:39 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/35] mm: cma: Add CMA_RELEASE_{SUCCESS,FAIL}
 events
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
 <20240125164256.4147-8-alexandru.elisei@arm.com>
 <545bb7bd-31c7-4166-9f81-778b82ece6d4@arm.com> <ZbeRs-vIDWGlpcGV@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbeRs-vIDWGlpcGV@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 17:23, Alexandru Elisei wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 03:01:24PM +0530, Anshuman Khandual wrote:
>>
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> Similar to the two events that relate to CMA allocations, add the
>>> CMA_RELEASE_SUCCESS and CMA_RELEASE_FAIL events that count when CMA pages
>>> are freed.
>> How is this is going to be beneficial towards analyzing CMA alloc/release
>> behaviour - particularly with respect to this series. OR just adding this
>> from parity perspective with CMA alloc side counters ? Regardless this
>> CMA change too could be discussed separately.
> Added for parity and because it's useful for this series (see my reply to
> the previous patch where I discuss how I've used the counters).

As mentioned earlier, a new CONFIG_CMA_SYSFS element 'cma->nr_freed_pages'
could be instrumented in cma_release()'s success path for this purpose.
But again the failure path is not of much value as it could only happen
when there is an invalid input from the caller i.e when cma_pages_valid()
check fails.

