Return-Path: <linux-fsdevel+bounces-78908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOpxIhGfpWnACAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB241DAD25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169D030557E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748633FD147;
	Mon,  2 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQQaQj/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA838A723;
	Mon,  2 Mar 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461168; cv=none; b=JGlYSdPPXpPY5GPlDQdJatKmpR3+sFMTZ3aRJON5kg88sjGc+9Dku3I3sN74rsWaStcIP4ZJES/znHU1nXQfEJL22gimqNDvvRMQReyGinUgFiGabsPN6Cvz5+pd88Mc4LsrofMl5uW28ff9JVfeTHPl3b2UcaHmSEgyModu5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461168; c=relaxed/simple;
	bh=W9GZqW6NjL6/MQYVnfHt4zTImrZXqXJ9Ntus8qEAlks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1KcC7mxf9KBwo5l3USIBRe6RUdyMvS9Y6BDf6cqk6lDhBWoOZZvYuDuVXm+sYuIPpf0adfYhB3m4V5zR2qds6DaP/Wlg1+L5p0hEcb8jflSCYArS/biNm+dNKvP85E9jarZGbpkaHvhc63luKjzXWbL3ctPeOhB6AX2/vkELtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KQQaQj/I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vRH0VYuDnXIQ/WJ+FaJNrLKhHHLaKL0S+YY2G+IdqU8=; b=KQQaQj/IT3chTySiJCVuiK1W5/
	zI2yTx6tE92rx/uX9K/RuqfLRnZdOCaD8kTnQ5T71+A/VMlLqslcVRh5roKOC38nVydVHrpaVD2Y4
	kpNgVlTC643UVxsfWuCpFgJDiY7JICZJgctDFOb6R59BNjkIDABBsKKIN6Wc9H8VlseHgxfHDZfjR
	vF/wMmMbXXNElMfp04EwieRgIr3VFJ1YMRcxCjCw/EmbdfxivAJLOZkraAC5vsMaMZhNXp6EFavpN
	pUI/D67nPtQZFo8vn0ZvjTvnQ9NmKFHqtbRbafy1iqpqNF+O8B7qIR8qKUMfxhZ38We3Qwd4dubuC
	U6Xicxvw==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47K-0000000DDRk-2YZr;
	Mon, 02 Mar 2026 14:19:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/14] ext4: open code fscrypt_set_bio_crypt_ctx_bh
Date: Mon,  2 Mar 2026 06:18:07 -0800
Message-ID: <20260302141922.370070-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
References: <20260302141922.370070-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 1DB241DAD25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78908-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

io_submit_init_bio already has or can easily get at most information
needed to set the crypto context.  Open code fscrypt_set_bio_crypt_ctx_bh
based on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index b8cf9f6f9e0b..c5ca99b33c26 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -417,6 +417,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 
 static void io_submit_init_bio(struct ext4_io_submit *io,
 			       struct inode *inode,
+			       struct folio *folio,
 			       struct buffer_head *bh)
 {
 	struct bio *bio;
@@ -426,7 +427,9 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
 	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
-	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+			(folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits,
+			GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
@@ -448,7 +451,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 		ext4_io_submit(io);
 	}
 	if (io->io_bio == NULL)
-		io_submit_init_bio(io, inode, bh);
+		io_submit_init_bio(io, inode, folio, bh);
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, folio, bh->b_size);
-- 
2.47.3


