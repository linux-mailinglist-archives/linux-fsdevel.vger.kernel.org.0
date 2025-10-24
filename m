Return-Path: <linux-fsdevel+bounces-65424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C333C04F17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5278A1AE2A46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411EA3019A5;
	Fri, 24 Oct 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MidHAQ0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE292FD67C;
	Fri, 24 Oct 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293104; cv=none; b=JDbqiFoX6dDWnGxdbpPGy5k5Kl60D64C/TqbtJbaBsf4hncHl44p6S0DKRL98MzJtteniQQWheZ8oNZNBhOVatszEiTHOAj+QcMkBrcIV+Hu3HKO536z2T3VzCKTUwsmIUSoXH1OcyaGx0B/005mSf0W95sPasH6FsjnZfED6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293104; c=relaxed/simple;
	bh=UsLVnwkA+xWzyI8JEej0mi0ns/CU6rXOwcYq8zkYhrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV7s+9yB8+JQyRInlwGZISeRYrsJEXD6JL6SwiSLtaoJq1z3fTi3flGdAO+a82mQfkVXDZh+JVw/d8C36W9COCHr6Uo1wZfEBsA+0VklPklgT6uaNoTw5Uf9HOEEqcyvjHBZnEMc6qk21509NsRORZSZiRMcLYfZLngUlyvF9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MidHAQ0k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KHvBUxtcyVHjSYHDlnvJ4K1d0lqno9jHSlEtLibjOIA=; b=MidHAQ0kwxqlWDee9nUjX5/ncS
	/gU4JQOWSPMGAiFiG4yaffjRRz4MElW+Z2WYhMwXUVZWakiREcYe+ziH2B8X5Bvu2XQYQIaQQzbWV
	N0oWMwaWHyESKD7PyHomOsoOu8Guy7O65qijonMdiYnIXEedKnA+c9bYddZVHcIKmin5nHQeKLk/o
	edDFzGriSX5Pvxb4yJYL5rzOvMPTjTefiX0tXNO2lWVqdvU1hyciL/1qDgrgJ9Q+HV05qIN8ISqE7
	COsFc0cdNiZBzaigQNjXMS5B/ZUACtZbvri47/aoS80VVCs6ZOyP+fUSiPnv/2atttMGFOsL2sVoP
	rnAZBExA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCnC-00000008c3M-2cmC;
	Fri, 24 Oct 2025 08:04:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/10] 9p: don't opencode filemap_fdatawrite_range in v9fs_mmap_vm_close
Date: Fri, 24 Oct 2025 10:04:13 +0200
Message-ID: <20251024080431.324236-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024080431.324236-1-hch@lst.de>
References: <20251024080431.324236-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use filemap_fdatawrite_range instead of opencoding the logic using
filemap_fdatawrite_wbc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/9p/vfs_file.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index eb0b083da269..612a230bc012 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -483,24 +483,15 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 {
-	struct inode *inode;
-
-	struct writeback_control wbc = {
-		.nr_to_write = LONG_MAX,
-		.sync_mode = WB_SYNC_ALL,
-		.range_start = (loff_t)vma->vm_pgoff * PAGE_SIZE,
-		 /* absolute end, byte at end included */
-		.range_end = (loff_t)vma->vm_pgoff * PAGE_SIZE +
-			(vma->vm_end - vma->vm_start - 1),
-	};
-
 	if (!(vma->vm_flags & VM_SHARED))
 		return;
 
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
-	inode = file_inode(vma->vm_file);
-	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
+	filemap_fdatawrite_range(file_inode(vma->vm_file)->i_mapping,
+			(loff_t)vma->vm_pgoff * PAGE_SIZE,
+			(loff_t)vma->vm_pgoff * PAGE_SIZE +
+				(vma->vm_end - vma->vm_start - 1));
 }
 
 static const struct vm_operations_struct v9fs_mmap_file_vm_ops = {
-- 
2.47.3


