Return-Path: <linux-fsdevel+bounces-74993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MOLMBrgcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:30:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35563161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 402FD4E3FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA093D6662;
	Thu, 22 Jan 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jT2fKnPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A892331A77;
	Thu, 22 Jan 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070204; cv=none; b=gYAkwcvQXf9fHAYMY135NZCBBAeHyeG1T7tGkSKCxay1WbznYpmVmFG/4Bd01Amxc4ru+mxSkDRv7QyAAptc5vimH6WfWyUZ4f/ehgTZ43GnjWVc/yInN86BcXkxQqiTk5gIR3ijrjYUx9YfEsAPWOO0Ayz9gjWdZuIzJSkO+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070204; c=relaxed/simple;
	bh=FNRUfXPzdVEiIIQbbSg6MBVvSUGHiP0m0uO+68AMwEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbDr759cQGSlGJ1SzW5Qro/pX6+/nO/l8P8e+M5hnZKVfBGi22vAHfJv+PSmSNTCi75qDcrMDtO197R/PtEStzbt/HdL2nX0zb9Ouvc4P3KmEBDcn2efvsxqhEeFoqjSeFN4WnGcb/JtcapEazg6qdmacS5CecWOrJ48x8hIP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jT2fKnPi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0l5S3+jm1Up01/hy7cRWjAmA3NOu7Ry/oSVRb4wzezE=; b=jT2fKnPiuBPOBodPtCjjop08tm
	fe1HUTQellYxFlua9W9DZHrqhHT9ajw7cWBGb8r8DIdZhml/jXOyCzcVaWlRLh41atXUD8hKYxrZJ
	9p2uU9RLmx2+Gy3JydESDuXqwKe/SYBLrFy4sMbupdasr+xzf6cfU+2tTAc7RJl/MSN0VkPNnlaXu
	aBvaBpAJqNhCnODntHNcViPysDmGqnZGfoF97i+4vHqJyOurx3r+Pxfv9vLbFpHPw1ijWJeHy0F56
	twb+ODGm/sHoLSHVKn4xMcPGQoy2xYm9Z4ERJ2b6sfVREkG87Uzh/IeTYObh9yyVjFTN2L5uwFi/R
	wCdDh7ow==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipyJ-00000006dwF-37C2;
	Thu, 22 Jan 2026 08:23:20 +0000
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
Subject: [PATCH 10/11] btrfs: consolidate fsverity_info lookup
Date: Thu, 22 Jan 2026 09:22:06 +0100
Message-ID: <20260122082214.452153-11-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74993-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B35563161
X-Rspamd-Action: no action

 Look up the fsverity_info once in btrfs_do_readpage, and then use it
 for all operations performed there, and do the same in end_folio_read
 for all folios processed there.  The latter is also changed to derive
 the inode from the btrfs_bio - while bbio->inode is optional, it is
 always set for buffered reads.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e65e2cdf950..fe96f060725a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -476,26 +476,25 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				end, page_ops);
 }
 
-static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
+static bool btrfs_verify_folio(struct fsverity_info *vi, struct folio *folio,
+			       u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
-	if (!fsverity_active(folio->mapping->host) ||
-	    btrfs_folio_test_uptodate(fs_info, folio, start, len) ||
-	    start >= i_size_read(folio->mapping->host))
+	if (!vi || btrfs_folio_test_uptodate(fs_info, folio, start, len))
 		return true;
-	return fsverity_verify_folio(*fsverity_info_addr(folio->mapping->host),
-			folio);
+	return fsverity_verify_folio(vi, folio);
 }
 
-static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 len)
+static void end_folio_read(struct fsverity_info *vi, struct folio *folio,
+			   bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
 	ASSERT(folio_pos(folio) <= start &&
 	       start + len <= folio_next_pos(folio));
 
-	if (uptodate && btrfs_verify_folio(folio, start, len))
+	if (uptodate && btrfs_verify_folio(vi, folio, start, len))
 		btrfs_folio_set_uptodate(fs_info, folio, start, len);
 	else
 		btrfs_folio_clear_uptodate(fs_info, folio, start, len);
@@ -575,15 +574,19 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct inode *inode = &bbio->inode->vfs_inode;
 	struct bio *bio = &bbio->bio;
+	struct fsverity_info *vi = NULL;
 	struct folio_iter fi;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
+	if (bbio->file_offset < i_size_read(inode))
+		vi = fsverity_get_info(inode);
+
 	bio_for_each_folio_all(fi, &bbio->bio) {
 		bool uptodate = !bio->bi_status;
 		struct folio *folio = fi.folio;
-		struct inode *inode = folio->mapping->host;
 		u64 start = folio_pos(folio) + fi.offset;
 
 		btrfs_debug(fs_info,
@@ -618,7 +621,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		}
 
 		/* Update page status and unlock. */
-		end_folio_read(folio, uptodate, start, fi.length);
+		end_folio_read(vi, folio, uptodate, start, fi.length);
 	}
 	bio_put(bio);
 }
@@ -1004,6 +1007,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	struct extent_map *em;
 	int ret = 0;
 	const size_t blocksize = fs_info->sectorsize;
+	struct fsverity_info *vi = NULL;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -1011,6 +1015,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		return ret;
 	}
 
+	if (start < last_byte)
+		vi = fsverity_get_info(inode);
+
 	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
 		size_t zero_offset = offset_in_folio(folio, last_byte);
 
@@ -1031,16 +1038,16 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
 			folio_zero_range(folio, pg_offset, end - cur + 1);
-			end_folio_read(folio, true, cur, end - cur + 1);
+			end_folio_read(vi, folio, true, cur, end - cur + 1);
 			break;
 		}
 		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
-			end_folio_read(folio, true, cur, blocksize);
+			end_folio_read(vi, folio, true, cur, blocksize);
 			continue;
 		}
 		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
-			end_folio_read(folio, false, cur, end + 1 - cur);
+			end_folio_read(vi, folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
 		}
 		extent_offset = cur - em->start;
@@ -1117,12 +1124,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
 			folio_zero_range(folio, pg_offset, blocksize);
-			end_folio_read(folio, true, cur, blocksize);
+			end_folio_read(vi, folio, true, cur, blocksize);
 			continue;
 		}
 		/* the get_extent function already copied into the folio */
 		if (block_start == EXTENT_MAP_INLINE) {
-			end_folio_read(folio, true, cur, blocksize);
+			end_folio_read(vi, folio, true, cur, blocksize);
 			continue;
 		}
 
-- 
2.47.3


