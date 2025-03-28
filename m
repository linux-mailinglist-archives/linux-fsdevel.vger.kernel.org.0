Return-Path: <linux-fsdevel+bounces-45196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3AA747E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B69A17D2B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1198217733;
	Fri, 28 Mar 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="JIYO42aa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asR2tvTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14F1A5BAE;
	Fri, 28 Mar 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157021; cv=none; b=radzzAMJMXyL/dcw+gdBe5VSlYhDH7Sgml77Vag/V5CXS3/IriOOhg4QD1u/gV9o73K/dg+7hOu1sj/PqkSIZoI7wshm7jJgRZHe9Ykxa0Gsj0zahGnlIQtjx5h4dBpmu5YFx0+k6mFFdvhwOB1zcYjo/I/tWBDcN9e/wthXmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157021; c=relaxed/simple;
	bh=/arn/xPbmGg9sUXMiuKadWzed+23kCeYKFOmCYvBUtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIvNP4cLE9gVAbu/JvUmZ3wmQ7vsGLPgNrisyVMG69HjtZbPWcWM8aMJVGPbcNAR8DU2p33vKVPbXSb/GUl9rvvpoJkNW6oe6o5TDw4jXRCC6bYqNYUBq9djZOJx2fr25S31aknGYiuchqWsLSfCzDL7dfFssuef7nYX4QDws9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=JIYO42aa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asR2tvTE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 263B41380B39;
	Fri, 28 Mar 2025 06:16:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Mar 2025 06:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743157018;
	 x=1743243418; bh=IMBk0uSPcE9659LgXN2g27zCHtqfCxGM1l5u0E4E2hA=; b=
	JIYO42aaTijYZrCVLAmu7TcR7c47s+0HLa/+VSkxSE/qpp8dwjMd1g9WHBOBSYuk
	Tjt+ghXqh6GmJg6/8ubLR7hrEpjSDhWZm1sZi5yhPIFY0YWk3SNd2aEotDmbOmvw
	IwbvFzZv7Gb1Xt2gaJcDRTOBSSzPdl+N40ujzQbxC40O1ObfQyHL14QJhvq0Wp45
	11nxkHUsqvxOOz+y154NDjifmIANsI57cgXE+T482kwfb5euf0L5xvVeGJSaNI9p
	ECOyyhcfdtm9iTxJ6IfPqTXvOulQOGCl6+YORq6aWiRJJA/AI4IJYedpvkctJMa8
	qJm7L06ZANIVd8x5YX82qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743157018; x=
	1743243418; bh=IMBk0uSPcE9659LgXN2g27zCHtqfCxGM1l5u0E4E2hA=; b=a
	sR2tvTEaugR+Dov5MAHQUSimSAMlu1Z0sc1S5Q/Os6d09f3nDRg7wHRokusneud5
	4rVsrx6myTJXKT6ZVSFCvoYtUpjLYcWWTPhRNTOSg/Rms9pFvOmBwFC0FR5orMJC
	NL9FbeISCy4otN6Yx2VADa6KbeillxhDHe+yKEIrjIrtopaGGjTLCAi0i97/p3ah
	Ls2h5acQfJ/vupUqHdDeu2ylO5WOyA4hTyPbIK2lQ0XIUT3AN4DqoHYBj/sXbBg/
	TEkKiiiBNbdXtQtzrhil5QqQm0aME8yaw8lsh9TMupXhLv3xatJNg7Dyqb6i/bJj
	sK1k+W40RyKIqT5d2ebag==
X-ME-Sender: <xms:GXfmZyz2OWK0eLV7S-9fTcXk5czovMcK7jsBJXk1q277DeechG6qYQ>
    <xme:GXfmZ-R0X0akjQqYhih8HBXDVXuCsHPnKLVnRcQUBcrWS5I0uWGBJVp9P1kRxVlcf
    nS2vH0KNLbQHkww>
X-ME-Received: <xmr:GXfmZ0X1OSvv9ZAc7tYTzwcza9TJj06xexoZ-B08bLJA5CgSIajMMYgwJxdtUhsUVsz5gMPM6TtVddH79Ec66SvOZ8vCfY1gF_gRLoAzDcMV3wNf-EqB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjrggtohesuhhlshdrtghordiirgdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehrughunhhlrghpse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhrrghpvgigihhtsehsphgrfihn
    rdhlihhnkh
X-ME-Proxy: <xmx:GXfmZ4jYiLAuzU5Y0sQZRuwx0swgtGMzkTYYrqgJoQi2quf-shHbFg>
    <xmx:GXfmZ0AmcuaJRImY1WiQjhwsaRHJ7sR96kTjYAnwqxySP_tU5__-Mg>
    <xmx:GXfmZ5Jl3vBKSJagfwFInK5KWhobLPdpjMGR58oBNxMmc_Z4KnIzag>
    <xmx:GXfmZ7D8Jw_-_iTqbOYT4VzDlz9gVeBmNJzjI450U6OysBObnLO8SQ>
    <xmx:GnfmZ20-ARwv0lOLjVjSadSL6TAk6dOPLx1hi0HM4z6qI8-Hw4cUBZ18>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 06:16:56 -0400 (EDT)
Message-ID: <e89ab398-41f5-48ff-9592-98d21056043f@fastmail.fm>
Date: Fri, 28 Mar 2025 11:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: increase readdir() buffer size
To: Jaco Kroon <jaco@uls.co.za>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: miklos@szeredi.hu, rdunlap@infradead.org, trapexit@spawn.link
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
 <05b36be3-f43f-4a49-9724-1a0d8d3a8ce4@uls.co.za>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <05b36be3-f43f-4a49-9724-1a0d8d3a8ce4@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/25 11:15, Jaco Kroon wrote:
> Hi All,
> 
> I've not seen feedback on this, please may I get some direction on this?
> 
> Kind regards,
> Jaco
> 

Sorry, will review today.

