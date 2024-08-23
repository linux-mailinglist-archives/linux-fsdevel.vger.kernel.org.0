Return-Path: <linux-fsdevel+bounces-26917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C695D04B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B332B268EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931918859A;
	Fri, 23 Aug 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZqjTOS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C41EB27;
	Fri, 23 Aug 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424340; cv=none; b=cpihHkgP+2FhBTuBkhas0ciB01ESbx/AS2Y2P7EKzXNjwyvkmLLU4VS2bxHLKxTuE3EA5S0KXOS5QRkGDUr6NirwEhkj3WqtuGVctEa27Jgyt1IvSdw7eEeIzpSOQ0ToLX4+yG8hLH1SFKOz/QvH+yZoF1opVYrc5tYJeDm5Z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424340; c=relaxed/simple;
	bh=W6z8CSJIQISlh38AzR3KbpPdvjf84h6oaEwrIWjYySE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ZmO2Gmj51N62pxDAWIQI+14D4sDV7LvEZq18sMx2/i6LPcVbv7xd5KQGWTfi7XGkh9wp8JZ26PwzX1mSXfqOR4HRAUFugptPoDMkPsx05YwjDmEaUGNdLpRw6gZ3fDjDPfATKwRgQK3noeKa939DfVVbSUpVChly9NM2qOq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZqjTOS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE55C32786;
	Fri, 23 Aug 2024 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724424340;
	bh=W6z8CSJIQISlh38AzR3KbpPdvjf84h6oaEwrIWjYySE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZqjTOS2yJ3SZLJsVGt+kPr01XngWDjZhXRB11P59QKeuj0yVdJ2sI1jiTOtfwc1l
	 0KofF0+gZW+2ilrX698/xbyYRzb0afe9ZQFHS1eX/89s0tT+SeZqTHYfl0x18Zexz+
	 ojJmzjO42Pp6SJ9/97BgEuwauVrtWeqDuXAITbu5HlICS/eRA8zhCqnIg8SX7Th28A
	 y7taxVji40p7C4F97d5UAN7RkOd33c6kp1ratVeJjgaBBAfyebkKljPHUnl0HXwW3X
	 1mwWo5iqo+efoKR6XMU/0Rs+9uXSAMETOVivGRw42b48YIgSaoiHjeAEww/ehNsqRy
	 s82ANrYxvLTLA==
Date: Fri, 23 Aug 2024 15:45:32 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <20240823144531.GH32156@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822151113.1479789-7-joey.gouly@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> POR_EL0 is a register that can be modified by userspace directly,
> so it must be context switched.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>  arch/arm64/include/asm/processor.h  |  1 +
>  arch/arm64/include/asm/sysreg.h     |  3 +++
>  arch/arm64/kernel/process.c         | 28 ++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+)

[...]

> +static void permission_overlay_switch(struct task_struct *next)
> +{
> +	if (!system_supports_poe())
> +		return;
> +
> +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +	if (current->thread.por_el0 != next->thread.por_el0) {
> +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */

nit: typo "chaning".

But more substantially, is this just to prevent spurious faults in the
context of a new thread using a stale value for POR_EL0?

Will

