Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24A6EC56B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjDXFtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDXFtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:49:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6231726;
        Sun, 23 Apr 2023 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V5nklQoA9f4p457fAmSLCbWYVHcQ95Tr9Yi93vZ1hXQ=; b=BVLdIyeC9XyB883rbVnHnnshYb
        v9MBAr9Kui06l3iqsHsxD6wr7hDLJughW5sYL6bLE4MMi2NT4MojE/Kqi+QP5twRZ+EZc4+pHQm3S
        kcN/fEcPtZ2XKOf2kEcveCPw4THCw9R3Vp3FTaYaHC5Q6XyN/KDa1LZrslZMBHL8ouAUMCh+sbtnt
        jGhkPdK1bf1+RRVNAAo7uctMzy3iud0d3e4hNElvjoV0xaEA7vu/iU7cwGxhgjr4qByRCVU5CGTNI
        M7ydlMTMwaIbWoe21seFAlCC/o0TZc5ZPNp4ELlK9gRxqfYBpHM10qTh06+1CPkGzgFFFvJGUiBet
        OQvgwjkg==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp4y-00FOuS-1q;
        Mon, 24 Apr 2023 05:49:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
Date:   Mon, 24 Apr 2023 07:49:11 +0200
Message-Id: <20230424054926.26927-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

def_blk_fops always returns -ENODEV, which dosn't match the return value
of a non-existing block device with CONFIG_BLOCK, which is -ENXIO.
Just remove the extra implementation and fall back to the default
no_open_fops that always returns -ENXIO.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Makefile   | 10 ++--------
 fs/inode.c    |  3 ++-
 fs/no-block.c | 19 -------------------
 3 files changed, 4 insertions(+), 28 deletions(-)
 delete mode 100644 fs/no-block.c

diff --git a/fs/Makefile b/fs/Makefile
index 05f89b5c962f88..da21e7d0a1cf37 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -18,14 +18,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o
 
-ifeq ($(CONFIG_BLOCK),y)
-obj-y +=	buffer.o mpage.o
-else
-obj-y +=	no-block.o
-endif
-
-obj-$(CONFIG_PROC_FS) += proc_namespace.o
-
+obj-$(CONFIG_BLOCK)		+= buffer.o mpage.o
+obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
 obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f135573..d43f07f146eb73 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2265,7 +2265,8 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = rdev;
 	} else if (S_ISBLK(mode)) {
-		inode->i_fop = &def_blk_fops;
+		if (IS_ENABLED(CONFIG_BLOCK))
+			inode->i_fop = &def_blk_fops;
 		inode->i_rdev = rdev;
 	} else if (S_ISFIFO(mode))
 		inode->i_fop = &pipefifo_fops;
diff --git a/fs/no-block.c b/fs/no-block.c
deleted file mode 100644
index 481c0f0ab4bd2c..00000000000000
--- a/fs/no-block.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* no-block.c: implementation of routines required for non-BLOCK configuration
- *
- * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/kernel.h>
-#include <linux/fs.h>
-
-static int no_blkdev_open(struct inode * inode, struct file * filp)
-{
-	return -ENODEV;
-}
-
-const struct file_operations def_blk_fops = {
-	.open		= no_blkdev_open,
-	.llseek		= noop_llseek,
-};
-- 
2.39.2

