Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8751D6F9B34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEGT2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjEGT2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F141156D;
        Sun,  7 May 2023 12:28:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaec9ad820so35184375ad.0;
        Sun, 07 May 2023 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487709; x=1686079709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8AgPtFTLwnnodFqXnj65oA9+VPfSCvnmXBU33BWJTQ=;
        b=UzDy2pFnv8hMMLnzl0UM+Hojq3uIdg15q+uOAHKnXsFuHaTOtqrW7c4Q2O+Oc8ABzC
         yqiGg07rDtNm3+Nro30SZY55ROh0NlwAVNxWNDtMI5n3l8aQuizsezn15c//IcbMAkh1
         Whxcm7N8VRo/ZWNNZ2Pk7gJ8EPfuFmRLZmbc95KqWB3isuCkQnjZdb9k6JsUa9QHhX/N
         Jo8ghD3kOVEIwIe+b95sFVwGmqikk2kjWjEl/J7S1uA7RDhkeqdhYCV7NZ97V8ws5sNJ
         5TDVaFfeEonMPSd5ubN2o7WRtD14b9082ySyRogpS5WO0dGtnAZkN1eJOiEYHUt0QOnC
         Iypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487709; x=1686079709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8AgPtFTLwnnodFqXnj65oA9+VPfSCvnmXBU33BWJTQ=;
        b=AX8+ZlcRWjNPw3QHhXcsn4g5+NWYLcE33O5pXsmwNxk+86DLoyooqiT6Mqv0h0LbcO
         efWeO0WbgfB0Yqbs6eOptocSw2YgbWLYzRh7xq7C9IdItWQuhBfhZrYlvxqGDx6b9ITA
         Qi7Wace/Ooncyap4wGk29ze5ekS+BpTI2xprDl+fh5IgD0BdN/ISIL97ZeBByzhfoMTv
         ZD6JiRMDyIu/nasyZa78a19F9BHLdHbsrm7VqlnmIT7EWFBulWs+4v+7UDWToqpjho6g
         G6P18Wd+k8Ibv8tt9aBiUK0HI/kVDTO6kgT/EOUQCO9kyh0YQ/eUPGd62l0h1nVKSMz1
         63RA==
X-Gm-Message-State: AC+VfDyQu4GMpIk3r+o6yUjz/5mpBk+vQltHgEvSK70fXbq6zhRNIG7K
        pI6oHFJEA5wy2o+tc1w4fi7vVnJWCNc=
X-Google-Smtp-Source: ACHHUZ63huWcIE+wanl2Cpp834onJAx9K24ZbqEam48izbzxWYt0dV6h3DtZCETWZ3+utxpf6tliuw==
X-Received: by 2002:a17:903:41c1:b0:1ac:4162:5922 with SMTP id u1-20020a17090341c100b001ac41625922mr9668351ple.66.1683487709390;
        Sun, 07 May 2023 12:28:29 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:29 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve performance
Date:   Mon,  8 May 2023 00:58:00 +0530
Message-Id: <86987466d8d7863bd0dca81e9d6c3eff7abd4964.1683485700.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683485700.git.ritesh.list@gmail.com>
References: <cover.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When filesystem blocksize is less than folio size (either with
mapping_large_folio_support() or with blocksize < pagesize) and when the
folio is uptodate in pagecache, then even a byte write can cause
an entire folio to be written to disk during writeback. This happens
because we currently don't have a mechanism to track per-block dirty
state within struct iomap_page. We currently only track uptodate state.

This patch implements support for tracking per-block dirty state in
iomap_page->state bitmap. This should help improve the filesystem write
performance and help reduce write amplification.

Performance testing of below fio workload reveals ~16x performance
improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

1. <test_randwrite.fio>
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

2. Also our internal performance team reported that this patch improves
   their database workload performance by around ~83% (with XFS on Power)

Reported-by: Aravinda Herle <araherle@in.ibm.com>
Reported-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 115 ++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a5f4be6b9213..75efec3c3b71 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepages = gfs2_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-	.dirty_folio = filemap_dirty_folio,
+	.dirty_folio = iomap_dirty_folio,
 	.release_folio = iomap_release_folio,
 	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 25f20f269214..c7f41b26280a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -52,6 +52,12 @@ static inline void iop_set_range(struct iomap_page *iop, unsigned int start_blk,
 	bitmap_set(iop->state, start_blk, nr_blks);
 }

+static inline void iop_clear_range(struct iomap_page *iop,
+				   unsigned int start_blk, unsigned int nr_blks)
+{
+	bitmap_clear(iop->state, start_blk, nr_blks);
+}
+
 static inline bool iop_test_block(struct iomap_page *iop, unsigned int block)
 {
 	return test_bit(block, iop->state);
@@ -84,6 +90,16 @@ static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
 	return iop_test_block(iop, block);
 }

+static bool iop_test_block_dirty(struct folio *folio, int block)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	WARN_ON(!iop);
+	return iop_test_block(iop, block + blks_per_folio);
+}
+
 static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
 				   size_t off, size_t len)
 {
@@ -104,8 +120,42 @@ static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
 	}
 }

+static void iop_set_range_dirty(struct inode *inode, struct folio *folio,
+				size_t off, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	if (!iop)
+		return;
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_set_range(iop, first_blk + blks_per_folio, nr_blks);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iop_clear_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	if (!iop)
+		return;
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_clear_range(iop, first_blk + blks_per_folio, nr_blks);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
 static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
-				    unsigned int flags)
+				    unsigned int flags, bool is_dirty)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -119,12 +169,20 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;

-	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
+	/*
+	 * iop->state tracks two sets of state flags when the
+	 * filesystem block size is smaller than the folio size.
+	 * The first state tracks per-block uptodate and the
+	 * second tracks per-block dirty state.
+	 */
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
 		      gfp);
 	if (iop) {
 		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
 			iop_set_range(iop, 0, nr_blocks);
+		if (is_dirty)
+			iop_set_range(iop, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -268,7 +326,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iop_alloc(iter->inode, folio, iter->flags);
+		iop = iop_alloc(iter->inode, folio, iter->flags,
+				folio_test_dirty(folio));
 	else
 		iop = to_iomap_page(folio);

@@ -306,7 +365,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);

 	/* zero post-eof blocks as the page may be mapped */
-	iop = iop_alloc(iter->inode, folio, iter->flags);
+	iop = iop_alloc(iter->inode, folio, iter->flags,
+			folio_test_dirty(folio));
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -561,6 +621,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);

+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	struct iomap_page *iop;
+	struct inode *inode = mapping->host;
+	size_t len = i_blocks_per_folio(inode, folio) << inode->i_blkbits;
+
+	iop = iop_alloc(inode, folio, 0, false);
+	iop_set_range_dirty(inode, folio, 0, len);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -608,7 +680,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;

-	iop = iop_alloc(iter->inode, folio, iter->flags);
+	iop = iop_alloc(iter->inode, folio, iter->flags,
+			folio_test_dirty(folio));

 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
@@ -767,6 +840,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos), len);
+	iop_set_range_dirty(inode, folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -954,6 +1028,10 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
+		struct iomap_page *iop;
+		unsigned int first_blk, last_blk, blks_per_folio, i;
+		loff_t last_byte;
+		u8 blkbits = inode->i_blkbits;

 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -978,6 +1056,28 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 				}
 			}

+			/*
+			 * When we have per-block dirty tracking, there can be
+			 * blocks within a folio which are marked uptodate
+			 * but not dirty. In that case it is necessary to punch
+			 * out such blocks to avoid leaking any delalloc blocks.
+			 */
+			iop = to_iomap_page(folio);
+			if (!iop)
+				goto skip_iop_punch;
+			last_byte = min_t(loff_t, end_byte - 1,
+				(folio_next_index(folio) << PAGE_SHIFT) - 1);
+			first_blk = offset_in_folio(folio, start_byte) >>
+						    blkbits;
+			last_blk = offset_in_folio(folio, last_byte) >>
+						   blkbits;
+			blks_per_folio = i_blocks_per_folio(inode, folio);
+			for (i = first_blk; i <= last_blk; i++) {
+				if (!iop_test_block_dirty(folio, i))
+					punch(inode, i << blkbits,
+						     1 << blkbits);
+			}
+skip_iop_punch:
 			/*
 			 * Make sure the next punch start is correctly bound to
 			 * the end of this data range, not the end of the folio.
@@ -1666,7 +1766,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iop_alloc(inode, folio, 0);
+	struct iomap_page *iop = iop_alloc(inode, folio, 0, true);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1682,7 +1782,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !iop_test_block_uptodate(folio, i))
+		if (iop && !iop_test_block_dirty(folio, i))
 			continue;

 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1726,6 +1826,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}

+	iop_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2ef78aa1d3f6..77c7332ae197 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -578,7 +578,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.read_folio		= xfs_vm_read_folio,
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..e508c8e97372 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -175,7 +175,7 @@ const struct address_space_operations zonefs_file_aops = {
 	.read_folio		= zonefs_read_folio,
 	.readahead		= zonefs_readahead,
 	.writepages		= zonefs_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migrate_folio		= filemap_migrate_folio,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..0c2bee80565c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -264,6 +264,7 @@ bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
--
2.39.2

