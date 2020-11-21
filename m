Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7953B2BBFFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgKUOlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgKUOlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:41:16 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E9C0613CF;
        Sat, 21 Nov 2020 06:41:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so13845795wrb.9;
        Sat, 21 Nov 2020 06:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xysplVXaBNytmPMnndEWZlloVuS+KJXZUbKq+dY47f4=;
        b=M02cG4cB5pSktHaj5npZsKxdFicdYc8OGOnTMgdJJLbfFEbvVIWWRAUovx8aojT1bI
         WV+Snuh7IyCMOABkvIkocRcgSTnZ+cV6pdrRTfCLDWtV9lHv31HzzhwJhRYnSZ9AcGQn
         wHpbPHFJyeViEWGjQJ1XuqM7vs5UhfFdb5liUVL22pa29+Nu6LA99PTbUjJq9L+SdOZa
         L+aahoYFtBkgfoDqnP8548Mq3K2xdxSzWVEtnNVDi+NUDRVZFZhNzMyeaT0JzW3oE5dz
         iMSiHS6AutHBnOeLHz/PzzUWWqPuv0Z67m1OU048VtOG+6yC2HmmLoFZNc+cL2rvZBa9
         eUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xysplVXaBNytmPMnndEWZlloVuS+KJXZUbKq+dY47f4=;
        b=l1IkAJueh98B+ajwVSboctGz9ZgP+dRNqTfXYDMbMe0VGGCnn24fxIZZwmKyD7/bSL
         oTQgXtSW0chHLrG+VAIhenbuTLp4rpNf2BO46nA4M90fDWdnN7DJgZfRgGZ/xU0qB/mS
         Uc2w35xK6u3sMWspM9WQtXzDsLIykig3LGZMfFLZ1ib2WZjjYeLoJM2sFzcXfXNaASWH
         zOJjLU0ehBcpkbWMmTOEFT82RPQtLKAEy21XTA1+MxXIOvcJlvOxZim0vJM0IflP3Pkd
         IK7oXjW0QrSc8duZ8A4sKqZy2OcM7sqHCj6G4+phVptSNHA/2AjYPJJKKddihDUN4OlN
         TjTA==
X-Gm-Message-State: AOAM53100pNkty8qDy0L1RZmvrWpcIpO8h8Bq8/a7c6GAPWkMN0oupb7
        Ezq1pduRfpJ3ofA5EdYvuDTVCkTZI5o=
X-Google-Smtp-Source: ABdhPJx5iaDeHAjNBKJZvg8aDQEcjlO9VOgr5BKCk++khu+EkphqRDTQNzCMJKWcfemsu2IPma6D7w==
X-Received: by 2002:adf:94c3:: with SMTP id 61mr22658980wrr.143.1605969674968;
        Sat, 21 Nov 2020 06:41:14 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id z8sm1780114wrv.0.2020.11.21.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:41:14 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH] iov_iter: optimise iter type checking
Date:   Sat, 21 Nov 2020 14:37:56 +0000
Message-Id: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The problem here is that iov_iter_is_*() helpers check types for
equality, but all iterate_* helpers do bitwise ands. This confuses
compilers, so even if some cases were handled separately with
iov_iter_is_*(), corresponding ifs in iterate*() right after are not
eliminated.

E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
still checks for discard iter type and generates unreachable code down
the line.

           text    data     bss     dec     hex filename
before:   24409     805       0   25214    627e lib/iov_iter.o
after:    23977     805       0   24782    60ce lib/iov_iter.o

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..c5970b2d3307 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -57,27 +57,27 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_IOVEC;
+	return iov_iter_type(i) & ITER_IOVEC;
 }
 
 static inline bool iov_iter_is_kvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_KVEC;
+	return iov_iter_type(i) & ITER_KVEC;
 }
 
 static inline bool iov_iter_is_bvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_BVEC;
+	return iov_iter_type(i) & ITER_BVEC;
 }
 
 static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_PIPE;
+	return iov_iter_type(i) & ITER_PIPE;
 }
 
 static inline bool iov_iter_is_discard(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_DISCARD;
+	return iov_iter_type(i) & ITER_DISCARD;
 }
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
-- 
2.24.0

