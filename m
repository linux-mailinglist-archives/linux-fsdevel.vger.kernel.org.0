Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719D74C4E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 19:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiBYSz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiBYSz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA51CABD2;
        Fri, 25 Feb 2022 10:54:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so12561307ejf.11;
        Fri, 25 Feb 2022 10:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8uvJLnv8OEOW9/y5I0aNp4U25HFaYMsYrF+UQvtVus=;
        b=hJH0X7/GNAe2leJJwEgktx6GmGcM7hNyr8fKDqbePJerOwgFnk/h/it6th6V5PtsoC
         D3Jq4Y/KciDrvcOXp44jBtbIU1LpwTldM4ZILdn46PhsH4f5DlbtLo/NqNojm9euqSTw
         vBxIwRvuzSGx1iqcksEDylj5I3tJyWHS3Ds6oABhhGsMMu7KgPBPaBINDNPCOvRaVWGD
         yrXsn7L7HB7XaZbgaKFp430S6c+6UL7yvb/arOFnWEBnY+R6AIdJjCFVXWXTllTq9CZ3
         MBY0UwE6Ax8G4rqWH4mL95F5F9S0BnGvk239Y1oW9V53wWkHfZ8L4gFVHSvXG51AAsHT
         OziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8uvJLnv8OEOW9/y5I0aNp4U25HFaYMsYrF+UQvtVus=;
        b=u7cveQURLtipPrznR8v2jNGTnojEp0/iiZeE8vYtWdaqyMDR1mOqym1gf821Er/W9z
         u/IaeUALRMIIhchE4RQ0EDrZXD6i/tavOGpZyT+8E7IjiKV55mRpo10dmLxOR5jLLNE1
         Of9RpJOLYzZt9fzaXM6BvB3PfG5hh40kXFTP4kSQPsAIpj3QbneeDGqOU8xuJpMiC8cc
         wfl8bz9JjAvNFdqhBmJRtMxm1ugMZL0pI4/PVH/Q+X5px6DCD5yoDGYhyuGC/+fQab9h
         qmsxoPU8LtpexFb8vqbR2N+oxSt8iG80BF9U7r6nDipzQ4gUP32xqDRuKJtVtt9dWf5K
         ytwQ==
X-Gm-Message-State: AOAM532aBzT/M3/bsNzaA0J6W8SftIDBGduJqv32VFPoH04Gn1WzhERy
        g+Tgth61/F4IoHS9y6mk3Zw=
X-Google-Smtp-Source: ABdhPJzQwwFAfEO8yZTRSmbrIUT/Fns/Ucssp+T7FrqPIINt3+nordhrLv1ypihQeZkLYbMJigPNFw==
X-Received: by 2002:a17:906:ce30:b0:6cf:1b03:e696 with SMTP id sd16-20020a170906ce3000b006cf1b03e696mr7214337ejb.505.1645815292792;
        Fri, 25 Feb 2022 10:54:52 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f1cbe000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f1c:be00::fd2])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm1328508eja.91.2022.02.25.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:54:52 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 2/4] fs/pipe: remove duplicate "offset" initializer
Date:   Fri, 25 Feb 2022 19:54:29 +0100
Message-Id: <20220225185431.2617232-2-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220225185431.2617232-1-max.kellermann@gmail.com>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
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

This code duplication was introduced by commit a194dfe6e6f6 ("pipe:
Rearrange sequence in pipe_write() to preallocate slot"), but since
the pipe's mutex is locked, nobody else can modify the value
meanwhile.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index da842d13029d..aca717a89631 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -535,7 +535,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 			ret += copied;
-			buf->offset = 0;
 			buf->len = copied;
 
 			if (!iov_iter_count(from))
-- 
2.34.0

