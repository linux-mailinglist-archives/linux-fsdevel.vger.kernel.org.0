Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAD681622
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbjA3QPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjA3QPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:15:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF86E6A64;
        Mon, 30 Jan 2023 08:15:00 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n2so8124405pfo.3;
        Mon, 30 Jan 2023 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVFW2L8PRdmpyXP+UlpsFapVZPiXoES6qg+s7zA41Fw=;
        b=jQWxi9flL3kQMS+w2rBrBQs/69zM7Dk/UGpWDDA/O51nECPATgCPamfmHePcVj/ifY
         7bgOjHai8gu3n/klPjyerkYrMIjQ6tm6JjR/BpHua6mg4jmCSKN3rDXsISoHzfsJR6G2
         +ggTrWy3W10QTr9vTW40Jm1KKc5fauiQHF4Xt5xT3q3EjoXKxwykxlUxP/BpgM07VPhr
         BQSZBaSiabyEqEn64E/Uez4BqB10iNNOCaBAMUAp/ZlfGtW7VTXbptgOzNbe9U0oAXzR
         xEOHx7R2zkETjeFRhgKC/WAwyf1bFtmFpZ5WVPtpV/JVnijNQOhZ/fzx2C76gEAVoNdd
         AeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVFW2L8PRdmpyXP+UlpsFapVZPiXoES6qg+s7zA41Fw=;
        b=bCldCmd3miS2H5iOKigeIbXqDsHKnvOErCicK5v+a9hB6R78MvpLr+I/Pv7qcuH++g
         8FXj0kNdVuyffCpVKlUkETQiHOIBLpxn+NVTEXtl4nT/3wpu32ok9ANdq37rAcOb3xEo
         kg1nfpXF24MhMi5MIjpuvmZHDrqhhkqdfrWKxJWGtRPuBeWHVdOoiX2+bD2DbKY1wANd
         Gxs0M0uEI0pxeFM8IKTW5TI6gFhTl2K5O9PEBcGfE/cPg861sbcYd7Gv+VaY1sqTp2ZU
         senZ391+13YTUPD21YDnyY6AqCfVDkSOrUf+PM9oUo2QVrQeEExyw+aJcJr+vM5a/89k
         naSw==
X-Gm-Message-State: AO0yUKXSawx0vn38cs7gidFRgSloRerYKuNJU410MiNCF7wEnDBFzG8I
        ii0wZz91N/973Cf5cxTxmszuwNNsgIo=
X-Google-Smtp-Source: AK7set8NUJ2e4RazoGqL8YQDJ/IuWw1yK1R8upq/7Gz2EgBiPp+4p40F/+9hhthZePWzaeXaSM6pXA==
X-Received: by 2002:a62:1809:0:b0:590:7330:353c with SMTP id 9-20020a621809000000b005907330353cmr8200313pfy.6.1675095299758;
        Mon, 30 Jan 2023 08:14:59 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id a27-20020a056a001d1b00b00593deb1a329sm795227pfx.66.2023.01.30.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:14:59 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Aravinda Herle <araherle@in.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 3/3] iomap: Support subpage size dirty tracking to improve write performance
Date:   Mon, 30 Jan 2023 21:44:13 +0530
Message-Id: <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675093524.git.ritesh.list@gmail.com>
References: <cover.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
filesystem blocksize, this patch should improve the performance by doing
only the subpage dirty data write.

This should also reduce the write amplification since we can now track
subpage dirty status within state bitmaps. Earlier we had to
write the entire 64k page even if only a part of it (e.g. 4k) was
updated.

Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

<test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

Reported-by: Aravinda Herle <araherle@in.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 103 +++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/super.c      |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index e782b4f1d104..b9c35288a5eb 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -741,7 +741,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepages = gfs2_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-	.dirty_folio = filemap_dirty_folio,
+	.dirty_folio = iomap_dirty_folio,
 	.release_folio = iomap_release_folio,
 	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index faee2852db8f..af3e77276dab 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -44,7 +44,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
+		  bool from_writeback)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -58,12 +59,32 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
 		      gfp);
 	if (iop) {
 		spin_lock_init(&iop->state_lock);
-		if (folio_test_uptodate(folio))
-			bitmap_fill(iop->state, nr_blocks);
+		/*
+		 * iomap_page_create can get called from writeback after
+		 * a truncate_inode_partial_folio operation on a large folio.
+		 * For large folio the iop structure is freed in
+		 * iomap_invalidate_folio() to ensure we can split the folio.
+		 * That means we will have to let go of the optimization of
+		 * tracking dirty bits here and set all bits as dirty if
+		 * the folio is marked uptodate.
+		 */
+		if (from_writeback && folio_test_uptodate(folio))
+			bitmap_fill(iop->state, 2 * nr_blocks);
+		else if (folio_test_uptodate(folio)) {
+			unsigned start = offset_in_folio(folio,
+					folio_pos(folio)) >> inode->i_blkbits;
+			bitmap_set(iop->state, start, nr_blocks);
+		}
+		if (folio_test_dirty(folio)) {
+			unsigned start = offset_in_folio(folio,
+					folio_pos(folio)) >> inode->i_blkbits;
+			start = start + nr_blocks;
+			bitmap_set(iop->state, start, nr_blocks);
+		}
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -168,6 +189,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
 		folio_mark_uptodate(folio);
 }
 
+static void iomap_iop_set_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
+	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iomap_set_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	if (iop)
+		iomap_iop_set_range_dirty(folio, iop, off, len);
+}
+
+static void iomap_iop_clear_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
+	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_clear(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iomap_clear_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	if (iop)
+		iomap_iop_clear_range_dirty(folio, iop, off, len);
+}
+
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -231,7 +294,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iomap_page_create(iter->inode, folio, iter->flags, false);
 	else
 		iop = to_iomap_page(folio);
 
@@ -269,7 +332,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_page_create(iter->inode, folio, iter->flags, false);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -497,6 +560,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
 
+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	unsigned int nr_blocks = i_blocks_per_folio(mapping->host, folio);
+	struct iomap_page *iop = iomap_page_create(mapping->host, folio, 0, false);
+
+	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, folio_pos(folio)),
+			      nr_blocks << mapping->host->i_blkbits);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -528,7 +602,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_page *iop = iomap_page_create(iter->inode, folio,
-						   iter->flags);
+						   iter->flags, false);
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -686,6 +760,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1231,6 +1306,13 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		block_commit_write(&folio->page, 0, length);
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
+		/*
+		 * TODO: We need not set range of dirty bits in iop here.
+		 * This will be taken care by iomap_dirty_folio callback
+		 * function which gets called from folio_mark_dirty().
+		 */
+		iomap_set_range_dirty(folio, to_iomap_page(folio),
+				offset_in_folio(folio, iter->pos), length);
 		folio_mark_dirty(folio);
 	}
 
@@ -1590,7 +1672,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iomap_page_create(inode, folio, 0, true);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1606,7 +1688,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->state))
+		if (iop && !test_bit(i + nblocks, iop->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1650,6 +1732,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}
 
+	iomap_clear_range_dirty(folio, iop,
+				offset_in_folio(folio, folio_pos(folio)),
+				end_pos - folio_pos(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 41734202796f..7e6c54955b4f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -571,7 +571,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.read_folio		= xfs_vm_read_folio,
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index a9c5c3f720ad..4cefc2af87f3 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -267,7 +267,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.read_folio		= zonefs_read_folio,
 	.readahead		= zonefs_readahead,
 	.writepages		= zonefs_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migrate_folio		= filemap_migrate_folio,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0983dfc9a203..b60562a0b893 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -262,6 +262,7 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-- 
2.39.1

