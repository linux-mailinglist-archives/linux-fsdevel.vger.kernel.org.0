Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED0A18FF61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCWUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bXxQrgQXQShpPRAImqUo+1g9aMfKRLOEa0QksKyDt0Y=; b=oHsH9YdzinUiaUUGgXwK2Kr9GL
        p+PtJJ8EPGRVd2TmXh2RAWU8KcIl6BG8F3K4XiRiRYeZTjWqe7HUI/1F57Z0JOs1jwNBRr7RJUaQR
        icrqQbRpbxYgjFMYJMyVO+8J8b4CzzyA2f4lKLZVx7cX5keBbfDvBsA+Ued6+PaZ3DqhoFmdNT06f
        h1Ym/0f05LHoJBFsqCOM2UTKLISKOw3QzYahUH7/cuuMI8DEW9lQfcw12+02bYbHrQ9o74U1Ygkxv
        xA3yQERj5GatZXGjy8lydEwyH3VD7kesFvedyAc63bUYksONsPU3qjuvG7X1d0kZXFYGOiagDCpRa
        HiVeG79Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbC-0003Vr-3C; Mon, 23 Mar 2020 20:23:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v10 21/25] ext4: Pass the inode to ext4_mpage_readpages
Date:   Mon, 23 Mar 2020 13:22:55 -0700
Message-Id: <20200323202259.13363-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This function now only uses the mapping argument to look up the inode,
and both callers already have the inode, so just pass the inode instead
of the mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h     | 2 +-
 fs/ext4/inode.c    | 4 ++--
 fs/ext4/readpage.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 95b4bb2cc44c..a9c133e6f786 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3298,7 +3298,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 }
 
 /* readpages.c */
-extern int ext4_mpage_readpages(struct address_space *mapping,
+extern int ext4_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a867835bca2d..27b35a79f99c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3226,7 +3226,7 @@ static int ext4_readpage(struct file *file, struct page *page)
 		ret = ext4_readpage_inline(inode, page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(page->mapping, NULL, page);
+		return ext4_mpage_readpages(inode, NULL, page);
 
 	return ret;
 }
@@ -3239,7 +3239,7 @@ static void ext4_readahead(struct readahead_control *rac)
 	if (ext4_has_inline_data(inode))
 		return;
 
-	ext4_mpage_readpages(rac->mapping, rac, NULL);
+	ext4_mpage_readpages(inode, rac, NULL);
 }
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 66275f25235d..5761e9961682 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -221,13 +221,12 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-int ext4_mpage_readpages(struct address_space *mapping,
+int ext4_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
 
-	struct inode *inode = mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
-- 
2.25.1

