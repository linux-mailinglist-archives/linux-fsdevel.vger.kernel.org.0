Return-Path: <linux-fsdevel+bounces-59547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A409B3AE0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B227F988521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2F2D6E5A;
	Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A3hDh/sH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE22D23B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=prQXdpZbAcdo/YaueFCYibuJpMFBgc5/DockitorF6t6pKLd5A7rtO4BdhOmBXUpsG4ZpDJH8rDjvIHdVJ5/bzb3nGCPzMQ0IQ1U3Yvfuym6UeFowBWh8MZW5nHepM9D9RN68oKC3Aihr7NkyA52eTdOqihtY7/LwO7hWYf4Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=qcdXDPpHwqiVJ6r52bDqt9V3OzTA8YpgSACCi5C1UUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM5CrUq9H4f3zXQi935aoccDNtLrGGJ7xYxpLkQuMRf7nD+egi03tbl2IB9ChxZ45UQM2/MMB0vw+7mGfJQChKStCGM6VyAkBZIddEU4V146KcBdM6xrU9a5PeXaZgHoNEuu1SQ2/7Nf9B+9eTUzHw61eCC5Um+QDg+X9fFiJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A3hDh/sH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=69urXmyg5KFrvN85peeuPorsBjm+32eG/k2iwxgTI/0=; b=A3hDh/sHvjZjlmScGret+N6v7G
	Own0o1poyQrX9GQmtMDCUNzKmZzH8DK0zkk1sDeh8CdAdq453vhM2/Uj/Pi8rzQSZF1Afeavqpw/I
	zaXalrfoKGezeExICivtuiRN0qXWjAdBoXYtVY7p8/UKKFcgR9Rx4wnFuvPR4F6MoVO5QAvy/On1v
	UFgxWFZnJC64QpeOWNblg8Bb4Jvbr/zAPs9fCNRWUasGh+4aRUrB4Q5dzsiPKHlqBxaMrljkdpz+T
	fWYLByYV2ltBcEdnQEZI9W+tZqyyPKMuvYPZZAuvBI+7XXqPn0ggA+6ija/ljDZKwWM/tkzIPpRCD
	UIk3R0KA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F23i-0bGl;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 20/63] do_move_mount(): deal with the checks on old_path early
Date: Fri, 29 Aug 2025 00:07:23 +0100
Message-ID: <20250828230806.3582485-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) checking that location we want to move does point to root of some mount
can be done before anything else; that property is not going to change
and having it already verified simplifies the analysis.

2) checking the type agreement between what we are trying to move and what
we are trying to move it onto also belongs in the very beginning -
do_lock_mount() might end up switching new_path to something that overmounts
the original location, but... the same type agreement applies to overmounts,
so we could just as well check against the original location.

3) since we know that old_path->dentry is the root of old_path->mnt, there's
no point bothering with path_is_overmounted() in can_move_mount_beneath();
it's simply a check for the mount we are trying to move having non-NULL
->overmount.  And with that, we can switch can_move_mount_beneath() to
taking old instead of old_path, leaving no uses of old_path past the original
checks.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ad9b5687ff15..74c67ea1b5a8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3433,7 +3433,7 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
 
 /**
  * can_move_mount_beneath - check that we can mount beneath the top mount
- * @from: mount to mount beneath
+ * @mnt_from: mount we are trying to move
  * @to:   mount under which to mount
  * @mp:   mountpoint of @to
  *
@@ -3443,7 +3443,7 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  *   root or the rootfs of the namespace.
  * - Make sure that the caller can unmount the topmost mount ensuring
  *   that the caller could reveal the underlying mountpoint.
- * - Ensure that nothing has been mounted on top of @from before we
+ * - Ensure that nothing has been mounted on top of @mnt_from before we
  *   grabbed @namespace_sem to avoid creating pointless shadow mounts.
  * - Prevent mounting beneath a mount if the propagation relationship
  *   between the source mount, parent mount, and top mount would lead to
@@ -3452,12 +3452,11 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * Context: This function expects namespace_lock() to be held.
  * Return: On success 0, and on error a negative error code is returned.
  */
-static int can_move_mount_beneath(const struct path *from,
+static int can_move_mount_beneath(struct mount *mnt_from,
 				  const struct path *to,
 				  const struct mountpoint *mp)
 {
-	struct mount *mnt_from = real_mount(from->mnt),
-		     *mnt_to = real_mount(to->mnt),
+	struct mount *mnt_to = real_mount(to->mnt),
 		     *parent_mnt_to = mnt_to->mnt_parent;
 
 	if (!mnt_has_parent(mnt_to))
@@ -3470,7 +3469,7 @@ static int can_move_mount_beneath(const struct path *from,
 		return -EINVAL;
 
 	/* Avoid creating shadow mounts during mount propagation. */
-	if (path_overmounted(from))
+	if (mnt_from->overmount)
 		return -EINVAL;
 
 	/*
@@ -3565,16 +3564,21 @@ static int do_move_mount(struct path *old_path,
 			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
 	struct mount *p;
-	struct mount *old;
+	struct mount *old = real_mount(old_path->mnt);
 	struct pinned_mountpoint mp;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
 
+	if (!path_mounted(old_path))
+		return -EINVAL;
+
+	if (d_is_dir(new_path->dentry) != d_is_dir(old_path->dentry))
+		return -EINVAL;
+
 	err = do_lock_mount(new_path, &mp, beneath);
 	if (err)
 		return err;
 
-	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
 
 	err = -EINVAL;
@@ -3611,15 +3615,8 @@ static int do_move_mount(struct path *old_path,
 			goto out;
 	}
 
-	if (!path_mounted(old_path))
-		goto out;
-
-	if (d_is_dir(new_path->dentry) !=
-	    d_is_dir(old_path->dentry))
-		goto out;
-
 	if (beneath) {
-		err = can_move_mount_beneath(old_path, new_path, mp.mp);
+		err = can_move_mount_beneath(old, new_path, mp.mp);
 		if (err)
 			goto out;
 
-- 
2.47.2


