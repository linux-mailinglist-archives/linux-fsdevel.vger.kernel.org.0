Return-Path: <linux-fsdevel+bounces-15315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68E88C15C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2787E2E7D03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374E73505;
	Tue, 26 Mar 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aZkuBp9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Axh5Y35a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E473177;
	Tue, 26 Mar 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454346; cv=none; b=ILIpfHUUxcBSYzVyRMu92AKrIcFfMpSrZOe2V7FGqKysyL4SZxy76OgXQa6bKSbORMzPxCS1fq+Y1Yk7J/k52ikWteQs3XacP7JS/jgT7frhdo6OsHpPBpcchTwLBbGhzv0ThFBnwhTB+9ILHU36XqIpMZfZYKeqgmAz1JsWZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454346; c=relaxed/simple;
	bh=Uw0vEDnTywERzPvWbpvw8VnR6iyRSe9qC08om5vrDsg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FqPR5K9DPBeywvfuAmoCwL/9lMO+nPPpLjl59IexvNF9fq2svUG7iDI7km/0Rr1w+x+mzPGKBW5amOEHW2eomp8AjEs3Uc6oK7F29KJbfn8ZlN+rD6GMfaip/ByI/ap2xrvpXUAo2+Jy7VkdaMaYpGQ1TPOBrLRpxNWuZWXaeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aZkuBp9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Axh5Y35a; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE23211400C8;
	Tue, 26 Mar 2024 07:59:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711454342;
	 x=1711540742; bh=HBMjo6bs1TmtqzdrJ6zhWiwvcYl00xxz+dnjWEO4m0I=; b=
	aZkuBp9D7HxYAbrMrXEPqMTzd1wUuzw3O4reX05HjGJ54i4Fdu75oCqBhQh/8ULQ
	M3GtjG5GSWwK1bGJbcy+6XUupO5R51jejqaQgajDjTkk+22uAd4E7zmPvlrmPAek
	FYQw3y8tgrd1Zl2oJ2EuGLLvUWPuOExdfLjjiewKRyyuMIU2cs2Laag90ZknKjRk
	0tyv4EEJ3Ya/GUwCfxkn2UqZ1GIcOoNsTXqg3OarPpBGYkImLMnhL20kZ4YF3gzn
	t8pNEJCc1/ro8Db6Qmt9pC0hvOmOs9znf6NB2YMWMQX36vl6hO+xWeKp2qEoyJZw
	YsxiSGuWXGSDQe2VoKIbLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711454342; x=
	1711540742; bh=HBMjo6bs1TmtqzdrJ6zhWiwvcYl00xxz+dnjWEO4m0I=; b=A
	xh5Y35aK+8FBX5cTZ2Kw71f9O7OWA0VBf9NuVpET7nWk/trsMsrR8rbVJfNMDa1S
	ZUJbv2wCMOpuUkgfr5hAvmN1VIbSfWqAztLTSs6pViBpMpRP2/mlG9I7O+PBIMQ7
	+jQNbB5bET2pVvU4r8poLPPmFkOvY7uIuvxrGDrIVUHAb0pfhZ7EJD6KyeSxjtCj
	scSiOMgxwEEb3yAf0QXxa1CqcBud3sQPn2pBVdunIBX9JK5LYRC9oAA+yyqwwHgH
	2jAJlSIE39axUPdoJA2o9ZocGRgwfH79nEqKMbLnhAB+oEINm2ZEg1+6hVHO2EYZ
	vJ2TW+ZULIqnQwx2RjeUQ==
X-ME-Sender: <xms:hrgCZrJMkQXLs4iSU7XlY5ityG1A1lbj3RCDr1N_J-DHQa97ZzzTJg>
    <xme:hrgCZvKv00HeJj9Rx2wMuzI_T4m2730x-AuLqsreyFyYiErfqsExMShOjzTx2iqy2
    YyBAzZOHfo_bZ_iSwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hrgCZjuurT2rRD4w0wlePJODZf3zQE-ikbrzWDouhxCLT5SCRU-qRA>
    <xmx:hrgCZkadw1pzCTVhFBvhnIFpxz14GJxCc3iAyB0Irt3DKLlcSFZAfQ>
    <xmx:hrgCZiafYlH3nHu2zeCNHMEK75nUZ4npKxLoH1GQwNGPn9M3k1fQUQ>
    <xmx:hrgCZoCD6G06nG22IEezON-nU5ReXuoL6NjpePVvYiAzVFhe0zXKcw>
    <xmx:hrgCZuRc6EmF_sngx-2EdUPtTzex7BY2xzwbMlSZn4ou6aeUMMLVRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 668DBB6008D; Tue, 26 Mar 2024 07:59:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b6a2a782-894a-461c-8fc1-9a3669545633@app.fastmail.com>
In-Reply-To: <20240326.ahyaaPa0ohs6@digikod.net>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
 <20240326.pie9eiF2Weis@digikod.net>
 <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com>
 <20240326.ahyaaPa0ohs6@digikod.net>
Date: Tue, 26 Mar 2024 12:58:42 +0100
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

On Tue, Mar 26, 2024, at 11:10, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Mar 26, 2024 at 10:33:23AM +0100, Arnd Bergmann wrote:
>> On Tue, Mar 26, 2024, at 09:32, Micka=C3=ABl Sala=C3=BCn wrote:
>> >
>> > This is indeed a simpler solution but unfortunately this doesn't fit
>> > well with the requirements for an access control, especially when we
>> > need to log denied accesses.  Indeed, with this approach, the LSM (=
or
>> > any other security mechanism) that returns ENOFILEOPS cannot know f=
or
>> > sure if the related request will allowed or not, and then it cannot
>> > create reliable logs (unlike with EACCES or EPERM).
>>=20
>> Where does the requirement come from specifically, i.e.
>> who is the consumer of that log?
>
> The audit framework may be used by LSMs to log denials.
>
>>=20
>> Even if the log doesn't tell you directly whether the ioctl
>> was ultimately denied, I would think logging the ENOFILEOPS
>> along with the command number is enough to reconstruct what
>> actually happened from reading the log later.
>
> We could indeed log ENOFILEOPS but that could include a lot of allowed
> requests and we usually only want unlegitimate access requests to be
> logged.  Recording all ENOFILEOPS would mean 1/ that logs would be
> flooded by legitimate requests and 2/ that user space log parsers would
> need to deduce if a request was allowed or not, which require to know
> the list of IOCTL commands implemented by fs/ioctl.c, which would defe=
at
> the goal of this specific patch.

Right, makes sense. Unfortunately that means I don't see any
option that I think is actually better than what we have today,
but that forces the use of a custom whitelist or extra logic in
landlock.

I didn't really mind having an extra hook for the callbacks
in addition to the top-level one, but that was already nacked.

      Arnd

