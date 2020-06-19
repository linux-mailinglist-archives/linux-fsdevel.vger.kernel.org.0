Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75E2201CB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391480AbgFSUsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:48:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55531 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390846AbgFSUrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:39 -0400
Received: by mail-pj1-f66.google.com with SMTP id ne5so4532577pjb.5;
        Fri, 19 Jun 2020 13:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2yimRzl8Lw3YXqKnlvPORVOiA/F0uPiDUWZ3ls2daA=;
        b=HCTVEt2+mSLqPeZ4IEPM96KM9vpsSKoyzAlVW9mlGNxFe8pRHyJ7oyYRxQ/FJdy7Up
         p/gt0vPwtJHmdksUs02iiuOxvzRJAMtRQ0PJv0qGge5soNSDJndI81+GpoeChVFIiPFw
         079S1CxLQaAg1Sb5wbHoKCsJZ0H2QZGaHSrEU0LGhoAnuerC5gwfHuh+Cd/nz9Gwhkmg
         b6TbV1JELo3KMe3Dgyu3c8Ev5LSisYNzmF2925N94j5wlFAmlf/A9vLymx0LJVDSMNFm
         aAOV3QVz4hLDXwfAUHR0osjak6pmIS9vf89WQWhFIk7uKnxSHT1d6tgdNBZE3FJCv0bX
         komg==
X-Gm-Message-State: AOAM5338OJYiCbFfW+BXxcSmVM1mwc+/kJRotVetixx3ayk9qTYmQuha
        m6fJuVeh6lWBsg23hyOvyjE=
X-Google-Smtp-Source: ABdhPJxFRWJeGBF/KVpIZjDjuYUsWmT39p655O9+P8pTa/kXrFWjOjoAArzLFFiiosUU3pALUbXUqw==
X-Received: by 2002:a17:90a:21a2:: with SMTP id q31mr5337450pjc.230.1592599656355;
        Fri, 19 Jun 2020 13:47:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z8sm5863127pjr.41.2020.06.19.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5665341D25; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 3/8] block: revert back to synchronous request_queue removal
Date:   Fri, 19 Jun 2020 20:47:25 +0000
Message-Id: <20200619204730.26124-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
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

blk_put_queue() decrements the refcount for the request_queue kobject, and
upon reaching 0 blk_release_queue() is called. Although blk_exit_rl() is
now removed through commit db6d99523560 ("block: remove request_list code")
on v5.0, we reserve the right to be able to sleep within
blk_release_queue() context.

The last reference for the request_queue must not be called from atomic
context. *When* the last reference to the request_queue reaches 0 varies,
and so let's take the opportunity to document when that is expected to
happen and also document the context of the related calls as best as
possible so we can avoid future issues, and with the hopes that the
synchronous request_queue removal sticks.

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

While at it, update the docs with the context expectations for the
request_queue / gendisk refcount decrement, and make these
expectations explicit by using might_sleep().

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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c       |  8 ++++++++
 block/blk-sysfs.c      | 43 +++++++++++++++++++++---------------------
 block/genhd.c          | 17 +++++++++++++++++
 include/linux/blkdev.h |  2 --
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14c09daf55f3..a5126c0be777 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -327,6 +327,9 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
  *
  * Decrements the refcount of the request_queue kobject. When this reaches 0
  * we'll have blk_release_queue() called.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
  */
 void blk_put_queue(struct request_queue *q)
 {
@@ -359,9 +362,14 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
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
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 02643e149d5e..561624d4cc4e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -873,22 +873,32 @@ static void blk_exit_queue(struct request_queue *q)
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
@@ -917,15 +927,6 @@ static void __blk_release_queue(struct work_struct *work)
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
index 1be86b1f43ec..60ae4e1b4d38 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -889,12 +889,19 @@ static void invalidate_partition(struct gendisk *disk, int partno)
  * The final removal of the struct gendisk happens when its refcount reaches 0
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
+ *
+ * Drivers exist which depend on the release of the gendisk to be synchronous,
+ * it should not be deferred.
+ *
+ * Context: can sleep
  */
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
+	might_sleep();
+
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -1548,11 +1555,15 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
  * drivers we also call blk_put_queue() for them, and we expect the
  * request_queue refcount to reach 0 at this point, and so the request_queue
  * will also be freed prior to the disk.
+ *
+ * Context: can sleep
  */
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	might_sleep();
+
 	blk_free_devt(dev->devt);
 	disk_release_events(disk);
 	kfree(disk->random);
@@ -1797,6 +1808,9 @@ EXPORT_SYMBOL(get_disk_and_module);
  *
  * This decrements the refcount for the struct gendisk. When this reaches 0
  * we'll have disk_release() called.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
  */
 void put_disk(struct gendisk *disk)
 {
@@ -1811,6 +1825,9 @@ EXPORT_SYMBOL(put_disk);
  *
  * This is a counterpart of get_disk_and_module() and thus also of
  * get_gendisk().
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ *          atomic context.
  */
 void put_disk_and_module(struct gendisk *disk)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6e067dca94cf..780d6fa94746 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -584,8 +584,6 @@ struct request_queue {
 
 	size_t			cmd_size;
 
-	struct work_struct	release_work;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.26.2

