Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720A331465B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhBICbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBICa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA3C061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:30:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so8880655plg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lORwaaiPEScAng7B1o0PI3rE/Z/yT/4jNBxJ0rOXsDA=;
        b=SjQuZzcSz5/ors8H2c2fFiZya7IIdg+5e48zKW4Xry1PtdKCTBUPuv313R/WdoitzW
         wuCwqdW24Ut65txynzjDs1N06SiK7i4h+TXbTxmVE5MkXz+USPW5zsA9Wocpj5tU4zEE
         yBMQpAILtUgKvPnWuksDPdo6J5vxwbq7s3ydpDYJIE896kYhYJOD6KEI+lyq41fVWXet
         bp74ML+EBujxIPO+SJEvOXIL7wEimkfU8xQv0A/wiZO6zt4LBuBqqVhIvlYrS41ufJfN
         49znuQDexZiOgIImZMVJboqYj5OvZTTmWAJJmPj54xT9oaNxc83hpzZNct6bgz48I8E3
         lWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lORwaaiPEScAng7B1o0PI3rE/Z/yT/4jNBxJ0rOXsDA=;
        b=Avpl9+/iuNazYsn4ktAINSMsI6cGCtiBAT2i31QiokBZ+xFxjlnD1uSfDgzqjUDa43
         Twv0y7rdWgsVUszfSExeJMz3ZErRQS547bXMHr/qaDH3Q3oEJ6yZuGR1qCt+CDABtpVp
         nNy5R7Vrqqb7M0LlpL5gkMP2b4hG5X5SWihYH4HOsKEQEvpxIdMGXi5AzaE36k9Qj3kU
         frntKFME/XvGXtcT7Fvk4tA1RJ0PlS9yA5OUrwj4x2gaVfYokxGJgYr+dJVM6Tww7q1L
         8wq8Q1pF0dDYtjIRvKLMVBX3GXt01iYu5UM0Jybx+ajsWwr7G/15Yh9KXk3BmkEtjIzw
         gqnQ==
X-Gm-Message-State: AOAM530XSvh1oyPC31GHeQyx31723FGw+WLFT6KRXVRuBjartrNonmZ4
        V+YG1miuzM1Ecv58l0gmTGYnUl267BPdyw==
X-Google-Smtp-Source: ABdhPJzRjq3VJvcakEyMmh+N1e9dpfs3Ljn9RDCUa5pfoyICkb5FgskLto2S5Lg49P8ke0tXi65jCw==
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr1854414pju.2.1612837815702;
        Mon, 08 Feb 2021 18:30:15 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y2sm19070597pfe.118.2021.02.08.18.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:30:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Date:   Mon,  8 Feb 2021 19:30:06 -0700
Message-Id: <20210209023008.76263-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209023008.76263-1-axboe@kernel.dk>
References: <20210209023008.76263-1-axboe@kernel.dk>
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
index aa0e0fb04670..6a58d50fbd31 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -633,6 +633,49 @@ static bool mapping_needs_writeback(struct address_space *mapping)
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

