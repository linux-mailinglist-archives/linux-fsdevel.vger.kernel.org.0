Return-Path: <linux-fsdevel+bounces-26510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474D95A3E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F87A282081
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0021B2EF7;
	Wed, 21 Aug 2024 17:28:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F21B253C;
	Wed, 21 Aug 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261337; cv=none; b=q06jyhh9bZv/T5lnAuPGCMD8NzpC4vo3NArvr/xjs1denxwYDUzwnFdq1PZHYAHgmO4fwkTiip2FUwgcO1p6nHfGhcvLZvhqrV8Vv1HQfdZLfzrKuzcVLrM7kBK+wqYncpAcG6Q5wY8rDOy0BA7C7wjQwhXpn5X0zR7sSFcpjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261337; c=relaxed/simple;
	bh=Y36hndsmna6Cj17isFdEqLLJSj8xaaWul7b+DjkH7Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/8bKfZqzNpmtxon0MFyoACeCTJBg3bsJJb4ZYWip7bOSc9buoBdhcErt7koe5GkByGJg+JwzEsFXiKHlJa6UHmssoTFnTxGL/yUUG0W/YqapW2Gkc4kRg7Y9J7p2Akr7H3rAvylo6lityM8nIdEpGkFuqqPsQUs935KEqV94GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439DCC4AF09;
	Wed, 21 Aug 2024 17:28:51 +0000 (UTC)
Date: Wed, 21 Aug 2024 18:28:49 +0100
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
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZsYj0YYMuX1YRBZT@arm.com>
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
> @@ -860,6 +892,50 @@ static int restore_sigframe(struct pt_regs *regs,
>  	return err;
>  }
>  
> +#ifdef CONFIG_ARM64_GCS
> +static int gcs_restore_signal(void)
> +{
> +	u64 gcspr_el0, cap;

Nitpick: use 'unsigned long __user *gcspr_el0' as in the
gcs_signal_entry(). It's more consistent and probably less casting.

> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> +		return 0;
> +
> +	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
> +	 */
> +	gcsb_dsync();
> +	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
> +	if (ret)
> +		return -EFAULT;

Can the user change GCSPR_EL0 to a non-shadow-stack region, fake the
cap before sigreturn? copy_from_user() cannot check it's a GCS page.
Does it actually matter?

> @@ -1130,7 +1209,50 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
>  	return 0;
>  }
>  
> -static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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

Doesn't the second put_user_gcs() override the previous ret?

> +
> +	gcsb_dsync();

Wondering if we need the barrier both for entry and restore. If the
restore happens on another CPU, we have the barriers in the context
switch code already. If it's only the kernel writing the caps with
GCSSTTR on setting up the stack and checking it on return, a single
barrier is sufficient (can be this one). If the user can write something
on the stack or maybe doing a sigreturn without fully unwinding the
stack, we may need both. Either way, it would help to add some comments
on these barriers.

-- 
Catalin

