Return-Path: <linux-fsdevel+bounces-52465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C323AAE3487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5B16D780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6E1F3FF8;
	Mon, 23 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ERFEFgnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D451E51E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654477; cv=none; b=j2X5XYhph4cuUffd7TnKipFmzsosWxb0jdQqCPbR717MjjwQTUI9SNowhOulpK96vvYdB+lkHpD7pnqaKy9KPGqAfvvLtkQikYgB9g0E3uFgSw/5FWk+4HS6Hnsa4MeP1pHzeM71pVhJ4LCaLIlCASNBS0a5BKcgcPCcIoAULXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654477; c=relaxed/simple;
	bh=XIG7FfvL5o8E932yZpw0Er7uxtMhCu7Hgov/KdGnSns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdKIeTafK5UAI/8n67TOQ4U061ZBQJtrP1WTUywU0ZNH57p84OXIPXmH4tF4fU/+czYsd1ZIl1aXMaEA5fJJaha++Qyo5V7XIMm7/LQ53s0axlQ1uPkFOO7qJRiRStyABU0UkOHZnMji/AgYbQEcml5BlJVinddTZuYTpE8xxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ERFEFgnA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JbiDxAi2gin9LglvafrK4r6wdaZiNf+B2kphhvJ5v6g=; b=ERFEFgnAEM4XnUARr5JcNRB1aw
	Tfgq0VHAX6rMvCv8tA2FrDSlMuSRVRThAunM8rikL9NiCLo0TEY32DJOFDb8czx8i1WV8LpJ8O7Dz
	ce1GkK1DQUNFRwt9tfwOzfTu9xgxDeXMHC9j7CpZOvuzPlAgBEEfMIhc8MXzP6Mb2IDBwUejAZTEk
	MMgv7wYQyziI7J7hMub2YIeDRgwB95txf+CgPBOIjrwuIPUcJYoiJYghM5dUCUb0eD69zLm0rEP8a
	khXsEPKPpTAyK4yxUeok/DDEkDcDG4rUm22B93ChARQKbr3icyqhSl8ieaCE7nCW61Q6rg//SZFfk
	52lG49tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005Kv0-41Sm;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 35/35] take freeing of emptied mnt_namespace to namespace_unlock()
Date: Mon, 23 Jun 2025 05:54:28 +0100
Message-ID: <20250623045428.1271612-35-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
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
index 4ea72ecd2621..b8abac07b794 100644
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
@@ -3658,13 +3662,6 @@ static int do_move_mount(struct path *old_path,
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
 
@@ -6159,11 +6156,11 @@ void put_mnt_ns(struct mnt_namespace *ns)
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


