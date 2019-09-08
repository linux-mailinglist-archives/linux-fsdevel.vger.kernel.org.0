Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8DACF95
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfIHP7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 11:59:55 -0400
Received: from a3.inai.de ([88.198.85.195]:58382 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfIHP7z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 11:59:55 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 11:59:55 EDT
Received: by a3.inai.de (Postfix, from userid 65534)
        id 6FA332A7D4AF; Sun,  8 Sep 2019 17:53:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 4FF363BACCAB;
        Sun,  8 Sep 2019 17:53:22 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     hsiangkao@aol.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH erofs-utils] build: cure compiler warnings
Date:   Sun,  8 Sep 2019 17:53:22 +0200
Message-Id: <20190908155322.22828-1-jengelh@inai.de>
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
 lib/compress.c | 2 +-
 lib/inode.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index a977c87..8d97e82 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -457,7 +457,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 	DBG_BUGON(ret);
 
-	erofs_info("compressed %s (%lu bytes) into %u blocks",
+	erofs_info("compressed %s (%llu bytes) into %u blocks",
 		   inode->i_srcpath, inode->i_size, compressed_blocks);
 
 	/*
diff --git a/lib/inode.c b/lib/inode.c
index 141a300..a514303 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -789,7 +789,7 @@ fail:
 
 		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
 		erofs_d_invalidate(d);
-		erofs_info("add file %s/%s (nid %lu, type %d)",
+		erofs_info("add file %s/%s (nid %llu, type %d)",
 			   dir->i_srcpath, d->name, d->nid, d->type);
 	}
 	erofs_write_dir_file(dir);
-- 
2.23.0

