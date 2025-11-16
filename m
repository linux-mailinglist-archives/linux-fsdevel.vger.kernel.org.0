Return-Path: <linux-fsdevel+bounces-68611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA27C614E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAAF44E7CBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA72D8795;
	Sun, 16 Nov 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieh1SlTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F2236EE;
	Sun, 16 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763297036; cv=none; b=hDDCHWr+ehMLMRfm4qb1ytiIvYSO3fxYTQ7rm8Eh1C+R63Qk/vGj1vNkyxCX2LCWr0YPHHPECa8pKNa986LzkeRA+MZIAVyvgMr39dxEchlVfEaaPLGfRyVM6fj8ZnqCS56RSfRKH4oOTKQKzwqpVHy/dkXqoOv9q0X3192m9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763297036; c=relaxed/simple;
	bh=wWgCpDj9fkSDw4SXrRucTxci3O9QnA85j+Vg+gKkTZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fubKzZduHP9pHTiP/IRYn9jp14wy0Zn+U4c9e3U5g3GkLNlP3vPFbJJX1cki6Luma9XH9y17zJmzR4vU5ypoDrGwmUSRv1ZaoKlrpskUtp+s4cJT2CZWXwOh+tz9TVmcN0LjP4ARDYjG1T6OVNfGNf0zS0UIuUZdio/Eb/6dQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieh1SlTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C659C4CEF1;
	Sun, 16 Nov 2025 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763297035;
	bh=wWgCpDj9fkSDw4SXrRucTxci3O9QnA85j+Vg+gKkTZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieh1SlTXRyDrT+ZZELMQ4or1AmZFhWxyj0uZvf0u87CtZbeGdiEpozUfnNNr1l+mb
	 sMrREnOzqiH3M4E0YXtb4+WG+/Tn8ZbGqeMJxNZK2uu4C0EPHlmGSBtACovs10gEaR
	 dbIJvUIgAOALfJHE7yK/czgKIPoIma6GCIhWXV74j+3uM3Z8UY8R/EqXgcGrEQl/GG
	 dl9EUPpRD6FQMFDPDUEhCxjwC4KPkRq+y98WArsZWKSjf7/AuHH9IF4TVYL3qbB+5C
	 Pf262w+HheFYjusQSjF7Z5PIClenH85cNiEddYc2DBJxABYjoDYbtHZbpgH7fvHatP
	 vzplMQ3ly0JNw==
Date: Sun, 16 Nov 2025 14:43:31 +0200
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
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <aRnG8wDSSAtkEI_z@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-3-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:48PM -0500, Pasha Tatashin wrote:
> Integrate the LUO with the KHO framework to enable passing LUO state
> across a kexec reboot.
> 
> When LUO is transitioned to a "prepared" state, it tells KHO to
> finalize, so all memory segments that were added to KHO preservation
> list are getting preserved. After "Prepared" state no new segments
> can be preserved. If LUO is canceled, it also tells KHO to cancel the
> serialization, and therefore, later LUO can go back into the prepared
> state.
> 
> This patch introduces the following changes:
> - During the KHO finalization phase allocate FDT blob.

This happens much earlier, isn't it?

> - Populate this FDT with a LUO compatibility string ("luo-v1").
> 
> LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
> logic (`luo_do_*_calls`) remains unimplemented in this patch.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate/abi/luo.h |  54 ++++++++++
>  kernel/liveupdate/luo_core.c       | 153 ++++++++++++++++++++++++++++-
>  2 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/liveupdate/abi/luo.h
> 
> diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
> new file mode 100644
> index 000000000000..9483a294287f
> --- /dev/null
> +++ b/include/linux/liveupdate/abi/luo.h
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

I'd add a sentence that stresses that ABI changes are possible as long they
include changes to the FDT version.
This is indeed implied by the last paragraph, but I think it's worth
spelling it explicitly.

Another thing that I think this should mention is that compatibility is
only guaranteed for the kernels that use the same ABI version.

> + *
> + * FDT Structure Overview:
> + *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
> + *   This entry contains an FDT with the following layout:
> + *
> + *   .. code-block:: none
> + *
> + *     / {
> + *         compatible = "luo-v1";
> + *         liveupdate-number = <...>;
> + *     };
> + *
> + * Main LUO Node (/):
> + *
> + *   - compatible: "luo-v1"
> + *     Identifies the overall LUO ABI version.
> + *   - liveupdate-number: u64
> + *     A counter tracking the number of successful live updates performed.
> + */
...

> +static int __init liveupdate_early_init(void)
> +{
> +	int err;
> +
> +	err = luo_early_startup();
> +	if (err) {
> +		pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> +		       ERR_PTR(err));

How do we report this to the userspace?
I think the decision what to do in this case belongs there. Even if it's
down to choosing between plain kexec and full reboot, it's still a policy
that should be implemented in userspace.

> +		luo_global.enabled = false;
> +	}
> +
> +	return err;
> +}
> +early_initcall(liveupdate_early_init);

-- 
Sincerely yours,
Mike.

