Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F910119250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJUnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:43:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37888 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so413896pfc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g934jRFitGK2n249ARajPKYt/UpPdfJOZffggpxpM9A=;
        b=VC4R6EkXXjbtQxDiwSsKD2cJRnJF2ODuAL3j8ivGaSeswr6nBQpNBzBjn+q/Vcpeil
         ycZ+Ao2nHQq7myQuMGD4fppkVnNgT+lLMObOnSHXDraX/2V7KQWkp73TSXf1iEqwkpvh
         kxQ8tBtG4h00b0Cq5hSe/+zR7dUYXOklLtS4yzNx4n754+9LRSDtzwF0BM5zDwGWJlI4
         LCO18i09Xt9xIgLpbQJlOKGBukiM2Ye2CGcaYQrV5tIalX34nIHITLjJAnryr2uiaQnQ
         H1JJKa0QJQNhA30TOcOpwFn6uj1aSiDWyQ1shW2UC8FJjuPu8Dy3GnqYQgccuq7auwLV
         eXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g934jRFitGK2n249ARajPKYt/UpPdfJOZffggpxpM9A=;
        b=E3OpbeFqxvhaUiRyFWyQMCv7biYWoK/Oz0Mt/vt2Y3x1ufgQswWd22x8/tUYIspvyO
         05n8GbTWDwZOjSmoQzdKPaZQcPmN3Y+bFRWqqO8GrHSxlqEakuumJYY0gxMT/ZSCVFgB
         i0hc71EeiT6ZjIUZ7UuhYX7cNVOM5rl0SrCQmrQ2+ILjLLeg8yTWmtOCb5rr+kvrCwql
         nX4DAmVKoH4R0PxPlbHqqj8EChVRZgTxxqhuhR560Q/buVpbNnyN1++7VZLTW5Aao8yE
         p03HHzMblpCuISnzbOLcwAjsyuwDE3Dc6+HrS74GRxTVSeZAz0ttUmxZdXfoVUPJfLQJ
         P5cQ==
X-Gm-Message-State: APjAAAWRqiqG3A43+dszBTkEWNRBZsbtZhp8UefRk/ALWlY6DcMsKmk7
        8RN2sDE1PiTndm15NPpBuQmhhQ==
X-Google-Smtp-Source: APXvYqyE5WoFA/cmJn1vJRX9pzPgXF2eR410xgWfmk3FD8JEs9EuTw5uMmkjPyn17EKlZwqDrRxS2A==
X-Received: by 2002:a62:788a:: with SMTP id t132mr29104312pfc.134.1576010589664;
        Tue, 10 Dec 2019 12:43:09 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] fs: add read support for RWF_UNCACHED
Date:   Tue, 10 Dec 2019 13:43:00 -0700
Message-Id: <20191210204304.12266-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210204304.12266-1-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll drop the
cache for buffered reads if we are the ones instantiating it. If the
data is already cached, we leave it cached.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      |  3 +++
 include/uapi/linux/fs.h |  5 ++++-
 mm/filemap.c            | 46 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 6 deletions(-)

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
index bf6aa30be58d..ed23a11b3e34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -933,8 +933,8 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
+static int __add_to_page_cache(struct page *page, struct address_space *mapping,
+			       pgoff_t offset, gfp_t gfp_mask, bool lru)
 {
 	void *shadow = NULL;
 	int ret;
@@ -956,9 +956,17 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		WARN_ON_ONCE(PageActive(page));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
 			workingset_refault(page, shadow);
-		lru_cache_add(page);
+		if (lru)
+			lru_cache_add(page);
 	}
 	return ret;
+
+}
+
+int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
+				pgoff_t offset, gfp_t gfp_mask)
+{
+	return __add_to_page_cache(page, mapping, offset, gfp_mask, true);
 }
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
@@ -2032,6 +2040,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	offset = *ppos & ~PAGE_MASK;
 
 	for (;;) {
+		bool drop_page = false;
 		struct page *page;
 		pgoff_t end_index;
 		loff_t isize;
@@ -2048,6 +2057,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;
+			/* UNCACHED implies no read-ahead */
+			if (iocb->ki_flags & IOCB_UNCACHED)
+				goto no_cached_page;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -2147,6 +2159,26 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		offset &= ~PAGE_MASK;
 		prev_offset = offset;
 
+		/*
+		 * If we're dropping this page due to drop-behind, then
+		 * lock it first. Ignore errors here, we can just leave it
+		 * in the page cache. Note that we didn't add this page to
+		 * the LRU when we added it to the page cache. So if we
+		 * fail removing it, or lock it, add to the LRU.
+		 */
+		if (drop_page) {
+			bool addlru = true;
+
+			if (!lock_page_killable(page)) {
+				if (page->mapping == mapping)
+					addlru = !remove_mapping(mapping, page);
+				else
+					addlru = false;
+				unlock_page(page);
+			}
+			if (addlru)
+				lru_cache_add(page);
+		}
 		put_page(page);
 		written += ret;
 		if (!iov_iter_count(iter))
@@ -2234,8 +2266,12 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
-		error = add_to_page_cache_lru(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			drop_page = true;
+
+		error = __add_to_page_cache(page, mapping, index,
+				mapping_gfp_constraint(mapping, GFP_KERNEL),
+				!drop_page);
 		if (error) {
 			put_page(page);
 			if (error == -EEXIST) {
-- 
2.24.0

