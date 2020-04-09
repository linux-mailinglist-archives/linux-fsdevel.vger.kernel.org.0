Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA501A3BDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgDIVWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:22:19 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38420 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:22:19 -0400
Received: by mail-wr1-f43.google.com with SMTP id 31so13747001wre.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+wnWElS2g3azI8fVzJ8R1o0iyiQtVVNapeZ8Qs7pW5o=;
        b=WSXpbamSvdexSGoyOW1WgyWqsdS8m+0Tuiln6raIOeHJQ/Utqeiilc995pMzz5C9i9
         sf5lnMTITI/MmDwtlHuIonC9Ke9QhwG7EL05bEKnrWAojsCR4nUudWh8AHmdVEw1AFhX
         Ns5S1tRkK10IzFs28hkfNFGFZr+pLep6dyJUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+wnWElS2g3azI8fVzJ8R1o0iyiQtVVNapeZ8Qs7pW5o=;
        b=pBSM5gPoespGtfjhwdcAg0FjzcUGToF8J1YJV3U72lkXW03KIt0vZ+kJlJWowWez+L
         0DlrKmDiu1YLTlQSYqoADZeYdp05kH5QQJGCM+ZxveXAmlfpSF9xoVsDNU+NjHTrlORA
         N9DIRLGlOmBBnIOsd/NWc7Ae90EG9vnCz1DzBVn9b1TwI/JSPWjduA07ubZaMePEpSqY
         ZrkwMwWA7CiVhDSJtFh1wu7sIR/CVVkVzXQETLDiaNaDrwJnOb2iSxg3XHN0CEhvweXt
         AyZc4AMBusoaW0uBqeyn5TAo9dAvgphpmCr711LZa3Q90JR5zcWrrVw2fLPFpkKJZ+SZ
         6jig==
X-Gm-Message-State: AGi0PubzGssLebSEdnEhnDDqMRcCSF2M9auNcrrAUPREuteIS7We8S6p
        50JS3Pu0eTMu24bpUoHhiEvMu6n1BGU=
X-Google-Smtp-Source: APiQypLo5L/pkJRLr1clPqO6g+CFiemOL5IEaMYc2gR8liYLU/CoMNHAPJmNXpWAQLUPOXSRy+komw==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr1184326wrp.403.1586467337577;
        Thu, 09 Apr 2020 14:22:17 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm5176766wmi.27.2020.04.09.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:22:16 -0700 (PDT)
Date:   Thu, 9 Apr 2020 23:22:14 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] proc/mounts: add cursor
Message-ID: <20200409212214.GG28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

I think this version fixes your worries about cachline pingpong and excessively
long list due to cursors.

Thanks,
Miklos
---

From: Miklos Szeredi <mszeredi@redhat.com>
Subject: proc/mounts: add cursor

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
Differences from v2:
 - only update cursor in m_end(): a lot less cachline invalidations
 - remove cursor when at EOF, this means no cursors on the list when not
   actively reading the file

Differences from v1:
 - removed unnecessary code that wanted to handle lseeks
 - fixed double entry at the start of a read

fs/mount.h            |   12 +++++--
 fs/namespace.c        |   85 ++++++++++++++++++++++++++++++++++++++++----------
 fs/proc_namespace.c   |    4 +-
 include/linux/mount.h |    4 +-
 4 files changed, 83 insertions(+), 22 deletions(-)

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
@@ -1249,42 +1277,50 @@ struct vfsmount *mnt_clone_internal(cons
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt = NULL;
 
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
+	if (!list_empty(&p->cursor.mnt_list))
+		mnt = mnt_skip_cursors(p->ns, &p->cursor);
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
+	mnt = mnt_skip_cursors(p->ns, list_next_entry(mnt, mnt_list));
+	unlock_ns_list(p->ns);
+	++*pos;
+
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
 
@@ -1294,6 +1330,15 @@ const struct seq_operations mounts_op =
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
@@ -3202,6 +3247,7 @@ static struct mnt_namespace *alloc_mnt_n
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
+	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3842,10 +3888,14 @@ static bool mnt_already_visible(struct m
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
 
@@ -3893,6 +3943,7 @@ static bool mnt_already_visible(struct m
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
