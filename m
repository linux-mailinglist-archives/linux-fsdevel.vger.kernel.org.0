Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77511925A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLJUnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:43:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39501 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfLJUnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so329924plk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0YILHXRbJs8J7xsozfnM9NWRJjXyg0wWjg7zLtIn80=;
        b=Zt5cRttRdXTuNVRLaNW0GjwGe5xHR8pnhuh3//XlXzBx2Yao7Cov2+gkE21/h+3h+1
         WuZdvNjk4cyOjKY+Nv/wXMUPD6MqoHPpjb1M8M+hamqvqfa8qP5HjmGfPwpbS6JmfAVC
         bDImSEbNsxnur/ua4DNRDLlSSmqvi7f1BSO/whT6Qn32GIfxBGre9moCBjtjgWCpQVyF
         elvvWumccRmLUs75y2VUuFGhfYSivHqtAhtnSOGVzYw0kJLYvj0GRLlN/KyezNv2/3ds
         ebpVhAEowfUe9ry6gChE683ESa8i58Buk5lPBkFmpQbTSgQug/w9b6/DsCgwe36iOGD3
         nOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0YILHXRbJs8J7xsozfnM9NWRJjXyg0wWjg7zLtIn80=;
        b=DrltpoerhMIDJ//wPLVFmS6OZASWsK3wAe/xoeDNXNftXlmuH5q0UVoAjHxvOAr5io
         DUSZ/6w6jbpzCzO8WzRRb+ItLypn/rWxMWge/rkOqNYM6ZUwB0T8RF3AD/j+5p9/FoQ6
         hHgTW8TKzsEhviMvu+ruVlz5HwE+Mr2E8Fl7//2RQ0IwZNsqZhqebfooHdCcY/b7r6jc
         Bul/XJs6Ssqv0U0rM9ErWBSnAkhakntVZtZqJz0rX4LGYMTrBcGpCGtitwJKpbxFd4yB
         uL9qeyy51VzSpb+Oqnr/ONiMhvs+tt6hFYof2zYv+q/bOr115DiOvOWZ6q2PVCyHkQw2
         1fXg==
X-Gm-Message-State: APjAAAVy1QWaW3QXOG6Y649kY6Xb6BuoYjWieyKnrL3ljc5zRWdy713K
        xjUrgXkDa3dv5IGtUzC+QQM8VnMvjvb7qg==
X-Google-Smtp-Source: APXvYqyz4BWMiFzYaNYGlsgVbEiw1vf/lVaKsSU/fOlFo52QB6QY5giJhs5CEYFJjumARZ6Uym7YcA==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr7531541pjb.7.1576010596956;
        Tue, 10 Dec 2019 12:43:16 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Date:   Tue, 10 Dec 2019 13:43:04 -0700
Message-Id: <20191210204304.12266-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210204304.12266-1-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
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
 fs/iomap/buffered-io.c | 72 +++++++++++++++++++++++++++++++++++-------
 include/linux/iomap.h  |  1 +
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9b5b770ca4c7..3a18a6af8cb3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include <linux/pagevec.h>
 #include "trace.h"
 
 #include "../internal.h"
@@ -566,6 +567,7 @@ EXPORT_SYMBOL_GPL(iomap_migrate_page);
 
 enum {
 	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
+	IOMAP_WRITE_F_UNCACHED		= (1 << 1),
 };
 
 static void
@@ -643,6 +645,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	unsigned aop_flags;
 	struct page *page;
 	int status = 0;
 
@@ -659,8 +662,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 			return status;
 	}
 
+	aop_flags = AOP_FLAG_NOFS;
+	if (flags & IOMAP_UNCACHED)
+		aop_flags |= AOP_FLAG_UNCACHED;
 	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
-			AOP_FLAG_NOFS);
+						aop_flags);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
@@ -670,9 +676,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		iomap_read_inline_data(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
-	else
-		status = __iomap_write_begin(inode, pos, len, flags, page,
+	else {
+		unsigned wb_flags = 0;
+
+		if (flags & IOMAP_UNCACHED)
+			wb_flags = IOMAP_WRITE_F_UNCACHED;
+		status = __iomap_write_begin(inode, pos, len, wb_flags, page,
 				srcmap);
+	}
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -796,19 +807,27 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 	return ret;
 }
 
+#define GPW_PAGE_BATCH		16
+
 static loff_t
 iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct iov_iter *i = data;
+	struct pagevec pvec;
 	long status = 0;
 	ssize_t written = 0;
 
+	pagevec_init(&pvec);
+
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
+		bool drop_page = false;	/* drop page after IO */
+		unsigned lflags = flags;
 
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
@@ -832,10 +851,17 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
-				srcmap);
-		if (unlikely(status))
+retry:
+		status = iomap_write_begin(inode, pos, bytes, lflags, &page,
+						iomap, srcmap);
+		if (unlikely(status)) {
+			if (status == -ENOMEM && (lflags & IOMAP_UNCACHED)) {
+				drop_page = true;
+				lflags &= ~IOMAP_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -844,10 +870,16 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		flush_dcache_page(page);
 
+		if (drop_page)
+			get_page(page);
+
 		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
-		if (unlikely(status < 0))
+		if (unlikely(status < 0)) {
+			if (drop_page)
+				put_page(page);
 			break;
+		}
 		copied = status;
 
 		cond_resched();
@@ -864,15 +896,29 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			 */
 			bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_single_seg_count(i));
+			if (drop_page)
+				put_page(page);
 			goto again;
 		}
+
+		if (drop_page &&
+		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
+			if (!pagevec_add(&pvec, page))
+				write_drop_cached_pages(&pvec, mapping);
+		} else {
+			if (drop_page)
+				put_page(page);
+			balance_dirty_pages_ratelimited(inode->i_mapping);
+		}
+
 		pos += copied;
 		written += copied;
 		length -= copied;
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
 	} while (iov_iter_count(i) && length);
 
+	if (pagevec_count(&pvec))
+		write_drop_cached_pages(&pvec, mapping);
+
 	return written ? written : status;
 }
 
@@ -882,10 +928,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
+	unsigned flags = IOMAP_WRITE;
+
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		flags |= IOMAP_UNCACHED;
 
 	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
+		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags,
+					ops, iter, iomap_write_actor);
 		if (ret <= 0)
 			break;
 		pos += ret;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 61fcaa3904d4..833dd43507ac 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -121,6 +121,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_UNCACHED		(1 << 6)
 
 struct iomap_ops {
 	/*
-- 
2.24.0

