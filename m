Return-Path: <linux-fsdevel+bounces-71120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FAACB616A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F7A3028FF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F22765F8;
	Thu, 11 Dec 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gAt8YDvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA523BD02;
	Thu, 11 Dec 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461047; cv=none; b=b9hN02MBnJLZe0nnCFWdb6zqE72paz8Jjfp6XyfczUM0pnK+OeqaHyP4gFDsbl9GEL3NG2l9/QZZBkzVpEEMG4O9EPbflxImETcpSMoaBFgnpZFYRg5zr4aiglagvc+8ZBZgBrGmGA08q1aI9MRX0c+qi7Ltj+8v7nFDFLDjzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461047; c=relaxed/simple;
	bh=vA2YJhIrUaqn0dr8oSRAqm7XZzsn3YnknE2/8eQA3po=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZhzWVUzM/UaAF9AhdJZtMQ/AkTz4JpeIlex8HJh3D0lliZXHEGgyW4ckNd9Cwj5aH/dpgvyGaycWXPuPuS2A7G2TvrB+gyI/4Zen7v09gP7lA/13XhBrlERc7UQtrE15DKB+YWgDnKUB8mbmswTJ1IRSTZx67UByTqYLn5ktrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gAt8YDvW; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 49AE61D99;
	Thu, 11 Dec 2025 13:47:13 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=gAt8YDvW;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 585923AC;
	Thu, 11 Dec 2025 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1765461043;
	bh=9Ummg4vQH2Jy52i7ooxKOQj5GmEHtEX2E83JGVuLdew=;
	h=From:To:CC:Subject:Date;
	b=gAt8YDvWS4JcUU4GuMx2gUi+A5haqJLKdFz6sNy/sZL6BMvHytj1NGpt4nzHgmh5Z
	 8RqELuiCmKEYpJBB27+PxdQ7QYAWSgU+kYe1pPUrWTt4Tp2Tpd0vaINmEiF058vX7P
	 ISXKbE3IJkTEbDgc7fvKzcRAiaNN+X0/mmhkE8aw=
Received: from localhost.localdomain (172.30.20.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Dec 2025 16:50:42 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: improve readahead for bitmap initialization and large directory scans
Date: Thu, 11 Dec 2025 14:50:34 +0100
Message-ID: <20251211135034.13925-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Previously sequential reads operations relied solely on single-page reads,
causing the block layer to perform many synchronous I/O requests,
especially for large volumes or large directories. This patch introduces
explicit readahead via page_cache_sync_readahead() and file_ra_state to
reduce I/O latency and improve sequential throughput.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/bitmap.c  | 17 +++++++++++++++++
 fs/ntfs3/dir.c     |  4 ++--
 fs/ntfs3/fslog.c   |  6 ++++--
 fs/ntfs3/fsntfs.c  | 29 +++++++++++++++++++++--------
 fs/ntfs3/index.c   | 13 +++++++------
 fs/ntfs3/ntfs_fs.h | 35 ++++++++++++++++++++++++++++-------
 6 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 65d05e6a0566..db7d0ecfb469 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -508,6 +508,8 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 	size_t wpos, wbit, iw, vbo;
 	struct buffer_head *bh = NULL;
 	CLST lcn, clen;
+	struct file_ra_state *ra;
+	struct address_space *mapping = sb->s_bdev->bd_mapping;
 
 	wnd->uptodated = 0;
 	wnd->extent_max = 0;
@@ -516,6 +518,13 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 
 	vbo = 0;
 
+	/* Allocate in memory instead of stack. Not critical if failed. */
+	ra = kzalloc(sizeof(*ra), GFP_NOFS);
+	if (ra) {
+		file_ra_state_init(ra, mapping);
+		ra->ra_pages = (wnd->nbits / 8 + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	}
+
 	for (iw = 0; iw < wnd->nwnd; iw++) {
 		if (iw + 1 == wnd->nwnd)
 			wbits = wnd->bits_last;
@@ -552,6 +561,13 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 			len = ((u64)clen << cluster_bits) - off;
 		}
 
+		if (ra) {
+			pgoff_t idx = lbo >> PAGE_SHIFT;
+			if (!ra_has_index(ra, idx))
+				page_cache_sync_readahead(mapping, ra, NULL,
+							  idx, 1);
+		}
+
 		bh = ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
 		if (!bh) {
 			err = -EIO;
@@ -638,6 +654,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 	}
 
 out:
+	kfree(ra);
 	return err;
 }
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index b98e95d6b4d9..1dbb661ffe0f 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -487,8 +487,8 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 
-		err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
-				&node);
+		err = indx_read_ra(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
+				   &node, &file->f_ra);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 38934e6978ec..ee24ef0dd725 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1074,6 +1074,8 @@ struct ntfs_log {
 	u32 client_undo_commit;
 
 	struct restart_info rst_info, rst_info2;
+
+	struct file_ra_state read_ahead;
 };
 
 static inline u32 lsn_to_vbo(struct ntfs_log *log, const u64 lsn)
@@ -1164,8 +1166,8 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 
 	page_buf = page_off ? log->one_page_buf : *buffer;
 
-	err = ntfs_read_run_nb(ni->mi.sbi, &ni->file.run, page_vbo, page_buf,
-			       log->page_size, NULL);
+	err = ntfs_read_run_nb_ra(ni->mi.sbi, &ni->file.run, page_vbo, page_buf,
+				  log->page_size, NULL, &log->read_ahead);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index a3cb39ff470f..ff0b2595f32a 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1164,11 +1164,13 @@ struct buffer_head *ntfs_bread_run(struct ntfs_sb_info *sbi,
 	return ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
 }
 
-int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		     u64 vbo, void *buf, u32 bytes, struct ntfs_buffers *nb)
+int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+			u64 vbo, void *buf, u32 bytes, struct ntfs_buffers *nb,
+			struct file_ra_state *ra)
 {
 	int err;
 	struct super_block *sb = sbi->sb;
+	struct address_space *mapping = sb->s_bdev->bd_mapping;
 	u32 blocksize = sb->s_blocksize;
 	u8 cluster_bits = sbi->cluster_bits;
 	u32 off = vbo & sbi->cluster_mask;
@@ -1208,10 +1210,22 @@ int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		nb->bytes = bytes;
 	}
 
+	if (ra && !ra->ra_pages)
+		file_ra_state_init(ra, mapping);
+
 	for (;;) {
 		u32 len32 = len >= bytes ? bytes : len;
 		sector_t block = lbo >> sb->s_blocksize_bits;
 
+		if (ra) {
+			pgoff_t index = lbo >> PAGE_SHIFT;
+			if (!ra_has_index(ra, index)) {
+				page_cache_sync_readahead(mapping, ra, NULL,
+							  index, 1);
+				ra->prev_pos = (loff_t)index << PAGE_SHIFT;
+			}
+		}
+
 		do {
 			u32 op = blocksize - off;
 
@@ -1282,11 +1296,11 @@ int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
  *
  * Return: < 0 if error, 0 if ok, -E_NTFS_FIXUP if need to update fixups.
  */
-int ntfs_read_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
-		 struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
-		 struct ntfs_buffers *nb)
+int ntfs_read_bh_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+		    u64 vbo, struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
+		    struct ntfs_buffers *nb, struct file_ra_state *ra)
 {
-	int err = ntfs_read_run_nb(sbi, run, vbo, rhdr, bytes, nb);
+	int err = ntfs_read_run_nb_ra(sbi, run, vbo, rhdr, bytes, nb, ra);
 
 	if (err)
 		return err;
@@ -1347,8 +1361,7 @@ int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 				wait_on_buffer(bh);
 
 				lock_buffer(bh);
-				if (!buffer_uptodate(bh))
-				{
+				if (!buffer_uptodate(bh)) {
 					memset(bh->b_data, 0, blocksize);
 					set_buffer_uptodate(bh);
 				}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7c7bae84ec9a..f0cfa000ffbb 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1026,17 +1026,18 @@ static int indx_write(struct ntfs_index *indx, struct ntfs_inode *ni,
 }
 
 /*
- * indx_read
+ * indx_read_ra
  *
  * If ntfs_readdir calls this function
  * inode is shared locked and no ni_lock.
  * Use rw_semaphore for read/write access to alloc_run.
  */
-int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
-	      struct indx_node **node)
+int indx_read_ra(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
+		 struct indx_node **node, struct file_ra_state *ra)
 {
 	int err;
 	struct INDEX_BUFFER *ib;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct runs_tree *run = &indx->alloc_run;
 	struct rw_semaphore *lock = &indx->run_lock;
 	u64 vbo = (u64)vbn << indx->vbn2vbo_bits;
@@ -1062,7 +1063,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	}
 
 	down_read(lock);
-	err = ntfs_read_bh(ni->mi.sbi, run, vbo, &ib->rhdr, bytes, &in->nb);
+	err = ntfs_read_bh_ra(sbi, run, vbo, &ib->rhdr, bytes, &in->nb, ra);
 	up_read(lock);
 	if (!err)
 		goto ok;
@@ -1082,7 +1083,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 		goto out;
 
 	down_read(lock);
-	err = ntfs_read_bh(ni->mi.sbi, run, vbo, &ib->rhdr, bytes, &in->nb);
+	err = ntfs_read_bh_ra(sbi, run, vbo, &ib->rhdr, bytes, &in->nb, ra);
 	up_read(lock);
 	if (err == -E_NTFS_FIXUP)
 		goto ok;
@@ -1098,7 +1099,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	}
 
 	if (err == -E_NTFS_FIXUP) {
-		ntfs_write_bh(ni->mi.sbi, &ib->rhdr, &in->nb, 0);
+		ntfs_write_bh(sbi, &ib->rhdr, &in->nb, 0);
 		err = 0;
 	}
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7b619bb151ce..18b14f7db4ad 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -625,11 +625,27 @@ int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		      u64 vbo, const void *buf, size_t bytes, int sync);
 struct buffer_head *ntfs_bread_run(struct ntfs_sb_info *sbi,
 				   const struct runs_tree *run, u64 vbo);
-int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		     u64 vbo, void *buf, u32 bytes, struct ntfs_buffers *nb);
-int ntfs_read_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
-		 struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
-		 struct ntfs_buffers *nb);
+int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+			u64 vbo, void *buf, u32 bytes, struct ntfs_buffers *nb,
+			struct file_ra_state *ra);
+static inline int ntfs_read_run_nb(struct ntfs_sb_info *sbi,
+				   const struct runs_tree *run, u64 vbo,
+				   void *buf, u32 bytes,
+				   struct ntfs_buffers *nb)
+{
+	return ntfs_read_run_nb_ra(sbi, run, vbo, buf, bytes, nb, NULL);
+}
+int ntfs_read_bh_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+		    u64 vbo, struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
+		    struct ntfs_buffers *nb, struct file_ra_state *ra);
+static inline int ntfs_read_bh(struct ntfs_sb_info *sbi,
+			       const struct runs_tree *run, u64 vbo,
+			       struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
+			       struct ntfs_buffers *nb)
+{
+	return ntfs_read_bh_ra(sbi, run, vbo, rhdr, bytes, nb, NULL);
+}
+
 int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 		u32 bytes, struct ntfs_buffers *nb);
 int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
@@ -695,8 +711,13 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	      const struct ATTRIB *attr, enum index_mutex_classed type);
 struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 				 struct ATTRIB **attr, struct mft_inode **mi);
-int indx_read(struct ntfs_index *idx, struct ntfs_inode *ni, CLST vbn,
-	      struct indx_node **node);
+int indx_read_ra(struct ntfs_index *idx, struct ntfs_inode *ni, CLST vbn,
+		 struct indx_node **node, struct file_ra_state *ra);
+static inline int indx_read(struct ntfs_index *idx, struct ntfs_inode *ni,
+			    CLST vbn, struct indx_node **node)
+{
+	return indx_read_ra(idx, ni, vbn, node, NULL);
+}
 int indx_find(struct ntfs_index *indx, struct ntfs_inode *dir,
 	      const struct INDEX_ROOT *root, const void *Key, size_t KeyLen,
 	      const void *param, int *diff, struct NTFS_DE **entry,
-- 
2.43.0


