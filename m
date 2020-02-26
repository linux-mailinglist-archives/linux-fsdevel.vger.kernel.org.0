Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243EA16FD04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBZLLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:11:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728000AbgBZLLu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81F038A282C020EE2566;
        Wed, 26 Feb 2020 19:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:41 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 5/7] bfq: fix potential kernel crash when print dev err info
Date:   Wed, 26 Feb 2020 19:18:49 +0800
Message-ID: <20200226111851.55348-6-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use bdi_get_dev_name() to get device name, avoiding
use-after-free or NULL pointer reference for ->dev.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bfq-iosched.c         | 7 +++++--
 include/linux/backing-dev.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 00904611b8e4..8d41783d8e77 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -123,6 +123,7 @@
 #include <linux/ioprio.h>
 #include <linux/sbitmap.h>
 #include <linux/delay.h>
+#include <linux/backing-dev.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -4971,6 +4972,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	struct task_struct *tsk = current;
 	int ioprio_class;
 	struct bfq_data *bfqd = bfqq->bfqd;
+	char dname[BDI_DEV_NAME_LEN];
 
 	if (!bfqd)
 		return;
@@ -4978,8 +4980,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		dev_err(&bfqq->bfqd->queue->backing_dev_info->rcu_dev->dev,
-			"bfq: bad prio class %d\n", ioprio_class);
+		bdi_get_dev_name(bfqq->bfqd->queue->backing_dev_info,
+				dname, BDI_DEV_NAME_LEN);
+		pr_err("bdi %s: bfq: bad prio class %d\n", dname, ioprio_class);
 		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 89d1cb7923f5..291db069f7da 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -19,6 +19,8 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
+#define BDI_DEV_NAME_LEN       32
+
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
-- 
2.16.2.dirty

