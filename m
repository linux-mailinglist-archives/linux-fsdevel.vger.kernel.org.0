Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DED4F00B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbiDBKep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiDBKeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:34:44 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B041AF7D2
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 03:32:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V8zD-od_1648895570;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8zD-od_1648895570)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 18:32:50 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     gerry@linux.alibaba.com
Subject: [PATCH] fuse: avoid unnecessary spinlock bump
Date:   Sat,  2 Apr 2022 18:32:50 +0800
Message-Id: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move dmap free worker kicker inside the critical region, so that extra
spinlock lock/unlock could be avoided.

Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d7d3a7f06862..b9f8795d52c4 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -138,9 +138,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn_dax *fcd)
 		WARN_ON(fcd->nr_free_ranges <= 0);
 		fcd->nr_free_ranges--;
 	}
+	__kick_dmap_free_worker(fcd, 0);
 	spin_unlock(&fcd->lock);
 
-	kick_dmap_free_worker(fcd, 0);
 	return dmap;
 }
 
-- 
2.27.0

