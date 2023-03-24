Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668976C8704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 21:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjCXUo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjCXUoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:44:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76FAF38
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so2524496pjk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679690689; x=1682282689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=1jQI1rntbGp4LT8Q/vDlFUvDa8D1jBQ+wWLS4DUAwTf9EwaNgwc/yImIbXtM63rDLC
         2AeLgfc94BtGCbJYOzjucQa2FAe7BFANf2WRJRDzA8zbY5zIjEvejivqdOk21lVhKA9R
         9X+9lJUk036RvdxvFYkkYttu44mUgJ60VKdMLqfcAxrtXfXtEvyGx/pc9vzxQvzkzX9D
         HmuwFUv1h7y1MO4Qu3wwXO96Fg0GEx2Oc/luCJgWs61OBxXVEbvZq/AbyAjAYKBQovRI
         pCyfO4t+LIehUZwX+OI0brDVerUhaA3ceDIV4ZGcJcUOEpWBj9zNF+5Sg6I4IZgBElUP
         mt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690689; x=1682282689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=ZGigI6TUDbPrPZRKbarBTDyBm7fp9Bx1shANj3BLVVf+Fz78rBGAu5/CJXXSQTJtje
         FWVOaz+2AgzAorCmLwNLdo8qK9axUBwLdxwVFMIrmsedqFYPZZ0Y/p52H6zzPdUcQAqr
         eDoPuIHIghkt6r4Glst8r8BYWWQGRtgcD6EnfQJkQoogpsHgQFcXzkmFZYsMLKsH3dkI
         okTC026IksoQGbat21NuHHPy/bPR+CcHv3vM7yjOMtCDi4zAu/+ikfKNInirXgsB7/JD
         7Qhna6L8Tcq04rPCySh4jnUhcChIcYF9QkLATo2QicWmJ2vOat8BcbB2JUQEbW0l85sh
         lX1g==
X-Gm-Message-State: AAQBX9dfaJfO4Yn5yt7acI1CFxQxihammqicTIJZ7vmAW3nfKoMQzrEG
        3XmXaAAYy/ruPi+qpEwEjrjQ2Hsdj+1VSnfEYBOcPw==
X-Google-Smtp-Source: AKy350ajPLouZV/V5pcUyPa5q49J8SiHt+D2LmNTScm3eGWKsnp68sbw937uXZuu6QA83L0977U6OA==
X-Received: by 2002:a17:902:7c0d:b0:1a0:7663:731b with SMTP id x13-20020a1709027c0d00b001a07663731bmr3294395pll.5.1679690688920;
        Fri, 24 Mar 2023 13:44:48 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b0019a87ede846sm14605344plb.285.2023.03.24.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:44:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Fri, 24 Mar 2023 14:44:42 -0600
Message-Id: <20230324204443.45950-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324204443.45950-1-axboe@kernel.dk>
References: <20230324204443.45950-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

