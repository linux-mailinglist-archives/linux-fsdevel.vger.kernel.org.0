Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FA659424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 03:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiL3CN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 21:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:13:58 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D3BE35;
        Thu, 29 Dec 2022 18:13:57 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so20490870pjo.3;
        Thu, 29 Dec 2022 18:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc3wMLmxgbNHWXke/R98z/cJl64dMMjheuYb1sarzrQ=;
        b=j/BYjXpXwLJI8QZAQ547Y2mx5CUbzChw3JqzoByWSeBr9mzx7JhC5K7KJCh8CkeGvq
         9qmp4LbFY5hjfg1LJ49KucjThq+4k33AUAVnuQOKsd///Sza4RDCKiIYfQ6n+tEy6tsf
         m3pNe/vcK565jgiXWyl9yzpT9Kt3FXM6CyWQ1EDUvEjJYVNuCF8mLqj373Hrs9jRh8I1
         sLp2enSJxOCAKgtHEDAhVX902jw6Ofem3tyxPKTZE6plyb2FjFr4Ut/Q3/O34eirmHCL
         hc4gImCQu1nSAdctGpfPMDiX75D9L3zyOYB4HBxwCJqoznrBmgLOf77VKYS3hAJGCWrB
         oB8w==
X-Gm-Message-State: AFqh2kqAy1KN5e/0DpIhXZc5awh/i4oJQS9evkQXadJCGcvpqZaEGoDr
        7rdCUeNod7LLWjqihXxODC8xrcpha+E=
X-Google-Smtp-Source: AMrXdXvotUAdaqZxt2XhVmh3KbGtCsMzxqoTNaL6WfIzBWoAYKa9LhhfpCtUYIqaFOjIv9uftyN86g==
X-Received: by 2002:a17:90b:2291:b0:226:3b78:36ab with SMTP id kx17-20020a17090b229100b002263b7836abmr2180054pjb.3.1672366437193;
        Thu, 29 Dec 2022 18:13:57 -0800 (PST)
Received: from localhost ([119.39.248.88])
        by smtp.gmail.com with ESMTPSA id px12-20020a17090b270c00b0020dc318a43esm12006902pjb.25.2022.12.29.18.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:13:56 -0800 (PST)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [RESEND PATCH v3 -next] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Fri, 30 Dec 2022 10:13:51 +0800
Message-Id: <20221230021351.441749-1-xiehongyu1@kylinos.cn>
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

