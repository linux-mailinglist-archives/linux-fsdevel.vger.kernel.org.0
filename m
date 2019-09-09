Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4CADEDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfIIS1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P0OALANFA/2QhfNdtWVv0Ednyl+D8v845H9cywOtycE=; b=OQhoOnqWQL/eUOqt7cUd3WjjH
        RXP/DnsovIlpQqE+k8cezlsPfG4ilzftaMOAMmP/i9ik6SiaI8M9BdUCCOUlLLYLbassepfuHbf3z
        5ULgsxAzmP8JwmuRcr2u4pAAOnB8JxdNowQZQ0/X9Wnx9yuE126k28EIVA1V4zQacvJHR9uBQQEkE
        B8fGOix5q170jdNJXkBAE5BUqe+Vlik9DENLKmX1BesrW7J00ZtUO0f1hZp7m/ACk7FTjCm1tam3J
        JIgpgxL7xymhG7+ihLqXZ0dW6NpqkeWF2XGU1nKJ3h06LWlDoIHHLMLh+xRwuyCWk+sJ7qT0a8ArN
        tYlSoNTmA==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OO6-0001xE-Nm; Mon, 09 Sep 2019 18:27:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/19] iomap: use write_begin to read pages to unshare
Date:   Mon,  9 Sep 2019 20:27:09 +0200
Message-Id: <20190909182722.16783-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the existing iomap write_begin code to read the pages unshared
by iomap_file_unshare.  That avoids the extra ->readpage call and
extent tree lookup currently done by read_mapping_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 49 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fe099faf540f..a421977a9496 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -533,6 +533,10 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
 #endif /* CONFIG_MIGRATION */
 
+enum {
+	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
+};
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -562,7 +566,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 }
 
 static int
-__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
+__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *iomap)
 {
 	struct iomap_page *iop = iomap_page_create(inode, page);
@@ -581,11 +585,14 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 		if (plen == 0)
 			break;
 
-		if ((from <= poff || from >= poff + plen) &&
+		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
+		    (from <= poff || from >= poff + plen) &&
 		    (to <= poff || to >= poff + plen))
 			continue;
 
 		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
+			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
+				return -EIO;
 			zero_user_segments(page, poff, from, to, poff + plen);
 			iomap_set_range_uptodate(page, poff, plen);
 			continue;
@@ -631,7 +638,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, iomap);
 	else
-		status = __iomap_write_begin(inode, pos, len, page, iomap);
+		status = __iomap_write_begin(inode, pos, len, flags, page,
+				iomap);
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -854,22 +862,6 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
-static struct page *
-__iomap_read_page(struct inode *inode, loff_t offset)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
-
-	page = read_mapping_page(mapping, offset >> PAGE_SHIFT, NULL);
-	if (IS_ERR(page))
-		return page;
-	if (!PageUptodate(page)) {
-		put_page(page);
-		return ERR_PTR(-EIO);
-	}
-	return page;
-}
-
 static loff_t
 iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -885,24 +877,15 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		return length;
 
 	do {
-		struct page *page, *rpage;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
-
-		offset = offset_in_page(pos);
-		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
-
-		rpage = __iomap_read_page(inode, pos);
-		if (IS_ERR(rpage))
-			return PTR_ERR(rpage);
+		unsigned long offset = offset_in_page(pos);
+		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
+		struct page *page;
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
-		put_page(rpage);
+		status = iomap_write_begin(inode, pos, bytes,
+				IOMAP_WRITE_F_UNSHARE, &page, iomap);
 		if (unlikely(status))
 			return status;
 
-		WARN_ON_ONCE(!PageUptodate(page));
-
 		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
 		if (unlikely(status <= 0)) {
 			if (WARN_ON_ONCE(status == 0))
-- 
2.20.1

