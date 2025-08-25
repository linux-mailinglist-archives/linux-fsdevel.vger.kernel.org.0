Return-Path: <linux-fsdevel+bounces-58918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD357B3356E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570757A4BB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916927B50C;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P6eJJUkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690BD2749D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=VFuUf2+ZuFAriBLX7qa8NNeUDVqXhIg4hWi6GZSHooeiOLJlZHkoc1rhoOIWwJ6xCcRq9OrDRkUZS0Oov7KDOCcFlnQOnEnrEqoq7tN6hoLqZERH0CA9wPpgID3K30DNTHTJmUUBFUNEaKlD2Kl03/3/xrFNDr8rBpO8eCJKrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=x2Jl1S3LgKTubqRwEzFWDjA/Tqn2NemRO2t7ULBNmlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOHdWnozNSbQqUfNUuQL+kqsbCKBJ5vgxnyagUZwSinglx7SxNX5ZaAO1adyc7A5ElG8iRO21lmUNGEPuQ1rQs5ZW3UQM1RTJJS/HqxvleyQAoTSHnnO3nSUtBbp0pReZ+IQBlm0w6h+1k+/hABK32Ol4NnFB6Ud33AX7+OpFjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P6eJJUkZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L25YVQL53BcV/n4KISmwb7vez+AMe0AL2PeAcI6dWpI=; b=P6eJJUkZ0/zqFcGspnOX5wyrpl
	lVNdTyDcjijf+mLFGUVblkJl6u8W4ft7I662ShRhr7AecqAUilcXumSX3rTdBe4XP6P6XFcRxPScF
	OTVp2aqax1Q7uHaZ9J87wt/D3XD3v9kceMM0twjNe1aUwTz/2OvNC1KPaC5gbSwmAA+A7r+o5by/w
	maEoC8D5p6QZZJvaxvhJYr1R2U8v8yYYIDEaxX3wgCg2LYwZEUgDh4s0pkuXvmko7ZUYXcUD/sMQc
	ynmNCetrOdP34GD0k8dqj1y2DfboZucGv5XNZb/JmT209wnUIqpHVg7SRZDsB3/H3Jf33GgoPWCZ4
	ex2k3bJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TAt-3LxJ;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 19/52] do_move_mount(): deal with the checks on old_path early
Date: Mon, 25 Aug 2025 05:43:22 +0100
Message-ID: <20250825044355.1541941-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1a076aac5d73..42ef0d0c3d40 100644
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


