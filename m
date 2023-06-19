Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA6734A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFSC3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFSC3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A58E4C;
        Sun, 18 Jun 2023 19:29:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9e36e5ea8so25500941cf.3;
        Sun, 18 Jun 2023 19:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141769; x=1689733769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO1To0LqRLNdbiQA/kflsw/IzgNitRtvfDgKhsX/Ado=;
        b=Lj1r1m8YzA8T4RFDREbsLFQEDEKRHW6bzwm0ixipbg6d7v6N+5nnMYQ8BRCmrXo75j
         u6qvzNyL931UiBaY4+9zQCssNmFBBGpSdb4u3bRGaf/UM/adOHyUbZy4eN07q3cvfPHD
         HoJ/IHUzuio6wG3buFOzBujdv7l48AeqPmLEhVASGC8aOG1sg1gBgxH6EcZqTDEENehV
         hyrXJVnHb+5wiimkUhsSWCvF39Fw6DPzH3g8mw1uv7ZX+F/BIWweGnq4MXx3prqFbfC/
         MRfND04zBUa2r0RrvzF707P4JyjHNqXoXCIiOvQxS+QYHUgA4y4pg7k/zthv+ljw95X3
         KKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141769; x=1689733769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO1To0LqRLNdbiQA/kflsw/IzgNitRtvfDgKhsX/Ado=;
        b=L9tHH70giFWWi3IYoiBO7IX3k/vuM/pLAM3ZDP4fnDkZEmuS3ny5Jm0bTRL4k8qBLn
         T2NtHpzOZvnWCPbQ4moPjnsTWUuVAt97Xf4Hs5GxSlsjZuG1drUfnGJyQS17tDi1Sv+9
         3g3JfngQSSPmFVTvzMCxF2plO6fTx+uaOnb8D7TqvuYGJVdjCGfLBtZeQbJ2+gv6Qqy0
         +DW/0NdwL5Pe87mAxvvcyG/r0rNSJjLON78ReAvzEICc9w5BImF8Uznlh0mEsWNRAQym
         nodu/bjI/nu2twszjrN5aodn/Flz8VOGaDHmmDp4NjqoJTOA2a57hNun/mPkKnY4hhaI
         HwcQ==
X-Gm-Message-State: AC+VfDy/5Xq2C55s7F5MHmifbIft+pFtSEZiDLLbBelWywo3GhhiA/gg
        0EmnKOVdoCDzSFnYYykeuOGaZeCiAfQ=
X-Google-Smtp-Source: ACHHUZ4wVlo84kyIQcD/m9j9kxlIPokw6x7CZRca2vlMW30WAgA1HDjv96WEzlVGqr+LM3893BHgvQ==
X-Received: by 2002:a05:622a:15d4:b0:3fd:ec4a:2198 with SMTP id d20-20020a05622a15d400b003fdec4a2198mr3661066qty.18.1687141768981;
        Sun, 18 Jun 2023 19:29:28 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:28 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to improve performance
Date:   Mon, 19 Jun 2023 07:58:51 +0530
Message-Id: <6db62a08dda3a348303e2262454837149c2afe2a.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
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
state within struct iomap_folio_state. We currently only track uptodate
state.

This patch implements support for tracking per-block dirty state in
iomap_folio_state->state bitmap. This should help improve the filesystem
write performance and help reduce write amplification.

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
 fs/iomap/buffered-io.c | 189 ++++++++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 171 insertions(+), 25 deletions(-)

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
index 391d918ddd22..50f5840bb5f9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -25,7 +25,7 @@
 
 typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
- * Structure allocated for each folio to track per-block uptodate state
+ * Structure allocated for each folio to track per-block uptodate, dirty state
  * and I/O completions.
  */
 struct iomap_folio_state {
@@ -35,31 +35,55 @@ struct iomap_folio_state {
 	unsigned long		state[];
 };
 
+enum iomap_block_state {
+	IOMAP_ST_UPTODATE,
+	IOMAP_ST_DIRTY,
+
+	IOMAP_ST_MAX,
+};
+
+static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
+		enum iomap_block_state state, unsigned int *first_blkp,
+		unsigned int *nr_blksp)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first = off >> inode->i_blkbits;
+	unsigned int last = (off + len - 1) >> inode->i_blkbits;
+
+	*first_blkp = first + (state * blks_per_folio);
+	*nr_blksp = last - first + 1;
+}
+
 static struct bio_set iomap_ioend_bioset;
 
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 					       struct iomap_folio_state *ifs)
 {
 	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int nr_blks = (IOMAP_ST_UPTODATE + 1) * blks_per_folio;
 
-	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
+	return bitmap_full(ifs->state, nr_blks);
 }
 
-static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
-					       unsigned int block)
+static inline bool ifs_block_is_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs, unsigned int block)
 {
-	return test_bit(block, ifs->state);
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	return test_bit(block + IOMAP_ST_UPTODATE * blks_per_folio, ifs->state);
 }
 
 static void ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
-	struct inode *inode = folio->mapping->host;
-	unsigned int first_blk = off >> inode->i_blkbits;
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, nr_blks;
 	unsigned long flags;
 
+	ifs_calc_range(folio, off, len, IOMAP_ST_UPTODATE, &first_blk,
+			     &nr_blks);
 	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
 	if (ifs_is_fully_uptodate(folio, ifs))
@@ -78,6 +102,55 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
+static inline bool ifs_block_is_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, int block)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	return test_bit(block + IOMAP_ST_DIRTY * blks_per_folio, ifs->state);
+}
+
+static void ifs_clear_range_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	unsigned int first_blk, nr_blks;
+	unsigned long flags;
+
+	ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk, &nr_blks);
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_clear(ifs->state, first_blk, nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs)
+		ifs_clear_range_dirty(folio, ifs, off, len);
+}
+
+static void ifs_set_range_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	unsigned int first_blk, nr_blks;
+	unsigned long flags;
+
+	ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk, &nr_blks);
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk, nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs)
+		ifs_set_range_dirty(folio, ifs, off, len);
+}
+
 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -93,14 +166,24 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	ifs = kzalloc(struct_size(ifs, state, BITS_TO_LONGS(nr_blocks)),
-		      gfp);
-	if (ifs) {
-		spin_lock_init(&ifs->state_lock);
-		if (folio_test_uptodate(folio))
-			bitmap_fill(ifs->state, nr_blocks);
-		folio_attach_private(folio, ifs);
-	}
+	/*
+	 * ifs->state tracks two sets of state flags when the
+	 * filesystem block size is smaller than the folio size.
+	 * The first state tracks per-block uptodate and the
+	 * second tracks per-block dirty state.
+	 */
+	ifs = kzalloc(struct_size(ifs, state,
+		      BITS_TO_LONGS(IOMAP_ST_MAX * nr_blocks)), gfp);
+	if (!ifs)
+		return ifs;
+
+	spin_lock_init(&ifs->state_lock);
+	if (folio_test_uptodate(folio))
+		bitmap_set(ifs->state, 0, nr_blocks);
+	if (folio_test_dirty(folio))
+		bitmap_set(ifs->state, nr_blocks, nr_blocks);
+	folio_attach_private(folio, ifs);
+
 	return ifs;
 }
 
@@ -143,7 +226,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!ifs_block_is_uptodate(ifs, i))
+			if (!ifs_block_is_uptodate(folio, ifs, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -153,7 +236,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (ifs_block_is_uptodate(ifs, i)) {
+			if (ifs_block_is_uptodate(folio, ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -457,7 +540,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!ifs_block_is_uptodate(ifs, i))
+		if (!ifs_block_is_uptodate(folio, ifs, i))
 			return false;
 	return true;
 }
@@ -523,6 +606,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
 
+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+	size_t len = folio_size(folio);
+
+	ifs_alloc(inode, folio, 0);
+	iomap_set_range_dirty(folio, 0, len);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -727,6 +821,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -891,6 +986,43 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+static int iomap_write_delalloc_ifs_punch(struct inode *inode,
+		struct folio *folio, loff_t start_byte, loff_t end_byte,
+		iomap_punch_t punch)
+{
+	unsigned int first_blk, last_blk, i;
+	loff_t last_byte;
+	u8 blkbits = inode->i_blkbits;
+	struct iomap_folio_state *ifs;
+	int ret = 0;
+
+	/*
+	 * When we have per-block dirty tracking, there can be
+	 * blocks within a folio which are marked uptodate
+	 * but not dirty. In that case it is necessary to punch
+	 * out such blocks to avoid leaking any delalloc blocks.
+	 */
+	ifs = folio->private;
+	if (!ifs)
+		return ret;
+
+	last_byte = min_t(loff_t, end_byte - 1,
+			folio_pos(folio) + folio_size(folio) - 1);
+	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
+	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
+	for (i = first_blk; i <= last_blk; i++) {
+		if (!ifs_block_is_dirty(folio, ifs, i)) {
+			ret = punch(inode, folio_pos(folio) + (i << blkbits),
+				    1 << blkbits);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+
 static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
 		iomap_punch_t punch)
@@ -907,6 +1039,13 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		if (ret)
 			return ret;
 	}
+
+	/* Punch non-dirty blocks within folio */
+	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte,
+			end_byte, punch);
+	if (ret)
+		return ret;
+
 	/*
 	 * Make sure the next punch start is correctly bound to
 	 * the end of this data range, not the end of the folio.
@@ -1637,7 +1776,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_folio_state *ifs = ifs_alloc(inode, folio, 0);
+	struct iomap_folio_state *ifs = folio->private;
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1645,6 +1784,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
+	if (!ifs && nblocks > 1) {
+		ifs = ifs_alloc(inode, folio, 0);
+		iomap_set_range_dirty(folio, 0, folio_size(folio));
+	}
+
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
 
 	/*
@@ -1653,7 +1797,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (ifs && !ifs_block_is_uptodate(ifs, i))
+		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1697,6 +1841,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}
 
+	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 451942fb38ec..2fca4b4e7fd8 100644
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
index e2b836c2e119..eb9335c46bf3 100644
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
2.40.1

