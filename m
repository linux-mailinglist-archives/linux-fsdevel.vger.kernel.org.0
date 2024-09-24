Return-Path: <linux-fsdevel+bounces-29936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F3983F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD2A1F2398E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC914BF8F;
	Tue, 24 Sep 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v/H5oFxs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924714A4DC;
	Tue, 24 Sep 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163685; cv=none; b=B6EfpMJX4k/rkaCcXWdp+5+DlGx3zVOQT6CvPFrG7E+Z/no0GDgWk6X/hiVbGICpplmIXR+4csKz8BGfA9KMsE5tY+ENG9qzc6BppqQPt8xErtS4gKl+99IOoRQ041PV+OBsa40KD9UeUppOuxRElSpb68BrQ/DC039Q8biOLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163685; c=relaxed/simple;
	bh=QdTfzr7+jI79irwZVd3XFgSAH/bYrYFsD1r4F9MgmAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh8zcO4vg+BigAggia/MQ0LrG2gep7II0cBI3aV49N+V4t2EOe2sRQL2V7PADIwVaGoXTG4gJErQayJW1GwIH+NTf0dk9H2qYUrZEd1pUGdcI8pQTUHsFooLVblv4+65aQkAGB7rBFBeVG3D2exw32/8aDSKhPIDdlROqQpu0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v/H5oFxs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=up31ahDxat1SKY5qQH6eThzNHFP9FnIFJl22bu3tHJs=; b=v/H5oFxs7cHTlsJgCLvlrVtJcB
	atas+IqjeBaf/twOz64qfSbWmJoplMlIVkJPevEWZoRn+zy1x3L3OOUj6zWLbmq79UGy1SU/ry7Rt
	WVjqmcIaLE2MA9iJ8yWHIGpU98VT2xrD1mBVRpGE5SfaCqb0febESTqLEt0J6WWDAqO4GvFRDrgsb
	aXV4rRv8btVAVdQhYcfA+9384MCq+NzAx5wWhbksrZJrx6Ph74JJS6YQX3f7Zd5inBi2pwbaNaXuu
	/NqekzIzgCT3O4sivnFf907ry89pIECPuKbbN077kSfEvJ1wXSBgMaMxP70ZTSPAuM2hcl+EB9rJD
	yVF40JpQ==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0Ak-00000001SI3-2rbg;
	Tue, 24 Sep 2024 07:41:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] iomap: factor out a iomap_last_written_block helper
Date: Tue, 24 Sep 2024 09:40:43 +0200
Message-ID: <20240924074115.1797231-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 13 ++-----------
 include/linux/iomap.h  | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 11ea747228aeec..884891ac7a226c 100644
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


