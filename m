Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741E40840E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhIMFwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhIMFwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:52:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC28C061574;
        Sun, 12 Sep 2021 22:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UXp+fCkzH2CgbRglk3bxc6R/C42uMSQO+IFVmi1XBWI=; b=vmxsq3hppe0dYahL5qFfdE0tJ/
        2ShQjICI/kC6mB0ChKBLQCxgBaPncDLqYiqspAn8/f3LAksAHTBQN8enw54iej21JfpBYEdEGCx8K
        gN27kY46iMty53v/i5rvgM3b7Etf6H8IeufhJa+NSlW9l+OPurYcO7QupS6LRgUF7JA+h3Mrtgpfk
        qilZ9npxNVyQcks4Lm6ScYT0C/Q9ncJXUQNcqwB1nMLHt1FY1hvv6YuLrkBZBXyogxMnA11ws0OAW
        MukKRHZwlaUwA2v9Aw1nnQ4yzCAC+pyiCUENgniEg0QxeJM+sisbE/1N4tcvvoshVVgSmon0NS74A
        iEJ88Rgg==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPepg-00DCsG-Kh; Mon, 13 Sep 2021 05:49:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] block: convert the blk_mq_hw_ctx attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:16 +0200
Message-Id: <20210913054121.616001-9-hch@lst.de>
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
 block/blk-mq-sysfs.c | 64 +++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 253c857cba47c..cae649b83bd54 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -47,29 +47,27 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 
 struct blk_mq_hw_ctx_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct blk_mq_hw_ctx *, char *);
-	ssize_t (*store)(struct blk_mq_hw_ctx *, const char *, size_t);
+	void (*show)(struct blk_mq_hw_ctx *hctx, struct seq_file *sf);
+	ssize_t (*store)(struct blk_mq_hw_ctx *hctx, const char *buf,
+			size_t size);
 };
 
-static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
-				    struct attribute *attr, char *page)
+static int blk_mq_hw_sysfs_seq_show(struct kobject *kobj,
+		struct attribute *attr, struct seq_file *sf)
 {
-	struct blk_mq_hw_ctx_sysfs_entry *entry;
-	struct blk_mq_hw_ctx *hctx;
-	struct request_queue *q;
-	ssize_t res;
-
-	entry = container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
-	hctx = container_of(kobj, struct blk_mq_hw_ctx, kobj);
-	q = hctx->queue;
+	struct blk_mq_hw_ctx_sysfs_entry *entry =
+		container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
+	struct blk_mq_hw_ctx *hctx =
+		container_of(kobj, struct blk_mq_hw_ctx, kobj);
+	struct request_queue *q = hctx->queue;
 
 	if (!entry->show)
 		return -EIO;
 
 	mutex_lock(&q->sysfs_lock);
-	res = entry->show(hctx, page);
+	entry->show(hctx, sf);
 	mutex_unlock(&q->sysfs_lock);
-	return res;
+	return 0;
 }
 
 static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
@@ -94,39 +92,33 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 	return res;
 }
 
-static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
-					    char *page)
+static void blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", hctx->tags->nr_tags);
+	seq_printf(sf, "%u\n", hctx->tags->nr_tags);
 }
 
-static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
-						     char *page)
+static void blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
+	seq_printf(sf, "%u\n", hctx->tags->nr_reserved_tags);
 }
 
-static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
+static void blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx,
+		struct seq_file *sf)
 {
-	const size_t size = PAGE_SIZE - 1;
-	unsigned int i, first = 1;
-	int ret = 0, pos = 0;
+	bool first = true;
+	unsigned int i;
 
 	for_each_cpu(i, hctx->cpumask) {
 		if (first)
-			ret = snprintf(pos + page, size - pos, "%u", i);
+			seq_printf(sf, "%u", i);
 		else
-			ret = snprintf(pos + page, size - pos, ", %u", i);
-
-		if (ret >= size - pos)
-			break;
-
-		first = 0;
-		pos += ret;
+			seq_printf(sf, ", %u", i);
+		first = false;
 	}
 
-	ret = snprintf(pos + page, size + 1 - pos, "\n");
-	return pos + ret;
+	seq_printf(sf, "\n");
 }
 
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
@@ -151,8 +143,8 @@ static struct attribute *default_hw_ctx_attrs[] = {
 ATTRIBUTE_GROUPS(default_hw_ctx);
 
 static const struct sysfs_ops blk_mq_hw_sysfs_ops = {
-	.show	= blk_mq_hw_sysfs_show,
-	.store	= blk_mq_hw_sysfs_store,
+	.seq_show	= blk_mq_hw_sysfs_seq_show,
+	.store		= blk_mq_hw_sysfs_store,
 };
 
 static struct kobj_type blk_mq_ktype = {
-- 
2.30.2

