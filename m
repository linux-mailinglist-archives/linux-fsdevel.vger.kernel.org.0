Return-Path: <linux-fsdevel+bounces-42870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4510A4A679
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 00:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2847A7ABC62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374D1DEFF5;
	Fri, 28 Feb 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="tvR27nhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d03nxS+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9451DED6B;
	Fri, 28 Feb 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783892; cv=none; b=R8kN6svJSTKSUYOdAtd6xdBhDi/fhDopakMaTiXtRd7mwqfV1+G04izqqKlN+MkoNutofsYiw9+J9hYsCChwjchG01U5KddsJkQ1f0ybgZzWxndwRD/j1dXv8YTc/072pUW1Xcm1z/tvZyD7b4iw8VaQPOVqDHApTtFrBReeojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783892; c=relaxed/simple;
	bh=jhwqS+8UgHrU+nFfkhLgpKb37PyoJnMpRYl+nlaOack=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VocAgsvnJ8eiCcfeETA1lDWu7MCdD3cKIi5F3t0XrXwdRj7UqpXL352G5dBRZDOjzZZr+5WZr51ZLd7ikVjkJGtCExGHPzny+IHNVOEr8EL3E9HcLpZIVQo1z+KeGAyyJrJTSJla6DpLKjvtTsADZffpWt63uAth4F9gA8s9AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=tvR27nhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d03nxS+H; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D8281140142;
	Fri, 28 Feb 2025 18:04:49 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-03.internal (MEProxy); Fri, 28 Feb 2025 18:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740783889; x=1740870289; bh=1wPPLlxLV8AoIw8qmI9GdCQUordZNsKK
	ATsbb1y5JqA=; b=tvR27nhRRPzWtgJ/xWx0rUYDqXK2P5r499BJ3UPpXhEoTLCS
	UAUT2yCihs2A39iMOJKFxAfNZcqtpE+0HC6DcQ/LUoloRqepQEtoXC8VN2Ga/xR5
	jcHepNyyXmtE/tCOY3UrODH5baP8rZBgETUSbmRjYACygmqx9dnZEOYchQXgF+NS
	g1eRjIa55uRacBdLyFvyGH5+ESo3eXpMu2LzCN7cN5cSGeYV+D4EX2CwDNCylRvs
	w9A4Q+T2fG1K+/8s3uu2q0yUjBR9URpqnxujattCddYQ7+pSMqlNOzzTNV/4ZaZF
	OGOyF7Wf+qQJyEn1VELKeTOXR++B8re09d7EUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740783889; x=
	1740870289; bh=1wPPLlxLV8AoIw8qmI9GdCQUordZNsKKATsbb1y5JqA=; b=d
	03nxS+HIq65zT1rBDtqLq7XLN7yQ8qo23nO5ERm+u90QYIFEXfBCN+H+p+AMxldi
	P+WyO7EaNHWAZsfnIfUMLgTDECFxdpgd2shMCoX0SdwlHzaZT0hW6SPQ5JGjrm2v
	RXahm8U6D4s1fom7zQNvxvWFbaeR2CxtZn1FJv19VyH8PyCfzaero4RRZMWKLICC
	yPBPHbpCZNjp/KWVXBtSh9p2M4Bt3WbculMQHuCkFeQpQi7Qt8rKs8hbw+qPGiG6
	NP0qknnCtHiHBgFHeo5PwVT6tACxITmA9WQGm/vPkzx+MYldp3o6888DHLdU4iJb
	uGuw/qmCfk3by9dAe0e6g==
X-ME-Sender: <xms:EEHCZ-wOlwM-6n0gLPYG04iVmFtBS6SrUmJskghJfDcp3-LwM4hC4A>
    <xme:EEHCZ6R-P_C5dOLyjOIDngOMxmiBUGVJFR-ZKJxSk1aA9F7vxvU7pW29j_YCIzUe2
    6bsElLVhUxFt1KFEhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghthhgrnhesvg
    hthhgrnhgtvggufigrrhgushdrtghomhdprhgtphhtthhopegrshgrhhhisehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqshhtrghgihhngheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EEHCZwWcYEV3dQxBmnNhsnIxeWJKZvlIfdUF0o0IU0e_z3bQrYKFKw>
    <xmx:EEHCZ0hYzsWqnJGalWq-8DVI0_He2rWZPFYcz4VI00XuyUjoqNM-sQ>
    <xmx:EEHCZwAL0KqJNQO50a-NulLpX0_QuXMcmXpOuSvKAp3108F3nejdBg>
    <xmx:EEHCZ1JLXUm7ljlFcJ2GVJK6uDF4ReVdpVHaJSB123HVu38_hgkiIQ>
    <xmx:EUHCZz9cXNdOIDaEcHPaqEYkeSK9NmG4EMJcoCdmmDnbz52h0BL_V2gF>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A471EBA0070; Fri, 28 Feb 2025 18:04:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Mar 2025 00:04:27 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Ethan Carter Edwards" <ethan@ethancedwards.com>,
 linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev,
 asahi@lists.linux.dev
Message-Id: <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
In-Reply-To: 
 <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Fri, Feb 28, 2025, at 02:53, Ethan Carter Edwards wrote:
> Lately, I have been thinking a lot about the lack of APFS support on
> Linux. I was wondering what I could do about that. APFS support is not 
> in-tree, but there is a proprietary module sold by Paragon software [0].
> Obviously, this could not be used in-tree. However, there is also an 
> open source driver that, from what I can tell, was once planned to be 
> upstreamed [1] with associated filesystem progs [2]. I think I would 
> base most of my work off of the existing FOSS tree.
>
> The biggest barrier I see currently is the driver's use of bufferheads.
> I realize that there has been a lot of work to move existing filesystem
> implementations to iomap/folios, and adding a filesystem that uses
> bufferheads would be antithetical to the purpose of that effort.
> Additionally, there is a lot of ifndefs/C preprocessor magic littered
> throughout the codebase that fixes functionality with various different
> versions of Linux. 
>
> The first step would be to move away from bufferheads and the
> versioning. I plan to start my work in the next few weeks, and hope to
> have a working driver to submit to staging by the end of June. From
> there, I will work to have it meet more kernel standards and hopefully
> move into fs/ by the end of the year.
>
> Before I started, I was wondering if anyone had any thoughts. I am open
> to feedback. If you think this is a bad idea, let me know. I am very
> passionate about the Asahi Linux project. I think this would be a good
> way to indirectly give back and contribute to the project. While I
> recognize that it is not one of Asahi's project goals (those being
> mostly hardware support), I am confident many users would find it
> helpful. I sure would.

Agreed, I think it would be helpful for many people (especially those
who still regularly dual boot between macOS and Linux) to have a working
APFS driver upstream.
This may also be useful once we fully bring up the Secure Enclave and need
to read/write to at least a single file on the xART partition which has
to be APFS because it's shared between all operating systems running on
a single machine.


It looks like there's still recent activity on that linux-apfs github
repository. Have you reached out to the people working on it to see
what their plans for upstreaming and/or future work are?



Best,


Sven


