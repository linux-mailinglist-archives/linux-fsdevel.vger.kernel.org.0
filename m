Return-Path: <linux-fsdevel+bounces-67682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B8C46B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D049188448B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14530F94D;
	Mon, 10 Nov 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkU2Otl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044625DAEA;
	Mon, 10 Nov 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778871; cv=none; b=lwtPQC103fQJNCR2UskivSJG2oqGZBMXtQpC21zKylqZXedjwqOeVLH8j6qla5ygaTFg4+4DmbV8PWPK1dVxl82WP7d/6E8U30NVzM8U03FGjMB6KOv+x0dffzN5n/UokK9WlrL0/3TiHf1PpcYeySdPKHQTJs1/I+3DLmN9xLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778871; c=relaxed/simple;
	bh=krQuZhwpzOYT8s7UHP2yOrtuhp6BF8s1XMfmG+rag9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J58LWbv3X/a38Q7a2NwNzA/GCNykYQ/ptGOJfX46KQBpp9uH+azRBQPGLmspT0yxjP58fl7BRCJ/ioYdXPwsCfqqEWvgctMPMC1WrV8YbrxFmda0HbU9ZzdE4J7paYZDolNpIyKLsRi/wUMuDWcF3HL2URymwUi6n4190aX0j88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkU2Otl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B6C16AAE;
	Mon, 10 Nov 2025 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778870;
	bh=krQuZhwpzOYT8s7UHP2yOrtuhp6BF8s1XMfmG+rag9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkU2Otl92+NH6dS6BRxM3Pcwe5qEi0rO36rNDsE5dHY5pkl8emxeUFv5DBGqvn8m+
	 huc6rMZRzf//W1QBka7gMF2VfdmLtp27tgCpcsM67jyG6LgnY1LYqBtBUOP7xbKoF4
	 zbiKt1oAlYsXkoYlxMjROzPvk8bnqMUonRm+QHOV0gcrKvnhdPiCJNeX0MBxx+DssH
	 Y2Frbw3m3Hs/dfpCZeLPel6eYxerTlM93oEv6pFrRKhsAqhA5qXK6p2rINmTh1FmZf
	 KVtV7Rosq7FhkeR+hploLk3pK12+4sDNEwquB7tPTUXL7zFaRlM7on8PMD8r4CYLHO
	 tjU0vnabCYe9g==
Date: Mon, 10 Nov 2025 14:47:26 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
Message-ID: <aRHe3syRvOrCYC9u@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-6-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:03PM -0500, Pasha Tatashin wrote:
> In case KHO is driven from within kernel via live update, finalize will
> always happen during reboot, so add the KHO image unconditionally.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9f0913e101be..b54ca665e005 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -15,6 +15,7 @@
>  #include <linux/kexec_handover.h>
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
> +#include <linux/liveupdate.h>
>  #include <linux/memblock.h>
>  #include <linux/page-isolation.h>
>  #include <linux/vmalloc.h>
> @@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
>  	int err = 0;
>  	struct kexec_buf scratch;
>  
> -	if (!kho_out.finalized)
> +	if (!kho_out.finalized && !liveupdate_enabled())
>  		return 0;

This feels backwards, I don't think KHO should call liveupdate methods.
  
>  	image->kho.fdt = virt_to_phys(kho_out.fdt);
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

