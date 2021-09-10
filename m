Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3E4070E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 20:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhIJS07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIJS04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:26:56 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F0C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x5so2986937ill.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXqLAV2nHQSRvb7ZpTv11qb8Cadrv15U6bJT2tEZrTA=;
        b=C9n592YCvQVMPC3QJJq8doHR8zymsLndJY7D9sFC7MPjcHYXietRyHeBqWGrPNd8Eh
         Ramev7MeNwgQevFyw9xHgFNGVl+TJBPmb5KYDOH9lMFERBfoQHZgGUyqarBbcdfsS/bs
         RIcHmf/0TIdWttSAMJEJYaLIbfSJLyO1Ts8HsHDOQswciqFc+KmOa5B6V3iSrx5qfJMZ
         LQXRIqmc1XOYT6gHnhua2GK1eRKuJ1puUPfOA3daLzgT2ui441hg6bDnm0DOfFZ+/3PN
         1rj1n7m88iN14EDYdY9D/VQhHQsM/f9WNlv7FL4ZJxMb7Vexn2RDYE4wLhL97X+qxyFo
         UR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXqLAV2nHQSRvb7ZpTv11qb8Cadrv15U6bJT2tEZrTA=;
        b=hThQr5dEYteL4IR6+GUUEJx6DwEhvZbhKB12x4/d+Te0glyDT+cCnwTnziKvGllJmL
         q5KR39Iaa2g7W9kkMEOiMy+VAo56sXiCQs16hGV6sJar0pCEJwg0+TiGSNt7P/dhIPBB
         2zaj1NuahMuf/cIr00MeWg2bLGRTFio5jxoCKPrc5LeMZEB4oChpKIqxh4mawkSueYZd
         nm2xJgMgCbm4UTbenyeh5TMYoaX9Mqz4bvwJKllZYM99Rj2vMJiuHWdSGV/4txg8PO2p
         5Rt1nMpIsBm83RNIYQLapsqVoiY+JYs2g3xxNvbjbFuUOd2Jt4zeViQrS3IK0lcRwBxX
         AVWQ==
X-Gm-Message-State: AOAM5310Pgd7ojPTHYMT47Wf8EFEg670EJ0k1ImLw3KLq1GPZY1gmAKZ
        rEiA6IlVjJ4nmraLL+2rhfUgrA==
X-Google-Smtp-Source: ABdhPJx8Mme/uzeOQpl1RzbdA7+VQ+YAp0SgCmqt948wv5waJl2kT5lV9BmbUv+0u+x7l5dlVBPYrg==
X-Received: by 2002:a05:6e02:1044:: with SMTP id p4mr7281793ilj.227.1631298344198;
        Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c20sm2575149ili.42.2021.09.10.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:25:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] Revert "iov_iter: track truncated size"
Date:   Fri, 10 Sep 2021 12:25:36 -0600
Message-Id: <20210910182536.685100-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910182536.685100-1-axboe@kernel.dk>
References: <20210910182536.685100-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit 2112ff5ce0c1128fe7b4d19cfe7f2b8ce5b595fa.

We no longer need to track the truncation count, the one user that did
need it has been converted to using iov_iter_restore() instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6eaedae5ea2f..7c8aeacc6fa7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -53,7 +53,6 @@ struct iov_iter {
 		};
 		loff_t xarray_start;
 	};
-	size_t truncated;
 };
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
@@ -271,10 +270,8 @@ static inline void iov_iter_truncate(struct iov_iter *i, u64 count)
 	 * conversion in assignement is by definition greater than all
 	 * values of size_t, including old i->count.
 	 */
-	if (i->count > count) {
-		i->truncated += i->count - count;
+	if (i->count > count)
 		i->count = count;
-	}
 }
 
 /*
@@ -283,7 +280,6 @@ static inline void iov_iter_truncate(struct iov_iter *i, u64 count)
  */
 static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 {
-	i->truncated -= count - i->count;
 	i->count = count;
 }
 
-- 
2.33.0

