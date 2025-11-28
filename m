Return-Path: <linux-fsdevel+bounces-70091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0ACC9078A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F188F4E12B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CF2248A4;
	Fri, 28 Nov 2025 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UXFOEVyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="St32PTD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02071A9F9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292311; cv=none; b=tLjv/pqvuWg6kLaAFbjQ2Wceul4OiMrTFIsazICl5FJs+3WtDKI6WGeIvDHLzF83rSnn//6/a4YO86Srx99Ov6C0MGgc/2tdMZ3Zf8c6APV8BAEyO1lO8MZ3y5dRS4f5fPwavyr6nU+5fXWr9M7qoGr/p48UJCpswwbWp5LUWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292311; c=relaxed/simple;
	bh=guPiejOzWBUeJ0eo7OxoCcNgGJnILWUhI2r3oWJ4BVc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YKXbyy7IIomwOhdHGYo4No42tiGkaQznO9JDwX7ZYV39G7dP5C3jLgLK7r1BR40QfOIsXbKTJfRdcO6TMdc3z/TdM9nITnQA2a/pdWi/pScITCF2ca2i8dKvlpGd8K6dr+3nCo9ZcJb1hIgaqvVxz5kyVS/MnshYCp3RRMiDxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UXFOEVyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=St32PTD4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D65BE7A068D;
	Thu, 27 Nov 2025 20:11:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 20:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764292308; x=1764378708; bh=HfHGWz5qrxc9g6uRmHrVb7KNiXD2rsC3vku
	wuBXyboc=; b=UXFOEVygBy6YTS9GFjmgJ72JvCXIoihrUk++VUUbUQSm7eW77vf
	CNlE4pEn9R4etv/QTjohIKid5B8Rfs5++ZnTCRo10dHHwctm2IaqJBq0MjE9Sn+B
	xg1a6vgVJOw7CM6wO5OZHTnmATa/5OK6HnlnsawGuvItHxTRYYxsDLXqOl+fza18
	0cCepDmd3BhCAqnRMxyzgiGQVGN0v+LGLxZyAgywDXQ+io6xY+WfZrqriMIuuxl5
	DRzkVmrI0RVNmjtjvAUL3CEa9Bl3hsyUcZdqHCUs+RpZBfaal9y/4Ev/zS0wNO6y
	yxnoMI8mfX8qJZ1xwM8lLsLD3DjDTjmlm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764292308; x=
	1764378708; bh=HfHGWz5qrxc9g6uRmHrVb7KNiXD2rsC3vkuwuBXyboc=; b=S
	t32PTD45Jsf1PvyjpjwjqwyvT8t/9dKVnd/Xnxf6LSZTHSikIfHtOKeglnjddi+E
	QSKpNDbGXqk87IqDxf4ZEfG6ELtv6vKX6ThMUngdTERlYH14mRSF1151YkfuReZN
	3WGMuHDEH2+Cyx5a5Uoo5jvnEYns/pds2UICg4cqdC1d5q3JfV50tEkT9NQA11s5
	YKN2JEy62y0+glBy2KWVBE9qgEc/R9jgfGDbkWDGnvW+5K9eJ03x4SEDHe43M28D
	4J5PVhvamuV79gL5bPsrc8E+3KNgW0h00p7f5WcY2INjIrzvvD5A0nk00E/Zg6Nb
	fW4/UWxzwxG7BaQyYkqbA==
X-ME-Sender: <xms:1PYoaQ0gv9WvYtDjs2S18h_K4_kkGMOY8l3OXDLZ9X3ejw-gLgaokA>
    <xme:1PYoaUCtJI9mD9yP60s4RDI_ER_JKkYD_QkPfyl-JQn1aGzJn6D4A9BnkJkZQpKcB
    lreUVpbMT-8iLn_OxyEmJ5UaCE7Y7aslM5drq3_aojyMMDETQ>
X-ME-Received: <xmr:1PYoaUeMfnPm_rQXRbOoVVH63zeO7R_CpfqKO3A7NNMQNBuDyDv2IEybFEXWxqlFabv2v5HGe83FNlcsY54GeOwNI5zQN9RdXVLBM7I7MHrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggr
    ugdrohhrgh
X-ME-Proxy: <xmx:1PYoaZ7Fzrl3oAdlnTlc8smnTdJ41ye7kYOSJK26j_WaLCozqKMEDw>
    <xmx:1PYoafVyAV2cxsgF3yYKmc3UT3GyZexbztBu_ve2WI3d_6o0UzqKsQ>
    <xmx:1PYoaQ6Arzri6Go54HwKhVKcjaQVQGga7u2cMc55vJ5iCT7SkWe4SA>
    <xmx:1PYoaSrpI0EWpZ_ZU_0NIj8hlQrF9Rtsnipr2UY440PcNTXSAbqkhg>
    <xmx:1PYoaXOWCa_muV0x_HE68oRPx5k8I2mxwWOIpMxqMt3LGrTLKHfRcqWO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 20:11:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH] VFS: namei: fix __start_dirop() kernel-doc warnings
In-reply-to: <20251128002841.487891-1-rdunlap@infradead.org>
References: <20251128002841.487891-1-rdunlap@infradead.org>
Date: Fri, 28 Nov 2025 12:11:43 +1100
Message-id: <176429230388.634289.16874615606207992509@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 28 Nov 2025, Randy Dunlap wrote:
> Use the correct function name and add description for the @state
> parameter to avoid these kernel-doc warnings:
>=20
> Warning: fs/namei.c:2853 function parameter 'state' not described
>  in '__start_dirop'
> WARNING: fs/namei.c:2853 expecting prototype for start_dirop().
>  Prototype was for __start_dirop() instead
>=20
> Fixes: ff7c4ea11a05 ("VFS: add start_creating_killable() and start_removing=
_killable()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: NeilBrown <neil@brown.name>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  fs/namei.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- linux-next-20251127.orig/fs/namei.c
> +++ linux-next-20251127/fs/namei.c
> @@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, st
>  }
> =20
>  /**
> - * start_dirop - begin a create or remove dirop, performing locking and lo=
okup
> + * __start_dirop - begin a create or remove dirop, performing locking and =
lookup
>   * @parent:       the dentry of the parent in which the operation will occ=
ur
>   * @name:         a qstr holding the name within that parent
>   * @lookup_flags: intent and other lookup flags.
> + * @state:        target task state
>   *
>   * The lookup is performed and necessary locks are taken so that, on succe=
ss,
>   * the returned dentry can be operated on safely.
>=20

Thanks - but I would rather the doc comment were moved down to be
immediately before start_dirop().

If we were to document __start_dirop (as well?) we would need to
actually say what @state is used for.

Thanks,
NeilBrown

