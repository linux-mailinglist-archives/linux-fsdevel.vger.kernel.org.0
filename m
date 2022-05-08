Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3251F130
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiEHUeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiEHUdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF5E006
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4AdYNoxSNYf1znHoghZsAbHVJkiPcg5j1cBHuf1ltuk=; b=NsOlI24So2HoTS7H6TKae/1N/R
        xyWQ278aizy7F3JyzNf6hpjszA9ZxJ79jsB+caj7XtVDVPsWn6qEZpwl5qQ187fwOPRWCiTvXiIPI
        z5gyZfnH6/FcS7UNbyEgtSp1gp9dcZluGPinLv4FcZuCtC/ZtfD4+MbyJCimIGN4B5Woviqc5vkam
        oucjCkvXfTu/3hIPnzqOGRKUmPoU0BICUFLPT4B3ayVGy6cz/i0+1671aNYCQMuaVoW41U52dq287
        Uic/QBqd15scY/ec3iqYcQvRSp5nFKWlXRlJCnsRAeRiqrTvu2vJBR6xDJBealZqfz+w4jaadQd/m
        UuOWLirA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXU-002nZf-1Y; Sun, 08 May 2022 20:30:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 21/25] hfsplus: Call hfsplus_write_begin() and generic_write_end() directly
Date:   Sun,  8 May 2022 21:29:37 +0100
Message-Id: <20220508202941.667024-22-willy@infradead.org>
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

There is only one kind of write_begin/write_end aops, so we don't need
to look up which aop it is, just make hfsplus_write_begin() available to
this file and call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/hfsplus/extents.c    | 8 ++++----
 fs/hfsplus/hfsplus_fs.h | 2 ++
 fs/hfsplus/inode.c      | 5 ++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7054a542689f..721f779b4ec3 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -557,12 +557,12 @@ void hfsplus_file_truncate(struct inode *inode)
 		void *fsdata;
 		loff_t size = inode->i_size;
 
-		res = pagecache_write_begin(NULL, mapping, size, 0, 0,
-					    &page, &fsdata);
+		res = hfsplus_write_begin(NULL, mapping, size, 0,
+					  &page, &fsdata);
 		if (res)
 			return;
-		res = pagecache_write_end(NULL, mapping, size,
-			0, 0, page, fsdata);
+		res = generic_write_end(NULL, mapping, size, 0, 0,
+					page, fsdata);
 		if (res < 0)
 			return;
 		mark_inode_dirty(inode);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1798949f269b..396e73aa0961 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -468,6 +468,8 @@ extern const struct address_space_operations hfsplus_aops;
 extern const struct address_space_operations hfsplus_btree_aops;
 extern const struct dentry_operations hfsplus_dentry_operations;
 
+int hfsplus_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata);
 struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 				umode_t mode);
 void hfsplus_delete_inode(struct inode *inode);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 73010aa4623f..905ae3660315 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -43,9 +43,8 @@ static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int hfsplus_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+int hfsplus_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	int ret;
 
-- 
2.34.1

