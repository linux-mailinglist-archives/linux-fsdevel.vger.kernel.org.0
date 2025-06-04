Return-Path: <linux-fsdevel+bounces-50548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97418ACD106
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB651899184
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6C81E;
	Wed,  4 Jun 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="WdXr+Ge3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NI+/ipCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549B846C;
	Wed,  4 Jun 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998077; cv=none; b=B0FHLJ1/rNgg6YYMACfpX4KXYgJe0LJ5HcaUX+wLHg92UxAKSRm8ueMnOWVbD8MgrBYsKC92P3A5kxdR6n+HgaInQV9kXSuDJst5hQwdQsnZRwt3sGxGvG43Xj6zJdttNudJ6v536M3wUy2P0dqwbV39VcK8rpN29Zl9Ziz5zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998077; c=relaxed/simple;
	bh=mXjOjMULU1769XXrLhpJlJxrNA5COsF4mbYDV+ploUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOQgmn7QE0qjUBRdo1/hACJ4Tt+4FQRUv+WFnkawoo8BfFq+xcmwfq1s8xp7fy5bP4sXnPVUaMJRsD3NpOh7kRhl/IKl/wVgFggMFsPONuLnn4f68DJjYalgZDIMwWTXsH5UPMQs8tZQlC/hX2VpJKXNEgsJu2vTQ61DyaXH1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=WdXr+Ge3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NI+/ipCK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B12391140171;
	Tue,  3 Jun 2025 20:47:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Jun 2025 20:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748998074; x=
	1749084474; bh=a/Ft0wFZ8OzoQWMUCGM874NCjOr6bcUfRrD820vild4=; b=W
	dXr+Ge3Bzuv21M5hBpaWt5jfTFeTbg68LDp4U2WWgc+ZRVrNuxvxPlkXKFsm0Vgz
	Yo7yRmRBbUfsFSJKGJHZlFUOnOAmAomqofIm/ZtjM3HPJaIFoGWZUo9rJQR5K4/a
	d7HqfVB8GmVO5mWjxG36mceSY+Vv9yXAswXhBmxeWQxDzjXbDzkKAX4JrB4vByw9
	dYBLqC9eZB2CybzNDsn3kDIN/uenrYjqtsTmV3tO6lQMr2C7wpTdOivUym/ApEaQ
	+blHbF4Al0EwO6Jug31qduOe0ShA6877axF+1wzl7emuNPcfW+WMkIOBJOyF2aRD
	8q2Q+xNJqy0M9pinn2o0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748998074; x=1749084474; bh=a
	/Ft0wFZ8OzoQWMUCGM874NCjOr6bcUfRrD820vild4=; b=NI+/ipCKgPZyIQ5t+
	qYAWHFN8mDz5/kXu+a0MFaHIgDk6pJ0cyH3hm8EuSPZlo8oujF/dPKzm3Bc7y8NI
	94ZYP8NiVRwY70ricq0jkWf/IKFB/7F5+yvjX+RCZhErn4TyEsrQPUMbWFPr8XE9
	Zow8Sg56rofV/ivEw9NmdW3UYihKQ739mtYmFLNgnaU6vk3E7+p3RKHPIL6SeHHf
	r4VwOKom9PPiDAVyF0Fv1MIkxL5Nn8rDr1Iuw9yInE+FqjvF9pR1srCz3AiYKeEN
	MR0IVQjkQsjgLb76dIuCj6tU4nP1j9F2ClTIUlWv/NDtKWZYAedH/D+ohuGZ6sOQ
	6hTGw==
X-ME-Sender: <xms:upc_aCCYwpLgk-IhuBZj6TC0SQTyLwHaJUNqliI4qYd8pUcUIedFgw>
    <xme:upc_aMih_Zaelrq9Ad0IcBjQfVaR1vr_ZNaCJyf3GBXsYMs3UloMpOTbeF2qMM1B9
    cL5YSx_VNG-jMGcEpk>
X-ME-Received: <xmr:upc_aFnqF7Xk3w3QDAj49sElOpkQtgnjAEhGbIgg0vm2SC95VECFymcpZrk7K7PPIVZqVl6wpNbH0QL8j9V5ZZhmdZIUpqa5EcaqNf1WRcO4uPdJLkbViw>
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
X-ME-Proxy: <xmx:upc_aAwqqhSrgD7zfcu1iAqLAxwUQmB5JSg5JqsBxh7-CpHZrpRsBA>
    <xmx:upc_aHRzjhUsH4F3TBM0rWt__REzMBmerSv7-4o7TT6MIrXiaO04eA>
    <xmx:upc_aLb8N7GaSzZG7dHTIlqdHjWQunzRhSMhFbNvx7mp5pF65DctUw>
    <xmx:upc_aASvRwCihYf0QbRLbtM7uk7znshsOCzJoXMa65AELS3K3F-2nA>
    <xmx:upc_aLdpExjLPph1JwQfa8FeM1I0P3oYMHn9xZDrvs4x_uy7-YdC7igP>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 20:47:52 -0400 (EDT)
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
Subject: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
Date: Wed,  4 Jun 2025 01:45:45 +0100
Message-ID: <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
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

This fixes the issue mentioned in the previous patch, by essentially
having two "modes" for the pathwalk code - in the pathwalk_ref == false
case we don't take references and just inspect `d_parent` (unless we have
to `follow_up`).  In the pathwalk_ref == true case, this is the same as
before.

When we detect any renames during a pathwalk_ref == false walk, we restart
with pathwalk_ref == true, re-initializing the layer masks.  I'm not sure
if this is completely correct in regards to is_dom_check - but seems to
work for now.  I can revisit this later.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c | 109 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 923737412cfa..6dff5fb6b181 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -771,6 +771,9 @@ static bool is_access_to_paths_allowed(
 		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
+	unsigned int rename_seqcount;
+	bool pathwalk_ref = false;
+	const struct landlock_rule *rule;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -811,6 +814,7 @@ static bool is_access_to_paths_allowed(
 
 	rcu_read_lock();
 
+restart_pathwalk:
 	if (unlikely(dentry_child1)) {
 		landlock_unmask_layers(
 			find_rule_rcu(domain, dentry_child1),
@@ -833,13 +837,32 @@ static bool is_access_to_paths_allowed(
 	}
 
 	walker_path = *path;
+
+	/*
+	 * Attempt to do a pathwalk without taking dentry references first,
+	 * but if any rename happens while we are doing this, give up and do a
+	 * walk with dget_parent instead.  See comments in
+	 * collect_domain_accesses().
+	 */
+
+	if (!pathwalk_ref) {
+		rename_seqcount = read_seqbegin(&rename_lock);
+		if (rename_seqcount % 2 == 1) {
+			pathwalk_ref = true;
+			path_get(&walker_path);
+		}
+	} else {
+		path_get(&walker_path);
+	}
+
+	rule = find_rule_rcu(domain, walker_path.dentry);
+
 	/*
 	 * We need to walk through all the hierarchy to not miss any relevant
 	 * restriction.
 	 */
 	while (true) {
 		struct dentry *parent_dentry;
-		const struct landlock_rule *rule;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -881,7 +904,6 @@ static bool is_access_to_paths_allowed(
 				break;
 		}
 
-		rule = find_rule_rcu(domain, walker_path.dentry);
 		allowed_parent1 = allowed_parent1 ||
 				  landlock_unmask_layers(
 					  rule, access_masked_parent1,
@@ -899,13 +921,16 @@ static bool is_access_to_paths_allowed(
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
 			/* follow_up gets the parent and puts the passed in path */
-			path_get(&walker_path);
+			if (!pathwalk_ref)
+				path_get(&walker_path);
 			if (follow_up(&walker_path)) {
-				path_put(&walker_path);
+				if (!pathwalk_ref)
+					path_put(&walker_path);
 				/* Ignores hidden mount points. */
 				goto jump_up;
 			} else {
-				path_put(&walker_path);
+				if (!pathwalk_ref)
+					path_put(&walker_path);
 				/*
 				 * Stops at the real root.  Denies access
 				 * because not all layers have granted access.
@@ -925,10 +950,27 @@ static bool is_access_to_paths_allowed(
 			}
 			break;
 		}
-		parent_dentry = walker_path.dentry->d_parent;
-		walker_path.dentry = parent_dentry;
+		if (!pathwalk_ref) {
+			parent_dentry = walker_path.dentry->d_parent;
+
+			rule = find_rule_rcu(domain, parent_dentry);
+			if (read_seqretry(&rename_lock, rename_seqcount)) {
+				pathwalk_ref = true;
+				goto restart_pathwalk;
+			} else {
+				walker_path.dentry = parent_dentry;
+			}
+		} else {
+			parent_dentry = dget_parent(walker_path.dentry);
+			dput(walker_path.dentry);
+			walker_path.dentry = parent_dentry;
+			rule = find_rule_rcu(domain, walker_path.dentry);
+		}
 	}
 
+	if (pathwalk_ref)
+		path_put(&walker_path);
+
 	rcu_read_unlock();
 
 	if (!allowed_parent1) {
@@ -1040,22 +1082,55 @@ static bool collect_domain_accesses(
 {
 	unsigned long access_dom;
 	bool ret = false;
+	bool pathwalk_ref = false;
+	unsigned int rename_seqcount;
+	const struct landlock_rule *rule;
+	struct dentry *parent_dentry;
 
 	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
 		return true;
 	if (is_nouser_or_private(dir))
 		return true;
 
+	rcu_read_lock();
+
+restart_pathwalk:
 	access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 					       layer_masks_dom,
 					       LANDLOCK_KEY_INODE);
 
-	rcu_read_lock();
+	/*
+	 * Attempt to do a pathwalk without taking dentry references first, but
+	 * if any rename happens while we are doing this, give up and do a walk
+	 * with dget_parent instead.  This prevents wrong denials in the
+	 * presence of a move followed by an immediate rmdir of the old parent,
+	 * where even when both the original and the new parent has allow
+	 * rules, we might still hit a negative dentry (the deleted old parent)
+	 * and being unable to find either rules.
+	 */
+
+	if (!pathwalk_ref) {
+		rename_seqcount = read_seqbegin(&rename_lock);
+		if (rename_seqcount % 2 == 1) {
+			pathwalk_ref = true;
+			dget(dir);
+		}
+	} else {
+		dget(dir);
+	}
+	rule = find_rule_rcu(domain, dir);
+	/*
+	 * We don't need to check rename_seqcount here because we haven't
+	 * followed any d_parent yet, and the d_inode of the path being
+	 * accessed can't change under us as we have ref on path.dentry.  But
+	 * once we start walking up the path, we need to check the seqcount to
+	 * make sure the rule we got isn't based on a wrong/changing/negative
+	 * dentry.
+	 */
 
 	while (true) {
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
-					   layer_masks_dom,
+		if (landlock_unmask_layers(rule, access_dom, layer_masks_dom,
 					   ARRAY_SIZE(*layer_masks_dom))) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1069,9 +1144,21 @@ static bool collect_domain_accesses(
 		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
 			break;
 
-		dir = dir->d_parent;
+		if (!pathwalk_ref) {
+			parent_dentry = dir->d_parent;
+			rule = find_rule_rcu(domain, dir);
+			if (read_seqretry(&rename_lock, rename_seqcount)) {
+				pathwalk_ref = true;
+				goto restart_pathwalk;
+			} else {
+				dir = parent_dentry;
+			}
+		}
 	}
 
+	if (pathwalk_ref)
+		dput(dir);
+
 	rcu_read_unlock();
 
 	return ret;
-- 
2.49.0


