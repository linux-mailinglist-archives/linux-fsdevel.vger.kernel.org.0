Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E401FF534
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgFROpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbgFROoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8DC0617B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so2891175pfc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=UWm+xgAJblrksR6J1tnnSoleBzj4zdmtzBmjubOyR4o=;
        b=hm30VxENfZId4iIBXYzmK7NVLqG1L452OFVsVzBNxCcZsqrbma8q5o0CvvJElY7+8p
         Vs3+SDv61eWDJjcgEcNeNVdRAryioKuqAY0VZ5KUIBPne3UmEh/fpO8LsZt7zLrRhbVF
         r+xLfZ3r0wJVLTx1JAQn8WOQ4kpy0vI/zExZIzz2SQwYuNPeL12OnD2ggCtzoLOv29Ic
         dmRtYj8kmpp8on0fqufKHzxL4rQ9UdLZGMuQ6WCXYxQiYiLwh6uMWp6HgQzG+k87uazV
         SyI82aOrSqK4C/Ej6hlCmtBJKK+kxn+LVz6hW8Too2R1mZqI9Blhbsn1DdgKctf5HYDC
         n8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=UWm+xgAJblrksR6J1tnnSoleBzj4zdmtzBmjubOyR4o=;
        b=QKQ7bSqnnqUY9MrROgXssQVwV4Ic5BvTmzqF1HQZq4oUnuj340GQmZOYCo6fT25+Jn
         VZB7447JieOM3bUQ6QpCqiI3uucxkAyWYS8Lxzp+QO2kzTmTeJKiMyQI/rNkRlyKJzb0
         g+CA9o83n4R1cHWupSly4TyZp5npkK/H6xgfPsU8qrJoh3WSYRb9QFld15rTf6MMaQq5
         cgGjCgKHkv1oibHzlUqk47Z2fZ6VHFOrWii84SJXlaKuP0N29TmRpO3PaOE/N4UjjQ9N
         d40mElvrdu2oV9OM88G6auoYwABAp/qbDhiTfHCxwnT4n8JpDjb1fL2d/n7sh3Hs3q0h
         QDTA==
X-Gm-Message-State: AOAM533p7tlMAcNNPvwMOiuP6Cn/dxvL/hmy7/uNBGuP/p7cCRuve1Bw
        bixiuQA0KU+rECki1CWQ1fOpCw==
X-Google-Smtp-Source: ABdhPJw0BKfA7CBOC1lO1/wFQlqefNyxHA+f5iR+FuKvtS2xAVdcBGbcEewx+yzDvjoPb4DPsIu+/g==
X-Received: by 2002:a63:931b:: with SMTP id b27mr3478644pge.135.1592491450319;
        Thu, 18 Jun 2020 07:44:10 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 08/15] mm: support async buffered reads in generic_file_buffered_read()
Date:   Thu, 18 Jun 2020 08:43:48 -0600
Message-Id: <20200618144355.17324-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the async page locking infrastructure, if IOCB_WAITQ is set in the
passed in iocb. The caller must expect an -EIOCBQUEUED return value,
which means that IO is started but not done yet. This is similar to how
O_DIRECT signals the same operation. Once the callback is received by
the caller for IO completion, the caller must retry the operation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e8aaf43bee9f..a5b1fa8f7ce4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1210,6 +1210,14 @@ static int __wait_on_page_locked_async(struct page *page,
 	return ret;
 }
 
+static int wait_on_page_locked_async(struct page *page,
+				     struct wait_page_queue *wait)
+{
+	if (!PageLocked(page))
+		return 0;
+	return __wait_on_page_locked_async(compound_head(page), wait, false);
+}
+
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
  * @page: The page to wait for.
@@ -2049,17 +2057,25 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
-				put_page(page);
-				goto would_block;
-			}
-
 			/*
 			 * See comment in do_read_cache_page on why
 			 * wait_on_page_locked is used to avoid unnecessarily
 			 * serialisations and why it's safe.
 			 */
-			error = wait_on_page_locked_killable(page);
+			if (iocb->ki_flags & IOCB_WAITQ) {
+				if (written) {
+					put_page(page);
+					goto out;
+				}
+				error = wait_on_page_locked_async(page,
+								iocb->ki_waitq);
+			} else {
+				if (iocb->ki_flags & IOCB_NOWAIT) {
+					put_page(page);
+					goto would_block;
+				}
+				error = wait_on_page_locked_killable(page);
+			}
 			if (unlikely(error))
 				goto readpage_error;
 			if (PageUptodate(page))
@@ -2147,7 +2163,10 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
+		if (iocb->ki_flags & IOCB_WAITQ)
+			error = lock_page_async(page, iocb->ki_waitq);
+		else
+			error = lock_page_killable(page);
 		if (unlikely(error))
 			goto readpage_error;
 
@@ -2190,10 +2209,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		}
 
 		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_WAITQ)
-				error = lock_page_async(page, iocb->ki_waitq);
-			else
-				error = lock_page_killable(page);
+			error = lock_page_killable(page);
 			if (unlikely(error))
 				goto readpage_error;
 			if (!PageUptodate(page)) {
-- 
2.27.0

