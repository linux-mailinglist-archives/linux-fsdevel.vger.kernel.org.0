Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33C264B47E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 12:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiLMLwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiLMLwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:52:23 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423EFCFB;
        Tue, 13 Dec 2022 03:52:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=zyfjeff@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VXEBpaV_1670932326;
Received: from localhost(mailfrom:zyfjeff@linux.alibaba.com fp:SMTPD_---0VXEBpaV_1670932326)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 19:52:18 +0800
From:   zyfjeff <zyfjeff@linux.alibaba.com>
To:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        zyfjeff <zyfjeff@linux.alibaba.com>
Subject: [PATCH] fuse: remove duplicate check for nodeid
Date:   Tue, 13 Dec 2022 19:51:47 +0800
Message-Id: <20221213115147.26629-1-zyfjeff@linux.alibaba.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

before this check, the nodeid has already been checked once, so
the check here doesn't make an sense, so remove the check for
nodeid here.

            if (err || !outarg->nodeid)
                    goto out_put_forget;

            err = -EIO;
    >>>     if (!outarg->nodeid)
                    goto out_put_forget;

Signed-off-by: zyfjeff <zyfjeff@linux.alibaba.com>
---
 fs/fuse/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd1a071b625a..a33cd1131640 100644
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
2.34.0

