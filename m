Return-Path: <linux-fsdevel+bounces-59613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF4B3B2F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE181C22C54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED42224B09;
	Fri, 29 Aug 2025 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U2rwOL3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1121CFFA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447628; cv=none; b=APPuSItJe8VzPZF79XJslci0zFhofzzVRTV3nKRamc095BtkcadsokBwAcnB8zs6DLszkACJYHxKan0cT8fb/9LTLDMz/TblJUxFP9rTqMMVYD1rFdNGgQTCOyOj9Y5mWkrtiM1QWvogKGDW21VTiN/3T12kiipkRsizZrXIKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447628; c=relaxed/simple;
	bh=z5Xf9Ide3dDY9cJ+0Ioo+BH3/9KpxOzcHUPHrWhuzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgBIFCsnplzaDXOYIbMnYaQlFKKRk3rqTvNSiZ61Sc6fOJsBNpimFa8xT/qkoF6AnDooUU1WhQz0fv2DleHKObmAgnG7Xz8Yc1P9j/sF0MGcppSWZn8PgUCMpQgaHmcrCbYXpnfVzR7N1L6bEc3tHQuu6S1k7FvnCrbX+ELcysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U2rwOL3u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tm4vlK1FyfR97ym1H3KOSwQYYe6YAui0szvnrs5GcLk=; b=U2rwOL3uMk5ozU3PiXzGKlaWiF
	1LWORpRkH0upP7sMeCrD6LkSUZYeSAQ1jaoQNwTQv0qBoWLV0eENLTFCPksgnNJDy6G6nOolNv/5w
	aiWVI5SWIWF+QNlqjuj2bg0Otq4rpBNqG6MGDnsFsRaAJk6cjactC5y4rntvgqZmGfA6/2St/cdPR
	vrOpCXxRhf74QG8HyRNvs8dfKTlq9BIc4TAKn8MRWiGPaL9vR+wvj4wAz+8BkKaeV7XWftqB5Ub4w
	OGYtPWOh0bLbT8NGzBUXiexF43wxNAEOgZM340vhgoHrcxnzGk3uNAG+1xH8j6XZcOp7P89LGBc/o
	NkbEqkAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ursGP-00000002pEl-2KSF;
	Fri, 29 Aug 2025 06:07:05 +0000
Date: Fri, 29 Aug 2025 07:07:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: [62/63] struct mount: relocate MNT_WRITE_HOLD bit
Message-ID: <20250829060705.GD659926@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829060306.GC39973@ZenIV>
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


