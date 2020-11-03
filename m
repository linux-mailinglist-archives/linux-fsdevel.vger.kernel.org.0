Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11FE2A3988
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 02:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgKCB0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 20:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgKCBTk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:19:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E702222B9;
        Tue,  3 Nov 2020 01:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366380;
        bh=tmhYmKVVWDqUgBs9mXJum1MbwD2MM8BbPYOJUHh2uR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpi6b5DZlDVgG/FEAq9zBtx2pKp7syodsIrNRLr+bfoU9mBA0aGz7FcP1PPPDZWw5
         9H6OZpYaktnZDVhXmwnKZ2q/UmWFxd9Rr3jr+Mtqx5grNW2bdCmxay4R30UHgLksd9
         jjCFtPOpGQHCrOSgAWnZvQK9ORRS8718l8Vyu39I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 08/29] io_uring: don't miss setting IO_WQ_WORK_CONCURRENT
Date:   Mon,  2 Nov 2020 20:19:07 -0500
Message-Id: <20201103011928.183145-8-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011928.183145-1-sashal@kernel.org>
References: <20201103011928.183145-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit feaadc4fc2ebdbd53ffed1735077725855a2af53 ]

Set IO_WQ_WORK_CONCURRENT for all REQ_F_FORCE_ASYNC requests, do that in
that is also looks better.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8e9c58fa76362..d84eb0cc49ee4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1089,6 +1089,9 @@ static inline void io_prep_async_work(struct io_kiocb *req,
 
 	io_req_init_async(req);
 
+	if (req->flags & REQ_F_FORCE_ASYNC)
+		req->work.flags |= IO_WQ_WORK_CONCURRENT;
+
 	if (req->flags & REQ_F_ISREG) {
 		if (def->hash_reg_file)
 			io_wq_hash_work(&req->work, file_inode(req->file));
@@ -5876,13 +5879,6 @@ static void io_queue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 			if (unlikely(ret < 0))
 				goto fail_req;
 		}
-
-		/*
-		 * Never try inline submit of IOSQE_ASYNC is set, go straight
-		 * to async execution.
-		 */
-		io_req_init_async(req);
-		req->work.flags |= IO_WQ_WORK_CONCURRENT;
 		io_queue_async_work(req);
 	} else {
 		__io_queue_sqe(req, sqe);
-- 
2.27.0

