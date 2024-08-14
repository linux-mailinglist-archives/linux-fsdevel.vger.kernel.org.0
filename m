Return-Path: <linux-fsdevel+bounces-25921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3D951DBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D804F28A0BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050531B3F08;
	Wed, 14 Aug 2024 14:51:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BB1B3744;
	Wed, 14 Aug 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647112; cv=none; b=s6mFy4Rwqm3dFr+hanW/n03x1nJ6nOkQRYrB0+NboQwqIlzwwghTuSnDZuc/Z4JkeZBZGRunkRfWlQ4OPYcTOfDtyNkI+cppiYDEYadnxsNCaVW9YuBBqCjOCIBw5a7VF2lwUFGfJ6FMh1SzXBFYx5FlFut6HGSK/idte/4BwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647112; c=relaxed/simple;
	bh=E1PvKzZfFbl9Y7vjlzg9rl6r2PYqNMNxihVjb/Okon4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI4JI0ZaAkoLbES6TtAguSGJfub3DbxgIzH7Qk02VZxWgcPaUFOMymyuFl4wHNOLigLEsN7Sbmz8DnnqrPJ0OVgzRQ/TDQKNgLRXLXgWUEUNPuAph+BdIoe52KAidM+ikPoROBGWIsqBwylw1ZUZMUt8g7rOKytxy4n3vpYhg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4071DA7;
	Wed, 14 Aug 2024 07:52:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6CB73F58B;
	Wed, 14 Aug 2024 07:51:44 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:51:42 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:50PM +0100, Mark Brown wrote:
> When invoking a signal handler we use the GCS configuration and stack
> for the current thread.
> 
> Since we implement signal return by calling the signal handler with a
> return address set up pointing to a trampoline in the vDSO we need to
> also configure any active GCS for this by pushing a frame for the
> trampoline onto the GCS.  If we do not do this then signal return will
> generate a GCS protection fault.
> 
> In order to guard against attempts to bypass GCS protections via signal
> return we only allow returning with GCSPR_EL0 pointing to an address
> where it was previously preempted by a signal.  We do this by pushing a
> cap onto the GCS, this takes the form of an architectural GCS cap token
> with the top bit set and token type of 0 which we add on signal entry
> and validate and pop off on signal return.  The combination of the top
> bit being set and the token type mean that this can't be interpreted as
> a valid token or address.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/gcs.h |   1 +
>  arch/arm64/kernel/signal.c   | 134 +++++++++++++++++++++++++++++++++++++++++--
>  arch/arm64/mm/gcs.c          |   1 +
>  3 files changed, 131 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c

[...]

> +#ifdef CONFIG_ARM64_GCS
> +
> +static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
> +{
> +	unsigned long __user *gcspr_el0;
> +	int ret = 0;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!task_gcs_el0_enabled(current))
> +		return 0;
> +
> +	/*
> +	 * We are entering a signal handler, current register state is
> +	 * active.
> +	 */
> +	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * Push a cap and the GCS entry for the trampoline onto the GCS.
> +	 */
> +	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
> +	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
> +	if (ret != 0)
> +		return ret;

What happens if we went wrong here, or if the signal we are delivering
was caused by a GCS overrun or bad GCSPR_EL0 in the first place?

It feels like a program has no way to rescue itself from excessive
recursion in some thread.  Is there something equivalent to
sigaltstack()?

Or is the shadow stack always supposed to be big enough to cope with
recursion that exhausts the main stack and alternate signal stack (and
if so, how is this ensured)?

> +
> +	gcsb_dsync();
> +
> +	gcspr_el0 -= 2;
> +	write_sysreg_s((unsigned long)gcspr_el0, SYS_GCSPR_EL0);
> +
> +	return 0;
> +}

[...]

Cheers
---Dave

