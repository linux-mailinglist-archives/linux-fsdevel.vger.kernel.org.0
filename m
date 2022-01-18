Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7A49229B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiARJYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 04:24:10 -0500
Received: from prt-mail.chinatelecom.cn ([42.123.76.226]:35136 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345607AbiARJYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:24:09 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 04:24:09 EST
HMM_SOURCE_IP: 172.18.0.188:51990.1385957579
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-110.86.5.92 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 8AA20280118;
        Tue, 18 Jan 2022 17:17:46 +0800 (CST)
X-189-SAVE-TO-SEND: +zhenggy@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 1479501a639e40e2943d9f1f15895486 for bcrl@kvack.org;
        Tue, 18 Jan 2022 17:17:49 CST
X-Transaction-ID: 1479501a639e40e2943d9f1f15895486
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
From:   GuoYong Zheng <zhenggy@chinatelecom.cn>
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        GuoYong Zheng <zhenggy@chinatelecom.cn>
Subject: [PATCH] aio: inform block layer of how many requests we are submitting
Date:   Tue, 18 Jan 2022 17:17:44 +0800
Message-Id: <1642497464-1847-1-git-send-email-zhenggy@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit 47c122e35d7e ("block: pre-allocate requests if plug is
started and is a batch"), block layer can make smarter request allocation
if it know how many requests it need to submit, so switch to use
blk_start_plug_nr_ios here to pass the number of requests we will submit.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13..7c4935e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2071,7 +2071,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+		blk_start_plug_nr_ios(&plug, nr);
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
-- 
1.8.3.1

