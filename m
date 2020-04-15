Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2C1A98C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895462AbgDOJZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895392AbgDOJZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:25:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEACC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 02:25:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so10247469wmh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=voy/7FRc8KaBEQidYftS2rKPG6soy+IxgcMhpwhr8Ng=;
        b=AyJdn09a4Sh6gNtgZfj8OqC7AJHFYhiScinc7ku61l8tvkvnS5Sqz9BP25ghR716R4
         PL1FT24sPBmFUFt3rJgwfWmTa9nBKYquNfhyHJix/Je3A/d/VP1DdgNmtJijT6Q1iosy
         3f0Gwb3nxcVAaCjjSToS6g0EJSJ3gj8bGHMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=voy/7FRc8KaBEQidYftS2rKPG6soy+IxgcMhpwhr8Ng=;
        b=M1+IEv7BGtD0KcLXwI6+dBJPFM0DDHAx3zsmzLDoaED3v1Gx/AtfCXDqBRFM3J3TYv
         KG9K/ky/QVH6ixXWDXamqvHGvWvATY7PN14KkEK+tOA2xXRkQhtxdQK+T0AftYXyvr8X
         XgPHrUrJAj4sfGYlMk3uOtTnBjv2UUkgW93iaiIkVbV4yGTJuvBTb0Gc/2r8MMDcRlWT
         15kbU0I+FL8PEU8HYQ9ryn1T9rpm15qmJkpwq/Q01MchmxMsnSC02UnL/3tNpxFK/KE6
         71MHNXDKR9ZL4P0G0VSw+cJTqd2K4PqP6rBJq6Obi7XgIbqSOR3jy0SpVtboMmE9Li7F
         WdsQ==
X-Gm-Message-State: AGi0Puabd4BFPVQSqlieHDlkn7OKs93x913YEAajqAHqtX4+2lPqqUKn
        EuB4/oW3/OEKAapX/Jp9hn8/UfvIeYI=
X-Google-Smtp-Source: APiQypLip2KIu6kk7nTeuLMFqT7q62gz7x/7h5mHxclQ1DGoKTm4xNlqAYZDdKoBa6IB5150hYLHGg==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr4302079wme.33.1586942701012;
        Wed, 15 Apr 2020 02:25:01 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j135sm23169639wmj.46.2020.04.15.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:25:00 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:24:57 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5] proc/mounts: add cursor
Message-ID: <20200415092457.GJ28467@miu.piliscsaba.redhat.com>
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

Only move the cursor once for each read (cursor is not added on open) to
minimize cacheline invalidation.  When EOF is reached, the cursor is taken
off the list, in order to prevent an excessive number of cursors due to
inactive open file descriptors.

Reported-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h            |   12 ++++--
 fs/namespace.c        |   91 +++++++++++++++++++++++++++++++++++++++++---------
 fs/proc_namespace.c   |    4 +-
 include/linux/mount.h |    4 +-
 4 files changed, 90 insertions(+), 21 deletions(-)

Differences from v4:
 - move dereferecing .next as well as locking into mnt_skip_cursors()
 - rename this helper to mnt_list_next()
 - move helper inside #ifdef CONFIG_PROC_FS

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
@@ -648,6 +648,21 @@ struct vfsmount *lookup_mnt(const struct
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
 /*
  * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
  *                         current mount namespace.
@@ -673,11 +688,15 @@ bool __is_local_mountpoint(struct dentry
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
@@ -1245,46 +1264,71 @@ struct vfsmount *mnt_clone_internal(cons
 }
 
 #ifdef CONFIG_PROC_FS
+static struct mount *mnt_list_next(struct mnt_namespace *ns,
+				   struct list_head *p)
+{
+	struct mount *mnt, *ret = NULL;
+
+	lock_ns_list(ns);
+	for (p = p->next; p != &ns->list; p = p->next) {
+		mnt = list_entry(p, typeof(*mnt), mnt_list);
+		if (!mnt_is_cursor(mnt)) {
+			ret = mnt;
+			break;
+		}
+	}
+	unlock_ns_list(ns);
+
+	return ret;
+}
+
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct list_head *prev;
 
 	down_read(&namespace_sem);
-	if (p->cached_event == p->ns->event) {
-		void *v = p->cached_mount;
-		if (*pos == p->cached_index)
-			return v;
-		if (*pos == p->cached_index + 1) {
-			v = seq_list_next(v, &p->ns->list, &p->cached_index);
-			return p->cached_mount = v;
-		}
+	if (!*pos) {
+		prev = &p->ns->list;
+	} else {
+		prev = &p->cursor.mnt_list;
+
+		/* Read after we'd reached the end? */
+		if (list_empty(prev))
+			return NULL;
 	}
 
-	p->cached_event = p->ns->event;
-	p->cached_mount = seq_list_start(&p->ns->list, *pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	return mnt_list_next(p->ns, prev);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt = v;
 
-	p->cached_mount = seq_list_next(v, &p->ns->list, pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	++*pos;
+	return mnt_list_next(p->ns, &mnt->mnt_list);
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
 
@@ -1294,6 +1338,15 @@ const struct seq_operations mounts_op =
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
@@ -3202,6 +3255,7 @@ static struct mnt_namespace *alloc_mnt_n
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
+	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3842,10 +3896,14 @@ static bool mnt_already_visible(struct m
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
 
@@ -3893,6 +3951,7 @@ static bool mnt_already_visible(struct m
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
