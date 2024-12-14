Return-Path: <linux-fsdevel+bounces-37408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FB39F1C47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5505188D5E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207126ACD;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VHdDK0Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D718AE2;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145860; cv=none; b=B0jByBsIAspS727ZSlHvrMvtadBoutu9MQ4M3tf0t3WtDZmyOsXbMO/bM4+kL3+t1S4+1Jepvya9aZLCrDh9Wk2ZXT8b7YDm36yMxA3ilqfQhiqg/15+s6egH/8qYl20SNWIUz7Ouxf+402S77xie224092F3XaVmvvCtNZ92Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145860; c=relaxed/simple;
	bh=qIBIacVwUPG6Ngtozy/fdIO8D5rV9f+t5tzPrtzygH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkbdhMxq/GWtDWQt+29GfNO/r807Thy5lXUnEyRbNRFvwPXhb95ewy9kcCLlUL1vt2AzckNR5zUxgRq4aah/jmsGKpr3LYX9/jy96VYb1I4Ccf0Tpjkwic7pU4g6g/JNHyqbhrokyJKHZXjeey9N5C1NQ+oLg54wsyTUVbLg3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VHdDK0Rw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=17Q0gy/g/R6GF/kNACXWfTzKrmUaCrFTxm3DWtltqxI=; b=VHdDK0RwjffflcX0z4byIMeij+
	aBC6gTkms+qYDlNfhyjSs4Iliz0FzPjXIe39juSBMwSojG8tpjFyDSN1F1sOdoq2Hbh9yXAmmtlOt
	usRJ2g2lmhXmusq/xZg+cKiTaGMTY+FQVlDo3OPNgLXemfBWpiTctwVZz8NZvXSWH9g8b9OeoGLXE
	5H0355Vu+iAVkzf1E2XE6CSW/DqoZK/gq2UnpMD2T5zGEPbqz6W6d8F2PgzjrXvnaBVpXzpwxgwPW
	sLKjc5IS86MBxhWVC7oEkQMS+svl9Wx4GyxjP1KXnek3QBbi0tPj2ClewMr8FHSTRGQw/xqCPLI3r
	u9L99Mgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3b-3W4y;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 03/11] fs/buffer: add iteration support for block_read_full_folio()
Date: Fri, 13 Dec 2024 19:10:41 -0800
Message-ID: <20241214031050.1337920-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Provide a helper to iterate on buffer heads on a folio. We do this
as a preliminary step so to make the subsequent changes easier to
read. Right now we use an array on stack to loop over all buffer heads
in a folio of size MAX_BUF_PER_PAGE, however on CPUs where the system
page size is quite larger like Hexagon with 256 KiB page size support
this can mean the kernel can end up spewing spews stack growth
warnings.

To be able to break this down into smaller array chunks add support for
processing smaller array chunks of buffer heads at a time. The used
array size is not changed yet, that will be done in a subsequent patch,
this just adds the iterator support and logic.

While at it clarify the booleans used on bh_read_batch_async() and
how they are only valid in consideration when we've processed all
buffer-heads of a folio, that is when we're on the last buffer head in
a folio:

  * bh_folio_reads
  * unmapped

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 130 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 94 insertions(+), 36 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 108e1c36fc1a..f8e6a5454dbb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2397,57 +2397,64 @@ static void bh_read_batch_async(struct folio *folio,
 #define bh_next(__bh, __head) \
     (bh_is_last(__bh, __head) ? NULL : (__bh)->b_this_page)
 
+/* Starts from a pivot which you initialize */
+#define for_each_bh_pivot(__pivot, __last, __head)	\
+    for ((__pivot) = __last = (__pivot);		\
+         (__pivot);					\
+         (__pivot) = bh_next(__pivot, __head),		\
+	 (__last) = (__pivot) ? (__pivot) : (__last))
+
 /* Starts from the provided head */
 #define for_each_bh(__tmp, __head)			\
     for ((__tmp) = (__head);				\
          (__tmp);					\
          (__tmp) = bh_next(__tmp, __head))
 
+struct bh_iter {
+	sector_t iblock;
+	get_block_t *get_block;
+	bool any_get_block_error;
+	int unmapped;
+	int bh_folio_reads;
+};
+
 /*
- * Generic "read_folio" function for block devices that have the normal
- * get_block functionality. This is most of the block device filesystems.
- * Reads the folio asynchronously --- the unlock_buffer() and
- * set/clear_buffer_uptodate() functions propagate buffer state into the
- * folio once IO has completed.
+ * Reads up to MAX_BUF_PER_PAGE buffer heads at a time on a folio on the given
+ * block range iblock to lblock and helps update the number of buffer-heads
+ * which were not uptodate or unmapped for which we issued an async read for
+ * on iter->bh_folio_reads for the full folio. Returns the last buffer-head we
+ * worked on.
  */
-int block_read_full_folio(struct folio *folio, get_block_t *get_block)
-{
-	struct inode *inode = folio->mapping->host;
-	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
-	size_t blocksize;
-	int nr, i;
-	int fully_mapped = 1;
-	bool page_error = false;
-	loff_t limit = i_size_read(inode);
-
-	/* This is needed for ext4. */
-	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
-		limit = inode->i_sb->s_maxbytes;
-
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
-	head = folio_create_buffers(folio, inode, 0);
-	blocksize = head->b_size;
+static struct buffer_head *bh_read_iter(struct folio *folio,
+					struct buffer_head *pivot,
+					struct buffer_head *head,
+					struct inode *inode,
+					struct bh_iter *iter, sector_t lblock)
+{
+	struct buffer_head *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh = pivot, *last;
+	int nr = 0, i = 0;
+	size_t blocksize = head->b_size;
+	bool no_reads = false;
+	bool fully_mapped = false;
+
+	/* collect buffers not uptodate and not mapped yet */
+	for_each_bh_pivot(bh, last, head) {
+		BUG_ON(nr >= MAX_BUF_PER_PAGE);
 
-	iblock = div_u64(folio_pos(folio), blocksize);
-	lblock = div_u64(limit + blocksize - 1, blocksize);
-	nr = 0;
-	i = 0;
-
-	for_each_bh(bh, head) {
 		if (buffer_uptodate(bh))
 			continue;
 
 		if (!buffer_mapped(bh)) {
 			int err = 0;
 
-			fully_mapped = 0;
-			if (iblock < lblock) {
+			iter->unmapped++;
+			if (iter->iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
-				err = get_block(inode, iblock, bh, 0);
+				err = iter->get_block(inode, iter->iblock,
+						      bh, 0);
 				if (err)
-					page_error = true;
+					iter->any_get_block_error = true;
 			}
 			if (!buffer_mapped(bh)) {
 				folio_zero_range(folio, i * blocksize,
@@ -2465,10 +2472,61 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		}
 		arr[nr++] = bh;
 		i++;
-		iblock++;
+		iter->iblock++;
+	}
+
+	iter->bh_folio_reads += nr;
+
+	WARN_ON_ONCE(!bh_is_last(last, head));
+
+	if (bh_is_last(last, head)) {
+		if (!iter->bh_folio_reads)
+			no_reads = true;
+		if (!iter->unmapped)
+			fully_mapped = true;
 	}
 
-	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
+	bh_read_batch_async(folio, nr, arr, fully_mapped, no_reads,
+			    iter->any_get_block_error);
+
+	return last;
+}
+
+/*
+ * Generic "read_folio" function for block devices that have the normal
+ * get_block functionality. This is most of the block device filesystems.
+ * Reads the folio asynchronously --- the unlock_buffer() and
+ * set/clear_buffer_uptodate() functions propagate buffer state into the
+ * folio once IO has completed.
+ */
+int block_read_full_folio(struct folio *folio, get_block_t *get_block)
+{
+	struct inode *inode = folio->mapping->host;
+	sector_t lblock;
+	size_t blocksize;
+	struct buffer_head *bh, *head;
+	struct bh_iter iter = {
+		.get_block = get_block,
+		.unmapped = 0,
+		.any_get_block_error = false,
+		.bh_folio_reads = 0,
+	};
+	loff_t limit = i_size_read(inode);
+
+	/* This is needed for ext4. */
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		limit = inode->i_sb->s_maxbytes;
+
+	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+
+	head = folio_create_buffers(folio, inode, 0);
+	blocksize = head->b_size;
+
+	iter.iblock = div_u64(folio_pos(folio), blocksize);
+	lblock = div_u64(limit + blocksize - 1, blocksize);
+
+	for_each_bh(bh, head)
+		bh = bh_read_iter(folio, bh, head, inode, &iter, lblock);
 
 	return 0;
 }
-- 
2.43.0


