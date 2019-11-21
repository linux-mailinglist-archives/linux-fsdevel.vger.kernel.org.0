Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37F1050BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUKkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 05:40:32 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:49232 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfKUKkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:40:31 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 235CB2E18F1;
        Thu, 21 Nov 2019 13:40:27 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 8k5UtZBVOc-eQuieGpg;
        Thu, 21 Nov 2019 13:40:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1574332827; bh=jJPE2lkmi4is3srgVXQWiJk3+sodk/rEZ57R5XJTD2A=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=VdaT6ljRC2SUcekXlATqcMbKCncFOBIm5Zi1cy5Wj8O8rszKGb1kg2Akj6jgw+oED
         0vQAdkbhCN4PU6T6/QE5xPLDLlw4ALeDhv7F1coCZUilJKIdu8gY1gJGOGCisicojB
         8wTDqm+7Xp+WAXkdqGO9YIjiisnLX3FS2MV6X+Z4=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:1009:4fae:ad87:4eae])
        by vla5-2bf13a090f43.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4uiq2DmQw7-eQV4np4t;
        Thu, 21 Nov 2019 13:40:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] block: add iostat counters for flush requests
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Thu, 21 Nov 2019 13:40:26 +0300
Message-ID: <157433282607.7928.5202409984272248322.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Requests that triggers flushing volatile writeback cache to disk (barriers)
have significant effect to overall performance.

Block layer has sophisticated engine for combining several flush requests
into one. But there is no statistics for actual flushes executed by disk.
Requests which trigger flushes usually are barriers - zero-size writes.

This patch adds two iostat counters into /sys/class/block/$dev/stat and
/proc/diskstats - count of completed flush requests and their total time.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/ABI/testing/procfs-diskstats |    5 +++++
 Documentation/ABI/testing/sysfs-block      |    6 ++++++
 Documentation/admin-guide/iostats.rst      |    9 +++++++++
 Documentation/block/stat.rst               |   14 ++++++++++++--
 block/blk-flush.c                          |   15 ++++++++++++++-
 block/genhd.c                              |    8 ++++++--
 block/partition-generic.c                  |    7 +++++--
 include/linux/blk_types.h                  |    1 +
 8 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index 2c44b4f1b060..70dcaf2481f4 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -29,4 +29,9 @@ Description:
 		17 - sectors discarded
 		18 - time spent discarding
 
+		Kernel 5.5+ appends two more fields for flush requests:
+
+		19 - flush requests completed successfully
+		20 - time spent flushing
+
 		For more details refer to Documentation/admin-guide/iostats.rst
diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index f8c7c7126bb1..ed8c14f161ee 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -15,6 +15,12 @@ Description:
 		 9 - I/Os currently in progress
 		10 - time spent doing I/Os (ms)
 		11 - weighted time spent doing I/Os (ms)
+		12 - discards completed
+		13 - discards merged
+		14 - sectors discarded
+		15 - time spent discarding (ms)
+		16 - flush requests completed
+		17 - time spent flushing (ms)
 		For more details refer Documentation/admin-guide/iostats.rst
 
 
diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 5d63b18bd6d1..4f0462af3ca7 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -121,6 +121,15 @@ Field 15 -- # of milliseconds spent discarding
     This is the total number of milliseconds spent by all discards (as
     measured from __make_request() to end_that_request_last()).
 
+Field 16 -- # of flush requests completed
+    This is the total number of flush requests completed successfully.
+
+    Block layer combines flush requests and executes at most one at a time.
+    This counts flush requests executed by disk. Not tracked for partitions.
+
+Field 17 -- # of milliseconds spent flushing
+    This is the total number of milliseconds spent by all flush requests.
+
 To avoid introducing performance bottlenecks, no locks are held while
 modifying these counters.  This implies that minor inaccuracies may be
 introduced when changes collide, so (for instance) adding up all the
diff --git a/Documentation/block/stat.rst b/Documentation/block/stat.rst
index 9c07bc22b0bc..77311335c08b 100644
--- a/Documentation/block/stat.rst
+++ b/Documentation/block/stat.rst
@@ -41,6 +41,8 @@ discard I/Os    requests      number of discard I/Os processed
 discard merges  requests      number of discard I/Os merged with in-queue I/O
 discard sectors sectors       number of sectors discarded
 discard ticks   milliseconds  total wait time for discard requests
+flush I/Os      requests      number of flush I/Os processed
+flush ticks     milliseconds  total wait time for flush requests
 =============== ============= =================================================
 
 read I/Os, write I/Os, discard I/0s
@@ -48,6 +50,14 @@ read I/Os, write I/Os, discard I/0s
 
 These values increment when an I/O request completes.
 
+flush I/Os
+==========
+
+These values increment when an flush I/O request completes.
+
+Block layer combines flush requests and executes at most one at a time.
+This counts flush requests executed by disk. Not tracked for partitions.
+
 read merges, write merges, discard merges
 =========================================
 
@@ -62,8 +72,8 @@ discarded from this block device.  The "sectors" in question are the
 standard UNIX 512-byte sectors, not any device- or filesystem-specific
 block size.  The counters are incremented when the I/O completes.
 
-read ticks, write ticks, discard ticks
-======================================
+read ticks, write ticks, discard ticks, flush ticks
+===================================================
 
 These values count the number of milliseconds that I/O requests have
 waited on this block device.  If there are multiple I/O requests waiting,
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1eec9cbe5a0a..1777346baf06 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -136,6 +136,17 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
 	blk_mq_add_to_requeue_list(rq, add_front, true);
 }
 
+static void blk_account_io_flush(struct request *rq)
+{
+	struct hd_struct *part = &rq->rq_disk->part0;
+
+	part_stat_lock();
+	part_stat_inc(part, ios[STAT_FLUSH]);
+	part_stat_add(part, nsecs[STAT_FLUSH],
+		      ktime_get_ns() - rq->start_time_ns);
+	part_stat_unlock();
+}
+
 /**
  * blk_flush_complete_seq - complete flush sequence
  * @rq: PREFLUSH/FUA request being sequenced
@@ -185,7 +196,7 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DONE:
 		/*
-		 * @rq was previously adjusted by blk_flush_issue() for
+		 * @rq was previously adjusted by blk_insert_flush() for
 		 * flush sequencing and may already have gone through the
 		 * flush data request completion path.  Restore @rq for
 		 * normal completion and end it.
@@ -212,6 +223,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 	struct blk_mq_hw_ctx *hctx;
 
+	blk_account_io_flush(flush_rq);
+
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
diff --git a/block/genhd.c b/block/genhd.c
index 26b31fcae217..ff6268970ddc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1385,7 +1385,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
 			   "%u %u %u "
-			   "%lu %lu %lu %u\n",
+			   "%lu %lu %lu %u "
+			   "%lu %u"
+			   "\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
@@ -1402,7 +1404,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   part_stat_read(hd, ios[STAT_DISCARD]),
 			   part_stat_read(hd, merges[STAT_DISCARD]),
 			   part_stat_read(hd, sectors[STAT_DISCARD]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD)
+			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
+			   part_stat_read(hd, ios[STAT_FLUSH]),
+			   (unsigned int)part_stat_read_msecs(hd, STAT_FLUSH)
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index aee643ce13d1..3db8b73a96b1 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -127,7 +127,8 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u"
+		"%8lu %8lu %8llu %8u "
+		"%8lu %8u"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
@@ -143,7 +144,9 @@ ssize_t part_stat_show(struct device *dev,
 		part_stat_read(p, ios[STAT_DISCARD]),
 		part_stat_read(p, merges[STAT_DISCARD]),
 		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
-		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD));
+		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
+		part_stat_read(p, ios[STAT_FLUSH]),
+		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d688b96d1d63..b811a673a300 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -371,6 +371,7 @@ enum stat_group {
 	STAT_READ,
 	STAT_WRITE,
 	STAT_DISCARD,
+	STAT_FLUSH,
 
 	NR_STAT_GROUPS
 };

