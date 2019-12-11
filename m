Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17EFF11B145
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 16:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfLKP34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 10:29:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35575 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfLKP3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so1559209plp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es9BSJvoDpT3WZtR0L+ZV+Or+1xGCPbWn6QJpLr3Xx4=;
        b=b7eZVja6aKMDWQsCKiYnvs5qkkMtb4DoRhvZH0mwJvk9LESKsse6xmT3WWlILNTvSh
         v88npyxYy5/e7tLfGcgiIVXEYnv46FT50sPnEQt69UhDuyJOSuVNzLSlAXpUWTdkrJku
         nBpk9ZFk1qOaWPCwwhIIUbpQcT9k4a3aWUlDts7fPgZxFfbctK2wZluabjrrFqSzFkdb
         ugqNIWkF1i16/QrpWLX9gvSlMh+w4/NfxFGOtFaxQnCkEmSB/wopkF4l1CCYgv3FmwBY
         8JMlN5D7vigbmAU/36SNoC65YkKfas3+j+3P0Mey+EpgI+uJdC4zZ8pPIn6ofe48cSq8
         fYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es9BSJvoDpT3WZtR0L+ZV+Or+1xGCPbWn6QJpLr3Xx4=;
        b=OTql8V+lOizKMLIOFO14JClMsQxXBYBDZlvca5haTgRsTK9UWCbpmtmSqHe/WiVpfI
         j/xheoIwlB73dSY3qn/rDTMz6tO1uSM6Spoh6/xnvJvn3goSdcLKXDCQS7LhEhh3cxfd
         Q+ltQ9meIahPQHu8g+jZQfGfbVbIMfDP6SxCaOvYk+sokX6f9RM3OAFtk3NDVFVpl4+K
         0+7xYB/DrYHH5qqRLt22dUnIHaEe6uAUOh87gaI3VtfNWeYHNWDSrBsQ5/xn2FBsYjua
         g4roN3mxiwPkoUhdfeVoqNkC49Q9G5MGeHhCqJdbB7V5jMvpWqStW4DA18tImw3gKn/B
         m+OQ==
X-Gm-Message-State: APjAAAU34S2oCrSsccu/Som7PjIQkvFRsDOtjin/TjLCyjHgG2R2XSIu
        kGrnzftGTiy8xQJJA8AYGiUJ6w==
X-Google-Smtp-Source: APXvYqwO4KCx+Py7lrwxvyOY5WGp+WpfJGvARNpLtItIFsqOyOUndXtXBekGEuoMQQchwtmsNvTWrg==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr3929048plo.282.1576078193740;
        Wed, 11 Dec 2019 07:29:53 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Date:   Wed, 11 Dec 2019 08:29:41 -0700
Message-Id: <20191211152943.2933-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
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
index fe37bd2b2630..4dadd1a4ca7c 100644
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
@@ -3311,6 +3313,9 @@ ssize_t generic_perform_write(struct file *file,
 	ssize_t written = 0;
 	unsigned int flags = 0;
 
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		flags |= AOP_FLAG_UNCACHED;
+
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
@@ -3343,10 +3348,16 @@ ssize_t generic_perform_write(struct file *file,
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
@@ -3382,6 +3393,32 @@ ssize_t generic_perform_write(struct file *file,
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
2.24.0

