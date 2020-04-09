Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC01A35A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgDIOQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 10:16:25 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45998 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIOQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:16:24 -0400
Received: by mail-wr1-f43.google.com with SMTP id v5so12089895wrp.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w7VO2K61FcqbOTP79IipXpGspUymVI8Ff419Lafe8Ws=;
        b=IZaZB80KRmVJeHM9YItkIeUuxnOVaIt6bSxmR7LyXrR5yL9JLwTGOEEGHYn75dVizZ
         nIV2G8JYK6FUzAZF0jv64CFORk6clOjoX/TXNwVHgtG4w78RlA9NNBR7DXOXHj+tZ3fA
         nU5tyTn7f3mdlZ/ieVmhIyPcXf3Af9DCXytYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w7VO2K61FcqbOTP79IipXpGspUymVI8Ff419Lafe8Ws=;
        b=Brt7uxC3i0hWdOsk18Qy6ayxcNpBqFNNdFh1tLmvTCo5podiXjbiQYFRKiz+3IYbXJ
         ET5UOd4i3s9lGQx+ciTkJSPll2mcAcKA1/Zd+v0v32ksU95wznNRh9ZmvFIJO0mjmNtR
         DD8KlIc826QqHv1TyhqI3Up65XkqSt5jMKyIdjyZ8oiLYjx24/uZtp9a3b3mOFeq7Zr7
         S+eXrItr4/HyAuz/ub6GxSQxwnotQ4fCwQu8/9fcUwnfaR/NxhJdMpOgTQXuNZJ89x5k
         HREqvp/m/NweOUhtUpQhZHSp8kmeuFOycYl5ICF7MDt8+3/m0eYX/6mGzzHljAjkJOOf
         JL0A==
X-Gm-Message-State: AGi0PuY9ZeQNUo4pcQ5NRKxeU5ogvE9HU21mHuIogtX+gss6vMVJyb6X
        5qGXX84kFAu5RI+ccu7B0Zl6gg==
X-Google-Smtp-Source: APiQypIU7fDky0BKTr3XCZ64Iuh66UXOohtK+I0QYArc/aIZDg7URiAnQS3Vs2qC0ZKZ+nREmZwDlQ==
X-Received: by 2002:a5d:4041:: with SMTP id w1mr13815837wrp.137.1586441782407;
        Thu, 09 Apr 2020 07:16:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g186sm4194137wmg.36.2020.04.09.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 07:16:21 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:16:19 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] proc/mounts: add cursor
Message-ID: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
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
Differences from v1:
 - removed unnecessary code that wanted to handle lseeks
 - fixed double entry at the start of a read

 fs/mount.h            |   12 +++++--
 fs/namespace.c        |   76 ++++++++++++++++++++++++++++++++++++++------------
 fs/proc_namespace.c   |    4 +-
 include/linux/mount.h |    4 +-
 4 files changed, 74 insertions(+), 22 deletions(-)

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
@@ -1249,31 +1277,30 @@ struct vfsmount *mnt_clone_internal(cons
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt;
 
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
+	lock_ns_list(p->ns);
+	if (!*pos)
+		list_move(&p->cursor.mnt_list, &p->ns->list);
+	mnt = mnt_skip_cursors(p->ns, &p->cursor);
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
 
-	p->cached_mount = seq_list_next(v, &p->ns->list, pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	lock_ns_list(p->ns);
+	list_move(&p->cursor.mnt_list, &mnt->mnt_list);
+	mnt = mnt_skip_cursors(p->ns, &p->cursor);
+	unlock_ns_list(p->ns);
+	++*pos;
+
+	return mnt;
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -1284,7 +1311,7 @@ static void m_stop(struct seq_file *m, v
 static int m_show(struct seq_file *m, void *v)
 {
 	struct proc_mounts *p = m->private;
-	struct mount *r = list_entry(v, struct mount, mnt_list);
+	struct mount *r = v;
 	return p->show(m, &r->mnt);
 }
 
@@ -1294,6 +1321,15 @@ const struct seq_operations mounts_op =
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
@@ -3202,6 +3238,7 @@ static struct mnt_namespace *alloc_mnt_n
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
+	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3842,10 +3879,14 @@ static bool mnt_already_visible(struct m
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
 
@@ -3893,6 +3934,7 @@ static bool mnt_already_visible(struct m
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
