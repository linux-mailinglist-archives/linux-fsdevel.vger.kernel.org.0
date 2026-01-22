Return-Path: <linux-fsdevel+bounces-74991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBT5NPbfcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:29:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550763118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23DA7C0700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61D3D4124;
	Thu, 22 Jan 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0qG/e9Tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C936C0CE;
	Thu, 22 Jan 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070196; cv=none; b=fRIY7fDjyikUKKnGKEoShoAS8NmtMMKcreGWVJBM2b7FIdIC9dXF9c8p9vc/7fkwUZkiBNEAk93FP2Jj9GqTNOqiSDuCprcyw06o2u6dxttAvI+aMgiMXYLrl0Ytl+42/Lh192ophDsTv4XNdpc2JHCCFk4b0291wEp53M9vR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070196; c=relaxed/simple;
	bh=RaqRCe+KQ5RAq0vSu/Qw+cvUfK2eC1qsso+i35VdI1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMh4dp1qesbtxgPMzP9CJI27cIH4Pb7BTHWlgyj9YBcy2FKPgWCPKKhGX7NDnZQpXMi1pwAR4lJgGo5bjq1XU/nhJPvFTKsDvA5WedtsLUmlxF2vVCogRfCGUdyb0zlAgIUb3anaR8mQiWvwIXV2AIEwF419kbk+X7V0Lq0pITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0qG/e9Tb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FWCJModxY90FXNQGxz4npQidt6MGc4Ufe6Kd0yYr2QE=; b=0qG/e9TbOhESgi0veTXNeGbDib
	ilePuxHcNm2fJMgmcT/3dzHe9j8FnWRovm8l88AafyqUyegh1wPnUUgfTXwxaJFFI/bSAEkKq53+Z
	jYwc40IS2sxq0/4hmsQkvcrpCQkfaIciv7OMG6NbsSHZeWcTix/e9zOTSrR7R9qcNVr2QSBw8GAst
	h7hInW4OEciYie7O02Rc8ZHas/Sf3uIWqcj4QcDPEJ5kvAXO5uMKhQWv4zYel+fUozjmpPvD0BHgq
	WudJfSsRmQmXsmcdesAo8k9wa8aaVH63iZDvQ6Wmj3X2vMNASOmfP/iT3jM0+Xoj5bfMXwvxHne8j
	TqSkOxJg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipy9-00000006dvi-397M;
	Thu, 22 Jan 2026 08:23:10 +0000
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
Subject: [PATCH 08/11] ext4: consolidate fsverity_info lookup
Date: Thu, 22 Jan 2026 09:22:04 +0100
Message-ID: <20260122082214.452153-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74991-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 6550763118
X-Rspamd-Action: no action

Look up the fsverity_info once in ext4_mpage_readpages, and then use it
for the readahead, local verification of holes and pass it along to the
I/O completion workqueue in struct bio_post_read_ctx.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/readpage.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 02f918cf1945..6092d6d59063 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -61,6 +61,7 @@ enum bio_post_read_step {
 
 struct bio_post_read_ctx {
 	struct bio *bio;
+	struct fsverity_info *vi;
 	struct work_struct work;
 	unsigned int cur_step;
 	unsigned int enabled_steps;
@@ -96,7 +97,7 @@ static void verity_work(struct work_struct *work)
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
 	struct bio *bio = ctx->bio;
-	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
+	struct fsverity_info *vi = ctx->vi;
 
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and although verity
@@ -109,7 +110,7 @@ static void verity_work(struct work_struct *work)
 	mempool_free(ctx, bio_post_read_ctx_pool);
 	bio->bi_private = NULL;
 
-	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
+	fsverity_verify_bio(vi, bio);
 
 	__read_end_io(bio);
 }
@@ -172,22 +173,16 @@ static void mpage_end_io(struct bio *bio)
 	__read_end_io(bio);
 }
 
-static inline bool ext4_need_verity(const struct inode *inode, pgoff_t idx)
-{
-	return fsverity_active(inode) &&
-	       idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-}
-
 static void ext4_set_bio_post_read_ctx(struct bio *bio,
 				       const struct inode *inode,
-				       pgoff_t first_idx)
+				       struct fsverity_info *vi)
 {
 	unsigned int post_read_steps = 0;
 
 	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 
-	if (ext4_need_verity(inode, first_idx))
+	if (vi)
 		post_read_steps |= 1 << STEP_VERITY;
 
 	if (post_read_steps) {
@@ -196,6 +191,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 
 		ctx->bio = bio;
+		ctx->vi = vi;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
@@ -223,6 +219,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	sector_t first_block;
 	unsigned page_block;
 	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct fsverity_info *vi = NULL;
 	int length;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
@@ -244,9 +241,11 @@ int ext4_mpage_readpages(struct inode *inode,
 			folio = readahead_folio(rac);
 
 		if (first_folio) {
-			if (ext4_need_verity(inode, folio->index))
-				fsverity_readahead(*fsverity_info_addr(inode),
-						folio, nr_pages);
+			if (folio->index <
+			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+				vi = fsverity_get_info(inode);
+			if (vi)
+				fsverity_readahead(vi, folio, nr_pages);
 			first_folio = false;
 		}
 
@@ -337,11 +336,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			folio_zero_segment(folio, first_hole << blkbits,
 					  folio_size(folio));
 			if (first_hole == 0) {
-				struct fsverity_info *vi =
-					*fsverity_info_addr(folio->mapping->host);
-
-				if (ext4_need_verity(inode, folio->index) &&
-				    !fsverity_verify_folio(vi, folio))
+				if (vi && !fsverity_verify_folio(vi, folio))
 					goto set_error_page;
 				folio_end_read(folio, true);
 				continue;
@@ -369,7 +364,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					REQ_OP_READ, GFP_KERNEL);
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
-			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
+			ext4_set_bio_post_read_ctx(bio, inode, vi);
 			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			if (rac)
-- 
2.47.3


