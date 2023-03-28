Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14036CCC6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjC1V6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjC1V6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ACDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so14104401pjl.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=TRcTPvyy4Jwp13v9qZokt390mEYtWiUJM7dzupouQFNkIG/E+C3gzL3VPsFPG3v4OI
         wNzt+wHGNRZmp6x6LVjk1kYlRYydMGe2C1tMqNPoleJrGMfqewx8NnhfS3nKNdXx3dbq
         1HWt0zW9uNTKVsIyhAqsDlNpoWsFKEqjmth/cIMwAALgePLpCKaAJYOvp7UUwMtIg9aF
         IJoRrNZXR+9Z+Q0n/u+8kmdV+V4wy/VROgZeHqpaaX5RhLPoTJ5rTI5RHUI80ugBs9Sc
         /8pySX+DZ2BvDPeruLTaVOtGgwZ8spjolG8YMWgosZIAHyQN3JBd/NTLRXBMgUa/LGg2
         MAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=Wu7DKQE6J6o/0Bw4a+ispboNKIO9ljlaXn/vpxAMpKELz9x8e1agrru7sADWMzk/h/
         92K9/OPsufGt8Y1nKV1xbQWtnE4Kf9m3jT6qLhV7/tUjngmqqQQ5ADl1OHqwngXn4XUs
         74C+v0oBvgw04i34nX/Bjl49JocsMd5dWfOF0K8molGkjszyegOu1TJfdYG1vp3AF52R
         G/7FW6W8hUDFSxorQCHWJXhnpbftzA9IArDCHWIaZU3Lj1t9eckZlXKW4fGR9+Ig2q6N
         99HoPea+Capqyc5ySaLfI3pCEr+Ty8efjyfr3pn2STwYovIbomyGmlDfEHBbwRFcCGrf
         JcIA==
X-Gm-Message-State: AAQBX9d941AnyYU6YHMkwzkWNiOFzZZymLiIiMu2EKrOwsFbBUyAo63K
        +lQ/buWcDjCTDJozULdurOSY+R0bJQUF8PHE0DeG9Q==
X-Google-Smtp-Source: AKy350bBrLb4f49OQ2bhEWkug3l5Rqr9IUo2aWUWL4KurUgPUzHH6kg4uqefE8uDjY81Us5lihHmMA==
X-Received: by 2002:a17:902:f9cb:b0:19a:723a:8405 with SMTP id kz11-20020a170902f9cb00b0019a723a8405mr14923896plb.6.1680040695634;
        Tue, 28 Mar 2023 14:58:15 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] block: ensure bio_alloc_map_data() deals with ITER_UBUF correctly
Date:   Tue, 28 Mar 2023 15:58:03 -0600
Message-Id: <20230328215811.903557-2-axboe@kernel.dk>
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

This helper blindly copies the iovec, even if we don't have one.
Make this case a bit smarter by only doing so if we have an iovec
array to copy.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9137d16cecdc..3bfcad64d67c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -29,10 +29,11 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
 	if (!bmd)
 		return NULL;
-	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
 	bmd->iter = *data;
-	if (iter_is_iovec(data))
+	if (iter_is_iovec(data)) {
+		memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
 		bmd->iter.iov = bmd->iov;
+	}
 	return bmd;
 }
 
-- 
2.39.2

