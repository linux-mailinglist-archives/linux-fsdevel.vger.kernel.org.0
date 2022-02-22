Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7873D4C0248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiBVTs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03BB715F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gtgskDXp/tcHj+rjiWtlCF2I5xpsBBQ+frpV3m+21BA=; b=Ym3RPixQX2v/laiXujZCw4oH12
        S1KRQYzj1m68R9IpUaYxhG6JmunkWzn3EP1NJ2OnxxtQe2L+ouj9DZtCIu/2PtepLLLYikaUjHgu/
        isQ9rizetdmw5z8VAZdpIbPEX6lWrDa+1yIezSwsoJAwAxUWD/I3/u2Zd1wVHV5ddj7VMiq7be9AQ
        MAcuCOK+1ruEyNB3wwjQLcqC5jJXiBQ1An6viI28LO+3bVWPQHZt3yuHNFzgmxzhwihkKEKt2M4j/
        OCdi816XIvLoeuOedw21dMM8kIICPxOk0p8MsLJGfEP+qlxU3IY9lB4dG56s3ECio1km8y3UZyOU8
        CqZfVQkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zk-FX; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/22] ext4: Use page_symlink() instead of __page_symlink()
Date:   Tue, 22 Feb 2022 19:48:03 +0000
Message-Id: <20220222194820.737755-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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
---
 fs/ext4/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8cf0a924a49b..52799e1d579f 100644
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

