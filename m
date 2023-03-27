Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196016CB253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 01:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC0X1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 19:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC0X1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:27:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B2B2D65
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id le6so9966385plb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=5YvhmYqFwE45/+fdIM6T0939zWYyiLrCUChhI1VxTnIXZgu/pY/DphMdHT8GDb2P/m
         Ifn/+I5Mvx9by3buCvH50D6DMfhJ6hCU7vnakXKXXs80hLsOnmapofA6KriW4MHi2Jsg
         C0UL+NH6GXdfOHP4CmusKWtZh1jKZrokS+qohYivmdUuDeIWv1uVCiJ179Gk4QcRdJeo
         HsCeq9ZMgk57P6/yTpOku9ptCjmHygwTZPbUBONzxGPGx27FSUqrltXqU7A3eguYqtVM
         67Scguz7uobyMNlDbyV+1u9QI6LrNCACs4lCS5Flhz9NIBPm2jTMaaHPeg87HLhJKNSJ
         vWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=IwJtiDOkWCm4f/AoqY4hQWpadQ69b0tqWhQngf7FvekFCq76wtokEXZbPQMrJ6CAGk
         jo+hT4RUD374H63rmNvFAMeqvLDW3ilvx5O96fJbaCroTFvSnrRh2NSofNytobE0ytCC
         TaR392OejvGI0OLtcbm0zw0meth4ycJvnqFxQCiVB76Y1U+fhs9zsjVEvs9ixuKyV6VD
         hnW76j3od3y6Vl1z4uaBliFW0bGKNn5ycgPamqOfNut5dgYt14TH6Iigdw1T6FVvhyit
         fgXW0J5Iu/DeApnsJa6jxDLSbyK4ettpUvEBIgUSmYpAx2BfEhxLbewI+wvfGEECWqnn
         nOTA==
X-Gm-Message-State: AAQBX9cLw2QyPmgTE3WGrNLA0X6Qh0ER0+yKAoM5Hh5F5ej6O4ivGph8
        u3ZnBpZy+hfFZ/geA/BCR1T7fRhUtVcglgmuCwUxGg==
X-Google-Smtp-Source: AKy350ZFClyDoyTKZ5x8f1bNy3rhtURN/DSsvCZ5i5mqgZ7TwDVVYbVTW+kFYyZTnw8vXcNu10UTOg==
X-Received: by 2002:a17:903:2844:b0:19a:7060:948 with SMTP id kq4-20020a170903284400b0019a70600948mr12044587plb.1.1679959647431;
        Mon, 27 Mar 2023 16:27:27 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm15534222plr.146.2023.03.27.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:27:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Mon, 27 Mar 2023 17:27:13 -0600
Message-Id: <20230327232713.313974-4-axboe@kernel.dk>
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

Add a special case to __import_iovec(), which imports a single segment
iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
to iterate than ITER_IOVEC, and for a single segment iovec, there's no
point in using a segmented iterator.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fc82cc42ffe6..63cf9997bd50 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1780,6 +1780,30 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
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
@@ -1788,6 +1812,9 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
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

