Return-Path: <linux-fsdevel+bounces-60474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA22B48361
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542B318988D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961CC21FF35;
	Mon,  8 Sep 2025 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W2ttfYOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Td2RJF8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED176315D3A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307023; cv=none; b=AuVev0v92QY49Q8/SESJC9oeF4DbBPw2NdYS+JHQEiClGnBjCRP5b7qV9LiU8+/ol15wY+ZW5I3oDYDIvazV9CcqTVKzb4jBWe9DJtlm9znLuJShkLHGrMM/cZ2aEJH3601UjtYMR8joqLB9bF6Isi0ss48tEaItQXtqd1IQTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307023; c=relaxed/simple;
	bh=fEgVGn+llp/VpYpp6b5ajW+ZOa7YZ6qN3ursEelVfaA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SVvHnoOlVbk11/EVsoqfJ4tDINztxwWFezlvTfzcQA8gAPm2HEOzidqPG4bpYnkxt4FlB1osxTIRS38oAXLVGeH+IGHxJI8llBtPrFgfRLWf7gmrSqyKj5CUdzgvo5QAVafZeTnY4IqL6iEmInL0jO5lwYDBeE3DbyMjQPibVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W2ttfYOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Td2RJF8o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D919614000C3;
	Mon,  8 Sep 2025 00:50:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 00:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757307019; x=1757393419; bh=5D+jx+Z3KghxMJ3/XRBDZGuGnfpQl3f6+ix
	fgTJG8aU=; b=W2ttfYOViLGLpwLpBZBh3hOXQCTzJ8P7Ec8NZSZrchs/8ayH1xt
	lgMQDmWPgLDzcPjQOKpCGfV3KUJo50XyXfULn0XhiDX69iAcHXfzcU8MTU6T92vw
	8D+ax6jIHCkkSOyGUdv8JVU36BKStgFkxkL4rlzccC0EDYl9fnvq7QGS4Y/aBmzV
	tFj5B9GaRpw7RogoFx71iDZNMOVCI1xBXH1ywQINgbnEH1AnuKEEFzf5YtzxvyYF
	2XsFBFh3x0YHqvXKxBp5CW/R0QCyDLx36AVsxoVG49v0GGk5r/qsmHDEqeEd2lGW
	3EFqnkFZQ0prIDk+0WyKPcym2JKCddNGXgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757307019; x=
	1757393419; bh=5D+jx+Z3KghxMJ3/XRBDZGuGnfpQl3f6+ixfgTJG8aU=; b=T
	d2RJF8oe4Q024xKmzFencROPCX4GRgZg6H7+HPnCdX7PqfMzgpgEeymPssmeDZ1x
	ffhyCIc4aSCOuxM1no1CzjbbO0urM6CigR4fwyXv9ktHG2D9b1jWLs+YVQhjce8y
	tq3PqXM1s8G/LNA/Xa/bDMIsAudqNvba/xugiZqPna/TQukBzwhXrZaX1y42RrAS
	bMqD19gyR76QYHio5lfpY0+1xEXUchGiowXY8L6jl+evNq4WJ6/0FYf0tYfm/jFC
	l3T/y/HKLgIZeQDDdAqPVI/65aM2ZK3Q8ltc6Etxs5CyPnHN0CS1UY42kJBTJgPm
	IaZj9qZTEHTeW2/RwdoSw==
X-ME-Sender: <xms:i2C-aPpcmnpmzYPPbkBGJfK9nBE6cAq9MRa6voJlEyiwMTtu8ySW9A>
    <xme:i2C-aHl687sfPUWOsFsXEieAx7X3IRywOZ23wcD8PocW02cWLs7YObmM-CVZdV7RW
    jhUDC6aJ-97Hg>
X-ME-Received: <xmr:i2C-aOgcsZODa1B0IGjPxZPKmX-4ZrFp4TTuwdaEjfLxKCJDz-ohOYp6d_Cg3_azaHNVslOBX3x8UMFWnvujraol56HndvWp2Y8TZmMjyyc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghrfhffkfesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duveevleeihfehjeelffelteeiudegleetudehgfejvdevfeekheetgeelvdefhfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghrrghunhgv
    rheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i2C-aHcZBSGXAAQTBn0DAgStx6mLybdRfYVFu0Bq-tSOVM0lQLK3SA>
    <xmx:i2C-aGgxrjNzrohcdz1IZeJmIhDZyHeT2vvyJos0I-_YfcCFQYeAlQ>
    <xmx:i2C-aHxI5KOhCS2XiM0EvHywpTqJDtLdSq7NTTk07-E6Z9dN3V1xOw>
    <xmx:i2C-aKNj0sqJqqAnC8gobsVxJehQQAsskjUU0TKw0dTElZbdegVZgg>
    <xmx:i2C-aCtUrQHCGbNp8_Ro94o3fc6EqH99KJrqtW8o4pC9AiD23bsokalO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 00:50:17 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250908035708.GH31600@ZenIV>
Reply-to: NeilBrown <neil@brown.name>
References: <20250908035708.GH31600@ZenIV>
Date: Mon, 08 Sep 2025 14:50:10 +1000
Message-id: <175730701033.2850467.1822935583045267017@noble.neil.brown.name>

On Mon, 08 Sep 2025, Al Viro wrote:
> That way xfs hits will be down to that claim_stability() and the obscenity =
in
> trace.h - until the users of the latter get wrapped into something that wou=
ld
> take snapshots and pass those instead of messing with ->d_name.  Considering
> the fun quoted above, not having to repeat that digging is something I'd
> count as a win...
>=20

What would you think of providing an accessor function and insisting
everyone use it - and have some sort of lockdep_assert_held() to that
function so that developers who test their code will see these problem?

Then a simple grep can find any unapproved uses.

NeilBrown

