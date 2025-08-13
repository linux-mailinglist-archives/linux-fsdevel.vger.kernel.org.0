Return-Path: <linux-fsdevel+bounces-57669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74965B245A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F83881223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1B2F533F;
	Wed, 13 Aug 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZVu5tv16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E12F531D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077923; cv=none; b=c6DsvMO+KL3/ExVfNM5vCzGG//LlC+3Tf+OpbBFrPQqfo/InDMA2X8yDAhw85il7R1X4Mw9HPsE8GesedpzuhNnVb48DLxHm+9+OKRozSg72lX0u5wXXXIWmmGrGZpMimVrzS9tcW25fpGtCU8ymmS+PhdXssgvyUhEi8JxHXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077923; c=relaxed/simple;
	bh=QjB2xE0rGsMZrUAJQP9lWS3F7+2iGF6K/AipVbh+NCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRpupkvaSY4tSWxGm3P+Elnz5VLWmvLi2KjHkhOTWh9j3jFavk7MPBrW2ETkw1hmUpiKC9ImgzmY7IMwb2QrFHwBKMyZGe2MyvzVxFyj/zPXGYoNG6V8/spV/h6RvHzbu1Nn1WUQfdNcWm07GU0kPzhk8/sKecSmebPQ9D49nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZVu5tv16; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JX
	rrH1GuF3TyhMQNJeF8+XDV9FdDsRz5WCLevGpnP98=; b=ZVu5tv16Ie/VC6G5No
	GYpcdIIGziffWZpTa9IAi4MV0cJF+82KxanQMwWHGtsx+si5d97bnaLUfOuSHcJw
	WGDGpMvMCFOwduYbSos5FQaaQUVJff3StuZIk7+bgW2V6fXzqFThT77OxRsnLqiJ
	RVqAMgIjL7YzlbTYIv0EDlgVQ=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn_9odWZxo91unBg--.63865S9;
	Wed, 13 Aug 2025 17:21:50 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 7/9] f2fs:Make GC aware of large folios
Date: Wed, 13 Aug 2025 17:21:29 +0800
Message-Id: <20250813092131.44762-8-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813092131.44762-1-nzzhao@126.com>
References: <20250813092131.44762-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_9odWZxo91unBg--.63865S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4DXFW7WryDXw45JrW5Jrb_yoWrJw18pF
	W5GF9xGrs5JF17urn2yFn8Zr1rta4Ivr4UAFWxCw4xXa1UXwn5K3W0y3WfZF1DtrykArWI
	qF1rtry5WF4UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRkOzfUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEwWoz2icVjsqaAAAsq

Previously, the GC (Garbage Collection) logic for performing I/O and
marking folios dirty only supported order-0 folios and lacked awareness
of higher-order folios. To enable GC to correctly handle higher-order
folios, we made two changes:

- In `move_data_page`, we now use `f2fs_iomap_set_range_dirty` to mark
  only the sub-part of the folio corresponding to `bidx` as dirty,
  instead of the entire folio.

- The `f2fs_submit_page_read` function has been augmented with an
  `index` parameter, allowing it to precisely identify which sub-page
  of the current folio is being submitted.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 13 +++++++------
 fs/f2fs/gc.c   | 37 +++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b7bef2a28c8e..5ecd08a3dd0b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1096,7 +1096,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 /* This can handle encryption stuffs */
 static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 				 block_t blkaddr, blk_opf_t op_flags,
-				 bool for_write)
+				 pgoff_t index, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1109,7 +1109,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
-	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0)) {
+	if (!bio_add_folio(bio, folio, PAGE_SIZE,
+			   (index - folio->index) << PAGE_SHIFT)) {
 		iostat_update_and_unbind_ctx(bio);
 		if (bio->bi_private)
 			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
@@ -1276,8 +1277,8 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		return folio;
 	}
 
-	err = f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
-						op_flags, for_write);
+	err = f2fs_submit_page_read(inode, folio, dn.data_blkaddr, op_flags,
+				    index, for_write);
 	if (err)
 		goto put_err;
 	return folio;
@@ -3651,8 +3652,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 			goto put_folio;
 		}
 		err = f2fs_submit_page_read(use_cow ?
-				F2FS_I(inode)->cow_inode : inode,
-				folio, blkaddr, 0, true);
+			F2FS_I(inode)->cow_inode : inode, folio,
+			blkaddr, 0, folio->index, true);
 		if (err)
 			goto put_folio;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 098e9f71421e..6d28f01bec42 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1475,22 +1475,31 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			err = -EAGAIN;
 			goto out;
 		}
-		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
+#ifdef CONFIG_F2FS_IOMAP_FOLIO_STATE
+		if (!folio_test_large(folio)) {
+			folio_mark_dirty(folio);
+		} else {
+			f2fs_iomap_set_range_dirty(folio, (bidx - folio->index) << PAGE_SHIFT,
+				PAGE_SIZE);
+		}
+#else
+		folio_mark_dirty(folio);
+#endif
 	} else {
-		struct f2fs_io_info fio = {
-			.sbi = F2FS_I_SB(inode),
-			.ino = inode->i_ino,
-			.type = DATA,
-			.temp = COLD,
-			.op = REQ_OP_WRITE,
-			.op_flags = REQ_SYNC,
-			.old_blkaddr = NULL_ADDR,
-			.folio = folio,
-			.encrypted_page = NULL,
-			.need_lock = LOCK_REQ,
-			.io_type = FS_GC_DATA_IO,
-		};
+		struct f2fs_io_info fio = { .sbi = F2FS_I_SB(inode),
+					    .ino = inode->i_ino,
+					    .type = DATA,
+					    .temp = COLD,
+					    .op = REQ_OP_WRITE,
+					    .op_flags = REQ_SYNC,
+					    .old_blkaddr = NULL_ADDR,
+					    .folio = folio,
+					    .encrypted_page = NULL,
+					    .need_lock = LOCK_REQ,
+					    .io_type = FS_GC_DATA_IO,
+					    .idx = bidx - folio->index,
+					    .cnt = 1 };
 		bool is_dirty = folio_test_dirty(folio);
 
 retry:
-- 
2.34.1


