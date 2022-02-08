Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475454AD6E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiBHLag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355894AbiBHJ7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:59:32 -0500
X-Greylist: delayed 654 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 01:59:29 PST
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB1CC03FEC0;
        Tue,  8 Feb 2022 01:59:29 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.48:33584.1340775733
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-110.86.5.91 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id A4EC62800A8;
        Tue,  8 Feb 2022 17:48:27 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 138a66c129c44c58b32f4233f37be3ab for linux-kernel@vger.kernel.org;
        Tue, 08 Feb 2022 17:48:30 CST
X-Transaction-ID: 138a66c129c44c58b32f4233f37be3ab
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk, ebiggers@kernel.org,
        axboe@kernel.dk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   zhenggy <zhenggy@chinatelecom.cn>
Subject: [PATCH] aio: inform block layer of how many requests we are
 submitting
Message-ID: <8e0186ed-04bb-7bb8-ff09-581a7b9fdf03@chinatelecom.cn>
Date:   Tue, 8 Feb 2022 17:47:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

