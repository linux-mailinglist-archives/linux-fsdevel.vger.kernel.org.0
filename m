Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC96CCC73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjC1V6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjC1V60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2A210CC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id iw3so13057077plb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040704; x=1682632704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=iEgLbG9r6XFXfGtaFXYy7mZRK4UqzdhYqC84CtABUu5KKp3+efJcbGIAJ1/LAf0hob
         tkYdnCYJrC5UcutiQ3Km4pyRNp/llUDC53N0dc4/jsCC/Tpq+tTaaRqTvOWb2d5gTaLS
         4h4cCxuvtVnNRV7ezypeBWbXyZgVkw+YFDb+bPgMGrbUovySXMoNbqVAmPkPyu+iwyRg
         8SP6JoLCEOPdTFKWUzOUXK3EXY1SgYayGpfptiz4jhQ7yhh4i6ciDS0lfGEhbVvWfgQv
         8FpAAwJPrdqgaJ4ZR8fM7r8sBCKviktOcUGFHpbQoPn8EDCCCLeZKiQU33RkhyWsha0O
         6NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040704; x=1682632704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNiZElylqd4oRsTQgc5WV3Ag1/Bvc2tTEOYDdozkUio=;
        b=wudn5dypM4SlADKco1ifJMiBvBG6AeBaaGMYbqE4QsTHQ0ZfY/vH0dFvZwTV1a2w8L
         a8wQL69BtVqVCBilD88VDVdxAVjDDL25xEMUtWFVtF6dwyBK3VDYlaTu3QvsnUwe6K5N
         tBdYbxsxtdznZnertRzfDpACkAcwDSrNbr2PzYMwYMMCPhgi3MBC2yq5wslOG3YjVhmN
         bEsPbHW+EqBb20rhKuLB9IOX/aXm8bjNnIjDlzBuUOqsmtFTAO9PT1kaBfHjbmVqB2R1
         OAzlnifvjBiHVD2Z7n7ljyudrsHcr1iUfa455gaE2oW5ewQAnlGco/vKDGDfONXnBiWa
         R11w==
X-Gm-Message-State: AAQBX9fTkjAXKaJr2onoJZ0D+LK/mG3xste4daRW9qOAhdXY7ibc7jcF
        OU9Zo5JTKuiXwiytY6DUTtLSL3kLxx9VL5O4FG+R6Q==
X-Google-Smtp-Source: AKy350aBZmSxVCYzTJ87/4lMPgOjJSn67tUb/ixJ/7DpMtLCk4TXH9KmIYAMrrF9JHYn/MfDrF0xwg==
X-Received: by 2002:a17:902:f943:b0:19a:839d:b67a with SMTP id kx3-20020a170902f94300b0019a839db67amr14620207plb.5.1680040704275;
        Tue, 28 Mar 2023 14:58:24 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/9] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Tue, 28 Mar 2023 15:58:10 -0600
Message-Id: <20230328215811.903557-9-axboe@kernel.dk>
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

