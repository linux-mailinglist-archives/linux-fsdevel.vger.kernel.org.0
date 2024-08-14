Return-Path: <linux-fsdevel+bounces-25924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E2951E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF64FB286A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3A91B4C29;
	Wed, 14 Aug 2024 15:10:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E61B3F15;
	Wed, 14 Aug 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648201; cv=none; b=jPyfkvi9PsqP9yE6G4ujcWz8E15+diebxQajtI1Jp8EIIRLqz1VxHquFKFUCZMfYdufIEGbr1Y7jAzY180kW2UBVvmOtkI5TruxpRUZJXS0LO6eqMiSe2upcBqsUq+x1u7Hmqqs0wNLEo34PTgBLIowpgB1TNVf31Lm57UlC7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648201; c=relaxed/simple;
	bh=Ex5i7IuYmiDIp+jR8sdfsK2sQRn/4xZA629mGrDAPFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuTvfX5+HVKgKZGscM29tShfMeWzPiTTSSvCmcAg7MFYBiLq2HH3E0rLKBk7aANg3ESQFbxhWgAFSocdJGpqhInKf38vkgfcanuSI4UZU6pKODzkn7pw80uABRM0WX9MnTotfspnLLj3CG46NiMHSlAyDUqrnfcCkxmjWXch1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2CD2DA7;
	Wed, 14 Aug 2024 08:10:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126053F58B;
	Wed, 14 Aug 2024 08:09:53 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:09:51 +0100
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
Subject: Re: [PATCH v10 24/40] arm64/signal: Expose GCS state in signal frames
Message-ID: <ZrzIv3FWNgJizDc2@e133380.arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:51PM +0100, Mark Brown wrote:
> Add a context for the GCS state and include it in the signal context when
> running on a system that supports GCS. We reuse the same flags that the
> prctl() uses to specify which GCS features are enabled and also provide the
> current GCS pointer.
> 
> We do not support enabling GCS via signal return, there is a conflict
> between specifying GCSPR_EL0 and allocation of a new GCS and this is not
> an ancticipated use case.  We also enforce GCS configuration locking on
> signal return.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/uapi/asm/sigcontext.h |   9 +++
>  arch/arm64/kernel/signal.c               | 106 +++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)

[...]

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c

[...]

> @@ -999,6 +1092,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  			return err;
>  	}
>  
> +	if (add_all || task_gcs_el0_enabled(current)) {
> +		err = sigframe_alloc(user, &user->gcs_offset,
> +				     sizeof(struct gcs_context));
> +		if (err)
> +			return err;
> +	}
> +

Who turns on GCS?  I have a concern that if libc is new enough to be
built for GCS then the libc startup code will to turn it on, even if
the binary stack running on top of libc is old.

Whether a given library should break old binaries is a bit of a grey
area, but I think that libraries that deliberately export stable ABIs
probably shouldn't.


With that in mind, does any GCS state need to be saved at all?

Is there any scenario where it is legitimate for the signal handler to
change the shadow stack mode or to return with an altered GCSPR_EL0?

Is the guarded stack considered necessary (or at least beneficial) for
backtracing, or is the regular stack sufficient?

(I'm assuming that unwind tables / debug info should allow the shadow
stack to be unwound anyway; rather this question is about whether
software can straightforwardly find out the interrupted GCSPR_EL0
without this information... and whether it needs to.)


>  	if (system_supports_sve() || system_supports_sme()) {
>  		unsigned int vq = 0;
>  
> @@ -1099,6 +1199,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
>  	}
>  
> +	if (system_supports_gcs() && err == 0 && user->gcs_offset) {
> +		struct gcs_context __user *gcs_ctx =
> +			apply_user_offset(user, user->gcs_offset);
> +		err |= preserve_gcs_context(gcs_ctx);
> +	}
> +

[...]

Cheers
---Dave

