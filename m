Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA405151E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379647AbiD2R34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378214AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955B9F3AD
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+FJqpBnjKvkYcFghyH0RiRG/N81yoH33P8bIUw3ARaI=; b=mkd8v8p8LvF//ofhTfiImSMMxs
        NCDpcbuKIEPF5/YEvERIfZapwWX1relZn33EoXF9lk6GKlGGqHP+FM6Zv2JQmU9gxllRMG/TE4kxW
        /JOrHTxyynIGl0M2Ecnr9pd5sOkYPYVn9zvNP9KfphSkhZ1xRJ3RoCEeFr4w11nF1jMg7aeXQNKbI
        EU18qw7pJHfPv33W9PlVbYP8VqjxbmDJ4RtynjEBFeMoFCiyzgRNj5RZSd1pTlRNIoRQMkp0uL/l/
        vib0GGU09JAW8xig04ZSLAA/hkIkk7RBrm4NJQD5sxccyL3zHaPTmdXwBS4gqEXJJdzPBZbsJuTiT
        dZLtM34Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdX6-9M; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/69] ext4: Use page_symlink() instead of __page_symlink()
Date:   Fri, 29 Apr 2022 18:24:49 +0100
Message-Id: <20220429172556.3011843-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By using the memalloc_nofs_save() functionality, we can call
page_symlink(), safe in the knowledge that it won't recurse into the
filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 767b4bfe39c3..1e7c5deed5e3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/time.h>
 #include <linux/fcntl.h>
+#include <linux/sched/mm.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
@@ -3308,6 +3309,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 
 	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
+		unsigned int flags;
+
 		if (!IS_ENCRYPTED(inode))
 			inode->i_op = &ext4_symlink_inode_operations;
 		inode_nohighmem(inode);
@@ -3329,7 +3332,9 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		handle = NULL;
 		if (err)
 			goto err_drop_inode;
-		err = __page_symlink(inode, disk_link.name, disk_link.len, 1);
+		flags = memalloc_nofs_save();
+		err = page_symlink(inode, disk_link.name, disk_link.len);
+		memalloc_nofs_restore(flags);
 		if (err)
 			goto err_drop_inode;
 		/*
-- 
2.34.1

