Return-Path: <linux-fsdevel+bounces-37501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D619F350C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945E718864FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541F20127A;
	Mon, 16 Dec 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRspj2HJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A281B4124;
	Mon, 16 Dec 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364454; cv=none; b=TfrN2r+W000G/MN6/ZMJjEYvzW3iveSRctF+xCS/RI46ezg6PwD9vouGdlrqOa5856PjM8KEeneX6YbbiaOK5QVLfD3j5WpMpaLf8MzGeuJZjpM7OwheIS+zshord6ZHDFPAHG7m0qM6mnuC1BE6sbSQEYmZhnkCw2WiTJWHXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364454; c=relaxed/simple;
	bh=mdpQ1Rr6Q4/C6X6rpYbc+vmlgVo8HaKT44pMGF+PkNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZNDn7Z3FsP9GvymE+qVbRyiXlKOGtoGQCQ3/rU4/EjEvswWu40qN31VyHbKWFqhfcTEFt0aThVqS0rGTZfK3FzrF4rSJ90PbNQKUk/iBegG/7gzIfWFPAziL9YErsYiS5oG5TIJ0CYmV8/0VrCzX5mwwehY+2v+m3EmenMGkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QRspj2HJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rBBpd22PJzLLmPajy8p7zWHGVvG5LBG4Sj90qfpefx0=; b=QRspj2HJzQ59iy5Ci553SMSMuO
	OpXDIMj4ZSvlXoCYN03XnzN6ZFvokxsuE07B78w44YAdCG4uoQP7ne4uYQVtvJ6Fp0G+KH/MHLMSO
	r+WK18nJ4hPxUe34Xd3V0v2r60xi/SVkxxmoUec7Uztzmh2gZYsmXANof2/YTzIJz/kl4ispSox8d
	UVyk6ltKQrRQXBtak8bbmXoZsR22pyG3z4Nz6zMVkenVyxprmo2LWknrCbK155VRWNMKKDY5Lxtx1
	Zmxy20RDozu4q2jQnlHlFmK0nu7jdbAndAmNFX1PjXK8nOd87wrH56Z0/hGw1c15b+4RY6yzPV2ye
	PLjdJjqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDQA-000000002B3-0vvD;
	Mon, 16 Dec 2024 15:54:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] dax: Remove access to page->index
Date: Mon, 16 Dec 2024 15:53:55 +0000
Message-ID: <20241216155408.8102-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks like a complete mess (why are we setting page->index at page
fault time?), but I no longer care about DAX, and there's no reason to
let DAX hold us back from removing page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/dax/device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62bbee0..bc871a34b9cd 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -89,14 +89,13 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			ALIGN_DOWN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
+		struct folio *folio = pfn_folio(pfn_t_to_pfn(pfn) + i);
 
-		page = compound_head(page);
-		if (page->mapping)
+		if (folio->mapping)
 			continue;
 
-		page->mapping = filp->f_mapping;
-		page->index = pgoff + i;
+		folio->mapping = filp->f_mapping;
+		folio->index = pgoff + i;
 	}
 }
 
-- 
2.45.2


