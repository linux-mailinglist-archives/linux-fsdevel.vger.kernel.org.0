Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849C6D0BB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjC3Qrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjC3QrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:17 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1ACDD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:17 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l9so10118739iln.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194836; x=1682786836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4CO9nZAOAEco+zmBX+Z9tyoqzZd7VU/Gm6MZ2qt56o=;
        b=4w6ImjJd/ECXjseQEXiaqQzKSKrICMv95OG9ACGS6Mc/kXe9K39lVbNQmw8nvjr1rV
         Dk0x/o+4toszbkCZeOVHPbTZZvV6yWvn14g6ATPbItPD6/E7l6b0/YNV9ZgcjDEa1NjE
         uCFIT7XKcjpiwhyYiqE9JBw1KOF2bcj2xD+MjCER8zRVshMdM22L1kzvF8g08bpLu+TR
         5O4vNhBdiZzJVde2GZRH/LzYr07Dca5GY/iQX7GfKRKwuMLRPyJu7PniU0oFq5pJt8Qy
         bMVWct0Ua3Z2XxmVvl5EhoImYIhtxlAdoAw1AnhpZ4s3vUwEsZiILmoT/B9Wm4/+RgsP
         C+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194836; x=1682786836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4CO9nZAOAEco+zmBX+Z9tyoqzZd7VU/Gm6MZ2qt56o=;
        b=38R3D12hpbsGSbfc7tqUHtFf1VHy9aNp410OA1EX2KUdGX4dXSk8SEg/2vmUNITGaj
         zCg7bPa15yhJvS0CFd3rUny3WxgsdE/BKOQDJ6EdsRLW8MeA5qFaF8GihgpFojKZvtSj
         IlfkU6AwX/A2C6Yfji5+r9wCicuZu8jk+vXp2xl95mRB9TrT9TEQIWwtHd7y/+68LsKt
         hIer8yAlB9IIbxjHQlzUNVFJjGPlpvYqWcm9WhNGwymZJ+A1KCXsoG2k/1hupxQzOze0
         HjQ+Yd2E5CmVySOz2BlneBBEHgo8g9Lr2Pv2Zn+uTLqRELwTAjImzd5eA5EQoB3mQf3C
         Syfg==
X-Gm-Message-State: AAQBX9fGOD2CTUzuXGXRpXOgo4DGM9adN+H4DI3pXPrdIO6gKjN7iFK2
        T6KJ4Mjtc/wbGQFCYhiYNJFoGe63zVU+djtx9Tl+fg==
X-Google-Smtp-Source: AKy350axa2/au8hKZ3lugR9MQwmlu+ZPl6YemGFkjrx6KNOrDeVa1N7BLtFF5pnaBphe80ufXS7JCg==
X-Received: by 2002:a05:6e02:dc8:b0:319:5431:5d5b with SMTP id l8-20020a056e020dc800b0031954315d5bmr1564313ilj.1.1680194836154;
        Thu, 30 Mar 2023 09:47:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Thu, 30 Mar 2023 10:47:02 -0600
Message-Id: <20230330164702.1647898-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
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

Add a special case to __import_iovec(), which imports a single segment
iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
to iterate than ITER_IOVEC, and for a single segment iovec, there's no
point in using a segmented iterator.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f411bda1171f..3e6c9bcfa612 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1784,6 +1784,30 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
 	return iov;
 }
 
+/*
+ * Single segment iovec supplied by the user, import it as ITER_UBUF.
+ */
+static ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
+				   struct iovec **iovp, struct iov_iter *i,
+				   bool compat)
+{
+	struct iovec *iov = *iovp;
+	ssize_t ret;
+
+	if (compat)
+		ret = copy_compat_iovec_from_user(iov, uvec, 1);
+	else
+		ret = copy_iovec_from_user(iov, uvec, 1);
+	if (unlikely(ret))
+		return ret;
+
+	ret = import_ubuf(type, iov->iov_base, iov->iov_len, i);
+	if (unlikely(ret))
+		return ret;
+	*iovp = NULL;
+	return i->count;
+}
+
 ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat)
@@ -1792,6 +1816,9 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 	unsigned long seg;
 	struct iovec *iov;
 
+	if (nr_segs == 1)
+		return __import_iovec_ubuf(type, uvec, iovp, i, compat);
+
 	iov = iovec_from_user(uvec, nr_segs, fast_segs, *iovp, compat);
 	if (IS_ERR(iov)) {
 		*iovp = NULL;
-- 
2.39.2

