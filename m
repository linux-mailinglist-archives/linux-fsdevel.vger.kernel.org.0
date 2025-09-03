Return-Path: <linux-fsdevel+bounces-60074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75BB413E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71160681A48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149642D8779;
	Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mJ9ePG/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B462D5C73
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875347; cv=none; b=fRnmUa5Gtw66ypEReuOtMANy0FU/8Q5gXZbw5FwrrR7QxLX6+SVy7kNUO/6gAk7wdWs98UpZoCr0nHmLmj31ulnd3Of9kf5Iz3u/GEKRTG2J8iI9FW+ezE0RvBZtmzx49JL8lH+wiX9Y2KZR48HdAkUiyd+cOgCbSUjqYMTO6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875347; c=relaxed/simple;
	bh=+B+o4BijBafVuH3sYHX25CvdCvqsChYLWAuNYbnJHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOvshlVm8JXDhpvxt9oLtOznza7iyXiAbv+Vg6lzeLCjL+MOLvHatFsMMSrBju/HUX/FRl0Vl/iEyY8To2B+8DeAz9aXKvUblQGaHgSigx7E5n4DMXKMiq/iBDOgtMGPwxMUpxgXn0IBGqSa/c+SYOLq/NjjGY0DV3Veikivt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mJ9ePG/O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HuukHR+1X9+vH1DIDijaK+h8qqh72xNxgFdzXW9oHNE=; b=mJ9ePG/O9tavVnCBH2tIlR0U12
	z0YddzrdP7odXOzdCxMzwtIUQIviE8J3QQAXvi1uSoSccSTvPQy5lm1z0MsQ4TsrSSwQ7Cl5n3aC+
	FQFzezIiOFrblx/fi8RgD1iC35diCwsYJQGMGmRbJCUVZGE7tXjOJqODKnCGEtaOZS5BB7pFfDVlg
	NVcv7wiGhd71fpSJRUz+qHPNnecO8cxNtYB2OR2JboRp5wdm7NLED1fllfJU0icQUMTI0H0jH7yUp
	L62ZIdmC9bswKmpfeQfCv163RisxvXf3bUkWba/msdRl1+xD84T35rviHfP81IzSENSv10DAaF8Kc
	xSY+9idQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap9N-3bM9;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 25/65] finish_automount(): take the lock_mount() analogue into a helper
Date: Wed,  3 Sep 2025 05:54:46 +0100
Message-ID: <20250903045537.2579614-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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


