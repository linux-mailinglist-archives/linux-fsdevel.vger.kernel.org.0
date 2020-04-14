Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143FC1A81F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406767AbgDNPEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405654AbgDNPCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:02:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B9C08ED7D;
        Tue, 14 Apr 2020 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4eFuEtFIx5sdDH8888Ox3V688ScSD2mYzByZubNZjxM=; b=gWambYunuvWQI2G+VNQYnmJr1Z
        TKL6e0+Hz76y6vKTOxSOfADUrM5WCLIQWnN1/g0Fai9ncbP2geBYa12d6sXOFrLkQP9CY2k3676Wl
        H+U6h4ravj3a2BDbUk+8I5w8cPfnD8JmchogfWiM5dibK3wuxfCWNk6jDwHpyfrpA0ThYrxG2rC8z
        QQu9YDaZaL9cJRi0KRgDZ24q7rdnWMeXyZ1VxbmhCX2BAvBEzzUFZMPjyOZDcjGsRaetSzEWZuDQo
        e/792B1Z9I/dZ6qKEyDgMrvRd0hOPInOsEJQnwG5XF3aah3f3EKj4sWn7mT2sY8c0+dcyOpGEwFmt
        PpGG3+Nw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jON5A-0006PS-Fc; Tue, 14 Apr 2020 15:02:36 +0000
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
Subject: [PATCH v11 21/25] ext4: Pass the inode to ext4_mpage_readpages
Date:   Tue, 14 Apr 2020 08:02:29 -0700
Message-Id: <20200414150233.24495-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
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
index 9f2d3cd1df81..a47a98942626 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3316,7 +3316,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 }
 
 /* readpages.c */
-extern int ext4_mpage_readpages(struct address_space *mapping,
+extern int ext4_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fafd2862d7cd..604ad98758fe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3224,7 +3224,7 @@ static int ext4_readpage(struct file *file, struct page *page)
 		ret = ext4_readpage_inline(inode, page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(page->mapping, NULL, page);
+		return ext4_mpage_readpages(inode, NULL, page);
 
 	return ret;
 }
@@ -3237,7 +3237,7 @@ static void ext4_readahead(struct readahead_control *rac)
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

