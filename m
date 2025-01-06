Return-Path: <linux-fsdevel+bounces-38436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F380A028E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F861885455
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F890188A0D;
	Mon,  6 Jan 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPjKSrot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB814F9FD;
	Mon,  6 Jan 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176579; cv=none; b=MYi/KZyFJW3WJ+W66E67V/pNYhS73B6JpQmNSxObCokWrQ4Ogq+Ik0sO2Og+rdMc2bJCNsEyOWDSHtXWEx+VKbfnowuis/vuA6b40HGOZc9iDo6HblE4b0x0KQiWRSRJZ5ToS8aXNslwp866y77Dw8a46mcOCNBWzFyGD8sg1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176579; c=relaxed/simple;
	bh=800frk+QEZ9jXFWEBRQLfQfm8WWx+pV8NtYUXI2NK/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSRuYSqgJSZLKyPkW+8dhKugJ0JmymlMoG/m7gyewQvU/unP/JTOTZHt/5+kIGIMPG2DdbiFdTlK2s7RASbFks7cavdVWM6pNBxp7d3w8uJyz5QRbmV8CuY6RbleoR1ZmRFfm9nQzXn6a62T0WP+ICuu5sS2ku/nBuixLUdai08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OPjKSrot; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2a8fM/TVPyT+/NaXmoqfMwjUzmIC7BJD8ihQVJts44Y=; b=OPjKSrotetTWeOCnUfDQZQn9ny
	Y+Y6YCWjF8HqjCsLfHW5/ku9xu15wGpuEAVN4lxx7AFg0UqGkBBOTr6j4Aq7RKQoFjUMkPZLqjWQS
	yiHqebt2UFd8K9BoKjxWvBufcYWC8ZPb7xdzhAck44m52g02vQ+5M3ylyD5MbS800edniJBcZyFTO
	d5+Wakmm3DRLbvFGhnXpsRy+fZLQ81El0SxWgGg81goxG5egXLdzTUX54C6FduT3bzagQhEdAqdKH
	EcVi7jyIPcFJAoZyGDKc2vU64upMGq2Qcdnr8IzJrDnWLSeWCWOVJMcCai6yuBbUxjW2TyiRfOjrv
	Aqs2DO3g==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUopy-00000001isc-0pja;
	Mon, 06 Jan 2025 15:16:14 +0000
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
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/4] fs: reformat the statx definition
Date: Mon,  6 Jan 2025 16:15:54 +0100
Message-ID: <20250106151607.954940-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106151607.954940-1-hch@lst.de>
References: <20250106151607.954940-1-hch@lst.de>
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


