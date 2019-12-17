Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDA122EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfLQOjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34962 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfLQOjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:53 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so8566980ild.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEQyHfYbXoJej+s6/OMXT2BLZEPX6SiZ+5HLaKOeShc=;
        b=Rz0PTf0WwZEmsAUdF5wBZZkfVKCAltgfrzi74jjEA3lLneDy8dSauI/jbG3xoO7X7R
         e/VLmB+AiDGb4AjO2B/a6EyP+ygtn5D4ibbttq9rQLt5QiJNuzGA8PKC/CE9cdH4s9f+
         dNaoH3JbLMpqNSpla+Y1wRrLG2jXJyiYRfyNa/cTX2EX/ow4JZkh0XhafeJtifcvPcPw
         /mA6Xil4l219I3wA5uND8mxzy81yPgODPqEFgFMTmd/OtU9Ds3F3kx/oD5fjJd118/Sd
         EO3NABK5jRgz+ogHrcK6ROc0cGWS6zuF8O/S6gQWgDglVQaB14e5ws/hq5XF5GmnU0g9
         mBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEQyHfYbXoJej+s6/OMXT2BLZEPX6SiZ+5HLaKOeShc=;
        b=aFVwdnm+uQzbIYdIcpmjz+M0rNvKFJzUyRUkwl7YhRCSkF8BLBWaEEDyRJgxIepdWW
         lGSEAkAUsKP0IbRD1CMuSGdfvcRydrK8zijRjItylJhEYSFxscTEFiNCtlXPYtFuAwm3
         3sSbpJnSp1piKPinFZBeZ0NjquDMSnV4SRIJNBHbLHRLhZLEnWC/9kz4SnlRQoJaXfhD
         K1upoltuhNqoYSIvI4mOdX7g5ph5hkjXWKEziFs6NtRRaDwI/uA4byXhdRLhlDwdb2N/
         FeungSiduy59CXbBq29jnU+mFXFEDmN++f/evi6wpgtPqM3NAKZuowwYa8F2xqptn8IZ
         kwng==
X-Gm-Message-State: APjAAAVTMoL766I48+Z7kVB+hv4CoaSfWhE5+sqqJopUcCt04zUJrmH5
        kER4oW32a1WJuPum1AZuAfuNyQ==
X-Google-Smtp-Source: APXvYqxNs1UwvqiKd0kuf9aHlqRHi8PBLH1NSYmwr4Xu4fISsW1/lVDKFz8aN9GKiiU+f+n2z5OIYg==
X-Received: by 2002:a92:d809:: with SMTP id y9mr18025008ilm.261.1576593592098;
        Tue, 17 Dec 2019 06:39:52 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] fs: add read support for RWF_UNCACHED
Date:   Tue, 17 Dec 2019 07:39:43 -0700
Message-Id: <20191217143948.26380-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
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
 mm/filemap.c            | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 7 deletions(-)

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
index bf6aa30be58d..7ddc4d8386cf 100644
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
@@ -2234,6 +2250,14 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
+		if (iocb->ki_flags & IOCB_UNCACHED) {
+			__SetPageLocked(page);
+			page->mapping = mapping;
+			page->index = index;
+			clear_mapping = true;
+			goto readpage;
+		}
+
 		error = add_to_page_cache_lru(page, mapping, index,
 				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
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

