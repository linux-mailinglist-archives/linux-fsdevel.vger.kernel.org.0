Return-Path: <linux-fsdevel+bounces-66188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA20C18A72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C1188B42A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5E2EAB6E;
	Wed, 29 Oct 2025 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hh9owbaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BBD30F951;
	Wed, 29 Oct 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722150; cv=none; b=khacXESLBhN1PtyHlmyUSA2pWJMzVB3XusjcdYnSDKwD4KB+HJgqIh9maJA8rmIqTJrweY9vFpGkPKuVEkv7ZafxEUEJ/zgf1cIifEh6owYtABVVrE6WGMUmwtUv61NLUsuOKCRAG1nH4yqNdYdQyrNLuKxhZfp/HM4YQLakSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722150; c=relaxed/simple;
	bh=Ng7KG2Hp8JMk/T8D9WOp8V8/EWIoqASSxvc/wV1XLiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJkmCoSgUqNHrdvMTPPCEXvjIIL1WTbzCBAJasfi9lUZnWqPSDQIRRgYO9R+uJOJaaEM0kO7RaQmBeD/jWj6xy8SziVMdbMnLwyMAXlK2QdtNim/AhPCJdH0L4wqS0UxlQsIhueLnDJd5Hlcn3seGreaHkuXzd3albjuY05Km/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hh9owbaY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lNi3fBgwwAeRxNOu1AjQD5FUJJNzaIccOYaY72wa/gM=; b=hh9owbaYZDJPFVycD8Mf+zjNwd
	YYEmNH4zXIom+d9No+UfcX+z3UDVCiqZUZdGs8FDlBPw8UCjmxww/NoV6NkhdwB4kxJ9rinSY+jnC
	gl7AvUarR9buPVzz9ySLpNhOSd/EUnC7q93cB9JpJl/WXQFy3jiFMcMUFpKnxfYtDObtEcysbV3I0
	8RfPO0yG5frCsbERCIzIpK6fXAGuahlnNkNCxGQM2k9ZcJ3auFuUjfeYm2a9EXkkYvyUX8A/tCz/4
	YoOMd6SAfcRdbj925s50uKwdFoQzF/IK+aoZDHXS8tG3rmEKhWGxWJTj3W7CITp5QOWSBCABebfew
	a+ykoZXQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0PL-000000002T0-1E4X;
	Wed, 29 Oct 2025 07:15:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] fs: replace FOP_DIO_PARALLEL_WRITE with a fmode bits
Date: Wed, 29 Oct 2025 08:15:02 +0100
Message-ID: <20251029071537.1127397-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To properly handle the direct to buffered I/O fallback for devices that
require stable writes, we need to be able to set the DIO_PARALLEL_WRITE
on a per-file basis and no statically for a given file_operations
instance.

This effectively reverts a part of 210a03c9d51a ("fs: claw back a few
FMODE_* bits").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/file.c      | 2 +-
 fs/xfs/xfs_file.c   | 4 ++--
 include/linux/fs.h  | 7 ++-----
 io_uring/io_uring.c | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..b484e98b9c78 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -924,6 +924,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	filp->f_mode |= FMODE_DIO_PARALLEL_WRITE;
 	return dquot_file_open(inode, filp);
 }
 
@@ -978,7 +979,6 @@ const struct file_operations ext4_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_DIO_PARALLEL_WRITE |
 			  FOP_DONTCACHE,
 };
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90c..5703b6681b1d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1553,6 +1553,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
 	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
@@ -1951,8 +1952,7 @@ const struct file_operations xfs_file_operations = {
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
-			  FOP_DONTCACHE,
+			  FOP_BUFFER_WASYNC | FOP_DONTCACHE,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..09b47effc55e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -128,9 +128,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_WRITE_RESTRICTED	((__force fmode_t)(1 << 6))
 /* File supports atomic writes */
 #define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)(1 << 7))
-
-/* FMODE_* bit 8 */
-
+/* Supports non-exclusive O_DIRECT writes from multiple threads */
+#define FMODE_DIO_PARALLEL_WRITE ((__force fmode_t)(1 << 8))
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
 /* 64bit hashes as llseek() offset (for directories) */
@@ -2317,8 +2316,6 @@ struct file_operations {
 #define FOP_BUFFER_WASYNC	((__force fop_flags_t)(1 << 1))
 /* Supports synchronous page faults for mappings */
 #define FOP_MMAP_SYNC		((__force fop_flags_t)(1 << 2))
-/* Supports non-exclusive O_DIRECT writes from multiple threads */
-#define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
 /* Contains huge pages */
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 296667ba712c..668937da27e8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -469,7 +469,7 @@ static void io_prep_async_work(struct io_kiocb *req)
 
 		/* don't serialize this request if the fs doesn't need it */
 		if (should_hash && (req->file->f_flags & O_DIRECT) &&
-		    (req->file->f_op->fop_flags & FOP_DIO_PARALLEL_WRITE))
+		    (req->file->f_mode & FMODE_DIO_PARALLEL_WRITE))
 			should_hash = false;
 		if (should_hash || (ctx->flags & IORING_SETUP_IOPOLL))
 			io_wq_hash_work(&req->work, file_inode(req->file));
-- 
2.47.3


