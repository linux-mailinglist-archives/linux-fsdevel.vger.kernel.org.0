Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9343CD35B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhGSKXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSKXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444AC061574;
        Mon, 19 Jul 2021 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=er9Cpk9Z8lS1Hw2TdVzE4xq9i+F0Z8djgxOH+g0aQ/0=; b=hWXTOTXUJ1OOSZNYDWS6TRvyF1
        AjDqEwQtumS6wm2+eLbC3hw9IN2mDWC5LwgArYb8/KNvbydIwx212l9fv3LUTABwQGSuy47bEmEWY
        gGVtNUnD5YVMiIHnF9j8WHmaGW8gk8XswhuxKxemB4USyTkk4fIh5eByTRZrdCrPrcK9rAf+F5DzX
        7DQ+VEpDk50PiSqpw8FPcHG3ZScVp3GO0YRAr0Rfg1XNg5fau7efPv2ns4UyZLm+duRLfgHTCmJDk
        xSLpH8hkSTldPqDJWvF0tR13hU3KKAKubuWQesvpxpH64zG21K1OAn3pWrgZ5YWA9y8I8DL41xVFl
        lspJ93gQ==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5R1V-006mK6-97; Mon, 19 Jul 2021 11:01:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 23/27] iomap: rework unshare flag
Date:   Mon, 19 Jul 2021 12:35:16 +0200
Message-Id: <20210719103520.495450-24-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of another internal flags namespace inside of buffered-io.c,
just pass a UNSHARE hint in the main iomap flags field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 23 +++++++++--------------
 include/linux/iomap.h  |  1 +
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index daabbe8d7edfb5..eb5d742b5bf8b7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -511,10 +511,6 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
 #endif /* CONFIG_MIGRATION */
 
-enum {
-	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
-};
-
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -544,7 +540,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 }
 
 static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
-		unsigned len, int flags, struct page *page)
+		unsigned len, struct page *page)
 {
 	struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_page *iop = iomap_page_create(iter->inode, page);
@@ -563,13 +559,13 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		if (plen == 0)
 			break;
 
-		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
+		if (!(iter->flags & IOMAP_UNSHARE) &&
 		    (from <= poff || from >= poff + plen) &&
 		    (to <= poff || to >= poff + plen))
 			continue;
 
 		if (iomap_block_needs_zeroing(iter, block_start)) {
-			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
+			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
 			zero_user_segments(page, poff, from, to, poff + plen);
 		} else {
@@ -585,7 +581,7 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 }
 
 static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
-		unsigned flags, struct page **pagep)
+		struct page **pagep)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -617,7 +613,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
 	else if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, pos, len, flags, page);
+		status = __iomap_write_begin(iter, pos, len, page);
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -748,7 +744,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, 0, &page);
+		status = iomap_write_begin(iter, pos, bytes, &page);
 		if (unlikely(status))
 			break;
 
@@ -825,8 +821,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct page *page;
 
-		status = iomap_write_begin(iter, pos, bytes,
-				IOMAP_WRITE_F_UNSHARE, &page);
+		status = iomap_write_begin(iter, pos, bytes, &page);
 		if (unlikely(status))
 			return status;
 
@@ -854,7 +849,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
-		.flags		= IOMAP_WRITE,
+		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
 	};
 	int ret;
 
@@ -871,7 +866,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 	unsigned offset = offset_in_page(pos);
 	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
 
-	status = iomap_write_begin(iter, pos, bytes, 0, &page);
+	status = iomap_write_begin(iter, pos, bytes, &page);
 	if (status)
 		return status;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2f13e34c2c0b0b..719798814bdfdb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,7 @@ struct iomap_page_ops {
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
+#define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
 
 struct iomap_ops {
 	/*
-- 
2.30.2

