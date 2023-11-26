Return-Path: <linux-fsdevel+bounces-3851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7E7F92B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4911C20AB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A69D313;
	Sun, 26 Nov 2023 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K96gP7o6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EFB110;
	Sun, 26 Nov 2023 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oRjyiZVRuzcHxCkVzphuZka5+x7mico/0jagFrAkKhs=; b=K96gP7o6ouxbZ6KDzthKDexzUG
	7so1BBadANvi2QjfHUT2Dgi1lmR8QbK/vpvHgR60c+mftpcf+cQYI+IF5pX8rofmQUQJs2ZA1DcY9
	G4PK/TUOKdD6NypB0rMZ4F0gn9Awk6SuLWVfWsLp0gXZJlXCH2e54x2m8OYOy/LYRXJN8WhamEIvC
	fWg00iWwUSqSbvNi1X7fUYjRIoxoyzZdVcBO1eZQCG59vl0IlCpUKcH1OBaBgmrp85HCs0Yg5/ISw
	yqgNTNZCo+S3rMo8c3OpnsKzHtWUuZGG1c10B8ADc9Fm1PH6eveqUuaOfz3ZUKYhncpGmXNjQL8Lo
	CzINmoBg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EYH-00BCRS-22;
	Sun, 26 Nov 2023 12:47:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/13] iomap: only call mapping_set_error once for each failed bio
Date: Sun, 26 Nov 2023 13:47:17 +0100
Message-Id: <20231126124720.1249310-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 17760f3e67c61e..e1d5076251702d 100644
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


