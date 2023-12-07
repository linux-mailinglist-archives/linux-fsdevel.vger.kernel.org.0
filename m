Return-Path: <linux-fsdevel+bounces-5120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA68808319
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B92282A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885C31A82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q8I2PfwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D241AD;
	Wed,  6 Dec 2023 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XZ1A7mD8eN8GtDAlmqm1J/SEKdB95CFncu1BUvWex9k=; b=Q8I2PfwFoXdUCEtw5I4k640hRN
	jWOp1aSuWJfWVZRY+MuPvJU40g9Hc3x1D8lPqwdJU13mwEO1i8/5V7iT92XGwyquXN/xbxZx2tVxC
	1DHH7W54b2HRZeuYIuS9aib9llJJyObdVlRhRMoa4ndE0D4Pz88XAEBT+YAhJZyrx5qLPNRbXS6Mw
	WmzF6OGzajCoaDa6GKGXZT9q6rK+bIwhsWGXyJTfMaknTnfMZDO7KCMCDXFFjssdn4P9BSVypVWqV
	hqCDTCGZNALBQxYmK3Iemz03m4w8BeSNW6GOHhy8x717dy8UBv7ayHwtT7qb1bw+g9Dqqf0ml7oZu
	tZGKbqXg==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nR-00C53U-02;
	Thu, 07 Dec 2023 07:27:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 10/14] iomap: only call mapping_set_error once for each failed bio
Date: Thu,  7 Dec 2023 08:27:06 +0100
Message-Id: <20231207072710.176093-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Instead of clling mapping_set_error once per folio, only do that once
per bio, and consolidate all the writeback error handling code in
iomap_finish_ioend.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7ed11eca7c7c9e..21f5019c0fe762 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1464,15 +1464,10 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
 static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-		size_t len, int error)
+		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
-	if (error) {
-		folio_set_error(folio);
-		mapping_set_error(inode->i_mapping, error);
-	}
-
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
@@ -1493,18 +1488,24 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	struct folio_iter fi;
 	u32 folio_count = 0;
 
+	if (error) {
+		mapping_set_error(inode->i_mapping, error);
+		if (!bio_flagged(bio, BIO_QUIET)) {
+			pr_err_ratelimited(
+"%s: writeback error on inode %lu, offset %lld, sector %llu",
+				inode->i_sb->s_id, inode->i_ino,
+				ioend->io_offset, ioend->io_sector);
+		}
+	}
+
 	/* walk all folios in bio, ending page IO on them */
 	bio_for_each_folio_all(fi, bio) {
-		iomap_finish_folio_write(inode, fi.folio, fi.length, error);
+		if (error)
+			folio_set_error(fi.folio);
+		iomap_finish_folio_write(inode, fi.folio, fi.length);
 		folio_count++;
 	}
 
-	if (unlikely(error && !bio_flagged(bio, BIO_QUIET))) {
-		printk_ratelimited(KERN_ERR
-"%s: writeback error on inode %lu, offset %lld, sector %llu",
-			inode->i_sb->s_id, inode->i_ino,
-			ioend->io_offset, ioend->io_sector);
-	}
 	bio_put(bio);	/* frees the ioend */
 	return folio_count;
 }
-- 
2.39.2


