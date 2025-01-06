Return-Path: <linux-fsdevel+bounces-38437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB6A028E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477F23A4EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5668632D;
	Mon,  6 Jan 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3C8axgp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10438158A1F;
	Mon,  6 Jan 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176581; cv=none; b=I9inAIHi/PfEL4fHtUNGZBJk8rsDydIPi+Ethbolz4LxvdIDsQyba19f74vLlNSG6Mmrc0NrUsf3DYuEr6Ou0MXBBoW0c0K4EqIVpwfZ4FvAn7NmHYl5mgVHCZ/Isc6vV3IlZecBBKl6vIoKClP7Sk5YojPRVpgqKiA2JQD9hVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176581; c=relaxed/simple;
	bh=+WMZLvDhh299eRkP4WS/nYon0ArmuALtnhr5e7MjJqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DburogRWhltjOy9ZjaM0QSHrqylPYYsCe7VaZ+pqs7LP9NiUVHoJpLM7/S28bCU/B+yek59ILaJNajyN2wB1HfxCLf2t8tFOU+5rySQcnvfKIyRHhxWRoD5FGgqhH6hZSRFtdJfasH8yquKOAxImuaFhVu7OAe7hS0Ch8F60SOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3C8axgp+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sHEnV49pcd7oeH/sU+i0NL6e/N4lHchwElAj+faTm2w=; b=3C8axgp+4mpWATE++e6FPj/m0H
	6ePB++jTW5ut+qqad175Fy3KfC9uxXxv+f2SmMugRAbgFVMW/jR5HCvPQ2xm5DkY69hHnrEhJjJ4D
	5hwku0BlbQ8z5L5unsi7InYwHEZf2sAziBa4aR+sRcbAtXYH55UHD0wrOMMwbwYeNiSxWCohjWkBd
	N2uKwaU9Dz7b1a/OLkIebzMD3NVfKHDQayP0nwW0CNw8w8ygOfuInp08B17BUdAOpPPJ7XYUF+zEt
	1zjQEc5zpm4zlivLs6nB+fyllF8aMpvxNLKMQBr0ZC4R3byzouzU/ddoR3LBW3pkwJ03HFqJ40G17
	gn/QWZ3Q==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoq0-00000001isp-2vnx;
	Mon, 06 Jan 2025 15:16:17 +0000
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
Subject: [PATCH 2/4] fs: add STATX_DIO_READ_ALIGN
Date: Mon,  6 Jan 2025 16:15:55 +0100
Message-ID: <20250106151607.954940-3-hch@lst.de>
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

Add a separate dio read align field, as many out of place write
file systems can easily do reads aligned to the device sector size,
but require bigger alignment for writes.

This is usually papered over by falling back to buffered I/O for smaller
writes and doing read-modify-write cycles, but performance for this
sucks, so applications benefit from knowing the actual write alignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0..2c0e111a098a 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -725,6 +725,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
 	tmp.stx_subvol = stat->subvol;
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c..9d8382e23a9c 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -52,6 +52,7 @@ struct kstat {
 	u64		mnt_id;
 	u32		dio_mem_align;
 	u32		dio_offset_align;
+	u32		dio_read_offset_align;
 	u64		change_cookie;
 	u64		subvol;
 	u32		atomic_write_unit_min;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 8b35d7d511a2..f78ee3670dd5 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -179,7 +179,8 @@ struct statx {
 	/* Max atomic write segment count */
 	__u32   stx_atomic_write_segments_max;
 
-	__u32   __spare1[1];
+	/* File offset alignment for direct I/O reads */
+	__u32	stx_dio_read_offset_align;
 
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
@@ -213,6 +214,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.45.2


