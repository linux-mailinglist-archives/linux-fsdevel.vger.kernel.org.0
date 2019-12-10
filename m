Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6394D118D84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLJQZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:25:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33568 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfLJQZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:25:02 -0500
Received: by mail-io1-f66.google.com with SMTP id s25so4724935iob.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/x6NjL9O5h2Ux7aJEFNccuj0M9CNUr2pjvWBBusJd4=;
        b=Zpixa69lHW83t2ZbBBOHojQxENx5w2X0sKlji5l+ZpBo6tA/3fj9yn2HfnjrlJQ6Ob
         U8FY3MOCg7q0XHIPvND9EpFk53qsIhRbPB/9HbD1ilihLRNcBtOuwWUXkIqNVoGnuzdD
         5XOtCxdmCCmO2Arsi/KYjMVTyNg6egphSQmKqqQfmQkq1VyVM8Gj0Xtm9JJX4Led8WKe
         zmbD/SLsl+MyHYWuaQHEb1/hAAYeSbscwPIu0vVxe909vlonZb4pS3Y0AjqklnvTPNnZ
         6/Cw7617YWeJqBJwlZJAG0ivRv7q+hmVouVZ8mhUmu2zs+i9PsKCc/s41pHKmnnSHHi9
         5YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/x6NjL9O5h2Ux7aJEFNccuj0M9CNUr2pjvWBBusJd4=;
        b=SANzaqwDlcK1BvwGsV8jFHUA/TugxkTLJIRPivgIda54CYp1vxwsOpB3RvQglVYGCN
         TRZlH7bfJJgjWEBqvrSQMZDSz+8YuhAcXSw5ObHLanJIHCw8jMedV4zNjUlL3RAPlZhz
         jeXU6Gu+p+IfCVuNB9WSvv1h4mJfSTaofbsPoLn/KbkUdUlBn2cEJclC9QwMiVlVTXr7
         L2FCBlvnVwfC23m+nMEuW5ALNAo16aHzF0j3W5Bj8aUN62uLoSAfuCppmovJj0zGL7cc
         wX3VeFC3etC/LwJFZVuZPOrXuPUJoIQti9WuzZoTWApo1EK3zC8soE3kVNAvzeDr+GGQ
         08vw==
X-Gm-Message-State: APjAAAW2KRMrEVyzH5+tebKkIbGHj/Ob2WcqhCaGiayNtDXh5Q98Ew9u
        YmOk4RVlmcSrCj9ZDAP0JyvFAA==
X-Google-Smtp-Source: APXvYqxxtEmqFA3byjJGnmrQmrrH3TRgfkvrkxj17L5ofRuCP+Z2MTkeccUYnzTdzqEGwVD/DbWwww==
X-Received: by 2002:a02:c6d5:: with SMTP id r21mr32752498jan.129.1575995101208;
        Tue, 10 Dec 2019 08:25:01 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y11sm791174iol.23.2019.12.10.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:25:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Date:   Tue, 10 Dec 2019 09:24:52 -0700
Message-Id: <20191210162454.8608-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210162454.8608-1-axboe@kernel.dk>
References: <20191210162454.8608-1-axboe@kernel.dk>
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
 include/linux/fs.h |  3 ++
 mm/filemap.c       | 78 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bf58db1bc032..bcf486c132a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -285,6 +285,7 @@ enum positive_aop_returns {
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
+#define AOP_FLAG_UNCACHED		0x0004
 
 /*
  * oh the beauties of C type declarations.
@@ -3105,6 +3106,8 @@ extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_perform_write(struct file *, struct iov_iter *,
 				     struct kiocb *);
+extern void write_drop_cached_pages(struct page **,
+				    struct address_space *mapping, unsigned *);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index fe37bd2b2630..d6171bf705f9 100644
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
@@ -3301,21 +3303,67 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
+/*
+ * Start writeback on the pages in pgs[], and then try and remove those pages
+ * from the page cached. Used with RWF_UNCACHED.
+ */
+void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
+			     unsigned *nr)
+{
+	loff_t start, end;
+	int i;
+
+	end = 0;
+	start = LLONG_MAX;
+	for (i = 0; i < *nr; i++) {
+		struct page *page = pgs[i];
+		loff_t off;
+
+		off = (loff_t) page_to_index(page) << PAGE_SHIFT;
+		if (off < start)
+			start = off;
+		if (off > end)
+			end = off;
+		get_page(page);
+	}
+
+	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+
+	for (i = 0; i < *nr; i++) {
+		struct page *page = pgs[i];
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
+	*nr = 0;
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
+	struct page *drop_pages[GPW_PAGE_BATCH];
 	loff_t pos = iocb->ki_pos;
 	long status = 0;
 	ssize_t written = 0;
-	unsigned int flags = 0;
+	unsigned int flags = 0, drop_nr = 0;
 
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
+		bool drop_page = false;	/* drop page after IO */
 		void *fsdata;
 
 		offset = (pos & (PAGE_SIZE - 1));
@@ -3323,6 +3371,9 @@ ssize_t generic_perform_write(struct file *file,
 						iov_iter_count(i));
 
 again:
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			flags |= AOP_FLAG_UNCACHED;
+
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -3343,10 +3394,17 @@ ssize_t generic_perform_write(struct file *file,
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
@@ -3376,12 +3434,22 @@ ssize_t generic_perform_write(struct file *file,
 						iov_iter_single_seg_count(i));
 			goto again;
 		}
+		if (drop_page &&
+		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
+			drop_pages[drop_nr] = page;
+			if (++drop_nr == GPW_PAGE_BATCH)
+				write_drop_cached_pages(drop_pages, mapping,
+								&drop_nr);
+		} else
+			balance_dirty_pages_ratelimited(mapping);
+
 		pos += copied;
 		written += copied;
-
-		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
 
+	if (drop_nr)
+		write_drop_cached_pages(drop_pages, mapping, &drop_nr);
+
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_perform_write);
-- 
2.24.0

