Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDB1F1DFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgFHRBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:01:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46234 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbgFHRBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:01:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id p21so8985108pgm.13;
        Mon, 08 Jun 2020 10:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IR8sE8tegFIZFEE9c+9scyuraOZnu4HrFVBH9bLfdFU=;
        b=ONKj/SgCOoavM5X1uVQKx0vtnaNkVXxBKTlx3qpecjraPrfkdUa/IDRa84Din9cKfo
         Lv892KVL4Na0XvwtVOrFZaUe1OgOaUf3wiBnRPJkEVDpU8It883mttR+ksSN5JIp8Vxo
         Y2lZHFooMNibcHusm0/uFrxVhZSVBgdCZqQZpiYaY/8ikG3O7s+sAGBhXOW8GfJmYKx7
         ZKGtGJq42DCHCKUtWWa+qY+Xb/uWn8iwIMyoPG91QosVCdjFD2qw+bYmVrXMc9L5AVgQ
         xBEKGiCXc9slLG/U8d/G2QxQhIVHcCosqwaQrm6GOj2f2mssXF8CMbqMmDxSNzLYHLjM
         lcww==
X-Gm-Message-State: AOAM532KDrpxccRx/9QM7VC5c8od4XxmZlIseDiyNh9HZkdv2nZhx4bE
        zdFqnVIQ6FDTh2MZLnLUlto=
X-Google-Smtp-Source: ABdhPJxt2pD6W+zmvHH4/qZYFASujPCD7TMwgg/ner/gHNpT88Lk15hCgOpUe+6qMytW01UEwr4DCw==
X-Received: by 2002:a63:7e5a:: with SMTP id o26mr21581596pgn.134.1591635692300;
        Mon, 08 Jun 2020 10:01:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b140sm7542863pfb.119.2020.06.08.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F0A7740945; Mon,  8 Jun 2020 17:01:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/6] block: add docs for gendisk / request_queue refcount helpers
Date:   Mon,  8 Jun 2020 17:01:21 +0000
Message-Id: <20200608170127.20419-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200608170127.20419-1-mcgrof@kernel.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
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
index 62a4904db921..a0760aac110a 100644
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
index 1a7659327664..f741613d731f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -876,6 +876,20 @@ static void invalidate_partition(struct gendisk *disk, int partno)
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
@@ -1514,6 +1528,23 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
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
@@ -1727,6 +1758,13 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
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
@@ -1747,6 +1785,13 @@ struct kobject *get_disk_and_module(struct gendisk *disk)
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
@@ -1754,7 +1799,10 @@ void put_disk(struct gendisk *disk)
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

