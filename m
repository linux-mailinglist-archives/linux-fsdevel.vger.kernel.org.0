Return-Path: <linux-fsdevel+bounces-50424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90FACC09D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1206170728
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633BD269818;
	Tue,  3 Jun 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoErlSRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F78268C73;
	Tue,  3 Jun 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933977; cv=none; b=pRShydMYftUj7f32QNlbhQDVQR0NOKdIUj1Ymazx8sjN90SDIOQnd9wD9gFAaubd6cpwSi2jg1mh2GB07tYPGiD0dlQxQ40LFOFVJBJjdutDf6l9Unln2Tf29MuEee/Rxg4ZmOlfbRudXEqzB4KkekuSVKuob2X/86lxuHOiCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933977; c=relaxed/simple;
	bh=gYgctafhNOcX+plQIUV39B4VlTOC095ErEoqwaKakQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuRSeY7d/PVdxf7vy/+48FZ0QaEaGGxOq964aInR9/q9NGlquXrlA+RuoHzcEA+wFFMA/vrT9RQDO5+oPouzi/PIVC8ii/ZeJR9sTiT5zvivMcYfpR846YhuQaGOeVNqO2dYiNf0yBp4D4F1fjtce8lzi6QYrqP03J2p69SsM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoErlSRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BEEC4CEF2;
	Tue,  3 Jun 2025 06:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748933977;
	bh=gYgctafhNOcX+plQIUV39B4VlTOC095ErEoqwaKakQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoErlSRxr0rJlfDIkSQeQaOff/ryeJFuZx4Q4Ll5o9A/cdjQziu2/ymAED7UnNMzb
	 N1tK78e8XfaC1UsGdw5YwW86mytUzlbrbxWhs1mbYW59VmVdux93O8ODM2qGhhwANX
	 k5BPw87TUaQ2kLYyMZok9r91siWHaKIL/9ULti43dYXZeVhzDy4w1gdIUylqRQeSWc
	 waUPiHPu4SM5fRGvqW62GxoDRsXINVjGpBx7l//+YmXzT0nvQiCjsDtzlgH4hNwewT
	 2hY4IxTq9THows0CHfDAdm8GaIm0DD4HxwF5TrqfcS7MgJT2CIIQ0YRiLcytwZwNfG
	 r/YSYezO0DQ0A==
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
Subject: [PATCH v2 bpf-next 1/4] namei: Introduce new helper function path_walk_parent()
Date: Mon,  2 Jun 2025 23:59:17 -0700
Message-ID: <20250603065920.3404510-2-song@kernel.org>
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

This helper walks an input path to its parent. Logic are added to handle
walking across mount tree.

This will be used by landlock, and BPF LSM.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namei.c            | 52 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..7d5bf2bb604f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1424,6 +1424,58 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
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
+ * This effectively means we are walking from disconnectedbind mount to the
+ * original mount point. If this behavior is not desired, the caller can
+ * add a check like:
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
+		return true;
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


