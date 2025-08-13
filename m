Return-Path: <linux-fsdevel+bounces-57677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2FB245B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62573164662
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E22F6586;
	Wed, 13 Aug 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KTUeOmvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46ED2F7474
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077940; cv=none; b=A65nQo8nHWMiSlY/VFmHoSXGlydUjnKx2c4kDGHAEKt4lmGGJDYD+ldUB92DfWlymuNOInENBsL0CxEdTse+B5W/p13Eb5KiPpIa76+kYI0I+z9LrdW3l58vGKBquYlq/GdARz1f6pQzpxwVH0EcCkymbVDkWKpgsIQzTfoCJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077940; c=relaxed/simple;
	bh=eJUfmls9Zqt5KmYRMameY1hW0NNqVruFenjHND+hJDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQxBngddahW7EQjJ8ZUeT3HYbkeF5L08ryrZ7dimB1myb+8Q9H2YTvHugjZ1b1eSm4UnzjWaYeDWqJVocT8Ee7gWNnPQ9X/k8vgAS9L0qRSCSk1cq8k1TnKJyiumWa9TU+GIllVY86ZteDbg28O4ls9XWsXE2tXMiuWsGpf+kkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KTUeOmvw; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cl
	mdLcSEz6kiQGDh8neFf8Tbchu5TMZjFVQqtnsQs3U=; b=KTUeOmvwn7/NyzE1NS
	USaFoPyW+O6rMGSSVK/IWbTxQP8HX6ob6ATshI0uJd0LZz0wNNDUgL7Lkxpfhons
	c/DAATf7ptHrfXZQkswBWN8W/azbdOQ25FsV01ni9Ws9KdvVkONn+HCX8j+HMclE
	KCYtf6uUow/LcNbSgkfN/Kit0=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S8;
	Wed, 13 Aug 2025 17:38:28 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 6/9] f2fs: Extend f2fs_io_info to support sub-folio ranges
Date: Wed, 13 Aug 2025 17:37:52 +0800
Message-Id: <20250813093755.47599-7-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813093755.47599-1-nzzhao@126.com>
References: <20250813093755.47599-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4rXry8KF45Cw4fKF18uFg_yoWrArWkpF
	y5Kr4rGrs3Gr1fWw1ktFn8XF1Fk347Gr4fGFs7Ga4Skayjg3s5KFn3Ka48XFyrtrZ3AFWk
	XF1SkFyUXF1UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRPl1PUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiZAaoz2icUlqdGQAAs9

Since f2fs_io_info (hereafter fio) has been converted to use fio->folio
and fio->page is deprecated, we must now track which sub-part of a
folio is being submitted to a bio in order to support large folios.

To achieve this, we add `idx` and `cnt` fields to the fio struct.
`fio->idx` represents the offset (in pages) within the current folio
for this I/O operation, and `fio->cnt` represents the number of
contiguous blocks being processed.

With the introduction of these two fields, the existing `old_blkaddr`
and `new_blkaddr` fields in fio are reinterpreted. They now represent
the starting old and new block addresses corresponding to `fio->idx`.
Consequently, an fio no longer represents a single mapping from one
old_blkaddr to one new_blkaddr, but rather a range mapping from
[old_blkaddr, old_blkaddr + fio->cnt - 1] to
[new_blkaddr, new_blkaddr + fio->cnt - 1].

In bio submission paths, for cases where `fio->cnt` is not explicitly
initialized, we default it to 1 and `fio->idx` to 0. This ensures
backward compatibility with all existing f2fs logic that operates on
single pages.

Discussion: Now I don't know if it's better to store bytes-unit
logical file offset and LBA length instead of block-unit cnt and
page idx in fio if we are to support BLOCK_SIZE > PAGE_SIZE.
Suggestions are appreciated.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 16 ++++++++++------
 fs/f2fs/f2fs.h |  2 ++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a9dc2572bdc4..b7bef2a28c8e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -711,7 +711,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	f2fs_set_bio_crypt_ctx(bio, fio_folio->mapping->host,
 			fio_folio->index, fio, GFP_NOIO);
-	bio_add_folio_nofail(bio, data_folio, folio_size(data_folio), 0);
+	bio_add_folio_nofail(bio, data_folio,
+			     F2FS_BLK_TO_BYTES(fio->cnt ? fio->cnt : 1),
+			     fio->idx << PAGE_SHIFT);
 
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
@@ -1010,16 +1012,18 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		io->fio = *fio;
 	}
 
-	if (!bio_add_folio(io->bio, bio_folio, folio_size(bio_folio), 0)) {
+	if (!bio_add_folio(io->bio, bio_folio,
+			   F2FS_BLK_TO_BYTES(fio->cnt ? fio->cnt : 1),
+			   fio->idx << PAGE_SHIFT)) {
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
 
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
-				folio_size(fio->folio));
+					 F2FS_BLK_TO_BYTES(fio->cnt));
 
-	io->last_block_in_bio = fio->new_blkaddr;
+	io->last_block_in_bio = fio->new_blkaddr + fio->cnt - 1;
 
 	trace_f2fs_submit_folio_write(fio->folio, fio);
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -2675,7 +2679,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 
 	if (need_inplace_update(fio) &&
-	    f2fs_lookup_read_extent_cache_block(inode, folio->index,
+	    f2fs_lookup_read_extent_cache_block(inode, folio->index + fio->idx,
 						&fio->old_blkaddr)) {
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
 						DATA_GENERIC_ENHANCE))
@@ -2690,7 +2694,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
 		return -EAGAIN;
 
-	err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, folio->index + fio->idx, LOOKUP_NODE);
 	if (err)
 		goto out;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9f88be53174b..c6b23fa63588 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1281,6 +1281,8 @@ struct f2fs_io_info {
 	blk_opf_t op_flags;	/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
+	pgoff_t idx; /*start page index within current active folio in this fio*/
+	unsigned int cnt; /*block cnts of the active folio, we assume they are continuous.*/
 	union {
 		struct page *page;	/* page to be written */
 		struct folio *folio;
-- 
2.34.1


