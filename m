Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54B2122EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfLQOj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfLQOj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:56 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so2131508iop.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2t1wbHxKKKtUdtcUmZwxHQTSURnhol0rUQmYc3rnRQ=;
        b=msJo2enQjInrTvHVWg7Q+Z7EQ/nUVNXBraZbHG0oDoPJai9Aw7fJelgGmqmg/yLz3Q
         IxNq7da227XNWskPs5YZDPkksLrksK+B3OlR4q2IpVoEhR4KXC5DfOgwykS+rNJXLWsr
         6M4whoghpniEmcY1DAo891btCNofKb7o9xwPc+DGmYSsLnmhOIoVUkLefX6kwwIigoEP
         +Y7/MRJx/lIJnHCLqCK2uvHxatGExrnKbHZhcBoLJV3muyKEMeqWgGgsNEpklsg9O5ZE
         BlgVdEjoljwWHtcsa7FR1vyJ8iNszpL3IemrDGlKfiN/T/qWAtG+ESv//j24ERZiaYYD
         3lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2t1wbHxKKKtUdtcUmZwxHQTSURnhol0rUQmYc3rnRQ=;
        b=O0A3NzqWgYYYV4BF6ObJcXdqk3LNKQ7dQt7O7OPt63aP5a3hChMTnWOAWnx6u0qz08
         iskSqCZxCjbWA52yZTsg62EUUaZIlhAI/kj5x9jnltDEc+fEmfBSP+t/uIJQP0lbQzPZ
         J830c5SRa52btzYlv4MkEPYe2DU/NyWmbclzPGmMdsG2zgVD6ct3MmCOhFlw3JETYoRp
         Jm+ga3vYwprrTHvRerHbXzZ3j/ZkE4pbJPssCX/L+PlzgXaJ7jEFf++ecgYV4FxcDhvK
         z72buPgg9QUvM26pBnxO9oU581POn0Yv8NVF6T/CwecCvXWAM98Wn0Lb5FK+ugcshVzO
         /6dA==
X-Gm-Message-State: APjAAAUEmDneMc+zq/XvYd76NuVEo7UTdrN7vppN/rfamtejtz8gpsqa
        6qVQRjprHyCicNtQZeAxs+EZAg==
X-Google-Smtp-Source: APXvYqyAnsuB8ZAralfexxDLoU7WvWvM0qDJKnIIFzyd4aLl/ADMJwnw3aX9J/s22QIMOlWMxosrwQ==
X-Received: by 2002:a6b:7409:: with SMTP id s9mr4133569iog.197.1576593595835;
        Tue, 17 Dec 2019 06:39:55 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] iomap: support RWF_UNCACHED for buffered writes
Date:   Tue, 17 Dec 2019 07:39:47 -0700
Message-Id: <20191217143948.26380-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for RWF_UNCACHED for file systems using iomap to
perform buffered writes. We use the generic infrastructure for this,
by tracking pages we created and calling write_drop_cached_pages()
to issue writeback and prune those pages.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/apply.c       | 35 +++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
 fs/iomap/trace.h       |  4 +++-
 include/linux/iomap.h  |  5 +++++
 4 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 792079403a22..687e86945b27 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -92,5 +92,40 @@ iomap_apply(struct iomap_ctx *data, const struct iomap_ops *ops,
 				     data->flags, &iomap);
 	}
 
+	if (written <= 0)
+		goto out;
+
+	/*
+	 * If this is an uncached write, then we need to write and sync this
+	 * range of data. This is only true for a buffered write, not for
+	 * O_DIRECT.
+	 */
+	if ((data->flags & (IOMAP_WRITE|IOMAP_DIRECT|IOMAP_UNCACHED)) ==
+			(IOMAP_WRITE|IOMAP_UNCACHED)) {
+		struct address_space *mapping = data->inode->i_mapping;
+
+		end = data->pos + written;
+		ret = filemap_write_and_wait_range(mapping, data->pos, end);
+		if (ret)
+			goto out;
+
+		/*
+		 * No pages were created for this range, we're done. We only
+		 * invalidate the range if no pages were created for the
+		 * entire range.
+		 */
+		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
+			goto out;
+
+		/*
+		 * Try to invalidate cache pages for the range we just wrote.
+		 * We don't care if invalidation fails as the write has still
+		 * worked and leaving clean uptodate pages in the page cache
+		 * isn't a corruption vector for uncached IO.
+		 */
+		invalidate_inode_pages2_range(mapping,
+				data->pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	}
+out:
 	return written ? written : ret;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7f8300bce767..328afeba950f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -582,6 +582,7 @@ EXPORT_SYMBOL_GPL(iomap_migrate_page);
 
 enum {
 	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
+	IOMAP_WRITE_F_UNCACHED		= (1 << 1),
 };
 
 static void
@@ -659,6 +660,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	unsigned aop_flags;
 	struct page *page;
 	int status = 0;
 
@@ -675,8 +677,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 			return status;
 	}
 
+	aop_flags = AOP_FLAG_NOFS;
+	if (flags & IOMAP_WRITE_F_UNCACHED)
+		aop_flags |= AOP_FLAG_UNCACHED;
 	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
-			AOP_FLAG_NOFS);
+						aop_flags);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
@@ -820,9 +825,13 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
 	struct iov_iter *i = data->priv;
 	loff_t length = data->len;
 	loff_t pos = data->pos;
+	unsigned flags = 0;
 	long status = 0;
 	ssize_t written = 0;
 
+	if (data->flags & IOMAP_UNCACHED)
+		flags |= IOMAP_WRITE_F_UNCACHED;
+
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
@@ -851,10 +860,18 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
-				srcmap);
-		if (unlikely(status))
+retry:
+		status = iomap_write_begin(inode, pos, bytes, flags,
+						&page, iomap, srcmap);
+		if (unlikely(status)) {
+			if (status == -ENOMEM &&
+			    (flags & IOMAP_WRITE_F_UNCACHED)) {
+				iomap->flags |= IOMAP_F_PAGE_CREATE;
+				flags &= ~IOMAP_WRITE_F_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -907,6 +924,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 	};
 	loff_t ret = 0, written = 0;
 
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		data.flags |= IOMAP_UNCACHED;
+
 	while (iov_iter_count(iter)) {
 		data.len = iov_iter_count(iter);
 		ret = iomap_apply(&data, ops, iomap_write_actor);
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 6dc227b8c47e..63c771e3eef5 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -93,7 +93,8 @@ DEFINE_PAGE_EVENT(iomap_invalidatepage);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_UNCACHED,	"UNCACHED" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
@@ -101,6 +102,7 @@ DEFINE_PAGE_EVENT(iomap_invalidatepage);
 	{ IOMAP_F_SHARED,	"SHARED" }, \
 	{ IOMAP_F_MERGED,	"MERGED" }, \
 	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
+	{ IOMAP_F_PAGE_CREATE,	"PAGE_CREATE" }, \
 	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
 
 DECLARE_EVENT_CLASS(iomap_class,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 00e439aac8ea..58311b6fdfdd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -48,12 +48,16 @@ struct vm_fault;
  *
  * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
  * buffer heads for this mapping.
+ *
+ * IOMAP_F_PAGE_CREATE indicates that pages had to be allocated to satisfy
+ * this operation.
  */
 #define IOMAP_F_NEW		0x01
 #define IOMAP_F_DIRTY		0x02
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
+#define IOMAP_F_PAGE_CREATE	0x20
 
 /*
  * Flags set by the core iomap code during operations:
@@ -121,6 +125,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_UNCACHED		(1 << 6) /* uncached IO */
 
 struct iomap_ops {
 	/*
-- 
2.24.1

