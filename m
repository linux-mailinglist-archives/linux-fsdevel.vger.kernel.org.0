Return-Path: <linux-fsdevel+bounces-58926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D224B3357D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BE317D4EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B428314E;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z71zU1Yh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB8277C94
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097042; cv=none; b=C+wzc8rwD7TiAFUk6tQ2tOYdwIsWCWg+oCK0nh6O27MVRyNKqQx/H1iZhuq3M6Tcm4r8/HLC0d/K/UjPczUZV7oyGu7yWUPJOMcWRwtl8oC7o7aZLNbuolPCiM72LTWp17oJ/WdaSKypnRuYWttWA9iOjwMviqH8i2RokLySa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097042; c=relaxed/simple;
	bh=z7Q8Vk60Dxwa44N2VFmVDdSBb6erB+bAW8zEdY6PYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh75QajCegCWp/kDqSlrQyZwSl9SwjkKNWDd2pP78OjOc4vyc4CLiiTVrKWRkorJbP4avSnTG3ULYOf9fgTaUwjZ5aN04XE6K1C8pzKgYpnd0O3Jq555bqrntevkUL15wO3blMZ513H3Nz+ylLVm5FYu0xytpdW/qZf2zjio5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z71zU1Yh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5p/KyrujCCtoyeuJScNwk0ZFEAv7pq7ztEi3nUcnAWA=; b=Z71zU1Yhev8Zx8Qa9lBd0jC3Ic
	SKcSHlYL202Rq5SgtikupsBr8yGFEu4XpFjPmmI3dXemd7fm8EOEcYyw/3d7hjwmrgtPvJU40afbr
	hknlB+1OX3oefDMg3vLN5nw5uZT7C+x0q/B4ce9pbNmu/MaTijGn9OrUmGC4k23gK+nenPkdT5Px5
	wBPKLK7xzPt+pUWyV2Kz/9hXjG85DxxEiIJKCYMhyH8Axt4nCPGSWdb9V02X7WjkwoCWAN8iJEUH6
	mYgwUVRAOLgfdwIx68OQRc3tMV3z0KOcaiq2WLyXhQ/kOd6+0OzXKjUWFmcVipzGNYIJnhcv/fc1h
	8/97c32A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBg-24Yg;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 24/52] finish_automount(): take the lock_mount() analogue into a helper
Date: Mon, 25 Aug 2025 05:43:27 +0100
Message-ID: <20250825044355.1541941-24-viro@zeniv.linux.org.uk>
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

finish_automount() can't use lock_mount() - it treats finding something
already mounted as "quitely drop our mount and return 0", not as
"mount on top of whatever mounted there".  It's been open-coded;
let's take it into a helper similar to lock_mount().  "something's
already mounted" => -EBUSY, finish_automount() needs to distinguish
it from the normal case and it can't happen in other failure cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 892251663419..99757040a39a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3786,9 +3786,29 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	return err;
 }
 
-int finish_automount(struct vfsmount *m, const struct path *path)
+static int lock_mount_exact(const struct path *path,
+			    struct pinned_mountpoint *mp)
 {
 	struct dentry *dentry = path->dentry;
+	int err;
+
+	inode_lock(dentry->d_inode);
+	namespace_lock();
+	if (unlikely(cant_mount(dentry)))
+		err = -ENOENT;
+	else if (path_overmounted(path))
+		err = -EBUSY;
+	else
+		err = get_mountpoint(dentry, mp);
+	if (unlikely(err)) {
+		namespace_unlock();
+		inode_unlock(dentry->d_inode);
+	}
+	return err;
+}
+
+int finish_automount(struct vfsmount *m, const struct path *path)
+{
 	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 	int err;
@@ -3810,20 +3830,11 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 	 * that overmounts our mountpoint to be means "quitely drop what we've
 	 * got", not "try to mount it on top".
 	 */
-	inode_lock(dentry->d_inode);
-	namespace_lock();
-	if (unlikely(cant_mount(dentry))) {
-		err = -ENOENT;
-		goto discard_locked;
-	}
-	if (path_overmounted(path)) {
-		err = 0;
-		goto discard_locked;
+	err = lock_mount_exact(path, &mp);
+	if (unlikely(err)) {
+		mntput(m);
+		return err == -EBUSY ? 0 : err;
 	}
-	err = get_mountpoint(dentry, &mp);
-	if (err)
-		goto discard_locked;
-
 	err = do_add_mount(mnt, mp.mp, path,
 			   path->mnt->mnt_flags | MNT_SHRINKABLE);
 	unlock_mount(&mp);
@@ -3831,9 +3842,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 		goto discard;
 	return 0;
 
-discard_locked:
-	namespace_unlock();
-	inode_unlock(dentry->d_inode);
 discard:
 	mntput(m);
 	return err;
-- 
2.47.2


