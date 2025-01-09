Return-Path: <linux-fsdevel+bounces-38718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D726A0700A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2237A30A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E301215070;
	Thu,  9 Jan 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ycdrik+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEA215060;
	Thu,  9 Jan 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411480; cv=none; b=hog1W7pdhJQPeYIF1uLJCS6DfPe5W3q1kb9bdGWDmS/WsORc4pG0wilSOdgk8ycBEFebh51B8xHiJ6XlhVrCpKA4nCcb9tCsRIiDYx2toX7m6ORRjdYV0M7Lqjb2lOTr1PCc4tV+amcAgD++eRFitb7K21MVUIr4fRrRQtHgWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411480; c=relaxed/simple;
	bh=+oaa0rywqww60WTHK+nG2Wq2hiVt6mxJqcNtWyXDCvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc8W8XireS1DBx8KxUP7EN+IshWmUTMubcqRJh3oANHCULm8SuGC45oxvHq0fUuUJlCmSl6sZIxpi163YUswegWTeYaKh8ogWEsmZmq8elr8eHU8idvkDsP2mjkmWKFW08hxQTIyfLciXOpmES6ftc+ZUNE5TpVOqZ9hsvIKIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ycdrik+n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1Agbm7glbExWKNKxrQc6IjaFAs71f5tYsvIkWHOfhfs=; b=ycdrik+nb6xISCCA509tGorqKr
	Pu6OE5jODbIJA3v1F5xp1O0uaPaUaGB9FLYzmy8ihFAxPzYyihM6UcEWaSyjFLSHnovIO5uhgq67h
	NHppQmKa7oCpGxpNaSCQHbL+WBid9jARBukLmsdmsvSDCNpU8vVkxf4CMvSU96SZhFJXsE5eJDqAw
	UqvQ5d/aB9SHfReQ8N8oamASTCcElJjAqGD/su/m3NO8gw2PAyhiyTCg140ZfqqZu1hvEgG9pzroq
	vK8O6VIxrp1oIMWgyMtq7i8baOjN3BY5r6LqouuhmrpKT/cXDU4XASFSGBEjPy0p6XJPdNFoKo1xY
	4RGcMRhA==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnwi-0000000BBcz-2Y4v;
	Thu, 09 Jan 2025 08:31:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/5] fs: reformat the statx definition
Date: Thu,  9 Jan 2025 09:31:01 +0100
Message-ID: <20250109083109.1441561-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109083109.1441561-1-hch@lst.de>
References: <20250109083109.1441561-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The comments after the declaration are becoming rather unreadable with
long enough comments.  Move them into lines of their own.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/uapi/linux/stat.h | 95 +++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 887a25286441..8b35d7d511a2 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -98,43 +98,92 @@ struct statx_timestamp {
  */
 struct statx {
 	/* 0x00 */
-	__u32	stx_mask;	/* What results were written [uncond] */
-	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
-	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* What results were written [uncond] */
+	__u32	stx_mask;
+
+	/* Preferred general I/O size [uncond] */
+	__u32	stx_blksize;
+
+	/* Flags conveying information about the file [uncond] */
+	__u64	stx_attributes;
+
 	/* 0x10 */
-	__u32	stx_nlink;	/* Number of hard links */
-	__u32	stx_uid;	/* User ID of owner */
-	__u32	stx_gid;	/* Group ID of owner */
-	__u16	stx_mode;	/* File mode */
+	/* Number of hard links */
+	__u32	stx_nlink;
+
+	/* User ID of owner */
+	__u32	stx_uid;
+
+	/* Group ID of owner */
+	__u32	stx_gid;
+
+	/* File mode */
+	__u16	stx_mode;
 	__u16	__spare0[1];
+
 	/* 0x20 */
-	__u64	stx_ino;	/* Inode number */
-	__u64	stx_size;	/* File size */
-	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* Inode number */
+	__u64	stx_ino;
+
+	/* File size */
+	__u64	stx_size;
+
+	/* Number of 512-byte blocks allocated */
+	__u64	stx_blocks;
+
+	/* Mask to show what's supported in stx_attributes */
+	__u64	stx_attributes_mask;
+
 	/* 0x40 */
-	struct statx_timestamp	stx_atime;	/* Last access time */
-	struct statx_timestamp	stx_btime;	/* File creation time */
-	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
-	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* Last access time */
+	struct statx_timestamp	stx_atime;
+
+	/* File creation time */
+	struct statx_timestamp	stx_btime;
+
+	/* Last attribute change time */
+	struct statx_timestamp	stx_ctime;
+
+	/* Last data modification time */
+	struct statx_timestamp	stx_mtime;
+
 	/* 0x80 */
-	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_major;
 	__u32	stx_rdev_minor;
-	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+
+	/* ID of device containing file [uncond] */
+	__u32	stx_dev_major;
 	__u32	stx_dev_minor;
+
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
-	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+
+	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_mem_align;
+
+	/* File offset alignment for direct I/O */
+	__u32	stx_dio_offset_align;
+
 	/* 0xa0 */
-	__u64	stx_subvol;	/* Subvolume identifier */
-	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
-	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* Subvolume identifier */
+	__u64	stx_subvol;
+
+	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_min;
+
+	/* Max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;
+
 	/* 0xb0 */
-	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
+	/* Max atomic write segment count */
+	__u32   stx_atomic_write_segments_max;
+
 	__u32   __spare1[1];
+
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
+
 	/* 0x100 */
 };
 
-- 
2.45.2


