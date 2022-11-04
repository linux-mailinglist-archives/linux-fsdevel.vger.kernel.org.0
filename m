Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E76618E86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 03:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKDC5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 22:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKDC5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:57:19 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E824F2B;
        Thu,  3 Nov 2022 19:57:17 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id YDJ00113;
        Fri, 04 Nov 2022 10:57:13 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 4 Nov 2022 10:57:14 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>
CC:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] aio: replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 3 Nov 2022 22:57:11 -0400
Message-ID: <20221104025711.1835-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20221104105713ee8e3dfc37a711475d00319feaafcac1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad322..978bbfb8dcac 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -556,7 +556,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 				 PROT_READ | PROT_WRITE,
 				 MAP_SHARED, 0, &unused, NULL);
 	mmap_write_unlock(mm);
-	if (IS_ERR((void *)ctx->mmap_base)) {
+	if (IS_ERR_VALUE(ctx->mmap_base)) {
 		ctx->mmap_size = 0;
 		aio_free_ring(ctx);
 		return -ENOMEM;
-- 
2.27.0

