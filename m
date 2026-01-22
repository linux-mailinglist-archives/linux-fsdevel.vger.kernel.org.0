Return-Path: <linux-fsdevel+bounces-74992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZcIRDgcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:30:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 007256314A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A91F4FBAF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349243DA7CB;
	Thu, 22 Jan 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LMrKvFBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9D2BE04F;
	Thu, 22 Jan 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070198; cv=none; b=Mj6SflivaYLlYP7lTh0CJaVjqXNslHnfgbD4Re1PKTfiuunmftG9G58tWDW/XAvc5sp/JEIFHANAvzEnaFisxpOcbgF31u3Am8m/ozPr3nQ9EzsOwdBeD4Ogw4oF3ZyN+vuJDQJ8yoAqUqg1wQee9H9AhhV875tJoo63cNWAO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070198; c=relaxed/simple;
	bh=mJWRYMIANKHHZMwnrR1pR/C+AECdwpXaEH/XT6NC/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu5jpg49ZYFWZKWvCV/WVFBhizZU2LqK4mHp3cYByWJ1cl8tAf2WWb+PKsxgMqgPaTIog3nN0XBxNWNLuwduHCjMIzgYl8B6gP9vSNc/OYUgTxxwFIWFA3X8YKBGD+ED41FZVqDi8Z+eyBQNOULrDmY0w0LPP1oFkXilsI4VD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LMrKvFBW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/Hg9nOjKoAiA3eKUOy+W9eTBLJ6ktXLqchPca8hDNeU=; b=LMrKvFBW3MbQHLvKA9HOnzyR+k
	HCcLUfBQMBopJANLAtG91wPkZs6+zXge9XxmnS3rdC4uVvl9bmqxmym8lVodziGRWClFcWLfisAs1
	BUQXLiyVeiiAIu3qYp24WrvF6qdnYOp+6zIYeQz5CEWiaPlubmxeH/ZZRy74aEm2tYZQRdCDAmFPa
	Nm/+4m0/sxv8KlDbx03Ncy/g2QdFVkDGN8zaksoLB6SZEDkV7FUqNGyFsiDrD5OToNoO3GhaYGVgq
	S8d6Xhl40IB/oKn1cwGjbIo+p/0nlBi9BRP0mI/DLO1xRvnE6xG4+AEmgpA+gKSJZjkGHShmx1zF9
	5E8lvOFw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipyE-00000006dw1-2KOd;
	Thu, 22 Jan 2026 08:23:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 09/11] f2fs: consolidate fsverity_info lookup
Date: Thu, 22 Jan 2026 09:22:05 +0100
Message-ID: <20260122082214.452153-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122082214.452153-1-hch@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74992-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cc.vi:url,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 007256314A
X-Rspamd-Action: no action

Look up the fsverity_info once in f2fs_mpage_readpages, and then use it
for the readahead, local verification of holes and pass it along to the
I/O completion workqueue in struct bio_post_read_ctx.  Do the same
thing in f2fs_get_read_data_folio for reads that come from garbage
collection and other background activities.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/compress.c |  9 +++---
 fs/f2fs/data.c     | 73 +++++++++++++++++++++++++---------------------
 fs/f2fs/f2fs.h     |  9 ++----
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 0c269b875e0c..285f5b4bb2fc 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1181,6 +1181,7 @@ int f2fs_prepare_compress_overwrite(struct inode *inode,
 		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
 		.rpages = NULL,
 		.nr_rpages = 0,
+		.vi = NULL, /* can't write to fsverity files */
 	};
 
 	return prepare_compress_overwrite(&cc, pagep, index, fsdata);
@@ -1716,7 +1717,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->nr_cpages = cc->nr_cpages;
 	refcount_set(&dic->refcnt, 1);
 	dic->failed = false;
-	dic->need_verity = f2fs_need_verity(cc->inode, start_idx);
+	dic->vi = cc->vi;
 
 	for (i = 0; i < dic->cluster_size; i++)
 		dic->rpages[i] = cc->rpages[i];
@@ -1814,9 +1815,7 @@ static void f2fs_verify_cluster(struct work_struct *work)
 		if (!rpage)
 			continue;
 
-		if (fsverity_verify_page(
-				*fsverity_info_addr(rpage->mapping->host),
-				rpage))
+		if (fsverity_verify_page(dic->vi, rpage))
 			SetPageUptodate(rpage);
 		else
 			ClearPageUptodate(rpage);
@@ -1835,7 +1834,7 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 {
 	int i;
 
-	if (!failed && dic->need_verity) {
+	if (!failed && dic->vi) {
 		/*
 		 * Note that to avoid deadlocks, the verity work can't be done
 		 * on the decompression workqueue.  This is because verifying
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bca1e34d327a..2e0900d0673a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -109,6 +109,7 @@ enum bio_post_read_step {
 struct bio_post_read_ctx {
 	struct bio *bio;
 	struct f2fs_sb_info *sbi;
+	struct fsverity_info *vi;
 	struct work_struct work;
 	unsigned int enabled_steps;
 	/*
@@ -165,6 +166,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 		container_of(work, struct bio_post_read_ctx, work);
 	struct bio *bio = ctx->bio;
 	bool may_have_compressed_pages = (ctx->enabled_steps & STEP_DECOMPRESS);
+	struct fsverity_info *vi = ctx->vi;
 
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and while verity
@@ -185,8 +187,6 @@ static void f2fs_verify_bio(struct work_struct *work)
 
 		bio_for_each_folio_all(fi, bio) {
 			struct folio *folio = fi.folio;
-			struct fsverity_info *vi =
-				*fsverity_info_addr(folio->mapping->host);
 
 			if (!f2fs_is_compressed_page(folio) &&
 			    !fsverity_verify_page(vi, &folio->page)) {
@@ -195,9 +195,8 @@ static void f2fs_verify_bio(struct work_struct *work)
 			}
 		}
 	} else {
-		struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 
-		fsverity_verify_bio(*fsverity_info_addr(inode), bio);
+		fsverity_verify_bio(vi, bio);
 	}
 
 	f2fs_finish_read_bio(bio, true);
@@ -1040,9 +1039,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_up_write(&io->io_rwsem);
 }
 
-static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-				      unsigned nr_pages, blk_opf_t op_flag,
-				      pgoff_t first_idx, bool for_write)
+static struct bio *f2fs_grab_read_bio(struct inode *inode,
+		struct fsverity_info *vi, block_t blkaddr, unsigned nr_pages,
+		blk_opf_t op_flag, pgoff_t first_idx, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1061,7 +1060,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= STEP_DECRYPT;
 
-	if (f2fs_need_verity(inode, first_idx))
+	if (vi)
 		post_read_steps |= STEP_VERITY;
 
 	/*
@@ -1076,6 +1075,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 		ctx->bio = bio;
 		ctx->sbi = sbi;
+		ctx->vi = vi;
 		ctx->enabled_steps = post_read_steps;
 		ctx->fs_blkaddr = blkaddr;
 		ctx->decompression_attempted = false;
@@ -1087,15 +1087,15 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 }
 
 /* This can handle encryption stuffs */
-static void f2fs_submit_page_read(struct inode *inode, struct folio *folio,
-				 block_t blkaddr, blk_opf_t op_flags,
-				 bool for_write)
+static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
+		struct folio *folio, block_t blkaddr, blk_opf_t op_flags,
+		bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
 
-	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
-					folio->index, for_write);
+	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, folio->index,
+			for_write);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
@@ -1197,6 +1197,14 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
+static inline struct fsverity_info *f2fs_need_verity(const struct inode *inode,
+		pgoff_t idx)
+{
+	if (idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+		return fsverity_get_info(inode);
+	return NULL;
+}
+
 struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs)
 {
@@ -1262,8 +1270,8 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		return folio;
 	}
 
-	f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
-						op_flags, for_write);
+	f2fs_submit_page_read(inode, f2fs_need_verity(inode, folio->index),
+			folio, dn.data_blkaddr, op_flags, for_write);
 	return folio;
 
 put_err:
@@ -2067,12 +2075,10 @@ static inline blk_opf_t f2fs_ra_op_flags(struct readahead_control *rac)
 	return rac ? REQ_RAHEAD : 0;
 }
 
-static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
-					unsigned nr_pages,
-					struct f2fs_map_blocks *map,
-					struct bio **bio_ret,
-					sector_t *last_block_in_bio,
-					struct readahead_control *rac)
+static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
+		struct folio *folio, unsigned nr_pages,
+		struct f2fs_map_blocks *map, struct bio **bio_ret,
+		sector_t *last_block_in_bio, struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
 	const unsigned int blocksize = F2FS_BLKSIZE;
@@ -2124,10 +2130,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 	} else {
 zero_out:
 		folio_zero_segment(folio, 0, folio_size(folio));
-		if (f2fs_need_verity(inode, index) &&
-		    !fsverity_verify_folio(
-				*fsverity_info_addr(folio->mapping->host),
-				folio)) {
+		if (vi && !fsverity_verify_folio(vi, folio)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -2149,7 +2152,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 		bio = NULL;
 	}
 	if (bio == NULL)
-		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
+		bio = f2fs_grab_read_bio(inode, vi, block_nr, nr_pages,
 				f2fs_ra_op_flags(rac), index,
 				false);
 
@@ -2301,8 +2304,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		}
 
 		if (!bio)
-			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages - i,
-					f2fs_ra_op_flags(rac),
+			bio = f2fs_grab_read_bio(inode, cc->vi, blkaddr,
+					nr_pages - i, f2fs_ra_op_flags(rac),
 					folio->index, for_write);
 
 		if (!bio_add_folio(bio, folio, blocksize, 0))
@@ -2364,6 +2367,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
+	struct fsverity_info *vi = NULL;
 	int ret = 0;
 	bool first_folio = true;
 
@@ -2391,9 +2395,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		}
 
 		if (first_folio) {
-			if (f2fs_need_verity(inode, folio->index))
-				fsverity_readahead(*fsverity_info_addr(inode),
-						folio, nr_pages);
+			vi = f2fs_need_verity(inode, folio->index);
+			if (vi)
+				fsverity_readahead(vi, folio, nr_pages);
 			first_folio = false;
 		}
 
@@ -2405,6 +2409,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 		/* there are remained compressed pages, submit them */
 		if (!f2fs_cluster_can_merge_page(&cc, index)) {
+			cc.vi = vi;
 			ret = f2fs_read_multi_pages(&cc, &bio,
 						max_nr_pages,
 						&last_block_in_bio,
@@ -2438,8 +2443,8 @@ static int f2fs_mpage_readpages(struct inode *inode,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
-					&bio, &last_block_in_bio, rac);
+		ret = f2fs_read_single_page(inode, vi, folio, max_nr_pages,
+					&map, &bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
@@ -2455,6 +2460,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		if (f2fs_compressed_file(inode)) {
 			/* last page */
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
+				cc.vi = vi;
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
@@ -3653,6 +3659,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		}
 		f2fs_submit_page_read(use_cow ?
 				F2FS_I(inode)->cow_inode : inode,
+				NULL, /* can't write to fsverity files */
 				folio, blkaddr, 0, true);
 
 		folio_lock(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20edbb99b814..f2fcadc7a6fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1603,6 +1603,7 @@ struct compress_ctx {
 	size_t clen;			/* valid data length in cbuf */
 	void *private;			/* payload buffer for specified compression algorithm */
 	void *private2;			/* extra payload buffer */
+	struct fsverity_info *vi;	/* verity info if needed */
 };
 
 /* compress context for write IO path */
@@ -1658,7 +1659,7 @@ struct decompress_io_ctx {
 	refcount_t refcnt;
 
 	bool failed;			/* IO error occurred before decompression? */
-	bool need_verity;		/* need fs-verity verification after decompression? */
+	struct fsverity_info *vi;	/* fs-verity context if needed */
 	unsigned char compress_algorithm;	/* backup algorithm type */
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
@@ -4886,12 +4887,6 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 	return sbi->aligned_blksize;
 }
 
-static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
-{
-	return fsverity_active(inode) &&
-	       idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-}
-
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 					unsigned long type, enum fault_option fo);
-- 
2.47.3


