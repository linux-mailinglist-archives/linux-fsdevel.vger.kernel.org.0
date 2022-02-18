Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE74BB1DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 07:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiBRGRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 01:17:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBRGRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:17:07 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFBF237FE;
        Thu, 17 Feb 2022 22:16:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4ngyTv_1645165006;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V4ngyTv_1645165006)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 14:16:47 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] aio: make io return value more readable
Date:   Fri, 18 Feb 2022 14:16:40 +0800
Message-Id: <20220218061640.444038-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We may need to enable the debug prints in aio_complete when met io error
issue. We got below prints, fffffffffffffffb means the io err is EIO(-5),
but it's not readable.
[   33.304182] aio_complete: 00000000b3c70ea0[17]: 00000000cd131d11: 0000000023803e77 3fc2b160f0 fffffffffffffffb 0

Below prints are more readable, the value(-5) matches the errno defined
in include/uapi/asm-generic/errno-base.h,
[   98.187270] aio_complete: 00000000220ae523[10]: 00000000045ed171: 000000004c334ae4 3fc211a330 -5 0

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13a7..45a9ff3d2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1140,7 +1140,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
-	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
+	pr_debug("%p[%u]: %p: %p %Lx %Ld %Ld\n", ctx, tail, iocb,
 		 (void __user *)(unsigned long)iocb->ki_res.obj,
 		 iocb->ki_res.data, iocb->ki_res.res, iocb->ki_res.res2);
 
-- 
2.17.1

