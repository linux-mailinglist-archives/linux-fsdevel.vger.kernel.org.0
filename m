Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FB6724F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjARRb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjARRbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0B4F36E
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tKKUPVUCc1vcjlD9WoFla6fgqGJV6pEZLd5u8wPj4kY=; b=W2RLJZtWjZmHv9sTcMQH48sXB/
        JAHhsX1mtELnQxarHrPAvgoQZ/CtP7dC4EJQcW5jwgduy+PTzAUSNbidoYL2CCsx4T1g1EAJE/+bs
        vhnZKih4QVXkR3XHuN5lyqL9REaBX/aSqtuhPh7kUikPHUQSqk50bv2C91GV+3pL4e5EPgQPuqfGM
        pePNW2rboF5ElpEixHLdm7XU5CHV01F9sUldqJXn5K7Nv9ej49ndyAZCfNKB0q8VSicGkqQb451Od
        Ze44hQEf2g3VOFwBvBXQ09WyfI81/CGsglkNf9S7mTE8p+XuujCBqktlBUATnjwIbxC5ygo51PCNK
        sJk88oBQ==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGf-002261-8A; Wed, 18 Jan 2023 17:30:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/7] minix: move releasing pages into unlink and rename
Date:   Wed, 18 Jan 2023 18:30:21 +0100
Message-Id: <20230118173027.294869-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173027.294869-1-hch@lst.de>
References: <20230118173027.294869-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of consuming the page reference and kmap in the low-level
minix_delete_entry and minix_set_link helpers, do it in the callers
where that code can be shared with the error cleanup path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/dir.c   |  2 --
 fs/minix/namei.c | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index dcfe5b25378b54..ec462330e749af 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -306,7 +306,6 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 	} else {
 		unlock_page(page);
 	}
-	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 	return err;
@@ -430,7 +429,6 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
 	} else {
 		unlock_page(page);
 	}
-	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8afdc408ca4fd5..5fc696e032c543 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -150,23 +150,23 @@ static int minix_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 static int minix_unlink(struct inode * dir, struct dentry *dentry)
 {
-	int err = -ENOENT;
 	struct inode * inode = d_inode(dentry);
 	struct page * page;
 	struct minix_dir_entry * de;
+	int err;
 
 	de = minix_find_entry(dentry, &page);
 	if (!de)
-		goto end_unlink;
-
+		return -ENOENT;
 	err = minix_delete_entry(de, page);
-	if (err)
-		goto end_unlink;
+	kunmap(page);
+	put_page(page);
 
+	if (err)
+		return err;
 	inode->i_ctime = dir->i_ctime;
 	inode_dec_link_count(inode);
-end_unlink:
-	return err;
+	return 0;
 }
 
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
@@ -223,7 +223,10 @@ static int minix_rename(struct user_namespace *mnt_userns,
 		new_de = minix_find_entry(new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
+		err = 0;
 		minix_set_link(new_de, new_page, old_inode);
+		kunmap(new_page);
+		put_page(new_page);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -243,8 +246,6 @@ static int minix_rename(struct user_namespace *mnt_userns,
 		minix_set_link(dir_de, dir_page, new_dir);
 		inode_dec_link_count(old_dir);
 	}
-	return 0;
-
 out_dir:
 	if (dir_de) {
 		kunmap(dir_page);
-- 
2.39.0

