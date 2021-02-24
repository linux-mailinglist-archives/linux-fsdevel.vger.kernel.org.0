Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9532425E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBXQqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhBXQpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45EC061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k2so2282477ili.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owukme2spaP1zcM9AHe/6hJeoYkmBs9bd0Xi7g8qADI=;
        b=GeDAo7Bc1lkwEaS/OFb6vd+jmpQQkTiXXvshs4eXK221ZcL0dZcaVB0lb1WFKvgKym
         h0uKM1lq1iBvNdNmz7EVIEvEJb11qjJD2oK+PEdz+G1oZ4zhUj+M23frgBZzvgV0Qnw8
         troypsZkvPWeHDTHKC6Lha9WQQyh1Ud5MFj/W33jd8LRmE/S3zkeI5irCh2jwDOR75di
         l3toWqZJZLqiwSUzh9mQL4k45w6vwvBh0jMS0ibTJiQjz2YqgUaF647VT5OM+staaOsZ
         kTohBAGlscOR7g+W4RQGn8p66TiBRohVf94DEJWLbIY7qmev2STOMA9WutevYPxjtYP9
         lWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Owukme2spaP1zcM9AHe/6hJeoYkmBs9bd0Xi7g8qADI=;
        b=Df7IrXBr3SeDH2TXothxmdqhH49OS3VJSMVEKA82q+Ms0hNJdUGhjVkTXerdhlaBF4
         6u2HmgdgqQ0N6JhL877HkKSMyO4KHqvbGjxvpUWPhvwsp+51kkMUhRaALVAngzQxSnq7
         lq4Dmr/3UV1zBAatjatDg+yMO6yr0w6m6zRipo546eYnYjI7fCHFbV3eytCpeuBeeQ6U
         NT1ntCW2EALuT8DCLdzVqaSnjGhMoLVLhnvMs5KqrOvIDktiDQ8QzvYZAP8beu+4yVa2
         w20NhXSChNZ713Cuk4f7Gx34SV1/ApMcyqNZ9sN8dWL2hE/BrFmIXNOALBEsn0vrLIgh
         NK9g==
X-Gm-Message-State: AOAM533MpRlXJiCtimPhM7WMTeBiV7hMHU3U+pYoegBuAfM3ZvG92kzH
        EBOD2rgbMedICGVJUFoK9gctaTpoQdnz7nK+
X-Google-Smtp-Source: ABdhPJzpcC+zKFW8OqpZDD687rXHdYoKLtmGUfTu+b4vervy16l9zQ+Zel7Wo9F6htsMLjpgyNRD8A==
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr23894877ilv.278.1614185099819;
        Wed, 24 Feb 2021 08:44:59 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm2273652iov.3.2021.02.24.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:44:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Date:   Wed, 24 Feb 2021 09:44:53 -0700
Message-Id: <20210224164455.1096727-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210224164455.1096727-1-axboe@kernel.dk>
References: <20210224164455.1096727-1-axboe@kernel.dk>
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
 mm/filemap.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6d8b1e7337e4..4925275e6365 100644
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
index 6ff2a3fb0dc7..13338f877677 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -635,6 +635,49 @@ static bool mapping_needs_writeback(struct address_space *mapping)
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
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
+	struct page *page;
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
+	xas_for_each(&xas, page, max) {
+		if (xas_retry(&xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
+			break;
+	}
+	rcu_read_unlock();
+	return page != NULL;
+}
+EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
+
 /**
  * filemap_write_and_wait_range - write out & wait on a file range
  * @mapping:	the address_space for the pages
-- 
2.30.0

