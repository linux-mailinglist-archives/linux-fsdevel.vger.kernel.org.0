Return-Path: <linux-fsdevel+bounces-60114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58DB41407
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C281727FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE22DE70C;
	Wed,  3 Sep 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iKjvvqfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414A2D8395
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875358; cv=none; b=M3dzIWVKzFJr/P8hMP0vc3dgdrBRcSvMkaCGOieeL3QUNqSpKk7jA/v12cQzLTnTKkkt0AFQD5gpapbtEMdyn+kBEEvOHTpqZ6K0qQpwfuQuRihtZWq0x7jS/GRRaanynANg82FHvX+12pabfljTUqLq2vheIEEjUAjKBij6wRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875358; c=relaxed/simple;
	bh=+3JdY3kGlvPvIgyXEr+pZTDLTBBzPHkcUh6urmXiltA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkibD+SDvVu4wSHvXL5p4uwMSo+/Lg7v+V6ll+a3S6u02XnS/M9G/+GZqvjhkqYHzZK1+9sfiK6mMTbc/DGgQ+PT/mdEIIjH14pecCzp+R11M+UJJmA+PaMf5FyFRQyssa85SQIbygjPVDkB0lGXh4Jdpad55NFAZ1p0vYnwd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iKjvvqfw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xj+nxaPGKObBMtZDJXtEMHAAtyfdVp1aaUuyeQowfk4=; b=iKjvvqfw0z1izwCJi/8a3fMis4
	zn1rZo4DWeeVzLYTn9EjlSld1WMFIfMiO2PsxmgkG/ERdTsB4gXmh4J+Ffe82HwaEvm6/s+zWvPqW
	ouyftR/HI06CcTKoFdf+vdlrIbc+HKiSCxnmjWqoAw4+k52LRDeMnL7eznjuwjT2EY+ia9qXmGxcW
	ZKbo0w85QF3hwFpHCb8byPwpR0wBCBR2uvCyHr+GNWW32tSwzUOLTmQWBbq7VmD2t6KaoskEGxTug
	Fnd12Liki7O1hez5nPEi60Ec4w/v2BX/dAaL3mXSoI803MctvNItZl4xONKErqX7xZidh4BnoVKtm
	XC/meK0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXH-0000000ApM3-18LP;
	Wed, 03 Sep 2025 04:55:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 62/65] preparations to taking MNT_WRITE_HOLD out of ->mnt_flags
Date: Wed,  3 Sep 2025 05:55:32 +0100
Message-ID: <20250903045537.2579614-71-viro@zeniv.linux.org.uk>
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

We have an unpleasant wart in accessibility rules for struct mount.  There
are per-superblock lists of mounts, used by sb_prepare_remount_readonly()
to check if any of those is currently claimed for write access and to
block further attempts to get write access on those until we are done.

As soon as it is attached to a filesystem, mount becomes reachable
via that list.  Only sb_prepare_remount_readonly() traverses it and
it only accesses a few members of struct mount.  Unfortunately,
->mnt_flags is one of those and it is modified - MNT_WRITE_HOLD set
and then cleared.  It is done under mount_lock, so from the locking
rules POV everything's fine.

However, it has easily overlooked implications - once mount has been
attached to a filesystem, it has to be treated as globally visible.
In particular, initializing ->mnt_flags *must* be done either prior
to that point or under mount_lock.  All other members are still
private at that point.

Life gets simpler if we move that bit (and that's *all* that can get
touched by access via this list) out of ->mnt_flags.  It's not even
hard to do - currently the list is implemented as list_head one,
anchored in super_block->s_mounts and linked via mount->mnt_instance.

As the first step, switch it to hlist-like open-coded structure -
address of the first mount in the set is stored in ->s_mounts
and ->mnt_instance replaced with ->mnt_next_for_sb and ->mnt_pprev_for_sb -
the former either NULL or pointing to the next mount in set, the
latter - address of either ->s_mounts or ->mnt_next_for_sb in the
previous element of the set.

In the next commit we'll steal the LSB of ->mnt_pprev_for_sb as
replacement for MNT_WRITE_HOLD.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h         |  4 +++-
 fs/namespace.c     | 38 +++++++++++++++++++++++++++++---------
 fs/super.c         |  3 +--
 include/linux/fs.h |  4 +++-
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 04d0eadc4c10..b208f69f69d7 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -64,7 +64,9 @@ struct mount {
 #endif
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
-	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
+	struct mount *mnt_next_for_sb;	/* the next two fields are hlist_node, */
+	struct mount * __aligned(1) *mnt_pprev_for_sb;
+					/* except that LSB of pprev will be stolen */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
diff --git a/fs/namespace.c b/fs/namespace.c
index b7c317c23f69..eb1b557e9f6d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -730,6 +730,27 @@ static inline void mnt_unhold_writers(struct mount *mnt)
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 }
 
+static inline void mnt_del_instance(struct mount *m)
+{
+	struct mount **p = m->mnt_pprev_for_sb;
+	struct mount *next = m->mnt_next_for_sb;
+
+	if (next)
+		next->mnt_pprev_for_sb = p;
+	*p = next;
+}
+
+static inline void mnt_add_instance(struct mount *m, struct super_block *s)
+{
+	struct mount *first = s->s_mounts;
+
+	if (first)
+		first->mnt_pprev_for_sb = &m->mnt_next_for_sb;
+	m->mnt_next_for_sb = first;
+	m->mnt_pprev_for_sb = &s->s_mounts;
+	s->s_mounts = m;
+}
+
 static int mnt_make_readonly(struct mount *mnt)
 {
 	int ret;
@@ -743,7 +764,6 @@ static int mnt_make_readonly(struct mount *mnt)
 
 int sb_prepare_remount_readonly(struct super_block *sb)
 {
-	struct mount *mnt;
 	int err = 0;
 
 	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
@@ -751,9 +771,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 		return -EBUSY;
 
 	lock_mount_hash();
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
-			err = mnt_hold_writers(mnt);
+	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
+		if (!(m->mnt.mnt_flags & MNT_READONLY)) {
+			err = mnt_hold_writers(m);
 			if (err)
 				break;
 		}
@@ -763,9 +783,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 
 	if (!err)
 		sb_start_ro_state_change(sb);
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
+		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
+			m->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	}
 	unlock_mount_hash();
 
@@ -1207,7 +1227,7 @@ static void setup_mnt(struct mount *m, struct dentry *root)
 	m->mnt_parent = m;
 
 	lock_mount_hash();
-	list_add_tail(&m->mnt_instance, &s->s_mounts);
+	mnt_add_instance(m, s);
 	unlock_mount_hash();
 }
 
@@ -1425,7 +1445,7 @@ static void mntput_no_expire(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
-	list_del(&mnt->mnt_instance);
+	mnt_del_instance(mnt);
 	if (unlikely(!list_empty(&mnt->mnt_expire)))
 		list_del(&mnt->mnt_expire);
 
diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..3b0f49e1b817 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -323,7 +323,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	if (!s)
 		return NULL;
 
-	INIT_LIST_HEAD(&s->s_mounts);
 	s->s_user_ns = get_user_ns(user_ns);
 	init_rwsem(&s->s_umount);
 	lockdep_set_class(&s->s_umount, &type->s_umount_key);
@@ -408,7 +407,7 @@ static void __put_super(struct super_block *s)
 		list_del_init(&s->s_list);
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
-		WARN_ON(!list_empty(&s->s_mounts));
+		WARN_ON(s->s_mounts);
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..0e9c7f1460dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1324,6 +1324,8 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+struct mount;
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1358,7 +1360,7 @@ struct super_block {
 	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
-	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
+	struct mount		*s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
 	struct file		*s_bdev_file;
 	struct backing_dev_info *s_bdi;
-- 
2.47.2


