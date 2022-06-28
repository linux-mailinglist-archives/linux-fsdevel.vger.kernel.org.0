Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EE55EFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiF1UqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiF1UqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0494426540
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656449176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UnwOLd+3RtI858ogHbbAwRvYSEQdRCv3KJ1ACMKljA=;
        b=A8dVpeHONBDNp5BhUhx9qhbiO411PVoeUG2WKhMaAwge6uDPXXhAVD0sT9yuI015OBS2xn
        L7Vp6Y/t2ATwm8gC9EOmBvGd5NbAUsN8V+rczRTwEq4zN6bTP0xy6XAF73HU0t1GAsgnXY
        u6pmMpwElRcOLQ7KooHAGULj5HhWBZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-KDy9fWrnP-m8W5GnpFIHkQ-1; Tue, 28 Jun 2022 16:46:14 -0400
X-MC-Unique: KDy9fWrnP-m8W5GnpFIHkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EABC85A581;
        Tue, 28 Jun 2022 20:46:14 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.193.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC9540D282F;
        Tue, 28 Jun 2022 20:46:13 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/5] gfs2: Add glockfd debugfs file
Date:   Tue, 28 Jun 2022 22:46:07 +0200
Message-Id: <20220628204611.651126-2-agruenba@redhat.com>
In-Reply-To: <20220628204611.651126-1-agruenba@redhat.com>
References: <20220628204611.651126-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a process has a gfs2 file open, the file is keeping a reference on the
underlying gfs2 inode, and the inode is keeping the inode's iopen glock held in
shared mode.  In other words, the process depends on the iopen glock of each
open gfs2 file.  Expose those dependencies in a new "glockfd" debugfs file.

The new debugfs file contains one line for each gfs2 file descriptor,
specifying the tgid, file descriptor number, and glock name, e.g.,

  1601 6 5/816d

This list is compiled by iterating all tasks on the system using find_ge_pid(),
and all file descriptors of each task using task_lookup_next_fd_rcu().  To make
that work from gfs2, export those two functions.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/file.c       |   1 +
 fs/gfs2/glock.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/pid.c    |   1 +
 3 files changed, 149 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 3bcc1ecc314a..5f9c802a5d8d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -980,6 +980,7 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret
 	*ret_fd = fd;
 	return file;
 }
+EXPORT_SYMBOL(task_lookup_next_fd_rcu);
 
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index c992d53013d3..63dbab6fa242 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -33,6 +33,7 @@
 #include <linux/list_sort.h>
 #include <linux/lockref.h>
 #include <linux/rhashtable.h>
+#include <linux/fdtable.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -2745,6 +2746,149 @@ static const struct file_operations gfs2_glstats_fops = {
 	.release = gfs2_glocks_release,
 };
 
+struct gfs2_glockfd_iter {
+	struct super_block *sb;
+	unsigned int tgid;
+	struct task_struct *task;
+	unsigned int fd;
+	struct file *file;
+};
+
+static struct task_struct *gfs2_glockfd_next_task(struct gfs2_glockfd_iter *i)
+{
+	struct pid_namespace *ns = task_active_pid_ns(current);
+	struct pid *pid;
+
+	if (i->task)
+		put_task_struct(i->task);
+
+	rcu_read_lock();
+retry:
+	i->task = NULL;
+	pid = find_ge_pid(i->tgid, ns);
+	if (pid) {
+		i->tgid = pid_nr_ns(pid, ns);
+		i->task = pid_task(pid, PIDTYPE_TGID);
+		if (!i->task) {
+			i->tgid++;
+			goto retry;
+		}
+		get_task_struct(i->task);
+	}
+	rcu_read_unlock();
+	return i->task;
+}
+
+static struct file *gfs2_glockfd_next_file(struct gfs2_glockfd_iter *i)
+{
+	if (i->file) {
+		fput(i->file);
+		i->file = NULL;
+	}
+
+	rcu_read_lock();
+	for(;; i->fd++) {
+		struct inode *inode;
+
+		i->file = task_lookup_next_fd_rcu(i->task, &i->fd);
+		if (!i->file) {
+			i->fd = 0;
+			break;
+		}
+		inode = file_inode(i->file);
+		if (inode->i_sb != i->sb)
+			continue;
+		if (get_file_rcu(i->file))
+			break;
+	}
+	rcu_read_unlock();
+	return i->file;
+}
+
+static void *gfs2_glockfd_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct gfs2_glockfd_iter *i = seq->private;
+
+	if (*pos)
+		return NULL;
+	while (gfs2_glockfd_next_task(i)) {
+		if (gfs2_glockfd_next_file(i))
+			return i;
+		i->tgid++;
+	}
+	return NULL;
+}
+
+static void *gfs2_glockfd_seq_next(struct seq_file *seq, void *iter_ptr,
+				   loff_t *pos)
+{
+	struct gfs2_glockfd_iter *i = seq->private;
+
+	(*pos)++;
+	i->fd++;
+	do {
+		if (gfs2_glockfd_next_file(i))
+			return i;
+		i->tgid++;
+	} while (gfs2_glockfd_next_task(i));
+	return NULL;
+}
+
+static void gfs2_glockfd_seq_stop(struct seq_file *seq, void *iter_ptr)
+{
+	struct gfs2_glockfd_iter *i = seq->private;
+
+	if (i->file)
+		fput(i->file);
+	if (i->task)
+		put_task_struct(i->task);
+}
+
+static int gfs2_glockfd_seq_show(struct seq_file *seq, void *iter_ptr)
+{
+	struct gfs2_glockfd_iter *i = seq->private;
+	struct inode *inode = file_inode(i->file);
+	struct gfs2_glock *gl;
+
+	inode_lock_shared(inode);
+	gl = GFS2_I(inode)->i_iopen_gh.gh_gl;
+	if (gl) {
+		seq_printf(seq, "%d %u %u/%llx\n",
+			   i->tgid, i->fd, gl->gl_name.ln_type,
+			   (unsigned long long)gl->gl_name.ln_number);
+	}
+	inode_unlock_shared(inode);
+	return 0;
+}
+
+static const struct seq_operations gfs2_glockfd_seq_ops = {
+	.start = gfs2_glockfd_seq_start,
+	.next  = gfs2_glockfd_seq_next,
+	.stop  = gfs2_glockfd_seq_stop,
+	.show  = gfs2_glockfd_seq_show,
+};
+
+static int gfs2_glockfd_open(struct inode *inode, struct file *file)
+{
+	struct gfs2_glockfd_iter *i;
+	struct gfs2_sbd *sdp = inode->i_private;
+
+	i = __seq_open_private(file, &gfs2_glockfd_seq_ops,
+			       sizeof(struct gfs2_glockfd_iter));
+	if (!i)
+		return -ENOMEM;
+	i->sb = sdp->sd_vfs;
+	return 0;
+}
+
+static const struct file_operations gfs2_glockfd_fops = {
+	.owner   = THIS_MODULE,
+	.open    = gfs2_glockfd_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release_private,
+};
+
 DEFINE_SEQ_ATTRIBUTE(gfs2_sbstats);
 
 void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
@@ -2754,6 +2898,9 @@ void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
 	debugfs_create_file("glocks", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
 			    &gfs2_glocks_fops);
 
+	debugfs_create_file("glockfd", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
+			    &gfs2_glockfd_fops);
+
 	debugfs_create_file("glstats", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
 			    &gfs2_glstats_fops);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..3fbc5e46b721 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -519,6 +519,7 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 {
 	return idr_get_next(&ns->idr, &nr);
 }
+EXPORT_SYMBOL_GPL(find_ge_pid);
 
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 {
-- 
2.35.1

