Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231F811D694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfLLTBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38928 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbfLLTBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:45 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so3936565ioh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaJCkgUv/B3OET1g1Gk3ujWzgIVpNM0nxRodwjfiGBE=;
        b=IckOWSwJdM1mRDe5xLg+1QZWh5GjmzKz/7oAhzljHbAQD3IR8KlQNignWa1viyT4en
         Bh37pENQzkkWfMCAI6BipdGMRo/FeyG1ZLUKPSdW+BN/fp8yr0o4MzfkgwtRhNsjRco+
         M09XIHEM+8rPeoSpTB5EtkKznUCHqVeLvbg1q562VXLpYeQgoKspfnzL5cXCMwpaPm9s
         64iPUDt8t+FhqGPPjCxwjQKb/UMTjRByOLC6AKfFpFvHPt5TTIbYK8wViTd7F3Hrs/jz
         F0x/5d299vyhYmAirrEFlRTDD/S4fijWr09sEYNA74raM3wwMiGwx+yKRv9O7TOmRyd4
         3+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaJCkgUv/B3OET1g1Gk3ujWzgIVpNM0nxRodwjfiGBE=;
        b=p8z2HrLlzWbQs5UaYJAcWLRu9OUfYHtv8sFPmgzeXPOSc6zxwo+WErFW78ZuMHkSoH
         r3XmeaokEh4QjqY9Ewooo7HTlQeCE9iWq5whY5ksqmbpGwFiifHX8y2/v3YwCr1HObZY
         H9U3ZKkPdXLwlAqYwmCG0wFH9zML0NFTwt4hc9U+TxYrulDe775WlIJy3C2BdPXdgYsN
         lqOOIVDR96MfggsroCQi/N5nFnecml0iKhMhyQPcIEGJRTYscdFiPEScYeR/igO9dNJm
         PUCQNSg0vNv9Tc5qxymEogFI9DKZvmXDXxWIsXy3sqkxcZM15eASXIhnTGktn1GDr7Qf
         FJeQ==
X-Gm-Message-State: APjAAAUyHJ7XFs7WOJjMEsFHOkzfEpP3yUA9c1/xSxN8TJuRJhznHACp
        Ob+h8ilTQ9Mu8kCQDIaOAB46Pw==
X-Google-Smtp-Source: APXvYqwjTIM6kPV9uE6Psr7sf1orKaXXnKqktbjIaUiI0LaIo8/4HAcLiFgn4bEKliYaVLewxqJuUQ==
X-Received: by 2002:a02:a388:: with SMTP id y8mr9511471jak.70.1576177304566;
        Thu, 12 Dec 2019 11:01:44 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Date:   Thu, 12 Dec 2019 12:01:33 -0700
Message-Id: <20191212190133.18473-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
References: <20191212190133.18473-1-axboe@kernel.dk>
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
 fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
 fs/iomap/buffered-io.c | 23 +++++++++++++++++++----
 include/linux/iomap.h  |  5 +++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index e76148db03b8..11b6812f7b37 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -92,5 +92,29 @@ iomap_apply(struct iomap_data *data, const struct iomap_ops *ops,
 				     data->flags, &iomap);
 	}
 
+	if (written && (data->flags & IOMAP_UNCACHED)) {
+		struct address_space *mapping = data->inode->i_mapping;
+
+		end = data->pos + written;
+		ret = filemap_write_and_wait_range(mapping, data->pos, end);
+		if (ret)
+			goto out;
+
+		/*
+		 * No pages were created for this range, we're done
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
index 0a1a195ed1cc..df9d6002858e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -659,6 +659,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	unsigned aop_flags;
 	struct page *page;
 	int status = 0;
 
@@ -675,8 +676,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
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
@@ -818,6 +822,7 @@ iomap_write_actor(const struct iomap_data *data, struct iomap *iomap,
 {
 	struct inode *inode = data->inode;
 	struct iov_iter *i = data->priv;
+	unsigned flags = data->flags;
 	loff_t length = data->len;
 	loff_t pos = data->pos;
 	long status = 0;
@@ -851,10 +856,17 @@ iomap_write_actor(const struct iomap_data *data, struct iomap *iomap,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
-				srcmap);
-		if (unlikely(status))
+retry:
+		status = iomap_write_begin(inode, pos, bytes, flags,
+						&page, iomap, srcmap);
+		if (unlikely(status)) {
+			if (status == -ENOMEM && (flags & IOMAP_UNCACHED)) {
+				iomap->flags |= IOMAP_F_PAGE_CREATE;
+				flags &= ~IOMAP_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -907,6 +919,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 	};
 	loff_t ret = 0, written = 0;
 
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		data.flags |= IOMAP_UNCACHED;
+
 	while (iov_iter_count(iter)) {
 		data.len = iov_iter_count(iter);
 		ret = iomap_apply(&data, ops, iomap_write_actor);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 30f40145a9e9..30bb248e1d0d 100644
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
+#define IOMAP_UNCACHED		(1 << 6)
 
 struct iomap_ops {
 	/*
-- 
2.24.1

