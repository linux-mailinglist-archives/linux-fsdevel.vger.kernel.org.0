Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4654711D691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfLLTBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:42 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40510 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLTBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:42 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so2941111ila.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3zF2IoLkG99aJLG3KAoCKldE2uwFDYuWKBNVHHKeAg=;
        b=haFgiW36qK83MkfbXn59ksnSEeEsdMHyWL9vgaQPI/2M7BzIcgSEL5tmvJUk3CVyL9
         gaIUjsxIuvc2Scx+pXvX18Vol2DgeB6lck/Md1S9G8ORheTieuSd5A3FA09ZBu9H7LwU
         y8V5EwFbsXEx36zibedzoA5a9jooRrvi1Vufw6Bd6hsBuKZPJZHp7Qw3uMUUMmhZ5WTD
         jijcETsNbJTE6e2rQ/pBA1N0y4a+Prc5V7u02l8GVhZMpObLBF+CWkI4cN+2hZd+ZVU7
         v0wh3XrdAMhdaZNFvhnzz8UZY6e+m1OGDnOo39MZvia9Cgm5RurFCcDKsOl4s4SvRxAt
         X6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3zF2IoLkG99aJLG3KAoCKldE2uwFDYuWKBNVHHKeAg=;
        b=UqGVyJdTNjY1skLsBycuioFW1qAwppYqQ6k1ezVltOl5QvvgRRTs2l05KiuhSiYRNL
         mW9dItLlDeheBqMkRWxi8TQo06ecR2cdocQ4TkMn61j/vaa7M08A0wjT44ifbCcMBBm4
         nb6W8/Wa9Zp2Imvi3364VIeVRcw/KCSuHFNtAc0UI978A26+9hT+pcGdi7QBJuokH4Pb
         stpJ7xiVvtPJa5eCCwNxIGJ7Yo4BYH7z/+5BH43cm/SkUQ9NUH4GgADszRzbhAXCEgdw
         Wtz8RvTQPCtCy9eUJRxGDhOkN3iJKQ/xdZ6OTmHKH6HpFU0PNrt6/HwMCnHalR01k/1N
         gRVg==
X-Gm-Message-State: APjAAAVFHZbKioeXaEN4+X2wZ3XW4yIGA5m1NO8GrGSEJtJcgU5F8fu1
        HBWAmhcWGY6ga7o82Nc9GwO2HA==
X-Google-Smtp-Source: APXvYqy4Ha1ZPT0wkuEbZwzKrQRha4JXZvcnVJOgvUSyZMjxrG63y4ujfU5A0qzhnHglt6gsLEgwZw==
X-Received: by 2002:a92:4781:: with SMTP id e1mr9348975ilk.147.1576177301694;
        Thu, 12 Dec 2019 11:01:41 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Date:   Thu, 12 Dec 2019 12:01:31 -0700
Message-Id: <20191212190133.18473-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
References: <20191212190133.18473-1-axboe@kernel.dk>
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
index 00b8e87fb9cf..fbcd4537979d 100644
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

