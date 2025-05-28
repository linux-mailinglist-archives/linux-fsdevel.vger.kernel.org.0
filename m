Return-Path: <linux-fsdevel+bounces-50010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E35AC7406
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8681D50169E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51822B8BC;
	Wed, 28 May 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6JBTGgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D422A4EC;
	Wed, 28 May 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471192; cv=none; b=MCUkqu+6ndYGGEVfs1QnaGiz44n5zLVsQwZTilK1wWiQTQtfDoSHgePK/s75Q5hPaPlBKvmoFI+OxOSgIPst2XAXxQID30FBzryIjjjtMJmdYXgdPAtZAiphH4xCBjsMGM8BAiR+T83rhQqgZNPsqlAxV3iaAHwwkCmFRLw4aEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471192; c=relaxed/simple;
	bh=k5v9m831CLJ3N4Z7unFVudD+pbqb+Zm4eoJLzJx1inY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9anvkTsSquQ98qJYIt4edo798I3vUsHGNtze+dWCS3YfMY5/ikd5RtgqlKD/GEILWA4hBxuFdpQ9aBGmHgKl8et3wjqR1t3MnuFgh/nTLzQ8ubHUL/v5e17EPcORjdrvv5S2px6Wt2c8m5e90yS9VT1Syp6jBf0Eo9oUeIOJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6JBTGgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD5C4CEEE;
	Wed, 28 May 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471192;
	bh=k5v9m831CLJ3N4Z7unFVudD+pbqb+Zm4eoJLzJx1inY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6JBTGgOvKCWNyRKmjaz5DnBcuHTqofNvQQyAWKG3Xr6B3tPxyC7npaiaKkBOjGtp
	 8eCQyYJIh/isx0KGLdg9/chMaYT7nA/Zub67igCkebTvxzySJxrmJw2nJ1oa1dd2uz
	 GmT4jkieBiW1oCI3ZHl+qXmdBHZbuleEI2Ihwi98xNCUqXkblibqVdtcpd13bVj3vT
	 QSUK9UPAkcDOIY2bw6lC46dC9GiazrL4qlsqpwILqS4rDn3KOiNCoMPg1hf1jQp7Dv
	 h2MfOXYebKH4LZjdy8Po5YmwRzsVCofgYjYz8aw2dZGtqY1SFYcyrt67fgSA7k8j+r
	 1Nsstkz7uquWQ==
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
Subject: [PATCH bpf-next 1/4] namei: Introduce new helper function path_parent()
Date: Wed, 28 May 2025 15:26:20 -0700
Message-ID: <20250528222623.1373000-2-song@kernel.org>
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

This helper walks an input path to its parent. Logic are added to handle
walking across mount tree.

This will be used by landlock, and BPF LSM.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..475f4188a0e6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1379,6 +1379,45 @@ int follow_up(struct path *path)
 }
 EXPORT_SYMBOL(follow_up);
 
+/**
+ * path_parent - Find the parent of path
+ * @path: input and output path.
+ *
+ * Given a path, find the parent path. Replace @path with the parent path.
+ * If we were already at the real root or a disconnected root, @path is
+ * not changed.
+ *
+ * Returns:
+ *   PATH_PARENT_SAME_MOUNT         - if we walked up within the same mount;
+ *   PATH_PARENT_CHANGED_MOUNT      - if we walked up a mount point;
+ *   PATH_PARENT_REAL_ROOT          - if we were already at real root;
+ *   PATH_PARENT_DISCONNECTED_ROOT  - if we were at the root of a disconnected
+ *                                    filesystem.
+ */
+enum path_parent_status path_parent(struct path *path)
+{
+	struct dentry *parent;
+
+	if (path->dentry == path->mnt->mnt_root) {
+		if (!follow_up(path))
+			return PATH_PARENT_REAL_ROOT;
+		return PATH_PARENT_CHANGED_MOUNT;
+	}
+	if (unlikely(IS_ROOT(path->dentry)))
+		return PATH_PARENT_DISCONNECTED_ROOT;
+
+	parent = dget_parent(path->dentry);
+	if (unlikely(!path_connected(path->mnt, parent))) {
+		dput(parent);
+		return PATH_PARENT_DISCONNECTED_ROOT;
+	}
+
+	dput(path->dentry);
+	path->dentry = parent;
+	return PATH_PARENT_SAME_MOUNT;
+}
+EXPORT_SYMBOL_GPL(path_parent);
+
 static bool choose_mountpoint_rcu(struct mount *m, const struct path *root,
 				  struct path *path, unsigned *seqp)
 {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index bbaf55fb3101..dc6e9096eb15 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -86,6 +86,14 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+enum path_parent_status {
+	PATH_PARENT_SAME_MOUNT = 0,
+	PATH_PARENT_CHANGED_MOUNT,
+	PATH_PARENT_REAL_ROOT,
+	PATH_PARENT_DISCONNECTED_ROOT,
+};
+enum path_parent_status path_parent(struct path *path);
+
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
-- 
2.47.1


