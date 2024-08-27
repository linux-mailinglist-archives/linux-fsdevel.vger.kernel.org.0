Return-Path: <linux-fsdevel+bounces-27293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DB9600DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848D31C20F53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633313D291;
	Tue, 27 Aug 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/EAmlQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842084C92;
	Tue, 27 Aug 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735440; cv=none; b=HlrvhFuN8FRtfjBUPC4JVosvd0LfcdVmQHgort3vX3i6XB+0k2ogHB+Km3qdUw78DceLQ/rIGjV7BhABDG72oxs3puh6kwDKGaV4D6csiHLyTXfPDLBpbfnZXe/sJgnLlIY/klFdUeqkr0qZf4X8Mbwzig9PfDAInYa7nmQQ5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735440; c=relaxed/simple;
	bh=HgkVjCYOp6RB0xH4meNv63whfmywnZDnSyIOk6WC2Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5UQI669Zwq1FWNpaJqX9oDb7gEKDu2iB11q71+Xy37i0b4/L8nEDhtO9aSUFd0SA+PZeqd3tjtVZGnw9rb8hl8lzWwIqeNqlafSx9tgwLE2vXNdIoVcNj0HFlpRxGxALgU4dCiVKnLZR+Klxoz6oZSHk2RM7GVlkyfP+cWH7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y/EAmlQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+IGes5uab/HGA649OFVPKw06M9EW8igKaugT6RJoGxc=; b=Y/EAmlQay/JzFNnUU1Qv7aR20e
	rzSEfQo/hGMCWpJ5DR/bIzRDMzrIEaX3GMntgIlmi2hB9bOEWB7JV4EGFjL86s47IiKF6oSUkffrD
	soKU2cfnOrOXIJzsW9GGapMcic0tlLH5ZveyxqVPd8U6fTGwLdnxIqGIGwM0WOWRexClCHR0L/K7h
	WoHl3K08uVZbmm01+aTeVQRxA3Ai0k2Uy012bbWA+RCAt4n9MO5wHvudUtwb7jEBF0o75orciIMQO
	MKQWihpKcMsyrHDcAYXgah4xcQBlWFP4Mq51u4IZOweIU/3gW1b8YPe0c1b5SYyALz17lB+QnkOJm
	+ef9Ni3w==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTV-00000009osa-2eJC;
	Tue, 27 Aug 2024 05:10:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] iomap: pass flags to iomap_file_buffered_write_punch_delalloc
Date: Tue, 27 Aug 2024 07:09:50 +0200
Message-ID: <20240827051028.1751933-4-hch@lst.de>
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

To fix short write error handling, We'll need to figure out what operation
iomap_file_buffered_write_punch_delalloc is called for.  Pass the flags
argument on to it, and reorder the argument list to match that of
->iomap_end so that the compiler only has to add the new punch argument
to the end of it instead of reshuffling the registers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c |  5 ++---
 fs/xfs/xfs_iomap.c     |  5 +++--
 include/linux/iomap.h  | 10 ++++++----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 737a005082e035..34de9f58794ad5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,7 +23,6 @@
 
 #define IOEND_BATCH_SIZE	4096
 
-typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
  * Structure allocated for each folio to track per-block uptodate, dirty state
  * and I/O completions.
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
2.43.0


