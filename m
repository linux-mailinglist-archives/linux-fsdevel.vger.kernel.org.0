Return-Path: <linux-fsdevel+bounces-22635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5091A8E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227931F23541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC88198A11;
	Thu, 27 Jun 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcYpQz2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC78198A0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497523; cv=none; b=UgofxidAn9qlNzs0BAqDgNWqXBWLqv/bWZ+BzcF7M3P6OCBUZu6ca5BYh0pMA3pcyHOOQVF8sNYkuIFHDPfeXxTyEWBspGfArFRqaohSjCyFnYpnkRy/JObxeZoWOhnsB3hltNTHF3bM4F4RwQH2V5/ho19114fZ3SEDRJADOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497523; c=relaxed/simple;
	bh=nSTWSTrDybQHR+lX2cMJgo58KHuSllMHwXZNln6F9VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSklLjsGRj6VR4bxv/dmie4HyhKTackFFV5uC2kYujGYhSwt6w3r686vCn9492GeC8uKVj8DSrgBbfljTAG9ESJ8dbfx/of7DlEc8mJVQvyUuGIlQkay2tNTLV6V6wfPL1CFrU0nW5vV3nhqKlMGyEsypTgTXFPFhXahNydYoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcYpQz2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872AEC32786;
	Thu, 27 Jun 2024 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497523;
	bh=nSTWSTrDybQHR+lX2cMJgo58KHuSllMHwXZNln6F9VI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BcYpQz2mg6KfF9vguIRUbb2ttbzsXifPH0X8FR142Ob9mAUO4f58MRQqbIerqpcm9
	 04SlQyv/6zdJB8p6je+rildwPULNBNu0Pf6ZuuYGYAjVetsLvH53Gpik+VPpqFKX+8
	 e78lGfYfFZhLTnlH+Clnlj/EhGldg3BYym/eG4kTZUuz1kpu8G7VghepBw6+s4ENhK
	 Q+d1c2+kOmsZGb3R6rwzlOP6pljFpety7AdbceruJVPdnWc30JiLoLW1JWFnFi3zRa
	 dgE9rHqd85rpHXN54CESpprzM0E4tjwItHhEXrp5AX68iPxCb78jsekeKsEQaFypMY
	 rjcBW3PQqYR9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 27 Jun 2024 16:11:41 +0200
Subject: [PATCH RFC 3/4] nsfs: add open_namespace()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-work-pidfs-v1-3-7e9ab6cc3bb1@kernel.org>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nSTWSTrDybQHR+lX2cMJgo58KHuSllMHwXZNln6F9VI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVFmvtiw2t2l1/rfPgngCtW26vPp9itTSdz7j0I/uyX
 qNsZ9HPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpmcDI8KZ45ZwvF+8IMXSK
 yOUXWKzj7rn7Yc/sC7la8WW3nh28wcjwP319iVP6sbzAauMvzceEOKYvfdt46PjL6PuZtzpjCs+
 eYwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and call it from open_related_ns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h |  1 +
 fs/nsfs.c     | 55 +++++++++++++++++++++++++++++++------------------------
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ab2225136f60..1ece6a3d34cb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -321,3 +321,4 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+int open_namespace(struct ns_common *ns);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index af352dadffe1..c35bc3ca466f 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -83,40 +83,47 @@ int ns_get_path(struct path *path, struct task_struct *task,
 	return ns_get_path_cb(path, ns_get_path_task, &args);
 }
 
-int open_related_ns(struct ns_common *ns,
-		   struct ns_common *(*get_ns)(struct ns_common *ns))
+/**
+ * open_namespace - open a namespace
+ * @ns: the namespace to open
+ *
+ * This will consume a reference to @ns indendent of success or failure.
+ *
+ * Return: A file descriptor on success or a negative error code on failure.
+ */
+int open_namespace(struct ns_common *ns)
 {
-	struct path path = {};
-	struct ns_common *relative;
+	struct path path __free(path_put) = {};
 	struct file *f;
 	int err;
-	int fd;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
+	/* call first to consume reference */
+	err = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
+	if (err < 0)
+		return err;
+
+	CLASS(get_unused_fd, fd)(O_CLOEXEC);
 	if (fd < 0)
 		return fd;
 
+	f = dentry_open(&path, O_RDONLY, current_cred());
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+
+	fd_install(fd, f);
+	return take_fd(fd);
+}
+
+int open_related_ns(struct ns_common *ns,
+		   struct ns_common *(*get_ns)(struct ns_common *ns))
+{
+	struct ns_common *relative;
+
 	relative = get_ns(ns);
-	if (IS_ERR(relative)) {
-		put_unused_fd(fd);
+	if (IS_ERR(relative))
 		return PTR_ERR(relative);
-	}
 
-	err = path_from_stashed(&relative->stashed, nsfs_mnt, relative, &path);
-	if (err < 0) {
-		put_unused_fd(fd);
-		return err;
-	}
-
-	f = dentry_open(&path, O_RDONLY, current_cred());
-	path_put(&path);
-	if (IS_ERR(f)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(f);
-	} else
-		fd_install(fd, f);
-
-	return fd;
+	return open_namespace(relative);
 }
 EXPORT_SYMBOL_GPL(open_related_ns);
 

-- 
2.43.0


