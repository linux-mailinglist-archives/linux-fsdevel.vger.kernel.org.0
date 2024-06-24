Return-Path: <linux-fsdevel+bounces-22251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65569152E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6762820BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843A19D8B4;
	Mon, 24 Jun 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lSxD/iBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90119D8A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244247; cv=none; b=DYif1p8FrdK7qbGHsUyYVMtCb9HGu7K2LBc5IuY9BFM/U4TnPeqYgUJgxfCP9qURGhR2SbX2lPwa8UnLXAUrlyQlAfr6OqpIXshgr/NB+LauH2/MlgIhH6UPMM2qhVO0SODir7/l9rVUnkuReosGFUBgBC+Ls8PuzWDAWqPPqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244247; c=relaxed/simple;
	bh=38LHEfgALOYC66sa1e+K/n/lc4uBFNnqfHrvdHUL1oU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkjjJxGgn6sAPvBPPMgatKX3OITrl482mD37H2tRH9uuYQsMB65aNhOXbx1pLF6hRfu1bIrFmPmg5e42+ZcjTCcz7vpFgebOoX3rOTVIByzPuYS8NJS25sG8T6sxuZiO7/R9h+6amqjo65Pk1Tic07L5RfFuw/EZ/7tk1pqlhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lSxD/iBK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797dcb558ebso279233785a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244245; x=1719849045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SByAZNLq5sTtspyyUJQCXuY/e1cubv1bllAaHfOCEUA=;
        b=lSxD/iBKe+NmS+9vps4LiDo0GFFxDJ8d0mv4CWV/RWglVoEDujC+pBKKhtvGdpVG64
         v1rhAzsPA7iRv9EinqSY9+Sd9nV+kal8e00OLfbWAxrL0po1oQ4mYTS6KmG1pamnGE9S
         nshuY6hMuVrka1jGw1JTHdXgHsG5BvhnSCV9DOBEWOLk1vTUsjGGUXkJ/kFAAdtOzTnh
         MD0Ap/I1dATd83uwI7sygHEUt+trHYQ2VtQAFotlaLjTXfDZvz974fNQF13ZrJycnXaZ
         DPwbwmPh+XGt9ykMH6kVGDHrkuG9KanDTocSnV1vCcLCDlOzkl4NOsgJ5mqJoUWtdSsa
         1PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244245; x=1719849045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SByAZNLq5sTtspyyUJQCXuY/e1cubv1bllAaHfOCEUA=;
        b=kx+g3D3JZ6VZFkhXz/VYs/amnGhAtLP6kIpFZuRzfzn/IIjFbvC2n2FDCpS4y38Dmz
         d/SP6gzmMEjzdryVhibV2pTmA4u1PxnVGe7Za/sAZuyYoWlz1lWyFWkODYz/bObi/gkf
         WYix9RNGuTtt9RTNq1QMWS48A0meLm2vEMuMLYJP0kOkW61ISL3JShqP6c4d95waLW4N
         K/o4A57ie0s6sItJm39Lj8/qS7CwDWALgCGBq09GXQLE0XIn3LGlTTAcpKzl/LDa0A4v
         yrqxzDC6nViPu00x0urT/vqA7jFg4L46PGyrsknibgou2RsjUfZx+I7CdfHJgBzkxeMB
         AbUA==
X-Gm-Message-State: AOJu0YxFPFLyXNKk6WEu4VNvUMGlTHUAUAllSOLb8kfmES3qgPq1lLV6
	hJVNYSO6iLiNZmaRqoRV3Am6G+q4sXbILdwCuVbjw+B2kyi2B4o641v4VlTYF9dVT3d0SLJnDql
	P
X-Google-Smtp-Source: AGHT+IHFJvs5Y62A4s2+4NyD91rMTfDMUQMyM96uSFMGWMijNiyZvoyZ2a3OpABQ3ov2M0eFA1Aicw==
X-Received: by 2002:a05:622a:114:b0:440:c5bc:db7e with SMTP id d75a77b69052e-444d932b0b7mr44519051cf.66.1719244244738;
        Mon, 24 Jun 2024 08:50:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3d97esm43764861cf.62.2024.06.24.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/8] fs: Allow listmount() in foreign mount namespace
Date: Mon, 24 Jun 2024 11:49:48 -0400
Message-ID: <49930bdce29a8367a213eb14c1e68e7e49284f86.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

Expand struct mnt_id_req to add an optional mnt_ns_id field.  When this
field is populated, listmount() will be performed on the specified mount
namespace, provided the currently application has CAP_SYS_ADMIN in its
user namespace and the mount namespace is a child of the current
namespace.

Co-developed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c             | 88 ++++++++++++++++++++++++++++++--------
 include/uapi/linux/mount.h |  2 +
 2 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3c6711fec3cd..1b422fd5f267 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5125,7 +5125,7 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 	int ret;
 	size_t usize;
 
-	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER1);
 
 	ret = get_user(usize, &req->size);
 	if (ret)
@@ -5143,6 +5143,58 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 	return 0;
 }
 
+static struct mount *listmnt_next(struct mount *curr, bool reverse)
+{
+	struct rb_node *node;
+
+	if (reverse)
+		node = rb_prev(&curr->mnt_node);
+	else
+		node = rb_next(&curr->mnt_node);
+
+	return node_to_mount(node);
+}
+
+static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
+{
+	struct mount *first;
+
+	rwsem_assert_held(&namespace_sem);
+
+	/* We're looking at our own ns, just use get_fs_root. */
+	if (ns == current->nsproxy->mnt_ns) {
+		get_fs_root(current->fs, root);
+		return 0;
+	}
+
+	/*
+	 * We have to find the first mount in our ns and use that, however it
+	 * may not exist, so handle that properly.
+	 */
+	if (RB_EMPTY_ROOT(&ns->mounts))
+		return -ENOENT;
+
+	first = listmnt_next(ns->root, false);
+	if (!first)
+		return -ENOENT;
+	root->mnt = mntget(&first->mnt);
+	root->dentry = dget(root->mnt->mnt_root);
+	return 0;
+}
+
+/*
+ * If the user requested a specific mount namespace id, look that up and return
+ * that, or if not simply grab a passive reference on our mount namespace and
+ * return that.
+ */
+static struct mnt_namespace *grab_requested_mnt_ns(u64 mnt_ns_id)
+{
+	if (mnt_ns_id)
+		return lookup_mnt_ns(mnt_ns_id);
+	refcount_inc(&current->nsproxy->mnt_ns->passive);
+	return current->nsproxy->mnt_ns;
+}
+
 SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 		struct statmount __user *, buf, size_t, bufsize,
 		unsigned int, flags)
@@ -5188,30 +5240,21 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
-static struct mount *listmnt_next(struct mount *curr, bool reverse)
-{
-	struct rb_node *node;
-
-	if (reverse)
-		node = rb_prev(&curr->mnt_node);
-	else
-		node = rb_next(&curr->mnt_node);
-
-	return node_to_mount(node);
-}
-
-static ssize_t do_listmount(u64 mnt_parent_id, u64 last_mnt_id, u64 *mnt_ids,
-			    size_t nr_mnt_ids, bool reverse)
+static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
+			    u64 last_mnt_id, u64 *mnt_ids, size_t nr_mnt_ids,
+			    bool reverse)
 {
 	struct path root __free(path_put) = {};
-	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct path orig;
 	struct mount *r, *first;
 	ssize_t ret;
 
 	rwsem_assert_held(&namespace_sem);
 
-	get_fs_root(current->fs, &root);
+	ret = grab_requested_root(ns, &root);
+	if (ret)
+		return ret;
+
 	if (mnt_parent_id == LSMT_ROOT) {
 		orig = root;
 	} else {
@@ -5263,6 +5306,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 {
 	u64 *kmnt_ids __free(kvfree) = NULL;
 	const size_t maxcount = 1000000;
+	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct mnt_id_req kreq;
 	ssize_t ret;
 
@@ -5289,8 +5333,16 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!kmnt_ids)
 		return -ENOMEM;
 
+	ns = grab_requested_mnt_ns(kreq.mnt_ns_id);
+	if (!ns)
+		return -ENOENT;
+
+	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+		return -ENOENT;
+
 	scoped_guard(rwsem_read, &namespace_sem)
-		ret = do_listmount(kreq.mnt_id, kreq.param, kmnt_ids,
+		ret = do_listmount(ns, kreq.mnt_id, kreq.param, kmnt_ids,
 				   nr_mnt_ids, (flags & LISTMOUNT_REVERSE));
 
 	if (copy_to_user(mnt_ids, kmnt_ids, ret * sizeof(*mnt_ids)))
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index a07508aee518..ee1559cd6764 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -189,10 +189,12 @@ struct mnt_id_req {
 	__u32 spare;
 	__u64 mnt_id;
 	__u64 param;
+	__u64 mnt_ns_id;
 };
 
 /* List of all mnt_id_req versions. */
 #define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
+#define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
 
 /*
  * @mask bits for statmount(2)
-- 
2.43.0


