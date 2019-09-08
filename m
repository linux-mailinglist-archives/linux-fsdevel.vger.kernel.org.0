Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB6AD0E1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfIHVs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 17:48:26 -0400
Received: from a3.inai.de ([88.198.85.195]:42176 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfIHVs0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 17:48:26 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id 7116B2A7D4AF; Sun,  8 Sep 2019 23:48:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id ECD7D3BB6504;
        Sun,  8 Sep 2019 23:48:21 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     hsiangkao@aol.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH erofs-utils v2] build: cure compiler warnings
Date:   Sun,  8 Sep 2019 23:48:21 +0200
Message-Id: <20190908214821.32265-1-jengelh@inai.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On i586 I observe:

In file included from inode.c:16:
inode.c: In function 'erofs_mkfs_build_tree':
../include/erofs/print.h:27:21: error: format '%lu' expects argument of type
'long unsigned int', but argument 7 has type 'erofs_nid_t' {aka 'long long unsigned int'} [-Werror=format=]
   27 | #define pr_fmt(fmt) "EROFS: " FUNC_LINE_FMT fmt "\n"
../include/erofs/print.h:43:4: note: in expansion of macro 'pr_fmt'
   43 |    pr_fmt(fmt),    \
inode.c:792:3: note: in expansion of macro 'erofs_info'
  792 |   erofs_info("add file %s/%s (nid %lu, type %d)",
inode.c:792:37: note: format string is defined here
  792 |   erofs_info("add file %s/%s (nid %lu, type %d)",
---
 lib/compress.c | 4 ++--
 lib/inode.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index a977c87..cadf598 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -457,8 +457,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 	DBG_BUGON(ret);
 
-	erofs_info("compressed %s (%lu bytes) into %u blocks",
-		   inode->i_srcpath, inode->i_size, compressed_blocks);
+	erofs_info("compressed %s (%llu bytes) into %u blocks",
+		   inode->i_srcpath, (unsigned long long)inode->i_size, compressed_blocks);
 
 	/*
 	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
diff --git a/lib/inode.c b/lib/inode.c
index 141a300..db9ad99 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -789,8 +789,8 @@ fail:
 
 		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
 		erofs_d_invalidate(d);
-		erofs_info("add file %s/%s (nid %lu, type %d)",
-			   dir->i_srcpath, d->name, d->nid, d->type);
+		erofs_info("add file %s/%s (nid %llu, type %d)",
+			   dir->i_srcpath, d->name, (unsigned long long)d->nid, d->type);
 	}
 	erofs_write_dir_file(dir);
 	erofs_write_tail_end(dir);
-- 
2.23.0

