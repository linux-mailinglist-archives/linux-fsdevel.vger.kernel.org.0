Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D01E3649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 05:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgE0DMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 23:12:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43748 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 23:12:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id 185so2836651pgb.10;
        Tue, 26 May 2020 20:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPdSyUNbBu4Tk0UBqM+yLv8ZqjemRwgoOw92D8fo/Ys=;
        b=J/dhwq6wCTpHodfGqRrgK/9zODGr7K5W9KQJTe1uOGURVyw8ijN/H/6H2ty+OwMn4+
         uwlvlYWd47LTi0Rz20RYrh7sXKTeEVysED+J8lFiMihqLR7I4G/IDBupBq63RWfLkWsG
         cbNDbXgzcApgVdi0WkxUJKpaoTmrr0jfU2y5Q4yPeHPcBWEJYSwBxWf+9y62IzD/Sx/W
         gjAirETzLqbH/td3cq3EZm7jyxrg4FVdB5BotvSavNI5Evh196OaehvkIkTvTuii7/2Q
         p4iH7SJVro1/MoZAdh0X4ipgzSH5kSGHgE910MVb6raxL3D4b8vN0GCXPg8e++5mlfMi
         zM4Q==
X-Gm-Message-State: AOAM531UMaTHuGXBglOf9aYI+VAlvi18MMFKHfBkjkYYdQI1hCBMy728
        lx5F8bh6kUckIW1KJ/OfqxY=
X-Google-Smtp-Source: ABdhPJyKomyTJQ5gaYgDKB/WKtQZxfmOCKI9VPkAPDTYVfHGsWhziXM0XJANNASrM5gh/ua4aEyXBw==
X-Received: by 2002:a63:510c:: with SMTP id f12mr1806776pgb.20.1590549124513;
        Tue, 26 May 2020 20:12:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l11sm853406pjj.33.2020.05.26.20.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 20:12:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5391D419C3; Wed, 27 May 2020 03:12:02 +0000 (UTC)
Date:   Wed, 27 May 2020 03:12:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20200527031202.GT11244@42.do-not-panic.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163713.GA29944@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 09:37:13AM -0700, Christoph Hellwig wrote:
> I don't think we need any of that symlink stuff.  Even if we want it
> (which I don't), it should not be in a bug fix patch.
> 
> In fact to fix the blktrace race I think we only need something like
> this fairly trivial patch (completely untested so far) below.
> 
> (and with that we can also drop the previous patch, as blk-debugfs.c
> becomes rather pointless)

You forgot to deal with partitions. Putting similar lipstick on the pig,
this is what I end up with, let me know if this seems agreeable:

diff --git a/block/blk-core.c b/block/blk-core.c
index 2096373bd16d..67cd9ddac822 100644
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
@@ -1877,9 +1875,7 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
-#ifdef CONFIG_DEBUG_FS
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
-#endif
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 96b7a35c898a..08edc3a54114 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -822,9 +822,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -855,9 +852,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 561624d4cc4e..5babb6547f48 100644
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
 
@@ -989,6 +991,28 @@ int blk_register_queue(struct gendisk *disk)
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
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+#endif
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index 5db4ec1e85f7..f11f79295419 100644
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
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 297004fd2264..95f9019aac83 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
+#include <linux/debugfs.h>
 #include "check.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
@@ -322,6 +323,7 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	get_device(disk_to_dev(part_to_disk(part)));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	kobject_put(part->holder_dir);
+	debugfs_remove_recursive(part->debugfs_dir);
 	device_del(part_to_dev(part));
 
 	/*
@@ -443,6 +445,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p->holder_dir)
 		goto out_del;
 
+	p->debugfs_dir = debugfs_create_dir(dev_name(pdev), blk_debugfs_root);
 	dev_set_uevent_suppress(pdev, 0);
 	if (flags & ADDPART_FLAG_WHOLEDISK) {
 		err = device_create_file(pdev, &dev_attr_whole_disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 20e378b428b8..737467c29a31 100644
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
index 3b6ff5902edc..eb6db276e293 100644
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
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a9384449465a..7ff4c4c06140 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -89,6 +89,7 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	struct rcu_work rcu_work;
+	struct dentry *debugfs_dir;
 };
 
 /**
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..8209d41dec18 100644
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
@@ -482,9 +481,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -494,6 +490,38 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	/*
+	 * We also have to use a partition directory if a partition is
+	 * being worked on, even though the same request_queue is shared.
+	 */
+	if (bdev && bdev != bdev->bd_contains)
+		dir = bdev->bd_part->debugfs_dir;
+	else {
+		/*
+		 * For queues that do not have a gendisk attached to them, the
+		 * debugfs directory will not have been created at setup time.
+		 * Create it here lazily, it will only be removed when the
+		 * queue is torn down.
+		 */
+		if (!q->debugfs_dir) {
+			q->debugfs_dir =
+				debugfs_create_dir(buts->name,
+						   blk_debugfs_root);
+		}
+		dir = q->debugfs_dir;
+	}
+
+	/*
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (IS_ERR_OR_NULL(q->debugfs_dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		return -ENOENT;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
@@ -507,12 +535,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -551,8 +573,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.26.2

