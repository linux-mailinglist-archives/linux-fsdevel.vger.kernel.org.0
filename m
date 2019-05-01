Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1F105DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEAHYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 03:24:49 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:47765 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAHYt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 03:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1556695482;
        bh=5OYycxbwytoGNlsaJHsNXYpwDWjxGCcdM8AS1gUFazM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=aiqQ8uG+WNV/0xesQxRnqGu9YYCOWwPUWVqK1+DibDqEuchRsw8KROuqqNOIzbzA8
         uYNDVCdgNxOLsswm7xdlawl4tjSFRcl5BWHSA1m3tMP3fUEd6H2g4voxLbhUaBomXY
         k3FgP2QVLRINPZbLoxOI/SQTDj81XADitnb4Z4fE=
X-QQ-mid: esmtp7t1556695480tox338gz4
Received: from localhost.localdomain (unknown [61.48.57.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 01 May 2019 15:24:31 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: wEhDafM0Yc9uu8tyfM1rs+CFPVVrQlgWGMwpH1exmA6DNb1aBj9yruVSyiDwv
        HUzY2sEecLEEc0Tc9eOu5UFloLajb2qYKmlQB7KTkEPiQkcDuCGhd+irVhE9JOwaFaUUqPi
        onnZYmNOc0BB2bA++XTkx/cm7RYkZVavTZrFmQcoBKYaolBgME8Eb0U7v7yz70VivX1ARxv
        54hprnjiBT9kwi2yTF7xngFWIIrVV1FwY62Vxekq3K/s7qbLhr9RdMObuE9Lh0a+nIVOpPV
        Q3ceP/1btYSc+H9nHyk15S7t4Y9bddd75kfA==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     jmoyer@redhat.com
Subject: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
Date:   Wed,  1 May 2019 15:24:30 +0800
Message-Id: <20190501072430.6674-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This issue is found by running liburing/test/io_uring_setup test.

When test run, the testcase "attempt to bind to invalid cpu" would not
pass with messages like:
   io_uring_setup(1, 0xbfc2f7c8), \
flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
sq_thread_cpu: 2
   expected -1, got 3
   FAIL

On my system, there is:
   CPU(s) possible : 0-3
   CPU(s) online   : 0-1
   CPU(s) offline  : 2-3
   CPU(s) present  : 0-1

The sq_thread_cpu 2 is offline on my system, so the bind should fail.
But cpu_possible() will pass the check. We shouldn't be able to bind
to an offline cpu. Use cpu_online() to do the check.

After the change, the testcase run as expected: EINVAL will be returned
for cpu offlined.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e9fb2cb1984..aa3d39860a1c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2241,7 +2241,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	ctx->sqo_mm = current->mm;
 
 	ret = -EINVAL;
-	if (!cpu_possible(p->sq_thread_cpu))
+	if (!cpu_online(p->sq_thread_cpu))
 		goto err;
 
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
@@ -2258,7 +2258,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 
 			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
 			ret = -EINVAL;
-			if (!cpu_possible(p->sq_thread_cpu))
+			if (!cpu_online(p->sq_thread_cpu))
 				goto err;
 
 			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
-- 
2.20.1



