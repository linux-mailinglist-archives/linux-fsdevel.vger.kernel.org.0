Return-Path: <linux-fsdevel+bounces-17566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB428AFC52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF21C1F24375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F637171;
	Tue, 23 Apr 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p/a8joIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE062D7B8;
	Tue, 23 Apr 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912976; cv=none; b=oJrURXBdFUfOlGAZxTuirJckgSMKD7KvJK765I2wPYK9ZXTqSg4TtT2wyiNtHpfSWO39U3JawkTCXXL2FxKHOF/Mw5pWun3NISlkgVAGUVCFv5ziWPuQW2M3NQmZra8ZcLlInItdh5jCDNbAd7wyyOzc5zKiwmWi1Uhh04hGPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912976; c=relaxed/simple;
	bh=+hCzUl9kc0sFgtkRonxpDkcPqy2Ge9Y6/5LzUSSXFvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUPZRHPhPLKx+5vowSbOLhHo4rOjQ5OdpAnZ7cTC2Ih9xH5FtqShJgck2Yeg/Z26CYBfcb9Ov5L7XjR1vVeS8E/jQTSlyQd26jAmYQc0G/fYkEaZMadtk9d04b1692V6d31nENITKpTq74vTcbyJI5NQjOofZMqLnRCMUjSNFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p/a8joIL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NEsYsbU8qr0emUe6mxit/OuVTFvxbBfZCV5/pFcVA2w=; b=p/a8joILHo6OFpo2LhD6CykxRP
	WENvmFqHj0Ms3f2UKDAOSFJIen96AOJiItabSIxbfg/vMqH4dve5AA62QmtoQ748wuOlzizNjlL4v
	e/zDOTLlGiOzyDSauvcqu33bjQxTK2ZeUyy6PqvLrabr328y521cnxeM6BDh9iZ+s9TtErkhXew+z
	OlE6R3FkJueq/zlMKzBgdWdABtXTXqu/xN0aOtUuyE3D6tkefH6hr2EXw8kA4xvYiF6HC2uyxj/aj
	ukM0aTq63eh25mHnTS/tu5nyZN7C3c9ERJpH7Wgy6T/aPdNNYtvAGR8cnfSlANAxPuxsZxHnO/yht
	A2/G5ZJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6M-2eAw;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 5/6] userfault; Expand folio use in mfill_atomic_install_pte()
Date: Tue, 23 Apr 2024 23:55:36 +0100
Message-ID: <20240423225552.4113447-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call page_folio() a little earlier so we can use folio_mapping()
instead of page_mapping(), saving a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/userfaultfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d9dcc7d71a39..e6486923263c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -180,9 +180,9 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	pte_t _dst_pte, *dst_pte;
 	bool writable = dst_vma->vm_flags & VM_WRITE;
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
-	bool page_in_cache = page_mapping(page);
 	spinlock_t *ptl;
-	struct folio *folio;
+	struct folio *folio = page_folio(page);
+	bool page_in_cache = folio_mapping(folio);
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
@@ -212,7 +212,6 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	if (!pte_none_mostly(ptep_get(dst_pte)))
 		goto out_unlock;
 
-	folio = page_folio(page);
 	if (page_in_cache) {
 		/* Usually, cache pages are already added to LRU */
 		if (newly_allocated)
-- 
2.43.0


