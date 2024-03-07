Return-Path: <linux-fsdevel+bounces-13877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D6874ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83501C21B28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134912A155;
	Thu,  7 Mar 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q3Zgifs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGGjZIRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E775128821;
	Thu,  7 Mar 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814134; cv=none; b=lSjg4gOnwnaw1Wp4hwOnVIyeCOOfUr5uKeiTznGGHwaMzkKiBDdQ7Are+w0EZC6qei8MKBGRmxBWpgnxUVDDDs0xh4yO7AnCNUpgelMGtWRO9NbqsxXL9uPO5/8VajMe5EPIgRuCa1f/YrMXqRsxRtRA285Zhd+zJIdsGtDOHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814134; c=relaxed/simple;
	bh=bxa7eRDYb2BC0sfOOY3pB+tbouUV5dqHoZrj5sr7p6I=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kc7szsYXZOtO+wlnd49oigvp7OUnjQurkYpNczFLf8ImqMO9IS76t+FTkHxK/M4imQyyva1dHseK/5VE3t3mU3HWQ9E76apUQHmCUfxUYrzW+/nHtMb8ori5Rfxam9d7b6qp+Xx7nSR6qcYSOup6+zAfZWtc8wFSTjHEEqmO8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q3Zgifs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGGjZIRH; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 027C31C000A3;
	Thu,  7 Mar 2024 07:22:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 07:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709814129;
	 x=1709900529; bh=Jl0+L+a125aj6bSV51n924ykvlnMqQr9z0xJebLIxj4=; b=
	q3Zgifs7nUJ5YtbFzRcnt6ze+s1eTbyuJUcoKcbyskKBbZhMeWZlZo2xa6DIuyjt
	5uTxoIjttYAJQyHYTgEwEgwa23O9XkU5aJabbWJ4kEiqRb3giFpAAu2irwPOmQNb
	qTWNyhBPZx+ofRYTPS6V56Pa8GRXUWgtrfLXxn1i5Dm0UfogT3DJxqAlWqmYB6Di
	zT+bdztfBWhccZIl0waScKVGUh3dsMU2qwtjzmHwG3ypZSkVUcQ/fMQ/iwonjZBy
	zwqnYg8Z+UHpf/QBE48T6Uk1QI17rENXtPsdtePW3ApHxG/fyw/7j+w3oZFpH4Xm
	l4KYb/TlWWPExWvHne2LPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709814129; x=
	1709900529; bh=Jl0+L+a125aj6bSV51n924ykvlnMqQr9z0xJebLIxj4=; b=m
	GGjZIRH0S80bRmz6DZUg6NOr5jtp4HB68G9SPa39tNZgRkllzPREwlKR2bFxydjH
	wEqTVBVtfjVc/ZCedSXWhxtD+Q5GfUE/CDU4GJTrUzu+byvu0i5dV//1k7wJkdAw
	4ojSGeDtQJgS7xN8+93h90sPQRgcK/J2vuB7IyNs1sGHR6VWKpWgz+MMno5iMCcK
	kG21zeykqSWImohGiFx0d0g8hUSZuXwgQbho+rfIa1oUMRFgWZ4knNpN4QJC/OD9
	p0d9CV5P+nwp0YrVIlafutYoAu6ukxzbYq9NxVx9/UEBIucgFy1eIUFm1rwk4uMI
	vKAVDATtJ+B4jUi9G0TAg==
X-ME-Sender: <xms:cLHpZfPYXvMKtuEDhqCCRwt6JRI1Tz6ITyAPXHZiq5BewQ1SG8HbKg>
    <xme:cLHpZZ_NRthTVBuyP_cKfCaf4IHaEtK-C495rjvqoxJwCQmGsgeuQnYb4cVVvpeFN
    sd3FPh-_2JzTBXYkpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cLHpZeS-1hrbZZfajp8mY5hcI4I96Blm5lBkhBipcojXfdy9h6a2Xg>
    <xmx:cLHpZTuLA1QdULIOC06RUSwuoze3fMpSP3J17J9qy9poerYpWipl8Q>
    <xmx:cLHpZXcOQbUYwNM3MNlRdiH3ocdCUC3l8u-MToX8_BxSGUO6FRcnig>
    <xmx:cbHpZf16EL6SoqEMl-U0H6sGxQwC6SIrWfkVdknfE-PPa7Yd3SwXNpPpcoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4EAC9B6008D; Thu,  7 Mar 2024 07:22:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
In-Reply-To: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net> <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
Date: Thu, 07 Mar 2024 13:21:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, "Allen Webb" <allenwebb@google.com>,
 "Dmitry Torokhov" <dtor@google.com>, "Jeff Xu" <jeffxu@google.com>,
 "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
>> On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
>> >
>> > Arnd, Christian, Paul, are you OK with this new hook proposal?
>>=20
>> I think this sounds better. It would fit more closely into
>> the overall structure of the ioctl handlers with their multiple
>> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
>> you have the same structure for sockets and blockdev, and
>> then additional levels below that and some weirdness for
>> things like tty, scsi or cdrom.
>
> So an additional security hook called from tty, scsi, or cdrom?
> And the original hook is left where it is right now?

For the moment, I think adding another hook in vfs_ioctl()
and the corresponding compat path would do what Micka=C3=ABl
wants. Beyond that, we could consider having hooks in
socket and block ioctls if needed as they are easy to
filter out based on inode->i_mode.

The tty/scsi/cdrom hooks would be harder to do, let's assume
for now that we don't need them.

      Arnd

