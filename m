Return-Path: <linux-fsdevel+bounces-76023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPAUEY1AgGlJ5QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:13:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95914C88D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D170A30432D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7742F6170;
	Mon,  2 Feb 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fccZZ2Kk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DA2F2914;
	Mon,  2 Feb 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012523; cv=none; b=Dcf3Q4P+DibRSjEcG5Mv5QMBkxa5ty9XNsUvs4C2yhfHAg4fpqPSTuJDn36uHsnU16w0+VvLj1eVM2Uy1k+sW4KYBz5Gmfs0llOMsHutnFRwcQwLpsHLMtrBblP0seqzy0LHm+ygVStujCsRLFm1cdHemJAZUlSDr8IKXkOPafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012523; c=relaxed/simple;
	bh=+J6Gspvs+p5PUwJfgegRrhW3gSu3OZJO9xwIHLOgwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCPA+WhafVpgL2wuwKWcc7p+8lHb1dFD7yHO0HFv+jfkIaoS3XHAiC+S1OedA4YVXYgDX5QZvJafCPdNhCcTuK3rBnbAAtHAkiUZigugJXq8SIkaNi/l1Y6dng986F7OKyvDXyz/fq9yh3qFGb78FfNDVV2UAXxcCRJbwDLvEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fccZZ2Kk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PgkK/w7RCSXRzbuNalqUJdUjsLJbZJznBNluiIsClZ4=; b=fccZZ2Kk3jACjaidGY4udXmXzN
	PqZ95ALdL30DunF1MfLKoQTt+rUevmN+oHK7yEby2r0XRC6WScEyUqE/gM1wDOx+AqUcQeCwMdKDK
	5P1rcrFcGz2eAQY2duh8PP3YRxbyMl7vnUtOZHFVKl5BJFqgZNdHVn18TG3ecFekn6j7n/Qsy2iiM
	/sJf7frkJn1fNRqfjaSoICvDmewfHBQiCMuiBGagKQO9hLdBkiFSR1OqQKDd2AyQIC4Q8Z4e/9Gd0
	aEE4T7Vh7AqfGXyDqezOmylyB4XVTOfUCInXadfwNAwUBLYr2KpGv77pNXYqM4eoEgPBTnvzQKuN2
	Iv3qQMjg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmn71-00000004Ulv-1qvg;
	Mon, 02 Feb 2026 06:08:40 +0000
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
Subject: [PATCH 08/11] ext4: consolidate fsverity_info lookup
Date: Mon,  2 Feb 2026 07:06:37 +0100
Message-ID: <20260202060754.270269-9-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76023-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 95914C88D0
X-Rspamd-Action: no action

Look up the fsverity_info once in ext4_mpage_readpages, and then use it
for the readahead, local verification of holes and pass it along to the
I/O completion workqueue in struct bio_post_read_ctx.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/readpage.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 823d67e98c70..09acca898c25 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -62,6 +62,7 @@ enum bio_post_read_step {
 
 struct bio_post_read_ctx {
 	struct bio *bio;
+	struct fsverity_info *vi;
 	struct work_struct work;
 	unsigned int cur_step;
 	unsigned int enabled_steps;
@@ -97,7 +98,7 @@ static void verity_work(struct work_struct *work)
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
 	struct bio *bio = ctx->bio;
-	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
+	struct fsverity_info *vi = ctx->vi;
 
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and although verity
@@ -110,7 +111,7 @@ static void verity_work(struct work_struct *work)
 	mempool_free(ctx, bio_post_read_ctx_pool);
 	bio->bi_private = NULL;
 
-	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
+	fsverity_verify_bio(vi, bio);
 
 	__read_end_io(bio);
 }
@@ -174,22 +175,16 @@ static void mpage_end_io(struct bio *bio)
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
@@ -198,6 +193,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 
 		ctx->bio = bio;
+		ctx->vi = vi;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
@@ -211,7 +207,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-static int ext4_mpage_readpages(struct inode *inode,
+static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
@@ -331,10 +327,7 @@ static int ext4_mpage_readpages(struct inode *inode,
 			folio_zero_segment(folio, first_hole << blkbits,
 					  folio_size(folio));
 			if (first_hole == 0) {
-				if (ext4_need_verity(inode, folio->index) &&
-				    !fsverity_verify_folio(
-						*fsverity_info_addr(inode),
-						folio))
+				if (vi && !fsverity_verify_folio(vi, folio))
 					goto set_error_page;
 				folio_end_read(folio, true);
 				continue;
@@ -362,7 +355,7 @@ static int ext4_mpage_readpages(struct inode *inode,
 					REQ_OP_READ, GFP_KERNEL);
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
-			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
+			ext4_set_bio_post_read_ctx(bio, inode, vi);
 			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			if (rac)
@@ -401,6 +394,7 @@ static int ext4_mpage_readpages(struct inode *inode,
 int ext4_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
+	struct fsverity_info *vi = NULL;
 	int ret;
 
 	trace_ext4_read_folio(inode, folio);
@@ -411,24 +405,28 @@ int ext4_read_folio(struct file *file, struct folio *folio)
 			return ret;
 	}
 
-	if (ext4_need_verity(inode, folio->index))
-		fsverity_readahead(*fsverity_info_addr(inode), folio->index,
-				   folio_nr_pages(folio));
-	return ext4_mpage_readpages(inode, NULL, folio);
+	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+		vi = fsverity_get_info(inode);
+	if (vi)
+		fsverity_readahead(vi, folio->index, folio_nr_pages(folio));
+	return ext4_mpage_readpages(inode, vi, NULL, folio);
 }
 
 void ext4_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
+	struct fsverity_info *vi = NULL;
 
 	/* If the file has inline data, no need to do readahead. */
 	if (ext4_has_inline_data(inode))
 		return;
 
-	if (ext4_need_verity(inode, readahead_index(rac)))
-		fsverity_readahead(*fsverity_info_addr(inode),
-				   readahead_index(rac), readahead_count(rac));
-	ext4_mpage_readpages(inode, rac, NULL);
+	if (readahead_index(rac) < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+		vi = fsverity_get_info(inode);
+	if (vi)
+		fsverity_readahead(vi, readahead_index(rac),
+				   readahead_count(rac));
+	ext4_mpage_readpages(inode, vi, rac, NULL);
 }
 
 
-- 
2.47.3


