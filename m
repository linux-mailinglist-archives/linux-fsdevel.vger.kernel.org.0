Return-Path: <linux-fsdevel+bounces-60405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E6B46923
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9347AC63B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7B25CC58;
	Sat,  6 Sep 2025 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gLw5uNDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3JFO0yN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEA18C034
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134854; cv=none; b=enjIYjoL0k39k43oGNjTtAYxhEUquIKQaTyy6ABfTrMAVv1pkzgO6Ec7m+QK747rn7vgBuiE7bGSB/q06Cs2cl73tKJTDI+mZY5eRFuB6B2J4hw2Md+Qwd+IWgCm2orEhE925LtDM6tgwvX+Av+KrDqt2QOX4WcF8jB/WJ0Ju2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134854; c=relaxed/simple;
	bh=GW3U4jnJgJC2VBKcilY6dDv9+W1bogkpTQcWY5vAgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ry6ZsemKTbj2qjzQdwq4VCqRLJ30KrkeFCyblbvfYf0j/kIR8kmdeoQKZ9cSx1UqOym7uqG1LAXKjssO1yMZEaE/VEY0a/3qZdPOelCIbuH8RJ9SC2cR0FJD6BYdcdhxlYId2O1eFB4hOnQvugQgK3kz1WkhckPHojhj5mLowWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gLw5uNDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3JFO0yN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F0637A0390;
	Sat,  6 Sep 2025 01:00:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 06 Sep 2025 01:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1757134850; x=1757221250; bh=jQ9Px8mQZP+rK+uq5VEVI
	mmBGfyW/rdksCBKCHpeXXc=; b=gLw5uNDlZXgz0nI0JSf5x6lyk19QgBMoauOjN
	mbJqEwptrHX+J1ucxTtiJ21igTG3MvniKxwDQTUwxm9eAJN9v2I7OdBpDaaMGzzN
	iiDvNrE5S8cK1n/oRiQjWGgbgtcXDQh9EQCfs3p4/AI2lJAW5oqADTSn5h/6/SEt
	NX30ylEiqm10yivs0DtXqMihpblLVlIK5ljXe7TQ2S6+i/cy3ExxSN8ERbdG+8wB
	yQeGXzoH625Q9H7CKcDTYy50PzYFVLUKJcv5ygoQKokeRgLBAwXhXCUC28DfGcqU
	gxFX6bGZnsDw5UbOYv4Pf6csWGDJHQi0j7NC6ORS7vyokeM7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757134850; x=1757221250; bh=jQ9Px8mQZP+rK+uq5VEVImmBGfyW/rdksCB
	KCHpeXXc=; b=L3JFO0yNrJS9UBxUIg2Bw9e9EhzqE4H/VSbh3h/J0/2I0rSMMUP
	mPY6DfLEpvGr2K0xFSXiZEmY0X187rPs9wNvF25dlBjQaZZO9LOa1pl32K1/Y00C
	xPgstj5Rd9P34sCwIaAmaRjSFbSlbVWJYUxirvExfXuzShUEirH5S86HtuRGPerS
	59SBp65IFjYsk+z12OEs6rAZijkevZ5omsqq2vPo5cK2AWkzNDHAd/5ROTWmuxKF
	z5ossWTDqGtTqxKGZy1KC5dRavBxd1iuK0jOPnffH7HGAUAueBdBj3zr50N+xtt/
	TCGYIMMm3WUsLXi1ZXAaee8Trx6E5ESYkgQ==
X-ME-Sender: <xms:AcC7aDSOTAyqmjlUZxCzaRRu2PKA3cKxEbe1F7FvLpHZST7zJWoUsw>
    <xme:AcC7aCuMhIrZMHpfHMeoJRZdeGEmSZINx4JcB7bIXV0yXGjYzyLP-OjK2zdebV9b6
    xwxafQHHnTK4A>
X-ME-Received: <xmr:AcC7aLKRc4npJxwzQI_NgkrTGI9T7yOJgHS99gftmquPCgReXrrvT1t8VWBlsh_C2SdbZ_qufa5CbJ4VR6wcDmpJczkXpuTXuxxFE_XydO0v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhhofihn
    uceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepteeiff
    ehledthffgieeuveetffegteeigeetfeffueekvefhgfdthfeugedtteehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnh
    hmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AcC7aHlP9k_i9FhdX-f-pXJZy8G9yw5BBwqWsvF6aYx816h4rnDTYA>
    <xmx:AcC7aEL8v2ywNuJVV8lsyNSh5jJzkMI3IjJB2-UHas2dVmDrd24GGg>
    <xmx:AcC7aE6Dr_lkEM1SQ3_twLkt2jVqS5xE8wDl94tqjMdiv1VeMX8HFQ>
    <xmx:AcC7aA0byz4C6pzOYTbiPEOOvjmsatn8pj5oql-9M-keci9kc77u0Q>
    <xmx:AsC7aD2qIhVd52WDqMfdKGMwGAvIxUkn6tMycw3RrX7D3Gq3kHGtHEjk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:00:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] VFS: more prep for change to directory locking
Date: Sat,  6 Sep 2025 14:57:04 +1000
Message-ID: <20250906050015.3158851-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a selection of cleanups, renaming of some APIs, and the
addition of one simple API (patch 2) which follows an existing
pattern.  It seemed useful to separate this set from others which
will be primarily focussed on adding and using some new APIs.

Thanks,
NeilBrown


 [PATCH 1/6] fs/proc: Don't look root inode when creating "self" and
 [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
 [PATCH 3/6] VFS: discard err2 in filename_create()
 [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
 [PATCH 5/6] VFS/audit: introduce kern_path_parent() for audit
 [PATCH 6/6] VFS: rename kern_path_locked() to kern_path_removing()

