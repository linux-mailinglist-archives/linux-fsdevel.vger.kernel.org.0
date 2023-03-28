Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBE6CC963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC1Rge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC1RgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:25 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05348DBC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:25 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r4so6715946ilt.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024984; x=1682616984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=BI8hfl+CiitYpdnkPcVnUgegUqZlouG3QSCBfG9DFA0nNSGrunJY088Y1iE3b25nT8
         vrYps9cKkGZc9dVYN+GTCs/40hnrVgSCtptGg+4QVef5zzI4re8ZU5KQQgbACpcaPXXE
         FZNppFiMKiOG3UBXL9e8OW9Qa1f1UP/9x0U84oI4S70SHdsyPqVZOKZvso3UCoGdDlJo
         YdnwoiHRVluIo97ZviBmPvWTTK32JnY5m5MY3sXdD5TgT8wAoIK6fHKqIjSGUZM3wcoT
         GNaCVkfUCNF+lpIYCax8MyxIixmMqnKOvzdmWcALQPYROM6Kr86/hCIfSNxOmnugWslc
         /w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024984; x=1682616984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=ZFxJqI7G//YWt1EZFckQyu6wScEe7bv+PDsv2tY5VeVpwiVNJajiG4tTcq3Vt7Eqbx
         frcUkL41uICue4VH1qON16rmy7qnUh+/bsHCYcH6qfN1GdCm+g4YJy7hT4XRykuPYBOH
         8fEYXHiUH5yBcAp/94fDTsdCTJ+aCpIBlWG8U0gFHqgihdderMB+KhiuYNMoJZExoDRP
         hw3FmA65kCHblez17WmkSjP7JpQ3VOn6kp5S0tEZPB4dbfHdnVtgH7NgLtjg8wwnQ4jz
         H2fdKpgNOPrtwykVdTBRx8q26V+mqZHkzIhiMPRdfIhtHzIFys55qCbbHS5LC/8Tlbw8
         BztA==
X-Gm-Message-State: AAQBX9fkqPFAi7clVQIWV21njAdRalf09FTzxfR/tKQIgJbb5hWQVHbS
        kz4+5QNte45KR+tdjLmMbjWyRrD6QnOnMWMk4TkNSQ==
X-Google-Smtp-Source: AKy350bivxXUnmoww1f+N8VP5Fwqw/aCwTds3RdSAT1ZEz5A5O7TFf5C8IQq36lwlB5lZn3UrOV5rg==
X-Received: by 2002:a05:6e02:88c:b0:325:c88b:79b6 with SMTP id z12-20020a056e02088c00b00325c88b79b6mr8857121ils.2.1680024984093;
        Tue, 28 Mar 2023 10:36:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Tue, 28 Mar 2023 11:36:13 -0600
Message-Id: <20230328173613.555192-9-axboe@kernel.dk>
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

