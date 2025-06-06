Return-Path: <linux-fsdevel+bounces-50870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B636AD097A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D285C17B567
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854B723C8D6;
	Fri,  6 Jun 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT3xtTsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534021B9E4;
	Fri,  6 Jun 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245436; cv=none; b=OXVO9SckI4d/pQmOYsKq4MjAiqq2aJcRPJMk90Xlp9QBmLMBWt3akJFYH6Z0mp9zeviojrG0dPitMaEpcxvyTN0wcwCkxjDMBCXJ0QGDVU3FDd6HZ3AUhCvK2atpMpmJs2ulet0GJgyvWw3BTf6Xkz08cg4Rl8Sm1XJst8EufSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245436; c=relaxed/simple;
	bh=r6SeHhJh7cN3udLApUOE4uIsJst1l3j9wVKO2KszBrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4vOw52m1DY84GgQUN/8RxCWJVCq0z8biflXVZFy8sZHCNnLfdOsKpJTWJoe3H0nnsRel+Pdy5CkOigCpRnzBmPYvwfGze6V88nbiJ78/8u6m+4+zb3W+S1GUJATIjPwtZdmByCmEgREnriWWoZkQFqwaU4lbbRSPt8I9cDvZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT3xtTsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70A4C4CEEB;
	Fri,  6 Jun 2025 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749245435;
	bh=r6SeHhJh7cN3udLApUOE4uIsJst1l3j9wVKO2KszBrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NT3xtTsuEDnByf8wiTbYH9aJ1CMbbeibHuFjtuc+QGeyLHUNx1htAiy9AZ1mWdfzn
	 PhqJ4kx/TrZ9ufpcJ9qAyzsEKoVVDac+QfW9C0ROzqdaDSQBgk0uG4sJBPqKZq1MG5
	 fiAhp1Ev2JLMdFet8yjesKmr3kvUpBOumn0oi5MJygVHmlKz5/JWjTpjJM0O+L6QmN
	 vdocnkD0nJFlYI7JhWFxmYTWF6mUv8QkZJ/24xjEzT6KckJDTJYtiM34q5XHo6a67W
	 hhFLVnYPBjsPsS6T1K8DWCXdwWrAt74xMBVBKb+U1R1fmNZX0cnEsH8v6ol57p1A8Q
	 QUDa+FdX+L8Nw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	m@maowtm.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 2/5] landlock: Use path_walk_parent()
Date: Fri,  6 Jun 2025 14:30:12 -0700
Message-ID: <20250606213015.255134-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606213015.255134-1-song@kernel.org>
References: <20250606213015.255134-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use path_walk_parent() to walk a path up to its parent.

No functional changes intended.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..3adac544dc9e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -837,8 +837,8 @@ static bool is_access_to_paths_allowed(
 	 * restriction.
 	 */
 	while (true) {
-		struct dentry *parent_dentry;
 		const struct landlock_rule *rule;
+		struct path root = {};
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -895,34 +895,23 @@ static bool is_access_to_paths_allowed(
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
+
+		if (path_walk_parent(&walker_path, &root))
+			continue;
+
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
 			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
+			 * Stops at disconnected or real root directories.
+			 * Only allows access to internal filesystems
+			 * (e.g. nsfs, which is reachable through
+			 * /proc/<pid>/ns/<namespace>).
 			 */
 			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
 				allowed_parent1 = true;
 				allowed_parent2 = true;
 			}
-			break;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
+		break;
 	}
 	path_put(&walker_path);
 
-- 
2.47.1


