Return-Path: <linux-fsdevel+bounces-76020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFXZN24/gGlH5QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C971C87F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E638C300DD60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36402F3C07;
	Mon,  2 Feb 2026 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dduNA+cI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3248CFC;
	Mon,  2 Feb 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012508; cv=none; b=CU9VIcyl02DUQtDXpr2RVIW4XN6DnGlhVup8cOwygfHZj+Y2LgLl1NOn1ngkt2Pq3MJ6OoDD7FGcjwB3hLTHT993q3zGfLZLbvJ+PMQU7SMVJW2tL55LVkeeaAzrr5pPAEDY1tpBt1YuzLcTdWoXH6KNzjkHd1nQY1r+XyPLJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012508; c=relaxed/simple;
	bh=M8IrnlRYm+I0lOwZFKt/xfbVJ7qgIWn58B8ilDybxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAsAmxBGez7bTDwyZ+7RRefXmxry0YCNAiBGhsEGaNbI5/FXrNxIiv7GzMMvf0ixhjxQhzMBgC8nJt8pyTQERVtNE/y101ljG7T+pD7RNbzLx3eJDxsYrDF6wgvlllqgCQOo1UrQBM7HMmZFJ8XLZNfyGBRAKcErC6z+HvIOdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dduNA+cI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1aUYwg7LuL+2OQnTsRXeUx2rKpMAyIXFooShlg2uRJ0=; b=dduNA+cILUbo3gcQb9pOM0WS/r
	0DINhas3jXg8D/mE9yRAEirmJI+E+ZCKr9vCtiS72nfG/rZS4yrrIoksmSAfhBg8N5DYw6ft0DaGN
	/60jHQR4K9PneEhwlrdljkAGeC4ENNcgLg+4MRUGqMhx3nls+eyHVAGpxC5BEmuQIf3clCbk3T+ht
	DXp8iCWxZoCSqigmduI9smvah9jGXDRPeCcXOmqurY6jBsJaAUFlp5cZEHPu10i5hLZ3FZ6NbfB1d
	bWijQTrz8kTloh3kLwPGPXefXMIVMa7rlc1hxdcYXTLrAu7aQauFR7Ju7feeA4dK307c17AkYHEue
	FuFt87NA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmn6m-00000004UkL-1iqZ;
	Mon, 02 Feb 2026 06:08:24 +0000
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
	fsverity@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 05/11] fsverity: deconstify the inode pointer in struct fsverity_info
Date: Mon,  2 Feb 2026 07:06:34 +0100
Message-ID: <20260202060754.270269-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202060754.270269-1-hch@lst.de>
References: <20260202060754.270269-1-hch@lst.de>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76020-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C971C87F7
X-Rspamd-Action: no action

A lot of file system code expects a non-const inode pointer.  Dropping
the const qualifier here allows using the inode pointer in
verify_data_block and prepares for further argument reductions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/verity/fsverity_private.h | 4 ++--
 fs/verity/open.c             | 2 +-
 fs/verity/verify.c           | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dd20b138d452..f9f3936b0a89 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -73,7 +73,7 @@ struct fsverity_info {
 	struct merkle_tree_params tree_params;
 	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
-	const struct inode *inode;
+	struct inode *inode;
 	unsigned long *hash_block_verified;
 };
 
@@ -124,7 +124,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 				     unsigned int log_blocksize,
 				     const u8 *salt, size_t salt_size);
 
-struct fsverity_info *fsverity_create_info(const struct inode *inode,
+struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc);
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 090cb77326ee..128502cf0a23 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -175,7 +175,7 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
  * appended builtin signature), and check the signature if present.  The
  * fsverity_descriptor must have already undergone basic validation.
  */
-struct fsverity_info *fsverity_create_info(const struct inode *inode,
+struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc)
 {
 	struct fsverity_info *vi;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index dac004f2a1a0..0de55c8e4217 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -157,9 +157,10 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  *
  * Return: %true if the data block is valid, else %false.
  */
-static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
+static bool verify_data_block(struct fsverity_info *vi,
 			      const struct fsverity_pending_block *dblock)
 {
+	struct inode *inode = vi->inode;
 	const u64 data_pos = dblock->pos;
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
@@ -362,7 +363,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
 	}
 
 	for (i = 0; i < ctx->num_pending; i++) {
-		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
+		if (!verify_data_block(vi, &ctx->pending_blocks[i]))
 			return false;
 	}
 	fsverity_clear_pending_blocks(ctx);
-- 
2.47.3


