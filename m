Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB2D6CF257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjC2SlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjC2SlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5728186
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i3so669820iow.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115265; x=1682707265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqvAB6d8goa2TAcTv+sr3+77aiqYZ9Ym4nn/6JW4p+g=;
        b=2yUWt0xYDEJ7bCONaqqAHkStl/lIzPiBlubuf1kcx1og/Y4amwtqr1sJmWQKaaFUEn
         BQY/smQbMfRLRZzTGx4kMhDxHkEB4f2CyB3LsiWE3+8dzRIk4PTCRLrZ7y5uuPxyGmPX
         CJ0KWXRn/egJxsft6CtHrSk5CfD45h0d21AeeUbQbgk9xMZ+Zbn+MB0o0cufBXpxexdy
         KLcBj1lVtIaxEvLv/UTizgX8cTK2LdsSBlPZdG16HKRYr4xv6LD3m9dUdoBRagIBZN1R
         FYsdGx93qLuVCsub1DD+WYRZO0nWpFaBg3ninY0eMg+kGQ7Zn/7FczI5ZFhwXgpi0mEy
         Jq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115265; x=1682707265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqvAB6d8goa2TAcTv+sr3+77aiqYZ9Ym4nn/6JW4p+g=;
        b=0J+EOiODDAnOIwx3PS2eW3cByrIeaeLercHaBIUA80Pr9kc9hz7xrsPVb1T7udj8zS
         m2c2K2l82j8yN9kfteHubAfATGHY2GLPFvdcBTqLjgij16StGQxy4SNcPXYHI3isTceA
         kMk3gs2aglr3b2KJ7nyCPJFG76JyN8P6kuyN/aeCJA3YWEwka/3Jj8NgjsHMKcVzICYu
         ZAwuWoZ+4dEPhB17Z0KmPp8QL+ig4ln9HEWjypIdq+kQKwDZ5ZGVpmjgsWoDW7HaPpCn
         L2UNOBhmDjwO++l7S9FDUuFV1BMQt/WgdIgL/cyER3I06FwId0YmDB573oVkHS9MrE3R
         1hnw==
X-Gm-Message-State: AO0yUKWLT/d+vvbbSTTAvR1gI3jR/t2czyHm2uqIjQ7q2zATR2lZYueP
        jb7wImG0tmQKMFQa8Tjxu2Dyg7QUqQMDxTw1xC42XQ==
X-Google-Smtp-Source: AK7set8rR8FhOKC4cfAvmlPuF7FBzR1R2F60+jLZB+bEhhbuoG8heTMsfm6uuCjKjjOSduHb5R+C7g==
X-Received: by 2002:a05:6602:2dcf:b0:758:6517:c621 with SMTP id l15-20020a0566022dcf00b007586517c621mr15108082iow.2.1680115264768;
        Wed, 29 Mar 2023 11:41:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] iov_iter: set nr_segs = 1 for ITER_UBUF
Date:   Wed, 29 Mar 2023 12:40:49 -0600
Message-Id: <20230329184055.1307648-6-axboe@kernel.dk>
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

To avoid needing to check if a given user backed iov_iter is of type
ITER_IOVEC or ITER_UBUF, set the number of segments for the ITER_UBUF
case to 1 as we're carrying a single segment.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 7f585ceedcb2..5dbd2dcab35c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -355,7 +355,8 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 		.user_backed = true,
 		.data_source = direction,
 		.ubuf = buf,
-		.count = count
+		.count = count,
+		.nr_segs = 1
 	};
 }
 /* Flags for iov_iter_get/extract_pages*() */
-- 
2.39.2

