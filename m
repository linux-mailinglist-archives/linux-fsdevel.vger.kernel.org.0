Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2E119255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLJUnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:43:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36246 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLJUnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so334620pll.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=La+NjwGWvt7GtzB/lTDOhWu8CGazP1OPST351UYuSZU=;
        b=VmNeW0AhbIFvToeaKcXSGJpXV4duIlEUi83oBivoP6f/zYhBxVSNKZMaX2bBPcUUPu
         epQNja0TfDYERlBEuIeQjWCyTugaN95R49GIEme7K2YToJRGfkseJV2Ctzt5g5+/2QMd
         Tjs3tkuFOsmP6a0NwJoEKNnhQc027QKtWpbBywAMmC0NL7V6gU2X5enDUONiV8Uq3Aeo
         07SLH8MkXvRV/kuIXyWA5l4PLIgJ6eGyPYfzAj3PUo/cP56wO6Ak59DrKVOQGxwBKlVB
         7dRI5ZNnirDJTHCpOTu55xtP/C/apXPcdI1M/EBHLuoCOlxDQZMkTsXUlFnbOxd4cGeQ
         ORGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=La+NjwGWvt7GtzB/lTDOhWu8CGazP1OPST351UYuSZU=;
        b=hjyHkMDRzvOr2jWxato8+/9exVPnrgwCr9iUGpThsh+MEO9emUwfPX3LYgCVuUz0WV
         kCR7U2AnuPDHB7SRpYiT2K/hA6vh4XHnpELmVcaNxSjTY/HsfAB4ghOt4zS55MJtf9uu
         ZN5rgxX6c2u7AgzI8/QNGFJIHem7Uy2kcLZsX9luTWfrXWagPeyBGMxXudXxoRnu9VR7
         am7qbsroQHygE4FEPQExKu/zI+dThE0axhcVULmkOzUIhk3M4OW0mBkRIYDXt8Oai2Pp
         wLQZJfYpVcONYXLsB7yBLm/ta6jvHxDxtrtgtEfLDe7FpYZeH/n04uNAdUGg9wB/5c4t
         shvQ==
X-Gm-Message-State: APjAAAV6pTvq0Ewn3mghDX+qDzET+s0j/XqDTomNKf6inFkWeQkA61Xh
        yi4fk0AbV95TSKf6XcCYf7QhJQ==
X-Google-Smtp-Source: APXvYqwgqZKt25BF3h7lSSi7BUUZNK2CUq5kWJ1XJaGbTEbq+wqqeHVoePnNe2UiFNm+R/2EmgVeqg==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr7620307pju.103.1576010593276;
        Tue, 10 Dec 2019 12:43:13 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Date:   Tue, 10 Dec 2019 13:43:02 -0700
Message-Id: <20191210204304.12266-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210204304.12266-1-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If RWF_UNCACHED is set for io_uring (or pwritev2(2)), we'll drop the
cache instantiated for buffered writes. If new pages aren't
instantiated, we leave them alone. This provides similar semantics to
reads with RWF_UNCACHED set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  5 +++
 mm/filemap.c       | 85 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bf58db1bc032..7ea3dfdd9aa5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -285,6 +285,7 @@ enum positive_aop_returns {
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
+#define AOP_FLAG_UNCACHED		0x0004
 
 /*
  * oh the beauties of C type declarations.
@@ -3106,6 +3107,10 @@ extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_perform_write(struct file *, struct iov_iter *,
 				     struct kiocb *);
 
+struct pagevec;
+extern void write_drop_cached_pages(struct pagevec *pvec,
+				struct address_space *mapping);
+
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
 ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
diff --git a/mm/filemap.c b/mm/filemap.c
index fe37bd2b2630..2e36129ebe38 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3287,10 +3287,12 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 					pgoff_t index, unsigned flags)
 {
 	struct page *page;
-	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT;
+	int fgp_flags = FGP_LOCK|FGP_WRITE;
 
 	if (flags & AOP_FLAG_NOFS)
 		fgp_flags |= FGP_NOFS;
+	if (!(flags & AOP_FLAG_UNCACHED))
+		fgp_flags |= FGP_CREAT;
 
 	page = pagecache_get_page(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
@@ -3301,21 +3303,65 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
+/*
+ * Start writeback on the pages in pgs[], and then try and remove those pages
+ * from the page cached. Used with RWF_UNCACHED.
+ */
+void write_drop_cached_pages(struct pagevec *pvec,
+			     struct address_space *mapping)
+{
+	loff_t start, end;
+	int i;
+
+	end = 0;
+	start = LLONG_MAX;
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		loff_t off = page_offset(pvec->pages[i]);
+		if (off < start)
+			start = off;
+		if (off > end)
+			end = off;
+	}
+
+	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		lock_page(page);
+		if (page->mapping == mapping) {
+			wait_on_page_writeback(page);
+			if (!page_has_private(page) ||
+			    try_to_release_page(page, 0))
+				remove_mapping(mapping, page);
+		}
+		unlock_page(page);
+	}
+	pagevec_release(pvec);
+}
+EXPORT_SYMBOL_GPL(write_drop_cached_pages);
+
+#define GPW_PAGE_BATCH		16
+
 ssize_t generic_perform_write(struct file *file,
 				struct iov_iter *i, struct kiocb *iocb)
 {
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	loff_t pos = iocb->ki_pos;
+	struct pagevec pvec;
 	long status = 0;
 	ssize_t written = 0;
 	unsigned int flags = 0;
 
+	pagevec_init(&pvec);
+
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
+		bool drop_page = false;	/* drop page after IO */
 		void *fsdata;
 
 		offset = (pos & (PAGE_SIZE - 1));
@@ -3323,6 +3369,9 @@ ssize_t generic_perform_write(struct file *file,
 						iov_iter_count(i));
 
 again:
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			flags |= AOP_FLAG_UNCACHED;
+
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -3343,10 +3392,17 @@ ssize_t generic_perform_write(struct file *file,
 			break;
 		}
 
+retry:
 		status = a_ops->write_begin(file, mapping, pos, bytes, flags,
 						&page, &fsdata);
-		if (unlikely(status < 0))
+		if (unlikely(status < 0)) {
+			if (status == -ENOMEM && (flags & AOP_FLAG_UNCACHED)) {
+				drop_page = true;
+				flags &= ~AOP_FLAG_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
@@ -3354,10 +3410,16 @@ ssize_t generic_perform_write(struct file *file,
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 		flush_dcache_page(page);
 
+		if (drop_page)
+			get_page(page);
+
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
 						page, fsdata);
-		if (unlikely(status < 0))
+		if (unlikely(status < 0)) {
+			if (drop_page)
+				put_page(page);
 			break;
+		}
 		copied = status;
 
 		cond_resched();
@@ -3374,14 +3436,27 @@ ssize_t generic_perform_write(struct file *file,
 			 */
 			bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_single_seg_count(i));
+			if (drop_page)
+				put_page(page);
 			goto again;
 		}
+		if (drop_page &&
+		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
+			if (!pagevec_add(&pvec, page))
+				write_drop_cached_pages(&pvec, mapping);
+		} else {
+			if (drop_page)
+				put_page(page);
+			balance_dirty_pages_ratelimited(mapping);
+		}
+
 		pos += copied;
 		written += copied;
-
-		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
 
+	if (pagevec_count(&pvec))
+		write_drop_cached_pages(&pvec, mapping);
+
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_perform_write);
-- 
2.24.0

