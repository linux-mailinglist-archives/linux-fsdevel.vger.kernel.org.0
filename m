Return-Path: <linux-fsdevel+bounces-62367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B20B8F4B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8B179FA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6E255F28;
	Mon, 22 Sep 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PF58drar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fj5BuTrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34234BA39
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526219; cv=none; b=trXlv8sBhxwukhuNfdLdoZufpeXWwe0ur0nTO6eFxC5UL6gZjkHLRQnU+AgqR0Sm2IBClu/RAxnENswTVAl6Px0pv11SGC0ZE5rpmaqYTe1HPDQVFvj5wGVQ7Edaajk3hJbgitLUs+L0ko2xuDXRJFN8PhXWYFyZ/AhsQ4s4FtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526219; c=relaxed/simple;
	bh=QWTqqWsazuK30Dfj+iD1RgBVe5ng8dCO+kTGCYpFSwM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=eeDKWJuBHLdKvcY80HBqDgQ43TA0Xtq/AYYUM/XcMD1s0ps+5PcDDC4i/RaKrHpKpnzoSxLgH48nO9wM6Pmd7aE+TIKJL3xbguHlMFlUtCUdpjkEUSputyKldvASEjb/KTLC4li99Xw7TyiwtpvUcbLOgoNrRbyHCDN4AsXko/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PF58drar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fj5BuTrr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E45A07A0205;
	Mon, 22 Sep 2025 03:30:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 03:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758526214; x=1758612614; bh=ij1AEEteq5xLs6S1pJUDv8LjjQ90AZ9sSdW
	T05QLrQw=; b=PF58drarO7WgZSO4/ya7VVL9LsDs7CXdczwxjRQxDEcf+kRPEao
	X5cz94nxsccE+F6lJbikzOqeiQg584qiTUHrdanfFlVbpJLUn63GYUj5zN1gsmJj
	xvKTVJ4qPuF5wAlRxopdUUy31qiB6OPn4slGsIcndG+e0KknxLQzSAGmzZNWLzlq
	c6j3hmtyXMf7uAwl61b2VvrXUW00kzbMaz4ytng1WKN1kLoSF7xJ1N8lq1zgO1Es
	P+o9lMj/K3uaXtRsVrYAZb0R09ALRbULnKIPsHY0o+s5BWwQhvvnMluhRO2U1Uwv
	rLc6WDr6JurY39FZajnKGyIOMhKiCycKTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758526214; x=
	1758612614; bh=ij1AEEteq5xLs6S1pJUDv8LjjQ90AZ9sSdWT05QLrQw=; b=F
	j5BuTrrk/Bc0eYwOCq94boqxlPq76METDBL1hGIFXoMz/95vekGDgbao1QYGYnXi
	butwk1mi81Q9gB/GdSPJgdQ9Eqv2wgnmHhlXr40R6bfLh3v6M5Qe8JQdMlJbkKQV
	o9wg8EjJhw8KNtJeeu0LFT4PAugbpI20DAqn+utbWloHn2xFFnaqkk/D/HVQW5OG
	Fi2hkNcYwrDecpqO1f9z++y4zNV4FLlw974K5YRJLd8anxqODFjY9v9khqKlt1g3
	B/0YDmeAUBtIZ0vD+jSFignQnT+/FUvQ15kyV/4+VN9YQKYjxMyZrdEJnVqxe84O
	4sYg18XLkumYKbl3MpzJg==
X-ME-Sender: <xms:BvvQaCa2-65qS5LLsSfZdqiPjZ6zgZoGrKcxfgp8HXg6jJG1D8MzbQ>
    <xme:BvvQaMwo45N47bhyv2MTP7ZdaRCkxofgL5ntxjCM3k34eTdYzfpX-0yOaBiERqWYf
    X9JTQQFJ1GyEA>
X-ME-Received: <xmr:BvvQaCirPZEqq7DSwRiZUuCLUGuTcWk69Ixxoz2VVvp6bHj0EQbWRACO9LgNQJfbBtE1fTcLpy5iRQYA4FbJb5QYPPa6P7Fn5aTIKkqipSpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BvvQaAmsK6OthTOm1IGDGPopOLa4oXuHuXSgHB3OGRTACQajTqAssw>
    <xmx:BvvQaAjEI6s7nSNi1h-p86IuKTPUK6KWlnf8dZqlcz8xA71DU7xS7g>
    <xmx:BvvQaM17bu_UAGukMtN7Hz2_MNa0na0h0R3HAkpbAJO-Oq6w9qTeZw>
    <xmx:BvvQaBJEjm69smpMk3zkeO8evC7oFNgQ5XLs3eZPfGLAbRe6DKWmLg>
    <xmx:BvvQaJJzqAmIuqPt7t17bsFnl6hUf-qdE961-oAPRCQADuA0n3yopEPS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 03:30:12 -0400 (EDT)
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
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v4 5/6] VFS: rename kern_path_locked() and related functions.
In-reply-to: <20250922052100.GQ39973@ZenIV>
References: <20250922043121.193821-1-neilb@ownmail.net>,
 <20250922043121.193821-6-neilb@ownmail.net>, <20250922052100.GQ39973@ZenIV>
Date: Mon, 22 Sep 2025 17:30:04 +1000
Message-id: <175852620438.1696783.572936124747972315@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 22 Sep 2025, Al Viro wrote:
> On Mon, Sep 22, 2025 at 02:29:52PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > kern_path_locked() is now only used to prepare for removing an object
> > from the filesystem (and that is the only credible reason for wanting a
> > positive locked dentry).  Thus it corresponds to kern_path_create() and
> > so should have a corresponding name.
> >=20
> > Unfortunately the name "kern_path_create" is somewhat misleading as it
> > doesn't actually create anything.  The recently added
> > simple_start_creating() provides a better pattern I believe.  The
> > "start" can be matched with "end" to bracket the creating or removing.
> >=20
> > So this patch changes names:
> >=20
> >  kern_path_locked -> start_removing_path
> >  kern_path_create -> start_creating_path
> >  user_path_create -> start_creating_user_path
> >  user_path_locked_at -> start_removing_user_path_at
> >  done_path_create -> end_creating_path
> >=20
> > and also introduces end_removing_path() which is identical to
> > end_creating_path().
> >=20
> > __start_removing_path (which was __kern_path_locked) is enhanced to
> > call mnt_want_write() for consistency with the start_creating_path().
>=20
> Documentation/filesystems/porting.rst, please.  Either in this commit,
> or as a followup.
>=20

Patch already contains:

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystem=
s/porting.rst
index 85f590254f07..e0494860be6b 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,15 @@ rather than a VMA, as the VMA at this stage is not yet=
 valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+---
+
+**mandatory**
+
+Several functions are renamed:
+
+-  kern_path_locked -> start_removing_path
+-  kern_path_create -> start_creating_path
+-  user_path_create -> start_creating_user_path
+-  user_path_locked_at -> start_removing_user_path_at
+-  done_path_create -> end_creating_path


Are you saying that it also needs to mention that start_removing_path()
now calls mnt_want_write()?  Or that end_removing_path() should be
called to clean up?  Or both?
I agree that the latter is sensible, I'm not certain that the former is
needed, though I guess it doesn't hurt.

Thanks,
NeilBrown

