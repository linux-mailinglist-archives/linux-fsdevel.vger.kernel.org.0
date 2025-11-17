Return-Path: <linux-fsdevel+bounces-68694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA132C6356B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA6444EF2D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A8326D65;
	Mon, 17 Nov 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZw1HmSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8632692A;
	Mon, 17 Nov 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372469; cv=none; b=guIx/jmhtU7JVfBATG2wsk0qOKCv0MIu6UunPEbhV1cRA7QIqTKA48WRalGUb9Yw1fSiP9TEkGjKknPfhLs/yISnpsiQ/rlaNDVeFKMgHx3H4/yb9VajX5dh7I2Vriv2KS1w05iCVCUOZvokBO3DPSf2jQz/cg6I2G6jCpU92c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372469; c=relaxed/simple;
	bh=LD55be3edOh4ynHvlMDm/XHjOHztjZ05X5TLRldv6n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgRq1wqBgxkJorzQs5MK2Upm3/Ut7B9wC+DY6Ny0jbLHrimXVkn/QSz7oRfBT1twFZ/kO2AG/4U7DsD7nL/Q0Z8MTrudJ9NT6YQ1xt7eMkjMjUXCQpbe4oOfyQSt68aqNq+o6XKP/ITfJDfmMSfAdioNGrhVecZ56iBljCFuoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZw1HmSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294ACC4CEF5;
	Mon, 17 Nov 2025 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372468;
	bh=LD55be3edOh4ynHvlMDm/XHjOHztjZ05X5TLRldv6n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZw1HmSe6e5SFAhumoJoHd0IXoPQTP7+MM7Y+b8c2vcXdarBS83di9/hyntP8Bwin
	 QoUWbpZMGv8BUQLEhg5/B1QhjlObNdlqeqG91VFVurp9EWnhWkrfPd+wi4VUWtf3HO
	 l5tPEffj4bxsk3DE84PYjUHLcb9eQokPwtApJ8+RsXygkP3/+K2tUR2j2V+GkAS/rx
	 8hVpFGSKb16yzjkjNRPW9MAxWCY1qHhILkXy91NV+lQrn0avug6sJRmSAbrWCZE0Us
	 /cwZ1J7nuJ9g5szal7SnFP7JqhWGSgsgSX5FVOj5dyIHN1vYwYt9xNndhqpSqSQ7dX
	 VsczE/cGhyjIA==
Date: Mon, 17 Nov 2025 11:40:43 +0200
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
Subject: Re: [PATCH v6 10/20] MAINTAINERS: add liveupdate entry
Message-ID: <aRrtmy--AWCEEbtg@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-11-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-11-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:56PM -0500, Pasha Tatashin wrote:
> Add a MAINTAINERS file entry for the new Live Update Orchestrator
> introduced in previous patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 500789529359..bc9f5c6f0e80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14464,6 +14464,17 @@ F:	kernel/module/livepatch.c
>  F:	samples/livepatch/
>  F:	tools/testing/selftests/livepatch/
>  
> +LIVE UPDATE
> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>

Please count me in :)

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
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

