Return-Path: <linux-fsdevel+bounces-51367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D690BAD6218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F24717A202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D424DD05;
	Wed, 11 Jun 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1iWFD6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDD248F4C;
	Wed, 11 Jun 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679356; cv=none; b=qUE6ChdE6Z3eev7PtCBZvrEy3blzHoqqVR2ChL/rqmGv3quEHHJ0ZJO5dpV0wbNJ64TmPIkHKdmG+bUk55zDkKsoEnLfrZ8LCJAsjXHtaH/dCvl74sDeG2KbnBTuN+Z81jQRe1MFuOGLD9oDshoIyDG3MCUvTcZ4En6uRsHfCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679356; c=relaxed/simple;
	bh=jlqrddGkspQ/7KMHo/Q8pc7a80dvA5q3PcdnFIQGNwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euvsK4Xfe67DHD3qMlHH6ymGdEWkGvsoR4ANvkbmJIpkZLtO+1QT169dAWTbUG9UdetnN6fZPgVIoVxG02FbTfuiY5O52eAJ20eChIMozku69XgaN/KgVLqGiiixRZ0FAtww4Wu72ySoRL0EHHfOjLE42yGTri0wRqyOLYCQR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1iWFD6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD39C4CEEF;
	Wed, 11 Jun 2025 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749679356;
	bh=jlqrddGkspQ/7KMHo/Q8pc7a80dvA5q3PcdnFIQGNwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1iWFD6QV1u5zV9y/1ie6RG96+psPGnPn5mWQOveO/FaKkZygKZ5YD+yU05DLwgTb
	 XeuaHOaVFF0dvv64/LTyoPHD9WsgRfv3XVh0GyIRvCCcKiOvyVmQnu57mlM2IkSnM5
	 t8X2aHLKPJ+92wpe5Zr3jOdsqwBCDxOWEpnttOcaIgmFcbFJgeCC5Jrtef/RfBJrpR
	 fBMHGVQaYLWKrTJ1rqukTQF+m4Zvb1lieT4GGv1pm7KuDHhJ4YAZd5SSIQR3yEg/Ti
	 HEUaBV1rsamDH1uFJseyEGPe3eyuWb5tatYyPCAwhtCa3pPO1jLwH69dMXMMqU8Tzc
	 fBkmeF4B3yNZg==
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
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 2/5] landlock: Use path_walk_parent()
Date: Wed, 11 Jun 2025 15:02:17 -0700
Message-ID: <20250611220220.3681382-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611220220.3681382-1-song@kernel.org>
References: <20250611220220.3681382-1-song@kernel.org>
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
 security/landlock/fs.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..63232199ce23 100644
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
@@ -895,35 +895,23 @@ static bool is_access_to_paths_allowed(
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
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
+
+		if (unlikely(IS_ROOT(walker_path.dentry)) &&
+		    (walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
 			/*
 			 * Stops at disconnected root directories.  Only allows
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
 			allowed_parent1 = true;
 			allowed_parent2 = true;
-			}
 			break;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
+		if (!path_walk_parent(&walker_path, &root))
+			break;
 	}
+
+	if (walker_path.dentry)
 		path_put(&walker_path);
 
 	if (!allowed_parent1) {
-- 
2.47.1


