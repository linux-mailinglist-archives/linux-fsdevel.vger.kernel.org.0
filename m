Return-Path: <linux-fsdevel+bounces-59553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6AB3AE12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C97583915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D22F1FC2;
	Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SQuLXEXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983E2D59E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=KHvew9U1eA6GkWRL9vKaaf7ePB6ueoEpdOoUGq3b8b5C4Z6G8TUFrxBQBpHLOhkqVWC4zzy3XAmQqMrSEUmgcSeUzUgj7CLnJa17A26qaICr+YhHdPn2a6SNmIHvnEMGQwvyZISJ4JpuN/gU5PFbnZ4TCS15n0DulOsz3SzNt9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=+B+o4BijBafVuH3sYHX25CvdCvqsChYLWAuNYbnJHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjuOQs+Nok+m9uvX+J8D4mFhc/pTlXAotaXIAa/TLsdIK/eC6pSXMSAKcEKE0OK0PyKu+a0OvPoIipIASLt4LC2Aica2v87RHHLUcCQHDOkZh8WRs8DY7Sv0KKOO+tlh9nk6RWMtsMlAm3972yH6oPEPjLjD5MqvEsNl9qUUVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SQuLXEXw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HuukHR+1X9+vH1DIDijaK+h8qqh72xNxgFdzXW9oHNE=; b=SQuLXEXwtJzbDB5L5+w1jR9bVv
	ynwTL5pZ7bQELtAgg4+ErmdY2B0+8IeYgseBRCES36/6xP2EV1KzT/ZhrRgqMHjuzH/Vdnu79zWHQ
	avSy4XHvNxPOntI82wY+Ea3TlTgziXuHIrwRonwpAXzWx6AekVmws9WBAI9/bhTievtX04SW79MVL
	iMUxtpl3w/wC4KPjn/nO98OW6VtVtWWlgeQd2pb2EQBoPCT0LJQ/8YRJKzd5Vdg2w/MLGNAGYvcj1
	4wAcKmFlwcyJGQBICUpk0HpK/UC3hWswCS75dWjObYbxV4p699GY50McEX0p0uA9wm7LW1o3XVn+k
	3kFx7wdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F24W-38dj;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 25/63] finish_automount(): take the lock_mount() analogue into a helper
Date: Fri, 29 Aug 2025 00:07:28 +0100
Message-ID: <20250828230806.3582485-25-viro@zeniv.linux.org.uk>
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

finish_automount() can't use lock_mount() - it treats finding something
already mounted as "quitely drop our mount and return 0", not as
"mount on top of whatever mounted there".  It's been open-coded;
let's take it into a helper similar to lock_mount().  "something's
already mounted" => -EBUSY, finish_automount() needs to distinguish
it from the normal case and it can't happen in other failure cases.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 90b62ee882da..6251ee15f5f6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3781,9 +3781,29 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
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
@@ -3805,20 +3825,11 @@ int finish_automount(struct vfsmount *m, const struct path *path)
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
@@ -3826,9 +3837,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
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


