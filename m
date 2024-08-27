Return-Path: <linux-fsdevel+bounces-27295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF909600E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5401C208BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD621422D4;
	Tue, 27 Aug 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvB0BxP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF213CFB8;
	Tue, 27 Aug 2024 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735444; cv=none; b=YzLcuwb4zFfWRDDLQTJHhcKztcCKbxbtBiz5AjwVSbyCrHqtbI6QhCHs5NRFwvgyNqzSzdyjKfG+p2bvJMrnKQ0XV4u2mPySvKs2AwRlvMlLvymI3ZYNkDEoBdOFbp5osj3OqBzWvbc7Xm65A0jjmccYFwAbD1zwXeZJTmQ0rAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735444; c=relaxed/simple;
	bh=V1tuzOdFA8CG+9TSbvijsTSszErBnuoS7PX3v9XGz0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9Yx/6eQrB9ih/22LMEBzX9mipuWtVByHm4JSRxQU2EuH8zYSUfxscQYGB3wJ439LLKsDrIFNVOvKzgTJfgxnfQ0jK16RibU+3XQCuK2n9PzpaDU4z6nH1jjy9YKt2SBGuQrmtdAU+2qYTp5Me4DdzZotbxtGUMtPBDpLSS14Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SvB0BxP7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7swhIGC5iHUphtQcgqwFTgMPkCW9WVcGPPA83hxeOME=; b=SvB0BxP77evcD1llTpd65gXiTC
	x944nDbKZEruF0sbI/8QT4BxhIy77YzOPJ5W0YusbR5EEF0bNeXF2DMDOjCw+YYFHb3MnoaIxsKL7
	P9ijpjeERIfYBF7kQsDKcD21cQyyrS/AYxEWbej0DcLhUGehN3VN038rGikIXHuR9tWK/npxvssF0
	rvXJaa/eqz2guG+Z2eF9VepuejzeJnnGhxgDaK1Eesp2vhx45z1XwB/ngg1BzmGHQ5qQeODyntLnV
	WQZ3eEPO1Jv5I7ULvuyN4Dgo+i0BPFy95k9zmuV7f/XpwNr5cQ5sS9JQXQq7mfzGk8TpE8xWBwpvC
	mlTPUcwg==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTa-00000009ou3-1wAw;
	Tue, 27 Aug 2024 05:10:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] iomap: pass the iomap to the punch callback
Date: Tue, 27 Aug 2024 07:09:52 +0200
Message-ID: <20240827051028.1751933-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827051028.1751933-1-hch@lst.de>
References: <20240827051028.1751933-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

XFS will need to look at the flags in the iomap structure, so pass it
down all the way to the callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 25 +++++++++++++------------
 fs/xfs/xfs_iomap.c     |  3 ++-
 include/linux/iomap.h  |  3 ++-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 574ca413516443..7950cbecb78c22 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1047,7 +1047,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	unsigned int first_blk, last_blk, i;
 	loff_t last_byte;
@@ -1072,7 +1072,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 	for (i = first_blk; i <= last_blk; i++) {
 		if (!ifs_block_is_dirty(folio, ifs, i)) {
 			ret = punch(inode, folio_pos(folio) + (i << blkbits),
-				    1 << blkbits);
+				    1 << blkbits, iomap);
 			if (ret)
 				return ret;
 		}
@@ -1084,7 +1084,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 
 static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	int ret = 0;
 
@@ -1094,14 +1094,14 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 	/* if dirty, punch up to offset */
 	if (start_byte > *punch_start_byte) {
 		ret = punch(inode, *punch_start_byte,
-				start_byte - *punch_start_byte);
+				start_byte - *punch_start_byte, iomap);
 		if (ret)
 			return ret;
 	}
 
 	/* Punch non-dirty blocks within folio */
-	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte,
-			end_byte, punch);
+	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
+			iomap, punch);
 	if (ret)
 		return ret;
 
@@ -1134,7 +1134,7 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
  */
 static int iomap_write_delalloc_scan(struct inode *inode,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
@@ -1150,7 +1150,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		}
 
 		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
-						 start_byte, end_byte, punch);
+				start_byte, end_byte, iomap, punch);
 		if (ret) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -1199,7 +1199,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * the code to subtle off-by-one bugs....
  */
 static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
-		loff_t end_byte, unsigned flags, iomap_punch_t punch)
+		loff_t end_byte, unsigned flags, struct iomap *iomap,
+		iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1257,7 +1258,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-				start_byte, data_end, punch);
+				start_byte, data_end, iomap, punch);
 		if (error)
 			goto out_unlock;
 
@@ -1267,7 +1268,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 
 	if (punch_start_byte < end_byte)
 		error = punch(inode, punch_start_byte,
-				end_byte - punch_start_byte);
+				end_byte - punch_start_byte, iomap);
 out_unlock:
 	if (!(flags & IOMAP_ZERO))
 		filemap_invalidate_unlock(inode->i_mapping);
@@ -1335,7 +1336,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		return 0;
 
 	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
-					punch);
+					iomap, punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 47b5c83588259e..695e5bee776f94 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1212,7 +1212,8 @@ static int
 xfs_buffered_write_delalloc_punch(
 	struct inode		*inode,
 	loff_t			offset,
-	loff_t			length)
+	loff_t			length,
+	struct iomap		*iomap)
 {
 	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
 	return 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 83da37d64d1144..a931190f6d858b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -274,7 +274,8 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 
-typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
+typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
+		struct iomap *iomap);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
 		loff_t length, ssize_t written, unsigned flag,
 		struct iomap *iomap, iomap_punch_t punch);
-- 
2.43.0


