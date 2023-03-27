Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F596CAC9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjC0SFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjC0SE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:04:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050103AAC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso5197139f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=c53GxGsaME1PuxlxsP1Vkgso5etFHpCP8C3QispDf2mjuqP0jv2NRJvHlsmpgTT8yr
         qMd8w8M2rdWb4vo//MSvfGx2Q3qfXywpzUj7PdSHJF2rNW1oN0jgIZ80s29Jby2IZtwK
         itw+wc/ET9ZgwOG8FTSLS3J7WFZqW9T9AVPvajCFVqN8lltH9N1u/2GPGsYo0uiJR9FF
         Tk1w9TZHP3sqORGFlmdLiVb5wb2Zh0fvsloFEhETrN/iOXJJDGCFtmBioAQh1Yde+tu1
         QtFI8waLbjQlcFVemgtprDChu4E9Uh6Sxd/9c2EPYcUmhFNp3dGKgiN54CdOKy9oe7e6
         XN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=drLGTtI2TCR2RrjLvL7q0HzQEKa/G/ROgixYVxJPmU/xFROt7rdOzS/ZUevSwRmCHv
         5ecTFxJbpxhqjIyUhjYZERaJXkUd7MtZXir/JP0SediYYTtCS2ak2aus/YO3fU4+oF68
         HWnsAIfoqezqZN5oW1N6jDcOcPdmBJS6qZbDIQKpSaKF7nmOOGpTrTYbFt2A81XgbACm
         /9hPe8W1pwQbbvPze/Typ1vdo0LRT6mB2XD0pAxlKpY3Z4Zuzh6lmHan+nVtIGhFZqZc
         ioLjR+sY6enfqs6ZxszB//L4ASsVKHOrK9ZHsD44iuspSSdZ27Ko7uUKpJceKZkvG1CC
         UfUg==
X-Gm-Message-State: AO0yUKUtvGNvDh09zNfs/jN3gdb3Iyj8pcza5j2RIuptIhw/YdgQ6jO0
        1CK4QrcRN3MGCX2IL8O5vrWDgDrx3mUhB2FCO5dk5g==
X-Google-Smtp-Source: AK7set/RwkNZtja9qv8eRxy3SfWj5mxh8eSuD7R/eplf4EodBLpNHsTFWpSUcfl3XbHWQpv0mHIS3g==
X-Received: by 2002:a05:6602:2d87:b0:759:485:41d with SMTP id k7-20020a0566022d8700b007590485041dmr7343013iow.0.1679940298064;
        Mon, 27 Mar 2023 11:04:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e28-20020a0566380cdc00b0040634c51861sm8853235jak.132.2023.03.27.11.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:04:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Mon, 27 Mar 2023 12:04:49 -0600
Message-Id: <20230327180449.87382-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327180449.87382-1-axboe@kernel.dk>
References: <20230327180449.87382-1-axboe@kernel.dk>
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

