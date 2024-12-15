Return-Path: <linux-fsdevel+bounces-37450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084819F2602
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 21:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DC1885914
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D821BF7FC;
	Sun, 15 Dec 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8GpOvdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31368831
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293851; cv=none; b=O9wnp1bAD5Ql61gURA0QYWxl2Gvz1OnNRDZAAshkMR/IfJSURbf/5RMQm1dDLVJu0XDPLHmk+3/64RE24bLxZik7N4ZiuLoEnZEFVVHg7TfFpKQ06F2ubskOvIIDP3sANEGrfpqY7EBnPtdJX2/6y1rNU9NhiNv9pH13ZJkD23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293851; c=relaxed/simple;
	bh=z0UslY2EoGwGNf0urQ8uYzTdALc1f94HxDNf4auqClc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2mVE7ihGR8y1zh89XWRQnIKhLOlxatsfRZP8kLl+XH+oaWsV8Qiq2sm1OPlbXfywnVU7m3lfm8gcCGmmvHNDrD7XZUUAbnqXy7C0jAMBwWv+LhNwvosfA5HU59zZmC92z0ap/IRrZQMFOC2dbr+LjjNZcczWKA9RYr2/7fAKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8GpOvdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9E0C4CED6;
	Sun, 15 Dec 2024 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734293851;
	bh=z0UslY2EoGwGNf0urQ8uYzTdALc1f94HxDNf4auqClc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D8GpOvdyTGDqjWWn0clhgJ1pm3SOZZJ5cn5tCq2zIuSWEvmTseltNvARx2VW3AI+Q
	 qTUh0HwXLMem78EvnMnt2na4g4H0rbzJti6tnOFt/qZ4kEEgr35kpukRDCkYjZv3eb
	 IpX2mgvP8EjHXrHQuFmeXY0s6woEz3k/VA4qMEJl4Z0hcLNtkRwxvVKOUdMnQgAtRA
	 6x0uN+d7wF1qaT7vwaHIn8tQNA7ro19e2fdavGLogkDqdHQN2Hzk9H03Srgi84Yqks
	 339JPl19F0clpH8Wuc4nlGF1LsJDlvUYtbs0zh1x3aagtu60/N8yF7wWoHXA08XtcJ
	 Lc1PqDndlqvPg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 15 Dec 2024 21:17:06 +0100
Subject: [PATCH 2/3] fs: cache first and last mount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-vfs-6-14-mount-work-v1-2-fd55922c4af8@kernel.org>
References: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
In-Reply-To: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3092; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z0UslY2EoGwGNf0urQ8uYzTdALc1f94HxDNf4auqClc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTHW4Yt7RSazDZjW9EXWZ01JYwa724u/pAuXzZhVnJDr
 iF3Sf3EjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0eTD8L4qs1tvmkPmZT733
 +tvaHG+/n+YtrjKKZi17j4gvdd4ZyPC/zn1KJ2NTyNvMSCet25s/6IVLaeXHmAlE5f/XeZGlOo0
 dAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Speed up listmount() by caching the first and last node making retrieval
of the first and last mount of each mount namespace O(1).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     | 13 +++++++++++--
 fs/namespace.c | 17 +++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index e9f48e563c0fe9c4af77369423db2cc8695fa808..ffb613cdfeee97b99fe9419e8152c166e0a9ac83 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -8,7 +8,11 @@
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
-	struct rb_root		mounts; /* Protected by namespace_sem */
+	struct {
+		struct rb_root	mounts;		 /* Protected by namespace_sem */
+		struct rb_node	*mnt_last_node;	 /* last (rightmost) mount in the rbtree */
+		struct rb_node	*mnt_first_node; /* first (leftmost) mount in the rbtree */
+	};
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	u64			seq;	/* Sequence number to prevent loops */
@@ -154,8 +158,13 @@ static inline bool mnt_ns_attached(const struct mount *mnt)
 
 static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 {
+	struct mnt_namespace *ns = mnt->mnt_ns;
 	WARN_ON(!mnt_ns_attached(mnt));
-	rb_erase(&mnt->mnt_node, &mnt->mnt_ns->mounts);
+	if (ns->mnt_last_node == &mnt->mnt_node)
+		ns->mnt_last_node = rb_prev(&mnt->mnt_node);
+	if (ns->mnt_first_node == &mnt->mnt_node)
+		ns->mnt_first_node = rb_next(&mnt->mnt_node);
+	rb_erase(&mnt->mnt_node, &ns->mounts);
 	RB_CLEAR_NODE(&mnt->mnt_node);
 	list_add_tail(&mnt->mnt_list, dt_list);
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index d67df0fce4dcd1ee5ddf9ff5fbe005bcdcd626f1..d99a3c2c5e5c8a2e2d4e762ebda1226b882cd7f1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1158,16 +1158,25 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 {
 	struct rb_node **link = &ns->mounts.rb_node;
 	struct rb_node *parent = NULL;
+	bool mnt_first_node = true, mnt_last_node = true;
 
 	WARN_ON(mnt_ns_attached(mnt));
 	mnt->mnt_ns = ns;
 	while (*link) {
 		parent = *link;
-		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique)
+		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique) {
 			link = &parent->rb_left;
-		else
+			mnt_last_node = false;
+		} else {
 			link = &parent->rb_right;
+			mnt_first_node = false;
+		}
 	}
+
+	if (mnt_last_node)
+		ns->mnt_last_node = &mnt->mnt_node;
+	if (mnt_first_node)
+		ns->mnt_first_node = &mnt->mnt_node;
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
 }
@@ -5562,9 +5571,9 @@ static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
 
 	if (!last_mnt_id) {
 		if (reverse)
-			first = node_to_mount(rb_last(&ns->mounts));
+			first = node_to_mount(ns->mnt_last_node);
 		else
-			first = node_to_mount(rb_first(&ns->mounts));
+			first = node_to_mount(ns->mnt_first_node);
 	} else {
 		if (reverse)
 			first = mnt_find_id_at_reverse(ns, last_mnt_id - 1);

-- 
2.45.2


