Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9271A5151DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379627AbiD2R3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379517AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4969D06E
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PAfZABp1iNExCHmAXKO7YXQ6u4PT0MOTepjBvoeGvoE=; b=Q6hnBP8ElC2lTUtltAG/zcIR4P
        P67M7J5OLof00m01U1PoYp0A9y8riu5SDsZEwzLrf49wd+mMGOwx4mPc4bsPpXkmjerb+6mld2pU0
        926bXaNAd1UZxF6W7ThWeHRph9F7nAA8oyQWwKx9ANbJnS1SDOU67Lw41saND8fSGrzUfv/SXs8TL
        xXlYQEgGLzqDfTrkqx15tdROMutQuCxexOKzqh0zTR90VfHenJ+Y/6XTme/TYrWM5XqXIoLybzk1R
        5ONFIQetnVRc65go6CLgPm4LP9IWQ0PN6N1K3qldihO1ItYrQkcLPwLQeW6qcI79qhGpERifTxqtE
        Z31XSnmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNY-00CdYh-L1; Fri, 29 Apr 2022 17:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/69] hfs: Call hfs_write_begin() and generic_write_end() directly
Date:   Fri, 29 Apr 2022 18:25:07 +0100
Message-Id: <20220429172556.3011843-21-willy@infradead.org>
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

There is only one kind of write_begin/write_end aops, so we don't need
to look up which aop it is, just make hfs_write_begin() available to
this file and call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfs/extent.c | 6 +++---
 fs/hfs/hfs_fs.h | 2 ++
 fs/hfs/inode.c  | 5 ++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 263d5028d9d1..3f7e9bef9874 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -491,10 +491,10 @@ void hfs_file_truncate(struct inode *inode)
 
 		/* XXX: Can use generic_cont_expand? */
 		size = inode->i_size - 1;
-		res = pagecache_write_begin(NULL, mapping, size+1, 0, 0,
-					    &page, &fsdata);
+		res = hfs_write_begin(NULL, mapping, size + 1, 0, &page,
+				&fsdata);
 		if (!res) {
-			res = pagecache_write_end(NULL, mapping, size+1, 0, 0,
+			res = generic_write_end(NULL, mapping, size + 1, 0, 0,
 					page, fsdata);
 		}
 		if (res)
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index b8eb0322a3e5..68d0305880f7 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -201,6 +201,8 @@ extern int hfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
+int hfs_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata);
 extern struct inode *hfs_new_inode(struct inode *, const struct qstr *, umode_t);
 extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, __be32 *, __be32 *);
 extern int hfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 93d9aa832139..9a26b9510da0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -49,9 +49,8 @@ static void hfs_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int hfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+int hfs_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	int ret;
 
-- 
2.34.1

