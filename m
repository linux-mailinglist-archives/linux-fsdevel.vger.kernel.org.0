Return-Path: <linux-fsdevel+bounces-68894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02814C67B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9034739A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF12E8B7A;
	Tue, 18 Nov 2025 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EM0kw/Zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649E29E10F;
	Tue, 18 Nov 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446964; cv=none; b=cDxcZccH8taBEh0kuokHHKV/u5c/n09SlrPlrI0O+fwnMwDYR/SFPpb3wikzneKIITgMI1lsIK/FoGBPJbzJsBSxbfoXeXsZvRwbp5pI8s9t/eBO3O1W0QQkow0BpEojuI6OZKKnnOtRknEF9zvxwKMNzpwpw3ZDlRw2O4l7FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446964; c=relaxed/simple;
	bh=BKVT0v867KQN3wwmLD1n2DGSNWipCzd+dgbfQurcVEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTwCVSoI6/J4GsbrPGKMhQUXSgBTAMl70uU+arCcso1agOQYtiOUFP3FTXlOyFhWIkt8UEwsdYSGwigtC+WBxjizdKvbXsK/JwOXR5ObtSreUw6DnNYesib66BtW793EL4knEAWpobGXobPJLFMhjOPswtgLBpp036x7aC/SZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EM0kw/Zo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VVOYWQ13oNwsCNhff4f/rJsJFg+2FBZoVLj8q2JKV1E=; b=EM0kw/ZouZuxOhyR7S6g19ABHp
	9z1jNHEAKfQud2JK/NZhuhZSBg26k/YVt9MEQwkF2dylE0Zg77iOpZDYgf+5vQhXmWSpr8vhF28ll
	hLaQns+d0OP/LfeZJJbkKUvCJK13wi+taeys9wLhh4+rhSczZ2ZhHhAJyJ4r0VdDrGv6x79mqItH4
	noM6NPRe7d8gnpRFfgSWTeaXG6PTH+VWB+PyriUdMZb5C7j/dRgfhvE3LE23uy/C/p39e/z+lWT9b
	Sx3C4CmZSqJ88bDu6MzRLpxO+S28GzAYS6yyN39E1mc1LJN/izjjApkwB1YLflh4oZaL26s0M+pZq
	AhCRPekQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6v-0000000HUQ9-37bb;
	Tue, 18 Nov 2025 06:22:42 +0000
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
Subject: [PATCH 07/11] fscrypt: pass a byte length to fscrypt_zeroout_range_inline_crypt
Date: Tue, 18 Nov 2025 07:21:50 +0100
Message-ID: <20251118062159.2358085-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118062159.2358085-1-hch@lst.de>
References: <20251118062159.2358085-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Range lengths are usually expressed as bytes in the VFS, switch
fscrypt_zeroout_range_inline_crypt to this convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 07d757d2777e..be751bcd2976 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -73,8 +73,6 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 					      loff_t pos, sector_t sector,
 					      unsigned int len)
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
+				len << inode->i_blkbits);
 
 	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(u64, ARRAY_SIZE(pages),
-- 
2.47.3


