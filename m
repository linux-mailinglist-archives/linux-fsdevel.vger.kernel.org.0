Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23506CC95A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC1RgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC1RgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:19 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570DD50D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3230125dde5so421495ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kguXiZPFcvLxJWrtyUvMfJvLBJN9Ay1HNtZpd3doRKU=;
        b=BACQfHc0JtTyq2co22zooUZF48RVAPlk3hsZjdF4A0OR/lkF9alXKO1+mg/EU1OhTx
         07UrP7UgB8PjCvbEza0HSXeOnsCGUJ/gJL5ujbAK22J91Sm9ugavKYun2yvHA5MGXBp6
         +iSKblglwV67SpIHT3vPopDlhl3A3BUfETdP6rLQjn+2FC1iR28NB3nNrTXsklsQrxrU
         AjimNh0P3Yr0AY4mYco0VYrLXE6wXtaZr9NJzEVD0lwVSvLnV1vEO89X5AAZahHIlQGe
         21ob+7EdOV8xwvdeh3WfZUNgRONaczQN+dT9NmFScVHs3vU9qm7Z2TL2tioJlz3bD1Fj
         fM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kguXiZPFcvLxJWrtyUvMfJvLBJN9Ay1HNtZpd3doRKU=;
        b=zENVZI3IYNTsSWlYOCuDQSb8ssxTIBduiBfn3wr2zBjTve9uy0ejd8l2Rs7fSOgAhY
         y94KpkdOKwsi/0jGyergKbRxsEuOWNXiHNa6RDDvyYDtSgL3OLIjp3nEbyQJyMS2OGtw
         aiUhSC3ajYZrEdZ34l+ydIG0xGcLknu6muAL5Hf4UxbnN4sl2VMJk/nJ1f32NjCrJuAp
         /xmkmg7MRTnlFIDn86fha4omrgfoEIpJdUrzYEvQVZ8uKckHwhInMQeh8TpNewo6aUpz
         5vnMuSAzxVpmupqYfUlCA5Oy5dZCV5okrs7x3gw8VS70MFC52hcR1xXtrl63JaIrBMiu
         bWCw==
X-Gm-Message-State: AO0yUKW9a9tfCS4HHMYv+GtC4QL+1Fbxk4s9DUqQNmpwWbvC/pYN8WLL
        phF5jAW7PofEMQ92XX1BztEaxlRTl/GZU0XZurBzSQ==
X-Google-Smtp-Source: AK7set+kCEA/6Ti+bw0J0xQjLs3BVCf1MVRayD7+oTv2fvKwFhJEgLA5htndtW4MmCO39qkJx9DFrg==
X-Received: by 2002:a05:6602:2c82:b0:740:7d21:d96f with SMTP id i2-20020a0566022c8200b007407d21d96fmr10321949iow.1.1680024977535;
        Tue, 28 Mar 2023 10:36:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] iov_iter: teach iov_iter_iovec() to deal with ITER_UBUF
Date:   Tue, 28 Mar 2023 11:36:06 -0600
Message-Id: <20230328173613.555192-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328173613.555192-1-axboe@kernel.dk>
References: <20230328173613.555192-1-axboe@kernel.dk>
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

Even if we're returning an iovec, we can trivially fill it in with the
details from an ITER_UBUF as well. This enables loops that assume
ITER_IOVEC to deal with ITER_UBUF transparently.

This is done in preparation for automatically importing single segment
iovecs as ITER_UBUF.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..3b4403efcce1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -143,13 +143,29 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 	return ret;
 }
 
+/*
+ * Don't assume we're called with ITER_IOVEC, enable usage of ITER_UBUF
+ * as well by simply filling in the iovec.
+ */
 static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 {
-	return (struct iovec) {
-		.iov_base = iter->iov->iov_base + iter->iov_offset,
-		.iov_len = min(iter->count,
-			       iter->iov->iov_len - iter->iov_offset),
-	};
+	if (WARN_ON_ONCE(!iter->user_backed)) {
+		return (struct iovec) {
+			.iov_base = NULL,
+			.iov_len = 0
+		};
+	} else if (iter_is_ubuf(iter)) {
+		return (struct iovec) {
+			.iov_base = iter->ubuf + iter->iov_offset,
+			.iov_len = iter->count
+		};
+	} else {
+		return (struct iovec) {
+			.iov_base = iter->iov->iov_base + iter->iov_offset,
+			.iov_len = min(iter->count,
+				       iter->iov->iov_len - iter->iov_offset),
+		};
+	}
 }
 
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
-- 
2.39.2

