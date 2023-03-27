Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DC6CAC9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjC0SFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC0SE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:04:58 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271EB3A81
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso5196939f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=3EjGDt5/YbxFXYxnvhi7Sb3qTRKFQWxan3eGqdFzFwvjVRhSQCUim7vOVia6mKtAjd
         bB2vAUiuTmDg88jukpFFKOhOf381yB+jdqEIaEAjCOa9BIhuSI6tfu6XMXOgDIFFW+lo
         BhLxM4R0T4JwxYl3eSI+Nt0AT+feun3lGJlcuBrAV3m9Ic3HLE2VBO75LlUi5LIx4uau
         5Q/dRKx2EHICHPwjSmaJjV7QLkk7isw9pSsr9vzWgoJRZ3QThXMK/Fz0338HcWGCK0jW
         OWVChrzYa2qhneTK2LBxyQlUu4Tn7u1W1INcdaG/iMHUPQrbwnoXP76JSszA1SoPrPFD
         MyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=dpDYHh1bMNaPzhBGzM1KDHivSwCmtUhqqo1c1juSJeuWwbFhHMP5tRCIsMc4YGyaT1
         z0rWEw1ktrkgI8Qam89F1aA2gx0j0RBaOlA089Mg8o5X0NEa0gcAHfWTv+m3oo4GZX6W
         sVD0sWADzkpyd3hyPzc/sB+kG7A27cpuU2Y9xUxBLPUlgh4nG23dagPyiGyOC6kVwaiD
         3JNmBdZIp+HmU0bZAhq+7JP/bK3AG1x3qeXC7pY7ngnE1SRZV4AW5exMo+qN002ta7Sc
         bzfghgLXZxz3P+tPnwqbuBRe6vEl83myoONoTBSct1qwBEsn7ZYw04UHpSVnHDx6cwEV
         2NZg==
X-Gm-Message-State: AAQBX9e+DZy4OOohJ5XV2YhKGHSwUF4U/qWC7cO01duNN/v4WLeIKRCe
        koR4C6UJJLZ6GhFQhwS6Vy7YwhbRrOXfQbw/tjbTtA==
X-Google-Smtp-Source: AKy350aQJmrR+de0MRoP9/0Z2RHP0l/2slVlUluaT0k+KFu9KsOl1biHEGzFLNH9eilmnJ70zDXboQ==
X-Received: by 2002:a92:6701:0:b0:318:8674:be8 with SMTP id b1-20020a926701000000b0031886740be8mr5240414ilc.2.1679940297156;
        Mon, 27 Mar 2023 11:04:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e28-20020a0566380cdc00b0040634c51861sm8853235jak.132.2023.03.27.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:04:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Mon, 27 Mar 2023 12:04:48 -0600
Message-Id: <20230327180449.87382-4-axboe@kernel.dk>
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

