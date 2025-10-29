Return-Path: <linux-fsdevel+bounces-66382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA112C1D9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8635E3B20C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385912E0904;
	Wed, 29 Oct 2025 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="U/1Mrizc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zbyYgRyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E41F4617
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778328; cv=none; b=mInXi/ZHGn4KVzgX8YDKVidPDM2z4lgP4cSySnKRi6mzqTXAPXvhLCIP25tVVubl7BDdnQXLQ94J4AOfk6CGkGaT0q6ZIJlRWuB+UouW2ZRMmTiK7Rb9yS3f8Yvu/CgTh4Vq/dWiBPxFyDNl2yXWfzxpT1fTRdT9oQLhi+WCJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778328; c=relaxed/simple;
	bh=deA0DiIE5efWlAdXjFuyqOvN8FxOGJRmivXUibIMey8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=c2oN1YQAmGecN8CWd5KR3U2hJVFgidgQgHs2QRrPLFkN2dMaWE/Ka43ZHXI/l17RlMCpm+FI0Rrq6YOAajoDV+XB1fOwlWP6fpdeJqzjlV5nLVCv/yvCreuiFtvQuMvBK6zyzo3m4WpF/3o7hlDeD/mKhB2Bc9+diQuR38q14ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=U/1Mrizc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zbyYgRyR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1077A1D00083;
	Wed, 29 Oct 2025 18:52:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 29 Oct 2025 18:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761778324; x=1761864724; bh=RYiVv8xvv0qUhm3BTODhXe407n96GIIqZ4l
	yKcyAF8I=; b=U/1MrizcfTK6J8N4za+bJk1ljOH99k5iall1YLsVaTyRr1GTg8F
	DzpHpBPMrtieCD7Wp1+lP6Tz5Bf1ISs6LwuWn2nfBRCILMkRQvOZfCx6fqblX25P
	uVEg2jGcyNibIBer5laPSZztazi1GDCBlQllYyqUNMna28XpPkVF+376ZZf+Bd1X
	3Yw43ZyWfWnUxtUlO2ojDV/Fq8KTvWCbTYb6Cd5yee52jaabGJ2VfDCOh5LWkeLp
	wNC39XFINT6lTdNc36FbiPgRDn1hH2fkp7Hcv7GdWvrccGlwZ3MO1nGlIoFUgc/l
	iQvpCFWNalfPn2CFG6cRHsxLWr6Hi804gSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761778324; x=
	1761864724; bh=RYiVv8xvv0qUhm3BTODhXe407n96GIIqZ4lyKcyAF8I=; b=z
	byYgRyRBqzDJt8548sjBdkqOsDnCSaj2qSg3LubhRT6sNA1hQgJ6q+z5LrEMzPBZ
	xTsLjwTFoiY7axgsC0fyxr4atzCUSPsb7yR6zitPiS5/AP/b2NUgHjrEBxtcSX4h
	k7J+TipUc54NIRVLBeQ/ykJ4K18PI1tKe/X2S7Uz3qYoIsUgAbEvpK/HI7wnD76I
	vbZ+On98RZTbyg8qU4Jw/SUNIBa2tHHVgo4qCho2uZpeMjlOfJ8cXblOLX58At5/
	BYm3GAa/ndchzy3kJtNQEUz6remDowJzS+mLjjlYrXrZAjaf92p8dAhSq13DdVb8
	6XUFXj5ANImSVhg0R1/hg==
X-ME-Sender: <xms:lJoCaXWhzmIeFUO4Q2tl6obIGCKQWejq_fe7_OzRBR_0_vv6AxFsmA>
    <xme:lJoCaaj7FZQQs-0S4BX8o4znP2MgTw1ZFDFn29prgePvn1hngpsffxbJeYX7Z3Xdh
    ag36QGNXgenvLjKvDCj0YzZY-TqUOaeQjjMi_cooAK5RJdjtw>
X-ME-Received: <xmr:lJoCaSaNXYp-Ql-Jol8SxGvl6XVKVsKbcnBVGmI3pYb_ACOifKnMfZjlgREhCxjfVBsND2MQ2gF5RkGE7kjdIs6XhheV8EQZ5nqAiu_JPssb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epffevjeeljeehueejgeehleelueevudehjeekgeevueffteevhfefvedtueeugfejnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhm
    rghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lJoCaXpBewiVzqeJnh9pqHDbMqNg3dgFLsul-jLMV_30rXvvdQKRTQ>
    <xmx:lJoCafNYCm2J_DQ4p9y7ejNf2abQVQqlWKLVzZB3780238_9SvPHGw>
    <xmx:lJoCaaqfBQLuru_YUV-1v2w903cwf5wMsDA-nqVP2R36lJ4y6g4OUQ>
    <xmx:lJoCaceLRM56gD8KH7FfYar0w0ajRyMkjcWoz8iB8drxyjmxdcGGwg>
    <xmx:lJoCabMh3bdb4EAMQVkS-k0TpvtDU1DIf5H4D6kj1DJioJ56JdKOjShj>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 18:52:02 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Create and use APIs to centralise locking for
 directory ops.y
In-reply-to: <20251029-management-wortkarg-8231c147605d@brauner>
References: <20251022044545.893630-1-neilb@ownmail.net>,
 <20251029-management-wortkarg-8231c147605d@brauner>
Date: Thu, 30 Oct 2025 09:51:58 +1100
Message-id: <176177831849.1793333.1164390907191667489@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Oct 2025, Christian Brauner wrote:
> On Wed, Oct 22, 2025 at 03:41:34PM +1100, NeilBrown wrote:
> > following is v3 of this patch set with a few changes as suggested by Amir=
.=20
> > See particularly patches 06 09 13
> >=20
> > Whole series can be found in "pdirops" branch of
> >    https://github.com/neilbrown/linux.git
> >=20
> > v2: https://lore.kernel.org/all/20251015014756.2073439-1-neilb@ownmail.ne=
t/
>=20
> Are you resending with the dput() fixup or did you want me to just fix
> this up?
>=20

Thanks for asking.
I will resend later today - and to a larger audience covering all the
code I touch.
I ran a test over NFS and hit a crash which has distracted me, but it is
in unrelated code (localio) so doesn't affect this series.

Thanks,
NeilBrown

