Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD76290BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 04:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiKODRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 22:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiKODQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:16:57 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3D1094;
        Mon, 14 Nov 2022 19:16:52 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id JEF00144;
        Tue, 15 Nov 2022 11:16:44 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 15 Nov 2022 11:16:47 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>
CC:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] aio: replace IS_ERR() with IS_ERR_VALUE()
Date:   Mon, 14 Nov 2022 22:16:44 -0500
Message-ID: <20221115031644.2341-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202211151116440ddae5e63825895396b0687c100e7070
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Bo Liu <liubo03@inspur.com>
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

