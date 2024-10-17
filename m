Return-Path: <linux-fsdevel+bounces-32198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AEA9A246B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA635286929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496A31DE3A6;
	Thu, 17 Oct 2024 14:00:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AE1D5154;
	Thu, 17 Oct 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173643; cv=none; b=jP8TanALyLAH6y0U0M3in5uGTmN2NdGf68MkN1xjcjBs2Qh/37WxVzO66JUjQltI0qOffRG6GHXd97UfSR9WASdY+1TZE/CqYBY7KjrHicd28cBMksUTy17/IN5d7DuG61UCyfO0gYSkcij27y1bwh102Du3yX7RgR1qP8fUUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173643; c=relaxed/simple;
	bh=nZuVhJis95dVNimUHudHNvGiNmLlOJXRRB+4qzPMuVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB1D51//HunW4UCiQgatiAJYmREWhBXWwzuEWW+36dLf8Y9Dqe1sAGJ2qaXIPlo5VEXI8y67d19fR5M0Ezt42l8B7Kb94doZQgLOCDe+H2G82r2wKgI6P/df2j+jyASp4Cye5XbPbvMqHVyAO2EAI39ceQ8WaM0LrdppNHN0zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE2BEDA7;
	Thu, 17 Oct 2024 07:01:11 -0700 (PDT)
Received: from [10.57.78.172] (unknown [10.57.78.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F7AB3F528;
	Thu, 17 Oct 2024 07:00:35 -0700 (PDT)
Message-ID: <d68c78cc-1bec-4c44-afb6-66274f831948@arm.com>
Date: Thu, 17 Oct 2024 16:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
 nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
 broonie@kernel.org, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 skhan@linuxfoundation.org, szabolcs.nagy@arm.com, tglx@linutronix.de,
 x86@kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
 <20241015114116.GA19334@willie-the-truck> <Zw6D2waVyIwYE7wd@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Zw6D2waVyIwYE7wd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 17:01, Catalin Marinas wrote:
>> We also still need to resolve Kevin's concern, which probably means
>> keeping the thread's original POR around someplace.
> If we fail to allocate context for POR_EL0 (or anything else), we'll
> deliver a SIGSEGV. I think it's quite likely that the SIGSEGV will also
> fail to allocate context we end up with a fatal SIGSEGV. Not sure the
> user can affect the allocation/layout, though it can change stack
> attributes where the frame is written.
>
> Assuming that the user tricks the kernel into failing to write the
> context but allows it to succeed on the resulting SIGSEGV, POR_EL0
> wouldn't have been reset and the SIGSEGV context will still have the
> original value. I don't think we need to do anything here for 6.12.
>
> However, in for-next/core, we have gcs_signal_entry() called after
> resetting POR_EL0. If this fails, we can end up with a new POR_EL0 on
> sigreturn (subject to the above user toggling permissions). I think this
> needs to be fixed, POR_EL0 only reset when we know we are going to
> deliver the signal.

In the series I've just posted [1], POR_EL0 is reset to "allow all"
before we do anything, so it sounds like we may have a problem there.
However, it does keep track of that state, so I think the fix may be
simple. If any error occurs in setup_rt_frame(), we could call
restore_unpriv_access_state() to restore the original value of POR_EL0,
like in sigreturn(). Otherwise we call set_handler_unpriv_access_state()
to set POR_EL0 to POR_EL0_INIT as we do today. I can make that change in
v2 if that sounds helpful.

Kevin

[1]
https://lore.kernel.org/linux-arm-kernel/20241017133909.3837547-4-kevin.brodsky@arm.com/T/#u

