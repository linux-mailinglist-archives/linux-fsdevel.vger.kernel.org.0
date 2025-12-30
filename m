Return-Path: <linux-fsdevel+bounces-72254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6ACEAA87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C91C3009F53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FAE2DAFB9;
	Tue, 30 Dec 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QU2azYFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO2dxAdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA720C488;
	Tue, 30 Dec 2025 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767128988; cv=none; b=GqH94DHfbrxbcBp33RdpbgrGsjQYPbiUOnZKG52ajzPCUS+LpSTmzObUAGm0bNoJK9DgFq56jND4POR+IpE+o7Tb5V+qjXcLqAb5/L8KE1Y5sUg2jFMLY4wrx3hxoQigaIhjS9kmG4ZFjJeCHR1UxAgpiyunXe5BgK51wNOXvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767128988; c=relaxed/simple;
	bh=fRupOTFHWUE/2d6wnFdNN/SFw4nVIynwBcU/ap2tgxw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ffgiq6gJ1BaPP/7LGoQitjPtnkVDdnxX40ct4rzZAqshnhnWdL+ow7DdWm1IoM3MOBg3va8X+SSqqoy7j7cMXrtofD/EO8diQKEjYoQzB49Q0THbXbbNYMntqO3nlGZHqoh5zJ/aknt+Fib6dmVZWjxFj0bGmc9Bk+AnOPbmV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QU2azYFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO2dxAdI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C8D114000E5;
	Tue, 30 Dec 2025 16:09:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 30 Dec 2025 16:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767128985;
	 x=1767215385; bh=fRupOTFHWUE/2d6wnFdNN/SFw4nVIynwBcU/ap2tgxw=; b=
	QU2azYFFOHKR8nrv6UPJsiF/+czfWTNOSJnZ8jO1YErbBFdW23BZ6aA0SN7qqYuR
	eBiieW97opXTyMqDe/kUCXk8B4dZw98XMuGPTJQi0hZBhehX3bGFZdx2UlAf2iaw
	q5+dixRiNSw6hrv5h3gng7dwB+9TnRmiX6bPSw/HeG8/SfaxuId3S6DIRNy+LIN0
	8PS5mRuAUsAMlzTqobMM/w8kxlTB7qMtVTykjJTdOYo0iiyJTaNI18ajmFR8Xjzj
	XkX3CGVzm/TqruQpE9SksFBMEiG1Iap++WXuLluokqiBeIEuiQVrK/nP41QKMGex
	fykd7iMknqB/e8lFVMuvAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767128985; x=
	1767215385; bh=fRupOTFHWUE/2d6wnFdNN/SFw4nVIynwBcU/ap2tgxw=; b=c
	O2dxAdId/kVe0HqkTYnBq3CIaGIUQwgxOYlW80KS2Nljs0jDXJ9QljGV200WLr6d
	LV1IOm6UYqFlo0m3Cxi3SibTcD+AM2e71S82KBMEhyf8HYrN60+XXnjjbBPyWXrY
	cpikpsoDydusY/SKSyaa5uPgcv22evL2zKjbF56eucZG76IuictsLmqhuRcnjVzx
	gDSxeVAA/ghklaJAcLCOwsVgQBCdFN/K1g7oNPjV4zq4VeGk6lTE1uvTqmLyUTqI
	QknaDGXUKoV/5fHChKu9nwJKoSxaJ+jOHwTyum1tudhiGutiEV2whCCTUpe1lc5U
	8+wX7o0eA/NxVP8W1GPqQ==
X-ME-Sender: <xms:mT9UaaHwnlyWIYmk3pAkjdWiF8IRX8lgQdK7Zto145mDUfix1fmGaA>
    <xme:mT9UaWLu14kkp6j9nXnGkIgIxG81aBn7XoYa6Hq6B6hZoZ1rPufXMwLEv2yb4o-13
    GFw_YomSrSyEAcJ6ZtdI2J9F4ZMm-C3flxi-Tk2yr8nsJviz-vV1zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mT9UaZNgHxggWHa_rgqriJrt4drwUjEuoITWdos_Yr9YgJhQR-tz8g>
    <xmx:mT9UaXZ-OkZaEnPJklMUsFdZJYP3JVEPY2nTjDo5M4eJTMtuoY9mYA>
    <xmx:mT9UabzvOOUuu6_S7sSbSyrkabo3Kl6DRpMDUXozijSSNXMxDuTERQ>
    <xmx:mT9UaaLhHeVugv_xxbuswJpqvXiT3GSRSG7_83MTN3Qv_XXLZG1sqw>
    <xmx:mT9UabPIzs5j2JPhJxEHfgHvg2sGpFv1tdA-wSiTCLYERGbjxsrksWgs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0A7F6700065; Tue, 30 Dec 2025 16:09:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APoYDRVQ8Zf-
Date: Tue, 30 Dec 2025 22:09:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <26513f47-37d8-47d0-a6d2-acaa1bf8ec44@app.fastmail.com>
In-Reply-To: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025, at 13:10, Thomas Wei=C3=9Fschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
>
> Use the fixed-width integer types provided by the UAPI headers instead.
> To keep compatibility with non-Linux platforms, add a stdint.h fallbac=
k.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

