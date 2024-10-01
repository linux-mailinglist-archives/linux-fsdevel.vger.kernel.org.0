Return-Path: <linux-fsdevel+bounces-30559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AA98C3B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C311C23A51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FE1CB524;
	Tue,  1 Oct 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BSLk+XZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD2A1D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801033; cv=none; b=seq/7r3Q1rjxzZSsxRygu9GnjOlO3XwrhRXArlo2NMO/tY+GcvwIXIOoV71TyefF8D8JJTQivpqPUNR7qsONrMaHRcryzlpIRrkX5RD69AGfsct4V6akfYG96NBm7kZuh9LzEWLmTTtykrDKtcgORURXuPw6irejxZhUFtYdvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801033; c=relaxed/simple;
	bh=+cyq0kmWN6KB34sPrRQYecF7x+xdDpSrvpVly7NNnNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfIr5MCnROZcFGYcpVEGj6KiDSbueGTSlFpjE8pmXxMliGyd0GlYvMRRfwZmdd2qxsUZP9FUMIYvSxCrwao4+NKQ3qknLUVzKpY1d5n+OJWuvAq2BYA6Y4OJrms+U5CRb48NlcGO41ihGzOETqvyzQ8ysq5E3oxfWLLM+wC3Y+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BSLk+XZD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727801029;
	bh=+cyq0kmWN6KB34sPrRQYecF7x+xdDpSrvpVly7NNnNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BSLk+XZDnvKmbF8XvuVT5b8SGFHw9sdQD8epLkVwGh2h6+8rSNWgCac4GL6KK6iSO
	 ZhmoqxDMMRPXQvyzVATPgzDtl8RNI3RdYKEw0DFA4QNnO1exi/6EeJCUvE0lTFN4DC
	 Sy4mgEEb9uXrfBIIvbWvvjJONHnleSv98/VAZpEmQba1q5eIiliQFQZM+HktIo2pKo
	 u/00FdmgCCM/0ibsfa06OZ6wHZXjkZXrXNXCahDPsB1bM7SAj/Fc4s07KlVeYoW9Jn
	 Elo8UD+2ql5giuGBLJNKLbUDCyEoB7FjlyLXfuZivDYVzb4rrLZhHhUfiUQkl4UPAr
	 tzqL9r0w/iWvQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 39D7617E1060;
	Tue,  1 Oct 2024 18:43:49 +0200 (CEST)
Date: Tue, 1 Oct 2024 18:43:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christian Brauner <brauner@kernel.org>,
 dri-devel@lists.freedesktop.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
Message-ID: <20241001184344.14ded785@collabora.com>
In-Reply-To: <20240920102802.2483367-1-liviu.dudau@arm.com>
References: <20240920102802.2483367-1-liviu.dudau@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 11:28:02 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Since 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> the FMODE_UNSIGNED_OFFSET flag has been moved to fop_flags and renamed,
> but the patch failed to make the changes for the panthor driver.
> When user space opens the render node the WARN() added by the patch
> gets triggered.
> 
> Fixes: 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Queued to drm-misc-fixes.

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


