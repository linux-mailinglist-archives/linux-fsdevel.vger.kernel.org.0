Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530876CF25B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC2SlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjC2SlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C330D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k17so7251870iob.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115270; x=1682707270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4CO9nZAOAEco+zmBX+Z9tyoqzZd7VU/Gm6MZ2qt56o=;
        b=D/5ASckaf9bmeXQFyqcdTogslw5IeiU+xWykjuvsXK0mkhQvzu9TjlOnSrqsslmXiV
         YEYCJa3SS+i6eFCs5Tzs/Z3gciOEiFbUZ9OLlyijYb1jYMmwRWC092RVGt7YBwUHfdQ7
         AQv2ndCagPn82WTvL6unRZmwFnHMuxAMNYxeTpARBHmI/yzTO9NgSIMKSDSCO/UW6vew
         TJbpVAf3i7CPneRozC0Rsir1My+hu7IfxreiYeQlk19Xq6dc7MqbWo1RlSiRF4t/LLxF
         U9EsyHsrVFhXIXaCykWeljjoIEisZ/hVrvAhS74g00y1FLwaOJEn5L0WKCQf+a46G/Bx
         235A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115270; x=1682707270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4CO9nZAOAEco+zmBX+Z9tyoqzZd7VU/Gm6MZ2qt56o=;
        b=umDP8c1PRBbF9iiRcfdNVtJQ6OMgWMw50bVrpAefz3nXDBD3LJtMGQMVtbY31AjIm3
         4YlfzwoI7Wc+/CYZdap/1vc3G11SVVnybd6aYsOwURtLXa1U91jf2L33Ji260jHJiCUU
         j/EF9BUif/vnU7NSewiChnpI0k1/zMEYKcs+MTr6fcmjAzHiVFA/qGmyFAS85dvumDO+
         dFwuCobJH1vDoIHqyqDqnGNdYFCGqmcbiaj0/vFDu2lw77IoUOQElSnFeJAaxvW8OZ9X
         b6FH80//ErHmpoOB2/w9Xw516CHGTUY6vTjauQI5joTiDU0ZTligbXAVIbTWmSBwxd21
         DyKw==
X-Gm-Message-State: AO0yUKUHXErGkHZAkVbmlB2IKj0TjkuQ5OXEkB7Qsh+xDdJcbOJri4Hb
        QTQJhfWJR4jfkgGBPRDpaCgFOmaG0e9/fVdTShrHug==
X-Google-Smtp-Source: AK7set8s6XH1rW3hkG7I+hLmnxVFSRTZwvgT9dcWQn8IU4XmhJybOycFMg7y2SAPkX/0pIZJEbZnag==
X-Received: by 2002:a05:6602:72c:b0:719:6a2:99d8 with SMTP id g12-20020a056602072c00b0071906a299d8mr9141433iox.0.1680115270601;
        Wed, 29 Mar 2023 11:41:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Wed, 29 Mar 2023 12:40:55 -0600
Message-Id: <20230329184055.1307648-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
References: <20230329184055.1307648-1-axboe@kernel.dk>
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

