Return-Path: <linux-fsdevel+bounces-70559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E6C9F403
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603423A149D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C642F8BD0;
	Wed,  3 Dec 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U3UejOUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0EtvTMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEF1DDC37;
	Wed,  3 Dec 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771295; cv=none; b=h8wDeZuZb0beXeKaCiT5XQYjgGr7RolduUp/Dfk/b6SaaSnChXkLBM0lt3GlKkuGOqF9NyuW55YcpnAB+5i7EKK4y9VL7Jjg/2/OqdJceCU8NdbLvp3q6YW6m4742KPvfeh+/+P1bicEfz0aBCeQQucBjNQW5IlHx5mE3QS8xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771295; c=relaxed/simple;
	bh=zO/Gez8txDqpEdjYE4XXZlTij1GuyiTWVZj2f6HcPWU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g6bQyvSNm9NWc2vSx/9EHks1w/7djul6R79tC+KCDa6TxAs6ALmNjNEx7aXIUsxQI6YVjOS61XPsKmbOMaRRVWvc2v7TXh+Uc6xIuAcemLBbhqyrvWLlVn3PtCHsvoo9ryiAv0m3sNEeDvrXx0qgI19qqvN8RKJ8IazdKg5fH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U3UejOUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0EtvTMj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 28EF51D000AE;
	Wed,  3 Dec 2025 09:14:52 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 09:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764771292;
	 x=1764857692; bh=KeObzzNWGXc3V/Q6b4rI1gKX1ALkXOJl92CKTDtiCrw=; b=
	U3UejOUIj2B9dYQeuelt8QYQ7QQUj2x2iIoO1Z4TPp/E7xXgbQBqV9sIDrwaCYhE
	lIrscfCsSmZseiLoUXX03AiZ13vsRS9jJwnt6r44zSc4pth9LFnwf+lnULDpYl5d
	ztV0/va6WA2Qj6tyxTjz5L76k/2nK5A8PdbnlIfNEKNdljJiMJAntxV0xENpscyx
	JVgXnjBe/Xng2CoDlNKl9Era4ikT8t0Yc7lUw8p2635iUkkobYC3AvlfTAz2JyjM
	qoMIkCdRox6MqzyNVmykqtw+an7YnsCnIfzS6acTWDo6Ye1nbd8uCSFs6VFzD5mt
	DoLbX8VhnG4xYf9QFuPfSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764771292; x=
	1764857692; bh=KeObzzNWGXc3V/Q6b4rI1gKX1ALkXOJl92CKTDtiCrw=; b=V
	0EtvTMjI+lCnLBaOCiN4bcAaEpPyHDiB0RWbZSi+lUpfI8olElTpgN1ku+ciWGxw
	itfZMnsymk9sOP386wzqmYQfEpYB1v9nyhUwgDBWJJrRJTf1nBdvd5Nje/Bxh03w
	3LlGIcVfAqo1K2vDSve+USyNYGObLvmL9r53SOFHlE1iCURvWPoLNZreUvBLJMm+
	Z3HtY1HgrC1aznzRDBmD50D8tMeHq+kASKa4z0jW8vGsth8EF7jHMKJBSv6ChIO/
	gGxt/2LF79jlVFf/iU+NtyNEMA7kgYNw9dgliRq0G4u5NuC0zO3+bED6poW2Gt7O
	/ImqgI84P5p2WOs3gM2GQ==
X-ME-Sender: <xms:20UwaVC3jrUbpjGXI9u-gO7bidwpWERnoz5-cDYLIDTYYPb9en3psA>
    <xme:20UwaeXAxL-H76cTY3vO5RUYFL99xbzotAt8So3m3ys0lT2ERzDRPTbPebpeYLzWE
    jWqHxU_wsLsQm_YE2sEhHzv1ZxsFlAayKErUobfm_RJrVEU7RZAM2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgr
    tghlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:20UwaaCobFY3OfW9n260ZOYggT5DbakWSd1DOxtlvvzrwp7Q7aAZOg>
    <xmx:20UwaQiK-38GgE4wgWNohMttPbpPAgm_LNIX1057MqvVbRnJsJ4b7g>
    <xmx:20UwafxFQC6RmG3H22oHWs062kxgEcmwmlPVt-Ml-ynlzpA-wXeCYQ>
    <xmx:20UwaZ0UQq_fIdMTcsyn0fX6-URN-q2AIQDcjm_JLAYl8ihTG74B4g>
    <xmx:3EUwaRGqxbOjAtn5P_55G3jePQMxgBwnXey7cBIKf3imEzyBmz05mMQS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99932C40054; Wed,  3 Dec 2025 09:14:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdXoxbahDSgB
Date: Wed, 03 Dec 2025 15:14:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <75186ab2-8fc8-4ac1-aebe-a616ba75388e@app.fastmail.com>
In-Reply-To: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025, at 14:57, Thomas Wei=C3=9Fschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
>
> Use the fixed-width integer types provided by the UAPI headers instead.
>
> Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
> Fixes: 4be9e04ebf75 ("vfs: add needed headers for new struct delegatio=
n=20
> definition")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -4,11 +4,7 @@
>=20
>  #include <asm/fcntl.h>
>  #include <linux/openat2.h>
> -#ifdef __KERNEL__
>  #include <linux/types.h>
> -#else
> -#include <stdint.h>
> -#endif

I think we have a couple more files that could use similar changes,
but they tend to be at a larger scale:

include/uapi/linux/fuse.h
include/uapi/linux/idxd.h
include/uapi/linux/ax25.h
include/uapi/regulator/regulator.h
include/uapi/xen/privcmd.h

     Arnd

