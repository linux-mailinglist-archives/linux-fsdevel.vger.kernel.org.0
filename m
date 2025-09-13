Return-Path: <linux-fsdevel+bounces-61195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419EB55E1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520591CC2A14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121C1DDC1D;
	Sat, 13 Sep 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="uKY2jUXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAPs3TOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD476A935
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734621; cv=none; b=mjZchvEltkjLJz3Ju0kb/3gZ9uT60MtxNPbj2xSJ1sQwAU9OhPzMUGIIIYIZaFt80Efb/tRvi3fQPdmW9p3DLMVAqDJt6Ytkw2UFpXtYssMg/IfMHO5KJWt4HxlJcyO81VyvuWBxmZwhR88PrRvUK2it9iO+Z3g5rGthn5Bac0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734621; c=relaxed/simple;
	bh=YND12cuW+R5fPNFgUsVDrmTgoWlGFPoEeva8jqmJ2e4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MPw20/jshJS+9zCGaI+h3hFF1Hst3rc9BSR8olIC6LZVBpFPil/DybravAM1Nq2Yrklh2m0kfhoWlwlwI0RCMJGvpo/CaoNSwq8TR3MxeBujirfJbl/Hsn7AkjG8qiquYmi5gpD1NCQVWAVODZtvbtzwc7Zr6Lj5Fx+brVmeJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=uKY2jUXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAPs3TOb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF95B7A01ED;
	Fri, 12 Sep 2025 23:36:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 12 Sep 2025 23:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757734618; x=1757821018; bh=8sChCze6RlA4QFeK7HTjAGn694THAABMO7s
	VniCLsR4=; b=uKY2jUXLdaoJkD7JYs6gxn2/vsqXotUDj+B64wihRtPafJIQXWk
	4u/XS/sc1mVw68vTl6exbmuBbiDa5BDclKNTlOJDt6gz4eGlDumWdok87ZXUQZf4
	qDZHSAjHGOudKvjl6fqX8twJlmqybrQ/SmtFrTGbWD8oi4QjkTVTTSNwXk+GhG7y
	+1N0+ZKTEKKLsdM72qAqc1oEeXv2NVEwdocI0se4lqb2IPaPPue/BHg+TPK68rGX
	x2f6qF7XaKn3V6t+R5T4MBJH8pzM7JIbT7O+358BRMkZR3vIfFECHX48GJ8gFluh
	zLI9ahiDd4ErIdx8Ga0+XCAaHj0he+mOplQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757734618; x=
	1757821018; bh=8sChCze6RlA4QFeK7HTjAGn694THAABMO7sVniCLsR4=; b=B
	APs3TObhCNjA5I9yf5+1Pa4GCcsUKRTFp3fAZE4ohkq843BW4zK89UFzelcqwOpl
	iMxMYEXyaLa5yHY+ZSRjtb6ufF6vL8Yyht8/54KQM/F/dUmV4k2jpKRXste/bKib
	gpXEV9DcrnIXYWQnMrUMMGUgo4BYfjE5AulWCl6HX9h1LTGdX1omu+dGNXMmsiYa
	WyuTTYhKBObXkiEjve9rPgd+oWVP2WUYniH0BdndHgs1q6WcU9YOh7mT386EZAln
	HLA2x/svg0n/LWmvSNJ8BcuTzZD6uInflkPcikyoeO6XWtikaWHrxN5xl5AmB/HA
	MAAvCc5z0Kb/TpOncOnKA==
X-ME-Sender: <xms:2ubEaEPQVlbn-zCy7dev5stX3-VSIzW1b-Dq9vqkwkh-ONWk8f3jOw>
    <xme:2ubEaCk6sU2zy2DEakeDPTlLYx6n5JJy0aGbcY4-ekF6zcfQB1ycbXiJVF_XFegye
    X0Yz9OKbnkE0A>
X-ME-Received: <xmr:2ubEaI6U6wj3S3ht3wTov0BIn5_8ZOUGxvjiIXBb8mhphTbjRFN3KL8d_aoRpyckkT9YI2IdL8It60bzwsRiVjb0FPMDjvTYU3sbaghX4-y_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegsvghrnhgusegsshgsvghrnhgurdgtohhm
X-ME-Proxy: <xmx:2ubEaG2SOh5EQiWBZtVi-lyXQcSUXoypjm0ZzgVBbQKOnHNo-eulAA>
    <xmx:2ubEaDFk43WRtC4dSbmhWf3LRON3Q83N8Kw2_dvP6pt924uhHnZmug>
    <xmx:2ubEaFg9QIFM-u6a67PyOI_SEzU5Qu2hgYZzY5O7I8s7u9YOj7F5pA>
    <xmx:2ubEaGAsT33y0uD8fO50XZ2ijUd_z5jDxMq5Utn0SyJyqPvmCMQ8Og>
    <xmx:2ubEaCFHq0o6i5LLejInJWcFOwdJj2LOb7b8Z6nQtwmwysyLbM3Ub4Jg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 23:36:56 -0400 (EDT)
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
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>, "Bernd Schubert" <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
In-reply-to: <20250912182936.GY39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>,
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>,
 <20250910072423.GR31600@ZenIV>, <20250912054907.GA2537338@ZenIV>,
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>,
 <20250912182936.GY39973@ZenIV>
Date: Sat, 13 Sep 2025 13:36:49 +1000
Message-id: <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 13 Sep 2025, Al Viro wrote:
> On Fri, Sep 12, 2025 at 10:23:39AM +0200, Miklos Szeredi wrote:
> > On Fri, 12 Sept 2025 at 07:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > While we are at it, Miklos mentioned some plans for changing ->atomic_o=
pen()
> > > calling conventions.  Might be a good time to revisit that...  Miklos,
> > > could you give a braindump on those plans?
> >=20
> > [Cc: Bernd]
> >=20
> > What we want is ->atomic_open() being able to do an atomic revalidate
> > + open (cached positive) case.  This is the only case currently that
> > can't be done with a single ATOMIC_OPEN request but needs two
> > roundtrips to the server.
> >=20
> > The ->atomic_open() interface shouldn't need any changes, since it's
> > already allowed to use a different dentry from the supplied one.
> >=20
> > Based on (flags & LOOKUP_OPEN) ->revalidate() needs to tell the caller
> > that it's expecting the subsequent ->atomic_open() call to do the
> > actual revalidation.  The proposed interface for that was to add a
> > D_REVALIDATE_ATOMIC =3D  2 constant to use as a return value in this
> > case.
>=20
> 	Umm...	Unless I'm misunderstanding you, that *would* change the
> calling conventions - dentry could bloody well be positive, couldn't it?
> And that changes quite a bit - without O_CREAT in flags you could get
> parent locked only shared and pass a positive hashed dentry attached
> to a directory inode to ->atomic_open().  The thing is, in that case it
> can be moved by d_splice_alias()...

Once we get per-dentry locking for dirops this will cease to be a
problem.  The dentry would be locked exclusively whether we create or
not and the lock would prevent the d_splice_alias() rename.

NeilBrown


>=20
> 	Or am I misreading you?
>=20


