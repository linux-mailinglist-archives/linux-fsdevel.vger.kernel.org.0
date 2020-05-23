Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C931DF415
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgEWBvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgEWBu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:50:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD21C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:50:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so5812722pjd.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=zbiGe0xN/5Eo+H2CF5xCbc37d8G9FUD+KwT1btc4sCr0MmxKKhWlYkpMFKsBDe+auM
         9Lo6glgxT0TpCX3WRGG2vn4VE4AX+1pfCRCyrummCo1lCgDdqbkeBEk6ijx9JZHEJeU6
         jRmvQq6kJzvuOmFc9w5apNTgM3Y6aWuEs/rQtJ0OKa8yDTfg0sKs6pnYpShqn12A0A9y
         J6Wc16rnzBpz+0lD/w43ca6v1fqIWEl8Vw2+W7mJDgRZMzxLokmiLxhG9yZLWNMkjrKX
         Hj5+zMmQhwgf39Gi5fHYe6g3ZGmPsA6EMMkh/9rZ+BCgVtl95AzUU9gmqRnnCNoVHzwK
         88yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=J6gdSjOyFPfLaxTrw2ZmAzs5zPlpLssoXL1Y0Oc1qJ9R8JHJ4F/fSh+UymsL0jHBBZ
         8wbEiIdCzdqkJwMqTL4Q2o+WgKalVMy9OO0iMGDK0p9KZjcSLSr8fNGy55Pc9FyNYArG
         3CEeKwqDReeaApSCVxK8UrdPEV53/syXazAZ+pFfq3G8HwaoOvuRmg8whyJGgpVoy0+7
         snF/t2g/ggRjB0l6OCbZlKvoelx1YicTl5HnESRDfToNEHmz9QhwC6jc6k9nGUChPbVN
         8ATpITxn26TReb51FpjPaQ0pwlfT/PXRyKE6SjBv54IfgkEBYCNsSBUpN3rSYJWdILCL
         diTg==
X-Gm-Message-State: AOAM531OYIhG7mq4O5lMNjm7CW80YsKPPGawK65Iv0JNsNwqRoyJ2I7/
        V5x29/ZaGRmt8NMW5ATf9VmSvg==
X-Google-Smtp-Source: ABdhPJwBmDXlE+x5QTHM8T9DaQOh7Fl5EgB2+dvXN52teuRxNlg4WmYuq4kTmwFYa3fjjpSWpHNLKQ==
X-Received: by 2002:a17:90a:344c:: with SMTP id o70mr8104020pjb.23.1590198658974;
        Fri, 22 May 2020 18:50:58 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:50:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: read-ahead submission should imply no-wait as well
Date:   Fri, 22 May 2020 19:50:39 -0600
Message-Id: <20200523015049.14808-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As read-ahead is opportunistic, don't block for request allocation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..c296463c15eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,7 +374,8 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
+#define REQ_RAHEAD		\
+	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-- 
2.26.2

