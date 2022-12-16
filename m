Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB964E732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 07:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLPGIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 01:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPGIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:08:17 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D20F396F3;
        Thu, 15 Dec 2022 22:08:16 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id s7so1340476plk.5;
        Thu, 15 Dec 2022 22:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLh1Eyw+or4r7Gjsa0mCG1VAAyU02FM2G5SCk8sdZH0=;
        b=6vq7ZxnxV4IG/bpVdnFxD/DRGsBQhx7c2mjXB+KxdEPhmIowvZ2Vt/gQH0+2bIBXEl
         1YQQVuXBWXskQU1lYrL/BGgukLnUYR3uUoYBPE5pogr1rvtnhCjNgAzwH8MKYqfo/HY3
         ydlaFXRn3QEyePi/ZFzjuDFzrEdWDu2enP+6x3NM/r4V0bscwwLAZADyEOEcvi1u2+t+
         Kv7d9Q7bcRvInHbLNqLEFd8BXqZ+Dgfpvmtao0GSglGlEjmw3hoG4xYNXBy0myxxz49V
         AIrGaKpz0SyQBQsFdhTbSuP5+vwj2EK5YMvdnMjFWtgLcuLJIH/OQBe5Q0KWBzJQelfs
         0Atg==
X-Gm-Message-State: ANoB5pmSoq9ni3OVRYO6Pse4cOkDSuNJvRFPstyEF4hpRg23gj69xupA
        zYGRXIoNSIjLMtN5ljXw3zBD/CQP69RiIUzkBB4=
X-Google-Smtp-Source: AA0mqf7lknSe7YALv4pyXYnh1xm7BnThhqN6o576812aNYRNYtU/NAltu4AN98oZITXzhW43LorSKg==
X-Received: by 2002:a05:6a20:a58e:b0:ac:44ab:be3b with SMTP id bc14-20020a056a20a58e00b000ac44abbe3bmr39049894pzb.60.1671170895980;
        Thu, 15 Dec 2022 22:08:15 -0800 (PST)
Received: from localhost ([116.162.134.33])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79992000000b0056d7cc80ea4sm610697pfh.110.2022.12.15.22.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 22:08:15 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v3 -next] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Fri, 16 Dec 2022 14:07:24 +0800
Message-Id: <20221216060724.943833-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When CONFIG_COREDUMP is set and CONFIG_ELF_CORE is not set, you get warning
like:
fs/coredump.c:841:12: error: ‘dump_emit_page’ defined but not used
[-Werror=unused-function]
841 | static int dump_emit_page(struct coredump_params *cprm, struct
page *page)

dump_emit_page only called in dump_user_range, since dump_user_range
using #ifdef preprocessor directives, use #ifdef for dump_emit_page too.

Fixes: 06bbaa6dc53c ("[coredump] don't use __kernel_write() on kmap_local_page()")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v3: add reported by

v2: change sending mail address

 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..95390a73b912 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -838,6 +838,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -870,6 +871,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.34.1

