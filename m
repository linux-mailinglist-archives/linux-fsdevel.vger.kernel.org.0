Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986351DF096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgEVUYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbgEVUXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC3C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so5460414pjd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pk0mOQuIM8W3goGTEUJ7lPQkF+2EvbiQPRxtP96y/VQ=;
        b=XR1Hfpngk92X60W6mtjRxmwWQjUpXxr57sMRlRMp6WKXl0EGRM1SyAOYAgYY/8k15p
         InaZ+j7vcNDYMPyNeT3pDlSC7+7MpYvudX2nOoV8UHce1YTszpzP9mKmUYM9+1SSZXq5
         luaLISz3wcOf7+VgrtBaX5me2bW3GJ2GmAjc5UYbYKCQVBBAfA0DmjLo7fD31fEdUXGr
         jHzVrF/TM6JPGmvwNE0mpRc+1IJz9vT6u7Y4z3e0+t6sID85Socj7145P1lc8My6fsi2
         kejNXdw85Mje1pDKxQKcH2qKiA+KYZmlq8rNRp4E3T8t8Bj9P56S+c++YndQX8+ING/I
         WFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pk0mOQuIM8W3goGTEUJ7lPQkF+2EvbiQPRxtP96y/VQ=;
        b=ZGHn1lYwDbhTDAZKLOynWrDQsYi9/V2IhXG/VsIV8di0yAiiu4rQPqbUQNffK/0jAH
         s3QMdU5r+4yA6CYJvGlVymIE9WE2bAz1o8lQcTK9tgbFNlsCFfM4cCsfhbENtRB7c1TG
         EJUhgB5kMwqQu46W1+/CDc59DJI4k+bA7BaOdMEVYphHSZ+Z30BOwBWCmLxmr+Wcs+Gy
         sKfbuG2/wiqZOPVunWqGE4K80Lnw70Jq5bWmUpFH+ijPoEDdqnbmuA71uJHSxpp/lx/3
         R8WIXbtj1+Qr/b92pqGB8CNIaTkSYfnALt2eh3Gk+Az2SmF6aknoeI/nTVlrdoznWROa
         7GKg==
X-Gm-Message-State: AOAM533m491OeBRZYzTQKerMFaC4nyOpZYkyFrEI5AAKAZC4iQl6CDaI
        MfqCKnpyQy5VZ2bUt8XYEt3OIFFay5M=
X-Google-Smtp-Source: ABdhPJwS7xFlgv35cRDBhVL35NxCpOL//x8P0nJbD9YCPQRRanDgUxHWeCBsTZZ0WIpa+r85qBpFhw==
X-Received: by 2002:a17:90a:c594:: with SMTP id l20mr6422753pjt.123.1590179003224;
        Fri, 22 May 2020 13:23:23 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] mm: support async buffered reads in generic_file_buffered_read()
Date:   Fri, 22 May 2020 14:23:04 -0600
Message-Id: <20200522202311.10959-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
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
 mm/filemap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0bc77f431bea..d9d65c74b2f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2074,17 +2074,25 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
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
+								iocb->private);
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
@@ -2172,7 +2180,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
+		if (iocb->ki_flags & IOCB_WAITQ)
+			error = lock_page_async(page, iocb->private);
+		else
+			error = lock_page_killable(page);
 		if (unlikely(error))
 			goto readpage_error;
 
-- 
2.26.2

