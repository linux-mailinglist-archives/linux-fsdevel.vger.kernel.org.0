Return-Path: <linux-fsdevel+bounces-60869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EEB52449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 00:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285E61C81198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC9306493;
	Wed, 10 Sep 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hIQE6v4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPRtcxlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62B3FE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757544783; cv=none; b=TaoPrMXkRtZ1Zi1U8V7rQL8s/wBOcgR3tjRKNhxtWMozAtV+HBeJ31z0JHYkmGezlCQamsSn2cBjC5X1UDCrOVVKYC5I+3Qa5Rj8LpHWmXxCJWi5QQIm/Sylmw4jnKqrj9qpCmbJrlSW0TEPZzbYGKPSbTdtU1/sqw6sp11Hpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757544783; c=relaxed/simple;
	bh=zfJh1194wu5My6wYs9ByZLcFRkMzzTxu8Sk1/+thGJQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=djqMYVmgMDBSXBzqfZiRcN1UqyUtGML9a1nsNdS4rG308Sko086JVxUmo92mJ5WMcQo2AlL9oeGYIxOKPfrgA9LlidXoOsxu+G0cm2EWHMOFf08+0zL5owfUejUDop/oi0RLVMPfv9bftXQFnpw5ovGjzrrFP5X/7Y/dLuArzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hIQE6v4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPRtcxlX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D73F87A0134;
	Wed, 10 Sep 2025 18:52:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 18:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757544778; x=1757631178; bh=kfbWiRHMT7a7kXRlr41kdQFDvD++NeYyH8x
	BB6eaWDQ=; b=hIQE6v4kW2Fs1h9VG+7BauK1JpjNLY8MIXRvqg3PJ1avgTBkXc/
	pbMcEY99tVWxtN5AV56HhcRIS726O5F/KnA3WaCltbYkFlEtlE4qYZF1w6LSmUCp
	U+yVBrHPtBGmg8AV3DRp3OW2VV5YKirq1akH0G4guYepxWVwXS4eI1Y3toWOPr+J
	90jvav819rba7jSWeI4pmMkiwn/WsYQC3UGe23Ao7UETPxZzvegys6RnK5DwUW4O
	LybCZu1CZaGVG9wY/T6SPEpF0aGZFAAZigtRLvCFDBsQBVGgrTgw7ezKUE9bgp1c
	Lq/YK67On2zQdMgJc60w6Pl/+ecs4/qb+KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757544778; x=
	1757631178; bh=kfbWiRHMT7a7kXRlr41kdQFDvD++NeYyH8xBB6eaWDQ=; b=X
	PRtcxlX6GcSfw8aWsUPzbn0MdVgL03G2OvX9+nR7d1LJhNfk+BegYsQvOK/NI38M
	xmQdQSSyRFVberukwFe7uUVpbGMM+FP24hh9dBCQosH+7EsR1CusWJlrI/8u7eXv
	wLE/mftD9b2PqiouOOhrG6M3KS8RU82e56cgtAxpcpZYC/TVWxlvZpT9TJa8zPGs
	2mlHZ7y3R0iTgX5FYFkpZUUUZLOTLXFhsT6pZvo+9aTadqYP4JD9IEX7kd/iaEZH
	7bMM97agnclB9kU6BEuIoDoNewJcOZKxbyR4rSli7SBE7lRIio3Cqm1nHgibUsuK
	Qu9OhrKJUvm5G7IJpCu1g==
X-ME-Sender: <xms:SgHCaKBaJb-wOHKzjH9GFBxu1HA315gPflSvz7fFGYpbMxafeoajxw>
    <xme:SgHCaCeeDJTNFEZrIdeB1aJcOPqrN4sBKWMta-qoXfd6guJs4JY0TrTjKZFVvR3q6
    31sD43Cmf4QxA>
X-ME-Received: <xmr:SgHCaP6h2_Ri1-8epECK3gP1Tp1JYDXZPSArfzvCn8623HCdEVZNWH-ieLV3rL7Pqfww6Dc9QoZEvdlG76S71VVh7k0AdbqQTqFjZiCmiClB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvrhevufgjfhffkfesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    efkeffueeuieehfeeihfegheefudejfeeftedufeduhfegudethfehiedugeeikeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghrrghunhgv
    rheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SgHCaNWH-XcB64Su8ZMV6iTCNyaRZOGPzPOmfAL-38B4YVQ_RPcG9A>
    <xmx:SgHCaG6jkRevvmAiXTMe11CrRS5iJMvD5onm_GyOJweWOcfF0de3RA>
    <xmx:SgHCaAo5tVWzB7axGElA0S80Maw25ZZa3eQMnFSYrx2PNwkJNhoKEw>
    <xmx:SgHCaBlk0B8DtayBQOvMpII4DwN1bTvkUi2oeTCTYoY-HXOE_rzTrA>
    <xmx:SgHCaHnFH2uvjOUuATkZVBtDnaRqnZuK45dLh8_rFyS18ZSIcqKMFDXi>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 18:52:56 -0400 (EDT)
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
Reply-To: neil@brown.name
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250910072423.GR31600@ZenIV>
References: <>, <20250910072423.GR31600@ZenIV>
Date: Thu, 11 Sep 2025 08:52:52 +1000
Message-id: <175754477209.2850467.14429587967463898116@noble.neil.brown.name>

On Wed, 10 Sep 2025, Al Viro wrote:
> On Wed, Sep 10, 2025 at 12:45:41PM +1000, NeilBrown wrote:
>=20
> >    - dentry is negative and a shared lock is held on parent inode.
> >      This is guaranteed for dentries passed to ->atomic_open when create
> >      is NOT set.
>=20
> Umm...  The same goes for tmpfile dentry while it's still negative (nobody
> else could make it positive - it's only reachable via the parent's list
> of children and those who traverse such will ignore anything negative unhas=
hed
> they find there.
>=20
> > One thing I don't like is the name "unwrap_dentry()".  It says what is
> > done rather than what it means or what the purpose is.
> > Maybe "access_dentry()" (a bit like rcu_access_pointer()).
> > Maybe "dentry_of()" - then we would want to call stable dentries
> > "stable_foo" or similar.  So:
> >=20
> >  static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >                       struct stable_dentry stable_child, const char *cont=
ent)
>=20
> That has too much of over-the-top hungarian notation feel for my taste, TBH=
...
>=20
> Note that these unwrap_dentry() are very likely to move into helpers - if s=
ome
> function is always called with unwrapped_dentry(something) as an argument,
> great, that's probably a candidate for struct stable_dentry.
>=20
> I'll hold onto the current variant for now...
>=20

Another idea - maybe we don't need "unwrap_dentry()" at all.
Just have
  struct stable_dentry {
       struct dentry *dentry;
  };

and code can use child.dentry.

There is no concern about people misusing unwrap_dentry() so there is no
need to be able to grep for it.  So we don't need it.

It is only uses of claim_stability() and of ->d_name and ->d_parent that we
might want to monitor.  So I imagine that one day all accesses to
->d_name and ->d_parent will be centralised either dentry_name() and
dentry_parent() or in fs/*.c code - and then we can rename them to
->_private_d_name and ->_private_d_parent or whatever to discourage
unwrapped access.

But accessing the dentry in a stable_dentry is safe and uninteresting so
there is no need to wrap it.

NeilBrown

