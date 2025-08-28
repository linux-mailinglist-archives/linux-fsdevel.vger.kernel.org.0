Return-Path: <linux-fsdevel+bounces-59562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A82B3AE26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E723A3231
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E422F5488;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c4GqIRXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B32E03EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422495; cv=none; b=pfqu07sdPE8TdjFIPcNulZ+DP+5qOV26vs8h22krjEHQnw+O9DQJB7TUAZ4qDtbqGT/SKkLJdyw7VRWKtK4yhQ84ynepeR2NjRwSBUPE5li5kgVZw5C3rTUjGYt07ckrcfndTc2IkHUqXQGu0eF1GQ24vzg9DxwZ49kleqO9yKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422495; c=relaxed/simple;
	bh=iIO96DUYxmWnNywmlRdaNq0JjAIRDfbYAEl64FoN/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZIxyqDa1VWAaNS9DjYq7OsZpBLCwoxlovBCHouKdS0hTEw0y6dut1hOwtCLwzn1R2YWEmEKD2qgaLqNNha9IXk9F2w9nYe4Wc02Sd5DSZytS9Rj8t/WHngugb4MKsJ+RFGdd1DEUFKDtdXQMp3fuh09koRgKjtWQApMqoY/at8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c4GqIRXd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IliqLXpNpxISnbrlMwFMoi6HU2ZhSjeAcdUiKyGUBPQ=; b=c4GqIRXdnobzFG3EcoqPUWViau
	7cL+J9ufveph0cwlOz1xcZIZfb5SkylH8K7hwnUFRs76E8+nw7d6vjanyyX5Wf1VeRXaRlqHT/FKM
	7zSqZ2YQB6iQvA7IH10dQ+RU05R8aoDp6q9geLGFyT+413saKUhtwIIGn705TkgPxdspGDOGpv4kl
	q3taTcMu8BABpEx2W5iSqUfNLIG+BO6jgjd2L7tdTvmS6/ARPVgd5CpHlE816MWjz3JDWltTubFEc
	Oe/nfe2p3G2fXIqUo3zODvrj1LFfUE7qeQy7c2gY+I39C71stMLWFrNnVRd4D4W2RkTAWXEl8bexX
	F0+Ek9Ug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj0-0000000F25V-2gEU;
	Thu, 28 Aug 2025 23:08:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 30/63] do_add_mount(): switch to passing pinned_mountpoint instead of mountpoint + path
Date: Fri, 29 Aug 2025 00:07:33 +0100
Message-ID: <20250828230806.3582485-30-viro@zeniv.linux.org.uk>
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

Both callers pass it a mountpoint reference picked from pinned_mountpoint
and path it corresponds to.

First of all, path->dentry is equal to mp.mp->m_dentry.  Furthermore, path->mnt
is &mp.parent->mnt, making struct path contents redundant.

Pass it the address of that pinned_mountpoint instead; what's more, if we
teach it to treat ERR_PTR(error) in ->parent as "bail out with that error"
we can simplify the callers even more - do_add_mount() will do the right
thing even when called after lock_mount() failure.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d57e727962da..b236536bbbc9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3657,10 +3657,13 @@ static int do_move_mount_old(struct path *path, const char *old_name)
 /*
  * add a mount into a namespace's mount tree
  */
-static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
-			const struct path *path, int mnt_flags)
+static int do_add_mount(struct mount *newmnt, const struct pinned_mountpoint *mp,
+			int mnt_flags)
 {
-	struct mount *parent = real_mount(path->mnt);
+	struct mount *parent = mp->parent;
+
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
 
 	mnt_flags &= ~MNT_INTERNAL_FLAGS;
 
@@ -3674,14 +3677,15 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
 	}
 
 	/* Refuse the same filesystem on the same mount point */
-	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb && path_mounted(path))
+	if (parent->mnt.mnt_sb == newmnt->mnt.mnt_sb &&
+	    parent->mnt.mnt_root == mp->mp->m_dentry)
 		return -EBUSY;
 
 	if (d_is_symlink(newmnt->mnt.mnt_root))
 		return -EINVAL;
 
 	newmnt->mnt.mnt_flags = mnt_flags;
-	return graft_tree(newmnt, parent, mp);
+	return graft_tree(newmnt, parent, mp->mp);
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
@@ -3711,14 +3715,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
 	LOCK_MOUNT(mp, mountpoint);
-	if (IS_ERR(mp.parent)) {
-		return PTR_ERR(mp.parent);
-	} else {
-		error = do_add_mount(real_mount(mnt), mp.mp,
-				     mountpoint, mnt_flags);
-		if (!error)
-			retain_and_null_ptr(mnt); // consumed on success
-	}
+	error = do_add_mount(real_mount(mnt), &mp, mnt_flags);
+	if (!error)
+		retain_and_null_ptr(mnt); // consumed on success
 	return error;
 }
 
@@ -3824,11 +3823,10 @@ int finish_automount(struct vfsmount *__m, const struct path *path)
 	 * got", not "try to mount it on top".
 	 */
 	LOCK_MOUNT_EXACT(mp, path);
-	if (IS_ERR(mp.parent))
-		return mp.parent == ERR_PTR(-EBUSY) ? 0 : PTR_ERR(mp.parent);
+	if (mp.parent == ERR_PTR(-EBUSY))
+		return 0;
 
-	err = do_add_mount(mnt, mp.mp, path,
-			   path->mnt->mnt_flags | MNT_SHRINKABLE);
+	err = do_add_mount(mnt, &mp, path->mnt->mnt_flags | MNT_SHRINKABLE);
 	if (likely(!err))
 		retain_and_null_ptr(m);
 	return err;
-- 
2.47.2


