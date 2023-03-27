Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A2A6CB251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC0X1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjC0X1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:27:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3B2723
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso10695850pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959645; x=1682551645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kguXiZPFcvLxJWrtyUvMfJvLBJN9Ay1HNtZpd3doRKU=;
        b=oudBH5W1YN7luLtpSU6havksFDdCltkYkitZ66kKZEwqtJauy6VPvCVeuVpvEurLEv
         s29FljZyUQJ7lWExCkoDNsRFq3+yBwse8uHXRlxNGbk2IuKmtAiItlA5FFTkBvBYrXCY
         CtGv1lNIrGpgZ91fxxvFQ+Vbzd2cSjqiqmAOTdPWZVbPBV4lVNUVsC1DHGf7puqRUFoO
         BJFeChHwj1Bzgrbg4wXhMngsCRL7beXhjWd0utPtemMXTQGGYIVaPtGBsf9p7JVIve6q
         xLTOKEeZZISK7n21wTpVI4vM5BJYPJGTM09Pw5Uf2OH/NgxISY8uNwxmeFd8ixpzNH4i
         M8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959645; x=1682551645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kguXiZPFcvLxJWrtyUvMfJvLBJN9Ay1HNtZpd3doRKU=;
        b=k4GMfVdY2rmFKtxwFnEiONRgreLeOFGOrBIfi+r5vsDOQu5CA46WGBNjmR8f/gkGzR
         OugwmNGYEv1oGL2jmJ99cJz6s/fiIVO/Qa75nrNRwU4evtCQfWdietkl49GhQIX9+1gv
         R5dcqlWtMCfLOww107VtMVDr+Qz8IBJdMps/VDvD0LZEUGdEbBZhta6uy5cSjue9McO/
         Jzoyv/pW8mpo11cxZmEWw0oFpMihYqlo1l11LYg9K+gCxg4Bd6DoeRcEbRsgyVTvB7dQ
         mgTojbGnySvfaPKhBRRDKB6NCvQwqPgYRu5ZX8RBnybR4/kkS8uYQ4yqLZT1K7qiyeZu
         AO2A==
X-Gm-Message-State: AAQBX9fpLdBX8Ov3w7eYr9rovmnBHEPJSDNgbJmM1Y2+2icC0eDRF3LS
        g0E52gV8bfejmHAjQd7j/6qnWYMEXlu6PwmGjoFXCA==
X-Google-Smtp-Source: AKy350ZZlUS/vQzXVfCu/6DG10e1c/E30kpBAbfbpaB5nPmBlRHTZQK7hLQUYFl+pUCRhkTaGyTc4g==
X-Received: by 2002:a17:902:b607:b0:1a2:6092:2193 with SMTP id b7-20020a170902b60700b001a260922193mr562802pls.4.1679959645229;
        Mon, 27 Mar 2023 16:27:25 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm15534222plr.146.2023.03.27.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:27:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] iov_iter: teach iov_iter_iovec() to deal with ITER_UBUF
Date:   Mon, 27 Mar 2023 17:27:11 -0600
Message-Id: <20230327232713.313974-2-axboe@kernel.dk>
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

