Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C66A33C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBZTn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:43:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281BD10A83;
        Sun, 26 Feb 2023 11:43:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ky4so4686144plb.3;
        Sun, 26 Feb 2023 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g965yn2X/Ge7g9i6QZav4CzsfI6wYWWjgzhXMmh1lL8=;
        b=jm8UTW1Zqa28JYwC1eZejncPPctz+3tkVUpqnTdeNlq8qaNMYH60zWK5ZCILt6V0Z/
         uMtl8j/EyWiNbHRkfqKPXmRF+baYCR9kd9gG/6l/ur+BF5A1LmJi6/BXvy0J136mm930
         mhYB13AufrxjapIAm5w+F9EyxtPVWwM8nK+vHVoXH7FjkjGQf5J9K5PlkVuG8PEaGHDb
         CYx87zkKzPdei4h/jHMgAjHklkXIcdwmpabhMZIvlBmp4T7owhNLLuz3ZoYqYtZb/PkL
         CHrFcBkJ4RFaSe0cOgiPBW/IotL16G0GTH0Fz9jNUrALgAYVqQzXLhFsc/Hv4sfZi2Ul
         YmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g965yn2X/Ge7g9i6QZav4CzsfI6wYWWjgzhXMmh1lL8=;
        b=JDgziDEJFjOo6CETPq2Ffh6CpONLdtHOxXWifJS7DasTrTNJMclWNV+Mm4CmIzWW8i
         4GRdynmFVvB1szKx2Ys/vWF/KGmK/8PyGyY6k+EhNsPtGyprNDaNyjZSk59+IYvoGkwV
         CPrTAtBiBU6sTbRJ1GN/rDotlIYmxzx5pUUsP67Z0aoDXJtOoLqi4xdhktBAFBaI8yw2
         jY30/K0WRGeUoCqQ7Yr/DNqvcuwxh2XxeUdLr9dQEnC1aIgnF20SFknNur6+2XsPahTi
         PglMp1oTspv9/SxzEsasPK6oTarpjdRm5VvToqyGOKRUbIJ3BOghCh0zev4NgB++c/oU
         /Yeg==
X-Gm-Message-State: AO0yUKXM1WjbqhC2UhvFhGQTB695Leam2+6IYamwW3BO9AF76DVWB2/n
        bxUPe45xZatFDdf8yjB6InawjoNJCrA=
X-Google-Smtp-Source: AK7set+AMypJWoyb2jHOpSwFSiVGfYWbLiBYssOaURXBBhmTjHYYo5XmamnYAWmKLyHpPLww9S1y9g==
X-Received: by 2002:a05:6a20:841d:b0:cd:5334:e240 with SMTP id c29-20020a056a20841d00b000cd5334e240mr1150147pzd.5.1677440632276;
        Sun, 26 Feb 2023 11:43:52 -0800 (PST)
Received: from rh-tp.. ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b00582f222f088sm2815606pfh.47.2023.02.26.11.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:43:51 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [RFCv3 3/3] iomap: Support subpage size dirty tracking to improve write performance
Date:   Mon, 27 Feb 2023 01:13:32 +0530
Message-Id: <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677428794.git.ritesh.list@gmail.com>
References: <cover.1677428794.git.ritesh.list@gmail.com>
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

2. Also our internal performance team reported that this patch improves there
   database workload performance by around ~83% (with XFS on Power)

Reported-by: Aravinda Herle <araherle@in.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 104 +++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/super.c      |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 99 insertions(+), 12 deletions(-)

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
index e0b0be16278e..fb55183c547f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -44,8 +44,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 static struct bio_set iomap_ioend_bioset;

 /*
- * Accessor functions for setting/clearing/checking uptodate bits in
- * iop->state bitmap.
+ * Accessor functions for setting/clearing/checking uptodate and
+ * dirty bits in iop->state bitmap.
  * nrblocks is i_blocks_per_folio() which is passed in every
  * function as the last argument for API consistency.
  */
@@ -75,8 +75,29 @@ static inline bool iop_full_uptodate(struct iomap_page *iop,
 	return bitmap_full(iop->state, nrblocks);
 }

+static inline void iop_set_range_dirty(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_set(iop->state, start + nrblocks, len);
+}
+
+static inline void iop_clear_range_dirty(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_clear(iop->state, start + nrblocks, len);
+}
+
+static inline bool iop_test_dirty(struct iomap_page *iop, unsigned int pos,
+			     unsigned int nrblocks)
+{
+	return test_bit(pos + nrblocks, iop->state);
+}
+
 static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
+		  bool is_dirty)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -90,12 +111,18 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;

-	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
+	/*
+	 * iop->state tracks 2 types of bitmaps i.e. uptodate & dirty
+	 * for bs < ps.
+	 */
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
 		      gfp);
 	if (iop) {
 		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
 			iop_set_range_uptodate(iop, 0, nr_blocks, nr_blocks);
+		if (is_dirty)
+			iop_set_range_dirty(iop, 0, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -202,6 +229,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
 		folio_mark_uptodate(folio);
 }

+static void iomap_iop_set_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+	unsigned first = (off >> inode->i_blkbits);
+	unsigned last = ((off + len - 1) >> inode->i_blkbits);
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_set_range_dirty(iop, first, last - first + 1, nr_blocks);
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
+	unsigned first = (off >> inode->i_blkbits);
+	unsigned last = ((off + len - 1) >> inode->i_blkbits);
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_clear_range_dirty(iop, first, last - first + 1, nr_blocks);
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
@@ -265,7 +334,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iomap_page_create(iter->inode, folio, iter->flags,
+					folio_test_dirty(folio));
 	else
 		iop = to_iomap_page(folio);

@@ -303,7 +373,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);

 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_page_create(iter->inode, folio, iter->flags,
+				folio_test_dirty(folio));
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -532,6 +603,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);

+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	unsigned int nr_blocks = i_blocks_per_folio(mapping->host, folio);
+	struct iomap_page *iop;
+
+	iop = iomap_page_create(mapping->host, folio, 0, false);
+	iomap_set_range_dirty(folio, iop, 0,
+			      nr_blocks << mapping->host->i_blkbits);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -574,7 +657,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;

-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_page_create(iter->inode, folio, iter->flags,
+				folio_test_dirty(folio));

 	if (folio_test_uptodate(folio))
 		return 0;
@@ -726,6 +810,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1630,7 +1715,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iomap_page_create(inode, folio, 0, true);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1646,7 +1731,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !iop_test_uptodate(iop, i, nblocks))
+		if (iop && !iop_test_dirty(iop, i, nblocks))
 			continue;

 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1690,6 +1775,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}

+	iomap_clear_range_dirty(folio, iop, 0, end_pos - folio_pos(folio));
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
2.39.2

