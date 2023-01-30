Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9673680382
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjA3BeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 20:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3BeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:34:00 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A219F1B;
        Sun, 29 Jan 2023 17:33:59 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so5182678pjt.1;
        Sun, 29 Jan 2023 17:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1u0LgSyfcYt4W6CZJvv15AMQYJ+p0Z4FB8ByXsH7ZKA=;
        b=ExnD0r+KTsfV0LSL3xg0KTVrgSW34fsG4Zm61UnblSrPcTXTdE+DVnHYjvNT8ER6op
         scN8Kr5AHd3oZj4YyHvRqaLSWPLSjfICbcZHXq7AIyGZkcWqn9cIM8zxFkqKtUOS5/WC
         nW+7dfQSFiAuR2Xebq5dVDj+Fp2JaHv3viSn7TJlWzEnsWBItKc5jym4jMmendNKNsKN
         0L/ay1M73JNQwZ5Cn333fSiaP9oDa5ckwf2LUsiChHnpNx9R/XELQ12j8iqQeQaUTltD
         aosLbLGJvbcwWA54zit4HZ8qD0mATZ8veSna9/eBzIby61v+Nz4NqSG+pyZSyGS7vBk6
         n7gg==
X-Gm-Message-State: AO0yUKUq5LKLZpLPqk+//DptCkICqaZL5+DeFBEtZcjOaFWa1xizeyeq
        ahx5w3MLy6T+IQ+D1DPIUujIP0TryHs=
X-Google-Smtp-Source: AK7set/s3kO+qIW9inU9p9Ej0WDxcUvJXBQMo+tFrqCxjnXHQADWYv7iwomOKTUJsg/g/q8cnYXjow==
X-Received: by 2002:a17:903:2282:b0:196:704e:2c9a with SMTP id b2-20020a170903228200b00196704e2c9amr5156560plh.22.1675042438721;
        Sun, 29 Jan 2023 17:33:58 -0800 (PST)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id p24-20020a170903249800b00195e6ea45a8sm6433641plw.305.2023.01.29.17.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 17:33:58 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v4 RESEND] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Mon, 30 Jan 2023 09:33:47 +0800
Message-Id: <20230130013347.17654-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
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
index f27d734f3102..df9f1f99ce46 100644
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

