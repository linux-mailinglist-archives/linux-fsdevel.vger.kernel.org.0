Return-Path: <linux-fsdevel+bounces-59204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1699B3622A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D718865C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55345341AA6;
	Tue, 26 Aug 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H3G4vCiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9E321457
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213936; cv=none; b=lU+fEaYHz9d07Aub9brcVutlwMiLMu7ia0wd3pz36NovJqZKw6P1Hfi0F8hbnaaope4kPnLFAlATkotFFCbMLj2JJHgbH6BgQ6bzKIhhvRgreB484c/3GmOvn/n0YCSNEi4SLbmVoc1ELsDDgbfN9/6HJ7NlNn+l3D5omSA3TMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213936; c=relaxed/simple;
	bh=1sW4DcbUi6KWE0I38yz5y5+UAIrE8FKDRH2/+T09aCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=eLHzC3LFeaiiK5Yw1AlqXcCgHAaZ1sGKdFmbKGZULbgmgxvEHE94Z0Y2TwmhUXBAwyvBvQhgdwUFu9hGfKon1bN5RSlNe7fWdn6o9jH0O9NlmOToMAe9TFqr2WGd6Sn2mc0MohhaOAuBw8+yf6prGc7ukPkKs8csvDhgvSw5O4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H3G4vCiM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250826131211euoutp02478b9085a500a3cd8ca84faac0a4e561~fU0QhnJKx0240002400euoutp02q
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:12:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250826131211euoutp02478b9085a500a3cd8ca84faac0a4e561~fU0QhnJKx0240002400euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756213931;
	bh=ytSqwcHPS5KmoFqBJtl5DsyS758vO0cD13s/5MVs99w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=H3G4vCiMCg3qUNBmNNU341fG5gDMCNltVXV6hREPZRJXZSPIBP5D6WxK3QNyAHKwK
	 h5lfxvl0LWZxLl8pYq2AJp9Uy0b7yGOEpbfqYqDefoPEYDy72PcGrLIvdCvWzQTMnn
	 atiWfSbqWv2zs3TWL11vUvtSoSNCm71822iM0tcc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250826131210eucas1p21a27a684042f37080b7a19599f479b7a~fU0PynAJh2350723507eucas1p2T;
	Tue, 26 Aug 2025 13:12:10 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250826131210eusmtip29b9a21b0c58ecf0ce713cf25b4b45afc~fU0PXArTq0684106841eusmtip2S;
	Tue, 26 Aug 2025 13:12:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David
	Hildenbrand <david@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Joanne
	Koong <joannelkoong@gmail.com>
Subject: [PATCH] mm: fix lockdep issues in writeback handling
Date: Tue, 26 Aug 2025 15:09:48 +0200
Message-Id: <20250826130948.1038462-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250826131210eucas1p21a27a684042f37080b7a19599f479b7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250826131210eucas1p21a27a684042f37080b7a19599f479b7a
X-EPHeader: CA
X-CMS-RootMailID: 20250826131210eucas1p21a27a684042f37080b7a19599f479b7a
References: <CGME20250826131210eucas1p21a27a684042f37080b7a19599f479b7a@eucas1p2.samsung.com>

Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
Unfortunately it also moved some variable intialization out of guarded
scope in writeback handling, what triggers a true lockdep warning. Fix
this by moving initialization to the proper place.

Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/page-writeback.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 99e80bdb3084..3887ac2e6475 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2984,7 +2984,7 @@ bool __folio_end_writeback(struct folio *folio)
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
@@ -2992,6 +2992,7 @@ bool __folio_end_writeback(struct folio *folio)
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, -nr);
 		__wb_writeout_add(wb, nr);
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
@@ -3024,7 +3025,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 		bool on_wblist;
 
@@ -3035,6 +3036,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, nr);
 		if (!on_wblist) {
 			wb_inode_writeback_start(wb);
-- 
2.34.1


