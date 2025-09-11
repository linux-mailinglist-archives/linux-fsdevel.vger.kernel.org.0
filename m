Return-Path: <linux-fsdevel+bounces-60984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D8B53F08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1E7AC13E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91E2F5328;
	Thu, 11 Sep 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GOmFJkNw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXkbQMXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AB156F45;
	Thu, 11 Sep 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632859; cv=none; b=RcJyr7yd1t79SZcGif/+VKYWgrJ14wRlZVqrFh9I2eGWIlHsfJ/TvbP4dmIsdlWPAE4inxsosAYbQMOdfQNsn/5QO8DUJvxdAksNbVvOePpzh2INnSRD+6GxtQ47izgc0W51llaO54ZEQQclQcmNw+Y4fyppFQ6pVR07rcASiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632859; c=relaxed/simple;
	bh=rZ/FZYb7nUytiry4q8GlBq/PVwf8mvigbStaikGpuvM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Fn+/Taxo1PZusPLSULTYJ7wsc81aEaa2i13oQieo+FPLRWvOM5IRCHccQPyCYqDSdTMscNHH2Xobb/A/TNiNQ3y5iR1hZAlmWUHDxTY9GLrRD1cRC0F0lk6gei9vkIZ+GWovxPXHty30p3X2wMGiFZK1mZhMYhiHwJ9O/87P7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GOmFJkNw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXkbQMXL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B39BBEC0381;
	Thu, 11 Sep 2025 19:20:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 19:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757632856; x=1757719256; bh=iyVDN5C+weFoGtIwmWJdYIgCsPIl4rECn3R
	svoO1Wfg=; b=GOmFJkNw5qhHtfllwHCk+tuVvIqrcboOcHidVyf6G0xgmyh0D5C
	grHdtM+OKWiRQlVRnI0Pw4QYJ/7Wecbc08NlMQoX7Dpf4xkxmPhUyfIgB3QOxSlB
	2QayHrRZRCS2UD7M/8vFXbIgiv/EFpuxW/LKC2LdKjFfFxn73IhgfaEiVkLigPvM
	AC4CANurV/D/5hAGbTrCHxl8VMniWesgUtxwDVmvVXX8K8DvtLj3lEEek1/8Naig
	e3X7EYDmbkLugYz7tEmjjpnSFIQ/3wlqLUhmIvNjgvN3K0E15w3B0IcQmNXusghB
	hHK379FEciyrf/WxtqxgzYvRbDbTe9JaBZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757632856; x=
	1757719256; bh=iyVDN5C+weFoGtIwmWJdYIgCsPIl4rECn3RsvoO1Wfg=; b=i
	XkbQMXLrBTQaAHnQ/YxyOeJbyJ/Hy3i3NvJBtRYXUwpm6T+SdV06yNwgrjnuLgXt
	17EwntsYtumN2AzbeXkz8aLSpDZ1smdFWDo/8owR0ON3EJTuxFHI+h6b7OjgHrcr
	0yVAGFcK3zyQt752xF/ZBBpQ6jKvKVjYCsKMHnde4kE+yuNXo+YAj1WGgmYl7BXf
	oUBsNqD8a3iOapvBZf4hLK/R2loEwg6a5k63X4zx/1twz3DhOpXRV4G+wdaW+N8Y
	j5YEiRotKMpNlSFxSykjMzfMhD4IcJ3928LVHzI4bhTpVI/kyLrR2YOASaVPKQ0Y
	bgA2Ax6Tm91RoMNxKB/SQ==
X-ME-Sender: <xms:WFnDaEqvG9WdIJxXg4pZ4ta-0Vp0PHNJ6dx0D03R5H6IzF_RZcDShA>
    <xme:WFnDaGKxkAMp8wAc_Asi1JbyCqXwHrRYtEGZTkR2B700spUh5pA7Dl02E2GaAyPV9
    GFNSKt_gsWoLg>
X-ME-Received: <xmr:WFnDaPq88ouu02MQE4L30MC-FnAY9bohCkpmNGT1NhA0U7d09GIw7SSCcr4h2Ohs83b_BOafG6NncWgLqmdH7sJCEDl25_x0gifhoCkOidcd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghfhrvfevufgjfhffkfesthhqredttddtjeenucfhrhhomhepfdfpvghilheu
    rhhofihnfdcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeuleejuddtvdelleeghfevffehleekvdfgtedvvdfhffetffduveegledugfdtueen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhnfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WFnDaGzPsOOmm-KMLp2lPj2j4gsjgd2Tj51s29DX6_7X4ZrB-9zT1A>
    <xmx:WFnDaLOyL7D4dzk30pL8fJKx1syE8EzmZWfjhB0is7jdPRUgCZEGCA>
    <xmx:WFnDaD4wGSxzX_eTMaE9XpUFnsJtgMfNf8WjIA0H4bN7ZJzJp6jh8w>
    <xmx:WFnDaMl_qpyyAUpSZTtnHZnApQGo_3gttpNoPpbF-WzAl1Ycep4Y3A>
    <xmx:WFnDaNY4cj94OlVkl1Pv67rONnalIgaoQn1AnhJFtSa7a54QFrdDhvNO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 19:20:54 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
Reply-To: neil@brown.name
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCHES] nfsctl fix and cleanups
In-reply-to: <20250911224429.GX39973@ZenIV>
References: <20250911224429.GX39973@ZenIV>
Date: Fri, 12 Sep 2025 09:20:53 +1000
Message-id: <175763285309.1430411.7808429601062986445@noble.neil.brown.name>

On Fri, 12 Sep 2025, Al Viro wrote:
> 	More stuff pulled out of tree-in-dcache pile, this time nfsctl.
> The first one in the series is a fix for minor bogosity, the rest -
> cleanups.  Elimination of more d_alloc_name() call sites on conversions
> to simple_start_creating() is what got that into preparation parts of
> tree-in-dcache...
>=20
> Branch in -rc5-based, lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.nfsctl
> individual patches in followups.  If nobody objects, into -next it goes...
>=20
> Shortlog:
>       nfsctl: symlink has no business bumping link count of parent directory
>       nfsd_mkdir(): switch to simple_start_creating()
>       _nfsd_symlink(): switch to simple_start_creating()
>       nfsdfs_create_files(): switch to simple_start_creating()
>       nfsd_get_inode(): lift setting ->i_{,f}op to callers.

All these look good to me.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Diffstat:
>  fs/nfsd/nfsctl.c | 137 ++++++++++++++++++++-------------------------------=
----
>  1 file changed, 49 insertions(+), 88 deletions(-)
>=20


