Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25419DBCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 08:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfD2GNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 02:13:50 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60185 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfD2GNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:13:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TQTtHYW_1556518419;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TQTtHYW_1556518419)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 14:13:47 +0800
From:   zhangliguang <zhangliguang@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fix a NULL pointer dereference
Date:   Mon, 29 Apr 2019 14:13:39 +0800
Message-Id: <1556518419-17986-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case kzalloc fails, the fix returns NULL to avoid NULL pointer
dereference.

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 fs/fuse/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9971a35..23e73d8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -61,6 +61,9 @@ static struct page **fuse_req_pages_alloc(unsigned int npages, gfp_t flags,
 
 	pages = kzalloc(npages * (sizeof(struct page *) +
 				  sizeof(struct fuse_page_desc)), flags);
+	if (!pages)
+		return NULL;
+
 	*desc = (void *) pages + npages * sizeof(struct page *);
 
 	return pages;
-- 
1.8.3.1

