Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864C71E0213
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbgEXTWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbgEXTWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC49C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z64so3423165pfb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooHBrOZD/3Y3JOqiI+j5WGnGx9rNLKp4UPlTrA3k0fA=;
        b=OxFpYtFBwzHltasPWMU+lcpGv4rU/W2vOx/T4krzJTwDePkK92WnP8Q9D4KmLLpY6f
         Gd2powlWYp6amNjj/pqEmErKe4G4P2gbejJam6uJcPC941s8l3j4LkrKcWofDhf2REGi
         YTJZ81xesGaQk5qxaVPuAbcllAJUCMysF5nbqjuG4CmorTuNG9vIpk0d1uNk8acf8Rff
         1jlX4yGiljx2GdZ16Qma2k/cZGqRuC3kacJw2yDCzjvloXbodfZK/edA2Q6I/0OGROAn
         1nP5uZaH7v6Ns2RKRSS6SiYvJFi0QZwo9hTw2Aqe4//xgAmUbZgp7F+hMebtqROV82zc
         2Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooHBrOZD/3Y3JOqiI+j5WGnGx9rNLKp4UPlTrA3k0fA=;
        b=W2fJJVB4I+e2HOXBRhDqrLnOZ2bWM9BRWYq12fzvwZxGp3pPUlBlTPX0RMqIsz3PUU
         FsBg1XXLnu2XNT6CZ7VEcsiYwX4pmONCnfA+2mY66kI2z0P3TmCQM/biJwGh9/UZFsJ3
         lLN06zw4b3XyCEFg8i/+UPOq6+KPOU74KcXSjjFOKV5zhImq9t6yvKoooMKadZ1LOk5K
         iFjqHDk7t/olECreFzbDFbzzgcNU/3Grcv7oJiS4LAYW+LGiyQnAOuNz2qQwgEeWbx43
         XlbOSpaDU4/Tt3693pUnY1dt/VjB4oNSI+Xx4+O9vveUh4JW+8+ZYsiGNCfVZvlJq4bu
         vZxQ==
X-Gm-Message-State: AOAM530NA7Nsg8N3OJsuJawinMat7G4MRuqdkS0mWLzipIMQ4opmn0ep
        Vlt2EAGbdcTi4WO/9v9wbipbog==
X-Google-Smtp-Source: ABdhPJwRpkNyoDLEGaBTPeF9s7BrdfA7F20JjdHpfn1NdnYqPnUj6c2W2tKIFVS9+VwQSQs0Ka0myQ==
X-Received: by 2002:a63:381c:: with SMTP id f28mr22576826pga.361.1590348139455;
        Sun, 24 May 2020 12:22:19 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/12] mm: support async buffered reads in generic_file_buffered_read()
Date:   Sun, 24 May 2020 13:21:59 -0600
Message-Id: <20200524192206.4093-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c746541b1d49..18022de7dc33 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1219,6 +1219,14 @@ static int __wait_on_page_locked_async(struct page *page,
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
@@ -2058,17 +2066,25 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
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
@@ -2156,7 +2172,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
+		if (iocb->ki_flags & IOCB_WAITQ)
+			error = lock_page_async(page, iocb->ki_waitq);
+		else
+			error = lock_page_killable(page);
 		if (unlikely(error))
 			goto readpage_error;
 
-- 
2.26.2

