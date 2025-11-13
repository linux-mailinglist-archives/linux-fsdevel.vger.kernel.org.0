Return-Path: <linux-fsdevel+bounces-68288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C258C586D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73AD4353D60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B452EC09E;
	Thu, 13 Nov 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="L/kTzUJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A732E8B85;
	Thu, 13 Nov 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047214; cv=none; b=TqFKhLXo+N57FW75HJ1EBeFSsRlzEttC2j501jLTL2dMO1RyyXYvmP0Sdy9RU4LUffTMdg2uvXdR1gxlNXlR8ZjYRa3o8ZmottKnS9gQHRQTgOctPhOQ/+H9DBHJk0MGO0FiCCmDraf0e2I5KP6RDG69pXoeLa3YGaR28/kGwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047214; c=relaxed/simple;
	bh=yCTC8WfVAKzkmwDuVgHQOjKllFtOOs2xRctUuU7j9L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=giuZNU97l4aQxLSYe6DR90NLgAYYpBkStt/BpSZy/+5ikSRrv50Xwe1BniHNoABsfM489fHXbQGCI/1Z3SVWulw5ywKNEJ3SUXXpe85yFmPpk9fY2M8DR6cgCSGLrD3O6J/5k9AqGJy7Q1769m6Kv/R7EKc12gWV/i8NjiQj5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=L/kTzUJS; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A36791D47;
	Thu, 13 Nov 2025 15:16:47 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=L/kTzUJS;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 67DA02151;
	Thu, 13 Nov 2025 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763047209;
	bh=oRKtnj2z6SCYHP4wOp0m5s3QGCUzz8qn9uMXPqFR9fE=;
	h=From:To:CC:Subject:Date;
	b=L/kTzUJStve4HpHjeb2FhjFkS0naszqawAakilORvSF+XX1mPqSUYPLSccM+/TXwZ
	 AQDS8NFCYs/Ex4OkavnldCHYndqB6To0+fL338/MBKzhb9lVcpRg6wYpC902mFQzEy
	 brSu9856vIgt8giEIkHh4IhvTDfDxAjvNaqJKhl0=
Received: from localhost.localdomain (172.30.20.182) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Nov 2025 18:20:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: check minimum alignment for direct I/O
Date: Thu, 13 Nov 2025 16:19:58 +0100
Message-ID: <20251113151958.7626-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Add a check for minimum alignment when performing direct I/O reads. If the
file offset or user buffer is not aligned to the device's logical block
size, fall back to buffered I/O instead of continuing with unaligned direct I/O.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 10 ++++++++++
 fs/ntfs3/ntfs_fs.h |  1 +
 fs/ntfs3/super.c   |  1 +
 3 files changed, 12 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b9484f48db34..3b22c7375616 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -941,6 +941,16 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		file->f_ra.ra_pages = 0;
 	}
 
+	/* Check minimum alignment for dio. */
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct super_block *sb = inode->i_sb;
+		struct ntfs_sb_info *sbi = sb->s_fs_info;
+		if ((iocb->ki_pos | iov_iter_alignment(iter)) &
+		    sbi->bdev_blocksize_mask) {
+			iocb->ki_flags &= ~IOCB_DIRECT;
+		}
+	}
+
 	return generic_file_read_iter(iocb, iter);
 }
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8ff49c5a2973..a4559c9f64e6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -212,6 +212,7 @@ struct ntfs_sb_info {
 
 	u32 discard_granularity;
 	u64 discard_granularity_mask_inv; // ~(discard_granularity_mask_inv-1)
+	u32 bdev_blocksize_mask; // bdev_logical_block_size(bdev) - 1;
 
 	u32 cluster_size; // bytes per cluster
 	u32 cluster_mask; // == cluster_size - 1
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 96f56333cf99..f481e9df0237 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1075,6 +1075,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		dev_size += sector_size - 1;
 	}
 
+	sbi->bdev_blocksize_mask = max(boot_sector_size, sector_size) - 1;
 	sbi->mft.lbo = mlcn << cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << cluster_bits;
 
-- 
2.43.0


