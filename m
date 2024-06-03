Return-Path: <linux-fsdevel+bounces-20798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9E8D7E65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B00283087
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BC7E110;
	Mon,  3 Jun 2024 09:22:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2253392
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406519; cv=none; b=PjZyXPCKtvfPFLX4tD4fdNi7Hv1KTKqxU9QpXjigd8aXJVArsJlz0rfD7tZqQaOnWxob9bNmoM9e/E7HQzzGNM5QU5QHMoUpU6mhfiwOl8ynTbTiAKv7HxhVDGxQvB8ssgEWPXHvwFE9OZeiRyqFIenAQhmDF6P8aCO2LWdqqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406519; c=relaxed/simple;
	bh=qoK6Vr3POzDChICSFnKDCHg67IUVeSeJ5myh4uqVVis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tp6hJTTl7McD0aoD12GKATGRm+mrrbY7wLh1K+Kir6BY8cONGQDqeajGSRHf+V3UBpZdgUmcy52cMyUNbpotw+iOs89yxHBg7+R7JByze0BzyRU8+HXScCLtPgHQJaKmrlLusy1M6XZayKU2XO/Xmg6TPO54jLuwGXviGi3cTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C731042;
	Mon,  3 Jun 2024 02:22:22 -0700 (PDT)
Received: from [10.162.42.12] (a077841.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005CB3F762;
	Mon,  3 Jun 2024 02:21:49 -0700 (PDT)
Message-ID: <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
Date: Mon, 3 Jun 2024 14:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
To: Mark Brown <broonie@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
 akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
 mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
 oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
 tglx@linutronix.de, will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
Content-Language: en-US
From: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
In-Reply-To: <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/24 22:09, Mark Brown wrote:
> On Tue, May 28, 2024 at 12:26:54PM +0530, Amit Daniel Kachhap wrote:
>> On 5/3/24 18:31, Joey Gouly wrote:
> 
>>> +#define POE_MAGIC	0x504f4530
> 
>>> +struct poe_context {
>>> +	struct _aarch64_ctx head;
>>> +	__u64 por_el0;
>>> +};
> 
>> There is a comment section in the beginning which mentions the size
>> of the context frame structure and subsequent reduction in the
>> reserved range. So this new context description can be added there.
>> Although looks like it is broken for za, zt and fpmr context.
> 
> Could you be more specific about how you think these existing contexts
> are broken?  The above looks perfectly good and standard and the
> existing contexts do a reasonable simulation of working.  Note that the
> ZA and ZT contexts don't generate data payload unless userspace has set
> PSTATE.ZA.

Sorry for not being clear on this as I was only referring to the
comments in file arch/arm64/include/uapi/asm/sigcontext.h and no code
as such is broken.

  * Allocation of __reserved[]:
  * (Note: records do not necessarily occur in the order shown here.)
  *
  *      size            description
  *
  *      0x210           fpsimd_context
  *       0x10           esr_context
  *      0x8a0           sve_context (vl <= 64) (optional)
  *       0x20           extra_context (optional)
  *       0x10           terminator (null _aarch64_ctx)
  *
  *      0x510           (reserved for future allocation)

Here I think that optional context like za, zt, fpmr and poe should have
size mentioned here to make the description consistent.As you said ZA
and ZT context are enabled by userspace so some extra details can be
added for them too.


