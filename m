Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18266DC80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfD2HCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 03:02:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46831 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfD2HCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:02:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TQUvmjd_1556521352;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TQUvmjd_1556521352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 15:02:40 +0800
From:   zhangliguang <zhangliguang@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: move attr_version to a more relevant place
Date:   Mon, 29 Apr 2019 15:02:32 +0800
Message-Id: <1556521352-46524-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move attr_version assignment code to the more relevant place.

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 fs/fuse/readdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 574d03f..8b74fe0 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -320,7 +320,6 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	req->pages[0] = page;
 	req->page_descs[0].length = PAGE_SIZE;
 	if (plus) {
-		attr_version = fuse_get_attr_version(fc);
 		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
 			       FUSE_READDIRPLUS);
 	} else {
@@ -340,6 +339,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
+			attr_version = fuse_get_attr_version(fc);
 			err = parse_dirplusfile(page_address(page), nbytes,
 						file, ctx, attr_version);
 		} else {
-- 
1.8.3.1

