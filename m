Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136031A89E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEKRID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:08:03 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54752 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfEKRID (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:08:03 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 75BE5C00A01;
        Sat, 11 May 2019 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557594481;
        bh=UvzKPBgcb3z7tPf6cm2ZxLlr17a42KxrWBRpHJot+sY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pf0hs1ePKiTJs6q1kmvuupUsBfRXewdBsKuZfCuY4MU36KhLP73wAm7mxgRzJGBqJ
         mIotsmL21z+1LZcN6AvuKoiB9WUSawfLKC6G+PiWhBAMFTF5vvE93AjL7IZ/MfNaH6
         2kes0Oi7GIIKocEsrbqCeT9kijRCb6/J6ym7cFvg=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/1] io_uring: fix race condition reading SQE data
Date:   Sat, 11 May 2019 19:08:01 +0200
Message-Id: <20190511170801.32182-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3900c9a9-41a2-31cb-3a7b-e93251505b15@kernel.dk>
References: <3900c9a9-41a2-31cb-3a7b-e93251505b15@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When punting to workers the SQE gets copied after the initial try.
There is a race condition between reading SQE data for the initial try
and copying it for punting it to the workers.

For example io_rw_done calls kiocb->ki_complete even if it was prepared
for IORING_OP_FSYNC (and would be NULL).

The easiest solution for now is to alway prepare again in the worker.

req->file is safe to prepare though as long as it is checked before use.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 48ea3977012a..576d9c652b4c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -329,9 +329,8 @@ struct io_kiocb {
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
-#define REQ_F_PREPPED		16	/* prep already done */
-#define REQ_F_IO_DRAIN		32	/* drain existing IO first */
-#define REQ_F_IO_DRAINED	64	/* drain done */
+#define REQ_F_IO_DRAIN		16	/* drain existing IO first */
+#define REQ_F_IO_DRAINED	32	/* drain done */
 	u64			user_data;
 	u32			error;	/* iopoll result from callback */
 	u32			sequence;
@@ -896,9 +895,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 
 	if (!req->file)
 		return -EBADF;
-	/* For -EAGAIN retry, everything is already prepped */
-	if (req->flags & REQ_F_PREPPED)
-		return 0;
 
 	if (force_nonblock && !io_file_supports_async(req->file))
 		force_nonblock = false;
@@ -941,7 +937,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 			return -EINVAL;
 		kiocb->ki_complete = io_complete_rw;
 	}
-	req->flags |= REQ_F_PREPPED;
 	return 0;
 }
 
@@ -1227,16 +1222,12 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (!req->file)
 		return -EBADF;
-	/* Prep already done (EAGAIN retry) */
-	if (req->flags & REQ_F_PREPPED)
-		return 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
-	req->flags |= REQ_F_PREPPED;
 	return 0;
 }
 
@@ -1277,16 +1268,12 @@ static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (!req->file)
 		return -EBADF;
-	/* Prep already done (EAGAIN retry) */
-	if (req->flags & REQ_F_PREPPED)
-		return 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
-	req->flags |= REQ_F_PREPPED;
 	return ret;
 }
 
-- 
2.20.1

