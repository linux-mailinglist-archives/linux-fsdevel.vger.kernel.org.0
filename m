Return-Path: <linux-fsdevel+bounces-62686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07BB9D014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 03:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7452F3A6176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C482DE717;
	Thu, 25 Sep 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZaMqplNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hwp5FFOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB512F84F;
	Thu, 25 Sep 2025 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763326; cv=none; b=OX4375mm+jcOk8N9codAYwKorr41nYcISEjrgS0EcCV42ESVjIGpLarEqhwr+aDu0WP06E0HB1og+NvwUbjuVh3Gc1ZE2TfU3UK53fK+ZbCr8otusYCFwHT0/c1Zrq7k8kD2juq4hVWfHMgUCCwX+qHHoe+dEaVL7eKtBV+LvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763326; c=relaxed/simple;
	bh=YdDmNoi4VG/ibhB+Od0cWZXiHImCKkMC3iccKlZuAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFW1UIkf4cdA1lpj+EkUMunjUQ66fkxtR1UsRHKdWCK16RaztEEuOzeZmigQo81fVhdfzsp9uN+R7mZzI2ziSqNiVrNcYdIufPmL8phTsWbAiTiBx+Bh8PCewNw/UZj5VZC5rrZMNwytI6/lL99QvhfP1Bl9HD0klvhHazZk5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZaMqplNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hwp5FFOk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CCE3EC01A3;
	Wed, 24 Sep 2025 21:22:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 21:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1758763323; x=1758849723; bh=ykqbCNnzPq
	n5P6VIp5/7eU1qjm3yp/m1ikX7a0JcGDc=; b=ZaMqplNnGC07sHYWcaqgONVUnd
	dayMMrIpP1kmeuZBe9e8JnoU+t3kBEOZWclApGGcx9pyFZeDtZhGQOz/lzaY5rKx
	rWHxESokke0IM/QWEOeM4fvNhYwx9hCSZtajC2SOrfNokojo5aqgcjJaMOMeOsHM
	+HUf85AK5nZovg8CSnfTVCRdOoCPkAXyfBy1CpGLqca0MDRep26tEnvTO2PbA9mm
	rJbRAVRdjt7968f0mzZb2p7ZTwDlLdhtTXaE/992oaqrvzRUVZcafVteAeevVyOQ
	4+b8xfakP58goVf4y5WsCkqdsUJ5R4ttwJGBOgShoHJEbRgkq8AXg+d+vivA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758763323; x=1758849723; bh=ykqbCNnzPqn5P6VIp5/7eU1qjm3y
	p/m1ikX7a0JcGDc=; b=Hwp5FFOkOLm07a9xCxxdC2zTAI+9KGTJDZpLrwlIYasd
	D5p6nT0tbWGeNrpRKWcvbbTG2V2Eiz08Rxql+C2Otu5nklBDaqQ2dkzU+c/hE0gp
	cZcm2IMjNBdMrBQFOq/bWxEp9JTW6b6v1tL/0B6dbp2ogkvKSAUK9zmZ0fYmunk9
	wXA+RDDuQLqug1yhvxnvSMSYxYrj6ZSA3HayjbCYPTSf619XOvR8DdsdQp7RzEqd
	1K78N5UYwGKeGaoUa8Cwoe9xBdvzKbnxpmHK8Uc1AxJbobnqRX/a3BtIiVlQwYlN
	mOVAfPHBwet0EhNJGB2r+rfgARGyZUzuQ+L+tCz+6g==
X-ME-Sender: <xms:OpnUaLHJ2BuT32iE26SbyNn_9HuVBFkh92g6eNg1jvq-oSi1cMbJ9w>
    <xme:OpnUaHbhF5xbx7nUd3N3KeLmAVgmRN9dDo0oAgwJjxRmiF63-NwPBe5z37pyrohSt
    ZilsN_-c6Ej-lp38q_Qob42K-Ai1M-WDWFHM47AKLENrhsK8Q>
X-ME-Received: <xmr:OpnUaDXBD6t1etTF_m-8TWv6zM-3w_IRC4VEqe1E8aLeT_AzlqVqNmNVYQ5BJq6a37YB7BkO8QmU89BbEwjeII-k9_kIRF1RPN6TCoPrsmaX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OpnUaFn_D4UXgmd7AdiWvWdUUAJJOuZ2QraP8GhS4DBikYXwsJr8pw>
    <xmx:OpnUaGA9hMPaltBo2IkwwittTm5FmxXuZINEjiMxhHAhBT-J9EsnkA>
    <xmx:OpnUaMhfqsNfNxwKJ0i3-Hkknwa985lpCr6JdqeiqWNcaReHVYjwoA>
    <xmx:OpnUaLzIu6A00e1aFN98cwbugGoo9i5vHtCtIqx5Kv3VxBjqDHlZ_w>
    <xmx:O5nUaD5DvdVogJrd4yrIbw9Hbo8jMvtj4jNs4Bqejbj06IpwVmlY-vLD>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 21:22:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] VFS: change ->atomic_open() calling to always have exclusive access
Date: Thu, 25 Sep 2025 11:17:51 +1000
Message-ID: <20250925012129.1340971-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->atomic_open() is called with only a shared lock on the directory when
O_CREAT wasn't requested.  If the dentry is negative it is still called
because the filesystem might want to revalidate-and-open in an atomic
operations.  NFS does this to fullfil close-to-open consistency
requirements.

NFS has complex code to drop the dentry and reallocate with
d_alloc_parallel() in this case to ensure that only one lookup/open
happens at a time.  It would be simpler to have NFS return zero from
->d_revalidate in this case so that d_alloc_parallel() will be called
in lookup_open() and NFS wan't need to worry about concurrency.

So this series makes that change to NFS to simplify atomic_open and remove
the d_drop() and d_alloc_parallel(), and then changes lookup_open() so that
atomic_open() can never be called without exclusive access to the dentry.

The v2 fixes a couple couple of bugs and revises the documentation to
remove the claim that ->atomic_open will not not be called with a
negative dentry and not O_CREAT.  As O_CREAT can be cleared late, that
combination is still possible.  The important property is that
->atomic_open will now always have exclusive access to the dentry.

NeilBrown


 [PATCH v2 1/2] NFS: remove d_drop()/d_alloc_parallel() from
 [PATCH v2 2/2] VFS: don't call ->atomic_open on cached negative

