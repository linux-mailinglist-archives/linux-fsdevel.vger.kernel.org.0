Return-Path: <linux-fsdevel+bounces-42234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DCA3F5AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C6A189AC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E22116F9;
	Fri, 21 Feb 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDtJ4pZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EC2116ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143633; cv=none; b=KsLoHzqjwV/fO9rx0NpwzX9w1fmki54JEjOH8JjeFJt2TO5DhL5to6h7WYgjTC2VsooC7UR5v6E1hAe/xidnKXEIeKVXwLgogSf/Vt+ZcFbxLPotLmTY8x3fED6p+1Cm8/gCZ+x0a6pBuQbXxl8jY0nfu25RkC4PSvzXc196nfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143633; c=relaxed/simple;
	bh=4mn5sqjIh2I8TbK20gfMxw4oSuvjmtmIZUUFqH+UwpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/0A76uOCT5bZAPjBEPL2RAy0mlq3PMRCWShT8JLE+1NV+Sc2nQjUtsTPiVO4v9uA1rBzwATbx8yKjFmMirHAvmbX3aCU2AOUdyq1WFarkOsUTa4dEqXQG6Wm9y9VeTRRedRe66SwbNrFHCQQ/qM6LWrIcrwcn1DdjfbndRUidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDtJ4pZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4529C4CED6;
	Fri, 21 Feb 2025 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143632;
	bh=4mn5sqjIh2I8TbK20gfMxw4oSuvjmtmIZUUFqH+UwpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MDtJ4pZiOI8UzOaiQMhHiW+lRmK8RwGQsT9VAAaFDub6UMd3tvs5VFYg5ubnREWAN
	 YZPOKhgMhmMXiQbhDysy6LpS/YCfLoJl/hNgvWj7YXFbskP+SuU4lVQy+wV2d++GPc
	 2pGWY2xWrcV0B90+kQbzFgZC51WlXj1fpRm6c3SkF2rqUfH6bRdYoOgVYcahqYcIUw
	 lgNxvbVc2//OZyEYpgJAjKSQVdiWg02dJOASG13lpulC1w6iDIWAZJa18FBxFuY2TZ
	 WZrsB266/2CzppbOXKE3fu+Yk/LM4wmsYbECWOmDSSTsXRWw/BrJFvI9YDBRp5+Bew
	 QLXNFle2iz92w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:08 +0100
Subject: [PATCH RFC 09/16] fs: mount detached mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-9-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6075; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4mn5sqjIh2I8TbK20gfMxw4oSuvjmtmIZUUFqH+UwpI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP51p6zIR4Ah52lOBROHX432zPJFVe3du3zKvoQY/
 VGNNhPvKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIh+AsNf0YOOt5ZHBa1UV+UQ
 MO4qubRg5uWPa6rPi/3Zs23zGpartxj+F6rFCqhZbPeRtey/GtLzM/uuTP/9625TOnQeqofs4Cz
 mAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently, detached mounts can only be mounted onto attached mounts.
This limitation makes it impossible to assemble a new private rootfs and
move it into place. That's an extremely powerful concept for container
and service workloads that we should support.

Right now, a detached tree must be created, attached, then it can gain
additional mounts and then it can either be moved (if it doesn't reside
under a shared mount) or a detached mount created again. Lift this
restriction.

In order to allow mounting detached mounts onto other detached mounts
the same permission model used for creating detached mounts from
detached mounts can be used:

(1) Check that the caller is privileged over the owning user namespace
    of it's current mount namespace.

(2) Check that the caller is located in the mount namespace of the mount
    it wants to create a detached copy of.

The origin mount namespace of the anonymous mount namespace must be the
same as the caller's mount namespace. To establish this the sequence
number of the caller's mount namespace and the origin sequence number of
the anonymous mount namespace are compared.

The caller is always located in a non-anonymous mount namespace since
anonymous mount namespaces cannot be setns()ed into. The caller's mount
namespace will thus always have a valid sequence number.

The owning namespace of any mount namespace, anonymous or non-anonymous,
can never change. A mount attached to a non-anonymous mount namespace
can never change mount namespace.

If the sequence number of the non-anonymous mount namespace and the
origin sequence number of the anonymous mount namespace match, the
owning namespaces must match as well.

Hence, the capability check on the owning namespace of the caller's
mount namespace ensures that the caller has the ability to attach the
mount tree.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 612f73481d35..0242d0dc6b47 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2295,6 +2295,24 @@ void dissolve_on_fput(struct vfsmount *mnt)
 		if (!must_dissolve(ns))
 			return;
 
+		/*
+		 * After must_dissolve() we know that this is a detached
+		 * mount in an anonymous mount namespace.
+		 *
+		 * Now when mnt_has_parent() reports that this mount
+		 * tree has a parent, we know that this anonymous mount
+		 * tree has been moved to another anonymous mount
+		 * namespace.
+		 *
+		 * So when closing this file we cannot unmount the mount
+		 * tree. This will be done when the file referring to
+		 * the root of the anonymous mount namespace will be
+		 * closed (It could already be closed but it would sync
+		 * on @namespace_sem and wait for us to finish.).
+		 */
+		if (mnt_has_parent(m))
+			return;
+
 		lock_mount_hash();
 		umount_tree(m, UMOUNT_CONNECTED);
 		unlock_mount_hash();
@@ -3435,6 +3453,54 @@ static int can_move_mount_beneath(const struct path *from,
 	return 0;
 }
 
+/* may_use_mount() - check if a mount tree can be used
+ * @mnt: vfsmount to be used
+ *
+ * This helper checks if the caller may use the mount tree starting
+ * from @path->mnt. The caller may use the mount tree under the
+ * following circumstances:
+ *
+ * (1) The caller is located in the mount namespace of the mount tree.
+ *     This also implies that the mount does not belong to an anonymous
+ *     mount namespace.
+ * (2) The caller is trying to use a mount tree that belongs to an
+ *     anonymous mount namespace.
+ *
+ *     For that to be safe, this helper enforces that the origin mount
+ *     namespace the anonymous mount namespace was created from is the
+ *     same as the caller's mount namespace by comparing the sequence
+ *     numbers.
+ *
+ *     The ownership of a non-anonymous mount namespace such as the
+ *     caller's cannot change.
+ *     => We know that the caller's mount namespace is stable.
+ *
+ *     If the origin sequence number of the anonymous mount namespace is
+ *     the same as the sequence number of the caller's mount namespace.
+ *     => The owning namespaces are the same.
+ *
+ *     ==> The earlier capability check on the owning namespace of the
+ *         caller's mount namespace ensures that the caller has the
+ *         ability to use the mount tree.
+ *
+ * Returns true if the mount tree can be used, false otherwise.
+ */
+static inline bool may_use_mount(struct mount *mnt)
+{
+	if (check_mnt(mnt))
+		return true;
+
+	/*
+	 * Make sure that noone unmounted the target path or somehow
+	 * managed to get their hands on something purely kernel
+	 * internal.
+	 */
+	if (!is_mounted(&mnt->mnt))
+		return false;
+
+	return check_anonymous_mnt(mnt);
+}
+
 static int do_move_mount(struct path *old_path,
 			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
@@ -3460,8 +3526,14 @@ static int do_move_mount(struct path *old_path,
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	/* The mountpoint must be in our namespace. */
-	if (!check_mnt(p))
+	if (!may_use_mount(p))
+		goto out;
+
+	/*
+	 * Don't allow moving an attached mount tree to an anonymous
+	 * mount tree.
+	 */
+	if (!is_anon_ns(ns) && is_anon_ns(p->mnt_ns))
 		goto out;
 
 	/* The thing moved must be mounted... */
@@ -3472,6 +3544,16 @@ static int do_move_mount(struct path *old_path,
 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
 		goto out;
 
+	/*
+	 * Ending up with two files referring to the root of the same
+	 * anonymous mount namespace would cause an error as this would
+	 * mean trying to move the same mount twice into the mount tree
+	 * which would be rejected later. But be explicit about it right
+	 * here.
+	 */
+	if (is_anon_ns(ns) && is_anon_ns(p->mnt_ns) && ns == p->mnt_ns)
+		goto out;
+
 	if (old->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 

-- 
2.47.2


