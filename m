Return-Path: <linux-fsdevel+bounces-32989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3C79B1204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2823F1F227DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E0213130;
	Fri, 25 Oct 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DIv2Z/In"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B387213127;
	Fri, 25 Oct 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893199; cv=none; b=aN4xQGKtZj63Txtl8d33m3vvw0wKtZxtABqJILDCxaBKowEDoqhDQgl2+treTJQQIDupLFH4Xg8P3B05BY0OlyqfyU8WkyRAbIvdREFqG50j85ZFhuzvPYl8c3RPjz/CtYeWdq9fWm2CjtjPtuTnwOOmcNadAMhJqQFXgDyEGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893199; c=relaxed/simple;
	bh=B2eKg6piefvOLUgc+8fdQZjha3kgkzP8l6w3dYBUF+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2+VW56Hf/a3dKK5HTwYjzT9YhBhCWrKm1dS2pr0waOHL/0c3UiEqbSHpiexnYu7ni8fPJVC6oN8T0WgZZ96ZCE2KC6Du7wHUaFFiGv9eg/UG2DaI1wuaS8oy3qBodjom14ntj1ybggepgT7aC5kNhem5PGYuPZUfYiCL9RIRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=DIv2Z/In; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 592AA14C1E1;
	Fri, 25 Oct 2024 23:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729893195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7KP7DYMAuwzCylxcT416P2aabyuPSXwgPLZEtgS+OhA=;
	b=DIv2Z/In+d9HJvJTHWir6U0Y+lqU1ichbOC8y9mr0UdB1HAOaOKsSgIN0O6ep++IOvts3/
	hkfBBITf1Qr9OYMomhf7qfcARVCy5PDiXnqrTck+3nJQf7uj38PAIWrOxiBrI/WCFA+kl/
	goLe64NMgsfEI2xoqsWuBhbxbOM67Ym2amui2urmJECog2sTpTx3vFkcZyQvB83MmyVMCz
	RASkXJtoYtCBY56KusIemJ/nqXC/QdIubDR7u61PLXrl8Mq5vIGDyoh7WuxZGV4T+ZbY0r
	yTKK8Vkx7zCSJKAUdEVcg0xsdAHd7GhRv1phCHEjSVvImrExa+eIf9V+vaN9UQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e2930f9b;
	Fri, 25 Oct 2024 21:53:11 +0000 (UTC)
Date: Sat, 26 Oct 2024 06:52:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Guan Xin <guanx.bac@gmail.com>
Cc: v9fs@lists.linux.dev,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack
 size
Message-ID: <ZxwTOB5ENi66C_kq@codewreck.org>
References: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>

Christian,

this is more up your alley, letting you comment as well as you weren't
even sent a copy in Ccs

Guan,

overall, please check Documentation/process/submitting-patches.rst -
this is missing [PATCH] in the mail header, missing some recipients that
you'd have gotten from get_maintiner.pl, and the commit title is a mess.

Have a look at other recent patches on https://lore.kernel.org/v9fs/

Guan Xin wrote on Sat, Oct 26, 2024 at 12:18:42AM +0800:
> For HPC applications the hard-coded VIRTQUEUE_NUM of 128 seems to
> limit the throughput of guest systems accessing cluster filesystems
> mounted on the host.
> 
> Just increase VIRTQUEUE_NUM for kernels with a
> larger stack.

You're replacing an hardcoded value with another, this could be made
dynamic e.g. as a module_param so someone could tune this based on their
actual needs (and test more easily); I'd more readily accept such a
patch.

> Author: GUAN Xin <guanx.bac@gmail.com>

Author: tag doesn't exist and would be useless here as it's the mail you
sent the patch from.

> Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: v9fs@lists.linux.dev
> cc: netdev@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> 
> --- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
> +++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
> @@ -31,11 +31,12 @@
> #include <net/9p/transport.h>
> #include <linux/scatterlist.h>
> #include <linux/swap.h>
> +#include <linux/thread_info.h>
> #include <linux/virtio.h>
> #include <linux/virtio_9p.h>
> #include "trans_common.h"
> 
> -#define VIRTQUEUE_NUM  128
> +#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))

(FWIW that turned out to be 256 on my system)

> /* a single mutex to manage channel initialization and attachment */
> static DEFINE_MUTEX(virtio_9p_lock);
> 

-- 
Dominique Martinet | Asmadeus

