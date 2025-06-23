Return-Path: <linux-fsdevel+bounces-52469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FC9AE348B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E67D3B0432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D361D5CE5;
	Mon, 23 Jun 2025 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Vi9LTzFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4C1E1DFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654481; cv=none; b=iEEibgr7QjlfBNX9C6z8ljtkRWqknEKIfv9AHIm3K/L5tDLxIpmcfP+8NCLgJWbQBRncn7oWGclfWy6TOcIkdFvg9BG5IIAXppCZSmwVXo6PN6qcTfFr7xzvj+CMDY+Wz6OQYFbUBs+rxbHN6wX1i/AgL24OOiFYqvLW+Ome1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654481; c=relaxed/simple;
	bh=JuRMZyB3O+GP8WUS1sJqqot+FR0zEWZVxKntOwipv2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVfFkGO3sZ3rHhZyHwiZ7HkJUkQfvZYQASjhfi5hgPvx5mQCoAvhpRF7lUeWx6VtJT/mHJXKkH8bft6FmVEtyy+yDGs2lpHEMkhZ1IP8ZdD/QGLtDB6jdK6rZeaVVMxePadIambXbQ1EKBhgThQ8az9tNXgFwqBGkVAadvgUL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Vi9LTzFD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pakxFPGlO3rrwcQLmTs8/oaJA1XZ2IplT0t+0kQ5Fls=; b=Vi9LTzFDL61qAkzJPvYeYYU0be
	1LBaYf9jJwcNquWTVsPJuGpRXCVTKxjkAoScTf794BXgiqfwD0Uz7Bm2xLF/NI/gK1q0VIZBKMLEK
	V++1WhAr2GMNW0Rxn/kluxIpQWooGWnBMFZjAncQHlXCykXVt8dOJbPUUQ9CcRut0DwCweznqc+m3
	xUbA6Rq97OP1EljzAVuj81LYsmSEstJ/RhGDSJTpDfosIYg6wKjrFboObm5VdJSiSXQELa0nriSTp
	sKWN1Ufd4jVb925fbzgog80GHCNL7yM9XM6L7USuk24QQUxAW/2k/w0HOfzL6MVYcv/tsPmVZYifi
	7hETGgpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005KuU-2pIw;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 32/35] mount: separate the flags accessed only under namespace_sem
Date: Mon, 23 Jun 2025 05:54:25 +0100
Message-ID: <20250623045428.1271612-32-viro@zeniv.linux.org.uk>
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

Several flags are updated and checked only under namespace_sem; we are
already making use of that when we are checking them without mount_lock,
but we have to hold mount_lock for all updates, which makes things
clumsier than they have to be.

Take MNT_SHARED, MNT_UNBINDABLE, MNT_MARKED and MNT_UMOUNT_CANDIDATE
into a separate field (->mnt_t_flags), renaming them to T_SHARED,
etc. to avoid confusion.  All accesses must be under namespace_sem.

That changes locking requirements for mnt_change_propagation() and
set_mnt_shared() - only namespace_sem is needed now.  The same goes
for SET_MNT_MARKED et.al.

There might be more flags moved from ->mnt_flags to that field;
this is just the initial set.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../filesystems/propagate_umount.txt          | 12 +++++-----
 fs/mount.h                                    | 17 ++++++++++++++
 fs/namespace.c                                |  4 ----
 fs/pnode.c                                    | 22 +++++++++----------
 fs/pnode.h                                    | 19 +++++++++-------
 include/linux/mount.h                         | 18 ++-------------
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/Documentation/filesystems/propagate_umount.txt b/Documentation/filesystems/propagate_umount.txt
index 5b48540b4059..d665144e9e6e 100644
--- a/Documentation/filesystems/propagate_umount.txt
+++ b/Documentation/filesystems/propagate_umount.txt
@@ -453,11 +453,11 @@ original set.
 So let's go for
 	* original set ("set").  Linkage via mnt_list
 	* undecided candidates ("candidates").  Subset of a list,
-consisting of all its elements marked with a new flag (MNT_UMOUNT_CANDIDATE).
+consisting of all its elements marked with a new flag (T_UMOUNT_CANDIDATE).
 Initially all elements of the list will be marked that way; in the
 end the list will become empty and no mounts will remain marked with
 that flag.
-	* Reuse MNT_MARKED for "has been already seen by trim_ancestors()".
+	* Reuse T_MARKED for "has been already seen by trim_ancestors()".
 	* anything in U that hadn't been in the original set - elements of
 candidates will gradually be either discarded or moved there.  In other
 words, it's the candidates we have already decided to unmount.	Its role
@@ -465,13 +465,13 @@ is reasonably close to the old "to_umount", so let's use that name.
 Linkage via mnt_list.
 
 For gather_candidates() we'll need to maintain both candidates (S -
-set) and intersection of S with set.  Use MNT_UMOUNT_CANDIDATE for
+set) and intersection of S with set.  Use T_UMOUNT_CANDIDATE for
 all elements we encounter, putting the ones not already in the original
 set into the list of candidates.  When we are done, strip that flag from
 all elements of the original set.  That gives a cheap way to check
 if element belongs to S (in gather_candidates) and to candidates
 itself (at later stages).  Call that predicate is_candidate(); it would
-be m->mnt_flags & MNT_UMOUNT_CANDIDATE.
+be m->mnt_t_flags & T_UMOUNT_CANDIDATE.
 
 All elements of the original set are marked with MNT_UMOUNT and we'll
 need the same for elements added when joining the contents of to_umount
@@ -480,5 +480,5 @@ to to_umount; that's close to what the old 'umount_one' is doing, so
 let's keep that name.  It also gives us another predicate we need -
 "belongs to union of set and to_umount"; will_be_unmounted() for now.
 
-Removals from the candidates list should strip both MNT_MARKED and
-MNT_UMOUNT_CANDIDATE; call it remove_from_candidates_list().
+Removals from the candidates list should strip both T_MARKED and
+T_UMOUNT_CANDIDATE; call it remove_from_candidates_list().
diff --git a/fs/mount.h b/fs/mount.h
index c5b170b6cb3c..250e84c0f2ce 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -84,6 +84,7 @@ struct mount {
 	struct list_head to_notify;	/* need to queue notification */
 	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
+	int mnt_t_flags;		/* namespace_sem-protected flags */
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
 	int mnt_group_id;		/* peer group identifier */
@@ -93,6 +94,22 @@ struct mount {
 	struct mount *overmount;	/* mounted on ->mnt_root */
 } __randomize_layout;
 
+enum {
+	T_SHARED		= 1, /* mount is shared */
+	T_UNBINDABLE		= 2, /* mount is unbindable */
+	T_MARKED		= 4, /* internal mark for propagate_... */
+	T_UMOUNT_CANDIDATE	= 8, /* for propagate_umount */
+
+	/*
+	 * T_SHARED_MASK is the set of flags that should be cleared when a
+	 * mount becomes shared.  Currently, this is only the flag that says a
+	 * mount cannot be bind mounted, since this is how we create a mount
+	 * that shares events with another mount.  If you add a new T_*
+	 * flag, consider how it interacts with shared mounts.
+	 */
+	T_SHARED_MASK	= T_UNBINDABLE,
+};
+
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
 
 static inline struct mount *real_mount(struct vfsmount *mnt)
diff --git a/fs/namespace.c b/fs/namespace.c
index 5556c5edbae9..4ea72ecd2621 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2905,10 +2905,8 @@ static int do_change_type(struct path *path, int ms_flags)
 			goto out_unlock;
 	}
 
-	lock_mount_hash();
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 		change_mnt_propagation(m, type);
-	unlock_mount_hash();
 
  out_unlock:
 	namespace_unlock();
@@ -3397,9 +3395,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 	if (IS_MNT_SHARED(from)) {
 		to->mnt_group_id = from->mnt_group_id;
 		list_add(&to->mnt_share, &from->mnt_share);
-		lock_mount_hash();
 		set_mnt_shared(to);
-		unlock_mount_hash();
 	}
 
 	err = 0;
diff --git a/fs/pnode.c b/fs/pnode.c
index f897a501bee7..0ae14f7f754f 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -112,7 +112,7 @@ static int do_make_slave(struct mount *mnt)
 }
 
 /*
- * vfsmount lock must be held for write
+ * EXCL[namespace_sem]
  */
 void change_mnt_propagation(struct mount *mnt, int type)
 {
@@ -125,9 +125,9 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		list_del_init(&mnt->mnt_slave);
 		mnt->mnt_master = NULL;
 		if (type == MS_UNBINDABLE)
-			mnt->mnt.mnt_flags |= MNT_UNBINDABLE;
+			mnt->mnt_t_flags |= T_UNBINDABLE;
 		else
-			mnt->mnt.mnt_flags &= ~MNT_UNBINDABLE;
+			mnt->mnt_t_flags &= ~T_UNBINDABLE;
 	}
 }
 
@@ -263,9 +263,9 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 		return PTR_ERR(child);
 	read_seqlock_excl(&mount_lock);
 	mnt_set_mountpoint(m, dest_mp, child);
+	read_sequnlock_excl(&mount_lock);
 	if (m->mnt_master != dest_master)
 		SET_MNT_MARK(m->mnt_master);
-	read_sequnlock_excl(&mount_lock);
 	last_dest = m;
 	last_source = child;
 	hlist_add_head(&child->mnt_hash, list);
@@ -322,13 +322,11 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		} while (n != m);
 	}
 out:
-	read_seqlock_excl(&mount_lock);
 	hlist_for_each_entry(n, tree_list, mnt_hash) {
 		m = n->mnt_parent;
 		if (m->mnt_master != dest_mnt->mnt_master)
 			CLEAR_MNT_MARK(m->mnt_master);
 	}
-	read_sequnlock_excl(&mount_lock);
 	return ret;
 }
 
@@ -447,7 +445,7 @@ void propagate_mount_unlock(struct mount *mnt)
 
 static inline bool is_candidate(struct mount *m)
 {
-	return m->mnt.mnt_flags & MNT_UMOUNT_CANDIDATE;
+	return m->mnt_t_flags & T_UMOUNT_CANDIDATE;
 }
 
 static inline bool will_be_unmounted(struct mount *m)
@@ -465,7 +463,7 @@ static void umount_one(struct mount *m, struct list_head *to_umount)
 
 static void remove_from_candidate_list(struct mount *m)
 {
-	m->mnt.mnt_flags &= ~(MNT_MARKED | MNT_UMOUNT_CANDIDATE);
+	m->mnt_t_flags &= ~(T_MARKED | T_UMOUNT_CANDIDATE);
 	list_del_init(&m->mnt_list);
 }
 
@@ -477,7 +475,7 @@ static void gather_candidates(struct list_head *set,
 	list_for_each_entry(m, set, mnt_list) {
 		if (is_candidate(m))
 			continue;
-		m->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
+		m->mnt_t_flags |= T_UMOUNT_CANDIDATE;
 		p = m->mnt_parent;
 		q = propagation_next(p, p);
 		while (q) {
@@ -495,7 +493,7 @@ static void gather_candidates(struct list_head *set,
 					q = skip_propagation_subtree(q, p);
 					continue;
 				}
-				child->mnt.mnt_flags |= MNT_UMOUNT_CANDIDATE;
+				child->mnt_t_flags |= T_UMOUNT_CANDIDATE;
 				if (!will_be_unmounted(child))
 					list_add(&child->mnt_list, candidates);
 			}
@@ -503,7 +501,7 @@ static void gather_candidates(struct list_head *set,
 		}
 	}
 	list_for_each_entry(m, set, mnt_list)
-		m->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
+		m->mnt_t_flags &= ~T_UMOUNT_CANDIDATE;
 }
 
 /*
@@ -520,7 +518,7 @@ static void trim_ancestors(struct mount *m)
 			return;
 		SET_MNT_MARK(m);
 		if (m->mnt_mountpoint != p->mnt.mnt_root)
-			p->mnt.mnt_flags &= ~MNT_UMOUNT_CANDIDATE;
+			p->mnt_t_flags &= ~T_UMOUNT_CANDIDATE;
 	}
 }
 
diff --git a/fs/pnode.h b/fs/pnode.h
index 04f1ac53aa49..507e30e7a420 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -10,14 +10,14 @@
 #include <linux/list.h>
 #include "mount.h"
 
-#define IS_MNT_SHARED(m) ((m)->mnt.mnt_flags & MNT_SHARED)
+#define IS_MNT_SHARED(m) ((m)->mnt_t_flags & T_SHARED)
 #define IS_MNT_SLAVE(m) ((m)->mnt_master)
 #define IS_MNT_NEW(m) (!(m)->mnt_ns)
-#define CLEAR_MNT_SHARED(m) ((m)->mnt.mnt_flags &= ~MNT_SHARED)
-#define IS_MNT_UNBINDABLE(m) ((m)->mnt.mnt_flags & MNT_UNBINDABLE)
-#define IS_MNT_MARKED(m) ((m)->mnt.mnt_flags & MNT_MARKED)
-#define SET_MNT_MARK(m) ((m)->mnt.mnt_flags |= MNT_MARKED)
-#define CLEAR_MNT_MARK(m) ((m)->mnt.mnt_flags &= ~MNT_MARKED)
+#define CLEAR_MNT_SHARED(m) ((m)->mnt_t_flags &= ~T_SHARED)
+#define IS_MNT_UNBINDABLE(m) ((m)->mnt_t_flags & T_UNBINDABLE)
+#define IS_MNT_MARKED(m) ((m)->mnt_t_flags & T_MARKED)
+#define SET_MNT_MARK(m) ((m)->mnt_t_flags |= T_MARKED)
+#define CLEAR_MNT_MARK(m) ((m)->mnt_t_flags &= ~T_MARKED)
 #define IS_MNT_LOCKED(m) ((m)->mnt.mnt_flags & MNT_LOCKED)
 
 #define CL_EXPIRE    		0x01
@@ -28,10 +28,13 @@
 #define CL_SHARED_TO_SLAVE	0x20
 #define CL_COPY_MNT_NS_FILE	0x40
 
+/*
+ * EXCL[namespace_sem]
+ */
 static inline void set_mnt_shared(struct mount *mnt)
 {
-	mnt->mnt.mnt_flags &= ~MNT_SHARED_MASK;
-	mnt->mnt.mnt_flags |= MNT_SHARED;
+	mnt->mnt_t_flags &= ~T_SHARED_MASK;
+	mnt->mnt_t_flags |= T_SHARED;
 }
 
 static inline bool peers(const struct mount *m1, const struct mount *m2)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 65fa8442c00a..5f9c053b0897 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -35,12 +35,8 @@ enum mount_flags {
 	MNT_SHRINKABLE	= 0x100,
 	MNT_WRITE_HOLD	= 0x200,
 
-	MNT_SHARED	= 0x1000, /* if the vfsmount is a shared mount */
-	MNT_UNBINDABLE	= 0x2000, /* if the vfsmount is a unbindable mount */
-
 	MNT_INTERNAL	= 0x4000,
 
-	MNT_UMOUNT_CANDIDATE	= 0x020000,
 	MNT_LOCK_ATIME		= 0x040000,
 	MNT_LOCK_NOEXEC		= 0x080000,
 	MNT_LOCK_NOSUID		= 0x100000,
@@ -49,25 +45,15 @@ enum mount_flags {
 	MNT_LOCKED		= 0x800000,
 	MNT_DOOMED		= 0x1000000,
 	MNT_SYNC_UMOUNT		= 0x2000000,
-	MNT_MARKED		= 0x4000000,
 	MNT_UMOUNT		= 0x8000000,
 
-	/*
-	 * MNT_SHARED_MASK is the set of flags that should be cleared when a
-	 * mount becomes shared.  Currently, this is only the flag that says a
-	 * mount cannot be bind mounted, since this is how we create a mount
-	 * that shares events with another mount.  If you add a new MNT_*
-	 * flag, consider how it interacts with shared mounts.
-	 */
-	MNT_SHARED_MASK	= MNT_UNBINDABLE,
 	MNT_USER_SETTABLE_MASK  = MNT_NOSUID | MNT_NODEV | MNT_NOEXEC
 				  | MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME
 				  | MNT_READONLY | MNT_NOSYMFOLLOW,
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
-	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |
-			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED |
-			     MNT_LOCKED | MNT_UMOUNT_CANDIDATE,
+	MNT_INTERNAL_FLAGS = MNT_WRITE_HOLD | MNT_INTERNAL | MNT_DOOMED |
+			     MNT_SYNC_UMOUNT | MNT_LOCKED
 };
 
 struct vfsmount {
-- 
2.39.5


