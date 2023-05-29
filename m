Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EC7141C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE2B5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 21:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2B5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 21:57:15 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EDB8;
        Sun, 28 May 2023 18:57:12 -0700 (PDT)
X-UUID: daab79a208784ff98e108a5844808a4b-20230529
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:567b328f-12ca-4442-b2a8-d379ba623739,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:567b328f-12ca-4442-b2a8-d379ba623739,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:525c446d-2f20-4998-991c-3b78627e4938,B
        ulkID:230529093928BK5NKPIW,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: daab79a208784ff98e108a5844808a4b-20230529
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <lijun01@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 404288243; Mon, 29 May 2023 09:56:57 +0800
From:   lijun <lijun01@kylinos.cn>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijun01@kylinos.cn
Subject: [PATCH] FUSE: dev: Change the posiion of spin_lock
Date:   Mon, 29 May 2023 09:56:56 +0800
Message-Id: <20230529015656.3099390-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

just list_del need spin_lock ，so the spin_lock should be close to
"list_del(&req->list)", this may add a little benefit.

Signed-off-by: lijun <lijun01@kylinos.cn>
---
 fs/fuse/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..c3a0a04ea9b4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -388,16 +388,15 @@ static void request_wait_answer(struct fuse_req *req)
 		if (!err)
 			return;
 
-		spin_lock(&fiq->lock);
 		/* Request is not yet in userspace, bail out */
 		if (test_bit(FR_PENDING, &req->flags)) {
+			spin_lock(&fiq->lock);
 			list_del(&req->list);
 			spin_unlock(&fiq->lock);
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;
 			return;
 		}
-		spin_unlock(&fiq->lock);
 	}
 
 	/*
-- 
2.34.1

