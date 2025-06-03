Return-Path: <linux-fsdevel+bounces-50425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4AEACC0A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A117A374E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDB269B01;
	Tue,  3 Jun 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfJjUnqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C52686A0;
	Tue,  3 Jun 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933984; cv=none; b=VhaQT/aI9CVAa8CDqb17KGt9EKIAnk+5ea//njmabTWFngpE4mZFSUB0vA7wI0FHxdqZlLRsD3CdYSkxoQJPC1NkE07UdNR16SPCD8KB9WVHK0hlxp3gVkySzGbSmV6UPXcZAnuNPFYRCyXezW/oyOIKmJ0XGCvPkhh49JJFQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933984; c=relaxed/simple;
	bh=r6SeHhJh7cN3udLApUOE4uIsJst1l3j9wVKO2KszBrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMRrtxSF7laILyDJ6mgW9yxN53EEThKKYJ8TU0fl9w0iGZXbfOvkuW2Q35GPaVrc9sUbUozS/XjY9oAL3aNqNnUikrebpsyFfZeaerm0yVaFKCfzmtFXqgzCa45NRnQgxPJq3ob9srwC5UgMefbnpD8fGAnnxCKKpi9cuRXKz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfJjUnqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABA2C4CEED;
	Tue,  3 Jun 2025 06:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748933983;
	bh=r6SeHhJh7cN3udLApUOE4uIsJst1l3j9wVKO2KszBrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfJjUnqtzvnXZNj6xU4dK/JeePuGv88lHEiSmLnzkXsjklSsXGBQIRYIK6iUnmVEC
	 vYH4UeFJKrCGA9QGTLQWvPjj+g38KZZ4mFOpHptHmSBPLQPo6wer+fQY/nsMHONWys
	 nqLs/5bynRKzdhLwPMu9DU2k1wHz/cTNPJo5jlqWO382XCU/fZHps87wuhS6I5geK0
	 +fj7oApf4+3f4b3QAH+9FqV5Ez1kEa3CayFw7J4SPRmjUKI85DKL9953bB51dT+wvm
	 5hCfaKz5gqu/O/+idTKTdqS0vjOxegZtd81fuYp69FURez7qwskFxvy2FezoaIVmMU
	 TNc63pm/Y+exQ==
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
Subject: [PATCH v2 bpf-next 2/4] landlock: Use path_walk_parent()
Date: Mon,  2 Jun 2025 23:59:18 -0700
Message-ID: <20250603065920.3404510-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250603065920.3404510-1-song@kernel.org>
References: <20250603065920.3404510-1-song@kernel.org>
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


