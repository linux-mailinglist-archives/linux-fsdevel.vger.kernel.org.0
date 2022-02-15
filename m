Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EDB4B63F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiBOHG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:06:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiBOHGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:06:23 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2B71CB3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:06:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4XMx67_1644908770;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4XMx67_1644908770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 15:06:11 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     vgoyal@redhat.com, hch@lst.de
Subject: [PATCH] init: remove unused names parameter of split_fs_names()
Date:   Tue, 15 Feb 2022 15:06:10 +0800
Message-Id: <20220215070610.108967-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is a trivial cleanup.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 init/do_mounts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 762b534978d9..15502d4ef249 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -339,7 +339,7 @@ __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
 /* This can return zero length strings. Caller should check */
-static int __init split_fs_names(char *page, size_t size, char *names)
+static int __init split_fs_names(char *page, size_t size)
 {
 	int count = 1;
 	char *p = page;
@@ -403,7 +403,7 @@ void __init mount_block_root(char *name, int flags)
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -546,7 +546,7 @@ static int __init mount_nodev_root(void)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {
-- 
2.27.0

