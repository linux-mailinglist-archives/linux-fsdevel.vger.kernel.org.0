Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A326D0BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjC3Qrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjC3QrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A29CDCB
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p17so8527247ioj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194835; x=1682786835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/kB5PhUmthEnCoqu+yOus3Fb3oBVmbBoIv7KU060Co=;
        b=kEs/0kLoBKtJvulYvNCnelAcTdv0BAmYF16vuEIDQPNzoMSPcPyhttooHRd2dL6LoZ
         4Goxcv7GykHvXStaVd+3RKyXvRwZS102Pw9OY9a8J2cd/Os14lEXRoPsStFkJ4FAUuAh
         GXKnb0YBD+xEOLBi+rDhO15I9uQlDbOengy0fN+nvN4uYgR1908gf9tsxYE3y5ZHMrUW
         fwFUDXrKQTp7w7zcloiWTbCtJWrNbflhg4QBOK72ObeGeMIhTQpv3Ky4bV1Lh5Em9IaX
         Cq5yb/Exw/c81nxXdUfaDNyl8w6MEdgYTjypunuNEsuZMY+gOwHIH1W0rc4inv1Zzm+w
         +Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194835; x=1682786835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/kB5PhUmthEnCoqu+yOus3Fb3oBVmbBoIv7KU060Co=;
        b=Dq2Rb+9fcFXp18fnhqNp33hHLtaBh/xKjgd9L3DaDLvWAd9YUPoBdI1WwOsolv7kVq
         n9s5yJdwA0GY8YdvAxOMSneNsQ8mCo+GJozDiXUXAE4a9nBmeIYbw0pjlK+Bs/6sch4d
         tXaSBOQ5e405pAeVrou2HgxfsrR6PmDpa6IGgRZTSW3ub1bEPUZl1/RztePEffGYlApu
         M2SeFoskpDy56+W2VCNdwgSMwkk6fz+7sh2GTt8A5+J/s7cSqnpeKiHtbyFrY+8oV/yb
         qLxXBkfTAE7ox1a2IeNIL/E7FctRhMevtPHK9omXZnX7uDsXVQ6hQtGGpwS3johoGnuM
         plIw==
X-Gm-Message-State: AO0yUKXRjRx/dK+VYsAIQ5B/lJCTKVX6N+vze74Ab2sCecxIdjnTQQky
        +chK5LLWJybbtXPQhVXsqzZdiSu44PSsfnH2Vyeg+A==
X-Google-Smtp-Source: AK7set947rl3w1tIIxmmE87kE5S90Ob7/qw9snKJll9DllXDRByo5t2BFzTAvIqLil1s2uW2wI83Mw==
X-Received: by 2002:a5d:9d96:0:b0:757:f2a2:affa with SMTP id ay22-20020a5d9d96000000b00757f2a2affamr14783195iob.1.1680194835296;
        Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] iov_iter: convert import_single_range() to ITER_UBUF
Date:   Thu, 30 Mar 2023 10:47:01 -0600
Message-Id: <20230330164702.1647898-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
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

