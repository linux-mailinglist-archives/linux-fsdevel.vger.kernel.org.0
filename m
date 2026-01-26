Return-Path: <linux-fsdevel+bounces-75413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULzHIUbzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67483FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D10E3009F03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4630E0EE;
	Mon, 26 Jan 2026 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2aycWPVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1D30DD13;
	Mon, 26 Jan 2026 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403197; cv=none; b=hjxqCrQfwlIl/WZ+OTeA6eDkd1+zEXwYp+ns5o65xtnnZUpMrDQUeB7WbTxVog++ANz5ymCKVjpTzXz0WxiU/fq+Kxh4mLdkoglGd73jrMsfh40I9K/uqM7xx3iNRDh35XFbN3K1PQcw7CK6hxYHtWG/K4j4Wv8TwpNUBQ5lpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403197; c=relaxed/simple;
	bh=jGpknJwZlDsunYIhv+Kzrx2Umzfl63T5qCugtfMa2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTH0/p1HfamCRMFXm1iAhR1rr5dygZ6+XmLpAlroopVgllAGKD8rpCT3/pq9MQlz5hKZZ+wzPjru9JTk04biQyjhoKqGiMWdd2lueDvCFK4YZXfmzIVLa4Xeqxf7CatKbILYJyE4d8idCOQ4GoZC8n6kmi+GtS4dn9a/XR6zk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2aycWPVl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=A3Sc/Ix6P+xjJUGd+uCi/ak9QfXa0EvxxoJM7QjJPn0=; b=2aycWPVlg3PMo3+nU+8gRTMqLc
	mhtj0dd+w2vqerkD+mWZDRNgkVsIphTrf5W5jWCpmB1EIO14atq8ls7tUNd5wjlmWOygZJJr/NeFe
	q0zq4+lh6MD+bvrGtxfwuSK4T9L/sMOTrhM/ykfXDC//e3jZNg2ua/3lHvhWp3xkc7n0Zs4ZHeWns
	qfzEWRM0aZZdqbrwJfvHXXsqsgyFrtnpSouQZsHrbiTTMVAboN4LLA//zE4ykwhq/O/+X9fh/EpEk
	toF8UcObDOZfHCahc7VvHmPBZjDDQ0yEJu3j5/sRnDCADL2KJgwQKh1rlmvPo228bgjLdce3XAz/a
	G6xBbT0w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEbB-0000000BuSk-39EM;
	Mon, 26 Jan 2026 04:53:14 +0000
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
Subject: [PATCH 09/16] fsverity: constify the vi pointer in fsverity_verification_context
Date: Mon, 26 Jan 2026 05:50:55 +0100
Message-ID: <20260126045212.1381843-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75413-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 3E67483FF2
X-Rspamd-Action: no action

struct fsverity_info contains information that is only read in the
verification path.  Apply the const qualifier to match various explicitly
passed arguments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/verity/verify.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 32cadb71953c..881af159e705 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -21,7 +21,7 @@ struct fsverity_pending_block {
 
 struct fsverity_verification_context {
 	struct inode *inode;
-	struct fsverity_info *vi;
+	const struct fsverity_info *vi;
 
 	/*
 	 * This is the queue of data blocks that are pending verification.  When
@@ -84,8 +84,8 @@ EXPORT_SYMBOL_GPL(fsverity_readahead);
  * Returns true if the hash block with index @hblock_idx in the tree, located in
  * @hpage, has already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
-				   unsigned long hblock_idx)
+static bool is_hash_block_verified(const struct fsverity_info *vi,
+				   struct page *hpage, unsigned long hblock_idx)
 {
 	unsigned int blocks_per_page;
 	unsigned int i;
@@ -156,7 +156,8 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  *
  * Return: %true if the data block is valid, else %false.
  */
-static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
+static bool verify_data_block(struct inode *inode,
+			      const struct fsverity_info *vi,
 			      const struct fsverity_pending_block *dblock)
 {
 	const u64 data_pos = dblock->pos;
@@ -315,7 +316,7 @@ static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
 				   struct inode *inode)
 {
-	struct fsverity_info *vi = *fsverity_info_addr(inode);
+	const struct fsverity_info *vi = *fsverity_info_addr(inode);
 
 	ctx->inode = inode;
 	ctx->vi = vi;
@@ -342,7 +343,7 @@ fsverity_clear_pending_blocks(struct fsverity_verification_context *ctx)
 static bool
 fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
 {
-	struct fsverity_info *vi = ctx->vi;
+	const struct fsverity_info *vi = ctx->vi;
 	const struct merkle_tree_params *params = &vi->tree_params;
 	int i;
 
@@ -372,7 +373,7 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
 				     struct folio *data_folio, size_t len,
 				     size_t offset)
 {
-	struct fsverity_info *vi = ctx->vi;
+	const struct fsverity_info *vi = ctx->vi;
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int block_size = params->block_size;
 	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
-- 
2.47.3


