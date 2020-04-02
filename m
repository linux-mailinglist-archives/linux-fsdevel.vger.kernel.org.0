Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92219B93B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgDBAAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 20:00:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43419 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbgDBAAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:00:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so624225ply.10;
        Wed, 01 Apr 2020 17:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vm+IPYywOxBkwyr7TKQH9BbZsRaS9vSqfzACF8qBlbo=;
        b=e1rLc8B8aJKzxPYn8uOzZ6D0p0nnn5Ii+IEh8aonCLNkHZcvLtidcer+LxxMjduCQw
         RXNLolG3HXSOcPtRMtGo/QzvI5GhtBSm7uHVWCXBmygZ4YNYL2ImK++lApPu6VPP+QgQ
         9t9FZOVhvQJPGhp3IdiY2nq5EqWG9l0gSSsfxo2Z00fsqCfkyBz5vZK99rnJt8ZIga8t
         J2Xzl96bMejZnnr3HCbzhjBEf1W3HLQS3Jb2ufoS5saU89cOLRTjRb2Q/JgoY/Uv6Hs2
         3If6d63MfxEqNdUpZ6U2QT3kvmnVGR/Fucw8U+FzK5KabzA1KBQE1+pw7KV8OsgC4Xy/
         uZbQ==
X-Gm-Message-State: AGi0PuYl08aelrDL+y1pFZ7KOjHywDznQo0/efCrQXy4k5FLEXfyzA+Y
        HdABba5Q11Mp3q/YSFeuinM=
X-Google-Smtp-Source: APiQypKV6AYf89cCEMicViLa7eFHdETMC/+pi997inC3D16Iti5incZo5Y11kbr1GFTvBYkvHkXSDg==
X-Received: by 2002:a17:902:788e:: with SMTP id q14mr409569pll.72.1585785614675;
        Wed, 01 Apr 2020 17:00:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id np4sm2615858pjb.48.2020.04.01.17.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:00:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B29F041DCA; Thu,  2 Apr 2020 00:00:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC 3/3] block: avoid deferral of blk_release_queue() work
Date:   Thu,  2 Apr 2020 00:00:02 +0000
Message-Id: <20200402000002.7442-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200402000002.7442-1-mcgrof@kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") moved
the blk_release_queue() into a workqueue after a splat floated around
with some work here which could sleep in blk_exit_rl().

On recent commit db6d9952356 ("block: remove request_list code") though
Jens Axboe removed this code, now merged since v5.0. We no longer have
to defer this work.

By doing this we also avoid failing to detach / attach a block
device with a BLKTRACESETUP. This issue can be reproduced with
break-blktrace [0] using:

  break-blktrace -c 10 -d -s

The kernel does not crash without this commit, it just fails to
create the block device because the prior block device removal
deferred work is pending. After this commit we can use the above
flaky use of blktrace without an issue.

[0] https://github.com/mcgrof/break-blktrace

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Suggested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-sysfs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 20f20b0fa0b9..f159b40899ee 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -862,8 +862,8 @@ static void blk_exit_queue(struct request_queue *q)
 
 
 /**
- * __blk_release_queue - release a request queue
- * @work: pointer to the release_work member of the request queue to be released
+ * blk_release_queue - release a request queue
+ * @kojb: pointer to the kobj representing the request queue
  *
  * Description:
  *     This function is called when a block device is being unregistered. The
@@ -873,9 +873,10 @@ static void blk_exit_queue(struct request_queue *q)
  *     of the request queue reaches zero, blk_release_queue is called to release
  *     all allocated resources of the request queue.
  */
-static void __blk_release_queue(struct work_struct *work)
+static void blk_release_queue(struct kobject *kobj)
 {
-	struct request_queue *q = container_of(work, typeof(*q), release_work);
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
@@ -905,15 +906,6 @@ static void __blk_release_queue(struct work_struct *work)
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
-- 
2.25.1

