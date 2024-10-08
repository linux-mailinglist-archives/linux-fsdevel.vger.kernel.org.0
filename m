Return-Path: <linux-fsdevel+bounces-31288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B099434D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BD428E9D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DA14EC59;
	Tue,  8 Oct 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qAFHyEA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA3187876;
	Tue,  8 Oct 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377987; cv=none; b=plf6UxxLwM64xXxPhBkpJ9XRoFTlOXZ+EtsfII/1xpkqTUMMoej48CCwxpyJmY6WtuqaAOFWhHJKnrgx07HQ6tbA6gEgy2STRpoJZ1Vttf0IhfUipSnLfUOIhM8heswAPfq2xXaHwoMCbBF21Msl36c25yicuvL/+t2G7y+1bfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377987; c=relaxed/simple;
	bh=FNLhLRiwfcaayQ4TBbEFLpKs+OmFDQuhmiIZd+/BECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InbNo6R7s61WK4PWDM6OzwOsmQTpCRB22fQxkuS1wA7zxRkrYADXMRYg9K8787Udmp1BhCYvJhPhdmwE5Jm4UV6qOXhhUEoqeZm28dl4AZjRB20POpnf5fzZk3W9ex0fZnKuIjPEi5MBSZz7SDcPB0U2B1xbBvJlux7J56OwMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qAFHyEA5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=50o+ZPjCb88EMOHPleMlwNA8WWFdEX2RWFylxFqf/8M=; b=qAFHyEA5IWO1de6nJ+cavwLY0c
	v7S0sqvBHulFk9SZ1fB2krVZvdowps/+dk9dfEtQK79h0zbksxxAzFJw+0xjGpLcIgndG60bUlR6+
	dCFnU5r8c07qhJMSRtf2ete2/dCqELBPAf++YbpYI6iSjCSBg7acKyeiy8uz71gbPdN3fdiLC3YM5
	fNtI6uIl3ZmSBa/r8Ac08Rao68PmCo1Cpf2v3A1E7WWOPLHeVfJfi9JUJNx5VT7xANjg5hbqJDtU1
	1ldYFVmmm6jBerr15KtmTjxQZAU1z8E1TnwD7qgeQI/1HNgtyxUR7nPHK+jX/yAWr/3PhwaBH/Gsl
	m4m1luvA==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64G-00000005BaD-2xP2;
	Tue, 08 Oct 2024 08:59:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] iomap: factor out a iomap_last_written_block helper
Date: Tue,  8 Oct 2024 10:59:12 +0200
Message-ID: <20241008085939.266014-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008085939.266014-1-hch@lst.de>
References: <20241008085939.266014-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out a pice of logic from iomap_file_buffered_write_punch_delalloc
that is useful for all iomap_end implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 13 ++-----------
 include/linux/iomap.h  | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 78ebd265f42594..b944d77a78c668 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1280,7 +1280,6 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-	unsigned int		blocksize = i_blocksize(inode);
 
 	if (iomap->type != IOMAP_DELALLOC)
 		return;
@@ -1289,16 +1288,8 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 	if (!(iomap->flags & IOMAP_F_NEW))
 		return;
 
-	/*
-	 * start_byte refers to the first unused block after a short write. If
-	 * nothing was written, round offset down to point at the first block in
-	 * the range.
-	 */
-	if (unlikely(!written))
-		start_byte = round_down(pos, blocksize);
-	else
-		start_byte = round_up(pos + written, blocksize);
-	end_byte = round_up(pos + length, blocksize);
+	start_byte = iomap_last_written_block(inode, pos, written);
+	end_byte = round_up(pos + length, i_blocksize(inode));
 
 	/* Nothing to do if we've written the entire delalloc extent */
 	if (start_byte >= end_byte)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae22..62253739dedcbe 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,6 +256,20 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+/*
+ * Return the file offset for the first unchanged block after a short write.
+ *
+ * If nothing was written, round @pos down to point at the first block in
+ * the range, else round up to include the partially written block.
+ */
+static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
+		ssize_t written)
+{
+	if (unlikely(!written))
+		return round_down(pos, i_blocksize(inode));
+	return round_up(pos + written, i_blocksize(inode));
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-- 
2.45.2


