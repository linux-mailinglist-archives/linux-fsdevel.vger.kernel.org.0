Return-Path: <linux-fsdevel+bounces-59589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64CB3AE40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FAF680E6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15E2FFDFB;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tCkQtR2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B02F3C14
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422500; cv=none; b=b8KwY6JRGhsfw8e91DTjZTIeMPX1OhNx1aQMY0U+3u8H8U4vLVJOMARSYSWzghzX7UcvYVCHa2kOQvydsD42xtPc3KqscAZ93B+6DiT0b+lpnwsbX8Yz6aURdWZpOBWU1lmrDAcOey/iiQO9tBMOtpjnv+MV9nmyO7EHiKKBVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422500; c=relaxed/simple;
	bh=8/l4JwXkSjTC7BOIM0FkLGlnc8+giPU01v3ise1ohsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8v4/wcUZQKMEXRsbxZl0ksZxkPI3iVMUgyGJ3BIf4/YNFIG/B1YCe4JjadL0P08J8JMcuL37bhV63ZzLEBjXFGUT0Ohws1+KCLSpptHKHSguR3EANrwFAzF3Ge8CxyrRVvGXVqgstiZzh40REqXFgya4x5Y+xCZidnllHRuGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tCkQtR2X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J+l/SpDLZDystaHAz90DPjsTisj3cEwbPmLPrZ80Ack=; b=tCkQtR2XqhqqPcFb3PnRsFhkKO
	5OTVxoeFvel+Ewy0aB6dATekXbnR2Cfb4fkLqmgYMIhWOzrWkc6LWJaflo7bJE+ey0g5zX3DVnkcc
	xw/BmhCnkCwtDwEy4GWrhfrUM+MBUWUMS1SGqevlq5ESPreVC9rvj/7nBA7qD/mRh3e+DB4Vfebwq
	0GEdIQrjpaVRxy91l1s913YPmHrVpZ7GlqtreMbt80QhTcquywHsuKPj1kKdkovR6o5JwbADwl8u1
	NcfAD56dhThAJNRc5nQhZXJaqh6r4vUFzymV9+Iya8QHhPJf1zGBgC1qJY+ieGnAZ1BzYWcZTiiLs
	6uFWJ1aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj6-0000000F2Bd-0Zjn;
	Thu, 28 Aug 2025 23:08:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 61/63] struct mount: relocate MNT_WRITE_HOLD bit
Date: Fri, 29 Aug 2025 00:08:04 +0100
Message-ID: <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
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

... from ->mnt_flags to LSB of ->mnt_pprev_for_sb.

This is safe - we always set and clear it within the same mount_lock
scope, so we won't interfere with list operations - traversals are
always forward, so they don't even look at ->mnt_prev_for_sb and
both insertions and removals are in mount_lock scopes of their own,
so that bit will be clear in *all* mount instances during those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h            |  3 ++-
 fs/namespace.c        | 50 +++++++++++++++++++++----------------------
 include/linux/fs.h    |  4 +---
 include/linux/mount.h |  3 +--
 4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 5c2ddcff810c..c13bbd93d837 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -65,7 +65,8 @@ struct mount {
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct mount *mnt_next_for_sb;	/* the next two fields are hlist_node, */
-	struct mount **mnt_pprev_for_sb;/* except that LSB of pprev will be stolen */
+	unsigned long mnt_pprev_for_sb;	/* except that LSB of pprev is stolen */
+#define WRITE_HOLD 1			/* ... for use by mnt_hold_writers() */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
diff --git a/fs/namespace.c b/fs/namespace.c
index 120854639dd2..f9c9c69a815b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -509,20 +509,20 @@ int mnt_get_write_access(struct vfsmount *m)
 	mnt_inc_writers(mnt);
 	/*
 	 * The store to mnt_inc_writers must be visible before we pass
-	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
-	 * incremented count after it has set MNT_WRITE_HOLD.
+	 * WRITE_HOLD loop below, so that the slowpath can see our
+	 * incremented count after it has set WRITE_HOLD.
 	 */
 	smp_mb();
 	might_lock(&mount_lock.lock);
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
+	while (READ_ONCE(mnt->mnt_pprev_for_sb) & WRITE_HOLD) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			cpu_relax();
 		} else {
 			/*
 			 * This prevents priority inversion, if the task
-			 * setting MNT_WRITE_HOLD got preempted on a remote
+			 * setting WRITE_HOLD got preempted on a remote
 			 * CPU, and it prevents life lock if the task setting
-			 * MNT_WRITE_HOLD has a lower priority and is bound to
+			 * WRITE_HOLD has a lower priority and is bound to
 			 * the same CPU as the task that is spinning here.
 			 */
 			preempt_enable();
@@ -533,7 +533,7 @@ int mnt_get_write_access(struct vfsmount *m)
 	}
 	/*
 	 * The barrier pairs with the barrier sb_start_ro_state_change() making
-	 * sure that if we see MNT_WRITE_HOLD cleared, we will also see
+	 * sure that if we see WRITE_HOLD cleared, we will also see
 	 * s_readonly_remount set (or even SB_RDONLY / MNT_READONLY flags) in
 	 * mnt_is_readonly() and bail in case we are racing with remount
 	 * read-only.
@@ -672,15 +672,15 @@ EXPORT_SYMBOL(mnt_drop_write_file);
  * @mnt.
  *
  * Context: This function expects lock_mount_hash() to be held serializing
- *          setting MNT_WRITE_HOLD.
+ *          setting WRITE_HOLD.
  * Return: On success 0 is returned.
  *	   On error, -EBUSY is returned.
  */
 static inline int mnt_hold_writers(struct mount *mnt)
 {
-	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
+	mnt->mnt_pprev_for_sb |= WRITE_HOLD;
 	/*
-	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
+	 * After storing WRITE_HOLD, we'll read the counters. This store
 	 * should be visible before we do.
 	 */
 	smp_mb();
@@ -696,9 +696,9 @@ static inline int mnt_hold_writers(struct mount *mnt)
 	 * sum up each counter, if we read a counter before it is incremented,
 	 * but then read another CPU's count which it has been subsequently
 	 * decremented from -- we would see more decrements than we should.
-	 * MNT_WRITE_HOLD protects against this scenario, because
+	 * WRITE_HOLD protects against this scenario, because
 	 * mnt_want_write first increments count, then smp_mb, then spins on
-	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
+	 * WRITE_HOLD, so it can't be decremented by another CPU while
 	 * we're counting up here.
 	 */
 	if (mnt_get_writers(mnt) > 0)
@@ -722,20 +722,20 @@ static inline int mnt_hold_writers(struct mount *mnt)
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
 	/*
-	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
+	 * MNT_READONLY must become visible before ~WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
 	 */
 	smp_wmb();
-	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	mnt->mnt_pprev_for_sb &= ~WRITE_HOLD;
 }
 
 static inline void mnt_del_instance(struct mount *m)
 {
-	struct mount **p = m->mnt_pprev_for_sb;
+	struct mount **p = (void *)m->mnt_pprev_for_sb;
 	struct mount *next = m->mnt_next_for_sb;
 
 	if (next)
-		next->mnt_pprev_for_sb = p;
+		next->mnt_pprev_for_sb = (unsigned long)p;
 	*p = next;
 }
 
@@ -744,9 +744,9 @@ static inline void mnt_add_instance(struct mount *m, struct super_block *s)
 	struct mount *first = s->s_mounts;
 
 	if (first)
-		first->mnt_pprev_for_sb = &m->mnt_next_for_sb;
+		first->mnt_pprev_for_sb = (unsigned long)&m->mnt_next_for_sb;
 	m->mnt_next_for_sb = first;
-	m->mnt_pprev_for_sb = &s->s_mounts;
+	m->mnt_pprev_for_sb = (unsigned long)&s->s_mounts;
 	s->s_mounts = m;
 }
 
@@ -765,7 +765,7 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 {
 	int err = 0;
 
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under WRITE_HOLD */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
@@ -783,8 +783,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (!err)
 		sb_start_ro_state_change(sb);
 	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
-			m->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+		if (m->mnt_pprev_for_sb & WRITE_HOLD)
+			m->mnt_pprev_for_sb &= ~WRITE_HOLD;
 	}
 	unlock_mount_hash();
 
@@ -4805,18 +4805,18 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 		struct mount *p;
 
 		/*
-		 * If we had to call mnt_hold_writers() MNT_WRITE_HOLD will
-		 * be set in @mnt_flags. The loop unsets MNT_WRITE_HOLD for all
+		 * If we had to call mnt_hold_writers() WRITE_HOLD will
+		 * be set in @mnt_flags. The loop unsets WRITE_HOLD for all
 		 * mounts and needs to take care to include the first mount.
 		 */
 		for (p = mnt; p; p = next_mnt(p, mnt)) {
 			/* If we had to hold writers unblock them. */
-			if (p->mnt.mnt_flags & MNT_WRITE_HOLD)
+			if (p->mnt_pprev_for_sb & WRITE_HOLD)
 				mnt_unhold_writers(p);
 
 			/*
 			 * We're done once the first mount we changed got
-			 * MNT_WRITE_HOLD unset.
+			 * WRITE_HOLD unset.
 			 */
 			if (p == m)
 				break;
@@ -4851,7 +4851,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 		WRITE_ONCE(m->mnt.mnt_flags, flags);
 
 		/* If we had to hold writers unblock them. */
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
+		if (mnt->mnt_pprev_for_sb & WRITE_HOLD)
 			mnt_unhold_writers(m);
 
 		if (kattr->propagation)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0e9c7f1460dc..1d583f38fb81 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1324,8 +1324,6 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
-struct mount;
-
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1360,7 +1358,7 @@ struct super_block {
 	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
-	struct mount		*s_mounts;	/* list of mounts; _not_ for fs use */
+	void			*s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
 	struct file		*s_bdev_file;
 	struct backing_dev_info *s_bdi;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 18e4b97f8a98..85e97b9340ff 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -33,7 +33,6 @@ enum mount_flags {
 	MNT_NOSYMFOLLOW	= 0x80,
 
 	MNT_SHRINKABLE	= 0x100,
-	MNT_WRITE_HOLD	= 0x200,
 
 	MNT_INTERNAL	= 0x4000,
 
@@ -52,7 +51,7 @@ enum mount_flags {
 				  | MNT_READONLY | MNT_NOSYMFOLLOW,
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
-	MNT_INTERNAL_FLAGS = MNT_WRITE_HOLD | MNT_INTERNAL | MNT_DOOMED |
+	MNT_INTERNAL_FLAGS = MNT_INTERNAL | MNT_DOOMED |
 			     MNT_SYNC_UMOUNT | MNT_LOCKED
 };
 
-- 
2.47.2


