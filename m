Return-Path: <linux-fsdevel+bounces-50934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A0AD1398
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F02216960D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C61A9B3D;
	Sun,  8 Jun 2025 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="TbbuAvWU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/hURk7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302801401C;
	Sun,  8 Jun 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749404126; cv=none; b=qOs8xwJsfBdBjAm3RQk/IhdqpEZYtoTR8CyM7S08TMtd/8yNwZi8q/3NPZCwgGP+s1zsyfVMkn3iHGuGVIXmqfAJGqYGYArY3+LyOJ6hCJadh1diSxmr3MhzIHhVPv+1a1ycafPxQNeDXl10tUsGGyHjRGdhWp7f8ngrAa1ixh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749404126; c=relaxed/simple;
	bh=s+ZZ9XEgFAo4sFhNg0qJu9lkS3Q1APFw5rpz16qZeF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmIifwXMB2Q6C++YBrxnNEYZLdRMc/lX7tYZm+pJn+7wUYzbBIyqsO/VpHBsb4TxfI8gwU9RqqCpkWi+YsfKiJbgVggvpT+WIURO8mjC39WFEkg0om6wUy6MCcLZYA7mHAINfpODo3yyDOEmi3IbY/ggXn+IxzCI1szMjbisjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=TbbuAvWU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/hURk7E; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 21CC920034A;
	Sun,  8 Jun 2025 13:35:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 08 Jun 2025 13:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1749404123; x=
	1749411323; bh=wh/MxpBJZ3+0ErayESGRZXiw/uDy6OAY57TTmqYgFes=; b=T
	bbuAvWUN4u5IElYw6mkYrVTrVw7UwfnSPylRRh5kCktfpoYxMb8jYioA3fWME9WK
	7rOqWW7dLoVA+pNAwj6y6f3Fx6PZntvr1yksxY5DUWAOWO/x+ZeM8wcCdSnMQyV5
	AnRSb9NslblN3ColrXzSCHcoMZLAZ5cq5VYmUyq4+bzM6xIH1SXUwxujp1hHI67h
	b6o/ictI7hN+7PPD3o0La7CCUXAq4/gaLxhwkxpWo3iUULBCDHljzntKNNaIt44z
	IB7tYOVziLCgR2+oXtpq/5a0tT5IAQMUPPxKYy+bVDbbvngLQuokbvCqAr+JLUSm
	6A3lsR6/WKLzfHYLUYsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749404123; x=1749411323; bh=w
	h/MxpBJZ3+0ErayESGRZXiw/uDy6OAY57TTmqYgFes=; b=E/hURk7Ek7ZG1YOYp
	XOGb+ParWaSBzYwoENwrai9M/iUqh16vt7IL8oJ0fTlTMb+K4q/q00Zlh7zWXqRc
	hvT4US/ratmskkX6a4Qn78pEo1d7qyMDGstcONGbCstOHPYliGfE37dUl9CMTVif
	mh9rGQ6jJSb6bt3vbqE+rh3x39GCHHlze6z53+IPDXGEMfl7+fmix+X5DK9rwRzs
	1ZLpZhbmqm/w5DKK/5d6jx2v4Lo4NSwl+93P2ESZqpt6sn3/QA/u3XD6HRaH5b+u
	wmwAhJyY6wfEp6ifNUng6NMqxfNjbKCrWNt1XJtzzL8bPExeGNCGdIT8hXAdDMYY
	p1/gQ==
X-ME-Sender: <xms:2slFaJiALuZN4h5yMoQfq9rB_NixL987P2aL8lQKsEgY2gainnT1ig>
    <xme:2slFaOBsa219Hw3lKt3JgLK3tCNipunAzfQOraataPEKr4G2Ea7OAXB-gQkA3RfeH
    ljMVYuF2Aks06AYK8Y>
X-ME-Received: <xmr:2slFaJHzbrBEqdorF7C2ID5eC3pqrlGivbW5r4CavYUmPv3ukbXps6Zu6kb6PqWW6ZoymbFVBuRo-Ep70dRrsJsPOzi6PeQ4-2czqod-0kFJdaQI7hgvC7UfCobd_1Ja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueeljeef
    ueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvdefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehvihhrohesiigvnhhi
    vhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheprghm
    ihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2slFaORmoVpxBka7gamkFUSQf03ThYXcLTC1MVqr9fjgvIRP4NvVhg>
    <xmx:2slFaGxrnWckiQvJlxLcKVTH9SSC5M83DSrq3R5bfoPNMPga1Rxfcw>
    <xmx:2slFaE5hAL3oYD2Ex9lyL3xbyWq_vD9V_1kwBNhd_lG4UcO8E2DnTA>
    <xmx:2slFaLwTG5teBm-lbBp4lAyNgAeE0vILVYc4ct-iJg_qjQdjfOIV5w>
    <xmx:28lFaJKM3TiOZZAfLjua0Fcgi2HSyPXoAT2TTgFhZKD3dN_tHyGRvazF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 13:35:18 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Song Liu <song@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>,
	amir73il@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	gnoack@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kernel-team@meta.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	repnop@google.com
Subject: Re: [PATCH v3 bpf-next 0/5] bpf path iterator
Date: Sun,  8 Jun 2025 18:32:56 +0100
Message-ID: <20250608173437.73874-1-m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
References: <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>, <20250606213015.255134-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update bpf_fs_kfuncs to match path_walk_parent changes.

It compiles, but I've not tested this yet.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/bpf_fs_kfuncs.c | 55 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 8c618154df0a..6599342dd0de 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -327,23 +327,18 @@ __bpf_kfunc_end_defs();
 
 /* open-coded path iterator */
 struct bpf_iter_path {
-	__u64 __opaque[2];
-} __aligned(8);
-
-struct bpf_iter_path_kern {
-	struct path path;
+	__u64 __opaque[sizeof(struct parent_iterator) / sizeof(__u64)];
 } __aligned(8);
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
-				  struct path *start,
+__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it, struct path *start,
 				  __u64 flags)
 {
-	struct bpf_iter_path_kern *kit = (void *)it;
+	struct parent_iterator *pit = (void *)it;
 
-	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
-	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+	BUILD_BUG_ON(sizeof(*pit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*pit) != __alignof__(*it));
 
 	if (flags) {
 		/*
@@ -351,45 +346,51 @@ __bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
 		 * kit->path so that it be passed to path_put() safely.
 		 * Note: path_put() is no-op for zero'ed path.
 		 */
-		memset(&kit->path, 0, sizeof(struct path));
+		memset(pit, 0, sizeof(*pit));
 		return -EINVAL;
 	}
 
-	kit->path = *start;
-	path_get(&kit->path);
-
-	return 0;
-}
-
-__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
-{
-	struct bpf_iter_path_kern *kit = (void *)it;
-	struct path root = {};
-
 	/*
-	 * "root" is zero'ed. Therefore, unless the loop is explicitly
+	 * "root" is NULL. Therefore, unless the loop is explicitly
 	 * terminated, bpf_iter_path_next() will continue looping until
 	 * we've reached the global root of the VFS.
 	 *
 	 * If a root of walk is needed, the user can check "path" against
 	 * that root on each iteration.
 	 */
-	if (!path_walk_parent(&kit->path, &root)) {
+	path_walk_parent_start(pit, start, NULL, false);
+
+	return 0;
+}
+
+__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
+{
+	struct parent_iterator *pit = (void *)it;
+	struct path p;
+
+	switch (path_walk_parent(pit, &p)) {
+	case PATH_WALK_PARENT_UPDATED:
+		return &pit->path;
+	case PATH_WALK_PARENT_ALREADY_ROOT:
 		/*
 		 * Return NULL, but keep valid kit->path. _destroy() will
 		 * always path_put(&kit->path).
 		 */
 		return NULL;
+	default:
+		WARN_ONCE(
+			1,
+			"did not expect any other return from path_walk_parent");
 	}
 
-	return &kit->path;
+	return &pit->path;
 }
 
 __bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
 {
-	struct bpf_iter_path_kern *kit = (void *)it;
+	struct parent_iterator *pit = (void *)it;
 
-	path_put(&kit->path);
+	path_walk_parent_end(pit);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.49.0

