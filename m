Return-Path: <linux-fsdevel+bounces-57680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB8B246C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F0A179C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4152F3C37;
	Wed, 13 Aug 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OzZ+o2R1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D6284B25
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079723; cv=none; b=jFv1n6tE2fEeZBNPM6deIoHsq9ITMFGTG3yUwuyaUbsnb15ABAba++EkAOmomIhOhOm/G3p3/wV+3S9Vmj1OR7QgGRIJAzX62CmFjD/iiMAy1tOa8e8O0YJXPB5tuGznolNV1qPW/gDOHiOZs9WvXxpEAF4UwOYwtAfdQz1xBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079723; c=relaxed/simple;
	bh=DbM2LA16EEWmeoyVhZTg1pb3KtLn2OJiWcyktt4aGgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cec13stkIKzU+5y+Ri/Ug6Dqukh/jWLildDMAxeaFRXKz4hqOIG8O6Crc5EFamCrmQ+xqwTbCL8T+INXCN/s4gvynVrnrvOS991TzaMkD5fewEBds3rNw6fp61gvikREYClJ1U3bfemx/lSSV7tqwvoXBgpgWrXGBJ4wBlbAlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OzZ+o2R1; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/c
	h+z7GSB5KCZPQlJoVXou/MWaJL2wpBA5pjQ8l8kXg=; b=OzZ+o2R12EgNgs2U2E
	LtBP7kmLL6lgQA8TtwHiJjqaSobfC1lXW7c3R/zdQZZQ59mGOHNgPGU8PVWoBboD
	xre+SqNjjsgeTqOQBFM4UoEaORWBt3J94AyuURfm7ggT7875mkIfvVO/NfCQXZwI
	gCOuJhDHXDBbIAZjfaScZO8wU=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn_9odWZxo91unBg--.63865S7;
	Wed, 13 Aug 2025 17:21:46 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 5/9] f2fs:Refactor `f2fs_is_compressed_page` to `f2fs_is_compressed_folio`
Date: Wed, 13 Aug 2025 17:21:27 +0800
Message-Id: <20250813092131.44762-6-nzzhao@126.com>
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
X-CM-TRANSID:_____wDn_9odWZxo91unBg--.63865S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxur4kXF1DWry5WF45Kw4rXwb_yoWrur1rpF
	W8KrykJrWxWrZ8Wr1kJFsY9r1fKryFqayUXFWxKw1ft3Waqrna9F10vw1rZF4UJryrZ3Z7
	Za1jkFyUXF45tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEJPEdUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiFgaoz2icTc2rTQAAsl

`f2fs_is_compressed_page` now already accept a folio as
a parameter.So the name now is confusing.
Rename it to `f2fs_is_compressed_folio`.
If a folio has f2fs_iomap_folio_state then it must not be
a compressed folio.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/compress.c | 11 ++++++-----
 fs/f2fs/data.c     | 10 +++++-----
 fs/f2fs/f2fs.h     |  7 +++++--
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6ad8d3bc6df7..627013ef856c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -71,13 +71,14 @@ static pgoff_t start_idx_of_cluster(struct compress_ctx *cc)
 	return cc->cluster_idx << cc->log_cluster_size;
 }
 
-bool f2fs_is_compressed_page(struct folio *folio)
+bool f2fs_is_compressed_folio(struct folio *folio)
 {
-	if (!folio->private)
+	if (!folio_test_private(folio))
 		return false;
 	if (folio_test_f2fs_nonpointer(folio))
 		return false;
-
+	if (folio_get_f2fs_ifs(folio)) /*compressed folio current don't support higer order*/
+		return false;
 	f2fs_bug_on(F2FS_F_SB(folio),
 		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
 	return true;
@@ -1483,8 +1484,8 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct compress_io_ctx *cic = folio->private;
-	enum count_type type = WB_DATA_TYPE(folio,
-				f2fs_is_compressed_page(folio));
+	enum count_type type =
+		WB_DATA_TYPE(folio, f2fs_is_compressed_folio(folio));
 	int i;
 
 	if (unlikely(bio->bi_status != BLK_STS_OK))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5589280294c1..a9dc2572bdc4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -142,7 +142,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
 
-		if (f2fs_is_compressed_page(folio)) {
+		if (f2fs_is_compressed_folio(folio)) {
 			if (ctx && !ctx->decompression_attempted)
 				f2fs_end_read_compressed_page(folio, true, 0,
 							in_task);
@@ -186,7 +186,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 		bio_for_each_folio_all(fi, bio) {
 			struct folio *folio = fi.folio;
 
-			if (!f2fs_is_compressed_page(folio) &&
+			if (!f2fs_is_compressed_folio(folio) &&
 			    !fsverity_verify_page(&folio->page)) {
 				bio->bi_status = BLK_STS_IOERR;
 				break;
@@ -239,7 +239,7 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
 	bio_for_each_folio_all(fi, ctx->bio) {
 		struct folio *folio = fi.folio;
 
-		if (f2fs_is_compressed_page(folio))
+		if (f2fs_is_compressed_folio(folio))
 			f2fs_end_read_compressed_page(folio, false, blkaddr,
 						      in_task);
 		else
@@ -344,7 +344,7 @@ static void f2fs_write_end_io(struct bio *bio)
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		if (f2fs_is_compressed_page(folio)) {
+		if (f2fs_is_compressed_folio(folio)) {
 			f2fs_compress_write_end_io(bio, folio);
 			continue;
 		}
@@ -568,7 +568,7 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 			if (IS_ERR(target))
 				continue;
 		}
-		if (f2fs_is_compressed_page(target)) {
+		if (f2fs_is_compressed_folio(target)) {
 			target = f2fs_compress_control_folio(target);
 			if (IS_ERR(target))
 				continue;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a14bef4dc394..9f88be53174b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4677,7 +4677,7 @@ enum cluster_check_type {
 	CLUSTER_COMPR_BLKS, /* return # of compressed blocks in a cluster */
 	CLUSTER_RAW_BLKS    /* return # of raw blocks in a cluster */
 };
-bool f2fs_is_compressed_page(struct folio *folio);
+bool f2fs_is_compressed_folio(struct folio *folio);
 struct folio *f2fs_compress_control_folio(struct folio *folio);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
@@ -4744,7 +4744,10 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
 		sbi->compr_saved_block += diff;				\
 	} while (0)
 #else
-static inline bool f2fs_is_compressed_page(struct folio *folio) { return false; }
+static inline bool f2fs_is_compressed_folio(struct folio *folio)
+{
+	return false;
+}
 static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
 {
 	if (!f2fs_compressed_file(inode))
-- 
2.34.1


