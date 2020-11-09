Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09A2AB895
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIMuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 07:50:00 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:53676 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgKIMtt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:49:49 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-103-122-167.net.upcbroadband.cz [89.103.122.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 23C7420A04;
        Mon,  9 Nov 2020 12:48:22 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RESEND PATCH v3] fuse: Abort waiting for a response if the daemon receives a fatal signal
Date:   Mon,  9 Nov 2020 13:46:55 +0100
Message-Id: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 09 Nov 2020 12:48:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch removes one kind of the deadlocks inside the fuse daemon. The
problem appear when the fuse daemon itself makes a file operation on its
filesystem and receives a fatal signal.

This deadlock can be interrupted via fusectl filesystem. But if you have
many fuse mountpoints, it will be difficult to figure out which
connection to break.

This patch aborts the connection if the fuse server receives a fatal
signal.

Reproducer: https://github.com/sargun/fuse-example
Reference: CVE-2019-20794
Fixes: 51eb01e73599 ("[PATCH] fuse: no backgrounding on interrupt")
Сс: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/fuse/dev.c    | 26 +++++++++++++++++++++++++-
 fs/fuse/fuse_i.h |  6 ++++++
 fs/fuse/inode.c  |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36b3676..eadfed675791 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/fdtable.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -357,6 +358,29 @@ static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	return 0;
 }
 
+static int match_fusedev(const void *p, struct file *file, unsigned fd)
+{
+	return ((struct fuse_conn *) p)->fusedev_file == file;
+}
+
+static inline bool is_fuse_daemon(struct fuse_conn *fc)
+{
+	return iterate_fd(current->files, 0, match_fusedev, fc);
+}
+
+static inline bool is_conn_untrusted(struct fuse_conn *fc)
+{
+	return (fc->sb->s_iflags & SB_I_UNTRUSTED_MOUNTER);
+}
+
+static inline bool is_event_finished(struct fuse_conn *fc, struct fuse_req *req)
+{
+	if (fc->check_fusedev_file &&
+	    fatal_signal_pending(current) && is_conn_untrusted(fc) && is_fuse_daemon(fc))
+		fuse_abort_conn(fc);
+	return test_bit(FR_FINISHED, &req->flags);
+}
+
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
@@ -399,7 +423,7 @@ static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
 	 */
-	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
+	wait_event(req->waitq, is_event_finished(fc, req));
 }
 
 static void __fuse_request_send(struct fuse_conn *fc, struct fuse_req *req)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..ee9986b3c932 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -516,6 +516,9 @@ struct fuse_conn {
 	/** The group id for this mount */
 	kgid_t group_id;
 
+	/** The /dev/fuse file for this mount */
+	struct file *fusedev_file;
+
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
 
@@ -720,6 +723,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/** Do not check fusedev_file (virtiofs) */
+	unsigned int check_fusedev_file:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..8dc86e5079e6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1201,6 +1201,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
 	fc->no_mount_options = ctx->no_mount_options;
+	fc->fusedev_file = fget(ctx->fd);
+	fc->check_fusedev_file = 1;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
@@ -1348,6 +1350,7 @@ static void fuse_sb_destroy(struct super_block *sb)
 
 		fuse_abort_conn(fc);
 		fuse_wait_aborted(fc);
+		fput(fc->fusedev_file);
 
 		down_write(&fc->killsb);
 		fc->sb = NULL;
-- 
2.25.4

