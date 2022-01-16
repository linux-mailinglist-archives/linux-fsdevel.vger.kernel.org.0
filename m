Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB348FCA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiAPMSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiAPMS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F9C06161C;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N9+b+qRj01tgXtfzT98WhdYz3W5Hnc+VP1/gS5QLC2A=; b=VHAVkzo/Ow57u7iZ+eMc5A5UVU
        oK9KEC5BirQhQqk0WgFmvGP0cW5qPgAI3u0rTZUbWIKy4GReRWXhYE6qAF5YGsnFyTnVtTU1CPQvW
        sMuigGT1W6w172hqhpOrtb8RP3JqhazxOsbc3RLche6LofYifVwENLX67RLinReTxXLBM7ikaks+h
        tq6Cfd/XYn/7dsOOjdJwynyLFIm51cdaVFnOTT7+MuEly0ckH8fJg23pMHYWyMPXLanbVBX0X/W9v
        N8aDt/KVCxjTCp3t3UPcuL49tk+Sa1+0Pmz2Ue6hgH6TOXhl4GC12ky4FCFgnWyq2IX9dKqZvkosR
        0SMZC/YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UN-007FUp-2K; Sun, 16 Jan 2022 12:18:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/12] mm/filemap: Support VM_HUGEPAGE for file mappings
Date:   Sun, 16 Jan 2022 12:18:21 +0000
Message-Id: <20220116121822.1727633-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the VM_HUGEPAGE flag is set, attempt to allocate PMD-sized folios
during readahead, even if we have no history of readahead being
successful.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8f076f0fd94f..da190fc4e186 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2915,6 +2915,24 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/* Use the readahead code, even if readahead is disabled */
+	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
+		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
+		ra->size = HPAGE_PMD_NR;
+		/*
+		 * Fetch two PMD folios, so we get the chance to actually
+		 * readahead, unless we've been told not to.
+		 */
+		if (!(vmf->vma->vm_flags & VM_RAND_READ))
+			ra->size *= 2;
+		ra->async_size = HPAGE_PMD_NR;
+		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
+		return fpin;
+	}
+#endif
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-- 
2.34.1

