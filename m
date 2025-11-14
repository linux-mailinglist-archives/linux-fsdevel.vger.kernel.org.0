Return-Path: <linux-fsdevel+bounces-68470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27EC5CE2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDA024EB788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFC313E2E;
	Fri, 14 Nov 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awS3On4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEE221DB6;
	Fri, 14 Nov 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119880; cv=none; b=nzSAulhk/665+9h6sr+qtwGz9sH8cXDbQnluCMhEDfFzKUFoekOhrOy/e82fcKctbzrXGJde5vhOqo5i8G3hCODECx7EYyeGINDXbsHnflpKbBGM0qCLz7TkLeqIDjmoYojH0Ni3y6V0UkGVQKDrbtNQtnYxSB02Rn11PrRIIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119880; c=relaxed/simple;
	bh=GaRt8mZMwQZGrcQ9Qajr5lrJ1sWQayWo13cA4bzwsac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+okO7gO88JMe4wfCEn2+39dDHLbB8VKpNdm4IgZJzMAIIOk6pgozfjnAsBWc/j2Y3F+xKq9vPHUW90+cpd3mbJwzWmcfRmmAszeztIVCkSHlkkUfpaooyaSFfKowSpFmg0443GlcIl00POEN5+BO71Eha40Xpx0PXcqpy3oEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awS3On4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E5FC4AF09;
	Fri, 14 Nov 2025 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119880;
	bh=GaRt8mZMwQZGrcQ9Qajr5lrJ1sWQayWo13cA4bzwsac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awS3On4flAlVPXnqWsYldgKjJTlVNUrXTI2f2IlBW0Mq9huNwec+HzA0o2vnASTRC
	 s2wSviLIQxbhJS1cgM3qY8D+PSZoNgxQLJMbhP+D59wrYAIcUTPU1nUTw4uc+kF49i
	 JZl4ja3iTV9+fg9wbvIbbTxkq6hsIQgI5Ek89x+esVIdOSLBBLRZ7QnfRZ0otnljJz
	 3Wh4BzCs3j8rdc77ctn6nYA6gqtu42YDZ1g0kDPONFM3yPke2HC09711bzh/M3eSqC
	 3IN+FfC2sw+CV8iY/M1yskLGfYGhXR7k9C8E7qVXe1HT8PbeiIKUpTprYobKNaWtKt
	 weG4if40H1QMQ==
Date: Fri, 14 Nov 2025 13:30:53 +0200
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
Subject: Re: [PATCH v5 03/22] reboot: call liveupdate_reboot() before kexec
Message-ID: <aRcS7YU0CGc4NdKX@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-4-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:01PM -0500, Pasha Tatashin wrote:
> Modify the reboot() syscall handler in kernel/reboot.c to call
> liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
> command.
> 
> This ensures that the Live Update Orchestrator is notified just
> before the kernel executes the kexec jump. The liveupdate_reboot()
> function triggers the final freeze event, allowing participating
> FDs perform last-minute check or state saving within the blackout
> window.
> 
> The call is placed immediately before kernel_kexec() to ensure LUO
> finalization happens at the latest possible moment before the kernel
> transition.
> 
> If liveupdate_reboot() returns an error (indicating a failure during
> LUO finalization), the kexec operation is aborted to prevent proceeding
> with an inconsistent state.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/reboot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ec087827c85c..bdeb04a773db 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,6 +13,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/liveupdate.h>
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> @@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	case LINUX_REBOOT_CMD_KEXEC:
> +		ret = liveupdate_reboot();
> +		if (ret)
> +			break;

As we discussed elsewhere, let's move the call to liveupdate_reboot() to
kernel_kexec().

>  		ret = kernel_kexec();
>  		break;
>  #endif
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

