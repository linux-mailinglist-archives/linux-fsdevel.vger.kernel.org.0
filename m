Return-Path: <linux-fsdevel+bounces-50546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B91ACD109
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F64D3A60B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397981BC5C;
	Wed,  4 Jun 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="UIN0kxg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7B4qHI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C19C2FA;
	Wed,  4 Jun 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998062; cv=none; b=hI95uEmbdaeowwhGtcivjqlqjtIrLlHacl/XpHP9NLdbqHHE6YUTUTeXU+X//aUniQwvkjsNmC0C9HFBAZJwJ3Z9g6CD5G7hObjdppf0AS0j9SjpU70BmZfcQdLjxvq1n/Ho/FMPsrJXqX3cRv/SdpfLs+c6JkVAfUpirf4a7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998062; c=relaxed/simple;
	bh=6E7u5Rlaxz9c+KYQjbz53Ta0aqiQKt4apCLYm6emwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeLWqkWOjV8WMaTg6KygOGxx808M/YeHv2gkh8GXEuoDdVj3HV/1MuwtNCXeKjYP/AnMq1xlxkS90P/9AudEVid0G7Dl3GgNQOjAgKS25jZrxJxWILv1HlLif6WaafyU9Sn4grfq9u3HJ5ue5gtoDPTKzBv9ersYYtcM1JDvr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=UIN0kxg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7B4qHI2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A063114016A;
	Tue,  3 Jun 2025 20:47:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 03 Jun 2025 20:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748998058; x=
	1749084458; bh=qErm6ZZryerlZvBrjkz7xosuN0pIpwdtfW1uQGxJQtE=; b=U
	IN0kxg+vd6rMEOACEVjsKC0tg/F/2m2uX0iugwxZcBpUaAUpr2jTq0sNDJgQF9lD
	AB5/x/r6yYRm4UWctLNxZzMR8bFpr+azW6P+6ex7EfH9qU/DGAZs2u07VU9in4ql
	WEZ9/r20PoUjMt1Ml+K5OtDqkmN5r4VH4YvBAWAm/sST4ClEBUHGr2qVEP367/gr
	T6OV/ydUSD3/Y9unawOyczODOgxdWAHoKEZJ79+zzZNKx4td22SOgaekl1DJTRNT
	3w/hFVX5rTCZ6YUf5tJs1hnywaNqzQ10hVjl1oOKWAvRhSjfniNRh4y/a6IRjT17
	efQuDPF1CPYJKOXpqoisA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748998058; x=1749084458; bh=q
	Erm6ZZryerlZvBrjkz7xosuN0pIpwdtfW1uQGxJQtE=; b=F7B4qHI26aIaxjKC6
	TjjjnngyfJqTQVE7/Nb+JxpzhgigxTLh1p5Cuy2ZUWLNE7Jxo1a62kfTFoQd6RKj
	maKsHuydQjA+ab+nk+fNNWxv0IuIneqGxEJXCopH19fll0oe6ahOQgqCWN8w4R9L
	PUVKUaas76d1OrX6rr3uI9/pqnvFiAckpzMzUgUUuwdiLLcYCz0XwBxzX4WQQwuI
	NgpL+wgQVVQVH0nJetTuua+yPg1qmz7cqDo8yOzWgP9XCamvaH8nY5AtdnbWNWWF
	MvuZ/7+/do0oymu3cy48cQkkbYjy1LLEUImMZgaxJ4voFJKn4HIq9lm+e4fSTPK2
	klWIg==
X-ME-Sender: <xms:qpc_aMj2mtQFa9nYO2e2zVnFpQqWCjRpj1O1HIHEIVGwgwSOs_FSFw>
    <xme:qpc_aFDfCPiyrrZpJl3Ob-y7pV46BpGY5FsYMFwzkH1l5XWBz_Gi_-2n23qUIBOVt
    _-HTnRlPca4EvtuzmY>
X-ME-Received: <xmr:qpc_aEFNicmgfvH59D4s-JU9qSyS1u22W1nG2MMIg61Yrd_4XGbnvxXdbzWRMSBBAMTxi7VfoanjTYNE9H5YpATwRbMZ0o3BFEw2hY4-9b_jOx4Bccf3VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueeljeef
    ueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpth
    htohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhi
    vhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggt
    khesshhushgvrdgtiidprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qpc_aNS2rQXtz-Nvr5VsF7ixWVEjQGfuZC31YEhIkavocHFwDPffww>
    <xmx:qpc_aJwU7Rzvx6DC0R2kdfJLTz76Sr4n_19ow2i38Ca6zKFC0nvxOg>
    <xmx:qpc_aL6KLBr_2aYtnwoPU0ZRwLl4PDpBiA64gfhlZtW2R29Dj0U6SQ>
    <xmx:qpc_aGxYY0eqBBFNbh8_ckcdIm-IBWKOpGo_voYtlpXOjbArY17oCg>
    <xmx:qpc_aJ-Ri8hxXe2FxAZCSA-4fKQAmF9Y2_uZT6qbS8owcjqC_broCC7s>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 20:47:37 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/3] landlock: walk parent dir without taking references
Date: Wed,  4 Jun 2025 01:45:43 +0100
Message-ID: <8cf726883f6dae564559e4aacdb2c09bf532fcc5.1748997840.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748997840.git.m@maowtm.org>
References: <cover.1748997840.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces dget_parent with a direct read of d_parent. By
holding rcu read lock we should be safe in terms of not reading freed
memory, but this is still problematic due to move+unlink, as will be shown
with the test in the next commit.

Note that follow_up is still used when walking up a mountpoint.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..923737412cfa 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -361,7 +361,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
  * Returns NULL if no rule is found or if @dentry is negative.
  */
 static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
+find_rule_rcu(const struct landlock_ruleset *const domain,
 	  const struct dentry *const dentry)
 {
 	const struct landlock_rule *rule;
@@ -375,10 +375,10 @@ find_rule(const struct landlock_ruleset *const domain,
 		return NULL;
 
 	inode = d_backing_inode(dentry);
-	rcu_read_lock();
+	if (unlikely(!inode))
+		return NULL;
 	id.key.object = rcu_dereference(landlock_inode(inode)->object);
 	rule = landlock_find_rule(domain, id);
-	rcu_read_unlock();
 	return rule;
 }
 
@@ -809,9 +809,11 @@ static bool is_access_to_paths_allowed(
 		is_dom_check = false;
 	}
 
+	rcu_read_lock();
+
 	if (unlikely(dentry_child1)) {
 		landlock_unmask_layers(
-			find_rule(domain, dentry_child1),
+			find_rule_rcu(domain, dentry_child1),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child1, LANDLOCK_KEY_INODE),
@@ -821,7 +823,7 @@ static bool is_access_to_paths_allowed(
 	}
 	if (unlikely(dentry_child2)) {
 		landlock_unmask_layers(
-			find_rule(domain, dentry_child2),
+			find_rule_rcu(domain, dentry_child2),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child2, LANDLOCK_KEY_INODE),
@@ -831,7 +833,6 @@ static bool is_access_to_paths_allowed(
 	}
 
 	walker_path = *path;
-	path_get(&walker_path);
 	/*
 	 * We need to walk through all the hierarchy to not miss any relevant
 	 * restriction.
@@ -880,7 +881,7 @@ static bool is_access_to_paths_allowed(
 				break;
 		}
 
-		rule = find_rule(domain, walker_path.dentry);
+		rule = find_rule_rcu(domain, walker_path.dentry);
 		allowed_parent1 = allowed_parent1 ||
 				  landlock_unmask_layers(
 					  rule, access_masked_parent1,
@@ -897,10 +898,14 @@ static bool is_access_to_paths_allowed(
 			break;
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
+			/* follow_up gets the parent and puts the passed in path */
+			path_get(&walker_path);
 			if (follow_up(&walker_path)) {
+				path_put(&walker_path);
 				/* Ignores hidden mount points. */
 				goto jump_up;
 			} else {
+				path_put(&walker_path);
 				/*
 				 * Stops at the real root.  Denies access
 				 * because not all layers have granted access.
@@ -920,11 +925,11 @@ static bool is_access_to_paths_allowed(
 			}
 			break;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
+		parent_dentry = walker_path.dentry->d_parent;
 		walker_path.dentry = parent_dentry;
 	}
-	path_put(&walker_path);
+
+	rcu_read_unlock();
 
 	if (!allowed_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
@@ -1045,12 +1050,11 @@ static bool collect_domain_accesses(
 					       layer_masks_dom,
 					       LANDLOCK_KEY_INODE);
 
-	dget(dir);
-	while (true) {
-		struct dentry *parent_dentry;
+	rcu_read_lock();
 
+	while (true) {
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
+		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
 					   layer_masks_dom,
 					   ARRAY_SIZE(*layer_masks_dom))) {
 			/*
@@ -1065,11 +1069,11 @@ static bool collect_domain_accesses(
 		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
 			break;
 
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
+		dir = dir->d_parent;
 	}
-	dput(dir);
+
+	rcu_read_unlock();
+
 	return ret;
 }
 
-- 
2.49.0


