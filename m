Return-Path: <linux-fsdevel+bounces-21237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B89007F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2AD1C22FDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C775199255;
	Fri,  7 Jun 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuRsynMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9154660
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772158; cv=none; b=FMmodOXYQUiSZ6XujHrO30qiOChI9lOIyzl9+YbRp6xvGXh90UjdahJXSajxCQ1nAp3q9PJeLwS99f2UxyMIAm282vDAICLeninjP7GiSsXqu3k86LOL8hOSWFP2CSwHQuBdax43L4WsSZxMAUT9JNQYiqzhtQ3fhVNGfWiUVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772158; c=relaxed/simple;
	bh=g7bulEmSdhtPayCYyl9eLgPHqmNEoIh5/t7WlOUgO5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZ11oxv2MLvHdIaHRkdynDG+E0aupXlgevQ4O7oo+MW7pXBTiVhXPYSWWAij6avkRDsmKKRFA+V4vvo2kRVNAEA9csxkhKFG6M0PM2btYDvwAtfJEtby5s05ONGeQSVZC59zkL7rEA0fo1ZZBSID8IzKC2BeIaPsn1D6cTrBYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuRsynMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FDEC32786;
	Fri,  7 Jun 2024 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772158;
	bh=g7bulEmSdhtPayCYyl9eLgPHqmNEoIh5/t7WlOUgO5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BuRsynMPS2FI4TQ2JGuJVA3FdH3TwmTBpVKipBVkNHTGKTFoU4brFpNAPP39IcZxR
	 gZU11DsKYyBO4k3XrGeXmnVYTiiQ6CVZy3dfeHFFgzV5mlWWIUERBbqbN6AQDNcs9r
	 MGgjQxfPTdiik5tf3mJlBSEHnMq5ZRUwE9eV2sezuZxnHrE6oVSx3fAxfJ/ChsJv6w
	 ul094eT2fkC/6k7Taeb9MXVVYqzdctYiF8VXGWjUeSW0wvygzX1eC3+nIfSnR5K746
	 m1kPFBUUqHXLWtk00W/N0ynw2rLRIN2tt1AprWMcifRO3HE06yrrlPXBKmX0NfgVjz
	 NgbAA3nZ10Kqw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Jun 2024 16:55:37 +0200
Subject: [PATCH 4/4] listmount: allow listing in reverse order
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-vfs-listmount-reverse-v1-4-7877a2bfa5e5@kernel.org>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5183; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g7bulEmSdhtPayCYyl9eLgPHqmNEoIh5/t7WlOUgO5Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQly5dZMk2rfJJaN3eC0Z+ndrWbP1uabI0u2dLl2Oewt
 W/vjcb/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZXcbIsEF4afq+aTl3JO7L
 /9Hd6BTXu4bR7W1jb5zitg4JiyVutgz/HW8bxSj3KZyfGR4cZKL0vbnAY/Z7JQdtwV3B2jILoyS
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

util-linux is about to implement listmount() and statmount() support.
Karel requested the ability to scan the mount table in backwards order
because that's what libmount currently does in order to get the latest
mount first. We currently don't support this in listmount(). Add a new
LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For
example, listing all child mounts of /sys without LISTMOUNT_REVERSE
gives:

    /sys/kernel/security @ mnt_id: 4294968369
    /sys/fs/cgroup @ mnt_id: 4294968370
    /sys/firmware/efi/efivars @ mnt_id: 4294968371
    /sys/fs/bpf @ mnt_id: 4294968372
    /sys/kernel/tracing @ mnt_id: 4294968373
    /sys/kernel/debug @ mnt_id: 4294968374
    /sys/fs/fuse/connections @ mnt_id: 4294968375
    /sys/kernel/config @ mnt_id: 4294968376

whereas with LISTMOUNT_RESERVE it gives:

    /sys/kernel/config @ mnt_id: 4294968376
    /sys/fs/fuse/connections @ mnt_id: 4294968375
    /sys/kernel/debug @ mnt_id: 4294968374
    /sys/kernel/tracing @ mnt_id: 4294968373
    /sys/fs/bpf @ mnt_id: 4294968372
    /sys/firmware/efi/efivars @ mnt_id: 4294968371
    /sys/fs/cgroup @ mnt_id: 4294968370
    /sys/kernel/security @ mnt_id: 4294968369

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c             | 62 ++++++++++++++++++++++++++++++++++++++--------
 include/uapi/linux/mount.h |  1 +
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 507f310dbf33..911c149c7979 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1448,6 +1448,30 @@ static struct mount *mnt_find_id_at(struct mnt_namespace *ns, u64 mnt_id)
 	return ret;
 }
 
+/*
+ * Returns the mount which either has the specified mnt_id, or has the next
+ * greater id before the specified one.
+ */
+static struct mount *mnt_find_id_at_reverse(struct mnt_namespace *ns, u64 mnt_id)
+{
+	struct rb_node *node = ns->mounts.rb_node;
+	struct mount *ret = NULL;
+
+	while (node) {
+		struct mount *m = node_to_mount(node);
+
+		if (mnt_id >= m->mnt_id_unique) {
+			ret = node_to_mount(node);
+			if (mnt_id == m->mnt_id_unique)
+				break;
+			node = node->rb_right;
+		} else {
+			node = node->rb_left;
+		}
+	}
+	return ret;
+}
+
 #ifdef CONFIG_PROC_FS
 
 /* iterator; we want it to have access to namespace_sem, thus here... */
@@ -5042,14 +5066,22 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
-static struct mount *listmnt_next(struct mount *curr)
+static struct mount *listmnt_next(struct mount *curr, bool reverse)
 {
-	return node_to_mount(rb_next(&curr->mnt_node));
+	struct rb_node *node;
+
+	if (reverse)
+		node = rb_prev(&curr->mnt_node);
+	else
+		node = rb_next(&curr->mnt_node);
+
+	return node_to_mount(node);
 }
 
 static ssize_t do_listmount(struct mount *first, struct path *orig,
 			    u64 mnt_parent_id, u64 __user *mnt_ids,
-			    size_t nr_mnt_ids, const struct path *root)
+			    size_t nr_mnt_ids, const struct path *root,
+			    bool reverse)
 {
 	struct mount *r;
 	ssize_t ret;
@@ -5066,7 +5098,7 @@ static ssize_t do_listmount(struct mount *first, struct path *orig,
 	if (ret)
 		return ret;
 
-	for (ret = 0, r = first; r && nr_mnt_ids; r = listmnt_next(r)) {
+	for (ret = 0, r = first; r && nr_mnt_ids; r = listmnt_next(r, reverse)) {
 		if (r->mnt_id_unique == mnt_parent_id)
 			continue;
 		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
@@ -5090,9 +5122,10 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 	struct path orig;
 	u64 mnt_parent_id, last_mnt_id;
 	const size_t maxcount = (size_t)-1 >> 3;
+	bool reverse_order;
 	ssize_t ret;
 
-	if (flags)
+	if (flags & ~LISTMOUNT_REVERSE)
 		return -EINVAL;
 
 	if (unlikely(nr_mnt_ids > maxcount))
@@ -5118,12 +5151,21 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 			return -ENOENT;
 		orig.dentry = orig.mnt->mnt_root;
 	}
-	if (!last_mnt_id)
-		first = node_to_mount(rb_first(&ns->mounts));
-	else
-		first = mnt_find_id_at(ns, last_mnt_id + 1);
+	reverse_order = flags & LISTMOUNT_REVERSE;
+	if (!last_mnt_id) {
+		if (reverse_order)
+			first = node_to_mount(rb_last(&ns->mounts));
+		else
+			first = node_to_mount(rb_first(&ns->mounts));
+	} else {
+		if (reverse_order)
+			first = mnt_find_id_at_reverse(ns, last_mnt_id - 1);
+		else
+			first = mnt_find_id_at(ns, last_mnt_id + 1);
+	}
 
-	return do_listmount(first, &orig, mnt_parent_id, mnt_ids, nr_mnt_ids, &root);
+	return do_listmount(first, &orig, mnt_parent_id, mnt_ids, nr_mnt_ids,
+			    &root, reverse_order);
 }
 
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index ad5478dbad00..88d78de1519f 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -207,5 +207,6 @@ struct mnt_id_req {
  * Special @mnt_id values that can be passed to listmount
  */
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+#define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
 #endif /* _UAPI_LINUX_MOUNT_H */

-- 
2.43.0


