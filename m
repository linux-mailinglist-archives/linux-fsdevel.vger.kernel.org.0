Return-Path: <linux-fsdevel+bounces-38439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B463A028EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F007A1FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABD15252D;
	Mon,  6 Jan 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PH9Z9vvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7716D9B8;
	Mon,  6 Jan 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176599; cv=none; b=KKrPyoJ+NsKpoAfkdZgeK82LdaKv4CjmX8Xn/AGJlUF5X9m+u1vLrfQ26UTvW1TpoDT1bgeoR4l4CpJSlRBceJdss/zRWpBf+quVfUJ0hrZF9N4Ye8qZcZbqzaheQ4RygaDpeMzEd25HYv1w2y43gk+5eHgjswIr09ch/19jY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176599; c=relaxed/simple;
	bh=9jbJmXOqJqQTZp56VRpFUa5S4tx84EJ6zWh7gF7RNhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwiw3R9wwMfwtT32fsQFvCxQ4EYJzj223g5jCs6a/GMe9rBnDydjvy0FCY/NbqpRMqZIzKaaqmI/I547jDcs891noDDHrZPpeKQksElCNPMfViupiZvGFaqWrickyHaCqfrel2FsFUsRvIVFLFqD/UPyrtLFszxCf9jQlcFqgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PH9Z9vvT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VOJ+r0WkA3fniEtlAqXYOsR+c6ifnitiklPTC0M6NN0=; b=PH9Z9vvT6puoq/IHE3Ta55S8j0
	Of1ZQrqctMkUxWkWUb8BtweacK/C0FS+NS7WPcKKVJBZ1OmMp4KFf/ZXI/o319FOCU5suhxnOptuI
	CZl1mFNwXli3caGvTTnmZq1dqWRwWR/5kmFB8GY9O4HwD8eNkgdAxj6xj5Pp1qJfh1cI7QWexOaQs
	fodDOZje8CS+TBXasv5JhV3MB4oUSBOeItxmbGCJ7qmEachtM1gvO4xELPfhSq2EnQ+OK66IIzzEE
	75HIBK1jXQb2ALyd/WTt1eyQEB2mxexxBILNInPmUtw4Old6jqzqSStj7bJOpNMsYabiEembz4Q/v
	qrfFaWyw==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoq5-00000001itK-3hl0;
	Mon, 06 Jan 2025 15:16:22 +0000
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
Subject: [PATCH 4/4] xfs: report the correct read/write dio alignment for reflinked inodes
Date: Mon,  6 Jan 2025 16:15:57 +0100
Message-ID: <20250106151607.954940-5-hch@lst.de>
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

For I/O to reflinked blocks we always need to write an entire new
file system block, and the code enforces the file system block alignment
for the entire file if it has any reflinked blocks.

Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
vs write alignments for reflinked files.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iops.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6b0228a21617..053d05f5567d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -580,9 +580,27 @@ xfs_report_dioalign(
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct block_device	*bdev = target->bt_bdev;
 
-	stat->result_mask |= STATX_DIOALIGN;
+	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
 	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
+	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
+
+	/*
+	 * On COW inodes we are forced to always rewrite an entire file system
+	 * block or RT extent.
+	 *
+	 * Because applications assume they can do sector sized direct writes
+	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
+	 * case.  Because that needs to copy the entire block into the buffer
+	 * cache it is highly inefficient and can easily lead to page cache
+	 * invalidation races.
+	 *
+	 * Tell applications to avoid this case by reporting the natively
+	 * supported direct I/O read alignment.
+	 */
+	if (xfs_is_cow_inode(ip))
+		stat->dio_offset_align = xfs_inode_alloc_unitsize(ip);
+	else
+		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
 static void
@@ -658,7 +676,7 @@ xfs_vn_getattr(
 		stat->rdev = inode->i_rdev;
 		break;
 	case S_IFREG:
-		if (request_mask & STATX_DIOALIGN)
+		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
 			xfs_report_dioalign(ip, stat);
 		if (request_mask & STATX_WRITE_ATOMIC)
 			xfs_report_atomic_write(ip, stat);
-- 
2.45.2


