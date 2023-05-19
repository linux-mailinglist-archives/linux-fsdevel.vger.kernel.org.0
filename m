Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96370939F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjESJiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjESJhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:37:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA68101;
        Fri, 19 May 2023 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DWCBIuCWrEPUSgFUMsFJ6qSq1T5QDjJd5vFpRCChJ1w=; b=GayNG3kzJFJ5dJ+3pyHdgpJaHg
        Vg+D3WJSisJRAfKh4FdM+kMULiHBkVK2JlSjPpe6AWhhM9TnhNcnVYwVNicVKsW2D6CwQtiNr4GbI
        ifi8oL59NNJcPyuNM4H5lL3BQg0kUH1IUPhrqcRX4x0gkGHePahAMpgU+OMoye7IWbL1i4P4N0K7d
        hPveIYGdIaP1exiwrksrwwox3ggk+6PoAmRpABmAJW0vLpX170W8n4+WiyOMWiWdUV0KUHViDPR2V
        y4iTj0Am5OrXwsAxT9LSL8UdxWNyTm0g69FXTbp/zKBR4iorevNKqz7EDBD0kG/pHeghxQmsCy7c1
        7dhC9L+g==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzwWZ-00FjgM-1F;
        Fri, 19 May 2023 09:35:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/13] iomap: assign current->backing_dev_info in iomap_file_buffered_write
Date:   Fri, 19 May 2023 11:35:16 +0200
Message-Id: <20230519093521.133226-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the assignment to current->backing_dev_info from the callers into
iomap_file_buffered_write to reduce boiler plate code and reduce the
scope to just around the page dirtying loop.

Note that zonefs was missing this assignment before.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/file.c         | 3 ---
 fs/iomap/buffered-io.c | 3 +++
 fs/xfs/xfs_file.c      | 5 -----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 499ef174dec138..261897fcfbc495 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -25,7 +25,6 @@
 #include <linux/dlm.h>
 #include <linux/dlm_plock.h>
 #include <linux/delay.h>
-#include <linux/backing-dev.h>
 #include <linux/fileattr.h>
 
 #include "gfs2.h"
@@ -1041,11 +1040,9 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 			goto out_unlock;
 	}
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 	pagefault_enable();
-	current->backing_dev_info = NULL;
 	if (ret > 0)
 		written += ret;
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 550525a525c45c..b2779bd1f10611 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (C) 2016-2019 Christoph Hellwig.
  */
+#include <linux/backing-dev.h>
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
@@ -869,8 +870,10 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 
+	current->backing_dev_info = inode_to_bdi(iter.inode);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_write_iter(&iter, i);
+	current->backing_dev_info = NULL;
 
 	if (unlikely(ret < 0))
 		return ret;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index bfba10e0b0f3c2..98d763cc3b114c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -27,7 +27,6 @@
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
-#include <linux/backing-dev.h>
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
@@ -717,9 +716,6 @@ xfs_file_buffered_write(
 	if (ret)
 		goto out;
 
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
-
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
 			&xfs_buffered_write_iomap_ops);
@@ -751,7 +747,6 @@ xfs_file_buffered_write(
 		goto write_retry;
 	}
 
-	current->backing_dev_info = NULL;
 out:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
-- 
2.39.2

