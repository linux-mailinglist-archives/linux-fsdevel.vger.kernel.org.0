Return-Path: <linux-fsdevel+bounces-69508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3CC7E031
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCB1834B3A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A172D47EF;
	Sun, 23 Nov 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZfhzArV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0724A3E;
	Sun, 23 Nov 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763897273; cv=none; b=mQvRsBJxghmm5ZFo/kp/feAerDiqpw4+Kt0jbKBAZ77FrkX+Sna6OHU8xnI90xdosazlTHkUu3CdM4dlTFKymRdMqey8h2x/o2bqj7mYP73GLa5CebxCrprwbTnzDOo/2dsAM4iLlD3jABbtAtkWWL++cV2jzKj+PUMJZR3hd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763897273; c=relaxed/simple;
	bh=RJWIVQsLtFDoyAvibb81H4g0e9OZxXyGb1K+TZ25eXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McNZmt+mUlj+GZLnd0ZwwiFdsgW1ZzWpARz4adhHQVitCgWtgZ2mNi2O4FIh4sHxuDZMlMk9on9xIdDMyOttpATQjshANXr+cgi2m6fT3CeSKngtn4QjG6HCLBnyr/kW2bcs0g72ZVLkp+TmUQchtTE3K3uM2YpMDEBXqes9wcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZfhzArV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E13C113D0;
	Sun, 23 Nov 2025 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763897273;
	bh=RJWIVQsLtFDoyAvibb81H4g0e9OZxXyGb1K+TZ25eXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZfhzArVLsHjBLAt4XfmVUPyRn0SeJFdACvw4DklTg6IwoSkyvWAxaTwaUzX5RovI
	 8Ro3Rybx/tN/ig+tzrDpbhvhKWQs91mVGH3w1TMmmJM8GuFTmx7TRTsvjR4gzEP3Wa
	 FEDrs+JFT5Z5zVtyXtQ9gR2ileWiTGLSzoPSJMN6/ENL3Wo6C2Z8ZfNVbGgWThRiPv
	 ACYYicPxsYIB9jNmgOh5MjWjbHIHPmz5Wa1wJtO4VeYlWidpQ4Gh4m9ob80amNlYY7
	 CSHDsdJdaPIjLqr94IsAAz4Wy+fSieoJq2C2kUgoLQEWd5QCFEGKZRJZFGH7YDR9ja
	 8Q5Wl2RANnndg==
Date: Sun, 23 Nov 2025 13:27:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aSLvo0uXLOaE2JW6@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-3-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:29PM -0500, Pasha Tatashin wrote:
> Integrate the LUO with the KHO framework to enable passing LUO state
> across a kexec reboot.
> 
> This patch implements the lifecycle integration with KHO:
> 
> 1. Incoming State: During early boot (`early_initcall`), LUO checks if
>    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
>    "luo-v1" compatibility string, and reads the `liveupdate-number` to
>    track the update count.
> 
> 2. Outgoing State: During late initialization (`late_initcall`), LUO
>    allocates a new FDT for the next kernel, populates it with the basic
>    header (compatible string and incremented update number), and
>    registers it with KHO (`kho_add_subtree`).
> 
> 3. Finalization: The `liveupdate_reboot()` notifier is updated to invoke
>    `kho_finalize()`. This ensures that all memory segments marked for
>    preservation are properly serialized before the kexec jump.
> 
> LUO now depends on `CONFIG_KEXEC_HANDOVER`.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho/abi/luo.h      |  54 +++++++++++
>  kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
>  kernel/liveupdate/luo_internal.h |  22 +++++
>  3 files changed, 229 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/kho/abi/luo.h
>  create mode 100644 kernel/liveupdate/luo_internal.h
> 
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> new file mode 100644
> index 000000000000..8523b3ff82d1
> --- /dev/null
> +++ b/include/linux/kho/abi/luo.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: Live Update Orchestrator ABI
> + *
> + * This header defines the stable Application Binary Interface used by the
> + * Live Update Orchestrator to pass state from a pre-update kernel to a
> + * post-update kernel. The ABI is built upon the Kexec HandOver framework
> + * and uses a Flattened Device Tree to describe the preserved data.
> + *
> + * This interface is a contract. Any modification to the FDT structure, node
> + * properties, compatible strings, or the layout of the `__packed` serialization
> + * structures defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the relevant `_COMPATIBLE` string to
> + * prevent a new kernel from misinterpreting data from an old kernel.

From v6 thread:

> > I'd add a sentence that stresses that ABI changes are possible as long they
> > include changes to the FDT version.
> > This is indeed implied by the last paragraph, but I think it's worth
> > spelling it explicitly.
> >
> > Another thing that I think this should mention is that compatibility is
> > only guaranteed for the kernels that use the same ABI version.
> 
> Sure, I will add both.

Looks like it fell between the cracks :/

> +static int __init liveupdate_early_init(void)
> +{
> +	int err;
> +
> +	err = luo_early_startup();
> +	if (err) {
> +		luo_global.enabled = false;
> +		luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> +				 ERR_PTR(err));

What's wrong with a plain panic()?

> +	}
> +
> +	return err;
> +}
> +early_initcall(liveupdate_early_init);
> +

...

>  int liveupdate_reboot(void)
>  {
> -	return 0;
> +	int err;
> +
> +	if (!liveupdate_enabled())
> +		return 0;
> +
> +	err = kho_finalize();
> +	if (err) {
> +		pr_err("kho_finalize failed %d\n", err);

Nit: why not %pe?

> +		/*
> +		 * kho_finalize() may return libfdt errors, to aboid passing to
> +		 * userspace unknown errors, change this to EAGAIN.
> +		 */
> +		err = -EAGAIN;
> +	}
> +
> +	return err;
>  }
>  
>  /**
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> new file mode 100644
> index 000000000000..8612687b2000
> --- /dev/null
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef _LINUX_LUO_INTERNAL_H
> +#define _LINUX_LUO_INTERNAL_H
> +
> +#include <linux/liveupdate.h>
> +
> +/*
> + * Handles a deserialization failure: devices and memory is in unpredictable
> + * state.
> + *
> + * Continuing the boot process after a failure is dangerous because it could
> + * lead to leaks of private data.
> + */
> +#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)

Let's add this when we have more than a single callsite.
Just use panic() in liveupdate_early_init() and add the comment there.

> +
> +#endif /* _LINUX_LUO_INTERNAL_H */
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 

-- 
Sincerely yours,
Mike.

