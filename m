Return-Path: <linux-fsdevel+bounces-60115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CA3B41408
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1871D541BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936932DE718;
	Wed,  3 Sep 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ncfsFmzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3A2D8764
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875359; cv=none; b=eTmvQr5A0ZZvHk8DDNBnsJhsAMxQuQ+PAkmKGeal7i7mmCA6LxPgrRyWSj+tTdyS6q2CkIjPJFbfOE09HuFqJX8oC4x9GLLBBf8YNB4gkDEBsOQ+XtrivboesfjAukdvzQ7D95AP5k6OUofPqhSzOLQGSDuj8OWeah/ujV1nWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875359; c=relaxed/simple;
	bh=z5Xf9Ide3dDY9cJ+0Ioo+BH3/9KpxOzcHUPHrWhuzjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROPS0N+bJxVEaul0CDk2k0Oj4A/0WfAJCeZiC/iahsj/Z4YBsq5Qk2NOqrNiVJDXtNHNnJt6iM9a2muqSKtCVtAEEp0VvAjnFG7Uo66moqzmm++yzM64pWEmrmR6idNxnQlVe2uEOctRtrniznIGS01PGi1UZjVJqYMCDh8gaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ncfsFmzm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tm4vlK1FyfR97ym1H3KOSwQYYe6YAui0szvnrs5GcLk=; b=ncfsFmzmnA2X+/vYAJnQOipjQw
	Q2Wlx1bmdVu77M7rpxU01XLycGvQQPqNv+IiCDJ5xKVSN67p2D8uIKSucyMPrf0RKGlyVAsxsgk+H
	9O+8dr+hoxRxoPtz9yUXHbxZponeSNxw/G3dkdw9McqFbdfaRiXdcsNjiH70r09oU+MxqUp5muZD0
	Fcq8IyG6RAS8nLyo52HEiTtCiDv3hr2/M0EpxLw3I2yQVVAVoWPFfeOqT+gPoSzbLF6s/47XBt5uZ
	GeEVBzM0ZLf+ltKLoyDXt8yfcYBulj6W/gRHf3aKmdOILmheSKjHpHuDPXIJ1nSCmZMGncL9GZsAb
	zgvY3qQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXH-0000000ApMc-3tvE;
	Wed, 03 Sep 2025 04:55:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 62/63] struct mount: relocate MNT_WRITE_HOLD bit
Date: Wed,  3 Sep 2025 05:55:33 +0100
Message-ID: <20250903045537.2579614-72-viro@zeniv.linux.org.uk>
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

... from ->mnt_flags to LSB of ->mnt_pprev_for_sb.

This is safe - we always set and clear it within the same mount_lock
scope, so we won't interfere with list operations - traversals are
always forward, so they don't even look at ->mnt_prev_for_sb and
both insertions and removals are in mount_lock scopes of their own,
so that bit will be clear in *all* mount instances during those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h            | 25 ++++++++++++++++++++++++-
 fs/namespace.c        | 34 +++++++++++++++++-----------------
 include/linux/mount.h |  3 +--
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index b208f69f69d7..40cf16544317 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -66,7 +66,8 @@ struct mount {
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct mount *mnt_next_for_sb;	/* the next two fields are hlist_node, */
 	struct mount * __aligned(1) *mnt_pprev_for_sb;
-					/* except that LSB of pprev will be stolen */
+					/* except that LSB of pprev is stolen */
+#define WRITE_HOLD 1			/* ... for use by mnt_hold_writers() */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
@@ -244,4 +245,26 @@ static inline struct mount *topmost_overmount(struct mount *m)
 	return m;
 }
 
+static inline bool __test_write_hold(struct mount * __aligned(1) *val)
+{
+	return (unsigned long)val & WRITE_HOLD;
+}
+
+static inline bool test_write_hold(const struct mount *m)
+{
+	return __test_write_hold(m->mnt_pprev_for_sb);
+}
+
+static inline void set_write_hold(struct mount *m)
+{
+	m->mnt_pprev_for_sb = (void *)((unsigned long)m->mnt_pprev_for_sb
+				       | WRITE_HOLD);
+}
+
+static inline void clear_write_hold(struct mount *m)
+{
+	m->mnt_pprev_for_sb = (void *)((unsigned long)m->mnt_pprev_for_sb
+				       & ~WRITE_HOLD);
+}
+
 struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 06be5b65b559..8e6b6523d3e8 100644
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
+	while (__test_write_hold(READ_ONCE(mnt->mnt_pprev_for_sb))) {
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
+	set_write_hold(mnt);
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
@@ -720,14 +720,14 @@ static inline int mnt_hold_writers(struct mount *mnt)
  */
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
-	if (!(mnt->mnt_flags & MNT_WRITE_HOLD))
+	if (!test_write_hold(mnt))
 		return;
 	/*
-	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
+	 * MNT_READONLY must become visible before ~WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
 	 */
 	smp_wmb();
-	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	clear_write_hold(mnt);
 }
 
 static inline void mnt_del_instance(struct mount *m)
@@ -766,7 +766,7 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 {
 	int err = 0;
 
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under WRITE_HOLD */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
@@ -784,8 +784,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (!err)
 		sb_start_ro_state_change(sb);
 	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
-			m->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+		if (test_write_hold(m))
+			clear_write_hold(m);
 	}
 	unlock_mount_hash();
 
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


