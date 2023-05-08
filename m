Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933566FB32A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjEHOoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjEHOoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 10:44:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A826AD;
        Mon,  8 May 2023 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4kuu4gBwsJnGnwZXLqP9nf/S9Djc87/bItwQ4iUImwo=; b=QZyfqMk4eQEDtPi9vCHi7Ag4qx
        Xp1ecG+OCrFaBVyEGKLsKvuUbwL/VMgPYvCj+gNC/as92GM6zBw5+UMWnvDPwqxODeE33TrEGYS1w
        xOb1C7OgriKJQvze/2rnb39kyMEXCMISkAKg87W+0QJVBETqwHxoAVdozoFBN0gEf2WRh8SQoT1qK
        DtPCXMGjXAiB/KUIYaDxCQav6xZGFtRhnP9+Eq+IX2Ug6rRmwAXkT/kLnnH+PrIUlEruhSe3QJPpk
        wjp8w59qZgbkBytZSVw5Z+qwZfRVkx7oPnxX3kwZSnMVX0tVa/GhdGIWHR0sxkdfo3QRLNqlzG651
        g5fCVuuw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw25t-000n0F-30;
        Mon, 08 May 2023 14:44:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: remove the special !CONFIG_BLOCK def_blk_fops
Date:   Mon,  8 May 2023 07:44:05 -0700
Message-Id: <20230508144405.41792-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Fixes: 9361401eb761 ("[PATCH] BLOCK: Make it possible to disable the block layer [try #6]")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Makefile   | 10 ++--------
 fs/inode.c    |  3 ++-
 fs/no-block.c | 19 -------------------
 3 files changed, 4 insertions(+), 28 deletions(-)
 delete mode 100644 fs/no-block.c

diff --git a/fs/Makefile b/fs/Makefile
index 834f1c3dba4642..4709eba1303c60 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -17,14 +17,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
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
index 577799b7855f6f..4d6a1544e95b7f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2264,7 +2264,8 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
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

