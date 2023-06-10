Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3315472AB37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjFJLjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjFJLjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ECE1;
        Sat, 10 Jun 2023 04:39:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b24b34b59fso16456825ad.3;
        Sat, 10 Jun 2023 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397179; x=1688989179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ7Q4R5U7AY6PpcGfOaRes0larMmuTaPyvKsUXfEUVY=;
        b=sp9xDMlRGxg2169BgRUkHr3pdFfCATWmLmAYHToSg5hSWNgw+WBYVsd2mG20p6jM2B
         tZPJfql8IwZoNwFKqipf4269EaEZuExqgcgpLge1fIxOrQ43xgDydXC8wdmuAS+QjmGn
         4EKnB8Iiv9dKulnSrBa4yXzdwhwfZMi6tEB7j54tShnBWzXKcLZrwJbHaecWfCyNbg9M
         4fU6RXEzxXntUtIqJFH5hyoNw5m1lsnVi8/DBLr/Cb+vf5KPkweDvdsBbKeSfYjIPeMM
         3zUcaA7CsFlOz7u9OI2d5qCku0kBF8Bzm+dGQsVzgRK2BxoNU4RaeidM48+PX6vTILX4
         6o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397179; x=1688989179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ7Q4R5U7AY6PpcGfOaRes0larMmuTaPyvKsUXfEUVY=;
        b=JJ58+aQzSCcvrgzefEcwb9INVuCSp8wntaail9Ln1pClqH7sikeOISTYDtZgS623SX
         6ze7UWhBOI95GVDyqtDX4Mw6rX0MXX86sC6ubuOjt0nXAEMj9XvDCZOTBVbCCv04kZfb
         jta5fRTZGfiP/hRV2U7IgO9QFN9bfRtDzu6j5z4sX+lkaFaZMC0OKp0/LfwbFxtsGQ1E
         +cLB420CvUjNds1R5VwdqUwHw/Occu+3Aep+0JMEB7KSfJsiHukIMV7eNKoI0cjdtNIx
         78+C8SWxCVY2v00OiR9upGs3dNwX0dnQ7uColLoxr3YTL0GzIE283Ks6NSWCkn70gWZB
         AX3A==
X-Gm-Message-State: AC+VfDwB1Bv8SseT5gFLUk4LXGAnF9Q0oWdLut1IL3q+yfOA8UoTb4C2
        VF34TD5ZQY5S3SyyqVoKqMUfXQarYOE=
X-Google-Smtp-Source: ACHHUZ50yi6clq+ANzvNvGUIwcfvj6EPxcOZy+mSzeHN/p0/RgCMy7U2UZADu4bH4it8f/MFoUfKJQ==
X-Received: by 2002:a17:902:d4cb:b0:1b1:9f8a:6c18 with SMTP id o11-20020a170902d4cb00b001b19f8a6c18mr1789355plg.25.1686397179326;
        Sat, 10 Jun 2023 04:39:39 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:39 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [PATCHv9 6/6] iomap: Add per-block dirty state tracking to improve performance
Date:   Sat, 10 Jun 2023 17:09:07 +0530
Message-Id: <954d2e61dedbada996653c9d780be70a48dc66ae.1686395560.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686395560.git.ritesh.list@gmail.com>
References: <cover.1686395560.git.ritesh.list@gmail.com>
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
state within struct iomap_folio_state. We currently only track uptodate state.

This patch implements support for tracking per-block dirty state in
iomap_folio_state->state bitmap. This should help improve the filesystem write
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
 fs/iomap/buffered-io.c | 158 +++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 147 insertions(+), 18 deletions(-)

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
index c6dcb0f0d22f..d5b8d134921c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -24,7 +24,7 @@
 #define IOEND_BATCH_SIZE	4096

 /*
- * Structure allocated for each folio to track per-block uptodate state
+ * Structure allocated for each folio to track per-block uptodate, dirty state
  * and I/O completions.
  */
 struct iomap_folio_state {
@@ -34,6 +34,26 @@ struct iomap_folio_state {
 	unsigned long		state[];
 };

+enum iomap_block_state {
+	IOMAP_ST_UPTODATE,
+	IOMAP_ST_DIRTY,
+
+	IOMAP_ST_MAX,
+};
+
+static void iomap_ifs_calc_range(struct folio *folio, size_t off, size_t len,
+		enum iomap_block_state state, unsigned int *first_blkp,
+		unsigned int *nr_blksp)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+
+	*first_blkp = first_blk + (state * blks_per_folio);
+	*nr_blksp = last_blk - first_blk + 1;
+}
+
 static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
 {
 	if (folio_test_private(folio))
@@ -60,12 +80,11 @@ static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
 static void iomap_ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
-	struct inode *inode = folio->mapping->host;
-	unsigned int first_blk = off >> inode->i_blkbits;
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, nr_blks;
 	unsigned long flags;

+	iomap_ifs_calc_range(folio, off, len, IOMAP_ST_UPTODATE, &first_blk,
+			     &nr_blks);
 	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
 	if (iomap_ifs_is_fully_uptodate(folio, ifs))
@@ -84,6 +103,59 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }

+static inline bool iomap_ifs_is_block_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, int block)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	return test_bit(block + blks_per_folio, ifs->state);
+}
+
+static void iomap_ifs_clear_range_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	unsigned int first_blk, nr_blks;
+	unsigned long flags;
+
+	iomap_ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk,
+			     &nr_blks);
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_clear(ifs->state, first_blk, nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
+
+	if (!ifs)
+		return;
+	iomap_ifs_clear_range_dirty(folio, ifs, off, len);
+}
+
+static void iomap_ifs_set_range_dirty(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	unsigned int first_blk, nr_blks;
+	unsigned long flags;
+
+	iomap_ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk,
+			     &nr_blks);
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk, nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
+
+	if (!ifs)
+		return;
+	iomap_ifs_set_range_dirty(folio, ifs, off, len);
+}
+
 static struct iomap_folio_state *iomap_ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -99,14 +171,24 @@ static struct iomap_folio_state *iomap_ifs_alloc(struct inode *inode,
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

@@ -529,6 +611,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);

+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+	size_t len = folio_size(folio);
+
+	iomap_ifs_alloc(inode, folio, 0);
+	iomap_set_range_dirty(folio, 0, len);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -733,6 +826,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -902,6 +996,10 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
 {
 	int ret = 0;
+	struct iomap_folio_state *ifs;
+	unsigned int first_blk, last_blk, i;
+	loff_t last_byte;
+	u8 blkbits = inode->i_blkbits;

 	if (!folio_test_dirty(folio))
 		return ret;
@@ -913,6 +1011,30 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		if (ret)
 			goto out;
 	}
+	/*
+	 * When we have per-block dirty tracking, there can be
+	 * blocks within a folio which are marked uptodate
+	 * but not dirty. In that case it is necessary to punch
+	 * out such blocks to avoid leaking any delalloc blocks.
+	 */
+	ifs = iomap_get_ifs(folio);
+	if (!ifs)
+		goto skip_ifs_punch;
+
+	last_byte = min_t(loff_t, end_byte - 1,
+		(folio_next_index(folio) << PAGE_SHIFT) - 1);
+	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
+	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
+	for (i = first_blk; i <= last_blk; i++) {
+		if (!iomap_ifs_is_block_dirty(folio, ifs, i)) {
+			ret = punch(inode, folio_pos(folio) + (i << blkbits),
+				    1 << blkbits);
+			if (ret)
+				goto out;
+		}
+	}
+
+skip_ifs_punch:
 	/*
 	 * Make sure the next punch start is correctly bound to
 	 * the end of this data range, not the end of the folio.
@@ -1646,7 +1768,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_folio_state *ifs = iomap_ifs_alloc(inode, folio, 0);
+	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1654,6 +1776,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);

+	if (!ifs && nblocks > 1) {
+		ifs = iomap_ifs_alloc(inode, folio, 0);
+		iomap_set_range_dirty(folio, 0, folio_size(folio));
+	}
+
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);

 	/*
@@ -1662,7 +1789,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (ifs && !iomap_ifs_is_block_uptodate(ifs, i))
+		if (ifs && !iomap_ifs_is_block_dirty(folio, ifs, i))
 			continue;

 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1706,6 +1833,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}

+	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
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

