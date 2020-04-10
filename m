Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA81A422D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgDJFF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 01:05:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJFF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:05:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so1019718wrt.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SoWAu2ozQGHpQvd1yn/GZrXzWg4gYu7ocZEk3Eq2swM=;
        b=eP2ybW8sudY3xF5UVj2bp/BXUf6tDTjDei0BUGCGlHkSK4vUIKNf1kjMeuBHOV7LqP
         +0et0fusfQZyszp3zOyWLFtTLsy+OMr1LvVc9CnQc0potBikktYll4eV2uErS5FfBNak
         csE2uaP8yEymA9I/+nUwnbiQuwQC33Hdyc2xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SoWAu2ozQGHpQvd1yn/GZrXzWg4gYu7ocZEk3Eq2swM=;
        b=PFMBZ5BxxeLKUp98MEdxlyBsCC2+ZZEd6fdVQSxLqXbl4FLWnYmzOmaZFynJ64BFF9
         w9BWd9Apc7vNJ/SGfHGE/9rgld+pEvwIR7WepNI0S5P/JRwA/Qcc40bFCgb2gMxyXimR
         NRl3TkvoGsDIwn8xQTjBQFrKQaIpGU6xpabSda+M0CfBPVqhRTxE8ymUS0dGyRFArrbn
         JQKEcJi2Azcr88xRumdC5McuJfDVIGe5rrtot6lQS5/Im443uAl7Q25iua3n6nZxx/uO
         dD8EeiRZpVWMFlpaH3qaT591nZDHoJf5oyhCiQG9jp/djhioITl/8Ilv3ca+CUJkSRKZ
         FwMA==
X-Gm-Message-State: AGi0Pub8pzze/mAX62FEJ+PnSyVOlqpXIxwqn82q6VdTyrH2jwEaeju8
        5W/O8VnnPiffWKnJ+S97fdUnag==
X-Google-Smtp-Source: APiQypKS5Jk91WOR8l/P+LxMptmZJI8AN2cp8z7Ki3JxgPfSjjnGOCnep0U/znrwIjlGYO/dSGi4wA==
X-Received: by 2002:adf:ab17:: with SMTP id q23mr2623355wrc.248.1586495124554;
        Thu, 09 Apr 2020 22:05:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id r5sm1309588wmr.15.2020.04.09.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 22:05:23 -0700 (PDT)
Date:   Fri, 10 Apr 2020 07:05:22 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4] proc/mounts: add cursor
Message-ID: <20200410050522.GI28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

If mounts are deleted after a read(2) call on /proc/self/mounts (or its
kin), the subsequent read(2) could miss a mount that comes after the
deleted one in the list.  This is because the file position is interpreted
as the number mount entries from the start of the list.

E.g. first read gets entries #0 to #9; the seq file index will be 10.  Then
entry #5 is deleted, resulting in #10 becoming #9 and #11 becoming #10,
etc...  The next read will continue from entry #10, and #9 is missed.

Solve this by adding a cursor entry for each open instance.  Taking the
global namespace_sem for write seems excessive, since we are only dealing
with a per-namespace list.  Instead add a per-namespace spinlock and use
that together with namespace_sem taken for read to protect against
concurrent modification of the mount list.  This may reduce parallelism of
is_local_mountpoint(), but it's hardly a big contention point.  We could
also use RCU freeing of cursors to make traversal not need additional
locks, if that turns out to be neceesary.

Reported-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h            |   12 +++++-
 fs/namespace.c        |   88 ++++++++++++++++++++++++++++++++++++++++----------
 fs/proc_namespace.c   |    4 +-
 include/linux/mount.h |    4 +-
 4 files changed, 86 insertions(+), 22 deletions(-)

Differences from v3:
 - no need to lock in case of starting from EOF
 - no need to move cursor in m_start

Differences from v2:
 - only update cursor in m_stop: a lot less cachline invalidations
 - remove cursor when at EOF, this means no cursors on the list when not
   actively reading the file

Differences from v1:
 - removed unnecessary code that wanted to handle lseeks
 - fixed double entry at the start of a read

--- a/fs/mount.h
+++ b/fs/mount.h
@@ -9,7 +9,13 @@ struct mnt_namespace {
 	atomic_t		count;
 	struct ns_common	ns;
 	struct mount *	root;
+	/*
+	 * Traversal and modification of .list is protected by either
+	 * - taking namespace_sem for write, OR
+	 * - taking namespace_sem for read AND taking .ns_lock.
+	 */
 	struct list_head	list;
+	spinlock_t		ns_lock;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	u64			seq;	/* Sequence number to prevent loops */
@@ -133,9 +139,7 @@ struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
 	int (*show)(struct seq_file *, struct vfsmount *);
-	void *cached_mount;
-	u64 cached_event;
-	loff_t cached_index;
+	struct mount cursor;
 };
 
 extern const struct seq_operations mounts_op;
@@ -153,3 +157,5 @@ static inline bool is_anon_ns(struct mnt
 {
 	return ns->seq == 0;
 }
+
+extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -648,6 +648,30 @@ struct vfsmount *lookup_mnt(const struct
 	return m;
 }
 
+static inline void lock_ns_list(struct mnt_namespace *ns)
+{
+	spin_lock(&ns->ns_lock);
+}
+
+static inline void unlock_ns_list(struct mnt_namespace *ns)
+{
+	spin_unlock(&ns->ns_lock);
+}
+
+static inline bool mnt_is_cursor(struct mount *mnt)
+{
+	return mnt->mnt.mnt_flags & MNT_CURSOR;
+}
+
+static struct mount *mnt_skip_cursors(struct mnt_namespace *ns,
+				      struct mount *mnt)
+{
+	list_for_each_entry_from(mnt, &ns->list, mnt_list)
+		if (!mnt_is_cursor(mnt))
+			return mnt;
+	return NULL;
+}
+
 /*
  * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
  *                         current mount namespace.
@@ -673,11 +697,15 @@ bool __is_local_mountpoint(struct dentry
 		goto out;
 
 	down_read(&namespace_sem);
+	lock_ns_list(ns);
 	list_for_each_entry(mnt, &ns->list, mnt_list) {
+		if (mnt_is_cursor(mnt))
+			continue;
 		is_covered = (mnt->mnt_mountpoint == dentry);
 		if (is_covered)
 			break;
 	}
+	unlock_ns_list(ns);
 	up_read(&namespace_sem);
 out:
 	return is_covered;
@@ -1249,42 +1277,53 @@ struct vfsmount *mnt_clone_internal(cons
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt = &p->cursor;
 
 	down_read(&namespace_sem);
-	if (p->cached_event == p->ns->event) {
-		void *v = p->cached_mount;
-		if (*pos == p->cached_index)
-			return v;
-		if (*pos == p->cached_index + 1) {
-			v = seq_list_next(v, &p->ns->list, &p->cached_index);
-			return p->cached_mount = v;
-		}
-	}
+	/* read after we'd reached the end? */
+	if (*pos && list_empty(&mnt->mnt_list))
+		return NULL;
+
+	lock_ns_list(p->ns);
+	if (!*pos)
+		mnt = list_first_entry(&p->ns->list, typeof(*mnt), mnt_list);
+	mnt = mnt_skip_cursors(p->ns, mnt);
+	unlock_ns_list(p->ns);
 
-	p->cached_event = p->ns->event;
-	p->cached_mount = seq_list_start(&p->ns->list, *pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	return mnt;
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt = v;
+
+	lock_ns_list(p->ns);
+	mnt = mnt_skip_cursors(p->ns, list_next_entry(mnt, mnt_list));
+	unlock_ns_list(p->ns);
+	++*pos;
 
-	p->cached_mount = seq_list_next(v, &p->ns->list, pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	return mnt;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
+	struct proc_mounts *p = m->private;
+	struct mount *mnt = v;
+
+	lock_ns_list(p->ns);
+	if (mnt)
+		list_move_tail(&p->cursor.mnt_list, &mnt->mnt_list);
+	else
+		list_del_init(&p->cursor.mnt_list);
+	unlock_ns_list(p->ns);
 	up_read(&namespace_sem);
 }
 
 static int m_show(struct seq_file *m, void *v)
 {
 	struct proc_mounts *p = m->private;
-	struct mount *r = list_entry(v, struct mount, mnt_list);
+	struct mount *r = v;
 	return p->show(m, &r->mnt);
 }
 
@@ -1294,6 +1333,15 @@ const struct seq_operations mounts_op =
 	.stop	= m_stop,
 	.show	= m_show,
 };
+
+void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
+{
+	down_read(&namespace_sem);
+	lock_ns_list(ns);
+	list_del(&cursor->mnt_list);
+	unlock_ns_list(ns);
+	up_read(&namespace_sem);
+}
 #endif  /* CONFIG_PROC_FS */
 
 /**
@@ -3202,6 +3250,7 @@ static struct mnt_namespace *alloc_mnt_n
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
+	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3842,10 +3891,14 @@ static bool mnt_already_visible(struct m
 	bool visible = false;
 
 	down_read(&namespace_sem);
+	lock_ns_list(ns);
 	list_for_each_entry(mnt, &ns->list, mnt_list) {
 		struct mount *child;
 		int mnt_flags;
 
+		if (mnt_is_cursor(mnt))
+			continue;
+
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
@@ -3893,6 +3946,7 @@ static bool mnt_already_visible(struct m
 	next:	;
 	}
 found:
+	unlock_ns_list(ns);
 	up_read(&namespace_sem);
 	return visible;
 }
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -279,7 +279,8 @@ static int mounts_open_common(struct ino
 	p->ns = ns;
 	p->root = root;
 	p->show = show;
-	p->cached_event = ~0ULL;
+	INIT_LIST_HEAD(&p->cursor.mnt_list);
+	p->cursor.mnt.mnt_flags = MNT_CURSOR;
 
 	return 0;
 
@@ -296,6 +297,7 @@ static int mounts_release(struct inode *
 	struct seq_file *m = file->private_data;
 	struct proc_mounts *p = m->private;
 	path_put(&p->root);
+	mnt_cursor_del(p->ns, &p->cursor);
 	put_mnt_ns(p->ns);
 	return seq_release_private(inode, file);
 }
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,7 +50,8 @@ struct fs_context;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
+			    MNT_CURSOR)
 
 #define MNT_INTERNAL	0x4000
 
@@ -64,6 +65,7 @@ struct fs_context;
 #define MNT_SYNC_UMOUNT		0x2000000
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
+#define MNT_CURSOR		0x10000000
 
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
