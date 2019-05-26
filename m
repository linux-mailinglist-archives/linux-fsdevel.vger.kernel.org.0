Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0232A920
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 11:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfEZJLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 05:11:36 -0400
Received: from mail05-md.ns.itscom.net ([175.177.155.115]:38800 "EHLO
        mail05-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfEZJLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 05:11:36 -0400
Received: from cmsa03-mds.s.noc.itscom.net (cmsa03-md.ns.itscom.net [175.177.0.93])
        by mail05-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 504A26585EF;
        Sun, 26 May 2019 18:11:34 +0900 (JST)
Received: from jromail.nowhere ([219.110.50.76])
        by cmsa-md with ESMTP
        id UpBmhgn4cFyw2UpBmhybPt; Sun, 26 May 2019 18:11:34 +0900
Received: from jro by jrobl id 1hUpBm-0004et-1c ; Sun, 26 May 2019 18:11:34 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kolyshkin@gmail.com
Subject: [PATCH] concrete /proc/mounts
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17909.1558861894.1@jrobl>
Date:   Sun, 26 May 2019 18:11:34 +0900
Message-ID: <17910.1558861894@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 1e83f8634c6efe7dd4e6036ee202ca10bdbca0b3
Author: J. R. Okajima <hooanon05g@gmail.com>
Date:   Sat May 25 18:35:13 2019 +0900

    concrete /proc/mounts
    
    When the size of /proc/mounts exceeds PAGE_SIZE, seq_read() has to
    release namespace_sem via mounts_op.m_stop().  It means if someone else
    issues mount(2) or umount(2) and the mounts list got changed, then the
    continuous getmntent(3) calls show the incomplete mounts list and some
    entries may not appear in it.
    
    This patch generates the full mounts list when mounts_op.m_start() is
    called, and keep it in the seq_file buffer until the file is closed.
    The size of the buffer increases if necessary.  Other operations m_next,
    m_stop, m_show become meaningless, but still necessary for the seq_file
    manner.
    
    I don't think the size of the buffer matters because many /proc entries
    already keep the similar PAGE_SIZE buffer.  Increasing /proc/mounts
    buffer is to keep the correctness of the mount list.
    
    Reported-by: Kirill Kolyshkin <kolyshkin@gmail.com>
    See-also: https://github.com/kolyshkin/procfs-test
    Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>

diff --git a/fs/mount.h b/fs/mount.h
index f39bc9da4d73..1ffd97696ca9 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -131,9 +131,7 @@ struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
 	int (*show)(struct seq_file *, struct vfsmount *);
-	void *cached_mount;
-	u64 cached_event;
-	loff_t cached_index;
+	bool filled;
 };
 
 extern const struct seq_operations mounts_op;
diff --git a/fs/namespace.c b/fs/namespace.c
index d18deb4c410b..2984a48cd40f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1298,46 +1298,77 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 
 #ifdef CONFIG_PROC_FS
 /* iterator; we want it to have access to namespace_sem, thus here... */
-static void *m_start(struct seq_file *m, loff_t *pos)
+static int m_start_fill(struct seq_file *m)
 {
+	int err;
+	size_t last_count;
+	char *buf;
+	struct mount *r;
 	struct proc_mounts *p = m->private;
 
 	down_read(&namespace_sem);
-	if (p->cached_event == p->ns->event) {
-		void *v = p->cached_mount;
-		if (*pos == p->cached_index)
-			return v;
-		if (*pos == p->cached_index + 1) {
-			v = seq_list_next(v, &p->ns->list, &p->cached_index);
-			return p->cached_mount = v;
+	list_for_each_entry(r, &p->ns->list, mnt_list) {
+		last_count = m->count;
+		err = p->show(m, &r->mnt);
+		if (unlikely(err < 0))
+			break;
+		if (!seq_has_overflowed(m))
+			continue;
+
+		/* expand the buffer */
+		buf = kvmalloc(m->size + PAGE_SIZE, GFP_KERNEL);
+		if (unlikely(!buf)) {
+			err = -ENOMEM;
+			break;
+		}
+		memcpy(buf, m->buf, last_count);
+		kvfree(m->buf);
+		m->buf = buf;
+		m->size += PAGE_SIZE;
+		m->count = last_count;
+
+		err = p->show(m, &r->mnt);
+		if (unlikely(err < 0))
+			break;
+		else if (unlikely(seq_has_overflowed(m))) {
+			err = -EFBIG;
+			break;
 		}
 	}
+	up_read(&namespace_sem);
 
-	p->cached_event = p->ns->event;
-	p->cached_mount = seq_list_start(&p->ns->list, *pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	if (!err)
+		p->filled = true;
+	return err;
 }
 
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+static void *m_start(struct seq_file *m, loff_t *pos)
 {
+	int err;
 	struct proc_mounts *p = m->private;
 
-	p->cached_mount = seq_list_next(v, &p->ns->list, pos);
-	p->cached_index = *pos;
-	return p->cached_mount;
+	if (!p->filled) {
+		err = m_start_fill(m);
+		if (unlikely(err))
+			return ERR_PTR(err);
+	}
+
+	return m_start; /* any valid pointer */
+}
+
+static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return NULL;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	up_read(&namespace_sem);
+	/* empty */
 }
 
 static int m_show(struct seq_file *m, void *v)
 {
-	struct proc_mounts *p = m->private;
-	struct mount *r = list_entry(v, struct mount, mnt_list);
-	return p->show(m, &r->mnt);
+	return 0;
 }
 
 const struct seq_operations mounts_op = {
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 7626ee11b06c..f8aee5cca1b1 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -279,7 +279,6 @@ static int mounts_open_common(struct inode *inode, struct file *file,
 	p->ns = ns;
 	p->root = root;
 	p->show = show;
-	p->cached_event = ~0ULL;
 
 	return 0;
 
