Return-Path: <linux-fsdevel+bounces-26471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE008959C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17D51C21C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A891917E3;
	Wed, 21 Aug 2024 12:54:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2A192D6A;
	Wed, 21 Aug 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244882; cv=none; b=ToDoclyanAW+xVNJzpN005F7wMpcezBIxOs+EhoFXyvp453QAq/5Y4Bcz54rOe3vN/T0Egww9MwTUHgjqK1AWSidS6OhKjJRQ338AO18p12jj6vLL1gOtW92yVVsIeAQ8drWxl3JyNSdmyGUUnh/ikFJ0Ekkcw7WFmgWv/BtExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244882; c=relaxed/simple;
	bh=gPZjU2t1BOenZRMDnNzEExdLNiNY+uelWC4Rm00hsJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe3inQ9tMZBy8P+3wb1x/XuM+CqUgIvxEF6h2xv/TjlWa1NgVeV7JwvyfnleYDijKfmoIc5v2/5UJ3SmfK5mIjSFrN2K7hJdvc5+LshOqqV68YXFEoVjUxZ63Z8N0vUymuvUG+h5zaRMj5ekBuKz+7Ks72ywdG5S80wOjY8DscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F86C32782;
	Wed, 21 Aug 2024 12:54:35 +0000 (UTC)
Date: Wed, 21 Aug 2024 13:54:33 +0100
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
Subject: Re: [PATCH v10 21/40] arm64/gcs: Implement shadow stack prctl()
 interface
Message-ID: <ZsXjiTlfLE61-jJC@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-21-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-21-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:48PM +0100, Mark Brown wrote:
> Implement the architecture neutral prtctl() interface for setting the

s/prtctl/prctl/

> +int arch_set_shadow_stack_status(struct task_struct *task, unsigned long arg)
> +{
> +	unsigned long gcs, size;
> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return -EINVAL;
> +
> +	if (is_compat_thread(task_thread_info(task)))
> +		return -EINVAL;
> +
> +	/* Reject unknown flags */
> +	if (arg & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +		return -EINVAL;
> +
> +	ret = gcs_check_locked(task, arg);
> +	if (ret != 0)
> +		return ret;
> +
> +	/* If we are enabling GCS then make sure we have a stack */
> +	if (arg & PR_SHADOW_STACK_ENABLE) {
> +		if (!task_gcs_el0_enabled(task)) {
> +			/* Do not allow GCS to be reenabled */
> +			if (task->thread.gcs_base)
> +				return -EINVAL;
> +
> +			if (task != current)
> +				return -EBUSY;
> +
> +			size = gcs_size(0);
> +			gcs = alloc_gcs(0, size);
> +			if (!gcs)
> +				return -ENOMEM;
> +
> +			task->thread.gcspr_el0 = gcs + size - sizeof(u64);
> +			task->thread.gcs_base = gcs;
> +			task->thread.gcs_size = size;
> +			if (task == current)
> +				write_sysreg_s(task->thread.gcspr_el0,
> +					       SYS_GCSPR_EL0);
> +
> +		}
> +	}

Nitpick: use a single 'if' instead of nesting (unless subsequent patches
add more to the first block).

Otherwise it looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

