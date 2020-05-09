Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1F1CBCD6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 05:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEIDLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 23:11:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35715 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEIDLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 23:11:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id t11so1806548pgg.2;
        Fri, 08 May 2020 20:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hs1FsqzUCeFOKYWDLktPBXjXEQEnvc6B5fC1IA2tJs=;
        b=KjEw7Qp+hn4yS9jPZbEiQ5375EVVb64HYAhnFBxYVyHTx93KqnRs/TyDI2QHynZywt
         toIV9Gd5A93Lr9rpoGk7IkoJupSjUbvTJnYJILU7oK4uhaUM7nFmsj8fsq/FzbAFwK00
         Ui/Qz4gf38UEtKF05eEvz68bNwyskyeaYXL2fCMtgGcg3wPzFjZJv5mnp30+DS626CkS
         5AtRarE6DOO8TjMXEyj1fKREhwsmdgZe7bJ+/vJ1PxK3WSjaHlybsciN2hGDMZIntzgu
         EF8yCWkBvFlNmIIxrbshNl6D5ht/khhWac8er21CVJEGCHk23KdqPbGGKXiCGNUnCE4f
         4Xxw==
X-Gm-Message-State: AGi0PuaTVi+ElKXLsKLzc+1+AJrw4qRSmvyO6GRonW1KJsFeIufyZGMg
        h+bdDOOnMPC4m6dPjVs1T7s=
X-Google-Smtp-Source: APiQypJIdZZf4fzJDIak5s4qUDa2dh0roVOHepWDb5ro3z6Ko9AyY0pr0+1Yd9BRw31ZoJl0sOgIzg==
X-Received: by 2002:a63:115a:: with SMTP id 26mr4759653pgr.354.1588993863961;
        Fri, 08 May 2020 20:11:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g16sm3198429pfq.203.2020.05.08.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:11:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C63964063E; Sat,  9 May 2020 03:10:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/5] block: revert back to synchronous request_queue removal
Date:   Sat,  9 May 2020 03:10:54 +0000
Message-Id: <20200509031058.8239-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509031058.8239-1-mcgrof@kernel.org>
References: <20200509031058.8239-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
v4.12 moved the work behind blk_release_queue() into a workqueue after a
splat floated around which indicated some work on blk_release_queue()
could sleep in blk_exit_rl(). This splat would be possible when a driver
called blk_put_queue() or blk_cleanup_queue() (which calls blk_put_queue()
as its final call) from an atomic context.

blk_put_queue() decrements the refcount for the request_queue kobject,
and upon reaching 0 blk_release_queue() is called. Although blk_exit_rl()
is now removed through commit db6d9952356 ("block: remove request_list code")
on v5.0, we reserve the right to be able to sleep within blk_release_queue()
context.

The last reference for the request_queue must not be called from atomic
context. *When* the last reference to the request_queue reaches 0 varies,
and so let's take the opportunity to document when that is expected to
happen and also document the context of the related calls as best as possible
so we can avoid future issues, and with the hopes that the synchronous
request_queue removal sticks.

We revert back to synchronous request_queue removal because asynchronous
removal creates a regression with expected userspace interaction with
several drivers. An example is when removing the loopback driver, one
uses ioctls from userspace to do so, but upon return and if successful,
one expects the device to be removed. Likewise if one races to add another
device the new one may not be added as it is still being removed. This was
expected behavior before and it now fails as the device is still present
and busy still. Moving to asynchronous request_queue removal could have
broken many scripts which relied on the removal to have been completed if
there was no error. Document this expectation as well so that this
doesn't regress userspace again.

Using asynchronous request_queue removal however has helped us find
other bugs. In the future we can test what could break with this
arrangement by enabling CONFIG_DEBUG_KOBJECT_RELEASE.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Suggested-by: Nicolai Stange <nstange@suse.de>
Fixes: dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c       | 23 +++++++++++++
 block/blk-sysfs.c      | 43 +++++++++++++------------
 block/genhd.c          | 73 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 --
 4 files changed, 117 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dccdae09b7b6..da120fd257fa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -306,6 +306,16 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
+/**
+ * blk_put_queue - decrement the request_queue refcount
+ * @q: the request_queue structure to decrement the refcount for
+ *
+ * Decrements the refcount of the request_queue kobject. When this reaches 0
+ * we'll have blk_release_queue() called.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
+ */
 void blk_put_queue(struct request_queue *q)
 {
 	kobject_put(&q->kobj);
@@ -337,9 +347,14 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
  *
  * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
  * put it.  All future requests will be failed immediately with -ENODEV.
+ *
+ * Context: can sleep
  */
 void blk_cleanup_queue(struct request_queue *q)
 {
+	/* cannot be called from atomic context */
+	might_sleep();
+
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
@@ -584,6 +599,14 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+/**
+ * blk_get_queue - increment the request_queue refcount
+ * @q: the request_queue structure to increment the refcount for
+ *
+ * Increment the refcount of the request_queue kobject.
+ *
+ * Context: Any context.
+ */
 bool blk_get_queue(struct request_queue *q)
 {
 	if (likely(!blk_queue_dying(q))) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..5d0fc165a036 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -860,22 +860,32 @@ static void blk_exit_queue(struct request_queue *q)
 	bdi_put(q->backing_dev_info);
 }
 
-
 /**
- * __blk_release_queue - release a request queue
- * @work: pointer to the release_work member of the request queue to be released
+ * blk_release_queue - releases all allocated resources of the request_queue
+ * @kobj: pointer to a kobject, whose container is a request_queue
+ *
+ * This function releases all allocated resources of the request queue.
+ *
+ * The struct request_queue refcount is incremented with blk_get_queue() and
+ * decremented with blk_put_queue(). Once the refcount reaches 0 this function
+ * is called.
+ *
+ * For drivers that have a request_queue on a gendisk and added with
+ * __device_add_disk() the refcount to request_queue will reach 0 with
+ * the last put_disk() called by the driver. For drivers which don't use
+ * __device_add_disk() this happens with blk_cleanup_queue().
  *
- * Description:
- *     This function is called when a block device is being unregistered. The
- *     process of releasing a request queue starts with blk_cleanup_queue, which
- *     set the appropriate flags and then calls blk_put_queue, that decrements
- *     the reference counter of the request queue. Once the reference counter
- *     of the request queue reaches zero, blk_release_queue is called to release
- *     all allocated resources of the request queue.
+ * Drivers exist which depend on the release of the request_queue to be
+ * synchronous, it should not be deferred.
+ *
+ * Context: can sleep
  */
-static void __blk_release_queue(struct work_struct *work)
+static void blk_release_queue(struct kobject *kobj)
 {
-	struct request_queue *q = container_of(work, typeof(*q), release_work);
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
+
+	might_sleep();
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
@@ -904,15 +914,6 @@ static void __blk_release_queue(struct work_struct *work)
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
-static void blk_release_queue(struct kobject *kobj)
-{
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
-
-	INIT_WORK(&q->release_work, __blk_release_queue);
-	schedule_work(&q->release_work);
-}
-
 static const struct sysfs_ops queue_sysfs_ops = {
 	.show	= queue_attr_show,
 	.store	= queue_attr_store,
diff --git a/block/genhd.c b/block/genhd.c
index c05d509877fa..901567d70390 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -897,11 +897,32 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 	bdput(bdev);
 }
 
+/**
+ * del_gendisk - remove the gendisk
+ * @disk: the struct gendisk to remove
+ *
+ * Removes the gendisk and all its associated resources. This deletes the
+ * partitions associated with the gendisk, and unregisters the associated
+ * request_queue.
+ *
+ * This is the counter to the respective __device_add_disk() call.
+ *
+ * The final removal of the struct gendisk happens when its refcount reaches 0
+ * with put_disk(), which should be called after del_gendisk(), if
+ * __device_add_disk() was used.
+ *
+ * Drivers exist which depend on the release of the gendisk to be synchronous,
+ * it should not be deferred.
+ *
+ * Context: can sleep
+ */
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
+	might_sleep();
+
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -992,11 +1013,15 @@ static ssize_t disk_badblocks_store(struct device *dev,
  *
  * This function gets the structure containing partitioning
  * information for the given device @devt.
+ *
+ * Context: can sleep
  */
 struct gendisk *get_gendisk(dev_t devt, int *partno)
 {
 	struct gendisk *disk = NULL;
 
+	might_sleep();
+
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
 		struct kobject *kobj;
 
@@ -1528,10 +1553,31 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
 	return 0;
 }
 
+/**
+ * disk_release - releases all allocated resources of the gendisk
+ * @dev: the device representing this disk
+ *
+ * This function releases all allocated resources of the gendisk.
+ *
+ * The struct gendisk refcount is incremented with get_gendisk() or
+ * get_disk_and_module(), and its refcount is decremented with
+ * put_disk_and_module() or put_disk(). Once the refcount reaches 0 this
+ * function is called.
+ *
+ * Drivers which used __device_add_disk() have a gendisk with a request_queue
+ * assigned. Since the request_queue sits on top of the gendisk for these
+ * drivers we also call blk_put_queue() for them, and we expect the
+ * request_queue refcount to reach 0 at this point, and so the request_queue
+ * will also be freed prior to the disk.
+ *
+ * Context: can sleep
+ */
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	might_sleep();
+
 	blk_free_devt(dev->devt);
 	disk_release_events(disk);
 	kfree(disk->random);
@@ -1737,6 +1783,15 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
+/**
+ * get_disk_and_module - increments the gendisk and gendisk fops module refcount
+ * @disk: the struct gendisk to to increment the refcount for
+ *
+ * This increments the refcount for the struct gendisk, and the gendisk's
+ * fops module owner.
+ *
+ * Context: Any context.
+ */
 struct kobject *get_disk_and_module(struct gendisk *disk)
 {
 	struct module *owner;
@@ -1757,6 +1812,16 @@ struct kobject *get_disk_and_module(struct gendisk *disk)
 }
 EXPORT_SYMBOL(get_disk_and_module);
 
+/**
+ * put_disk - decrements the gendisk refcount
+ * @disk: the struct gendisk to to decrement the refcount for
+ *
+ * This decrements the refcount for the struct gendisk. When this reaches 0
+ * we'll have disk_release() called.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
+ */
 void put_disk(struct gendisk *disk)
 {
 	if (disk)
@@ -1764,9 +1829,15 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
-/*
+/**
+ * put_disk_and_module - decrements the module and gendisk refcount
+ * @disk: the struct gendisk to to decrement the refcount for
+ *
  * This is a counterpart of get_disk_and_module() and thus also of
  * get_gendisk().
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
  */
 void put_disk_and_module(struct gendisk *disk)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f00bd4042295..3122a93c7277 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,8 +571,6 @@ struct request_queue {
 
 	size_t			cmd_size;
 
-	struct work_struct	release_work;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.25.1

