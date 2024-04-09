Return-Path: <linux-fsdevel+bounces-16413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B189D214
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 07:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958D61F23826
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C286A8AE;
	Tue,  9 Apr 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AD04XMaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDCVmWMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA93657D4;
	Tue,  9 Apr 2024 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642118; cv=none; b=G8iUFCkkf/YnxD5rBHGROGu2Z9GfSB6nBJ30uiQhRalX3bIwvlrkBRxm9mfFSz9jTwxaxIQohHLPqvbERd6RPkxkgEZHfmlDopa0qXMVSpkOwgHOGJ8plNIbfx/Giw/jjiD/D8YQcbS63whoyGawbRoB4HdR0hKc1m6TEJwBQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642118; c=relaxed/simple;
	bh=7PHyFq86sZSHTZ7mgJwXrlBy2b8rPAalgFbwOuOMKqI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rsl4x5tbP7F/P3dfMk2K+OWEq1dJd6jgWx8k1CXHuXiyFXsDaAIBmmq9xuLXXbwwbDcJPk2CLQnAZ8P4nDHxziVFtezWDaBp2sPF4gV2Crv7yvFRKjNG5c+Uxcmy6ODLtpSodo01nD/0/xBtU77xiER3BqaGWOVElaGz39r1hjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AD04XMaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDCVmWMG; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9B0FF1800109;
	Tue,  9 Apr 2024 01:55:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 01:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712642114;
	 x=1712728514; bh=mVqYZoy8F9eatbz6K+n+Z2DIzUwcR+3uwPu3hXlwdiA=; b=
	AD04XMaM7dkaWO1pYs25YgiL+pRK/5OI6YFGOOl4cz7V+KqRTnojBQb7wXsQUfuk
	pMjW8jCwBuA0p/TkMX09EIebtoA/el8SPKP3npuC2WC8MWflvS9bsn2WsXJk+PnX
	a96pyMG666cdNst4kIB4dGJgYes8vQeHkY6EiNrf5d/ijfHVTATQPNXMPSfRgItN
	LUR/Dr8K1gOawNFtKH92eRVn2DEchynQQvEb0rcH5ERAUdaJo6R2kDqZJ73B8vWP
	0FMMK0iw9boo2AN94+g8EWXTrYzA4Sd9ZJ7kqY1IBLoqTX1A+o6o3KjDqL6EB4MO
	48Q/gSNC0trbDF8GxoFl8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712642114; x=
	1712728514; bh=mVqYZoy8F9eatbz6K+n+Z2DIzUwcR+3uwPu3hXlwdiA=; b=e
	DCVmWMGkfGKvhfeZXULf2JX9R0Vblf0P9L0foaOI7PbUnZxUTxKgiT+zaSzuUNcF
	Wp6dCiAJ/Um4iiqVAiYTtdohSnB/xrFS+1EeRSUVpz9Jez5mO7U0I0Zwna05r8It
	Y5LXZOrL4+vhqZmdEqifuOts1eCUNy6cc0A79qOztGKl93YFfrKymo38WvfpcoQa
	RsVf7a08BLSne7BUxgWjf4nH1ZK3d2dzhr+0zvONQVvyliZTIDUxY4833aPK87YX
	wiYhPUEKrzgBmdHd++lY8zb6GiA8fc/E0xE/J2yhbSuMhsKU8dPqeim+Jk6uhWBb
	2sGDL1WUCwMc0TgaPicGA==
X-ME-Sender: <xms:QdgUZsulEM2aWTxlnoikNbha9E-nS_pnolHro31HBwbbQe9bKgq4lQ>
    <xme:QdgUZpcVJW6kmbcHlIkCgWoWys35smukmNRCNaGuUfGH4eN1m13XXPwEUa4DMd7A8
    e5escFnC-8p-KHJ6gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QdgUZnwzxAez57igef5P37UgCFDB3yzDMiQHR4bxG7i_ar_ZwW9zIA>
    <xmx:QdgUZvO__tf6qpMeTC5xmCYGotAu1rh_39Ra0L1NDsjQgN8lIUpuLg>
    <xmx:QdgUZs_QM8LI7byDFuYzFF_NP9GWLyMs6SRQRt-nz9wE5Ybu95S0gA>
    <xmx:QdgUZnV-ZL_9owsTYSqP9e7xK-Hrqe62k-Dd6xuWI75YsZ1uqozssw>
    <xmx:QtgUZnUYG82-BA3y4rL2F4upkB2Gb16T70YToYfq_Pc2rVsAU0uPQsSx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6D600B6008D; Tue,  9 Apr 2024 01:55:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96b55a64-2bcf-44da-a728-ae54e2a73343@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com>
References: <20240408075052.3304511-1-arnd@kernel.org>
 <20240408143623.t4uj4dbewl4hyoar@quack3>
 <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com>
Date: Tue, 09 Apr 2024 07:54:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Jan Kara" <jack@suse.cz>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Martin Brandenburg" <martin@omnibond.com>, devel@lists.orangefs.org,
 "Vlastimil Babka" <vbabka@suse.cz>, "Kees Cook" <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024, at 23:21, Justin Stitt wrote:
> On Mon, Apr 8, 2024 at 7:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>> Frankly, this initializer is hard to understand for me. Why not simpl=
e:
>>
>>         buf->f_fsid[0] =3D ORANGEFS_SB(sb)->fs_id;
>>         buf->f_fsid[1] =3D ORANGEFS_SB(sb)->id;
>>
>
> +1 for this idea, seems easier to read for me.

Yes, good idea, I'll send this as v2 after my next round
of build testing.

      Arnd

