Return-Path: <linux-fsdevel+bounces-63884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCDBD1454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6123B1894D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDA2F1FC8;
	Mon, 13 Oct 2025 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pgQEnUky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC81F5423;
	Mon, 13 Oct 2025 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324314; cv=none; b=Ir3EbtB3eGpc9Fq4dVAdSNZIb0KujzXYJrfZ/46+Qjw+sE5w+h4DB3CfnoOWjd9Kg/xJ9E2Juudu8HpxxmDldk/YQpNmsVHmPEmZLdRqtcIy+oZoH2dvoEO7RKzYH0/NJgtRnaXueYWH8C3i7RPzbChqWhGg9rv44Ks1aGu7uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324314; c=relaxed/simple;
	bh=QZ7Hd42Z15nuNzOT8yDt6lAQGlOAzAPTFPVL5i0G+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liEOHfU4FSt/sAbIiK+q77PwAn599e7ikz57HAPWyS1ujuGH5RKc7b/TAk/MjGUld5wTZdGi8VQYPIwn2RyBXprvOudMWinXxDiNJKvSA/pxkYMHDiW2YFZ1QDdnCEmX4gHpeQkhdiOLVUlZnQ6SFsl4ooifo4bfQohf7sooaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pgQEnUky; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lj0S3vmb6d6s8d0aaOlI5MPqL6b+xgrnGX6hOqz1wwY=; b=pgQEnUky4Ql91uLX3wxEvBkqfg
	Y5kAKuNYys7DA+Bdzoel/fuaJiYGe+yhJC40tdLtCmysJJmXsjU7NWrXctWPSuOKQd2KVl8e2cKNf
	vfKkVLHEa4wyUGUZ3BwaGLIy79HIiReJSvlaIdamBqQYFc/m+FOjw4daFqRcvHHYFc/nIXvJrCsJZ
	R5ftvFBbGFHhDVk6Z+T7I0h/7k4zlDlbVmAwuMtgIiixL8gp97UMYAnraPIxl5BBu85JDsneKe5qz
	xqCiWkuFZudZ97TBpTgw80q4gaZ425/EZZPUU92LFfnQu6Y0AeErFsIsOrun2fhPEWl9YnV6Y1Uu2
	A17JVs6w==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88lZ-0000000C86m-3JLa;
	Mon, 13 Oct 2025 02:58:30 +0000
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
	linux-mm@kvack.org
Subject: [PATCH 02/10] 9p: don't opencode filemap_fdatawrite_range in v9fs_mmap_vm_close
Date: Mon, 13 Oct 2025 11:57:57 +0900
Message-ID: <20251013025808.4111128-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
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


