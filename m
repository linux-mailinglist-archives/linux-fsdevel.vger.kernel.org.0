Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289EB6CF255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjC2SlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjC2SlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17304C2C
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:04 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x6so8583837ile.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwUjTOd1XNUvc/0wj6/ArC+MvM71+0/O8hmrQy2F/M=;
        b=qdi43+mLD0a4vUBOb613AgoA7UaRrr2PLFq8vlQHDsbqpvZzh7a3Tgz7O4g2DyihAo
         GFQIKSg9EQ5ZKL16bA8AgX0oA5+oOf+NtGLiKJN085iduJOpO150CkxUhdUXkSldMse5
         uqZfSrbU7TbtUFJ+1x7gXbrURttTEPskYQQg92QPax8uPNbdOShEgMhzUTB5pJCz0CX5
         slcyweq3LMpo9mv9VjVbKVRcbHB6IbCm7jP3Rfim4a+JdgWiBY+8VSIlnQsGierDctkm
         oI1F4RoYl2u4CaGoyZTwuyfgCG9CH1em7OEQlN+/PvhCTikZHq5vknfyUiTCcLY1SJX1
         zVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpwUjTOd1XNUvc/0wj6/ArC+MvM71+0/O8hmrQy2F/M=;
        b=HSPtBQ5PaKSziskWlXzMsR/LzmHFxrunXNuZr1nfcPo7hMURw4iy2ZWJ2bBW/+2dSj
         0MY8M+qAxPuEvLOIR7U/vn79TkxxMHb+Zgoq+sbV4FhC5aDmzfbY56IRGsZuAYk6BPNS
         k+imJSmLGbJ552TC7zkb7sy951gepMPxnxCVhFU3+ql4rRPOD8DQvGN9g3myhXYp01Kr
         +YS5zmKWRsJaxiEmTp11HtebA4nJaPqmrbCwSFflO9LEDhVnA4nSuRBgMK0o1/LiX6yD
         EStT0N6HyC6H8We3Kgzqn/Y+Kg9Tnw/chA7jR362lbQnJt4RIKVWA055Mp5p6gtlDDa3
         hoEg==
X-Gm-Message-State: AAQBX9eyediL2iU4MY8pV0iq1fKMAxSCgqMMWAcucDdjvRqfCnz/XUQ3
        0eV+yGcw1hNNoq7KZaZZ92sPVAbSh/u3yfWGAB2M1w==
X-Google-Smtp-Source: AKy350aSEj5hRiKjuwniCuaVLNY/j5/Zxm+O3ifltJIIAcBB0G3x7Q+R8kmMoWblHZBgmhSQ4TDO/Q==
X-Received: by 2002:a92:cda6:0:b0:31f:9b6e:2f52 with SMTP id g6-20020a92cda6000000b0031f9b6e2f52mr12817007ild.0.1680115263827;
        Wed, 29 Mar 2023 11:41:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] iov_iter: remove iov_iter_iovec()
Date:   Wed, 29 Mar 2023 12:40:48 -0600
Message-Id: <20230329184055.1307648-5-axboe@kernel.dk>
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

No more users are left of this function.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index b7fce87b720e..7f585ceedcb2 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -148,15 +148,6 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 	return ret;
 }
 
-static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
-{
-	return (struct iovec) {
-		.iov_base = iter_iov(iter)->iov_base + iter->iov_offset,
-		.iov_len = min(iter->count,
-			       iter_iov(iter)->iov_len - iter->iov_offset),
-	};
-}
-
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
-- 
2.39.2

