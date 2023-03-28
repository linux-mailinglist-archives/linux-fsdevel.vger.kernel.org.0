Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897B06CC961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjC1Rgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjC1RgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F400D52E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d22so4657140iow.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024983; x=1682616983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=pT8ktMSFhDLu8ROs3hlcIIFLQA9c7pJphrhLxeCiX6sTdP+QmoRgQZrW43liuOFHCY
         iypi62DSY9NM6ZC/v6PjBJVXjpy2QEEE+1/uHxUwKUrH3yKKrviC8jKhsMtRUgExYr33
         pcF8Kp4utptLUEabfZm4EqCS/5aWWK2Z0FoySU+Xwui6kPF3z0OVIX+O4H2TawaF/AEY
         1FPLkDMH7gfDmE0XOp6pUjiKrrT2lWN0+KuFVr8WvEX3KRGDri2jBL42g4GAtVVfrbu6
         xrdcHTDGAjUNxuwUwIXJIyKtaRlaIWv67E1a7T8+gbFZb6MxY7/oRZmpt1vB1HDlDxqx
         hDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024983; x=1682616983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=qNXHH/V4G6j0hyqfCLN1zfFzheoINPfis+KN8qMeOxP1EQ4bjelsmd6aCgUS/TV1y0
         MA6z8ieuu+ABdvE4m6Ms4nSL101vRt+NCN8b8rHLYz3kYGxQW9iI5GAuX7EDNve/YIKJ
         bcwAT5/W7fAWEhxmfc0TYufLxrah4OpZ8X6qa1PTmGtO84Pmq6kkIL9uCpzFkKauk+rm
         CGRAS0rsYtDa7m5yStoVDf49yN1jw3XyNpC0RwihGZYzkwU6cXMjWKG1CiVB2h4KdYcF
         pvEYmXhUqbiTzj39nDeAyly1IGrftJA73OpUTGFaSVKs0mIRaZLN7m8E3PH8QrKPFYg5
         wjNw==
X-Gm-Message-State: AO0yUKUgVBY4fENCQNITWfBrql7DFlu++E0dWa2x4iZLce0Z/+vWoTsK
        x8cbokriT1ygJh5+KjYoLQMomple1ctplUv4mW9TUA==
X-Google-Smtp-Source: AK7set8b/NbFUGqeeN1a6ECQP6ujpIqXhcqKrzQyLA5JTrtvfc0SRc7JTHVcWrPu4CdwjU0GIwODEA==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr11766606iow.2.1680024983235;
        Tue, 28 Mar 2023 10:36:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Tue, 28 Mar 2023 11:36:12 -0600
Message-Id: <20230328173613.555192-8-axboe@kernel.dk>
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

