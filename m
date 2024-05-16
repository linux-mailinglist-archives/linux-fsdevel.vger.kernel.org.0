Return-Path: <linux-fsdevel+bounces-19597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83908C7BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F851C2237A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BA156F41;
	Thu, 16 May 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlOPIfUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26593156642;
	Thu, 16 May 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883419; cv=none; b=fE1ubDD3KubSbWv0dES/0no81Bl7L36QuX8E+pi0yN0SR7gSxmpJ8CDfwiyy2eDH0nYpNOArK3C+Cyzo9Zzbz99F+rO7vO1FqQwEp0gYnbVhjfXdbHDP1PDaxk6yyleg2hvZSCaz/q5LvBu8MEUUi4KqUMIgf3eKCZyYvMGLOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883419; c=relaxed/simple;
	bh=euT+T82A22i2OFu5wfGFK62YgbYU4tPN5+GtgGpwi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6EVqOzDuF97DBo59YXppG8FWHPh7e1bM9MldFS7Jo0C2ethurRunamcFNFos86wZNYgH7aR1/B36O89iKzDg5SdwIkIe/DpYOiPmTEgXfX4G2B0nNOeXt1EEn1cVx+lrzfRl7UJMLcD7ZiA3peCgK94dW2+TBF4fDu3twuO52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GlOPIfUc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=i3kQ7stC3DK9CVJmM0bmn2z8NO/OC1l78IADZjYM0RU=; b=GlOPIfUc1touMc81UhO++/bJUP
	S7YIahFaVtgxyRpv+tC38Co5tGvAPe2u+Wj6cWSuj8zQ4wamy+3ijF4oGvDas/I04P7uvdSXJe7Si
	hRYMu5O8D4GPro3VxnFw+r74SV/pbGfS/fXD56FNHAplnFKgfIUgAKy2yx82ahd8wbO1v265lU8mE
	UuboK54JAsT23TblYysqRS9et9xqV8r+8iJJydiHg1pYfzJVW8ad3PH2CCWYc/3Mi3/mM3raNvqlf
	xbW0JSbABy6TQXo9yeyhpkZ6D6gPTV6KoXpW4bUFrXADXr6Aau6jcS2QJyk/1mtBPzLU3LR5W6Iu3
	zOYmutzg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7fet-0000000C5AB-3er9;
	Thu, 16 May 2024 18:16:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/2] ext4: Remove array of buffer_heads from mext_page_mkuptodate()
Date: Thu, 16 May 2024 19:16:51 +0100
Message-ID: <20240516181651.2879778-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516181651.2879778-1-willy@infradead.org>
References: <20240516181651.2879778-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code iterates over the list of buffer_heads, finds the
!uptodate ones and reads them, waiting for each one before submitting
the next one.  Instead, submit all the read requests before waiting
for each of the needed ones.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7cd4afa4de1d..529061fa3fbf 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -166,15 +166,16 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	return 0;
 }
 
-/* Force page buffers uptodate w/o dropping page's lock */
-static int
-mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
+/* Force folio buffers uptodate w/o dropping folio's lock */
+static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t block;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head;
 	unsigned int blocksize, block_start, block_end;
-	int i, err,  nr = 0, partial = 0;
+	int err = 0,  nr = 0;
+	bool partial = false;
+
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(folio_test_writeback(folio));
 
@@ -186,13 +187,14 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 	if (!head)
 		head = create_empty_buffers(folio, blocksize, 0);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - inode->i_blkbits);
-	for (bh = head, block_start = 0; bh != head || !block_start;
-	     block++, block_start = block_end, bh = bh->b_this_page) {
+	block = folio_pos(folio) >> inode->i_blkbits;
+	block_end = 0;
+	for (bh = head; bh != head; block++, bh = bh->b_this_page) {
+		block_start = block_end;
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (!buffer_uptodate(bh))
-				partial = 1;
+				partial = true;
 			continue;
 		}
 		if (buffer_uptodate(bh))
@@ -209,25 +211,28 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 				continue;
 			}
 		}
-		BUG_ON(nr >= MAX_BUF_PER_PAGE);
-		arr[nr++] = bh;
+		ext4_read_bh_nowait(bh, 0, NULL);
+		nr++;
 	}
 	/* No io required */
 	if (!nr)
 		goto out;
 
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		if (!bh_uptodate_or_lock(bh)) {
-			err = ext4_read_bh(bh, 0, NULL);
-			if (err)
-				return err;
-		}
+	for (bh = head; bh != head; bh = bh->b_this_page) {
+		if (bh_offset(bh) + blocksize <= from)
+			continue;
+		if (bh_offset(bh) > to)
+			break;
+		wait_on_buffer(bh);
+		if (buffer_uptodate(bh))
+			continue;
+		err = -EIO;
+		break;
 	}
 out:
-	if (!partial)
+	if (!err && !partial)
 		folio_mark_uptodate(folio);
-	return 0;
+	return err;
 }
 
 /**
-- 
2.43.0


