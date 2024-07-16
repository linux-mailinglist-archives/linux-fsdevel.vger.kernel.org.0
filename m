Return-Path: <linux-fsdevel+bounces-23752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4F9325DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69194282FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0315491;
	Tue, 16 Jul 2024 11:41:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E6D22309
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130068; cv=none; b=QkCkTXM3vIBtC5Xn1RwtCrsiF4/F4aNwSFwPHlJjmKN2iGh1BKZf7RJXjkTtwQuMbWSk5I9SdhVTgQ5rRRJjZ+zRQLHlOEJdYFGpIVSrrdS38t+El0HLXSzjEdXQdyv5LRN1Ls9iaSjlW6BoCKDf+fMwrLxUJlMrT/vmEqfnsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130068; c=relaxed/simple;
	bh=cPqUIIzgMa1VyzU8Q0SG76h08e/UGrYGch/lA75gQqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyGywW3vDTM3cArenp2Jn/Ey25ZNgc/na8jUomu5n+SpbOISRIKgbelshujnjUbfhTobezE/of6zQGXI1SDojWiZ0PvWAL7h5h/1lVLgmqXQB+VHGOUAKdTUSl0GkCYxZOQRG8EtwJQtUIsQ+d+18NT5oThJeMiwjwfmfPq9HWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19091063;
	Tue, 16 Jul 2024 04:41:30 -0700 (PDT)
Received: from [10.163.52.225] (unknown [10.163.52.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB35A3F766;
	Tue, 16 Jul 2024 04:40:54 -0700 (PDT)
Message-ID: <c6812a96-4a29-40de-8ed7-e98b193121a0@arm.com>
Date: Tue, 16 Jul 2024 17:10:50 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
To: Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <18aee949-7e07-45e1-85c8-c990f017f305@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <18aee949-7e07-45e1-85c8-c990f017f305@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/24 18:37, Kevin Brodsky wrote:
> On 03/05/2024 15:01, Joey Gouly wrote:
>> @@ -267,6 +294,28 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
>>  	return -1UL >> 8;
>>  }
>>  
>> +/*
>> + * We only want to enforce protection keys on the current process
>> + * because we effectively have no access to POR_EL0 for other
>> + * processes or any way to tell *which * POR_EL0 in a threaded
>> + * process we could use.
> 
> I see that this comment is essentially copied from x86, but to me it
> misses the main point. Even with only one thread in the target process
> and a way to obtain its POR_EL0, it still wouldn't make sense to check
> that value. If we take the case of a debugger accessing an inferior via
> ptrace(), for instance, the kernel is asked to access some memory in
> another mm. However, the debugger's POR_EL0 is tied to its own address
> space, and the target's POR_EL0 is relevant to its own execution flow
> only. In such situations, there is essentially no user context for the
> access, so It fundamentally does not make sense to make checks based on
> pkey/POE or similar restrictions to memory accesses (e.g. MTE).

Indeed this makes more sense. There is no memory context even if there is
access to another POR_EL0. The comment above could be improved describing
this limitation.

