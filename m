Return-Path: <linux-fsdevel+bounces-62542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8CFB98479
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 07:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DE19C2E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CD22DFA7;
	Wed, 24 Sep 2025 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="MxEUd7M4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfkiGmRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BA6FC5;
	Wed, 24 Sep 2025 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691558; cv=none; b=mcD1ts4qD9FgYSFszf8Q/+wMxvlhzg5LJiSknCkapDVoNeWIhPPbK75MuppAF6zJ8MMw4Z2Z3JndFDRuFN89NTioDHbrZZeX4KXcX3RRqJuI91qSORjzbr4P+yp0ZehPDDiamkYq7R8T1uTWMbhnQozn7Oi4uUWY4Jp1sbTPdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691558; c=relaxed/simple;
	bh=ezM4unOBkfJoa9iwE18B8oZRiX6f67XdWtDc5Ku+yw0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=AbHM3+22479FXAmStna5tLf0UW43352Zp+/djoL6xlMV6ht5VZxBSmzYMPXca4DrKTg83eJILFDFdyUigsgEKJvBt2FeaRqFybo7FMeE81uaIqyjwOxYuCzJdENhrN2ISr7qHtpx/lgRP2v/6YI88H69yEojKatSp3abj62ioIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=MxEUd7M4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfkiGmRB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B3BE14000BE;
	Wed, 24 Sep 2025 01:25:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 01:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758691555;
	 x=1758777955; bh=ezM4unOBkfJoa9iwE18B8oZRiX6f67XdWtDc5Ku+yw0=; b=
	MxEUd7M4I9Qhlb0up1FHxnb3KVlq+KpgU3AVVtTuuBYTnItNk5lVGQ5nhF//qgHL
	i436qEfsW0jFgmLGJwHodfcfoYrBSLok7nzpZ8O0UrfPQInmFWusPZi7vqgDuHCd
	4xq2ivxOx4kQHCsOtC7GVFj1KXkVh59OQYG90giuL2jmXMGEEx5BVCDu6zsu5AVZ
	ubXfsbz1MAcDR9VfadXcbab/v3zmTlzN9//4j0f4BNcfc5ZxRF1Kmanjo9C6q+qU
	5eGfCKcLebtJ7XtMKAqlYbfUxZWbaxOzQhG+8D9DdkvdutuJnqAOwlOj78klsZzm
	0Lf5241eo0j/lfWMDSbTag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758691555; x=
	1758777955; bh=ezM4unOBkfJoa9iwE18B8oZRiX6f67XdWtDc5Ku+yw0=; b=g
	fkiGmRBy+/QHYI3cBaF7+AmxfYV5o704Yaq7J2p5BFHXH129JyxPoJq2KW71Nz+q
	c/WCatW5rxZYHIYkVvw/OegLtfSD8S6TOtjwM5L/pWy1rz2yk/WYw6DbbW8Rl57W
	8NSF13pl3hvPa855/0JVeO0nkX2OvkwrBVMdp1hbxVWE143d6T/ArK1tK6ZBbqea
	0fPPRYH9W4mHG+Tf8Pn5ArlgnEWXpVguC7sK/+k7RNQ+XIjlK2/uTalaYVrVzKaP
	5Q/mx614Ql07I73KIIY1Q4Mf6mdhYLnA3cRqReInUgm9MTcpeT5evkzOa8nxsGIi
	lcHIkBIRnGVZxvRGApgSg==
X-ME-Sender: <xms:4oDTaP0YnrOmwoyKkgSqM-P4xl9u44vtJ2v28I0mAkDnOwQSwUg7IQ>
    <xme:4oDTaEFpAs3CITQHv5h8Z_fC5ufP69P9bueJfhoP9j12kVgTXn3VxejFT1x9RojUW
    cwW9im9qTdzc-Dw_qtHQinbPesiBKzrgr7uccU00_RQbDMBQXG5EBw>
X-ME-Received: <xmr:4oDTaKufQ27h8p3yVxX-ck4ja3mQce89VEcRKTto2_fBnj4gBP8yx5OP_x8y7Sppz9SMM0Wo9Qn_-LduQB352m7OuFRKPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdtjeenucfhrhhomhepgfhrihgtucfu
    rghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrth
    htvghrnhepvefghfduvdefjefftdfgkeehffevudejheffveegfefhheegkedtvdelhfej
    tedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhn
    vghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsheslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheprghsmhgruggvuh
    hssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghr
    uhguvggshihtvgdrtghomh
X-ME-Proxy: <xmx:4oDTaHquVPLd7DShPLL7-Dj7q6k57X-6YDPf2_uexwP15fEc5_Odrg>
    <xmx:4oDTaBWownC66bXZKQQ19ds0jI8kKaYcOa5qdP6MgLoeefzKXm1Njw>
    <xmx:4oDTaP30uHFQo1zyim36v2ekaIIO60syN9b7wWMdM2YGwuWFt0XO7g>
    <xmx:4oDTaGvhZc4d8v-fd8PgMEgqaTCMRV3B24yRhNOcj0E1BzuOrAqB8g>
    <xmx:44DTaOD_xyLbZB7nTwRLnpIJu5D5PxYNUJdwisSjwHdGa-6n6WPSBQP_>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:25:54 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Eric Sandeen <sandeen@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Date: Wed, 24 Sep 2025 00:25:43 -0500
Message-Id: <52E503A0-ED90-4C1B-A6CD-6C226752F180@sandeen.net>
References: <aNNdfO4WIJmBQ2uO@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 dhowells@redhat.com
In-Reply-To: <aNNdfO4WIJmBQ2uO@codewreck.org>
To: Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: iPhone Mail (22G100)



> On Sep 23, 2025, at 21:55, Dominique Martinet <asmadeus@codewreck.org> wro=
te:
>=20
> =EF=BB=BFEric Sandeen wrote on Tue, Sep 23, 2025 at 05:21:14PM -0500:
>>> On 8/15/25 3:53 PM, Dominique Martinet wrote:
>>> Christian Brauner wrote on Fri, Aug 15, 2025 at 03:55:13PM +0200:
>>>> Fyi, Eric (Sandeen) is talking about me, Christian Brauner, whereas you=

>>>> seem to be thinking of Christian Schoenebeck...
>>>=20
>>> Ah, yes.. (He's also in cc, although is name doesn't show up in his
>>> linux_oss@crudebyte mail)
>>>=20
>>> Well, that makes more sense; I've picked up the patches now so I think
>>> it's fine as it is but happy to drop the set if you have any reason to
>>> want them, just let me know.
>>=20
>> Hi Dominique - not to be pushy, but any chance for this in the current
>> merge window, if it's had enough soak time? If not it's not really urgent=
,
>> I just don't want it to get lost.
>=20
> Thanks for the mail;
>=20
> This ran into a syzbot bug a while ago and I've been meaning to check
> the v9ses setup as I wrote here:
> https://lkml.kernel.org/r/aKlg5Ci4WC11GZGz@codewreck.org
>=20
Ah, I had missed that so now it=E2=80=99s my turn to say sorry, didn=E2=80=99=
t mean to ignore. I=E2=80=99ll take a look and see if I can help.

-Eric S


