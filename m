Return-Path: <linux-fsdevel+bounces-75742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHKbMXotemnd3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:38:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5CA41CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E83316E11A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A136C5AA;
	Wed, 28 Jan 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OU5/R6ad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6B36B07E;
	Wed, 28 Jan 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614101; cv=none; b=M7uyX2LQ0enA6uGw1SEDM6YKj/Jo1zqb36dm9+e4plw5u09ggu4FmL5CJp2sCEee0MCw3Zih3MUFX4rVxRk+HZaFd1zI8DjPIwocklITeAkV7lXMPbq04yZwwVQPTd/QdrkXl2jzgxky4T/3DzHRf5RQPNw54z2LCtxuZPk4Eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614101; c=relaxed/simple;
	bh=debrzd4NzRekhfdtgkfQRdPZNwAiq/zU9J7aLkTDo9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+EUcVisbNaj1yqInQEkkWSWPmsNN5spHKrb5zVuA06RyQNDIn4mItGc1pK0PeEXWeLslfU/g8a1Apv4ZVhss1eNkCMYtD7shFpQYxcqL5kIKv+UZ4uNz9pCLClIRFUhdmNI1PesP9ScJnBig5jracEnGgTmw3QIjEZ/EraidJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OU5/R6ad; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aEalOFlIAJNf3Sx8CGoCosLvCgX3oRGPr4jQ2TTWcwQ=; b=OU5/R6adl77CpGecMr/OkFmYBv
	AumL0YUeP7IBBPEINo2EBDury9W4zyCwLnveaKkN0OJCXynNimQaiyyDPL9kFnpIFLhyZkW+EJzIV
	NJzmaind65yI8lkXmhwudMHsztKcMuiuvKJgY7qtbocu+hoFQ63cd3Q7em8E6SkYtrtt0IPLafm1D
	b34WvAc396YoS5clSWijReFST9VrXRRnH0PLAHMptUKYiFCIZx5gIJh2YvJe6SENhcuVhTCb7WTDK
	Sjk8pmiHyvUPqX9HAPnSk1rIVdJWQO6B2KZbZOaT7tKnyrmKOp5EZnh4UbpLhzNitOnsyI2rCLVzj
	qBGyoP7Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7Sp-0000000GHaZ-32lu;
	Wed, 28 Jan 2026 15:28:16 +0000
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
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 14/15] btrfs: consolidate fsverity_info lookup
Date: Wed, 28 Jan 2026 16:26:26 +0100
Message-ID: <20260128152630.627409-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75742-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56A5CA41CD
X-Rspamd-Action: no action

Look up the fsverity_info once in btrfs_do_readpage, and then use it
for all operations performed there, and do the same in end_folio_read
for all folios processed there.  The latter is also changed to derive
the inode from the btrfs_bio - while bbio->inode is optional, it is
always set for buffered reads.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 54 +++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 21430b7d8f27..24988520521c 100644
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
@@ -575,14 +574,19 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct inode *inode = &bbio->inode->vfs_inode;
 	struct bio *bio = &bbio->bio;
+	struct fsverity_info *vi = NULL;
 	struct folio_iter fi;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
+
+	if (bbio->file_offset < i_size_read(inode))
+		vi = fsverity_get_info(inode);
+
 	bio_for_each_folio_all(fi, &bbio->bio) {
 		bool uptodate = !bio->bi_status;
 		struct folio *folio = fi.folio;
-		struct inode *inode = folio->mapping->host;
 		u64 start = folio_pos(folio) + fi.offset;
 
 		btrfs_debug(fs_info,
@@ -617,7 +621,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		}
 
 		/* Update page status and unlock. */
-		end_folio_read(folio, uptodate, start, fi.length);
+		end_folio_read(vi, folio, uptodate, start, fi.length);
 	}
 	bio_put(bio);
 }
@@ -992,7 +996,8 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
-			     struct btrfs_bio_ctrl *bio_ctrl)
+			     struct btrfs_bio_ctrl *bio_ctrl,
+			     struct fsverity_info *vi)
 {
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1030,16 +1035,16 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
@@ -1116,12 +1121,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
 
@@ -1318,7 +1323,8 @@ static void lock_extents_for_read(struct btrfs_inode *inode, u64 start, u64 end,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct btrfs_inode *inode = folio_to_inode(folio);
+	struct inode *vfs_inode = folio->mapping->host;
+	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	const u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
 	struct extent_state *cached_state = NULL;
@@ -1327,10 +1333,13 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 		.last_em_start = U64_MAX,
 	};
 	struct extent_map *em_cached = NULL;
+	struct fsverity_info *vi = NULL;
 	int ret;
 
 	lock_extents_for_read(inode, start, end, &cached_state);
-	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
+	if (folio_pos(folio) < i_size_read(vfs_inode))
+		vi = fsverity_get_info(vfs_inode);
+	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, vi);
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	btrfs_free_extent_map(em_cached);
@@ -2697,16 +2706,19 @@ void btrfs_readahead(struct readahead_control *rac)
 		.last_em_start = U64_MAX,
 	};
 	struct folio *folio;
-	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
+	struct inode *vfs_inode = rac->mapping->host;
+	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	const u64 start = readahead_pos(rac);
 	const u64 end = start + readahead_length(rac) - 1;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
+	struct fsverity_info *vi = NULL;
 
 	lock_extents_for_read(inode, start, end, &cached_state);
-
+	if (start < i_size_read(vfs_inode))
+		vi = fsverity_get_info(vfs_inode);
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
+		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, vi);
 
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
-- 
2.47.3


