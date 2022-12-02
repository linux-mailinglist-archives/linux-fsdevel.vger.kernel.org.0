Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113F640AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiLBQ10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiLBQ1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:24 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F9F2DDC
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=zyfjeff@linux.alibaba.com;NM=0;PH=DS;RN=3;SR=0;TI=SMTPD_---0VWEfMBx_1669998425;
Received: from localhost(mailfrom:zyfjeff@linux.alibaba.com fp:SMTPD_---0VWEfMBx_1669998425)
          by smtp.aliyun-inc.com;
          Sat, 03 Dec 2022 00:27:20 +0800
From:   zyfjeff <zyfjeff@linux.alibaba.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu, zyfjeff <zyfjeff@linux.alibaba.com>
Subject: [PATCH] fuse: remove duplicate check for nodeid
Date:   Sat,  3 Dec 2022 00:27:02 +0800
Message-Id: <20221202162702.5931-1-zyfjeff@linux.alibaba.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

before this check, the nodeid has already been checked once, so the check here
doesn't make an sense, so remove the check for node id here.

	if (err || !outarg->nodeid)
		goto out_put_forget;

	err = -EIO;
>>>	if (!outarg->nodeid)
		goto out_put_forget;

Signed-off-by: zyfjeff <zyfjeff@linux.alibaba.com>
---
 fs/fuse/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bb97a384dc5d..c1a4682cf3a8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -395,8 +395,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 
 	err = -EIO;
-	if (!outarg->nodeid)
-		goto out_put_forget;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
 
-- 
2.34.1

