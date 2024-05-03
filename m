Return-Path: <linux-fsdevel+bounces-18589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D918B8BAA3A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5831F22BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA614F9CC;
	Fri,  3 May 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zmPDneZ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F814F9D5;
	Fri,  3 May 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730043; cv=none; b=j0u8NCjwGouQnZjQu2YXOQN9my7CSmILceVZlZKfyRcJEYs13Nf0z1RXuZcxZpcEWR7h49MuVHkeNa2cgu8g3CgSE/o92g9CJEyJR3n406Qfiqx3Mpocds3d77YpDgAmvZRbD8wEGJYa2tkg5HOqRKZO/b0hwJjahnyNGwQkBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730043; c=relaxed/simple;
	bh=ywnLOgNqTD1yV4HiB29ZO9Pm4yyxoKhdPWrUiIeVApQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmRfL4JRn2d6gNTZi/YkerVSKnoqGqb2bYaCIl35EoJUkiGed0j26sIyJqrG3mCfxqnOgMWhu7pNGKQcQ2nH37CV8TuOlbArwETSjWcb3+jBh7InfxcozG7XON3Y7PZ4xrzJQV91gKMTL6fQWHp0n73RT0GT4DEqMuaRjdI3Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zmPDneZ5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nRtRAstCK6XovsdzKMdtb1ZkfTlghtD3bCyykPEedow=; b=zmPDneZ5u8fBg/U/VAf8Y7kMBk
	fQGPvx0dr0ft+5FRbv17vC+ZfyDY57TML0UL79hvywkUDniQVm42l2NU77zPURlD7PLhUZwSMII6f
	oT8WI3l17HyIhiidVzG5MbYxHBIg1IO9TW97dY91khyxpxfGge6PYXZ5wRcmDxNocwnBofxjWGkGJ
	cdkPPx3tGWUb+f0BP6Zd8Z6UO5C/uidhgWvihvgQiUe+YBsvKchXmMh9IK8782IVekKoLzhla5IJ/
	YlGKXVfR7z0SDjI9IJ553dElW0MtF1thN2w8y13fwkPOCvSmXhjcsyZlu++C8Cc78J8JuuOA116uR
	ODRZgDaA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc3-0000000Fw3k-12zt;
	Fri, 03 May 2024 09:53:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 06/11] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Fri,  3 May 2024 02:53:48 -0700
Message-ID: <20240503095353.3798063-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. Cap the PTE range
to be created for the page cache up to the max allowed zero-fill file
end, which is aligned to the PAGE_SIZE.

An fstests test has been created to trigger this edge case [0].

[0] https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0c0cfbbd134..a727d8a4bac0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3574,7 +3574,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3598,6 +3598,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		folio_put(folio);
 		goto out;
 	}
+
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	do {
 		unsigned long end;
 
-- 
2.43.0


