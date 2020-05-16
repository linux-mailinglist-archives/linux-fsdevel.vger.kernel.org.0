Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B091D5E20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEPDUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:20:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40964 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgEPDUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:20:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id a13so143306pls.8;
        Fri, 15 May 2020 20:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCDwLQi1PpbdvFBz7RmcKLTv5dT9VmGJINCbFT46M0w=;
        b=UEoxdaD5liTtHJ14DqCJiQghSWIOAfDSitFSy7pCZ5BZAofHwNhRQsBNkVvwU4pfyZ
         8FYu3VcacSyxmgAbMh8s9td3Ge+3EXO1mKwKHzkBa9qF87CqD4OuOamScIEdjkYaWl4L
         2rx+DLGm8pTdUlUxhopstBMotNPVkfKpeS9uhHcRQQE2xznHs598wMKxBzEfnNpjMHgd
         P/TAowjJv+g1l/s5b54hfxMoXxSSHlvUQ22o5Mw+D9AEPqrZKzgcfONhN9Tp8QHyZ0yG
         IgHWjVATgn1nSCEX6TuD/ZawifkDsFbifWlKOlBh4evWdMBjFGhVFW5ULFyou1uR6oB7
         2JQA==
X-Gm-Message-State: AOAM531Xt3cZU0wMzlmTeeTLWsjq+nrFp5wkdEPRQd2cND80NNRS5qQx
        9JVaslly4DovFM2i7jFBTSQ=
X-Google-Smtp-Source: ABdhPJxpGP7LvR9debKxwG1zTA36KDJdf4RiTOPKJOGNpD6KGRlHrMWrKlnSOeY5IVOuPx6JE3OiNQ==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr6268304plb.71.1589599201625;
        Fri, 15 May 2020 20:20:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 188sm16835pfu.165.2020.05.15.20.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:20:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C0C7D41381; Sat, 16 May 2020 03:19:58 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 1/7] block: add docs for gendisk / request_queue refcount helpers
Date:   Sat, 16 May 2020 03:19:50 +0000
Message-Id: <20200516031956.2605-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200516031956.2605-1-mcgrof@kernel.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds documentation for the gendisk / request_queue refcount
helpers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c | 13 +++++++++++++
 block/genhd.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5847993738f1..e438c3b0815b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -321,6 +321,13 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
+/**
+ * blk_put_queue - decrement the request_queue refcount
+ * @q: the request_queue structure to decrement the refcount for
+ *
+ * Decrements the refcount of the request_queue kobject. When this reaches 0
+ * we'll have blk_release_queue() called.
+ */
 void blk_put_queue(struct request_queue *q)
 {
 	kobject_put(&q->kobj);
@@ -598,6 +605,12 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+/**
+ * blk_get_queue - increment the request_queue refcount
+ * @q: the request_queue structure to increment the refcount for
+ *
+ * Increment the refcount of the request_queue kobject.
+ */
 bool blk_get_queue(struct request_queue *q)
 {
 	if (likely(!blk_queue_dying(q))) {
diff --git a/block/genhd.c b/block/genhd.c
index afdb2c3e5b22..af910e6a0233 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -908,6 +908,20 @@ static void invalidate_partition(struct gendisk *disk, int partno)
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
+ */
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
@@ -1539,6 +1553,23 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
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
+ */
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -1748,6 +1779,13 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
+/**
+ * get_disk_and_module - increments the gendisk and gendisk fops module refcount
+ * @disk: the struct gendisk to to increment the refcount for
+ *
+ * This increments the refcount for the struct gendisk, and the gendisk's
+ * fops module owner.
+ */
 struct kobject *get_disk_and_module(struct gendisk *disk)
 {
 	struct module *owner;
@@ -1768,6 +1806,13 @@ struct kobject *get_disk_and_module(struct gendisk *disk)
 }
 EXPORT_SYMBOL(get_disk_and_module);
 
+/**
+ * put_disk - decrements the gendisk refcount
+ * @disk: the struct gendisk to to decrement the refcount for
+ *
+ * This decrements the refcount for the struct gendisk. When this reaches 0
+ * we'll have disk_release() called.
+ */
 void put_disk(struct gendisk *disk)
 {
 	if (disk)
@@ -1775,7 +1820,10 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
-/*
+/**
+ * put_disk_and_module - decrements the module and gendisk refcount
+ * @disk: the struct gendisk to to decrement the refcount for
+ *
  * This is a counterpart of get_disk_and_module() and thus also of
  * get_gendisk().
  */
-- 
2.26.2

