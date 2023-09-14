Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076B67A0853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbjINPAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjINPAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7B1FC9;
        Thu, 14 Sep 2023 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bqB65wo0qk1kIS6G0/rbQXc998l0R7mHaDo7i577vOM=; b=ZZF+Uuj0WmXBAgqo6R5Ec/qNCn
        qVjvgSsDLxOneF0b5d/rcYKg1B/zSjisDe8c6MHYVphtRIhQdZtDs06GAOx1Ulh07vOHoJ+szs7n2
        3bGuKrQFXJj+bkyACgXvpb03+iDxvR4OYxBzhQ4iaMC26BpYwt7Frj6K5l2Lmen95adguLnwjRhCB
        RVzkJXTxGN86EwiZuwM+E5mZ35RlRF1nKYhRHTJpXfBQ+8Uk18vqRA5oA6tYMjNhRf1gGx2I7gW4q
        bLNmVLPJtDiWedFThIjlO+nCh/4dtYgYI8xDmW6kTUnxOywy0Jh7qhkLfawx/dQljsXxktdcFM5gu
        1hDcSfyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpG-003XOW-Cl; Thu, 14 Sep 2023 15:00:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 7/8] ext4: Call bdev_getblk() from sb_getblk_gfp()
Date:   Thu, 14 Sep 2023 16:00:10 +0100
Message-Id: <20230914150011.843330-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the callers of sb_getblk_gfp() already assumed that they were
passing the entire GFP flags to use.  Fix up the two callers that didn't,
and remove the __GFP_NOFAIL from them since they both appear to correctly
handle failure.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/super.c             | 10 ++++++++--
 include/linux/buffer_head.h |  6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8d6c82239368..2684ed69403e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,13 +244,19 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	return __ext4_sb_bread_gfp(sb, block, op_flags, __GFP_MOVABLE);
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+			~__GFP_FS) | __GFP_MOVABLE;
+
+	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
 }
 
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	return __ext4_sb_bread_gfp(sb, block, 0, 0);
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+			~__GFP_FS);
+
+	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
 }
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 9ea4b6337251..5372deef732e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -365,10 +365,10 @@ static inline struct buffer_head *sb_getblk(struct super_block *sb,
 	return __getblk(sb->s_bdev, block, sb->s_blocksize);
 }
 
-static inline struct buffer_head *
-sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
+static inline struct buffer_head *sb_getblk_gfp(struct super_block *sb,
+		sector_t block, gfp_t gfp)
 {
-	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, gfp);
+	return bdev_getblk(sb->s_bdev, block, sb->s_blocksize, gfp);
 }
 
 static inline struct buffer_head *
-- 
2.40.1

