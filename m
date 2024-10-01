Return-Path: <linux-fsdevel+bounces-30494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774D98BC81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70C3B24381
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18391C2DDA;
	Tue,  1 Oct 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="na+K2Oya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953181C32E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786698; cv=none; b=R9d3HNz0/1nFMLy77PP+C+Ys9TXN8t2KRHTGXC4Gy0K2G6KXpntabbKJZE0qkLZCQSrrgyAKRSlQP2LCo5O4YY2BpM/Dln5C9uYJB0kSvOtQdDPUKxWtFQZjq4x3LOvFNqev8vpC2drSja8vOZENcOABFlHQh+hughNxd+5z0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786698; c=relaxed/simple;
	bh=GGCPdhCYPizhCA+/h1bnIg7CisAm7/yxQM5CkhaBD2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNnkcDej4HGu74lR/kGLlssYQoJfikvDsMOk+GxTGzrsW+LHUBUmLw9XBRY10YRc+y6aCjo6ERZ3Abc0xYblMiO1Jbwhyh0udDEc8Vmr/RTTGE+En3tosOG//sRQF6Ja3mwxkqVMDb1jrF0pz0/VQajgI1vdhpx3hvYdyXmH8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=na+K2Oya; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9QUcWnz6fid45GBubUoL7prAN4V8aOcYdytpl4grgXs=; b=na+K2OyaYLFieMg8y9ZtfgQb7O
	QqINAle8PwspThKDNJD7HTyEu8eRcnZufTpM0xmzVr/Tb+Dq/gpLHUvXZPShNP0kCVsd8EVmriMyF
	eCcEpHhpbYwLMBLKM53Gtf7ZRUopVpuytTWlfYki/E+LIy97aJtocW4Rt99cMmDp5BT/zCPIN0KdA
	obsHHD7FpIXj/v628JC0wGC+SxJO7zS56cpYNUWYQewn7mFb/DBrMncFe9uSoYbZER+OLtRzCCs4/
	h+brEFsmxy5Sexqk5M1JeY0rNGr2yg+QQgwMZdMVJZgovLryuOarJXstNSlGZ3lI1te4IgOkrpd78
	OEViH03Q==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svcF5-0004px-7q; Tue, 01 Oct 2024 14:44:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christian Brauner <brauner@kernel.org>,
 dri-devel@lists.freedesktop.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
Date: Tue, 01 Oct 2024 14:44:38 +0200
Message-ID: <2002903.PYKUYFuaPT@diego>
In-Reply-To: <20240920102802.2483367-1-liviu.dudau@arm.com>
References: <20240920102802.2483367-1-liviu.dudau@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 20. September 2024, 12:28:02 CEST schrieb Liviu Dudau:
> Since 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> the FMODE_UNSIGNED_OFFSET flag has been moved to fop_flags and renamed,
> but the patch failed to make the changes for the panthor driver.
> When user space opens the render node the WARN() added by the patch
> gets triggered.
> 
> Fixes: 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

On a rk3588-tiger-haikou

Tested-by: Heiko Stuebner <heiko@sntech.de>


with 6.11 panthor was working nicely
with 6.12-rc1 panthor was not recognized by mesa anymore

with this patch applied on top, things are back to a working state.


> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 34182f67136c1..c520f156e2d73 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1383,6 +1383,7 @@ static const struct file_operations panthor_drm_driver_fops = {
>  	.read = drm_read,
>  	.llseek = noop_llseek,
>  	.mmap = panthor_mmap,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> 





