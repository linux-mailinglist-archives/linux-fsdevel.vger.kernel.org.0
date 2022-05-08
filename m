Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3FF51F12E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiEHUeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiEHUdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB7DFEA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+FJqpBnjKvkYcFghyH0RiRG/N81yoH33P8bIUw3ARaI=; b=MBMEySWFYlK3OXr6oCp1Aj8Og5
        ExMzcKnZBquyLMrGjZmxPlbbz3JSyt5DeliReRwS+bUhHj6LIFx9kNcqlQ2UwkBiZsSJCJnxO43fc
        NGp8lWmy7j3bcuBeLm900dSfJmyyg8/aQlEWOISjyoPoitqJpGEp1OTwqqwaSbrXBz/8SDe7czGvA
        +COM9xRElXilf644nr3bSxVZn1glm4HLiD+qug48hFzXF+OvGkqseONGed+u/YFpUK6rG5EscMv/t
        Ea6eU7MQNw8nPAYcinRl+eQpg4LJEel/ZBZiyGkZ9hc6ZROioLki2cdEHEvgz1Mm1gWzpzfGvYi4j
        ouAcLzIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXR-002nXt-Sm; Sun, 08 May 2022 20:29:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/25] ext4: Use page_symlink() instead of __page_symlink()
Date:   Sun,  8 May 2022 21:29:17 +0100
Message-Id: <20220508202941.667024-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

