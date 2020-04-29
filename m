Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40001BD66B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgD2Hqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:46:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53759 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2Hqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id hi11so440083pjb.3;
        Wed, 29 Apr 2020 00:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5vpTVrx10Rf7A/Z6Yy5oBCSjI4ZVpUsuug2LyGGOvQ=;
        b=GIb26UiutnNvyze/Ksc3t2yjgA9aa/ypVFQk/5p1hg6AJiB2JdWlpIegs775twLwjA
         HW7bZIfeZuk4Wf8098qYysZNwKBoZ4PFk+fS7sFZavW7PL1v0A2TjGW/0fWJvb7yQ7Eq
         BEed/gDgCH8vXfPmPPUQaMvlyN92ctKQqWvJ+5b93OplpD5TzD6/q8bmxqCtD5ieG3BS
         Vzs5fBU7M0qL8AgCRlJkB4NjUDPNgiJBapUKR8UY31/PAs/7Oks7v/RZODWF5ksJbTFK
         3jjrAr1NExeGMUcWBRzd8ralHfDGJNHDiLf5BCbhoa3RV3VZb+fofYnRuN8c0f7N+Edu
         Ue1A==
X-Gm-Message-State: AGi0Pub/ugBhOmOhzM7S/N84AxyCyFXp23gxz6CEvjYNXeMQ15+b9S1o
        9k4YyrcaufktecjNIvjUS2I=
X-Google-Smtp-Source: APiQypLH/HANiOD/dQwddQ11EuhweU5P2arbITUF+MzuZpr33tqxR0UJYIvjyFj1xf+88z3YPmnS8g==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr1649338pjb.25.1588146391677;
        Wed, 29 Apr 2020 00:46:31 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u188sm451446pfu.33.2020.04.29.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C52CF40858; Wed, 29 Apr 2020 07:46:29 +0000 (UTC)
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
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v3 1/6] block: revert back to synchronous request_queue removal
Date:   Wed, 29 Apr 2020 07:46:22 +0000
Message-Id: <20200429074627.5955-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074627.5955-1-mcgrof@kernel.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
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
conext. *When* the last reference to the request_queue reaches 0 varies,
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
expected behaviour before and it now fails as the device is still present
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
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c       | 23 +++++++++++++
 block/blk-sysfs.c      | 43 +++++++++++++------------
 block/genhd.c          | 73 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 --
 4 files changed, 117 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0641c2916d7e..8a27c772982e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -306,6 +306,16 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
+/**
+ * blk_put_queue - decrement the request_queue refcount
+ * @q: the request_queue structure to decrement the refcount for
+ *
+ * Decrements the refcount to the request_queue kobject. When this reaches 0
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
@@ -567,6 +582,14 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+/**
+ * blk_get_queue - increment the request_queue refcount
+ * @q: the request_queue structure to incremenet the refcount for
+ *
+ * Increment the refcount to the request_queue kobject.
+ *
+ * Context: Any context.
+ */
 bool blk_get_queue(struct request_queue *q)
 {
 	if (likely(!blk_queue_dying(q))) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..eda8c4985511 100644
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
+ * @kobj: pointer to a kobject, who's container is a request_queue
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
index c05d509877fa..a933cffbee2e 100644
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
+ * The struct gendisk refcounted is incremeneted with get_gendisk() or
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

