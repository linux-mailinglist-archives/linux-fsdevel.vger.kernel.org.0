Return-Path: <linux-fsdevel+bounces-58934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619FB33587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662F33AFF05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFB284684;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pQ3i7biz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632327A915
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=YIMJQjuvP074L9K2Qn0dFrAoBVBVSyX17Z/3voJlcRgzpekeMpvgg7BhVpOjubvLqR0AC0EQb8wJ6h/15mIR0GHPkGMbOeKWOoNwxostG3NAZJcLqK/OFWXoO0x8MeA0GnLNKpd9tgtGUbhJpcMjICkbr9zzxQLw8u8gTprEYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=qNIKWlZaaAxuU3+m7odJj4ESDgK9r89WyLkp/ioOdLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMImYKYQ4hVuLzCPpGzobj1P6o8DEDjEjjQ8ksSGiMsh+Liiln5Vois78oRQ8NPl07aLRax28r32B+lOrlV/DYXFgf+PwzP6Do+5QkMYotJSloye9HX+EKI2+KowKb9ofq/uLo61zjQBwrfuG6UHYmSRqexmJorcD/mwi8lKWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pQ3i7biz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GMzyZDjHF5U7a0+zZLW9rT1B0HGquVgpD0HnxN7sCsE=; b=pQ3i7bizioD9yQdECUCCmQEd/5
	hObXnkddobEDcAHAa1NhUGwJynL+/irmMtwJbg2CHGrWZrxrVZQU9/JPw9AmWmbMdG/+RQ2w1CZ4Y
	2jO57U+lfmJKpTrBjcodNLq46GWoCyrktlpq7Ab9E6hIG/Ax2P9OOE7ly3UcT6f1CZ1VK+kzRqR21
	ikftSz7aeQ7rmF2ygY6uGjZXRhXe8Phv2XCTc61RxqOqpUGMExmN/KiG/SAu/Vs11tlPrHcgR3kTc
	yD5lc/JmVpsn2G3LXIUT7J4UGqp8e04tdgLdwyZ35Gz3V9c4p1rvppwdu90hp9dbpK2lSWHbTorOp
	M7O+/C8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TCZ-0otz;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 29/52] do_add_mount(): switch to passing pinned_mountpoint instead of mountpoint + path
Date: Mon, 25 Aug 2025 05:43:32 +0100
Message-ID: <20250825044355.1541941-29-viro@zeniv.linux.org.uk>
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
index 05019dde25a0..06c672127aee 100644
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
@@ -3714,14 +3718,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
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
 
@@ -3829,11 +3828,10 @@ int finish_automount(struct vfsmount *__m, const struct path *path)
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


