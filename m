Return-Path: <linux-fsdevel+bounces-58061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BFB288DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2776AC74D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD62D373B;
	Fri, 15 Aug 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HDrvnGEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbE4w8/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A72857F9;
	Fri, 15 Aug 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301196; cv=none; b=kGd0Kq9VFoAKLarzZqdxlIjOm/sfEAm4EGjCWNGCb5Bf5n3CCmyNO7syMUxY1qHucqRTtfCRkrh/1lC+Y7NAVVrxNG1RaEsHDhvkB7TQDBgc0mkElir/WFlJSf7C/Nlnh3q8xyXpDGnZpa8NuVe1aCnLxxFeXF+bmgIs3dPexFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301196; c=relaxed/simple;
	bh=3M2l1wIQfu7wQgiOq5u+MWbJdPn1G8pAQdkNqbVB+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7YmFntxQuVPI2O20r3SqwpTYspQcW1xgmjxh9lihh7A+5Hj5lGkzjl69S5xFkacoUoiv97nvFoJtPZQMCja9pvOPICeAWpqyg4QmeVVmE1CXNrRi/WxvVNyQAHYo/xKmXJJwfyYSmrumXVRjFyCxPTtOXPgOMjALSwvnSGhMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HDrvnGEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbE4w8/g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CF001400079;
	Fri, 15 Aug 2025 19:39:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Aug 2025 19:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1755301193; x=1755387593; bh=sZ4Ffa9LjIufP3LldpHrc
	2CPMG78ZFVCnuyEXE80K6w=; b=HDrvnGEGjkl0Jx+ejkHkEaBCQx5AcsEO+ii40
	g/5mfOvJ5V4n2Zgc3gfOdQhkX9Fyo0SpGvKWu33C1sUyoy5zPEvSC/u0/E1Bv6jn
	NNuAk8piVk0seSWBAwoqTkRRa1H2p2Ja2DLq5TTqdDxYsmlsbCLJjRvmuOhP/dPu
	e9u14a52jfOQDMaRZ6ygqk8em1IiMXw5p+kKyIrZE25KVCgtHNVsDZK6CYPfAZ8Q
	lyAuqTm/sZU+tZRN/kVmLRPpHs8gzkVRt2xxN8cUjVSxnHlHyb3nDV+NbVfjPpyj
	K+b7y51hkjLll9uHkBmnaGikei87U4tcd4A0UKbJLwA4NIArQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755301193; x=1755387593; bh=sZ4Ffa9LjIufP3LldpHrc2CPMG78ZFVCnuy
	EXE80K6w=; b=hbE4w8/gg31GsY51ankoKebjx0j9ytY1l88OWskDjBm5V4RDWFr
	CMqOo7tPDcAFEa7m5KyU8LlMbfQ7OUwKpCvYmYVnMCiX8tk8/kTMqhGXZKZBs5X4
	JCNSQAVv0HFeuvq9yxL0VVL5AmSmhBdUxVViQYuo/z4speSTc/oF00KvdK/zJ96U
	LKwH0shWOGCRHYfMBd+OdFhEWXSOWYO3ikXWjicZxOoiBNuAlhCLLK27SW9PbgQd
	XLoUGlXg2kYfXmQXQueOjfY7VNHX0yCJYl74jZ1uFY/DznNWn/7vyXFtwoenPy4T
	M4rqTLTu+GIVINSjvdonoCm/UckWypgdcTQ==
X-ME-Sender: <xms:SMWfaKc14A97yBhu4P2td-DDLCjev2yovlRtCBuumLQkelRX5h3dzA>
    <xme:SMWfaIC2U8J9L5GLb_t99D83ZBrT6bsGbTZmwYeuxoywxHU_sWgVrV3A4m8Ww5NJm
    8Utj1j0BAJuDmS20d4>
X-ME-Received: <xmr:SMWfaEkU6YMsGYRUK68IQiH4BAsA-xYHzho-AJEQ6xM4Fml9Rd_U7xDlaUyN_6iXepf0wHvK3dEm3aWKUqQGuq0u8eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhr
    khhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieegleehje
    elfeeifeeiuefhfefgvefgkedtjefhiedvveetgfduleejheeifffgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthht
    ohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepfihquh
    esshhushgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhr
    gh
X-ME-Proxy: <xmx:SMWfaLeUnQfpzjgLCkb9aVzWqBh0_bUPE7pAuefD1g8ERS_ujenqmQ>
    <xmx:SMWfaAS30SomTNa0YGBK8NEw9XYGAZF04xQF8tD1MWzGljwG8bZ0bw>
    <xmx:SMWfaKtC9WgEVzTmCxbn4AorxehnTZiosA_yRP8j_GcX1YRODK_ezA>
    <xmx:SMWfaJci4D4nKAfaZO1HP3jubIhBl00leIcyzSQRHZN795thq-vDLw>
    <xmx:ScWfaI98xR2MCZFPU5b8kA57YJ9plX2EWtzu2VaGS3nhSM-GlxUyYf6f>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:39:52 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org
Subject: [PATCH v2 0/3] introduce uncharged file mapped folios
Date: Fri, 15 Aug 2025 16:40:30 -0700
Message-ID: <cover.1755300815.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to revisit Qu's proposal to not charge btrfs extent_buffer
allocations to the user's cgroup.

https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/

I believe it is detrimental to randomly account these global pages to
the cgroup using them, basically at random. A bit more justification
and explanation in the patches themselves.

---
Changelog:
v2:
- switch from filemap_add_folio_nocharge() to AS_UNCHARGED on the
  address_space.
- fix an interrupt safety bug in the vmstat patch.
- fix some foolish build errors for CONFIG_MEMCG=n

Boris Burkov (3):
  mm/filemap: add AS_UNCHARGED
  mm: add vmstat for cgroup uncharged pages
  btrfs: set AS_UNCHARGED on the btree_inode

 fs/btrfs/disk-io.c      |  1 +
 include/linux/mmzone.h  |  3 +++
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 29 +++++++++++++++++++++++++----
 mm/vmstat.c             |  3 +++
 5 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.50.1


