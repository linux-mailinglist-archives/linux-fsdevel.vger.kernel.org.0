Return-Path: <linux-fsdevel+bounces-50011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE7AC740A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C3A50190E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E522D4DA;
	Wed, 28 May 2025 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8jl892J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C0221DAD;
	Wed, 28 May 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471198; cv=none; b=IpeCR9ssmO53CCZa4eb0zoCFILDTXwJIgZ6fJveH85JAAVo/+6LTW7XsOWpLjwA7XbBjkRzfY/CixA768HbHPaFimxgul8MasM8N5SE+Zby4dfL6nI/iSvi/QO+4DG3vpBB1PZ/pbDTVRtcVbHFEOiIe4bqjbBu1G1HFhIOlcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471198; c=relaxed/simple;
	bh=UgxT8rPg0mLYojJHE661GfEUhvEvpGi4Nx30b+sBsL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px78XXWdx943btE68j3CVhR8PPggxHbhFyhDkNb/xPksKS5MKIhj29I7ATXmIJer8gYnYi9+vmFN9zLnAgRypExMETOn4yy82cjByYQ1WkbxYs4zjXMEMAQfjCT+82Qk4/bbv9M0Tv13bNocud6oL7vzjMfHxoZ0H7IxCyqrdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8jl892J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E1C4CEE3;
	Wed, 28 May 2025 22:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471197;
	bh=UgxT8rPg0mLYojJHE661GfEUhvEvpGi4Nx30b+sBsL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8jl892JRxrP60c9PeJr4So/bgxSySclLbZBwH+NHxZ0jjV/9yaBI4MPE9S2pVlk6
	 37+RPSBYUI6kf+haaP5AiFZE22jAEt6mjzuDroTx23xcdTogb597nXdlWZR8CweDan
	 dG5NLrpdopz2EZrP6myi1vGzjWLkDf2W7D8WrFx3e4KKpdsR0JgV4t/Ewir5Jbb9RV
	 YPohDSBY5/sAYT200HWPvvMAOKHyXEexmJBqQNpgfT5KnqH5yhoj7TLloQ2KK+rLeW
	 +pywV8wrJ2E+L3hXe040OAcuvg8nB0iQusj7/UjKHn+M6RSs4LXex9GWWRQCH61Thi
	 iquEO9e6D40Tg==
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
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/4] landlock: Use path_parent()
Date: Wed, 28 May 2025 15:26:21 -0700
Message-ID: <20250528222623.1373000-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250528222623.1373000-1-song@kernel.org>
References: <20250528222623.1373000-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use path_parent() to walk a path up to its parent.

While path_parent() has an extra check with path_connected() than existing
code, there is no functional changes intended for landlock.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..32a24758ad6e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -837,7 +837,6 @@ static bool is_access_to_paths_allowed(
 	 * restriction.
 	 */
 	while (true) {
-		struct dentry *parent_dentry;
 		const struct landlock_rule *rule;
 
 		/*
@@ -896,19 +895,17 @@ static bool is_access_to_paths_allowed(
 		if (allowed_parent1 && allowed_parent2)
 			break;
 jump_up:
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
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
+		switch (path_parent(&walker_path)) {
+		case PATH_PARENT_CHANGED_MOUNT:
+			/* Ignores hidden mount points. */
+			goto jump_up;
+		case PATH_PARENT_REAL_ROOT:
+			/*
+			 * Stops at the real root.  Denies access
+			 * because not all layers have granted access.
+			 */
+			goto walk_done;
+		case PATH_PARENT_DISCONNECTED_ROOT:
 			/*
 			 * Stops at disconnected root directories.  Only allows
 			 * access to internal filesystems (e.g. nsfs, which is
@@ -918,12 +915,15 @@ static bool is_access_to_paths_allowed(
 				allowed_parent1 = true;
 				allowed_parent2 = true;
 			}
+			goto walk_done;
+		case PATH_PARENT_SAME_MOUNT:
 			break;
+		default:
+			WARN_ON_ONCE(1);
+			goto walk_done;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
+walk_done:
 	path_put(&walker_path);
 
 	if (!allowed_parent1) {
-- 
2.47.1


