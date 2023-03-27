Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAEE6CB252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 01:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjC0X1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjC0X1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:27:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7E2D4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so10678087pjl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959646; x=1682551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=IajKLrMCXCjOZDwYufESbCKzfN53bE1qXlW3mAtwzWljdMtwRNMjPIkIMXMXItNH6r
         akEIBdQUNDvnIeQxVtxGvrZNVzEHKjSZLObDzxwGFILMaROEPn1w9bxYevtNn4CeAM7h
         Cte8OXuRU/hf7cmQxs1mLz+Y4MpoZLerSoLKlTtXPQOAbCwpD7KFFOpJamb9e6VWVYou
         wUYrdwpW1l4AP+jksxsnlnJBiCQY8CqaJd11f6UrXteXEDzg0c9glWP3o/j4afRx8Ncd
         xLlYU7XYIJ/fgW+LwTcKdA3IWPU86kZjegW043uFr+kbNo2LD1RZSveOf9gSPVTy6KFM
         arEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959646; x=1682551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=NDC5Ui+QiKfvWhbQh52bimXTuXHfAp+TMXDCxQzMBsd1c5LI+aPM9AVQ/mHjeoxMJx
         4xK09aXQejUx0TzL+mPsu6ltzgs5oOoLwA8MfkJSMAbz69Vnu2Yd9gvmKnpb20SQaK3b
         UQx6XWpUGIoa5XgR6LczzgF4XCKCD5pGoJtamzJOmF/dwWuXBetf3cARI2ce90ithPYx
         7qlSDV02mVYPTUlqddNDmuYVHihjUnD7X88V0noB+wixpJyr+t31ATv665cUOn9IVOFJ
         wmeLiDfX7sLcssdBbQaM+M2OFcTcRj1TyybtQhyCIGBdV6mabmbKu7BsqFokBhPDo0vb
         P9LQ==
X-Gm-Message-State: AAQBX9cW7wF/jLHndVmxtdWpWyELSJuNuzndKMlDuayRUa+pCScmp900
        zM1+LZJG36r6fFM092WyA4HY7xi9qy5N3NHBb1ZX5w==
X-Google-Smtp-Source: AKy350bIVuvrrc+yJODeBmexe/uN1gyoPZzM/3KsQCh0w6lJ4Jh1Jl0uRDUKlk2TcjOyEQcZaSWkgA==
X-Received: by 2002:a17:90a:644b:b0:233:b57f:23c5 with SMTP id y11-20020a17090a644b00b00233b57f23c5mr11511967pjm.2.1679959646443;
        Mon, 27 Mar 2023 16:27:26 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm15534222plr.146.2023.03.27.16.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:27:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Mon, 27 Mar 2023 17:27:12 -0600
Message-Id: <20230327232713.313974-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327232713.313974-1-axboe@kernel.dk>
References: <20230327232713.313974-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since we're just importing a single vector, we don't have to turn it
into an ITER_IOVEC. Instead turn it into an ITER_UBUF, which is cheaper
to iterate.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..fc82cc42ffe6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1866,9 +1866,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
 	if (unlikely(!access_ok(buf, len)))
 		return -EFAULT;
 
-	iov->iov_base = buf;
-	iov->iov_len = len;
-	iov_iter_init(i, rw, iov, 1, len);
+	iov_iter_ubuf(i, rw, buf, len);
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
-- 
2.39.2

