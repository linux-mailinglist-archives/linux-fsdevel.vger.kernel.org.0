Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086E408441
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhIMF55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbhIMF54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:57:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A740C061574;
        Sun, 12 Sep 2021 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sQ7WZDPB/0FsX6UYbW3121WLPwXJuFVnksnNbQSfWlE=; b=W27ZPTjzCZrYvlYKGYXbNMlly1
        i0Xk84aAEWiw04y7JFEf2rrJ6Qxn/HXIRq0MFKFtoWxbqBnL746ac5D/3Jo7X9GUp9DoPVomyY0AF
        KIPOBQbe/6BPSQTnT5Cn+dF/q9nyXLN5383o0vBND/UTdSpNVS+FTiEL7D36UFqvFG/GZRRw8f/sF
        3NdY+JVBlR39pewg1ZQGIBVIplsfRklHQMvHrBeo3uckOJ6rzJbHBtHzgfJHGi18OFMPOBikA/FIv
        N8D4mjW7mrBFpTTrUiXNo/4/7qyNEN9aMg2P4WRRLK5yNpm7+V0erkqZmebjPglU2qsRjRB8YgKUY
        CpD6hNuQ==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPesc-00DD0b-W1; Mon, 13 Sep 2021 05:52:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] block: convert the elevator_queue attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:19 +0200
Message-Id: <20210913054121.616001-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial conversion to the seq_file based sysfs attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c      | 12 ++++++------
 block/elevator.c         | 21 ++++++++++++---------
 block/kyber-iosched.c    |  7 ++++---
 block/mq-deadline.c      |  5 +++--
 include/linux/elevator.h |  2 +-
 5 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dd13c2bbc29c1..a72b4f90f3ba2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7092,9 +7092,9 @@ static int __init bfq_slab_setup(void)
 	return 0;
 }
 
-static ssize_t bfq_var_show(unsigned int var, char *page)
+static void bfq_var_show(unsigned int var, struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", var);
+	seq_printf(sf, "%u\n", var);
 }
 
 static int bfq_var_store(unsigned long *var, const char *page)
@@ -7109,7 +7109,7 @@ static int bfq_var_store(unsigned long *var, const char *page)
 }
 
 #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
-static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
+static void  __FUNC(struct elevator_queue *e, struct seq_file *sf)	\
 {									\
 	struct bfq_data *bfqd = e->elevator_data;			\
 	u64 __data = __VAR;						\
@@ -7117,7 +7117,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 		__data = jiffies_to_msecs(__data);			\
 	else if (__CONV == 2)						\
 		__data = div_u64(__data, NSEC_PER_MSEC);		\
-	return bfq_var_show(__data, (page));				\
+	bfq_var_show(__data, (sf));					\
 }
 SHOW_FUNCTION(bfq_fifo_expire_sync_show, bfqd->bfq_fifo_expire[1], 2);
 SHOW_FUNCTION(bfq_fifo_expire_async_show, bfqd->bfq_fifo_expire[0], 2);
@@ -7131,12 +7131,12 @@ SHOW_FUNCTION(bfq_low_latency_show, bfqd->low_latency, 0);
 #undef SHOW_FUNCTION
 
 #define USEC_SHOW_FUNCTION(__FUNC, __VAR)				\
-static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
+static void __FUNC(struct elevator_queue *e, struct seq_file *sf)	\
 {									\
 	struct bfq_data *bfqd = e->elevator_data;			\
 	u64 __data = __VAR;						\
 	__data = div_u64(__data, NSEC_PER_USEC);			\
-	return bfq_var_show(__data, (page));				\
+	bfq_var_show(__data, (sf));					\
 }
 USEC_SHOW_FUNCTION(bfq_slice_idle_us_show, bfqd->bfq_slice_idle);
 #undef USEC_SHOW_FUNCTION
diff --git a/block/elevator.c b/block/elevator.c
index f068585f2f9b8..951bae559e5cb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -442,21 +442,24 @@ struct request *elv_former_request(struct request_queue *q, struct request *rq)
 
 #define to_elv(atr) container_of((atr), struct elv_fs_entry, attr)
 
-static ssize_t
-elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
+static int elv_attr_seq_show(struct kobject *kobj, struct attribute *attr,
+		struct seq_file *sf)
 {
 	struct elv_fs_entry *entry = to_elv(attr);
-	struct elevator_queue *e;
-	ssize_t error;
+	struct elevator_queue *e =
+		container_of(kobj, struct elevator_queue, kobj);
 
 	if (!entry->show)
 		return -EIO;
 
-	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = e->type ? entry->show(e, page) : -ENOENT;
+	if (!e->type) {
+		mutex_unlock(&e->sysfs_lock);
+		return -ENOENT;
+	}
+	entry->show(e, sf);
 	mutex_unlock(&e->sysfs_lock);
-	return error;
+	return 0;
 }
 
 static ssize_t
@@ -478,8 +481,8 @@ elv_attr_store(struct kobject *kobj, struct attribute *attr,
 }
 
 static const struct sysfs_ops elv_sysfs_ops = {
-	.show	= elv_attr_show,
-	.store	= elv_attr_store,
+	.seq_show	= elv_attr_seq_show,
+	.store		= elv_attr_store,
 };
 
 static struct kobj_type elv_ktype = {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 15a8be57203d6..633f9654b99b9 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -12,6 +12,7 @@
 #include <linux/elevator.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
+#include <linux/seq_file.h>
 
 #include <trace/events/block.h>
 
@@ -857,12 +858,12 @@ static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
 }
 
 #define KYBER_LAT_SHOW_STORE(domain, name)				\
-static ssize_t kyber_##name##_lat_show(struct elevator_queue *e,	\
-				       char *page)			\
+static void kyber_##name##_lat_show(struct elevator_queue *e,		\
+		struct seq_file *sf)					\
 {									\
 	struct kyber_queue_data *kqd = e->elevator_data;		\
 									\
-	return sprintf(page, "%llu\n", kqd->latency_targets[domain]);	\
+	seq_printf(sf, "%llu\n", kqd->latency_targets[domain]);		\
 }									\
 									\
 static ssize_t kyber_##name##_lat_store(struct elevator_queue *e,	\
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7f3c3932b723e..0e1fc6d3e5d64 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
+#include <linux/seq_file.h>
 
 #include <trace/events/block.h>
 
@@ -800,11 +801,11 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
  * sysfs parts below
  */
 #define SHOW_INT(__FUNC, __VAR)						\
-static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
+static void __FUNC(struct elevator_queue *e, struct seq_file *sf)	\
 {									\
 	struct deadline_data *dd = e->elevator_data;			\
 									\
-	return sysfs_emit(page, "%d\n", __VAR);				\
+	seq_printf(sf, "%d\n", __VAR);					\
 }
 #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
 SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index deecf7f9ff21a..ad5e4cb653a30 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -56,7 +56,7 @@ struct elevator_mq_ops {
 
 struct elv_fs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct elevator_queue *, char *);
+	void (*show)(struct elevator_queue *eq, struct seq_file *sf);
 	ssize_t (*store)(struct elevator_queue *, const char *, size_t);
 };
 
-- 
2.30.2

