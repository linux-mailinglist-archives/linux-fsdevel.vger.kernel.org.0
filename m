Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D431A3C14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgDIVpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:45:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35821 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgDIVpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:45:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id a13so150286pfa.2;
        Thu, 09 Apr 2020 14:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyMpnPWw/Y2hF5e4RISVaGw9GiKX0YRBleN8UhVQook=;
        b=YJ+nz4rMd3JuBzciDjM9mfLQMlgLNeYgMX7/uFZ3GzJq5A2n3WlXILUDSNG4Vk+E/J
         JWvCwx5+10EriDpGb+dicExUAI/8RMyHE8xstMEEyApntAl3s6Wp0ysS3Eg2DOEP6YFg
         gLYjFuL+yD1xHqQadgaNKaqIAmq+wkkGmzm8qNlv5c7pzPVAALquucHfRiyrAA9tcFvw
         JDOY6JCiRpaNBdXu9ftm24HIDisyMxQOS7opV7CaHCfBGYNHqanUZ5pi1HZmxu3bO0a7
         JqJDWRGQhZyZdJYRuypclhg5eUEzs8CsL4W3Ad9h7vyF9+m1wVtakhGoxz0/HI74HWht
         tD0w==
X-Gm-Message-State: AGi0PubpGSACpfuBaKveVabGZwI2fxmDz0SPYL2IrJdxWPIph822IUvH
        m7+oGTsjhy8OsQ8nztDVTMk=
X-Google-Smtp-Source: APiQypL2c8CK9HLPDrIBFDxSQIJ2+qEM1rtn9Tgz5zxuYIUXNV4bsvZbJNQbtegiTbkBK3QjOXl2Dw==
X-Received: by 2002:a63:d512:: with SMTP id c18mr1420081pgg.347.1586468740119;
        Thu, 09 Apr 2020 14:45:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w134sm65241pfd.41.2020.04.09.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:45:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7115241DAB; Thu,  9 Apr 2020 21:45:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC v2 5/5] block: revert back to synchronous request_queue removal
Date:   Thu,  9 Apr 2020 21:45:30 +0000
Message-Id: <20200409214530.2413-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200409214530.2413-1-mcgrof@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
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

blk_put_queue() puts decrements the refcount for the request_queue
kobject, and upon reaching 0 blk_release_queue() is called. Although
blk_exit_rl() is now removed through commit db6d9952356 ("block: remove
request_list code"), we reserve the right to be able to sleep within
blk_release_queue() context. There should be little reason to
defer removal from atomic context these days, as you can always just
increase your block device's reference count even in atomic context and
leave the removal for the request_queue to the upper layers later.
However if you really need to defer removal of the request_queue, you can
set the queue flag QUEUE_FLAG_DEFER_REMOVAL now.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-sysfs.c      | 40 ++++++++++++++++++++++++++++++++--------
 include/linux/blkdev.h |  3 +++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 20f20b0fa0b9..2ae8c39c88ef 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -860,10 +860,9 @@ static void blk_exit_queue(struct request_queue *q)
 	bdi_put(q->backing_dev_info);
 }
 
-
 /**
- * __blk_release_queue - release a request queue
- * @work: pointer to the release_work member of the request queue to be released
+ * blk_release_queue_sync- release a request queue
+ * @q: pointer to the request queue to be released
  *
  * Description:
  *     This function is called when a block device is being unregistered. The
@@ -872,11 +871,27 @@ static void blk_exit_queue(struct request_queue *q)
  *     the reference counter of the request queue. Once the reference counter
  *     of the request queue reaches zero, blk_release_queue is called to release
  *     all allocated resources of the request queue.
+ *
+ *     There are two approaches to releasing the request queue, by default
+ *     we reserve the right to sleep on release and so release is synchronous.
+ *     If you know the path under which blk_cleanup_queue() or your last
+ *     blk_put_queue() is called can be called in atomic context you want to
+ *     ensure to defer the removal by setting the QUEUE_FLAG_DEFER_REMOVAL
+ *     flag as follows upon initialization:
+ *
+ *     blk_queue_flag_set(QUEUE_FLAG_DEFER_REMOVAL, q)
+ *
+ *     Note that deferring removal may have implications for userspace. An
+ *     example is if you are using an ioctl to allow removal of a block device,
+ *     and the kernel returns immediately even though the device may only
+ *     disappear after the full removal is completed.
+ *
+ *     You should also be able to work around this by just increasing the
+ *     refcount for the block device instead during your atomic operation,
+ *     and so QUEUE_FLAG_DEFER_REMOVAL should almost never be required.
  */
-static void __blk_release_queue(struct work_struct *work)
+static void blk_release_queue_sync(struct request_queue *q)
 {
-	struct request_queue *q = container_of(work, typeof(*q), release_work);
-
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
@@ -905,13 +920,22 @@ static void __blk_release_queue(struct work_struct *work)
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
+void __blk_release_queue(struct work_struct *work)
+{
+	struct request_queue *q = container_of(work, typeof(*q), release_work);
+
+	blk_release_queue_sync(q);
+}
+
 static void blk_release_queue(struct kobject *kobj)
 {
 	struct request_queue *q =
 		container_of(kobj, struct request_queue, kobj);
 
-	INIT_WORK(&q->release_work, __blk_release_queue);
-	schedule_work(&q->release_work);
+	if (blk_queue_defer_removal(q))
+		schedule_work(&q->release_work);
+	else
+		blk_release_queue_sync(q);
 }
 
 static const struct sysfs_ops queue_sysfs_ops = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8b1cab52cef9..46fee1ef92e3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -614,6 +614,7 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_DEFER_REMOVAL 28	/* defer queue removal */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -648,6 +649,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #else
 #define blk_queue_rq_alloc_time(q)	false
 #endif
+#define blk_queue_defer_removal(q) \
+	test_bit(QUEUE_FLAG_DEFER_REMOVAL, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.25.1

