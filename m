Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFC59D0AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiHWFsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbiHWFsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:48:39 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBA1C105;
        Mon, 22 Aug 2022 22:48:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d71so11342801pgc.13;
        Mon, 22 Aug 2022 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b82hKkMkk+BFCK51z6F8F6CcuUjzRSFm5JzJ2di5jzE=;
        b=fWcRwsahF2OIXZY2/RukO9LDb7rZc0F1Izw0qbGjl7nmVMO/pQEJNS4eJKRfHHlEqo
         zzPtDGr2X0fUl2pQ2p5NZa/q9vWz7RMi3QrD7zSMAEbSBavU8282Z2/iH4PyNFwmEVMV
         iIm41iEGNK/loAg21DsZ5c6Uw9B6Y80wdfURz2o5d2eZs7zba1HPqccLPNNaR4foSL6E
         THyTd1G4W2mVikAPbpcO59TZ6w3FEpz7oYXOGA+LiThlN/c67gticRiIH9kDrhfkpYo/
         auY8TiV5hC8arbi90u9Aa3FiilvXYr7ly3mnSzsICq6ACfopDkeI9ihP/Kaku0G2L4Yu
         FnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b82hKkMkk+BFCK51z6F8F6CcuUjzRSFm5JzJ2di5jzE=;
        b=zEh/a6Zj6ByJzCurdDEln2I3RciogwLh6HFohtYKkzOhbM7dW6Qane4Cg2fsHIBhLJ
         8FDdPbi/kg53jnY6TMbbfwPJ4VlDlRVAFWp1nEb9OsNiPZe8Dkn/DhcMdKKIMhyKDyso
         tZTiQjmsXPoeRXtlpywlHnJwsCNhVqX6eci9pZwE/A9m8idjLxENoAaLlxdCT2E5h4E3
         Sl2/XplRU/+dFKbvyenZS60B0O4L/jyvfCse1odvH4qylGUyEa7weKjGsie9dcqE5/Sn
         romQ4WRVRkNT7722rWmQQN2JpBbM03vrTXFguyj1dgUJmCdbpmBHExDgUlx/1zRlJv0u
         2Deg==
X-Gm-Message-State: ACgBeo3nARcR+wScPHjDxi+7GBQ7bPaCzG/sk6lpUOiZNKBURZ6inL+t
        7yELfin94KordUfXQBghDFtl6h5Aloc=
X-Google-Smtp-Source: AA6agR6wK1ldPQCCGW+HDq+UQTZlCedRYYoUzs8o8JLeWTHx9/g/DvjnFz6aKeLzql3kteSopcyMAw==
X-Received: by 2002:a05:6a00:2354:b0:536:c154:2001 with SMTP id j20-20020a056a00235400b00536c1542001mr6010820pfj.34.1661233715833;
        Mon, 22 Aug 2022 22:48:35 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id i38-20020a632226000000b00419b66846fcsm8214669pgi.91.2022.08.22.22.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:48:35 -0700 (PDT)
From:   lily <floridsleeves@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, lily <floridsleeves@gmail.com>
Subject: [PATCH v1] fs/select: check return value of poll_select_set_timeout()
Date:   Mon, 22 Aug 2022 22:47:40 -0700
Message-Id: <20220823054740.1448595-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check poll_select_set_timeout(), which could fail and return error.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..d9febe1b846b 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1073,8 +1073,8 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 
 	if (timeout_msecs >= 0) {
 		to = &end_time;
-		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
-			NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
+		if (poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC, NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC)))
+			return -EINVAL;
 	}
 
 	ret = do_sys_poll(ufds, nfds, to);
-- 
2.25.1

