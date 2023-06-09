Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9372998B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjFIMVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFIMVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:21:10 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9FE50
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 05:21:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686313268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M36Jp2AxZkBfLvbvl2HSzo9LX0/6SxFY++SadI4YEpU=;
        b=sH53kXNSjeKiQd27BwhD2i4QH+Ooj4w4w449tiId73+FG0jrmBblPJH22ZDaK3att8tx88
        XWssYBEqvN10UD4UgxptngknKn9DLkz7SVeonq5Ce5bTwPxGQ7EKjOzuhI/6ixBGJufPbm
        VG3T87RasiNjaKcD1xaVcVyMisvpL6Q=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] io-wq: distinguish fixed worker by its name
Date:   Fri,  9 Jun 2023 20:20:30 +0800
Message-Id: <20230609122031.183730-11-hao.xu@linux.dev>
In-Reply-To: <20230609122031.183730-1-hao.xu@linux.dev>
References: <20230609122031.183730-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Distinguish fixed workers and normal workers by their names.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 io_uring/io-wq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 61cf6da2c72f..7a9e5fa19b81 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -634,10 +634,12 @@ static int io_wq_worker(void *data)
 	struct io_wq *wq = worker->wq;
 	bool exit_mask = false, last_timeout = false;
 	char buf[TASK_COMM_LEN];
+	bool fixed = is_fixed_worker(worker);
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
+	snprintf(buf, sizeof(buf), fixed ? "iou-fixed-%d" : "iou-wrk-%d",
+		 wq->task->pid);
 	set_task_comm(current, buf);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
@@ -656,7 +658,7 @@ static int io_wq_worker(void *data)
 		 * fixed worker, they can be manually reset to cpu other than
 		 * the cpuset indicated by io_wq_worker_affinity()
 		 */
-		if (!is_fixed_worker(worker) && last_timeout &&
+		if (!fixed && last_timeout &&
 		    (exit_mask || acct->nr_workers > 1)) {
 			acct->nr_workers--;
 			raw_spin_unlock(&wq->lock);
-- 
2.25.1

