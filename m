Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A768D11D68E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfLLTBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:39 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35398 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLTBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:39 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so2967469ild.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EURgosiuwacwBKKWTVFdoxY9333p7skGDIpbIB1Zdws=;
        b=Vzr47eRVotGYSh3EQMnnAe6Ot66q0hOOBDZojBAkzci5NUWtVNl3lneR1NJ/3wIZfK
         Fg7Hn9R0niEEs2DjJNtjZovqOx3Ee9i5zY/zRy7Imy+TZf3FCCEMrYzJk1iLwas0jnqf
         HKDwgUpPTo4vH6ewgmDGNe1vH3GKmuUvVz7bRcYweW3sbdUgDq/GSml9V9/MuKoxZkU+
         YdCNiD2ilKqWV5xB629CB9WK1/JBVNG+Jsy+WPBbYWXG/YiZyOkR4UG1uOwKsvT7ZrZ9
         fOlzBGNUItf64nch77z4IDMLTMFE4cNrLEH/sdi666IbGQ/+3QKETKHzFqVZ5gf/mSkF
         vPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EURgosiuwacwBKKWTVFdoxY9333p7skGDIpbIB1Zdws=;
        b=bFCJgbeEqkhfILL+nsPuBbS+Y/vxydQY1rcKuagotuecYMEVc5GCmi3md4+dCXHO0o
         qA1oCsn0jkesQoC0so9ZmxiCNcC1OMmca94P8P8ydPT7QgDbMtzyV91qioqqs89jTYjI
         ObK8JB3SNbcSDPay+KskdLVmWzMBQRJ597dQRMhLCnwcpLKYUHY3GmMuE6kbQharRLy9
         ykQTEcY/yHOfSJ8zONR3FrXEKmbj9bOTku54GDnvWRxcIjgZ1bsEo6r+8R6KZLMf+kMK
         kdMIEQSvpWQkx4OsKxWi2viyy/WHE3fjcgGVPWjw8a87ksylkB9P7fyEtHurquguSJ3P
         4aMw==
X-Gm-Message-State: APjAAAUKflWp3OSTtT8yrlynMT3U8a+CDQ9v7QvXnRgrWYRhXyr84s5A
        bTI4ztWqGJ/eNHDyz1lEHDgSmQ==
X-Google-Smtp-Source: APXvYqwTJOvHM9WtB0OBGg/KPxfufWu3Y/hk0jZpBwWYKUq7wMMB/eLDz2FyftDozy1WbYbk+WlZrg==
X-Received: by 2002:a92:c9c8:: with SMTP id k8mr871646ilq.235.1576177298605;
        Thu, 12 Dec 2019 11:01:38 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] fs: add read support for RWF_UNCACHED
Date:   Thu, 12 Dec 2019 12:01:29 -0700
Message-Id: <20191212190133.18473-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
References: <20191212190133.18473-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
pages for the buffered reads. These pages will never be inserted into
the page cache, and they are simply droped when we have done the copy at
the end of IO.

If pages in the read range are already in the page cache, then use those
for just copying the data instead of starting IO on private pages.

A previous solution used the page cache even for non-cached ranges, but
the cost of doing so was too high. Removing nodes at the end is
expensive, even with LRU bypass. On top of that, repeatedly
instantiating new xarray nodes is very costly, as it needs to memset 576
bytes of data, and freeing said nodes involve an RCU call per node as
well. All that adds up, making uncached somewhat slower than O_DIRECT.

With the current solition, we're basically at O_DIRECT levels of
performance for RWF_UNCACHED IO.

Protect against truncate the same way O_DIRECT does, by calling
inode_dio_begin() to elevate the inode->i_dio_count.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      |  3 +++
 include/uapi/linux/fs.h |  5 ++++-
 mm/filemap.c            | 40 +++++++++++++++++++++++++++++++++-------
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..092ea2a4319b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_UNCACHED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3418,6 +3419,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		ki->ki_flags |= IOCB_APPEND;
+	if (flags & RWF_UNCACHED)
+		ki->ki_flags |= IOCB_UNCACHED;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..357ebb0e0c5d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -299,8 +299,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* drop cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000040)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_UNCACHED)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..5d299d69b185 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1990,6 +1990,13 @@ static void shrink_readahead_size_eio(struct file *filp,
 	ra->ra_pages /= 4;
 }
 
+static void buffered_put_page(struct page *page, bool clear_mapping)
+{
+	if (clear_mapping)
+		page->mapping = NULL;
+	put_page(page);
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2013,6 +2020,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct file_ra_state *ra = &filp->f_ra;
+	bool did_dio_begin = false;
 	loff_t *ppos = &iocb->ki_pos;
 	pgoff_t index;
 	pgoff_t last_index;
@@ -2032,6 +2040,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	offset = *ppos & ~PAGE_MASK;
 
 	for (;;) {
+		bool clear_mapping = false;
 		struct page *page;
 		pgoff_t end_index;
 		loff_t isize;
@@ -2048,6 +2057,13 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;
+			/* UNCACHED implies no read-ahead */
+			if (iocb->ki_flags & IOCB_UNCACHED) {
+				did_dio_begin = true;
+				/* block truncate for UNCACHED reads */
+				inode_dio_begin(inode);
+				goto no_cached_page;
+			}
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -2106,7 +2122,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
+			buffered_put_page(page, clear_mapping);
 			goto out;
 		}
 
@@ -2115,7 +2131,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_MASK) + 1;
 			if (nr <= offset) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				goto out;
 			}
 		}
@@ -2147,7 +2163,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		offset &= ~PAGE_MASK;
 		prev_offset = offset;
 
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		written += ret;
 		if (!iov_iter_count(iter))
 			goto out;
@@ -2189,7 +2205,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				error = 0;
 				goto find_page;
 			}
@@ -2206,7 +2222,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					 * invalidate_mapping_pages got it
 					 */
 					unlock_page(page);
-					put_page(page);
+					buffered_put_page(page, clear_mapping);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -2221,7 +2237,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		goto out;
 
 no_cached_page:
@@ -2234,7 +2250,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
-		error = add_to_page_cache_lru(page, mapping, index,
+		if (iocb->ki_flags & IOCB_UNCACHED) {
+			__SetPageLocked(page);
+			page->mapping = mapping;
+			page->index = index;
+			clear_mapping = true;
+			goto readpage;
+		}
+
+		error = add_to_page_cache(page, mapping, index,
 				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
 			put_page(page);
@@ -2250,6 +2274,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 would_block:
 	error = -EAGAIN;
 out:
+	if (did_dio_begin)
+		inode_dio_end(inode);
 	ra->prev_pos = prev_index;
 	ra->prev_pos <<= PAGE_SHIFT;
 	ra->prev_pos |= prev_offset;
-- 
2.24.1

