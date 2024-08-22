Return-Path: <linux-fsdevel+bounces-26787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14595BACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B19286E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C81CCB2D;
	Thu, 22 Aug 2024 15:44:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1A17C7C9;
	Thu, 22 Aug 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341461; cv=none; b=QgOtT3Ixp3X9Qzi+PQLKmgnV9oOiL2gu3pqiZqOWje8igZKaLAMpOYNxJ5D9BfIvIWQhkE8SxpqjGpPlRzL3i0XwEMO1CWpL0esqone5Eh50EPwvKTODtURoj+Z0ULceeSnN9MslH/w8eDqPU2kVfS8zsNNxw0zPua1v7YjM+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341461; c=relaxed/simple;
	bh=ZOEMpQPu9K+XfBr85CGnu17+4EMpvj/m9mXtvb+H1ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3xfbOgB0hUARROc8LCF+utku2OhFR2EVIYlePCmRjNNodvGsWOhJDYE8Gvl2zzTtomKtAva++H8A7TLDWc3a5tIKzkLu3a9imYrgjkjAOygXSrR/8fm32KKXmx7GHxtW9Z2MxMSf2GUlwtCElQ8Ism/oonBMmE2XQ1O8RYvWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD5C32782;
	Thu, 22 Aug 2024 15:44:14 +0000 (UTC)
Date: Thu, 22 Aug 2024 16:44:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 18/39] arm64/traps: Handle GCS exceptions
Message-ID: <ZsdczGTaMgZnEaDy@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-18-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-18-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:21AM +0100, Mark Brown wrote:
> +static void noinstr el0_gcs(struct pt_regs *regs, unsigned long esr)
> +{
> +	enter_from_user_mode(regs);
> +	local_daif_restore(DAIF_PROCCTX);
> +	do_el0_gcs(regs, esr);
> +	exit_to_user_mode(regs);
> +}
> +
>  static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
>  {
>  	enter_from_user_mode(regs);
> @@ -766,6 +786,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>  	case ESR_ELx_EC_MOPS:
>  		el0_mops(regs, esr);
>  		break;
> +	case ESR_ELx_EC_GCS:
> +		el0_gcs(regs, esr);
> +		break;
>  	case ESR_ELx_EC_BREAKPT_LOW:
>  	case ESR_ELx_EC_SOFTSTP_LOW:
>  	case ESR_ELx_EC_WATCHPT_LOW:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9e22683aa921..d410dcc12ed8 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -500,6 +500,16 @@ void do_el1_bti(struct pt_regs *regs, unsigned long esr)
>  	die("Oops - BTI", regs, esr);
>  }
>  
> +void do_el0_gcs(struct pt_regs *regs, unsigned long esr)
> +{
> +	force_signal_inject(SIGSEGV, SEGV_CPERR, regs->pc, 0);
> +}

Just double checking: a GCSPOPM (for example, it can be a RET) from a
non-GCS page would generate a classic permission fault with ISS2.GCS set
rather than a GCS exception. That's my reading from the Arm ARM
pseudocode, the text isn't clear to me.

-- 
Catalin

