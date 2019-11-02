Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9EECDB3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfKBH4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 03:56:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfKBH4Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 03:56:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4BFCA82D5A7DEE08594F;
        Sat,  2 Nov 2019 15:56:23 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 2 Nov 2019
 15:56:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] io-wq: using kfree_rcu() to simplify the code
Date:   Sat, 2 Nov 2019 15:55:01 +0800
Message-ID: <20191102075501.38972-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callback function of call_rcu() just calls a kfree(),
so can use kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/io-wq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 652b8ba..3bbab2c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -102,13 +102,6 @@ struct io_wq {
 	struct completion done;
 };
 
-static void io_wq_free_worker(struct rcu_head *head)
-{
-	struct io_worker *worker = container_of(head, struct io_worker, rcu);
-
-	kfree(worker);
-}
-
 static bool io_worker_get(struct io_worker *worker)
 {
 	return refcount_inc_not_zero(&worker->ref);
@@ -194,7 +187,7 @@ static void io_worker_exit(struct io_worker *worker)
 	if (all_done && refcount_dec_and_test(&wqe->wq->refs))
 		complete(&wqe->wq->done);
 
-	call_rcu(&worker->rcu, io_wq_free_worker);
+	kfree_rcu(worker, rcu);
 }
 
 static void io_worker_start(struct io_wqe *wqe, struct io_worker *worker)
-- 
2.7.4


