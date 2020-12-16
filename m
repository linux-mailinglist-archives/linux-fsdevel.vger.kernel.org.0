Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC442DC65A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgLPSZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgLPSZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C3C0611E4;
        Wed, 16 Dec 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UgpvbXlrAkn91gctm5bwthgBha1dzfDC1MtleM1dKlc=; b=sspeqssMAikfub+pZEyfzlry6z
        CxtJKfgj2OVYYpoAIDjXIOzitXN+IQg5PlrE/lIN5oRd8wWNtFKzetv2eAqtOlDzsmh6en2ORxdxq
        knuLrVETJxXPwVCtrhvYcq75cftkY1wbm3j30IeMPV5XZySO7GhLSFpshQ7HmiDJWFmVBmnXQHdNx
        ZcBdv2dhVBC5dYo3R4TmtdBt8490Nv1PIr316MH2mC+jwCNfTS4Iis259LEXgwHqfaO9FBFL2RSFQ
        ZcF+xqC7VsntFBUqxLqarx1BGELYBybOLc4jM8H6l1c5FYs/vwvtHaIJRCGl11xndKC8qHkOSRO84
        WIAJmgBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSg-00078O-Pk; Wed, 16 Dec 2020 18:23:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] btrfs: Use readahead_batch_length
Date:   Wed, 16 Dec 2020 18:23:28 +0000
Message-Id: <20201216182335.27227-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement readahead_batch_length() to determine the number of bytes in
the current batch of readahead pages and use it in btrfs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c    | 6 ++----
 include/linux/pagemap.h | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e3b72e63e42..42936a83a91b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4436,10 +4436,8 @@ void extent_readahead(struct readahead_control *rac)
 	int nr;
 
 	while ((nr = readahead_page_batch(rac, pagepool))) {
-		u64 contig_start = page_offset(pagepool[0]);
-		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
-
-		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
+		u64 contig_start = readahead_pos(rac);
+		u64 contig_end = contig_start + readahead_batch_length(rac);
 
 		contiguous_readpages(pagepool, nr, contig_start, contig_end,
 				&em_cached, &bio, &bio_flags, &prev_em_start);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 630a0a589073..81ff21289722 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1048,6 +1048,15 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
 	return rac->_nr_pages;
 }
 
+/**
+ * readahead_batch_length - The number of bytes in the current batch.
+ * @rac: The readahead request.
+ */
+static inline loff_t readahead_batch_length(struct readahead_control *rac)
+{
+	return rac->_batch_count * PAGE_SIZE;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
-- 
2.29.2

