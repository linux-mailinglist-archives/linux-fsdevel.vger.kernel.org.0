Return-Path: <linux-fsdevel+bounces-15291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A441B88BE14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7871B22D45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674A6BFDE;
	Tue, 26 Mar 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="f9jagnBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qyckHF23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C04CB3D;
	Tue, 26 Mar 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445626; cv=none; b=qxfN+tmtDTLFBVVlrdkHZfN9ZnBbs56AcwfDbO/QxIvSxJb0Hpnwnztr0elialwF1ThpYX8DIJYfEtk/XzrabOV1XS0ituVHtTHeeTPXtCp5BjlPabgxG9a6oaws0RGc02CkZkfztWnvJtJCHyjd4rlXJLe1l4gYv6G8RDnZH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445626; c=relaxed/simple;
	bh=PwcZCILE8KnaKmeT4xNMUoMd6pvbcIPPx+HA7NUhan8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e674N0Kp6ippoohKk4MA9C6HD9L+EF7pz84+QSk9HFmlc+Sd2ILOr3OLWie9xLciWgapsmjfBK1Yn3OcTIvKQEnf4trBRvp1+FRS8E/A05IHTA1mLHQHWrw5PXplOhCZKu6LfJswejW5LQTR9i3AN2cQRWk6yssXUEemKWoLYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=f9jagnBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qyckHF23; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7A8013800DF;
	Tue, 26 Mar 2024 05:33:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711445623;
	 x=1711532023; bh=0Vu+lialpR+cOIZiodseyUQOl33fRqWzJfGVw61czq4=; b=
	f9jagnBpYWdPM8wbST8rhgSOKJc0fstUoLu6JeV7dNfGt6jt51GeeAc9h0xPVqzb
	+Coqe8nxrTb6EWu+InDELoodMCUVJZV/Jw8abIpefgVVlph7kkHAfpGG2n4DmJeI
	hz4dfMyRsyC/EbYSb1Nmjy6ZBNFcXEqb20o4RPRoKFMGN17gOEsb/2gIWwPh3LKa
	FHoFAn7ls4FhMT1GXG/nnWCEB4mbNMZn+CHIeRyHfF1lV3JTqkNff7O1sgIt7Pvg
	s314AgYjpRjbkOG2hkhSNZ6sowq3o8LdYr6g7747m9ovQ3BDVnH1rFFAkM/wkqpI
	e/GE5fYSsNmVb0KWRau7Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711445623; x=
	1711532023; bh=0Vu+lialpR+cOIZiodseyUQOl33fRqWzJfGVw61czq4=; b=q
	yckHF23mIufA4GFuYwTN1tSja2Y23YPwHzxwVGBuzA9XxqCOmsS+tSJY7dUTHGm4
	IRtocxs/4DTxERgxHkjVSr8EOdO5nUSAUudfVGMAT0YvmOFzCH1u4UMxvMDmxc7K
	h0MOV4DSmL9JR/lNMkXlbK6dyJx6DE1+EA194wMHFdUTS9GZCzgg7UVe3AT4Bomo
	4Wk3YCYTPTKo8WuV2qoWMSE5BcxheqxCjDoNILhvf6wEpNncun76D6hdMbwT+eAY
	QVJww+e2/S2UfHnND8W4+1ONfnAN/tdraz6HN6pgLHJTtfLE1bZc26+QPGb9Qoma
	ZWoK8l5rGKi7a4iuVCtOg==
X-ME-Sender: <xms:d5YCZnQfdJfXEGZfV4n9zzDGl7kHHN_Uln45qh_yIFYkPPHeV5vFAg>
    <xme:d5YCZoy4ma9yZTKH9qYjH9TvwE1r3O4faM6Ds-_r5c4HlEp19q8mXvtc7bb4Qy2jT
    7z-hnoK-pTp0uxUiCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:d5YCZs2zsWBm6fS7anQWTyZk09rcdLHgINuFvAGFQUd9wWe_z2NyBA>
    <xmx:d5YCZnAoE5-fArk4DTWLhzicioQPbyWaiES-V3gwh5eElPCKPlQE_Q>
    <xmx:d5YCZgicAJXr2mOB3lY6de6B5JrzvKIcnJ20Af4eDaUNwdPn0GwExQ>
    <xmx:d5YCZro7uEWVX8RGali4yKg_uA9f1HkkKyR51uGsPLfWj8xGvc9ZvA>
    <xmx:d5YCZhZ6emVrmu1cFXc8UgqxX7JjgASKH-8ga9BOk_wvPFmV_Oh98A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B217B6008D; Tue, 26 Mar 2024 05:33:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com>
In-Reply-To: <20240326.pie9eiF2Weis@digikod.net>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
 <20240326.pie9eiF2Weis@digikod.net>
Date: Tue, 26 Mar 2024 10:33:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, "Jeff Xu" <jeffxu@google.com>,
 "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for IOCTL
 hooks
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024, at 09:32, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Mar 25, 2024 at 04:19:25PM +0100, Arnd Bergmann wrote:
>> On Mon, Mar 25, 2024, at 14:39, G=C3=BCnther Noack wrote:
>> > If security_file_ioctl or security_file_ioctl_compat return
>> > ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOC=
TL
>> > command, but only as long as the IOCTL command is implemented direc=
tly
>> > in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
>> > f_ops->compat_ioctl operations, which are defined by the given file.
>> >
>> > The possible return values for security_file_ioctl and
>> > security_file_ioctl_compat are now:
>> >
>> >  * 0 - to permit the IOCTL
>> >  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to f=
all
>> >    back to the file implementation.
>> >  * any other error - to forbid the IOCTL and return that error
>> >
>> > This is an alternative to the previously discussed approaches [1] a=
nd [2],
>> > and implements the proposal from [3].
>>=20
>> Thanks for trying it out, I think this is a good solution
>> and I like how the code turned out.
>
> This is indeed a simpler solution but unfortunately this doesn't fit
> well with the requirements for an access control, especially when we
> need to log denied accesses.  Indeed, with this approach, the LSM (or
> any other security mechanism) that returns ENOFILEOPS cannot know for
> sure if the related request will allowed or not, and then it cannot
> create reliable logs (unlike with EACCES or EPERM).

Where does the requirement come from specifically, i.e.
who is the consumer of that log?

Even if the log doesn't tell you directly whether the ioctl
was ultimately denied, I would think logging the ENOFILEOPS
along with the command number is enough to reconstruct what
actually happened from reading the log later.

     Arnd

