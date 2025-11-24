Return-Path: <linux-fsdevel+bounces-69622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26238C7EFD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4A4C3462C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C72D1916;
	Mon, 24 Nov 2025 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAAUK8xI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F21B4138;
	Mon, 24 Nov 2025 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763961642; cv=none; b=aWMXZzyTrJqdQba0jnlJi19vyQNUqykFmiwBiiGlfAJGXoQheG9YFp0QnAC4/wx0kEVnP+HeRVXnUQTnbC0+LPIyeQHZ05todZlof6lMRjhsBMUdaaEEi/LAYl/Yql/iQFiqc6BVPqqXN+V6f7XiDjki/0X6QqMbgQGQ+IFV2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763961642; c=relaxed/simple;
	bh=orSAmTMGafLHYjEKKYaHreeHKsJFj4UJH1WnVx2XGfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px/iCvA1aqLXWeSBYfHaiGj9G/KotqEPdOh/1OUWEcmBZDVaKyKypxWALvMYcRJCRPJTxay2Sy226YM1qDuwMKYd0lVGu8b/iQ9Cxe6GX9RNAzmHfodchvE7/VrQhaXhUicWVZomJf+HN2BbWdKtzMkU10hLg+VXTOPFyEhiMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAAUK8xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE65CC4CEF1;
	Mon, 24 Nov 2025 05:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763961641;
	bh=orSAmTMGafLHYjEKKYaHreeHKsJFj4UJH1WnVx2XGfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAAUK8xIBrTLmZBWd7jWub9Eap+4labhYwFwPFXrHKfjYH58DE+TRQrdbYgYf0sG9
	 vuXD2dHLbZhjnFdAILj2MFTo/QhcZJSZ0r25L4dIJSd3l7Ke4AwadVC2q0Z6STvsRV
	 c7NRkaxj8qCllb3oSoQlHonVjwSzWpYNIvhIRlzujuLmsdulFw/5nVgk2qyUOSW1J4
	 vi7BQiIv6DA4zo/yrl/jKef8QbfKTnchHJ6HEhnzrQChxJ6JTR+/7txs6cPFeS1nQc
	 i4LZU+J2ZmQIQ7aSUaCe4g2/C1mwDfygX30A8AGOqmFyPwYkRLh1xYPiyq1JIozgTC
	 8lNdE2YwlIBJg==
Date: Mon, 24 Nov 2025 07:20:17 +0200
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
Subject: Re: [PATCH v7 07/22] liveupdate: luo_session: Add ioctls for file
 preservation
Message-ID: <aSPrEfxdj8aqNsyw@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-8-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:34PM -0500, Pasha Tatashin wrote:
> Introducing the userspace interface and internal logic required to
> manage the lifecycle of file descriptors within a session. Previously, a
> session was merely a container; this change makes it a functional
> management unit.
> 
> The following capabilities are added:
> 
> A new set of ioctl commands are added, which operate on the file
> descriptor returned by CREATE_SESSION. This allows userspace to:
> - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
>   to be preserved across the live update.
> - LIVEUPDATE_SESSION_RETRIEVE_FD: Retrieve a preserved file in the
>   new kernel using its unique token.
> - LIVEUPDATE_SESSION_FINISH: finish session
> 
> The session's .release handler is enhanced to be state-aware. When a
> session's file descriptor is closed, it correctly unpreserves
> the session based on its current state before freeing all
> associated file resources.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/uapi/linux/liveupdate.h | 103 ++++++++++++++++++
>  kernel/liveupdate/luo_session.c | 187 +++++++++++++++++++++++++++++++-
>  2 files changed, 288 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.

