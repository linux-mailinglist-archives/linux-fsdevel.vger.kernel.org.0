Return-Path: <linux-fsdevel+bounces-13979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8ED875E29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024221F23B6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2FA4EB3C;
	Fri,  8 Mar 2024 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pe4KXeOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSZA6nXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE21CFB2;
	Fri,  8 Mar 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881433; cv=none; b=bf2BXuE06HQNPDnnfoOGSvNAhcYRv9vgO3we6x5wovHPjzaEZKqM9duA9Rpz4mE1LTNXP+1JzCRpXfeZIl+PvQJj7VStoRSwS3+hl6n1dvCgjF+mBLrTa8vkz70fE6e0ymI9J4lpAkGcZZDrofH013i1pZsp5YmII0Kh3IuFUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881433; c=relaxed/simple;
	bh=1uqReeQKbaxkHZhzMByNGKVvUKOgE5HuK7lsF7HGm64=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dtewXZVlx98J2IP9PijKsNW/4K72XtHq+nms6K4EucQ434ZNgv2OLG0hA3cGfCUO2ee9WTlxxctC/ywy1N1WAdWpAKaUfttstRLiY+X64l1sJPdMw9VOpejteDwv7uzvmlCr+qPqQtsay4EWH3g72MCFkSdO5K/GLQxQwz88e3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pe4KXeOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSZA6nXd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B17E1380174;
	Fri,  8 Mar 2024 02:03:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 02:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709881430;
	 x=1709967830; bh=11LkabzuvCJDFPJOJPUUSJoKDOL+7OwgTjYJVM+filQ=; b=
	pe4KXeOygKcNKSWM5hmox4pfiU8kPMPCRfR5ZiYJ15j9paKTWuSHhdeRc2mzxNQe
	8uzRhl7L1HQ5iOir2pUs6IXtuOFPrjpcWzPuJ5iUjsjNbX/UZ0hPm384VU2U3Qxe
	ZZat52HklxhJQA68qWj+CFNlznMvZIw3KHhL/0PEFDHBjPgyN6fcDmct2sCDXe+x
	SbHeZC29E5SFOj+MzfdiFgEAAAQVOkw7BrociwvCckRPBg6WMiQ+FovB4U8mqrXq
	e6ZQXv3n48VFwee1ij6kC1TnQ5wI461NYGRxyYhno68XN02023HPvS6gMZ7FWhW7
	ArirIcshWkKAoMpi92I0+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709881430; x=
	1709967830; bh=11LkabzuvCJDFPJOJPUUSJoKDOL+7OwgTjYJVM+filQ=; b=i
	SZA6nXdAfFtih1ngbHWCqk0lZkUKVOd9/bIoUPcFiujle/y3GMSb+sGsy1oBn8Yp
	3HtkKyFC4a1BdDYFsNcpNf1Yzb+LPC9LYZ6cSXEvJtz7wtE/vKPsGvQkMGhl8HGl
	aC+DSEQuP5ZxvcJwu6ElJLtAxDtU9iNd3Br64ObiKXrO26KBV1oZS6O47Fan5qSP
	rO9BSeeZ91rU3pcszszxYyG581Ohx8RMyDpO8IMd6JNoN6avnCv32LP5kSS5v9q9
	25+RkaM8Zs2Xu8a7tUKux8GF2y7ZsRDKZjOnejJZ65qcKeBKTiC3mUPWGVbDEEmn
	PaTrh84ICGA7/6osxAKcA==
X-ME-Sender: <xms:VbjqZe16L7zdiA84zomB94jPsnUEf9tE2jES9hd_CwpKILxmI40tcg>
    <xme:VbjqZRFhGumC61X13SPXi2hn-cKW4KJHwC7CO_Zr0_uJL4tbboyj9pdM74EvTwN58
    07BUW_bg0WCN_iWWnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieeggddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VbjqZW7yfCRePSqVUT0NUBlr8EnsxhcN7pBZooS2-jmqNt4XRsfGvw>
    <xmx:VbjqZf14TfEDyIxvH1DoIM2CbXMT80mDgha9H52BpgXBz-votFhgkg>
    <xmx:VbjqZRGWL4T4ZpuDtXKLKcqUvIUbQhg7HOQrYcQDgHhT4hLaCAJT9A>
    <xmx:VrjqZQewIHWsqdcebM3l22gYnFxH8VW5T2PzH9KEcs4qbWslz3VqEQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 522C7B6008D; Fri,  8 Mar 2024 02:03:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
In-Reply-To: <ZepJDgvxVkhZ5xYq@dread.disaster.area>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net> <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
Date: Fri, 08 Mar 2024 08:02:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dave Chinner" <david@fromorbit.com>, "Paul Moore" <paul@paul-moore.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Christian Brauner" <brauner@kernel.org>,
 "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Jeff Xu" <jeffxu@google.com>, "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
>> On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoack@goo=
gle.com> wrote:
>> I need some more convincing as to why we need to introduce these new
>> hooks, or even the vfs_masked_device_ioctl() classifier as originally
>> proposed at the top of this thread.  I believe I understand why
>> Landlock wants this, but I worry that we all might have different
>> definitions of a "safe" ioctl list, and encoding a definition into the
>> LSM hooks seems like a bad idea to me.
>
> I have no idea what a "safe" ioctl means here. Subsystems already
> restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> "safe" clearly means something different here.

That was my problem with the first version as well, but I think
drawing the line between "implemented in fs/ioctl.c" and
"implemented in a random device driver fops->unlock_ioctl()"
seems like a more helpful definition.

This won't just protect from calling into drivers that are lacking
a CAP_SYS_ADMIN check, but also from those that end up being
harmful regardless of the ioctl command code passed into them
because of stupid driver bugs.

      Arnd

