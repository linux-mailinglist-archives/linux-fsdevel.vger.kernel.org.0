Return-Path: <linux-fsdevel+bounces-64176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A270BDC056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 868C6353C1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25092FABFE;
	Wed, 15 Oct 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="kTspozWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3mx+uA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D42F7478
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492893; cv=none; b=KyIETyOQXP1OzGjT0ubAWyq8CMtxmwqPhFp3BeYLJ9mmGNuUI80zLEnJLcWHVrjMC9U7Qe2Fe7tT66E+6F9gFmSoodXV6etr76hS6gfMucusSk5i58sqw/oYk37xqKH0mPfdojPSuODWsHtyrl/KIyoo3d62JxhpLWJRLNPxhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492893; c=relaxed/simple;
	bh=K3hLD0sSUiPdZTAuBvTnRAuf/dhsNvD9+8VG2yjikww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bt1htH2kPO70Zt65sTS5aiFOoRX8tWSv6AwZos5N3fOOStR8wAR3ro3Xv8iGengbAWLYUPtIV0cFczfLx15gNGxkLNVVxIsZy3cPKjvkPgpd6+oRgDznn20JA7cT+Xdnl9Z0EWbHFe4CA8fXgVSLf/peJCmynkmpR7GBi0KZQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=kTspozWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v3mx+uA1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B81614000D7;
	Tue, 14 Oct 2025 21:48:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 21:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1760492889; x=1760579289; bh=e0tSsJjDvN
	4YWXUkunkiD5YBN1AIh2ndfBlZRXH0j6Q=; b=kTspozWOSLA4x+b5ulcIBmeb1w
	r/3UYjPF8vpv/NgTfbrnfybVW6peqwmp+TiZyOFXXNMT5mHDdLyj5uwRhjqnUwTi
	HTb9N8pbv29mwq1n92sO2Kaz8xb4jIti/tRZ5tcwm8Lu02G3tJY/xlOmL30sTsqY
	/ERExnqYSKyDfT64MyWtMgeU2qNiEMIe+5kqitlwVGndFSYiGQGD/SK5ekX06BbX
	uf5D9lu7/MrAy2YJhohVDrQ28cvrvJoQnK31lhSZN7dsIvHOMZJgNvhP4vee5S4K
	bXAwVy4d8aF1FWHxp9zQT2C0BB/HDlA7DEt7QQNVqjItzRGMpdrxocT1ajaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760492889; x=1760579289; bh=e0tSsJjDvN4YWXUkunkiD5YBN1AI
	h2ndfBlZRXH0j6Q=; b=v3mx+uA1ynYFibSLZSK6piQZPm5Zn79e5RASWU464MpH
	fw+Y0DT6F0u5sw7/U9UhGJ7YVcq2Ws4tUhuPLUgjpXSUHeB6WUXxxUYTkIcSyoEw
	EsOzqPyiuYyGLzcldGF8/ruOvEgkiDx5rgZv45K036IU54ctE3yKeauA9z8fTK9C
	IiOHWqmviYW8R1+7zHnPm0zndBkA6y6M3JWNS6259tHm23X4OgoB18qXoF13orMV
	lzDN5CtF+0+lEDYyOqd2AbDiGUz8PdOa0w6wKwf88ulTvsd7tC3IUR1coDU1GD38
	N9rfgkPSO1rpfUO5S/gGwL1xb8kFITwngU0/aT7SDA==
X-ME-Sender: <xms:WP3uaKgPaO8q-V9cGh07vB5W0XxID1sbD4QqORu1kolf04Fc2TGSfg>
    <xme:WP3uaF-5bxtlgyKAKJQPoM2oOs-0qjOUiZoguWUEYX952N9UIO6SxpHF5kR2EaffC
    fV8eJa6clmFxcCE_zZKY481qAsyt4c3KiJGlbs9GDy5Y3Llmg>
X-ME-Received: <xmr:WP3uaBG-uWJieTgPheSXapPkwMKFUGwOpdwtJwGY7XwySi7oBZoHq_Nc_3-TRACWWaSieSE1SGyPA0SMRNfuIfJc8QU7pBOiyk7rVbbmMjL9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Wf3uaIk3U97BS4y5RikvOLqLrbzBF-lyfbZw5HbA2dmNgX52Wt9MRQ>
    <xmx:Wf3uaFaX41hvddQDQGj2EQpNfLK6Wy0wzdKZXz8lYkez0VWATCoaPw>
    <xmx:Wf3uaNEh1vg5_dkgb-mDb-BdpF0I26xAWzsNyzmJMPydakIxEg1WeQ>
    <xmx:Wf3uaGIA7wcPGyD5PioO4y3H5YHsPFS-XHon-5cQ3swECZsEpltBPg>
    <xmx:Wf3uaC77xI7w2NghlaW01ueVASBjsyKfM6O4kYBj-YSMZ9stbKwL6yw0>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:06 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/14] Create and use APIs to centralise locking for directory ops.
Date: Wed, 15 Oct 2025 12:46:52 +1100
Message-ID: <20251015014756.2073439-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a new series in response to review (thanks!).

The series creates a number of interfaces that combine locking and lookup, or
sometimes do the locking without lookup.
After this series there are still a few places where non-VFS code knows
about the locking rules.  Places that call simple_start_creating()
still have explicit unlock on the parent (I think).  Al is doing work
on those places so I'll wait until he is finished.
Also there explicit locking one place in nfsd which is changed by an
in-flight patch.  That lands it can be updated to use these interfaces.

The first patch here should have been part of the last patch of the
previous series - sorry for leaving it out.

I've combined the new interface with changes is various places to use
the new interfaces.  I think it is easier to reveiew the design that way.
If necessary I can split these out to have separate patches for each place
that new APIs are used if the general design is accepted.

NeilBrown

 [PATCH v2 01/14] debugfs: rename end_creating() to
 [PATCH v2 02/14] VFS: introduce start_dirop() and end_dirop()
 [PATCH v2 03/14] VFS: tidy up do_unlinkat()
 [PATCH v2 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH v2 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 [PATCH v2 06/14] VFS: introduce start_creating_noperm() and
 [PATCH v2 07/14] VFS: introduce start_removing_dentry()
 [PATCH v2 08/14] VFS: add start_creating_killable() and
 [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH v2 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH v2 11/14] Add start_renaming_two_dentries()
 [PATCH v2 12/14] ecryptfs: use new start_creating/start_removing APIs
 [PATCH v2 13/14] VFS: change vfs_mkdir() to unlock on failure.
 [PATCH v2 14/14] VFS: introduce end_creating_keep()

