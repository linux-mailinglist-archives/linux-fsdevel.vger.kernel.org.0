Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE051201CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391699AbgFSUru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:47:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43965 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391177AbgFSUrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id j12so2705491pfn.10;
        Fri, 19 Jun 2020 13:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwB6gnPxFEFUDI+liWG4HJoGOtS0QfTmlU5ZCBzuVTA=;
        b=GRri9G9fJKLoYS/9IsW8GwFxIyYGAhl0zIeCRXlT9XrkcIp6VCYNhz6VoW3GKTw7th
         ABxHvMP6Idto+P5eWnal1XdXY3xMjP+uCvDYGrg6lQNfcm0jikZng4D2PgKmsRmsjxKo
         pz9Iihg3bkzZji9wb3mAgJe49k7RPxZpX5uh++9DoCVouncVWam4sDmdJx7+CeYurRJ4
         ZPrLQdbugY0pAEmdloNFpZb00Tgro3RTARRBMJXdVEDd6bN+Vq9iYyTz2n3pBVXzOqcQ
         rNl0GMizMiAMIIhK9W26DiS4aor/T03tF2Sy7xNJWVEMbOl82ZJRNFb5XuXxScV9AZYS
         p5ew==
X-Gm-Message-State: AOAM531ghR8u8muw709KYXZdgqdyo35+iYiprBNzCrKORFpHGQgQUA91
        IRa1x5ja0cj9PnmXbjbpAnM=
X-Google-Smtp-Source: ABdhPJwn8wt+BXh8B2nnHFar7t2dCSA/MFrp9clSb4i0NMrHautUwplhSeTzGZ2gQSMi9eioBFJIug==
X-Received: by 2002:a63:f804:: with SMTP id n4mr3951220pgh.302.1592599665524;
        Fri, 19 Jun 2020 13:47:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s41sm6246108pjc.51.2020.06.19.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ADCAE42341; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 8/8] block: create the request_queue debugfs_dir on registration
Date:   Fri, 19 Jun 2020 20:47:30 +0000
Message-Id: <20200619204730.26124-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We were only creating the request_queue debugfs_dir only
for make_request block drivers (multiqueue), but never for
request-based block drivers. We did this as we were only
creating non-blktrace additional debugfs files on that directory
for make_request drivers. However, since blktrace *always* creates
that directory anyway, we special-case the use of that directory
on blktrace. Other than this being an eye-sore, this exposes
request-based block drivers to the same debugfs fragile
race that used to exist with make_request block drivers
where if we start adding files onto that directory we can later
run a race with a double removal of dentries on the directory
if we don't deal with this carefully on blktrace.

Instead, just simplify things by always creating the request_queue
debugfs_dir on request_queue registration. Rename the mutex also to
reflect the fact that this is used outside of the blktrace context.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c        |  8 +-----
 block/blk-mq-debugfs.c  |  5 ----
 block/blk-sysfs.c       |  9 +++++++
 block/blk.h             |  2 --
 include/linux/blkdev.h  |  5 ++--
 kernel/trace/blktrace.c | 58 ++++++++++++++++++-----------------------
 6 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a5126c0be777..72b102a389a5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,9 +51,7 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
 struct dentry *blk_debugfs_root;
-#endif
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
@@ -555,9 +553,7 @@ struct request_queue *__blk_alloc_queue(int node_id)
 
 	kobject_init(&q->kobj, &blk_queue_ktype);
 
-#ifdef CONFIG_BLK_DEV_IO_TRACE
-	mutex_init(&q->blk_trace_mutex);
-#endif
+	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
 	spin_lock_init(&q->queue_lock);
@@ -1937,9 +1933,7 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
-#ifdef CONFIG_DEBUG_FS
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
-#endif
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa..a2800bc56fb4 100644
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
index 561624d4cc4e..be67952e7be2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -917,6 +918,9 @@ static void blk_release_queue(struct kobject *kobj)
 		blk_mq_release(q);
 
 	blk_trace_shutdown(q);
+	mutex_lock(&q->debugfs_mutex);
+	debugfs_remove_recursive(q->debugfs_dir);
+	mutex_unlock(&q->debugfs_mutex);
 
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
@@ -989,6 +993,11 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	mutex_lock(&q->debugfs_mutex);
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+	mutex_unlock(&q->debugfs_mutex);
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index b5d1f0fc6547..499308c6ab3b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,9 +14,7 @@
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
-#ifdef CONFIG_DEBUG_FS
 extern struct dentry *blk_debugfs_root;
-#endif
 
 struct blk_flush_queue {
 	unsigned int		flush_pending_idx:1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 780d6fa94746..e70e03d2cd8c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -528,9 +528,9 @@ struct request_queue {
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
 	int			node;
+	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
-	struct mutex		blk_trace_mutex;
 #endif
 	/*
 	 * for flush operations
@@ -574,8 +574,9 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 098780ec018f..12e1d52f1d17 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -348,7 +348,7 @@ static int __blk_trace_remove(struct request_queue *q)
 	struct blk_trace *bt;
 
 	bt = rcu_replace_pointer(q->blk_trace, NULL,
-				 lockdep_is_held(&q->blk_trace_mutex));
+				 lockdep_is_held(&q->debugfs_mutex));
 	if (!bt)
 		return -EINVAL;
 
@@ -362,9 +362,9 @@ int blk_trace_remove(struct request_queue *q)
 {
 	int ret;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 	ret = __blk_trace_remove(q);
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
 }
@@ -483,14 +483,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	struct dentry *dir = NULL;
 	int ret;
 
-	lockdep_assert_held(&q->blk_trace_mutex);
+	lockdep_assert_held(&q->debugfs_mutex);
 
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -505,7 +502,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * we can be.
 	 */
 	if (rcu_dereference_protected(q->blk_trace,
-				      lockdep_is_held(&q->blk_trace_mutex))) {
+				      lockdep_is_held(&q->debugfs_mutex))) {
 		pr_warn("Concurrent blktraces are not allowed on %s\n",
 			buts->name);
 		return -EBUSY;
@@ -524,18 +521,15 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-#ifdef CONFIG_BLK_DEBUG_FS
 	/*
-	 * When tracing whole make_request drivers (multiqueue) block devices,
-	 * reuse the existing debugfs directory created by the block layer on
-	 * init. For request-based block devices, all partitions block devices,
+	 * When tracing the whole disk reuse the existing debugfs directory
+	 * created by the block layer on init. For partitions block devices,
 	 * and scsi-generic block devices we create a temporary new debugfs
 	 * directory that will be removed once the trace ends.
 	 */
-	if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)
+	if (bdev && bdev == bdev->bd_contains)
 		dir = q->debugfs_dir;
 	else
-#endif
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
 	/*
@@ -617,9 +611,9 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 {
 	int ret;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 	ret = __blk_trace_setup(q, name, dev, bdev, arg);
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
 }
@@ -665,7 +659,7 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	struct blk_trace *bt;
 
 	bt = rcu_dereference_protected(q->blk_trace,
-				       lockdep_is_held(&q->blk_trace_mutex));
+				       lockdep_is_held(&q->debugfs_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -705,9 +699,9 @@ int blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 	ret = __blk_trace_startstop(q, start);
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
 }
@@ -736,7 +730,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 
 	switch (cmd) {
 	case BLKTRACESETUP:
@@ -763,7 +757,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		break;
 	}
 
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 	return ret;
 }
 
@@ -774,14 +768,14 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 	if (rcu_dereference_protected(q->blk_trace,
-				      lockdep_is_held(&q->blk_trace_mutex))) {
+				      lockdep_is_held(&q->debugfs_mutex))) {
 		__blk_trace_startstop(q, 0);
 		__blk_trace_remove(q);
 	}
 
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP
@@ -1662,7 +1656,7 @@ static int blk_trace_remove_queue(struct request_queue *q)
 	struct blk_trace *bt;
 
 	bt = rcu_replace_pointer(q->blk_trace, NULL,
-				 lockdep_is_held(&q->blk_trace_mutex));
+				 lockdep_is_held(&q->debugfs_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -1837,10 +1831,10 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 
 	bt = rcu_dereference_protected(q->blk_trace,
-				       lockdep_is_held(&q->blk_trace_mutex));
+				       lockdep_is_held(&q->debugfs_mutex));
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!bt);
 		goto out_unlock_bdev;
@@ -1858,7 +1852,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "%llu\n", bt->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1901,10 +1895,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&q->blk_trace_mutex);
+	mutex_lock(&q->debugfs_mutex);
 
 	bt = rcu_dereference_protected(q->blk_trace,
-				       lockdep_is_held(&q->blk_trace_mutex));
+				       lockdep_is_held(&q->debugfs_mutex));
 	if (attr == &dev_attr_enable) {
 		if (!!value == !!bt) {
 			ret = 0;
@@ -1921,7 +1915,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (bt == NULL) {
 		ret = blk_trace_setup_queue(q, bdev);
 		bt = rcu_dereference_protected(q->blk_trace,
-				lockdep_is_held(&q->blk_trace_mutex));
+				lockdep_is_held(&q->debugfs_mutex));
 	}
 
 	if (ret == 0) {
@@ -1936,7 +1930,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&q->blk_trace_mutex);
+	mutex_unlock(&q->debugfs_mutex);
 out_bdput:
 	bdput(bdev);
 out:
-- 
2.26.2

