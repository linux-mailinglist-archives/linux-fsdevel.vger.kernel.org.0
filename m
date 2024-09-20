Return-Path: <linux-fsdevel+bounces-29744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5488997D528
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31F32869F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC613C80A;
	Fri, 20 Sep 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NwedZpcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0223D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833649; cv=none; b=l10g8JrU3GlX9tvyVcc5H/JVGVdfgWE/YDxfKi3TE32rn8/X/8aJBnF5Mi8n/t6dvgk736JpCQwgUp/Lf7ijy15pCB/gAnMWN1SLG7G7/5rrRv+g++bIIgK10HKnpYJcLkVFUYMojdrEPj/1Mw4g+9a8My/CTkbmP9uZgK1XU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833649; c=relaxed/simple;
	bh=vGkdCrKt2mqP8Fql+DXD0U+dMzqeSKngmeuHotXauKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m50eVJi1BBp8mMJWSF+EMy8CaNH65TTTaC5l0DU7VMPHP1BxgYJZSOQa6z19F5wImzdqwN9tp4pHfcivS2eXFHiRMfu9w/cQhLJglcC1LBtMz7r1aXu7BGO3hVC3XHTuW1n7EI9j9K6UcaUqi67Te1Y1NQXYPgyBRhWpRU/EjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NwedZpcg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726833640;
	bh=vGkdCrKt2mqP8Fql+DXD0U+dMzqeSKngmeuHotXauKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NwedZpcgmqcMNy2XJOpxmnaye9mrd64XOyNJ06zPXIRfulvLU9Qt9wMNRsn/92Prk
	 6YkvDLBVw+hgTEzMuL4FiQGREDAFhBdZfzx4ceYgmtrcZ5V69v9isuyRLtHAsGs3UE
	 pGTUpq+SPWcVs1325kpxVq+W2Kt5vJIxaCQy2JcxPc0UEJo12mG7BHiF9axTU6KTPA
	 fxW69pP8/yWCSDq0pTmTZJiGlrskut6Uz5E4Km65d2BBKmO9dxKLBcKWlcUXDluapq
	 lM2v9K5TqPH++X0mBWnnIo51+hIAjurt8q+ZnqTXHnbGxqtO04FR05vPMsm9XpWEm5
	 IIjnK8LRjnkkA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B086417E12AC;
	Fri, 20 Sep 2024 14:00:39 +0200 (CEST)
Date: Fri, 20 Sep 2024 14:00:34 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christian Brauner <brauner@kernel.org>,
 dri-devel@lists.freedesktop.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
Message-ID: <20240920140034.29f9dc2d@collabora.com>
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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


