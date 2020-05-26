Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4491E2F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbgEZTvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389848AbgEZTvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD9C03E96F
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q9so264293pjm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egusxH2Kf4IsegITvpm+Q3F8VxKliDk7k1e8lkissGM=;
        b=MLDFg6dOL3wi94Sm49zoJiHajT2Z6Uem1NGpbbefsORGLMzmbgt6H7oJbyNaRmzLhC
         8Gf5ZNcnIwrFrsP15fHb8Hmk8a2hfjKN86KGFvtSh4PMPlyXApwguNjE2pUXQI5wzJ0a
         rImtmWOl8q0Gt2VD5UOeqH755bpc04N3G1iq2vwGTCann04vKvGxeoLEFP4xQ4fRN5L5
         Wg9gBx9FYIQvKM0euflOkFd88eUTLbrv+ERHN3wTJKYKJYMp38rMrtrLJwTNL4ghE1HN
         EtuRhPWgN+n1jwAN6pgdhE4EdIt7SHFVS5ROARRrp8WYRbT1BdjRgRCf0aEwWTyQqK88
         EjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egusxH2Kf4IsegITvpm+Q3F8VxKliDk7k1e8lkissGM=;
        b=ad0mR4VFnxMvhRTmEpSpOGSVCfLlo4pnDVJSIzLjNV4BYsN21CsHZ2/3pKT5o2SQxn
         OmKLHp5X2Up+83wYyP10T/bjXs3vya453e+iGSZltTp7VmgNtoxz8isi3Owle9LLlDwq
         M9FQKaX29c7I2YUmI/SUaLzPQ4y/ZAiEMSPFklZueTVcsnmNvUcSGJwNSZnLAkHURqPx
         a2NFUWCf1ccxvuR8fudEfVbYMXnp2zzS0GbY3xxmn7bC/JB39qV9BthM5T9du0MAyrVX
         JCt6bpRNO47M2unNEbTxiCGvbfzvnkWAFkO9xyTNtRrv262u0Ta9M8wrmfDBupXYArXr
         34Zw==
X-Gm-Message-State: AOAM5300/lK/m8BO9VPHoU1T0ojj4oYrx0z8Gh4tKvd2tODLEGs7MikV
        qyggaaIFuRYOxibiv+2DXxxX3w==
X-Google-Smtp-Source: ABdhPJxAwu286c9tdXeF8Jkxcn+Zoh3JziTFwAwrgLKM/2XtZ0wj0VRphyzFquzNho/fJP8ygPEQiw==
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr2621523plr.138.1590522701930;
        Tue, 26 May 2020 12:51:41 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Date:   Tue, 26 May 2020 13:51:22 -0600
Message-Id: <20200526195123.29053-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checks if the file supports it, and initializes the values that we need.
Caller passes in 'data' pointer, if any, and the callback function to
be used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d3e63c9c61ae..8b65420410ee 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -493,6 +493,27 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 	return 1;
 }
 
+static inline int kiocb_wait_page_queue_init(struct kiocb *kiocb,
+					     struct wait_page_queue *wait,
+					     wait_queue_func_t func,
+					     void *data)
+{
+	/* Can't support async wakeup with polled IO */
+	if (kiocb->ki_flags & IOCB_HIPRI)
+		return -EINVAL;
+	if (kiocb->ki_filp->f_mode & FMODE_BUF_RASYNC) {
+		wait->wait.func = func;
+		wait->wait.private = data;
+		wait->wait.flags = 0;
+		INIT_LIST_HEAD(&wait->wait.entry);
+		kiocb->ki_flags |= IOCB_WAITQ;
+		kiocb->ki_waitq = wait;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
-- 
2.26.2

