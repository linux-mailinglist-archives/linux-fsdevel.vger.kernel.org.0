Return-Path: <linux-fsdevel+bounces-38722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2FA07017
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6256E3A6B22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99981215196;
	Thu,  9 Jan 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmfdCAZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DE215195;
	Thu,  9 Jan 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411492; cv=none; b=VfnOXGlhHlY4ObgoK8zLqmDQQ6HsExTe7mclSSTXA7RZHOyYz9G5gD6lrhstzL6U29nBTIeQDTdP/O8V2/uDH3OnBD4A+3Rp+vQOIp21yqcQGL8pJiPlEGIkk/qDJ099MuXEAxmog1DcMAAyPoFR0BW8IY83t5e8xO2eA3q0L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411492; c=relaxed/simple;
	bh=Tm55XrICoFFOZhOQCp/BhsCF/+rTgXD0KqX3WianO24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te8rbuzSlicEdxecYz8160FvlXa3ghLzLF30V8zl2Wd/yv/K4NKXO6W8sYaDbE/ZY2ZMG1tC5vMESlf7b9Yp822CamuM94acvJglnW7HwlW/LvGV8nliSq7UTeJ+gAdcifzCeunubdEIff5qs8h6dKHtvgmApHh6QBV5RgOoLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GmfdCAZ9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ckmGwDHmFUTHYT/M/bn57L+6bbayfUa1bCczep9VuZ4=; b=GmfdCAZ9RqRdm2muQPkTifnSh/
	iTExODn352C5Gzk9GEtKuMQ3oSx3DQEThD1ji5Ng0ae6yfO010OzjdL8DVSRRtOn7hWK+dFsUW7WA
	1C73N3JIezFR4+IYFoP/ztEdRbZsvK8oEr44yI2e4cGA1IsMnHZlJklub0JXoc6y5MWpnlS4Tj0Rl
	zMOjiJxgrGfc+eWXpi9Ac1Jg+qf6GL/tar/NMTypWGewPqXm5ziYgWQ+Bb+XnZIfniIfrbGcXhjxi
	fsx30FIOMGCFzxIj2C12oicRCwJV7INw3xxfFlKIRKsCcdJiQMuzx+FWwzhnlZOyX+UlC5LTiBZO2
	2YJi4Ssg==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnwu-0000000BBgk-2fFh;
	Thu, 09 Jan 2025 08:31:29 +0000
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
Subject: [PATCH 5/5] xfs: report larger dio alignment for COW inodes
Date: Thu,  9 Jan 2025 09:31:05 +0100
Message-ID: <20250109083109.1441561-6-hch@lst.de>
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

For I/O to reflinked blocks we always need to write an entire new file
system block, and the code enforces the file system block alignment for
the entire file if it has any reflinked blocks.  Mirror the larger
value reported in the statx in the dio_offset_align in the xfs-specific
XFS_IOC_DIOINFO ioctl for the same reason.

Don't bother adding a new field for the read alignment to this legacy
ioctl as all new users should use statx instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0789c18aaa18..f95103325318 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1204,7 +1204,16 @@ xfs_file_ioctl(
 		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 		struct dioattr		da;
 
-		da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
+		da.d_mem = target->bt_logical_sectorsize;
+
+		/*
+		 * See xfs_report_dioalign() for an explanation about why this
+		 * reports a value larger than the sector size for COW inodes.
+		 */
+		if (xfs_is_cow_inode(ip))
+			da.d_miniosz = xfs_inode_alloc_unitsize(ip);
+		else
+			da.d_miniosz = target->bt_logical_sectorsize;
 		da.d_maxiosz = INT_MAX & ~(da.d_miniosz - 1);
 
 		if (copy_to_user(arg, &da, sizeof(da)))
-- 
2.45.2


