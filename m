Return-Path: <linux-fsdevel+bounces-34754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C09C87A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EF2B2C7E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9B1FA268;
	Thu, 14 Nov 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Z7zmc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922201F8194;
	Thu, 14 Nov 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579152; cv=none; b=l9GO47effo4GpTTaWw5z8+bAYxcaW3ppqRtqMnWHZg44Keshp1t7qz05zovwW6zcK8vxqPbSRlX6FiP8hvJVJcI4jpH5u8+BWusMwJ5/JSHB08FGWT7qEroivCoDA6VohZQyyvMEm2+XAJRIbjsTehE3iT1pZEjSKd5e3N3bWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579152; c=relaxed/simple;
	bh=rho0TbbI2Kp7dox2SmK+Y/0lQzTp24hm5bw/PZNqPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK5BmAeQfKjHO68a19zYyimJOTbryuiJpd29t7PnyByyBXqJj6m1h+7JSZaHG4XRAY/dV06DZ61VQROs5OsfKupVgKhd/x0QPk6KxH6VbpIYD2pfL4V1rzHhkMPO8cVBR56keWSblbgx1PlfAX9HdBevXTOGXLKDPhU5v0hx5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Z7zmc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82066C4CECD;
	Thu, 14 Nov 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731579152;
	bh=rho0TbbI2Kp7dox2SmK+Y/0lQzTp24hm5bw/PZNqPls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4Z7zmc8EwJSNTSrVht3s+OtHWfMiBBGt3Pvq6nWMYPwor2GnW2+8EeImOAfXb3PV
	 DwG7ASvgh28lBovUKxq4pdLrnQpBsJI8B3mKeLISkL+OpYBcjuo8OzMaNIbOz048WM
	 NOmKO3lml2CBqBQXQRkF5Yz4haJsIs5PcROEWwguHT93rlZEfIlX9q9wc1hnwsrZhT
	 gPnffINO7hLvUgQe9HE2ezJ/Ps040iHxP4xO90kjv3JheznNe63wYQZf8kRB2T8WWt
	 EfEaGOTLWAcfD1Av14M5Ug4lA7VJ1H85fmCVdFr2iNS+uzLElb0Mni1KSiMz/k2NMA
	 ePo9857g2ggIw==
Date: Thu, 14 Nov 2024 11:12:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: pass an explicit reference of creators creds to
 callers
Message-ID: <20241114-lockvogel-fenster-0d967fbf6408@brauner>
References: <20241114100536.628162-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114100536.628162-1-amir73il@gmail.com>

On Thu, Nov 14, 2024 at 11:05:36AM +0100, Amir Goldstein wrote:
> ovl_setup_cred_for_create() decrements one refcount of new creds and
> ovl_revert_creds() in callers decrements the last refcount.
> 
> In preparation to revert_creds_light() back to caller creds, pass an
> explicit reference of the creators creds to the callers and drop the
> refcount explicitly in the callers after ovl_revert_creds().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos, Christian,
> 
> I was chasing a suspect memleak in revert_creds_light() patches.
> This fix is unrelated to memleak but I think it is needed for
> correctness anyway.
> 
> This applies in the middle of the series after adding the
> ovl_revert_creds() helper.

I'm going to try and reproduce the kmemleak with your ovl_creds branch
as is and then retry with the series applied as is plus one small fix
you correctly pointed out.

