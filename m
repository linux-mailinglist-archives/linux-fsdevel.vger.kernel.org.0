Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E06CC960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC1Rga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjC1RgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:23 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C40D525
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:22 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e6so6705016ilu.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024981; x=1682616981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPgTwTI5W0XG5CA6xrGMyHEB/r6kqIaXzt06jC3ZMH8=;
        b=oeXvDUR0AZKAhQ0k5Iy9bee7rVqzn/+yJiqzvDVjOs/gNRBTeTqIcH9PSMUu2JBwYG
         5Efqizb3FNsWIORmmQU5Help56rkF50zYVbbcMba+XBnPenQlfaGI+shqmA3/QMu4n6z
         0YN8ZrTStVyyo7Sd3niWg35UK6uN/wtJ3soSzfXATvGDsee62QhpWlFK7SsJpBHEdqqg
         DVQdUORC92wCgKld8k2MRjDS03ldTuPIVIpBbD0DqE9Z5icg1MvKEPIA6xRPwtUPU93x
         qKjV7npgsdo8iOTsK629wA+3xf9q3GZFifj7j5tcd/wtC8X/c2HLhNdjz0nrLmOi9rNf
         tlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024981; x=1682616981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPgTwTI5W0XG5CA6xrGMyHEB/r6kqIaXzt06jC3ZMH8=;
        b=Gamfl0xfDGBKAxxq96FF8L4wDwkg0vKxuGmRadPh+sRlCXEahzPJeJSnqLBUAO3VGl
         TrA/tvLiZeM0/Ek3P75AJgZyF2jttqRscS6PfquRag25SRVXCFbHLuVZ4/URP8TlUMk1
         NMxraY4LvB5SeZnfynZoVIWr+FUco8Jgjh489Xg63miI6Fu9hHNq1UXUP8n0Zyhhu4lN
         ongsC2AJwuEh39xinbBuvNL8XLJLCmDbEUzRgjXJt9lOyf3MQXfXcMgS5vLpPi6lh6hB
         5eG/oYk+NGEPoifc8Dmy2QOh5vLw6VUItKyRa0xN3G32NzzcTOGjJ3R5XS2+60/gUsDj
         FQNw==
X-Gm-Message-State: AAQBX9ctU9hj547E/mPtZLW8v29vbcAs5XGsqiKj5bonPI0udau3JBKm
        bEv4FilgAcXao+hoM6q7oA/MRn7uOCnAAq4mWsW5JQ==
X-Google-Smtp-Source: AKy350ay90y+Kneb0/E4isuJGqd8++H7ZLqHYkpd7CGo2euqKdd9KOQY8UO6SdcsPgr5lu0TJrGXEA==
X-Received: by 2002:a05:6e02:1bcf:b0:326:1e9e:d204 with SMTP id x15-20020a056e021bcf00b003261e9ed204mr2180551ilv.3.1680024981371;
        Tue, 28 Mar 2023 10:36:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF iov_iter
Date:   Tue, 28 Mar 2023 11:36:10 -0600
Message-Id: <20230328173613.555192-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328173613.555192-1-axboe@kernel.dk>
References: <20230328173613.555192-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't assume that a user backed iterator is always of the type
ITER_IOVEC. Handle the single segment case separately, then we can
use the same logic for ITER_UBUF and ITER_IOVEC.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 42 ++++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index b1d6ca7e9708..f52f57c30429 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -262,11 +262,17 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	struct hfi1_user_sdma_pkt_q *pq;
 	struct hfi1_user_sdma_comp_q *cq = fd->cq;
 	int done = 0, reqs = 0;
-	unsigned long dim = from->nr_segs;
+	unsigned long dim;
 	int idx;
 
 	if (!HFI1_CAP_IS_KSET(SDMA))
 		return -EINVAL;
+	if (!from->user_backed)
+		return -EFAULT;
+	dim = iovec_nr_user_vecs(from);
+	if (!dim)
+		return -EINVAL;
+
 	idx = srcu_read_lock(&fd->pq_srcu);
 	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
 	if (!cq || !pq) {
@@ -274,11 +280,6 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 		return -EIO;
 	}
 
-	if (!iter_is_iovec(from) || !dim) {
-		srcu_read_unlock(&fd->pq_srcu, idx);
-		return -EINVAL;
-	}
-
 	trace_hfi1_sdma_request(fd->dd, fd->uctxt->ctxt, fd->subctxt, dim);
 
 	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs) {
@@ -286,20 +287,27 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 		return -ENOSPC;
 	}
 
-	while (dim) {
-		int ret;
+	if (dim == 1) {
+		struct iovec iov = iov_iter_iovec(from);
 		unsigned long count = 0;
 
-		ret = hfi1_user_sdma_process_request(
-			fd, (struct iovec *)(from->iov + done),
-			dim, &count);
-		if (ret) {
-			reqs = ret;
-			break;
+		reqs = hfi1_user_sdma_process_request(fd, &iov, 1, &count);
+	} else {
+		while (dim) {
+			int ret;
+			unsigned long count = 0;
+
+			ret = hfi1_user_sdma_process_request(fd,
+					(struct iovec *)(from->iov + done),
+					dim, &count);
+			if (ret) {
+				reqs = ret;
+				break;
+			}
+			dim -= count;
+			done += count;
+			reqs++;
 		}
-		dim -= count;
-		done += count;
-		reqs++;
 	}
 
 	srcu_read_unlock(&fd->pq_srcu, idx);
-- 
2.39.2

