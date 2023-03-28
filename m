Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D426E6CCC6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjC1V6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC1V6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CDADE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a25eabf3f1so892365ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLSXksapHQJHwuesIk/XJE3QbuW+vdF3HCe0ZJppDrI=;
        b=oVPmmwlI2dvn8+WmkC37EqP4r+18J/8/XG5fJd5DqPym0TTne/xJSDXPmaYIADKlHQ
         o/XezQjHqI5SuTTNF/dwFVkoCwvOHDYnqnsTX5OTq7ap7m4eRXN6GgYpNjaidhlJeBOk
         iTvWnPlzFAKYZKtKtKo+Q0tQDCvmYyPu0YSlxjKnQfRqCxecXpQe0IbKC5abGAs79ziR
         0HULkSUdZedgR7pGiM3obIGSVnjAvvOKqKSGab6vTZi07MUyNcQsJ6Pj3YGQmWUMZppC
         t46JgsEdoQqc2whuLXhAjE4VFM1PEOZTQz6scloYkX+fYy8MebZJUitiASH594TswI1o
         U2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLSXksapHQJHwuesIk/XJE3QbuW+vdF3HCe0ZJppDrI=;
        b=e1KaQX6GihXkTC5OMYj0HaYjAghS+fh4Pdh2TbYHL21hZcA/7DTXqgYSl3NdvwGKJd
         1OYHDp7MHl2nXaLjZY/bJHMGTFJ5gg1f6huU8g+G0i89+lCl6YYg6SPTe5bSMYHmMCfR
         Ldx09hEpgYeCEJ6v7rTMSKwA5n/9qNTj5OPiPsjhedx10RDAAciEFAPuJSs8KTpoUZ+b
         1HnASi5kTkSwWGwS6cfS7X2P3MgPT7+UCHPCcb34WOsAJrcHU6e/00xJs0IMvU2JWOPO
         q91D0/9xaKQlmQX0/NMBVBRVCorrky3KDMMDUUu4ibbhUHyIf7aHcUTuQDcTz1bs35UF
         b7RQ==
X-Gm-Message-State: AAQBX9d1qhb+2rZZzxQ7LuqL3DZ4nMdT4CDczy2V4S3Y7+9IbESDgc1I
        0GR/7VeNd2ZEAwNAdoTBFJsesbF9jVP1ij4jWH71+Q==
X-Google-Smtp-Source: AKy350YpPlylR1kkDcOiYdyCp8k1z5f6to2vT+vKUXz/rFvQwCn6momKviBLdxto084ZL81BpBEOaw==
X-Received: by 2002:a17:902:864b:b0:1a1:d395:e85c with SMTP id y11-20020a170902864b00b001a1d395e85cmr14142422plt.0.1680040696742;
        Tue, 28 Mar 2023 14:58:16 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] iov_iter: teach iov_iter_iovec() to deal with ITER_UBUF
Date:   Tue, 28 Mar 2023 15:58:04 -0600
Message-Id: <20230328215811.903557-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328215811.903557-1-axboe@kernel.dk>
References: <20230328215811.903557-1-axboe@kernel.dk>
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

