Return-Path: <linux-fsdevel+bounces-28988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1616972869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E9A1F24B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29925157465;
	Tue, 10 Sep 2024 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRIx+7OX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359320314;
	Tue, 10 Sep 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943209; cv=none; b=NaYURNet69tyvbMzI8SK1X3W5BIm06lroDQV/Vk1fhWsngjIE6aYkZNVnoWHMkGHIKtrFh8C3iWM7SKJ/gE+AoMBDMhQVbVz9HnPP74w+YQpW+4Ppf4YePxcfn1AQjkBTaAvaGCnu5sdJdbgrB0DmjrQYS1ZV7MqoY+puiId0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943209; c=relaxed/simple;
	bh=oB/1fd8M+r3t2Zbeuvxacz6m3X6NY+XqH6Vyt9QgIEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkkjIptwkgHDqCTQ8aaz1Gp83rQhKyWUxo2jV69+r6IDDA3zoN4gfQDwjdbU28nY6M1s4d9T/gAISYiLlz88ZIVapuJxrCWWKaua3RDvMhkSgxID3USGw00HSzG5GluYAXkJCrrTIfYmsl/k1KgfUwJJmikrW40sA3HUhkkLpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rRIx+7OX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XLJKw25ZXuXWm5o+qVVpBlurmsLUI1zUegIrA4wy6YQ=; b=rRIx+7OXZpSvQNljgqxkLw6Bwj
	6QtzEv3pb9cvbVuClqAbZISAAkghwTIKjsXHZFgtqRFGPXsrGZbtt3u3MtHMqlBBZ9Cbwz4wVtvdT
	sdxtYdyxRDXdMpq2XrFngrzxpWgmQjWAMWaI+bnGHmT4WHwb5rK2z+R6BI93lzeiMVO8XH1P6Tqyx
	TRB/g/dbnVaKHIV0CugmaU5/CgYGOAwxxNQvzlr7Ly49r0kWi20bOAvhwUxjjqIEcgmwUPvER5ut9
	kzTlYILjZ+qIOCPsVOdcfLhSXMcImtNR4X9R6CpalfzBPpVx9NLA/5SzLLMF1j5tkDnOyMrqGK4Yx
	Mlf/YkrQ==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfe-00000004Ena-3hbF;
	Tue, 10 Sep 2024 04:40:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] iomap: pass flags to iomap_file_buffered_write_punch_delalloc
Date: Tue, 10 Sep 2024 07:39:05 +0300
Message-ID: <20240910043949.3481298-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To fix short write error handling, We'll need to figure out what operation
iomap_file_buffered_write_punch_delalloc is called for.  Pass the flags
argument on to it, and reorder the argument list to match that of
->iomap_end so that the compiler only has to add the new punch argument
to the end of it instead of reshuffling the registers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 11 +++++------
 fs/xfs/xfs_iomap.c     |  5 +++--
 include/linux/iomap.h  | 10 ++++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 737a005082e035..ac4666fede4c18 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,7 +23,6 @@
 
 #define IOEND_BATCH_SIZE	4096
 
-typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
  * Structure allocated for each folio to track per-block uptodate, dirty state
  * and I/O completions.
@@ -1199,8 +1198,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
  * the code to subtle off-by-one bugs....
  */
-static int iomap_write_delalloc_release(struct inode *inode,
-		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
+static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
+		loff_t end_byte, unsigned flags, iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1300,8 +1299,8 @@ static int iomap_write_delalloc_release(struct inode *inode,
  *         internal filesystem allocation lock
  */
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
-		struct iomap *iomap, loff_t pos, loff_t length,
-		ssize_t written, iomap_punch_t punch)
+		loff_t pos, loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
@@ -1329,7 +1328,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 	if (start_byte >= end_byte)
 		return 0;
 
-	return iomap_write_delalloc_release(inode, start_byte, end_byte,
+	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
 					punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 72c981e3dc9211..47b5c83588259e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1231,8 +1231,9 @@ xfs_buffered_write_iomap_end(
 	struct xfs_mount	*mp = XFS_M(inode->i_sb);
 	int			error;
 
-	error = iomap_file_buffered_write_punch_delalloc(inode, iomap, offset,
-			length, written, &xfs_buffered_write_delalloc_punch);
+	error = iomap_file_buffered_write_punch_delalloc(inode, offset, length,
+			written, flags, iomap,
+			&xfs_buffered_write_delalloc_punch);
 	if (error && !xfs_is_shutdown(mp)) {
 		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
 			__func__, XFS_I(inode)->i_ino);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d1e..83da37d64d1144 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -258,10 +258,6 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
-		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
-		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
-
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
@@ -277,6 +273,12 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
+
+typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
+int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, unsigned flag,
+		struct iomap *iomap, iomap_punch_t punch);
+
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len, const struct iomap_ops *ops);
 loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
-- 
2.45.2


