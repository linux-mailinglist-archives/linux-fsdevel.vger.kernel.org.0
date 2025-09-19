Return-Path: <linux-fsdevel+bounces-62270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B9B8BA40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 01:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E227A01AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03527E041;
	Fri, 19 Sep 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="qa7H9YUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arvNBI9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041311E32B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325498; cv=none; b=BYG5+KYSvfrzHD/I7JKz0mHat1eLNhvzsHhnNfyUKLr9HvjxJWNTF+eZffEhMgXJ3SOpJNfL1n83SNNbVkjslellfNrYDMxo45IHYOV6686OlN5brjJVFCbHC5mMxYKJvPFCZUyYbywk2NUgn1nmHTno6/dfs2bIOyx06/NhVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325498; c=relaxed/simple;
	bh=tQCAFei+mWD4cjqax7EevUyDz7F1CLKY5Xty9+1T67Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=F0q2gNuoMg2r2/gYGm5qtXUsOY6NFCInkg58v24SuSyOew0arEtjvyzXRjz4Havrm7tB2+kIagqM//LHoTTDE/smFLhMmhSXGr4WQDxqKRil7J+6UiBCi/c2/bqfGCyvxCcoGb0pPD9yRSxxR+yNVviMZoMTdFkJcycgdB0GbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=qa7H9YUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arvNBI9O; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 34846EC0242;
	Fri, 19 Sep 2025 19:44:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 19:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758325496; x=1758411896; bh=v6HndDkinm7aGnSWtKIHZZ0+LyixnatU4bY
	m3GYOuzU=; b=qa7H9YUuAXbK4exjMCy9/qiYrh29K7gMI84DA04ca/zhj216o6S
	u/A++5Xa+mDAcKSQMWWS0wxygNvNTqU/Ewz1nPJFV4vhewvPIeKYp6U/KdfA2lud
	/euM0syL3ixVKgViuI2O5HuIY9i8z9Plbd2wxyQVR5iJ9PIZwVXh/d6fK7b9TlGB
	N7Upamn9VGBd/yPcVFC4jbf3eWQfvtVYrz1J59f+W43YeYgz6+a2G+A327+QUiav
	AiVIW2uzROQGll9Ol/pKjIDxt5U/B9p41nS/E4Hoq64qR3sEcZrNqmaPTd5xKvr/
	/ZOCaWicGYzM7Lh/C9Hki0E3lIBomzpdVxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758325496; x=
	1758411896; bh=v6HndDkinm7aGnSWtKIHZZ0+LyixnatU4bYm3GYOuzU=; b=a
	rvNBI9Ozj9nYgdLF6cKNMLweNXJDGdJ10EaiIkyOJ00YZC7hqWB5T5ybBjS/7tTM
	BUM30C+7PelE9q/R0nK3FZ15DVTdkaDWlhnCtaeepnYOt/+VcnBzedNfoXO4xJ3X
	aRne8vIsEVQ7pBde8GoltOs+9N0vdZnhwYffuH90zrgA8TMMydanqSpP7ZTMBnVE
	V7owdo5Gd2pFaB9IObqAusq0NBYIQWzBe34tTki6zVgUeVzXVqbN5PnOJzY6GdIZ
	E3vHRqBhHdNE6FCmLKAeZrd5KdVr0zHeP1iRdm37KEoPtQCedpLBPUAxBgB9vAS8
	EEienloTkNKObUhh4ZuKQ==
X-ME-Sender: <xms:9-rNaPyHixobO-8F9EtoK1qb-rZmFI7w6ePvuqpACRdi6xHqz0W8HQ>
    <xme:9-rNaFOWHuQZly6ygL3damCWHAZbgYqLCQowDfg_om2TC9bHIgXjdh9B3n8eGi9MD
    0V8uePtYrrAJA>
X-ME-Received: <xmr:9-rNaLrUCSI9_xGrXhNobZ3NPAvwmbTx2xoQ_jQntlrD1d0RGDAIUJteOQK5Spk0HzWwhzXlwWslJqhabiiQA3bAuyejINz1jzJgZuT7fUf->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvueetleekjeekveetteevtdekgeeludeifedtfeetgfdttdeljefglefgveffieenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgiipdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9-rNaOEJigPYHpwn6VWqsw3_qfI8GBCDn1Ll_LJOdCq2EXknQ7r9KQ>
    <xmx:9-rNaIrK_6OCzYLjRISNuXCpDxQlkN3s_lVxFmotzmee6HreJI9CBw>
    <xmx:9-rNaPYHj23iWEV3CMXstHPukPS8e8JTMZ6NW40ROl1pPBIr3Zgigw>
    <xmx:9-rNaJWGBWEGtwEBeOMeBMa8TM3db82QfI3t-1EGoJPdPD3P0Rc7Pw>
    <xmx:-OrNaOX3ovwJkKEQlJN7UanNMxOIw9N5UCD6shYis1SqMMYwm4B750j5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:44:53 -0400 (EDT)
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
In-reply-to: <20250919231708.GJ39973@ZenIV>
References: <20250906050015.3158851-1-neilb@ownmail.net>,
 <20250906050015.3158851-5-neilb@ownmail.net>,
 <20250915-prasseln-fachjargon-25f106c2da6b@brauner>,
 <175832247637.1696783.9988129598384346049@noble.neil.brown.name>,
 <20250919231708.GJ39973@ZenIV>
Date: Sat, 20 Sep 2025 09:44:52 +1000
Message-id: <175832549204.1696783.3801114171301027038@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 20 Sep 2025, Al Viro wrote:
> On Sat, Sep 20, 2025 at 08:54:36AM +1000, NeilBrown wrote:
> > On Mon, 15 Sep 2025, Christian Brauner wrote:
> > > On Sat, Sep 06, 2025 at 02:57:08PM +1000, NeilBrown wrote:
> > > > From: NeilBrown <neil@brown.name>
> > > >=20
> > > > A rename can only rename within a single mount.  Callers of vfs_renam=
e()
> > > > must and do ensure this is the case.
> > > >=20
> > > > So there is no point in having two mnt_idmaps in renamedata as they a=
re
> > > > always the same.  Only one of them is passed to ->rename in any case.
> > > >=20
> > > > This patch replaces both with a single "mnt_idmap" and changes all
> > > > callers.
> > > >=20
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > >=20
> > > Hah, thanks. I'm stealing this now.
> > >=20
> >=20
> > I was hoping you would steal the whole series - v3 of it.
> >=20
> >  https://lore.kernel.org/all/20250915021504.2632889-1-neilb@ownmail.net/
> > =20
> > Is there anything preventing that going into vfs.all now?
>=20
> 1/6, perhaps?
>=20

Why might that patch be a barrier?
The only concern that has been raise is your question about the locking
environment for the list walk and I answered that - the list is
thread-local and doesn't need locking.

NeilBrown

