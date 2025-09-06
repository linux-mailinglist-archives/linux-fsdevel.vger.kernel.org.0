Return-Path: <linux-fsdevel+bounces-60415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD18B46962
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7867D5A644C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 06:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAED29E0F5;
	Sat,  6 Sep 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mcLZuEyM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNKjyc7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148A14B086
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757138905; cv=none; b=bWZRDfGpjcLzKzqo65p3JSfVteXT+JOx0mbcQzuiyd37tpb/XSNdgFXJGeBENtwgwocE/KPGZMXpxXcFMpO4J1Nxuge7jm5LbzBjq3BTiilzx4Ks7a0F0karsYslfKaFwlRbC1nF2FwPC53wswIvuyJ5HR3CYIRP4MZMdf2avBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757138905; c=relaxed/simple;
	bh=yWD5xFx4Bqg82T0P8vZC2qkHGyIz7w3a9FnA7WpF11o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LWOAnw2F3y9Bli4jRESBsUkMxG8ncLy+p5txMh9NQIZDMfRYVwh/neRx0niuIU/Cy1opXvhoggKH5WlGf7zWFKS+3A/SpXzTl0Q7DyCmX3ifp/K62AdqYchqnT4CBTFrgbuDvDtwH5+fnCneFJCdREBG5JMrp33oAOAu1P357SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mcLZuEyM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NNKjyc7v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 10CC6EC0322;
	Sat,  6 Sep 2025 02:08:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 06 Sep 2025 02:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757138902;
	 x=1757225302; bh=6HZJHo8fy/olclxztLAnE+x2Rb2KohEjTwRF5O2jMrM=; b=
	mcLZuEyM/h7onxPajcrXkr2dD8z8nzuiPvSmCmmk3XVg9pRVySfQy1QGWgPJW/BC
	eCPXEqHTiCXiPVUnneE0j83gEiilnZUpck++/DkXfdjfD7cQwwzLnuip/SFggLQc
	N7W7E31tiYnLp46vU2OAxGOO3PH4mcMkFFJqVeOKysl1wQ0DsVXws3fSm4atAf8B
	9Dyuu04K/AIjnBqLOY3+gfYwc6rFSY616es7aJiHJkpYVpJXs5h8WnsckN2qPyc1
	53s/cDjiT9EEoqx9Vl6zuHY0u4KB3OKZiX++pEKrGdtgJp1XJbbUeg023d/n1Z7z
	7Enu0hDaxF9jpYNI33OjzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757138902; x=
	1757225302; bh=6HZJHo8fy/olclxztLAnE+x2Rb2KohEjTwRF5O2jMrM=; b=N
	NKjyc7vkA7BvqDEdEEWQqwQ/5mEdxL912kW+ejNAPlylyqdU63lq2aPDGiH+vPx3
	gNvGefuKl1VMoSYOD6B7GeSbxzmbkHjdru8QzRSfR7hvjXP9qkokNILdBeuLpBHU
	aCEeZOebasFZ58q1vFORXiONc+iU+dB/+RzijsTxzAG98R9BgRjQBTckuVpNlxUe
	y+ZtIIsk8GpXpT9zOHPgGmW0z4PQX/8GJe5vl7qXNE3qzHuLaME0Z7q8fY0tMqn/
	oF0mGmg7aFhch1D39QyvyCRBu/0A8xltLVa5VAntk+p1GS2q8bGeN8HpVBiCQjTB
	x5LdELHFk9Pl2FSmcP7aw==
X-ME-Sender: <xms:1c-7aJNo16saGPAW573BPNmbBuejZW6nlzag5EvgyrpgeVnYEEeUew>
    <xme:1c-7aJ7gaOoLj4kFRdeIuoSf-eGin89Gf-u_TfewV8SI3bfGjbjh77Es7fSnMSPkE
    CKmgflbit4buQ>
X-ME-Received: <xmr:1c-7aKnYjhV2jiR4JMlsm8Gl3NBbYDmkfOTgVShHAleg_7JkPOGmyVRjTrMc4mXkaJwa_RxScYbYj6r2m-88p1SpHHhb_1LPjlAnsjFNL5uq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtqhertddttdejnecuhfhrohhmpedfpfgvihhluehr
    ohifnhdfuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueffkeetfeffieevfefgledukeelgfelveejteeutdduffduuedujeetteehffefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:1c-7aKRwCRdMlwkTkP5T3AcaC_2cwAXUll56PQYHQe3XpuN8ase2JQ>
    <xmx:1c-7aJG9VT0ikB93Sn4fpLisul3a8GXEA4aipo9-B3qG1cqcFU-5qQ>
    <xmx:1c-7aPHL8wun4CleW2R-iELh4AbC8-MoCHx_Ib4EA0i8mynPxk901g>
    <xmx:1c-7aHR6ZK8TMs4SQFyiirSXDASoB1jIzDQf2bPL-wlYQlGwsMnyPg>
    <xmx:1s-7aMA8F_Go8bi1RK3Qkmr5G4n2n_NEVepKaIe3XEdIqocpthLpYqSS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 02:08:19 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc: Don't look root inode when creating "self"
 and "thread-self"
In-reply-to: <20250906055240.GT39973@ZenIV>
References: <>, <20250906055240.GT39973@ZenIV>
Date: Sat, 06 Sep 2025 16:08:13 +1000
Message-id: <175713889363.2850467.15098685984482981601@noble.neil.brown.name>

On Sat, 06 Sep 2025, Al Viro wrote:
> On Sat, Sep 06, 2025 at 06:50:05AM +0100, Al Viro wrote:
> > On Sat, Sep 06, 2025 at 02:57:05PM +1000, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > >=20
> > > proc_setup_self() and proc_setup_thread_self() are only called from
> > > proc_fill_super() which is before the filesystem is "live".  So there is
> > > no need to lock the root directory when adding "self" and "thread-self".
> > >=20
> > > The locking rules are expected to change, so this locking will become
> > > anachronistic if we don't remove it.
> >=20
> > Please, leave that one alone.  FWIW, in tree-in-dcache branch (will push
> > tomorrow or on Sunday, once I sort the fucking #work.f_path out) there's
> > this:

Sure, I'm happy to drop this patch.

>=20
> PS: you do realize that we have similar things in devpts, binder, functionf=
s,
> etc., right?  What's special about procfs?
>=20

devpts uses simple_start_creating().
The ->lookup function for for procfs will return -ENOENT for a
non-existing name rather than returning NULL and leaving the dentry
uninstantiated, so simple_start_creating() will fail.

binder uses d_alloc_name() and d_add() without any locking, which is
exactly what I was proposing for proc.

functionfs seems to do the same.

NeilBrown

