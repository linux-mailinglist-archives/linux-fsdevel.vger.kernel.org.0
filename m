Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8354122EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfLQOj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:57 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38835 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfLQOjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:54 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so8547061ilq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOt7OEDxASzJpz4aW2OtR1NM6hhZ1aYaA0R6ITxPWMg=;
        b=tLwP2zT0MtI2kOTe48uSomwZIjJUT0pySzMCDXzO1sNdjdjOCFI1XHkUHEOozqFc8c
         nD8w1OUooAyprmV1auAjotvgf/lwQQgtJmjU0OOuifVAcFA6tNABcFtRb6VTMGQNvXW8
         R+UIQQhagkuaIdQ7XtSKY2NXtNhP26jjoETMW/zxAtTmWwRpQW/LEGudNmZGscJC8QcP
         5bfFqpV+WXfMvXGjvCr86gr0YU9WkuoxK8tJyuGnk+U8na/TmrO8XsxhHpezKrsvh+V8
         wbxIlP/OlD3s6ghZTqeNhQeYNghwcPJnzfXH2JT64KUq2IgoyaXWFWMfddWHwG8HGDQK
         3y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOt7OEDxASzJpz4aW2OtR1NM6hhZ1aYaA0R6ITxPWMg=;
        b=nbaNJTkRN7BW0xETGnOC83IwWCJyh3S1kXnEvtqwZ3wG+N9J/Eevz0I93Fd0NNuVqI
         5tGfRgMU7cJ5ElJAE118qTQHT2IxPlXEvNoJc6A9TT8mlgJz4dxO3/g2HQbb0+A9ISkC
         lbElVNF1jemZqltC3sCP4lhGodo9m933WBQ6LCB2MIJKXBlIxtMDaso08JYvI68pjgLA
         TIJ1SIqX7J+/MhtuXB+Q24RrgmMQo9lZnMU1oTrMYIpP97oc7lnOgqEDQWwxBnDSNv07
         zZEBRGjPiQK/pscSysLLQNnuKAvViKjSJw5Cjif73m9JS5+Eya3ciFFCaSkfvkRjpijE
         UpXQ==
X-Gm-Message-State: APjAAAXDOw5iMthm/d9ppj96r7rDWnGgr0Jc7BdZTXQ1HbOkka5KpP0F
        Ai05WiNnHxV+O+MtZkwkqbLwZwwKYEa5FA==
X-Google-Smtp-Source: APXvYqy373igjl5RaNDqw4GXVKR/B2FPaCQeTRyE7cK02n7sdyI5xVepqdHZGKv7py+DgJxlDb4Q6Q==
X-Received: by 2002:a92:cb11:: with SMTP id s17mr10211920ilo.114.1576593593985;
        Tue, 17 Dec 2019 06:39:53 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] mm: make buffered writes work with RWF_UNCACHED
Date:   Tue, 17 Dec 2019 07:39:45 -0700
Message-Id: <20191217143948.26380-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
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
 include/linux/fs.h |  1 +
 mm/filemap.c       | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bf58db1bc032..5ea5fc167524 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -285,6 +285,7 @@ enum positive_aop_returns {
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
+#define AOP_FLAG_UNCACHED		0x0004
 
 /*
  * oh the beauties of C type declarations.
diff --git a/mm/filemap.c b/mm/filemap.c
index 522152ed86d8..0b5f29b30c34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3277,10 +3277,12 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
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
@@ -3301,6 +3303,9 @@ ssize_t generic_perform_write(struct file *file,
 	ssize_t written = 0;
 	unsigned int flags = 0;
 
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		flags |= AOP_FLAG_UNCACHED;
+
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
@@ -3333,10 +3338,16 @@ ssize_t generic_perform_write(struct file *file,
 			break;
 		}
 
+retry:
 		status = a_ops->write_begin(file, mapping, pos, bytes, flags,
 						&page, &fsdata);
-		if (unlikely(status < 0))
+		if (unlikely(status < 0)) {
+			if (status == -ENOMEM && (flags & AOP_FLAG_UNCACHED)) {
+				flags &= ~AOP_FLAG_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
@@ -3372,6 +3383,32 @@ ssize_t generic_perform_write(struct file *file,
 		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
 
+	if (written && (iocb->ki_flags & IOCB_UNCACHED)) {
+		loff_t end;
+
+		pos = iocb->ki_pos;
+		end = pos + written;
+
+		status = filemap_write_and_wait_range(mapping, pos, end);
+		if (status)
+			goto out;
+
+		/*
+		 * No pages were created for this range, we're done
+		 */
+		if (flags & AOP_FLAG_UNCACHED)
+			 goto out;
+
+		/*
+		 * Try to invalidate cache pages for the range we just wrote.
+		 * We don't care if invalidation fails as the write has still
+		 * worked and leaving clean uptodate pages in the page cache
+		 * isn't a corruption vector for uncached IO.
+		 */
+		 invalidate_inode_pages2_range(mapping,
+					pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	}
+out:
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_perform_write);
-- 
2.24.1

