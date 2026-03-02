Return-Path: <linux-fsdevel+bounces-78917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM3NGh2fpWnACAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE71DAD43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0967304B930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BB407567;
	Mon,  2 Mar 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFS6t9d7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5A3FD147;
	Mon,  2 Mar 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461176; cv=none; b=EdACvYDPhXFIzg2Cn05qHZkZhgNZF2fYakThOrmlX076temiiKIRjIZV4fC4BndPMuieL8DfCwAw25ekKL7DCzZ/3JTSfMS4HCYHRXzYn4BUAVHX2sCkPmR+3YjEvOPbp6h4KU9+7LAsACAffUGaukUi81NOwm072pXQhpU1b1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461176; c=relaxed/simple;
	bh=zVRoSt6asxmfDQMLM126a5qnTo5UTfWOHEKCebkbnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLA4EcTQJc2ASfBuP4SqUd+U+8TM3o0o0hGhppKlTufSGKfbrWDda8JvS3WTMhKjaNwqmEVULo04uxIJgeA69X6j5+kqhESLAktIG8oOCsUYgHWTthcQF+WMbJTAHRllY7nYINkPyWnXzDYoT/3W8DpW7Z3gXi4N0mkp0ehiWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SFS6t9d7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iPTG6eQN9GD9Dw7MCvkn5JwwOi7YjGoLKJ1qkqW4aLQ=; b=SFS6t9d7RBVOwobiURK31Nszio
	LqB7LOwvBTDV6mo9O9d2588F0g/Lcdt+a5Ltxva2yGLB4bfdDEYZlfumcqWk6IKaczjRPKjlixmih
	hkwbWCsOfJLXPo7YOO2cnBgPjoG7pGorTdclD8TjW7J9qkiDhyvDznxfTtnaOqH9SR+XPPW/Q0aR8
	EyXT6b6vAJHwebT5DVrrBYxk/vXsf5NkNhE/0Wv0AABORnzfBqb772YVw0JE/syyOkXf+h6JHKogj
	Gqv3NC8RAjDCnp23dcSiWwGEY+AdHyLs5vAVDgy+GSBfIFHMo/znvPmN5cgcXYwg1SDGsTzquqJ6o
	CvVr5aCw==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47S-0000000DDTL-35tY;
	Mon, 02 Mar 2026 14:19:34 +0000
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
Subject: [PATCH 10/14] fscrypt: pass a byte length to fscrypt_zeroout_range_inline_crypt
Date: Mon,  2 Mar 2026 06:18:15 -0800
Message-ID: <20260302141922.370070-11-hch@lst.de>
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
X-Rspamd-Queue-Id: 6AAE71DAD43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78917-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

Range lengths are usually expressed as bytes in the VFS, switch
fscrypt_zeroout_range_inline_crypt to this convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 7558b3e69701..303b5acc66a9 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -71,10 +71,8 @@ static void fscrypt_zeroout_range_end_io(struct bio *bio)
 
 static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 					      loff_t pos, sector_t sector,
-					      unsigned int len)
+					      u64 len)
 {
-	const unsigned int blockbits = inode->i_blkbits;
-	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -92,12 +90,10 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_NOFS);
 
 		for (n = 0; n < BIO_MAX_VECS; n++) {
-			unsigned int blocks_this_page =
-				min(len, blocks_per_page);
-			unsigned int bytes_this_page = blocks_this_page << blockbits;
+			unsigned int bytes_this_page = min(len, PAGE_SIZE);
 
 			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
-			len -= blocks_this_page;
+			len -= bytes_this_page;
 			pos += bytes_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
 			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
@@ -155,7 +151,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return fscrypt_zeroout_range_inline_crypt(inode, pos, sector,
-							  len);
+				(u64)len << inode->i_blkbits);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(u64, ARRAY_SIZE(pages),
-- 
2.47.3


