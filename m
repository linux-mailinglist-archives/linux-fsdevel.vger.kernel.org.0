Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9551F134
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiEHUeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiEHUdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602CE009
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xgg3hfFzmZXJAZ0Ce7ibjyyF9U0Uk00kS7JDxy/9M+o=; b=uLPYciElESQty1vYyYaVgCy4JR
        chbX58zP1/6+m9El++7kW6sGc3zr5wtoQgmrygp3X2c1ULJtkga9RZR+rIICzm3Ejsl1wtxITvXAh
        5Fkf+PbNwZQPNz0VrAB2J514kNGL+StBoNR4xlUL+Og4BqN6dLg3OmojQV51NjN3NarQIxuzn6Zhu
        qnbv2a4kUnbnPIUxAolgW3btMx70Ue9HnYkbUTWPJs6K0rAp5R7tbOptPfQ2L6L0FQ2rSVdjLXwE8
        CtB7wJfn9BoEsPxuoCej4eITRoS3DCijnDcvJ6NB5I3qoPf804ATManDx4/pCkTmMjwwpb1Fr/dGd
        BMD90FjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nZd-VO; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/25] hfs: Call hfs_write_begin() and generic_write_end() directly
Date:   Sun,  8 May 2022 21:29:36 +0100
Message-Id: <20220508202941.667024-21-willy@infradead.org>
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
to look up which aop it is, just make hfs_write_begin() available to
this file and call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

