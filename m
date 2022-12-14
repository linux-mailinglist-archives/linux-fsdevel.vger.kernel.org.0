Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201E164C5BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 10:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiLNJTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 04:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiLNJTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:19:02 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5401AA1C;
        Wed, 14 Dec 2022 01:19:01 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id x66so4017256pfx.3;
        Wed, 14 Dec 2022 01:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5WGO5nEyaT5i7OBaG0eVmR371egFZjtKo7Vs5i57j8=;
        b=jMjJyttpCGndEH+ZTmL7aF0XTr6zfJenlfXALCtALkKExh0cIYnJx1cZQ5zs8WKmvR
         WUmn7w+llYuLstz1Tm+hBgoKQklyE1KKaoGFJpMgMmM/OrAkw36B9Tzxw4Eyq7z4Pl/C
         o7VzAUBjPDvMwXc6nFJxE4QD/ftBjw56HUS9aAFSp1RONz2xpvocirGqp7HWhzLh0+5u
         ttHYya6Fiyk9gQREXjYmzuFjjp9EW9xXb7/EiT/Ghf1DmoY6X5eX1n+La/4qwn6b95UW
         GZHRtKIWXVrEP96Q7A0lSZWAKrC5c+FqAfkHxWi3tjCgcPNZP71/weBF9NrHGXYvN8kC
         A3pQ==
X-Gm-Message-State: ANoB5pmE8E2WXcEJYou5SuotwM4uJ4hnVmtSTD/DAdP+z/KtvZU+NP1b
        yasXPMHHTMe2vu8eANu2ClGRxaxkEJ359RwHYyiR+w==
X-Google-Smtp-Source: AA0mqf4S1lf6KvFMo7z16nZPiPES28nKoiq1i1S+fc1W/q/E7H66Lz7vk3e4RPCs1Fhq5Kv8TI6bhQ==
X-Received: by 2002:a05:6a00:1310:b0:56d:74bf:3256 with SMTP id j16-20020a056a00131000b0056d74bf3256mr28796828pfu.22.1671009541089;
        Wed, 14 Dec 2022 01:19:01 -0800 (PST)
Received: from localhost ([116.162.0.145])
        by smtp.gmail.com with ESMTPSA id x2-20020a628602000000b00576d4d69909sm9013299pfd.8.2022.12.14.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:19:00 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH -next V2] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Wed, 14 Dec 2022 17:18:57 +0800
Message-Id: <20221214091857.790080-1-xiehongyu1@kylinos.cn>
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
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

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

