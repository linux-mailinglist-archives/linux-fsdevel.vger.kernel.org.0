Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB796027ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJRJHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJRJHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:07:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F06AE9E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 02:07:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so13249937plo.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ik/E//QP4NdBbqi/JKK2jChzoYGdVf04VQO8QaZ2oI=;
        b=OJ6MXnK+VlPl3Gcy1ZICT+bgZamtzoDgN7vzGSxP1iIfM23MZk+tkti34Hy31Qeri9
         TNMsi9ce+ddpAZLgmHjUEVLD8tv4P/osTJMT8z/x6jwe6BSRX1sbbyvcPUei9564v75q
         yWzWdeHCQUAekASByz1Jt35L/5AFk42tL9jXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ik/E//QP4NdBbqi/JKK2jChzoYGdVf04VQO8QaZ2oI=;
        b=qccuOwkio4bDPNDOaQ0H65fZk+5yBagJiLfjuWay7BY7QQz6u8oPUD79wQkD2Fx6kv
         1a2pt0yNnXoIzLHP1MTmrZacRwCb9Nl0INnHyutS6QH3TXko9JuQ5/1IUvEzEuH49LoA
         ccram/svrqG52cY4lEaJcll/aGGVdumc/G0sjdnsKNbyLHAG1h0V/0E/23p6P5i4Qy9t
         duR+2f8T71awH/VZyMpeQHDuErA8WZaGd+iGSFeSaKEcu3ahSSsJdIKPflmRpBZKZ5WY
         TLWZGbEChl6/LQRi+6nNvcNI/sAPK1OQ0owikEUGEXdtnVRQe8lwVP3PqWrU5B1vimTS
         E3GQ==
X-Gm-Message-State: ACrzQf3UgZ5SjM1XX62xom4N43Ba/oq14z1iLc1me3vuTzxer3jW9vao
        8DMrIQ8fiTFVN4gWJa94gifHxQ==
X-Google-Smtp-Source: AMsMyM6CIFIQbM4Lw/W6bIJwv433YVB+M6640oaCuA20xl6UHbu1b0zu7j1SEKv1OoEBTwDfHlePPA==
X-Received: by 2002:a17:90b:392:b0:20b:2c3b:547f with SMTP id ga18-20020a17090b039200b0020b2c3b547fmr2529481pjb.116.1666084027916;
        Tue, 18 Oct 2022 02:07:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a6b8400b0020d6fc00072sm11241693pjj.9.2022.10.18.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:07:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] coredump: Proactively round up to kmalloc bucket size
Date:   Tue, 18 Oct 2022 02:07:05 -0700
Message-Id: <20221018090701.never.996-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; h=from:subject:message-id; bh=p+MmonEVAKFmpb5iqSHacNcvTbIa15T8BRPfROxVUy8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmy5m8JCx9/BE56DDkyWbIsGqGD7nmhWHa2GZ8l+ Hy6FbFKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05suQAKCRCJcvTf3G3AJnEsEA CScUD9FTn1d8hXufUPd/FUQzE357ebRSIeX+m2v0ED9JXLrqJmh1gZrjrKHLkKiHTSnAn/jgoD2dgW U/YOQFrV7yyoQ4kKZzShL7FQ0s1Kki5m9LIqY/0HwPR8+tkdVVoG9a1PJoy3TBtZBDSTBQyojqxd0X Du2BbO4D0kz4QxdO1Zwl5lldGIOh7poGa2tmqXjvxG55wMNBP4WyRTNS5Id5ZMVNW2qOS0yN3rF+ac HT2LfblPNvdimyrWPwhl/2C6Ae+75yrDwn4P3d5DncHEDWBLrCqAXG5tOl2M2fLXjp7aBDKCn9t84Z yI5N3lIzvVqgzmFoQg9Z1WPlj0LmmJv49Pd/3FEGHrFdAeq4q4cKUJjclOyHapGm+NvcmkVvJWk4FU +jEB83ZhUMSqNUBe+ck7MRnOTSjsK+dJ5cau90wJyEpods3antluvAuYwQLpZxjLF+M4HvNSpJGVIE HNFPx13lmOsyt2MVaIQdGy7sm1yi8zfE/1DnLogCFzRasB3JoVBh012nXOhnl4dF0o49scKZrY1cge DGhZ0pVgCpql0gGtmm2Abphd95b4ufD7Np9gAWqH2xgvsGGicJEtY15OqOv/r61tRSwp5ieebceKfX PIOt9137ZR+Rxj7a4MQ+iIpvMA+gJDGhPYdlPr3J6MHr0kpiM4ZLE3QyUOZw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of discovering the kmalloc bucket size _after_ allocation, round
up proactively so the allocation is explicitly made for the full size,
allowing the compiler to correctly reason about the resulting size of
the buffer through the existing __alloc_size() hint.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/coredump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..97eaee325251 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -68,7 +68,10 @@ struct core_name {
 
 static int expand_corename(struct core_name *cn, int size)
 {
-	char *corename = krealloc(cn->corename, size, GFP_KERNEL);
+	char *corename;
+
+	size = kmalloc_size_roundup(size);
+	corename = krealloc(cn->corename, size, GFP_KERNEL);
 
 	if (!corename)
 		return -ENOMEM;
@@ -76,7 +79,7 @@ static int expand_corename(struct core_name *cn, int size)
 	if (size > core_name_size) /* racy but harmless */
 		core_name_size = size;
 
-	cn->size = ksize(corename);
+	cn->size = size;
 	cn->corename = corename;
 	return 0;
 }
-- 
2.34.1

