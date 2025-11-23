Return-Path: <linux-fsdevel+bounces-69518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E161C7E2A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763824E2773
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B02156C6A;
	Sun, 23 Nov 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce4qJKQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9629AB1A;
	Sun, 23 Nov 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911811; cv=none; b=gbDrwQZ8ivVs6Lx8UB3+ZPUCG9diNoHI1/dB4ohYfTpvJahi/KeRjVwTkoaJkeL0SHdC9QJsm3JpvdbvtJoenbpzxOOruJnUJk/eyJWkOKZSlCaSlkFYSZ2l19fzXEdLQqB6yJnrVm6P21HZQZHaMRNh6XmevCdKm/e8P/NGZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911811; c=relaxed/simple;
	bh=sbU7eVp3mgDSt5xPnwvjDRc6ZpRDTkp4dPpqxTd0hY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcvjTy5MLcZtz6BEvObwkb+CADBfhCnxyh4SI5e9DY8NIxdvlEOOkLEnUULSJjHfAm4RFHTbGjfD9iAm1H06xneK39RBxkhekAuAUK+3jpQQJXcsS9ZPikzGWQyh+4XS+CQI0dSI93Tyc5Uri8xaQBxrrJn3jM3QTEtsQZgFMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce4qJKQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75988C113D0;
	Sun, 23 Nov 2025 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763911811;
	bh=sbU7eVp3mgDSt5xPnwvjDRc6ZpRDTkp4dPpqxTd0hY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce4qJKQrDFTadmY+pK87YrLjQwwpdOXw9MPMemJsv5q6V5VTAgKNpSVXXF1HMX+gW
	 y7ITTZq/qNsL893/WbfpCeXI6PDAv6UpSGA1e2QWGxtfOQ0t+Y0oyBVsChod3uc5X8
	 uHrh0JXcsUDEbg5M0FdHOx19+BgL/yulj++EH4t50HlEz9gHX5HfsO4SthhtH3cz07
	 Lo0dhFZMQmp69FEm+D4zkH9UOhE41QiB+AwudQFj+L5hIZI4O7HTkx/BpGcnc6Z7Hd
	 z8BbYh1Fj7L6Jj+6jcnpKI4TM+UHGJAEuBy6lmziXqPX2tjtUFN2MqVhuraE7EsrDR
	 DLHQ1ynahlaig==
Date: Sun, 23 Nov 2025 17:29:44 +0200
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
Subject: Re: [PATCH v7 09/22] MAINTAINERS: add liveupdate entry
Message-ID: <aSMoaMlYwSh9oJAL@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-10-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:36PM -0500, Pasha Tatashin wrote:
> Add a MAINTAINERS file entry for the new Live Update Orchestrator
> introduced in previous patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b46425e3b4d3..868d3d23fdea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14466,6 +14466,18 @@ F:	kernel/module/livepatch.c
>  F:	samples/livepatch/
>  F:	tools/testing/selftests/livepatch/
>  
> +LIVE UPDATE
> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> +M:	Mike Rapoport <rppt@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/core-api/liveupdate.rst
> +F:	Documentation/userspace-api/liveupdate.rst
> +F:	include/linux/liveupdate.h
> +F:	include/linux/liveupdate/
> +F:	include/uapi/linux/liveupdate.h
> +F:	kernel/liveupdate/
> +
>  LLC (802.2)
>  L:	netdev@vger.kernel.org
>  S:	Odd fixes
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
> 

-- 
Sincerely yours,
Mike.

