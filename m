Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828726CF25C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC2SlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjC2SlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920142108
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:10 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s1so8568460ild.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/kB5PhUmthEnCoqu+yOus3Fb3oBVmbBoIv7KU060Co=;
        b=NJ+KQ3zxi/4UvbaJfWzuW7IIyB+5/n9vCN9CUy+htDOSpqTXm0RkWUHMFw10ybvQn9
         4B/Y+R+a0XonvaQZ0GRTNLVk6z+Eh5WbGUcnsRs1zF94rbmEBBYdWC1U8fvbbuUqLrFT
         RqRbkx+nzDfIVz6icy9YfPXJS4FQatMf+opioHRy8dk5KybXzJzUGFJq/vh47/vMX3I6
         Rnt5+TPE+hAP9GgNfe2plLM+6erd9jd4zpwpe1sVZh58/X6zefD7zjVgYOOdmABCADTW
         +4QBwZGhH7NzaAzijkTkzKpnUg8NNkaLNTnWEILqdKJO4Y7eIhJacoErcUj/DGIsugYn
         HemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/kB5PhUmthEnCoqu+yOus3Fb3oBVmbBoIv7KU060Co=;
        b=qNHPs7ndKYAxAsI8Xf2ofD9Dc8epIkBtCNN6AF8HHmQDoy6+Osv9WLYyY+RIq0R7TQ
         FidZtSKqSeez1xGaCBa5fbzP7pAuKfEWr1BxJ47UfE6HQvN6iaYrJhH9bP3vPllBP7Z8
         zOL+JvekYqHlovtdGbW8x5i++8ghCx13+b2kV69psDXV5U6gMmCw7mkTf/w2qG+EOAxO
         1MnIOPgCK5QQdSbQVORSGk9H1RH2GE9Jc87PaLCVIw9UMhvv7iJ5pWQtzVYFCgaGPHGM
         m+mksf6ud5UjsJzQtk5Cb/iRz4pDpvVoMVs78X1+clMQdp3zLhQ5ccGS3U18/FIHw2r9
         rvQg==
X-Gm-Message-State: AAQBX9cgi47s4YNifmEwztL7TyZKYQXaVMWNHdmg1s3W8Ejqjifz3pgh
        hGc0caWkWPfy4XWWN5eTTZRIialo7rmyHgwlmcPTuQ==
X-Google-Smtp-Source: AKy350bfpY8D4e+hOHv12oZYQKJ3c0vfhoQzGx5uO/+qtezIMlnc6aWhm5cZh7kMQXO8X+x8SCdwhA==
X-Received: by 2002:a05:6e02:ec1:b0:326:218d:6c14 with SMTP id i1-20020a056e020ec100b00326218d6c14mr2788509ilk.1.1680115269633;
        Wed, 29 Mar 2023 11:41:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Wed, 29 Mar 2023 12:40:54 -0600
Message-Id: <20230329184055.1307648-11-axboe@kernel.dk>
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

Since we're just importing a single vector, we don't have to turn it
into an ITER_IOVEC. Instead turn it into an ITER_UBUF, which is cheaper
to iterate.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 87488c4aad3f..f411bda1171f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1870,9 +1870,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
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

