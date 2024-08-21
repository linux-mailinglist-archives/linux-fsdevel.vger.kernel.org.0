Return-Path: <linux-fsdevel+bounces-26513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E595A40C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27F51F25DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F61B2EF8;
	Wed, 21 Aug 2024 17:40:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015C1B2EDE;
	Wed, 21 Aug 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262028; cv=none; b=U0Mrp16t8SNuVhKrHhAS057tCsNmBhWaRUjsvZixG9IjvbJfZ3vYT5cWjKxyx+bP3J33YoRlQ2W+6hiIN+1NJVoaivBggqrj7Sb9u0J/5+5O7OYjR+4ZpuMN9LP3vIH2xwBDC3UWsY1rqX6QFPCmrhIZTykAgwyUTXblXN1RlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262028; c=relaxed/simple;
	bh=3jSo8xTV6g9gk/XnSONwS00e5gGR/ZZ3onU+FR9wQio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyTxCN/8YGTCW4g6AdSboYlFeBlnO9ctQWrlWOORPeuh6AmruK8RCfO+WH0yOpz9N5J2tuCmyb+AinaSz8KhjygqasbZ8jfqf54Hn0yFLfuliFkfkKWRL5rEKaV+wXX5Eq0bSK/fkbprEXiInNlVA1j5ANUKlSKWk0Yf8d7TIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67B2C32781;
	Wed, 21 Aug 2024 17:40:22 +0000 (UTC)
Date: Wed, 21 Aug 2024 18:40:20 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 24/40] arm64/signal: Expose GCS state in signal frames
Message-ID: <ZsYmhHHmqSu7wWWW@arm.com>
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
> @@ -636,6 +639,81 @@ extern int restore_zt_context(struct user_ctxs *user);
>  
>  #endif /* ! CONFIG_ARM64_SME */
>  
> +#ifdef CONFIG_ARM64_GCS
> +
> +static int preserve_gcs_context(struct gcs_context __user *ctx)
> +{
> +	int err = 0;
> +	u64 gcspr;
> +
> +	/*
> +	 * We will add a cap token to the frame, include it in the
> +	 * GCSPR_EL0 we report to support stack switching via
> +	 * sigreturn.
> +	 */
> +	gcs_preserve_current_state();
> +	gcspr = current->thread.gcspr_el0 - 8;

We discussed briefly offline. Not a problem in this patch but
gcs_preserve_current_state() only saves it conditionally on GCS being
enabled for the task. However, you mentioned that the register is always
available to the user, so I'd rather change the preserving function to
save it unconditionally.

> +
> +	__put_user_error(GCS_MAGIC, &ctx->head.magic, err);
> +	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
> +	__put_user_error(gcspr, &ctx->gcspr, err);
> +	__put_user_error(0, &ctx->reserved, err);
> +	__put_user_error(current->thread.gcs_el0_mode,
> +			 &ctx->features_enabled, err);
> +
> +	return err;
> +}
> +
> +static int restore_gcs_context(struct user_ctxs *user)
> +{
> +	u64 gcspr, enabled;
> +	int err = 0;
> +
> +	if (user->gcs_size != sizeof(*user->gcs))
> +		return -EINVAL;
> +
> +	__get_user_error(gcspr, &user->gcs->gcspr, err);
> +	__get_user_error(enabled, &user->gcs->features_enabled, err);
> +	if (err)
> +		return err;
> +
> +	/* Don't allow unknown modes */
> +	if (enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +		return -EINVAL;
> +
> +	err = gcs_check_locked(current, enabled);
> +	if (err != 0)
> +		return err;
> +
> +	/* Don't allow enabling */
> +	if (!task_gcs_el0_enabled(current) &&
> +	    (enabled & PR_SHADOW_STACK_ENABLE))
> +		return -EINVAL;

We don't allow enabling and that's fine but we don't restore gcspr
either with this early return.

> +
> +	/* If we are disabling disable everything */
> +	if (!(enabled & PR_SHADOW_STACK_ENABLE))
> +		enabled = 0;
> +
> +	current->thread.gcs_el0_mode = enabled;
> +
> +	/*
> +	 * We let userspace set GCSPR_EL0 to anything here, we will
> +	 * validate later in gcs_restore_signal().
> +	 */
> +	current->thread.gcspr_el0 = gcspr;
> +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);

I think you should move this further up unconditionally.

-- 
Catalin

