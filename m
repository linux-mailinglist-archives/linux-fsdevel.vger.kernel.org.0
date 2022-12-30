Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B849665942E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 03:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiL3CYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 21:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3CYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:24:54 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D5A449;
        Thu, 29 Dec 2022 18:24:53 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so19550650pjb.0;
        Thu, 29 Dec 2022 18:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVZagi5Inm8vBRKD6M4Ob3Jab/hykkOo7yIFD6FDUbk=;
        b=SXQuGYUtC281D9JqcB98uR2U9NeB0mdrU24ULYgeonfbvQs4eU0M3dfBPvPSz0js+n
         oKWi6kLsqO3cgqe2ld1PR3TAoM6eiBRJfjA+XwB++v9ROGWP8/OEY/AIQKq4njlp7hh8
         n5ZHLmI3w6KKHQYXKnQQmZyQVRX97Y6rt5IinyxT6WeHtBEOz7CrQ6adeM6mptYWERiI
         9VlpeWzWfLBqC6ROUfQaSqTRO6f4/LS1J53Q8Iw9RNBw8mxJCp8PjH+pZskzopbfLsUb
         Wibf331CaXABWr3ttNZzaKAWao9Qr6ct07HVoaNIIlBFa9X6O72AIw5OT6W1T/w8YrN9
         76wA==
X-Gm-Message-State: AFqh2kq9ijPbGd2hhr2SCq5be/kmzahnLo+SKw3j/9avQfpNVyVXyYuP
        QVZX0+34pNeVVox0xdVTtUloFnWAerd6Lw==
X-Google-Smtp-Source: AMrXdXt7nnvR7LM+VuxWUlsr7o/pMTmikYR4YXwkhcuo7CRtuNq1zocRxPR1rEnA51tzslrRWIYdZg==
X-Received: by 2002:a17:903:2652:b0:192:8e0a:16b with SMTP id je18-20020a170903265200b001928e0a016bmr10205168plb.14.1672367093362;
        Thu, 29 Dec 2022 18:24:53 -0800 (PST)
Received: from localhost ([116.128.247.22])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b0018971fba556sm10855964plf.139.2022.12.29.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:24:52 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v4 -next] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Fri, 30 Dec 2022 10:24:46 +0800
Message-Id: <20221230022446.448179-1-xiehongyu1@kylinos.cn>
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

When CONFIG_COREDUMP is set and CONFIG_ELF_CORE is not, you'll get warnings
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

v4: modify commit msg

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

