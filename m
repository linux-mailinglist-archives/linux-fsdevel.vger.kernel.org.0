Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC44C6C2718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCUBNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCUBNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920F7AAC
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/nwz4V2EC8n0qXadUSrTDCVVXxTW7SFTYia0jIv3dHTxUd1q6TaeTl0bc4H5S6kd2nftaOtqSL/m8oVxewn4Htj9PnzaTQVyjIxjAQvzOCjUneRbExcfk7lkWCnG9VugDuCXRPjSyDqZo1wnoD2JJNoimGAiKK10vs9G1k4xR5DSZoqMDWB11RHtgr+rsytcsFv4OIW2mWETDA9+KF83WlRuzY8pujGQOmxGUcKCInwgJ6cDGob1fyAakiLsZmxZWXdjJbrCFkq7zhnPnKzrD6h6d8hccvKc1Rg7+xsyaUYQSuAEsPKWwW1knYH9HTNbdSRwh1AKOhGuc6t5LnViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uY1HkRQqKD6hE2ETLXf86bxnGU4qAYaeg0t3ADLNC8=;
 b=XITbMaY2RvVSH+H1a7/8iB+NDzTIMiuRAfK7qOurWaUIQh5l3592WBfrl/Is7IpaxmYhIAi2DfU7rV97n2BwqYmPuY5DRiLxmSHVC6VEA/LkYpxbntRSLwjyBiVWPxccFpdMzhdyex5FpDNItolG9s8FSGsvTO1csbY91gF72ww4BT+53MVxhKmsm9uTYnm6GAFVXgpUwNGEMtYQu8k0Zp3G1BHo/aE6sQNNKqlRkP0Eb/m6y40VzsCRdqeCHZcF2B29V6V/bhMyajfCcvDsEEd7/NoHTk+ILwqrsbHkapCMJ2opqtxz+7qzMqEgZOUm4JE7Bz61twy/PDYMZ0HvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uY1HkRQqKD6hE2ETLXf86bxnGU4qAYaeg0t3ADLNC8=;
 b=HETULZHUPJwbtSYtdF/BLNJEnA4doELrxDPYt6+9OO5D3oFUyHx0QpiPzVwPi8xonrQ4Dq9WEVKAQYyJnwJZdn/FATdGFdJOxEZyGD5OOV3HUn+/ROpOZv+9AJNmaZ/PHZO3nTmzUZ5UJz7BoWO80RLRJGUumKMygM48GEjBvmA=
Received: from BN8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:ac::27)
 by CH2PR19MB3879.namprd19.prod.outlook.com (2603:10b6:610:a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:28 +0000
Received: from BN8NAM04FT054.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::74) by BN8PR07CA0014.outlook.office365.com
 (2603:10b6:408:ac::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT054.mail.protection.outlook.com (10.13.160.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:27 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 3C85A20C6862;
        Mon, 20 Mar 2023 19:12:35 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 13/13] fuse: Allow to queue to the ring
Date:   Tue, 21 Mar 2023 02:10:47 +0100
Message-Id: <20230321011047.3425786-14-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT054:EE_|CH2PR19MB3879:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 71ab452f-96cd-4b25-bd84-08db29a932a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gys3V94rBlCuO+16jqzYMR6n5eVDayqrJuAiaCWbviUNwutVbr1FVAcs2PIGCYSn9uCjw4nyhrbxGyV9hQvMIsrfGnJlZ3F6Nbp9bDkxztyQWSTLsB6Gb8OX5CdUrVWWVsBXKOdMCT21X3wJNuoy4plqrrPk03Jl2yXhnvhBZnVCQBatHtZwE5BBFZU/sCfIEWOc1zY+I6gE+YldLrZ9YVVtS9LiJVvt4vkFmFFmiHI4N+ttekqmPPT4iTUlCjN1gcNhmUn+xO6tLGT7LbAehv+XEG/N4pMu025YTuH9z7GgoWzY5nK5LkWremayNsFqDf2mG4NmHrjBdmmOvG6gy1htlpfltHQg9WsZ3Pcf++ePmQTSvj2QEo9ryFSLmFOu6DLKNDKF5d1M63Rn8Y7lb+0MMvRKsmk0hpThe4NLj0xdwJlGX/9V4DglfJxtqSXVvwMradwbrZwUhyD0rc81nDzfluTq9muwYFTUwKJtmLeDXixsVdCx56F5Oqgk273MO1GFP/rAJ6BPvjIv7HKyxrsgFt26xMXHwNKLxu6HdCC4NLk7hIkpjTIaXbXVEavzErIm8vgkEXXtQBVUIHWSU5BVbvaomNBdrdQZiOi3wqlpSRanAm6LBu0Q88F+HFbdmLoxGYywDT+jYVuyZxOVUUSTXcfosQl7K3BPKg9QjXu3o2XeatIUoSxvTS1b4hjuYJMfT+Xs7veRG6MpnsFyC4DIxm4XofkmijPbWLzC7YM=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39850400004)(451199018)(46966006)(36840700001)(70586007)(4326008)(8936002)(336012)(70206006)(6916009)(5660300002)(8676002)(41300700001)(6666004)(316002)(54906003)(6266002)(26005)(186003)(1076003)(478600001)(2616005)(83380400001)(81166007)(82740400003)(36860700001)(36756003)(86362001)(356005)(40480700001)(82310400005)(2906002)(47076005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:27.7847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ab452f-96cd-4b25-bd84-08db29a932a9
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT054.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This enabled enqueuing requests through fuse uring queues.

For initial simplicity requests are always allocated the normal way
then added to ring queues lists and only then copied to ring queue
entries. Later on the allocation and adding the requests to a list
can be avoided, by directly using a ring entry. This introduces
some code complexity and is therefore not done for now.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c         | 80 ++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/dev_uring.c   | 68 ++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  1 +
 3 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cce55eaed8a3..e82db13da8f6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -211,13 +211,29 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 };
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
-static void queue_request_and_unlock(struct fuse_iqueue *fiq,
-				     struct fuse_req *req)
+
+static void queue_request_and_unlock(struct fuse_conn *fc,
+				     struct fuse_req *req, bool allow_uring)
 __releases(fiq->lock)
 {
+	struct fuse_iqueue *fiq = &fc->iq;
+
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
+
+	if (allow_uring && fc->ring.ready) {
+		int res;
+
+		/* this lock is not needed at all for ring req handling */
+		spin_unlock(&fiq->lock);
+		res = fuse_uring_queue_fuse_req(fc, req);
+		if (!res)
+			return;
+
+		/* fallthrough, handled through /dev/fuse read/write */
+	}
+
 	list_add_tail(&req->list, &fiq->pending);
 	fiq->ops->wake_pending_and_unlock(fiq);
 }
@@ -254,7 +270,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		fc->active_background++;
 		spin_lock(&fiq->lock);
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fc, req, true);
 	}
 }
 
@@ -398,7 +414,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 	spin_lock(&fiq->lock);
@@ -410,7 +427,7 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fc, req, true);
 
 		request_wait_answer(req);
 		/* Pairs with smp_wmb() in fuse_request_end() */
@@ -478,6 +495,12 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 	if (args->force) {
 		atomic_inc(&fc->num_waiting);
 		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
+		if (unlikely(!req)) {
+			/* should only happen with uring on shutdown */
+			WARN_ON(!fc->ring.configured);
+			ret = -ENOTCONN;
+			goto err;
+		}
 
 		if (!args->nocreds)
 			fuse_force_creds(req);
@@ -505,16 +528,55 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 	}
 	fuse_put_request(req);
 
+err:
 	return ret;
 }
 
-static bool fuse_request_queue_background(struct fuse_req *req)
+static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
+					       struct fuse_req *req)
+{
+	struct fuse_iqueue *fiq = &fc->iq;
+	int err;
+
+	req->in.h.unique = fuse_get_unique(fiq);
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->args->in_numargs,
+			      (struct fuse_arg *) req->args->in_args);
+
+	err = fuse_uring_queue_fuse_req(fc, req);
+	if (!err) {
+		/* XXX remove and lets the users of that use per queue values -
+		 * avoid the shared spin lock...
+		 * Is this needed at all?
+		 */
+		spin_lock(&fc->bg_lock);
+		fc->num_background++;
+		fc->active_background++;
+
+
+		/* XXX block when per ring queues get occupied */
+		if (fc->num_background == fc->max_background)
+			fc->blocked = 1;
+		spin_unlock(&fc->bg_lock);
+	}
+
+	return err ? false : true;
+}
+
+/*
+ * @return true if queued
+ */
+static int fuse_request_queue_background(struct fuse_req *req)
 {
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
 	bool queued = false;
 
 	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
+
+	if (fc->ring.ready)
+		return fuse_request_queue_background_uring(fc, req);
+
 	if (!test_bit(FR_WAITING, &req->flags)) {
 		__set_bit(FR_WAITING, &req->flags);
 		atomic_inc(&fc->num_waiting);
@@ -567,7 +629,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 				    struct fuse_args *args, u64 unique)
 {
 	struct fuse_req *req;
-	struct fuse_iqueue *fiq = &fm->fc->iq;
+	struct fuse_conn *fc = fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 	int err = 0;
 
 	req = fuse_get_req(fm, false);
@@ -581,7 +644,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		queue_request_and_unlock(fiq, req);
+		/* uring for notify not supported yet */
+		queue_request_and_unlock(fc, req, false);
 	} else {
 		err = -ENODEV;
 		spin_unlock(&fiq->lock);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5c41f9f71410..9e02e58ac688 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -330,6 +330,74 @@ __must_hold(&queue.waitq.lock)
 	return true;
 }
 
+int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct fuse_ring_queue *queue;
+	int qid = 0;
+	struct fuse_ring_ent *ring_ent = NULL;
+	const size_t queue_depth = fc->ring.queue_depth;
+	int res;
+	int is_bg = test_bit(FR_BACKGROUND, &req->flags);
+	struct list_head *head;
+	int *queue_avail;
+
+	pr_devel("%s req=%p bg=%d\n", __func__, req, is_bg);
+
+	if (fc->ring.per_core_queue) {
+		qid = task_cpu(current);
+		if (unlikely(qid >= fc->ring.nr_queues)) {
+			WARN_ONCE(1, "Core number (%u) exceeds nr ueues (%zu)\n",
+				  qid, fc->ring.nr_queues);
+			qid = 0;
+		}
+	}
+
+	queue = fuse_uring_get_queue(fc, qid);
+	head = is_bg ?  &queue->bg_queue : &queue->fg_queue;
+	queue_avail = is_bg ? &queue->req_bg : &queue->req_fg;
+
+	spin_lock(&queue->lock);
+
+	if (unlikely(queue->aborted)) {
+		res = -ENOTCONN;
+		goto err_unlock;
+	}
+
+	list_add_tail(&req->list, head);
+	if (*queue_avail) {
+		bool got_req;
+		int tag = find_first_bit(queue->req_avail_map, queue_depth);
+
+		if (unlikely(tag == queue_depth)) {
+			pr_err("queue: no free bit found for qid=%d "
+				"qdepth=%zu av-fg=%d av-bg=%d max-fg=%zu "
+				"max-bg=%zu is_bg=%d\n", queue->qid,
+				queue_depth, queue->req_fg, queue->req_bg,
+				fc->ring.max_fg, fc->ring.max_bg, is_bg);
+
+			WARN_ON(1);
+			res = -ENOENT;
+			goto err_unlock;
+		}
+		ring_ent = &queue->ring_ent[tag];
+		got_req = fuse_uring_assign_ring_entry(ring_ent, head, is_bg);
+		if (unlikely(!got_req)) {
+			WARN_ON(1);
+			ring_ent = NULL;
+		}
+	}
+	spin_unlock(&queue->lock);
+
+	if (ring_ent != NULL)
+		fuse_uring_send_to_ring(ring_ent);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&queue->lock);
+	return res;
+}
+
 /*
  * Checks for errors and stores it into the request
  */
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index b0ef36215b80..42260a2a22ee 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -10,6 +10,7 @@
 #include "fuse_i.h"
 
 void fuse_uring_end_requests(struct fuse_conn *fc);
+int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req);
 int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg);
 void fuse_uring_ring_destruct(struct fuse_conn *fc);
 int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
-- 
2.37.2

