Return-Path: <linux-fsdevel+bounces-29973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79A98447E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 13:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44703B237D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399F1A706C;
	Tue, 24 Sep 2024 11:28:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6301A705D;
	Tue, 24 Sep 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177289; cv=none; b=FKozlS4O0ovsdlfhVF/5VhnPir3C9Xj03YF01NXlPFyktS1KZI2WJZmeJxzA2DQI7EwSo9P3WxHI2Q8jiFpiXxHTYscAdXrlXzGCyWQDmPUnWr4+gUd+aicqBbSKNY/7tpKKJo8DaZRvyMx6yCH9C+T1VfHIsi15xfZnTItZlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177289; c=relaxed/simple;
	bh=w6ZtRnLtQAfgK8GE4fbEyNK/ud8SdGHKIdYvFa+frKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwRZwaqUF8sdeDpoece5WdqtSDf1b0QG6jXbKoMzXMWkDcUFEGG1Qw9pzPepyEFhqN2OAOgI2fX2NFReg0pq0tQ/j+uaEiDZAAPfJvFXcxvBHL2F6fcGLGwOoHcG+jFDetiH/1pOXTKJxDUtRUA/53yXbOc74jNba3nRlTcXXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADECDA7;
	Tue, 24 Sep 2024 04:28:34 -0700 (PDT)
Received: from [10.57.76.149] (unknown [10.57.76.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 452493F528;
	Tue, 24 Sep 2024 04:28:00 -0700 (PDT)
Message-ID: <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
Date: Tue, 24 Sep 2024 13:27:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
 broonie@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 skhan@linuxfoundation.org, szabolcs.nagy@arm.com, tglx@linutronix.de,
 will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240822151113.1479789-20-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 17:11, Joey Gouly wrote:
> @@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  		sme_smstop();
>  	}
>  
> +	if (system_supports_poe())
> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);

At the point where setup_return() is called, the signal frame has
already been written to the user stack. In other words, we write to the
user stack first, and then reset POR_EL0. This may be problematic,
especially if we are using the alternate signal stack, which the
interrupted POR_EL0 may not grant access to. In that situation uaccess
will fail and we'll end up with a SIGSEGV.

This issue has already been discussed on the x86 side, and as it happens
patches to reset PKRU early [1] have just landed. I don't think this is
a blocker for getting this series landed, but we should try and align
with x86. If there's no objection, I'm planning to work on a counterpart
to the x86 series (resetting POR_EL0 early during signal delivery).

Kevin

[1]
https://lore.kernel.org/lkml/20240802061318.2140081-2-aruna.ramakrishna@oracle.com/

> +
>  	if (ka->sa.sa_flags & SA_RESTORER)
>  		sigtramp = ka->sa.sa_restorer;
>  	else


