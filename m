Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4621957536A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiGNQvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiGNQvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:51:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4AD61D57;
        Thu, 14 Jul 2022 09:49:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so4425251eju.10;
        Thu, 14 Jul 2022 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB1X93ogJhANylPWr2KI+y5WU3eGimpfd/iYXdMRut4=;
        b=X8U+PGKBTMHOF8FwhbT/aZH3hn6B64YhGubQUkCCB1pzaV60oGRqHqM3KLwAR4sJPo
         NNNTnxtGtQFVIlLbZBytBuFOVL0lKdXCjg9n2njXxbsu2aCwAEZa+o9l7+zNzPIO5vUg
         HH1pI7kTvNjsCccK+gLuS3loNLQmhBF6UXyfdnMolOeXkdpGRuSC3zioP22LGUFGQ2Gb
         9bft6r+fP2Mhw5zqJBjZ1hr6u/tE4PdZ84cSOX4l1+V0OggdnYSvSgI6nJoZOjVJt+lK
         GBAUq0RqaOaNzFy4YhfH1YaKQw3R8sKoC1a9uQZ6qOQ3DxKJCvjP1gEpbi87k6PCs/QE
         eoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB1X93ogJhANylPWr2KI+y5WU3eGimpfd/iYXdMRut4=;
        b=WgCSM9fDwIuFWd0R6jEgBL6QgXsgFgB869QhTGkeUjNf+QI4lEHs3rogiuirBFfqk+
         r7ZgkNmvgfMcyRY4kA3UrAU4NZtJpE/FShDkc+xu0X+kUm3MyzC6CKb8M0WghLwgL8CX
         mle1HdQZkXSdPmCw1NkCFDBXabsCzQWesU0KlQ7Zf0q5RaYc/toS/V4iz+YZ++LMe680
         A8R6JDHg+S1HFEijUZ19IOSbDZOSOYJe853V24P44QFaK1HAqtTye+7l8blwQfhDBylH
         f4Ef4jsybPcQZBFobyNXS+5RpZtJ7+3Vt/6pz9ceYLe01ewxP3nmVAziKJlysciJamrK
         RV0A==
X-Gm-Message-State: AJIora9CQntxI3ISBV7NrgM2cVPJcsr1vAucS6iHzZh4EjDFHyVXeuoC
        jS9+v9B7zesvbu9901Y4q80=
X-Google-Smtp-Source: AGRyM1vGKigNOMcGNTFD/m1cRqJkjwoUYHw1esw9kHfp9D3mSa/PVRMcdlYAr9R0e4OEQANe+UeVIg==
X-Received: by 2002:a17:907:7f9e:b0:72e:d375:431 with SMTP id qk30-20020a1709077f9e00b0072ed3750431mr5750854ejc.580.1657817339457;
        Thu, 14 Jul 2022 09:48:59 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f25-20020a50fc99000000b00438ac12d6b9sm1325174edq.52.2022.07.14.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:48:59 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] aio: Use atomic_try_cmpxchg in __get_reqs_available
Date:   Thu, 14 Jul 2022 18:48:51 +0200
Message-Id: <20220714164851.3055-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in __get_reqs_available. x86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value
to "old" when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..054897f59c5e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -951,16 +951,13 @@ static bool __get_reqs_available(struct kioctx *ctx)
 	local_irq_save(flags);
 	kcpu = this_cpu_ptr(ctx->cpu);
 	if (!kcpu->reqs_available) {
-		int old, avail = atomic_read(&ctx->reqs_available);
+		int avail = atomic_read(&ctx->reqs_available);
 
 		do {
 			if (avail < ctx->req_batch)
 				goto out;
-
-			old = avail;
-			avail = atomic_cmpxchg(&ctx->reqs_available,
-					       avail, avail - ctx->req_batch);
-		} while (avail != old);
+		} while (!atomic_try_cmpxchg(&ctx->reqs_available,
+					     &avail, avail - ctx->req_batch));
 
 		kcpu->reqs_available += ctx->req_batch;
 	}
-- 
2.35.3

