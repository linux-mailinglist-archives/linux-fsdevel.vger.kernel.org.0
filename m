Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E551A726D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405249AbgDNETX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:19:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35289 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405223AbgDNETL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:19:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id y12so3899772pll.2;
        Mon, 13 Apr 2020 21:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAvWimIn06L/ckTvHYJdjtyNjcqrQOPPMI8XJSOmgvI=;
        b=TIfxM8D5oRdCqOxeW1d9FUPdVVUcj7Zy044/kNNsybCmbboWxmLksiV+i6kkxjGbg2
         Op6uamCE+2oMyM/XwXSpiujQPMMApKgivdhBBemZ+meEmymc1SApQRhRxi4v4dacqLIc
         Ki7RJRnh9Y0mF70AJRHl4k8g4HemcgteFZiUk2qx2GDoKaCHcGm6c09QU3NHBq84CS4T
         cK7g5KOehHFMQ2z7E92BfUmXYx9uk7NOTghfYqpdUoX/BV+gQhQyEezEtBnjR3CfaF16
         2iIlP7l6Ze6lIaQQbr6H5SgCji4PFLX3W33J8FjAli3802C/mmBvWYcfXgaOmArflygQ
         zdCw==
X-Gm-Message-State: AGi0PuYBMTsMaGmOVakyo4xalvtKA7oWIZ7g7VomMZ/RkxQ2JTdF4Ewn
        IZw6h1VONSIrZ2fVx7PAQHzWQWHJzSs=
X-Google-Smtp-Source: APiQypIIV5QwziKUNQLFlwjUY+5TxLvww5Fasa/CK24h/7LqZeND5GJga3hHm43a7pojb0NsTeIXBg==
X-Received: by 2002:a17:90a:a602:: with SMTP id c2mr25226081pjq.135.1586837950844;
        Mon, 13 Apr 2020 21:19:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u18sm10164611pfl.40.2020.04.13.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:19:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 35461419C3; Tue, 14 Apr 2020 04:19:04 +0000 (UTC)
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
Subject: [PATCH 5/5] block: revert back to synchronous request_queue removal
Date:   Tue, 14 Apr 2020 04:19:02 +0000
Message-Id: <20200414041902.16769-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200414041902.16769-1-mcgrof@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
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

blk_put_queue() decrements the refcount for the request_queue
kobject, and upon reaching 0 blk_release_queue() is called. Although
blk_exit_rl() is now removed through commit db6d9952356 ("block: remove
request_list code"), we reserve the right to be able to sleep within
blk_release_queue() context. If you see no other way and *have* be
in atomic context when you driver calls the last blk_put_queue()
you can always just increase your block device's reference count with
bdgrab() as this can be done in atomic context and the request_queue
removal would be left to upper layers later. We document this bit of
tribal knowledge as well now, and adjust kdoc format a bit.

We revert back to synchronous request_queue removal because asynchronous
removal creates a regression with expected userspace interaction with
several drivers. An example is when removing the loopback driver and
issues ioctl from userspace to do so, upon return and if successful one
expects the device to be removed. Moving to asynchronous request_queue
removal could have broken many scripts which relied on the removal to
have been completed if there was no error.

Using asynchronous request_queue removal however has helped us find
other bugs, in the future we can test what could break with this
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
 block/blk-core.c       | 19 ++++++++++++++++++-
 block/blk-sysfs.c      | 38 +++++++++++++++++---------------------
 include/linux/blkdev.h |  2 --
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5aaae7a1b338..8346c7c59ee6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -301,6 +301,17 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
+/**
+ * blk_put_queue - decrement the request_queue refcount
+ *
+ * Decrements the refcount to the request_queue kobject, when this reaches
+ * 0 we'll have blk_release_queue() called. You should avoid calling
+ * this function in atomic context but if you really have to ensure you
+ * first refcount the block device with bdgrab() / bdput() so that the
+ * last decrement happens in blk_cleanup_queue().
+ *
+ * @q: the request_queue structure to decrement the refcount for
+ */
 void blk_put_queue(struct request_queue *q)
 {
 	kobject_put(&q->kobj);
@@ -328,10 +339,16 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
 /**
  * blk_cleanup_queue - shutdown a request queue
- * @q: request queue to shutdown
  *
  * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
  * put it.  All future requests will be failed immediately with -ENODEV.
+ *
+ * You should not call this function in atomic context. If you need to
+ * refcount a request_queue in atomic context, instead refcount the
+ * block device with bdgrab() / bdput().
+ *
+ * @q: request queue to shutdown
+ *
  */
 void blk_cleanup_queue(struct request_queue *q)
 {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0285d67e1e4c..859911191ebc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -860,22 +860,27 @@ static void blk_exit_queue(struct request_queue *q)
 	bdi_put(q->backing_dev_info);
 }
 
-
 /**
- * __blk_release_queue - release a request queue
- * @work: pointer to the release_work member of the request queue to be released
+ * blk_release_queue - release a request queue
+ *
+ * This function is called as part of the process when a block device is being
+ * unregistered. Releasing a request queue starts with blk_cleanup_queue(),
+ * which set the appropriate flags and then calls blk_put_queue() as the last
+ * step. blk_put_queue() decrements the reference counter of the request queue
+ * and once the reference counter reaches zero, this function is called to
+ * release all allocated resources of the request queue.
  *
- * Description:
- *     This function is called when a block device is being unregistered. The
- *     process of releasing a request queue starts with blk_cleanup_queue, which
- *     set the appropriate flags and then calls blk_put_queue, that decrements
- *     the reference counter of the request queue. Once the reference counter
- *     of the request queue reaches zero, blk_release_queue is called to release
- *     all allocated resources of the request queue.
+ * This function can sleep, and so we must ensure that the very last
+ * blk_put_queue() is never called from atomic context.
+ *
+ * @kobj: pointer to a kobject, who's container is a request_queue
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
@@ -905,15 +910,6 @@ static void __blk_release_queue(struct work_struct *work)
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cc43c8e6516c..81f7ddb1587e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -582,8 +582,6 @@ struct request_queue {
 
 	size_t			cmd_size;
 
-	struct work_struct	release_work;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.25.1

