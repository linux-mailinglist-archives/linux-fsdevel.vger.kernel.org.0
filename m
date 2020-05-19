Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46571D9CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgESQhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgESQhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:37:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D553DC08C5C0;
        Tue, 19 May 2020 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uyf2ueNIfJGQl9XBfbBGLJfofliABcUPeh4lV+oFziQ=; b=MDdAAORNfycDuso9QDoBWPQvTu
        L4b4kKFQC8AYHUvV+XYvBB5XZ1tnbL/BKPTtDW5Rn+mhlIMTz0FYCNDcYStzUgO2kNT4lKbyU9OuF
        XZMsWbY3efbFlDzU87M9/XsluYaaTRbGis7+ucYa+Y04u2WH0UisMIcnc84ybcheRXaZtOZB1U1Po
        f91gUZJaQBefyGILuixbeTRwbaMXy/JXW7cN39hRrQENVtOH55Q0JqfpQJJA238xlkbwvtyTqPM1Y
        q9hB/r5GmypNEYLy4TLn9c7R65LLcuqPK8eX3qk2y4j3xONfhYKfpbIOdp3yuHk0ih8XI20dcVbNW
        SY/PSXMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb5Ev-0004uK-B9; Tue, 19 May 2020 16:37:13 +0000
Date:   Tue, 19 May 2020 09:37:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200519163713.GA29944@infradead.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516031956.2605-6-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't think we need any of that symlink stuff.  Even if we want it
(which I don't), it should not be in a bug fix patch.

In fact to fix the blktrace race I think we only need something like
this fairly trivial patch (completely untested so far) below.

(and with that we can also drop the previous patch, as blk-debugfs.c
becomes rather pointless)


diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa4..a2800bc56fb4d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -824,9 +824,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -857,9 +854,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 561624d4cc4e7..8e6ea4a13f550 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -918,6 +919,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
+	debugfs_remove_recursive(q->debugfs_dir);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -989,6 +991,27 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	/*
+	 * Blktrace needs a debugsfs name even for queues that don't register
+	 * a gendisk, so it lazily registers the debugfs directory.  But that
+	 * can get us into a situation where a SCSI device is found, with no
+	 * driver for it (yet).  Then blktrace is used on the device, creating
+	 * the debugfs directory, and only after that a drivers is loaded. In
+	 * that case we might already have a debugfs directory registered here.
+	 * Even worse we could be racing with blktrace to register it.
+	 */
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	mutex_lock(&q->blk_trace_mutex);
+	if (!q->debugfs_dir) {
+		q->debugfs_dir =
+			debugfs_create_dir(kobject_name(q->kobj.parent),
+				blk_debugfs_root);
+	}
+	mutex_unlock(&q->blk_trace_mutex);
+#else
+	blk_queue_debugfs_register(q);
+#endif
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8801f3d7cf4a3..7a4de524f408f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -574,8 +574,8 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 3b6ff5902edce..eb6db276e2931 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -22,7 +22,6 @@ struct blk_trace {
 	u64 end_lba;
 	u32 pid;
 	u32 dev;
-	struct dentry *dir;
 	struct dentry *dropped_file;
 	struct dentry *msg_file;
 	struct list_head running_list;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb3..1b622e970cede 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,7 +311,6 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
-	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
@@ -476,15 +475,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			      struct blk_user_trace_setup *buts)
 {
 	struct blk_trace *bt = NULL;
-	struct dentry *dir = NULL;
 	int ret;
 
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -494,6 +489,25 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	/*
+	 * For queues that do not have a gendisk attached to them, the debugfs
+	 * directory will not have been created at setup time.  Create it here
+	 * lazily, it will only be removed when the queue is torn down.
+	 *
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (!q->debugfs_dir) {
+		q->debugfs_dir =
+			debugfs_create_dir(buts->name, blk_debugfs_root);
+	}
+	if (IS_ERR_OR_NULL(q->debugfs_dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		return -ENOENT;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
@@ -507,23 +521,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
-					       &blk_dropped_fops);
+	bt->dropped_file = debugfs_create_file("dropped", 0444, q->debugfs_dir,
+					       bt, &blk_dropped_fops);
 
-	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
+	bt->msg_file = debugfs_create_file("msg", 0222, q->debugfs_dir, bt,
+					   &blk_msg_fops);
 
-	bt->rchan = relay_open("trace", dir, buts->buf_size,
+	bt->rchan = relay_open("trace", q->debugfs_dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
 	if (!bt->rchan)
 		goto err;
@@ -551,8 +560,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
