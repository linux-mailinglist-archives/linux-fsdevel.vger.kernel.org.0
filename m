Return-Path: <linux-fsdevel+bounces-78505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cERyC/VdoGlgiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:51:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179141A7F69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785CB3065E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855B3E8C60;
	Thu, 26 Feb 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H4EabXF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1C3B95E5;
	Thu, 26 Feb 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117404; cv=none; b=esYUm6+8a/MSmOg+eRTrOWEuBHS9pO6BYRPeUPH6TlyWTXRykwyI3Zd3kC3215ZZwQJBxdVl314X0hIZjri1N/45Y7vzAyowliS61nurLeb4NS2dyyHs9yvhmLrg7yvvQ56P99ylap3IIodt2VvNuNgl5+A13R9xi9knd8vs9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117404; c=relaxed/simple;
	bh=jNN+pxCqQfmKgqzEm/JbRLH09RDDBICEzMCdt6/vDYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ5y8fAMfFS8LiwZ9xT5wtp4uCdYGUvqLdOxDdz7nqQSHInOXySoxC10pJUFeUmailIGaeBFPuHuYhZSrn8z1uUGsYlazzYbV/LeuWMK2Lzg7n6BCAsAftYlEEUlo+iQ4spsRdKTFz3u9tRMAVE6CS0+uDmYHgg07wN3qNUvXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H4EabXF/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2MKwitb679q/7EFRawvNRTcIo328h9sEUi+N9CTrDp0=; b=H4EabXF/irN8FD02iELnKSzwK/
	hCTlIJw+XgFwRw/LbVRYCzvvxI4vhAYAymfxFb9P0krpCmpgI9pYJmO7a8m8Pr4z7FlCN1fJ3jwI3
	Vp9uG0Imz8e8gNBvJ6Wg9dXM9Y87WXU7sNvOj6xWNjo/sYVa0fJZypeyrZrpHPMj8JsRr3yfQFNGN
	2lxCXttT9u8LcZe0bGI2u2r/wSV+VsTvfq1KgByU8UqdwbSojTdqnG/qHZmnO0pWtFmP4an06mbTD
	HeQkjQAtFSrIU9D3k3anzlvquUIymuCrGwkbI4U4iwjqvzjZELCzb5eIOOScFw/g3KLHML5FXE5fx
	04NsViug==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgf-00000006Nbr-3asH;
	Thu, 26 Feb 2026 14:49:57 +0000
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
Subject: [PATCH 09/14] fscrypt: pass a byte offset to fscrypt_zeroout_range_inline_crypt
Date: Thu, 26 Feb 2026 06:49:29 -0800
Message-ID: <20260226144954.142278-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78505-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 179141A7F69
X-Rspamd-Action: no action

Logical offsets into an inode are usually expressed as bytes in the VFS.
Switch fscrypt_zeroout_range_inline_crypt to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index e7fb2fdd9728..7558b3e69701 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -70,12 +70,11 @@ static void fscrypt_zeroout_range_end_io(struct bio *bio)
 }
 
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
-					      pgoff_t lblk, sector_t sector,
+					      loff_t pos, sector_t sector,
 					      unsigned int len)
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
-	loff_t pos = (loff_t)lblk << blockbits;
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -142,6 +141,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
 	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
+	loff_t pos = (loff_t)lblk << inode->i_blkbits;
 	sector_t sector = pblk << (inode->i_blkbits - SECTOR_SHIFT);
 	struct page *pages[16]; /* write up to 16 pages at a time */
 	unsigned int nr_pages;
@@ -154,7 +154,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return 0;
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
-		return fscrypt_zeroout_range_inline_crypt(inode, lblk, sector,
+		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
 							  len);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
-- 
2.47.3


