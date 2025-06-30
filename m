Return-Path: <linux-fsdevel+bounces-53289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF1AED2B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317993B4E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1CD21FF21;
	Mon, 30 Jun 2025 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qvThdVnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C251940A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251986; cv=none; b=OHlarqzXwEL+8I9tbwT75ZpvjCACGNin/1acfm4SQLSktZcyUQXBg3FwEvOUYRsdB7RwwP0zdAGS6N9LxzfINDO1Z6nBYMaQXylNOwjDS2kezGOKbVssIFNwMgONIVx1p0KJb/PxS7jSCuC1IisZKbIDYmJVB/afCZPIORrF+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251986; c=relaxed/simple;
	bh=W/EpSkc8II/hDddlIWy65hMAjRbD91LSDgzykJ4CgC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc6iRYQJAWzhkR83LKCg+H796VDIcHbZrw4/kEnphTiWLboPRkegLLEWdO7JUASy0VF0uJmDXWQDIxyAUeaHyKZzh3oqmTwfHdPuS3FMA8W3fGmvodn/Lqy0fv0YT2fKzSYhjIeWnjmgZSYTBXjtR2gBgXtNwB12D8OMwOKzm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qvThdVnz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dSH3BBF4Dv12Xx2T+PiUbdUI2j2kN4ikdKNDrhpt/Hw=; b=qvThdVnzsb75G/lX5yv72mNaRl
	yeXVexnwz9I3YBAfzTrTuQkBMLLjmjQFoUbgQLZl8CvPibxKlDKQRCyzFlSjIJ54SVZBEW7aJYYp5
	NEa1CRYtThA+plGic1D/yCg0PRQD3TCYfCr73Dy8V5/aWiLlg7i5s8KI0IIhBUbauLIAZHTXPtONW
	uPakgicLUk1JKKhKpnCXyCwqVeUIPJGpeYrWP6LMf4yb5clB2iVr26C1NIYORxjqCOZGwdKpIrSG4
	L+vcZZZ+5dzNTzbGwCSRPR6LfzkoImWTAzcmpHt2BubrW/GSyaBLZl0D8DTnDsyADBi6myBHxAm/Z
	LKN1Aojg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p47-3avV;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 45/48] take freeing of emptied mnt_namespace to namespace_unlock()
Date: Mon, 30 Jun 2025 03:52:52 +0100
Message-ID: <20250630025255.1387419-45-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Freeing of a namespace must be delayed until after we'd dealt with mount
notifications (in namespace_unlock()).  The reasons are not immediately
obvious (they are buried in ->prev_ns handling in mnt_notify()), and
having that free_mnt_ns() explicitly called after namespace_unlock()
is asking for trouble - it does feel like they should be OK to free
as soon as they've been emptied.

Make the things more explicit by setting 'emptied_ns' under namespace_sem
and having namespace_unlock() free the sucker as soon as it's safe to free.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bd6c7da901fc..85db0de5fb53 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -79,6 +79,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
 #ifdef CONFIG_FSNOTIFY
@@ -1730,15 +1731,18 @@ static bool need_notify_mnt_list(void)
 }
 #endif
 
+static void free_mnt_ns(struct mnt_namespace *);
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+	struct mnt_namespace *ns = emptied_ns;
 	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
+	emptied_ns = NULL;
 
 	if (need_notify_mnt_list()) {
 		/*
@@ -1752,6 +1756,11 @@ static void namespace_unlock(void)
 	} else {
 		up_write(&namespace_sem);
 	}
+	if (unlikely(ns)) {
+		/* Make sure we notice when we leak mounts. */
+		VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
+		free_mnt_ns(ns);
+	}
 
 	shrink_dentry_list(&list);
 
@@ -2335,12 +2344,10 @@ void drop_collected_paths(struct path *paths, struct path *prealloc)
 		kfree(paths);
 }
 
-static void free_mnt_ns(struct mnt_namespace *);
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 
 void dissolve_on_fput(struct vfsmount *mnt)
 {
-	struct mnt_namespace *ns;
 	struct mount *m = real_mount(mnt);
 
 	/*
@@ -2362,15 +2369,11 @@ void dissolve_on_fput(struct vfsmount *mnt)
 		if (!anon_ns_root(m))
 			return;
 
-		ns = m->mnt_ns;
+		emptied_ns = m->mnt_ns;
 		lock_mount_hash();
 		umount_tree(m, UMOUNT_CONNECTED);
 		unlock_mount_hash();
 	}
-
-	/* Make sure we notice when we leak mounts. */
-	VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
-	free_mnt_ns(ns);
 }
 
 static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
@@ -2678,6 +2681,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	} else {
 		if (source_mnt->mnt_ns) {
 			/* move from anon - the caller will destroy */
+			emptied_ns = source_mnt->mnt_ns;
 			for (p = source_mnt; p; p = next_mnt(p, source_mnt))
 				move_from_ns(p);
 		}
@@ -3656,13 +3660,6 @@ static int do_move_mount(struct path *old_path,
 	err = attach_recursive_mnt(old, p, mp.mp);
 out:
 	unlock_mount(&mp);
-	if (!err) {
-		if (is_anon_ns(ns)) {
-			/* Make sure we notice when we leak mounts. */
-			VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
-			free_mnt_ns(ns);
-		}
-	}
 	return err;
 }
 
@@ -6153,11 +6150,11 @@ void put_mnt_ns(struct mnt_namespace *ns)
 	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
 	namespace_lock();
+	emptied_ns = ns;
 	lock_mount_hash();
 	umount_tree(ns->root, 0);
 	unlock_mount_hash();
 	namespace_unlock();
-	free_mnt_ns(ns);
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)
-- 
2.39.5


