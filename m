Return-Path: <linux-fsdevel+bounces-24257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1093C6CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5F41C21FE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D619D894;
	Thu, 25 Jul 2024 15:49:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD019B3D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922557; cv=none; b=ZgMz0ryZ4iHMmz6c+t7wwZ3mt9yMwAdSvqlm5AOhntzBS3rHiYgsSdVLRD9VM1UlrXPL9IIhBj8heMTWK4qKISYVmvOETc9rGytuqk8RM+SEjZ5ugnFd32t3koQL1IvnB0IW+oy8ufEVoDg6UiwPA7cf4b862EGlqt1ED36YdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922557; c=relaxed/simple;
	bh=RJYw0pND0OcBMJQdBlB5c5gKpbzA1lyRCnIAkzvS7VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwnZc6ehe5MGY19Cu2Nnyi9kiqY+OtPc6hkN+YArsNFd6yh5VzXwdbieFu9JU8sdcEzAxHl+RK3b22i210PnRlEqFxKrDxGV59/+DZb7fqDIMKqhp6Rm+NHX54vYOO2YJWYnxtzV2Bs0weOGhmpuNlO5bUpOLLT3dXYNBb4Te/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990801596;
	Thu, 25 Jul 2024 08:49:40 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 684063F766;
	Thu, 25 Jul 2024 08:49:11 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:49:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 10/29] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <ZqJz9EoqJE95Oe7g@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-11-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-11-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:28PM +0100, Joey Gouly wrote:
> Expose a HWCAP and ID_AA64MMFR3_EL1_S1POE to userspace, so they can be used to
> check if the CPU supports the feature.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> This takes the last bit of HWCAP2, is this fine? What can we do about more features in the future?
> 
> 
>  Documentation/arch/arm64/elf_hwcaps.rst |  2 ++
>  arch/arm64/include/asm/hwcap.h          |  1 +
>  arch/arm64/include/uapi/asm/hwcap.h     |  1 +
>  arch/arm64/kernel/cpufeature.c          | 14 ++++++++++++++
>  arch/arm64/kernel/cpuinfo.c             |  1 +
>  5 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> index 448c1664879b..694f67fa07d1 100644
> --- a/Documentation/arch/arm64/elf_hwcaps.rst
> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> @@ -365,6 +365,8 @@ HWCAP2_SME_SF8DP2
>  HWCAP2_SME_SF8DP4
>      Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
>  
> +HWCAP2_POE
> +    Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.

Nit: unintentionally dropped blank line before the section heading?

>  
>  4. Unused AT_HWCAP bits
>  -----------------------

[...]

Cheers
---Dave

