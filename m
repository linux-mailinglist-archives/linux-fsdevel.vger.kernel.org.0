Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2053408412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhIMFwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhIMFwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:52:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D584C061574;
        Sun, 12 Sep 2021 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8YEdkJerf6mQ5SzK6FEJIXN9xpaT7uYrq3tnYce5GtA=; b=v6ZhPrKZsQ1WlqIcHFdq6m+o4n
        ys5bAv3eFp2kXT3WJEXZGqW+d1GH+oOCYfrP7V+/LelBzJE9Lb8FGGIj6WG74UTEtJ70mXzKz2k6E
        qHjVFxDuV0Jv/SGndnmv9im2LB5PooCUjWel+sKzYpXERTo912pGeOs4WUS9zlW2DbpaqMR8iEhj2
        cYlL0laTN3CrByC3iw4FLpFRkC/e0oNdA2xLPRkg9sEPr/v9TVZR4CEbRahBxSxT1kNZcYfzhNIJz
        zVYhEr/cDPp8NDwKYCj5BoQ+oYmnt/ZrfO+6mk8TXmzPXAbW7ZH12gxM3prCPuEnGuD9iwbwiq+W8
        qxPOGCdQ==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPeqq-00DCva-2e; Mon, 13 Sep 2021 05:50:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] block: convert the blk_integrity attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:17 +0200
Message-Id: <20210913054121.616001-10-hch@lst.de>
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
 block/blk-integrity.c | 44 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69a12177dfb62..dca753b395539 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -214,19 +214,20 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 
 struct integrity_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct blk_integrity *, char *);
+	void (*show)(struct blk_integrity *bi, struct seq_file *sf);
 	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
 };
 
-static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
-				   char *page)
+static int integrity_attr_seq_show(struct kobject *kobj,
+		struct attribute *attr, struct seq_file *sf)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
 	struct blk_integrity *bi = &disk->queue->integrity;
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
 
-	return entry->show(bi, page);
+	entry->show(bi, sf);
+	return 0;
 }
 
 static ssize_t integrity_attr_store(struct kobject *kobj,
@@ -245,23 +246,24 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
+static void integrity_format_show(struct blk_integrity *bi, struct seq_file *sf)
 {
 	if (bi->profile && bi->profile->name)
-		return sprintf(page, "%s\n", bi->profile->name);
+		seq_printf(sf, "%s\n", bi->profile->name);
 	else
-		return sprintf(page, "none\n");
+		seq_printf(sf, "none\n");
 }
 
-static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
+static void integrity_tag_size_show(struct blk_integrity *bi,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", bi->tag_size);
+	seq_printf(sf, "%u\n", bi->tag_size);
 }
 
-static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
+static void integrity_interval_show(struct blk_integrity *bi,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%u\n",
-		       bi->interval_exp ? 1 << bi->interval_exp : 0);
+	seq_printf(sf, "%u\n", bi->interval_exp ? 1 << bi->interval_exp : 0);
 }
 
 static ssize_t integrity_verify_store(struct blk_integrity *bi,
@@ -278,9 +280,9 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
+static void integrity_verify_show(struct blk_integrity *bi, struct seq_file *sf)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
+	seq_printf(sf, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
 }
 
 static ssize_t integrity_generate_store(struct blk_integrity *bi,
@@ -297,15 +299,15 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
+static void integrity_generate_show(struct blk_integrity *bi,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
+	seq_printf(sf, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
 }
 
-static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
+static void integrity_device_show(struct blk_integrity *bi, struct seq_file *sf)
 {
-	return sprintf(page, "%u\n",
-		       (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
+	seq_printf(sf, "%u\n", (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
 }
 
 static struct integrity_sysfs_entry integrity_format_entry = {
@@ -352,8 +354,8 @@ static struct attribute *integrity_attrs[] = {
 ATTRIBUTE_GROUPS(integrity);
 
 static const struct sysfs_ops integrity_ops = {
-	.show	= &integrity_attr_show,
-	.store	= &integrity_attr_store,
+	.seq_show	= &integrity_attr_seq_show,
+	.store		= &integrity_attr_store,
 };
 
 static struct kobj_type integrity_ktype = {
-- 
2.30.2

