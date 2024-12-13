Return-Path: <linux-fsdevel+bounces-37326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411359F114B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E727F188408A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7F1E379B;
	Fri, 13 Dec 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qW05oXrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D32F24;
	Fri, 13 Dec 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104856; cv=none; b=CfJf+x/UKPRdpgmbgwAsob+rwlAyichR+/NQyuVABlxHYR1zL8pQ9gru/7+vG1N22/1kdRbPAgZYtZObfpK2Dz1yeFciXVSsBASdG20Lx5qR6QsYiqlmHkOoyMGdXpBcLyjX0Gtu4An5WFRwTGNONIiBWHpUmroydvErtcez5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104856; c=relaxed/simple;
	bh=6AU0Zu+j6lv5AWqSiZZfR6LsWkv1Sx+N4RSy8n0eNJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NqBgzQnJTrCsLIpu3n0/wvcV0RxPGPfC+ewk8TZtuzAJr/sYVTRAPRuxBSW/3Hnfo00erbPmVd+79AsHxVPa3Y3PkVgl2bWI0/XPP+T+dsbEQmptH4Vc7wlm4S9SFpDks6KsqdhOd40bu6zP1O2XJGGI3CU1v+Gx0gObZoD3kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qW05oXrP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E7FDF403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104854; bh=ROXOtd9jlx1s9lnUPcYMykHOvSU6CO3Ce2o1MCZInzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qW05oXrPfr4MHyggksWiC5+0x6hSTh7F4hh+wnhCasjJHT7uX1zoy8vGMKlHO6rwX
	 ZSiv+7hASz//0wsmuVfYNRMxUv3noTROUNoa2WN3QBN0OkTS7xuO0XYnuqqLSuVOzc
	 KByqKt48wXhBVUfA+i3GH2So/v2OQTwhH3qWLCpMAMQ4MOrYy168tE01dic+dxhn00
	 ZTYmNQ1+X1JszxC9Je2FqN5jSzzAs7Mw7zcnpIUWglZpNwgDSfFicky9BuX4J3FCwn
	 3S7Fn3ZyIchxnM4glVi6t3gzu4c95KEFEM6xBFEiP2oMDfkQn//7HvwqF1bAqkKw+y
	 lazFcxCLKAJPg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E7FDF403FA;
	Fri, 13 Dec 2024 15:47:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bingwu Zhang <xtex@envs.net>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: Bingwu Zhang <xtex@aosc.io>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 ~xtex/staging@lists.sr.ht
Subject: Re: [PATCH] Documentation: filesystems: fix two misspells
In-Reply-To: <20241208035447.162465-2-xtex@envs.net>
References: <20241208035447.162465-2-xtex@envs.net>
Date: Fri, 13 Dec 2024 08:47:33 -0700
Message-ID: <87zfkzwpnu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bingwu Zhang <xtex@envs.net> writes:

> From: Bingwu Zhang <xtex@aosc.io>
>
> This fixes two small misspells in the filesystems documentation.
>
> Signed-off-by: Bingwu Zhang <xtex@aosc.io>
> ---
> I found these typos when learning about OverlayFS recently.
> ---
>  Documentation/filesystems/iomap/operations.rst | 2 +-
>  Documentation/filesystems/overlayfs.rst        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.  Welcome to the kernel community!

jon

