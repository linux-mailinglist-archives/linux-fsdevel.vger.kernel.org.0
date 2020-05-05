Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476041C524E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgEEJ7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728697AbgEEJ71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RqCFyq/fXvFwN1UMB3LjzTaQRZFXgAWBLj/FQyRgmQ=;
        b=HkKRhpID5IMWnnjuqSwaK9fTGnP81kuBKsnP1hwd5kfjsLiF/0WnUCBOtragjpF8DDRkZC
        fkd5UFzBhEcviD9fLe4G9RxQHSDWiQ38dNhM554sqHWKHWa1pIj+Papc10QKMRZJNFJcLw
        t72lXyPXVsYma/yW0ByaNkkmb8LYwxI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-NWnD8ddpPTyyb3-6BexH3g-1; Tue, 05 May 2020 05:59:23 -0400
X-MC-Unique: NWnD8ddpPTyyb3-6BexH3g-1
Received: by mail-wm1-f71.google.com with SMTP id f128so803618wmf.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RqCFyq/fXvFwN1UMB3LjzTaQRZFXgAWBLj/FQyRgmQ=;
        b=RTA3WatTXr7TAbiQtjHtbvUSQQpdu5Y2tKfTJCoTwOMC7MZAkMRSHD8BUpQqmsDA8A
         aTykZk9XvK1ymKh0ZxdqufCM5tn9vWhUI9LAunZLyJd81fKfzhOEAkZMN6eEUKgqyVG/
         QHh7Ux1RTM3TCSAWpRt/1hm9M7jJDirWsGia/BXKW+gRr6L/r0++Zfo+HFG2YtPFZHGx
         cFYMfn9DiF7/RpeovCGmRzDVr4PnzDcZziwMa9V6kD0GqpXsj6gNNFT2EQbfq1qfXyNV
         wA4upsTkDeuF5ncUf04VdNCIa+dbHU3Vzk/9wN8aP2BzvMjJx1RcNFC7CdaAZKb37yUN
         Mq/A==
X-Gm-Message-State: AGi0PubCexnAvfCGGZ4PLx4Yn3IxEKBHGpq3PV7SAbA6BxsfTiENUrwI
        OFnk/3sNqd8JV7nuu2B3yCJ5DxrC9p61Y9aoG6RUFgFOf9C+B1l/q4OSNdTgq31IzgT7YaMjH7u
        WsnlcobhCQeVAmeo7pr8t5xjNlg==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr2432535wmb.61.1588672761484;
        Tue, 05 May 2020 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypIqfKdg8/E8gDuoSgLiqGy1Nspa1i1D3kvm29Fyrghvc6vvFSihgDimsNF46fPMZzhGipLHvw==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr2432500wmb.61.1588672761063;
        Tue, 05 May 2020 02:59:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: [PATCH 03/12] proc/mounts: add cursor
Date:   Tue,  5 May 2020 11:59:06 +0200
Message-Id: <20200505095915.11275-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
 fs/mount.h            | 12 ++++--
 fs/namespace.c        | 91 +++++++++++++++++++++++++++++++++++--------
 fs/proc_namespace.c   |  4 +-
 include/linux/mount.h |  4 +-
 4 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..c7abb7b394d8 100644
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
@@ -153,3 +157,5 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
 	return ns->seq == 0;
 }
+
+extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
diff --git a/fs/namespace.c b/fs/namespace.c
index a28e4db075ed..b59b4e4e9a8a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -648,6 +648,21 @@ struct vfsmount *lookup_mnt(const struct path *path)
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
@@ -673,11 +688,15 @@ bool __is_local_mountpoint(struct dentry *dentry)
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
@@ -1245,46 +1264,71 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
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
 
@@ -1294,6 +1338,15 @@ const struct seq_operations mounts_op = {
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
@@ -3202,6 +3255,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
+	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3842,10 +3896,14 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
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
 
@@ -3893,6 +3951,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 	next:	;
 	}
 found:
+	unlock_ns_list(ns);
 	up_read(&namespace_sem);
 	return visible;
 }
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..e4d70c0dffe9 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -279,7 +279,8 @@ static int mounts_open_common(struct inode *inode, struct file *file,
 	p->ns = ns;
 	p->root = root;
 	p->show = show;
-	p->cached_event = ~0ULL;
+	INIT_LIST_HEAD(&p->cursor.mnt_list);
+	p->cursor.mnt.mnt_flags = MNT_CURSOR;
 
 	return 0;
 
@@ -296,6 +297,7 @@ static int mounts_release(struct inode *inode, struct file *file)
 	struct seq_file *m = file->private_data;
 	struct proc_mounts *p = m->private;
 	path_put(&p->root);
+	mnt_cursor_del(p->ns, &p->cursor);
 	put_mnt_ns(p->ns);
 	return seq_release_private(inode, file);
 }
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf8cc4108b8f..7edac8c7a9c1 100644
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
-- 
2.21.1

