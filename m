Return-Path: <linux-fsdevel+bounces-50869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A645AD0976
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A935B3B49D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524723AE83;
	Fri,  6 Jun 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwCBZRmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D381A76BC;
	Fri,  6 Jun 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245430; cv=none; b=phOIM4sgvFYClzqYOk1ogOpeDmp08Gj9S4QSdXOnzMMsjSRXLpcmEgbdX3GRleSUoagm4W4HJspsjy2lBJ2G3sOTgaW8Re9LzlBlhAY439q8LSGp6DRLFb3UJQbPipo5cXC2XOY+BkCucxYIh2eD3yzpbyhZY6zZKg+qjCkQGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245430; c=relaxed/simple;
	bh=/615fZRRWGLCiRUGOTiVn04Y0AU0vnVl6B2PImYgEn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYGey/1h6QqHX1qjs3QI9mNm8nRbksKvBR7AbQrXkGwEUj+KjWRFs8NuEApy2cIK6zqk4/o7eTtSVExdSqSIxeV6sTKKMZFZ0MfZKUihUJNuiP90Za2bYnLvlAGWUOnzLYfXaL2AOJ2MZknCGfi4oxZAzkScsNW7Ubr5oghgZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwCBZRmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052ABC4CEEB;
	Fri,  6 Jun 2025 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749245429;
	bh=/615fZRRWGLCiRUGOTiVn04Y0AU0vnVl6B2PImYgEn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwCBZRmN3UWQL2YwbltywLQmOZF1AC99bHKIYtoHcOzZkdimuTxuRK7SOoqXjHc8E
	 V84kNq4s4U7u5bePuvWUCjWzIbx3yBk9+qGYy2UKsuVN4EErzONuP7RPwPVxtJxyOf
	 pZzmbdV8Y3fFE5iC7r4HOQc9CPgY1KYeQiSr5O7LilyEby6Ldpd3PkcgmX0Ird5DzL
	 kZg6snEY3yXSUf8dZrkPyAyi2aGOY01dMzfYXz/DCOr4Asc2GqqrCPwc0oZUYtyVAW
	 DSAUeTy9UPBNi6BQl7uuUjDDYW1fbkbb8wPcu4e6gubUJOp73Rnq13u9xU/UokBHQS
	 ROKkktd/SxdOw==
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
Subject: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
Date: Fri,  6 Jun 2025 14:30:11 -0700
Message-ID: <20250606213015.255134-2-song@kernel.org>
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

This helper walks an input path to its parent. Logic are added to handle
walking across mount tree.

This will be used by landlock, and BPF LSM.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namei.c            | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..f02183e9c073 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1424,6 +1424,57 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 	return found;
 }
 
+/**
+ * path_walk_parent - Walk to the parent of path
+ * @path: input and output path.
+ * @root: root of the path walk, do not go beyond this root. If @root is
+ *        zero'ed, walk all the way to real root.
+ *
+ * Given a path, find the parent path. Replace @path with the parent path.
+ * If we were already at the real root or a disconnected root, @path is
+ * not changed.
+ *
+ * The logic of path_walk_parent() is similar to follow_dotdot(), except
+ * that path_walk_parent() will continue walking for !path_connected case.
+ * This effectively means we are walking from disconnected bind mount to
+ * the original mount. If this behavior is not desired, the caller can add
+ * a check like:
+ *
+ *   if (path_walk_parent(&path) && !path_connected(path.mnt, path.dentry)
+ *           // continue walking
+ *   else
+ *           // stop walking
+ *
+ * Returns:
+ *  true  - if @path is updated to its parent.
+ *  false - if @path is already the root (real root or @root).
+ */
+bool path_walk_parent(struct path *path, const struct path *root)
+{
+	struct dentry *parent;
+
+	if (path_equal(path, root))
+		return false;
+
+	if (unlikely(path->dentry == path->mnt->mnt_root)) {
+		struct path p;
+
+		if (!choose_mountpoint(real_mount(path->mnt), root, &p))
+			return false;
+		path_put(path);
+		*path = p;
+	}
+
+	if (unlikely(IS_ROOT(path->dentry)))
+		return false;
+
+	parent = dget_parent(path->dentry);
+	dput(path->dentry);
+	path->dentry = parent;
+	return true;
+}
+EXPORT_SYMBOL_GPL(path_walk_parent);
+
 /*
  * Perform an automount
  * - return -EISDIR to tell follow_managed() to stop and return the path we
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..cba5373ecf86 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+bool path_walk_parent(struct path *path, const struct path *root);
+
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
-- 
2.47.1


