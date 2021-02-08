Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8873142BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBHWTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 17:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhBHWTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:19:17 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68BC061788
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 14:18:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b145so10626455pfb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/11CO3rYWuI/f/YHyMz9MjwWlbtuyR7jns8drX5Z6GM=;
        b=mb2oFeIEVgDEViUTWxQhJRn8gyfghyhp/ElayDIuXqgeaBC3HYBqXz/VyGWRwyfxyX
         xNOVUOTlqZOiwoPZvGkawIKvPSdaiRywSD983pANIibOlTA45T3D/u9hBzhvPIaon/tU
         WBt2X4roLHiAAxx56l/gFiUa/HQcYyqIS4SHHtGj51uM/gYRzdJCOrOubTCc7icgPz/e
         TBPf1d33DE2Lp+z5ek0LEGD8l0kYthWmJBknCrZPLXoi744YaRuxo52NTOvbjN+Hl6oI
         shdmBniDyS8xzu99iHg+R7lPS9r9fejFakjX/txkrDqm21gvQbo2V0UeFU7OjW3KBDZA
         ushw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/11CO3rYWuI/f/YHyMz9MjwWlbtuyR7jns8drX5Z6GM=;
        b=WWEuHCrVGIuJnoXaH8kSHyZWql78yaHqc3OQmSfZAOz6X/EW3e62jRFXNcWFP4a/nW
         6G1OlfI8toA8LIiq+A9mrcsqW/VKKSNfVkmgWhZbSCubL376M+ujPtNRKk7RAbdHoanj
         AKSPE22lVAf4oJpneL6VwVSPYKT9tVdGEDGA1JiYEb0e1hyYUH1voDSyKbGf3GKJIHz3
         ldhXnu8F2YtBv/INmn9aKPjUoY0mkOzYfHfsGVxoR7gcT9E7H+XPBWiMYI0BxXoTaAIu
         GTysXcWaeWo8XA+ZrD6CrNsAuPUcXdjhV82Q7QAPMkc4CpT+m+lIdMaH2r8btHEwyMMk
         L1SQ==
X-Gm-Message-State: AOAM530TZelSiXjGODz8PbxAU7Baysxz8oNSaqUbnQmhav0kOFfGNZ5n
        5ypj44da6qeAknJD+vC/jdQxJVP7LhOlrQ==
X-Google-Smtp-Source: ABdhPJzusnHUSOjH31Tu9aj2qgCr38CSB6bRtXmJ7daXvBLWnpK3G1cjMgphD7zjBJsZ8VTZxUZ39g==
X-Received: by 2002:a63:416:: with SMTP id 22mr18850742pge.286.1612822716935;
        Mon, 08 Feb 2021 14:18:36 -0800 (PST)
Received: from localhost.localdomain ([2600:380:4a36:d38a:f60:a5d4:5474:9bbc])
        by smtp.gmail.com with ESMTPSA id o10sm19324472pfp.87.2021.02.08.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:18:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Date:   Mon,  8 Feb 2021 15:18:27 -0700
Message-Id: <20210208221829.17247-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208221829.17247-1-axboe@kernel.dk>
References: <20210208221829.17247-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For O_DIRECT reads/writes, we check if we need to issue a call to
filemap_write_and_wait_range() to issue and/or wait for writeback for any
page in the given range. The existing mechanism just checks for a page in
the range, which is suboptimal for IOCB_NOWAIT as we'll fallback to the
slow path (and needing retry) if there's just a clean page cache page in
the range.

Provide filemap_range_needs_writeback() which tries a little harder to
check if we actually need to issue and/or wait for writeback in the
range.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..def89222dfe9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2633,6 +2633,8 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 
 extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
 				  loff_t lend);
+extern bool filemap_range_needs_writeback(struct address_space *,
+					  loff_t lstart, loff_t lend);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
 extern int __filemap_fdatawrite_range(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index aa0e0fb04670..1ed7acac8a1b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -633,6 +633,52 @@ static bool mapping_needs_writeback(struct address_space *mapping)
 	return mapping->nrpages;
 }
 
+/**
+ * filemap_range_needs_writeback - check if range potentially needs writeback
+ * @mapping:           address space within which to check
+ * @start_byte:        offset in bytes where the range starts
+ * @end_byte:          offset in bytes where the range ends (inclusive)
+ *
+ * Find at least one page in the range supplied, usually used to check if
+ * direct writing in this range will trigger a writeback. Used by O_DIRECT
+ * read/write with IOCB_NOWAIT, to see if the caller needs to do
+ * filemap_write_and_wait_range() before proceeding.
+ *
+ * Return: %true if the caller should do filemap_write_and_wait_range() before
+ * doing O_DIRECT to a page in this range, %false otherwise.
+ */
+bool filemap_range_needs_writeback(struct address_space *mapping,
+				   loff_t start_byte, loff_t end_byte)
+{
+	struct page *page = NULL, *head;
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
+
+	if (!mapping_needs_writeback(mapping))
+		return false;
+	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
+	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		return false;
+	if (end_byte < start_byte)
+		return false;
+
+	rcu_read_lock();
+	xas_for_each(&xas, head, max) {
+		if (xas_retry(&xas, head))
+			continue;
+		if (xa_is_value(head))
+			continue;
+		page = find_subpage(head, xas.xa_index);
+		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
+			break;
+		page = NULL;
+	}
+	rcu_read_unlock();
+
+	return page != NULL;
+}
+EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
+
 /**
  * filemap_write_and_wait_range - write out & wait on a file range
  * @mapping:	the address_space for the pages
-- 
2.30.0

