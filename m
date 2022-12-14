Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A518E64C469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 08:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiLNHg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 02:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLNHg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:36:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E9175A2;
        Tue, 13 Dec 2022 23:36:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so6188166pjm.2;
        Tue, 13 Dec 2022 23:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oD3KwJVrSoSFDnHdhsSq1u/h9sH78UzRHgxOi9bsI3c=;
        b=HQAinVlxck5zoUcbsSArLckmv63dxOeV5KiPW9phjyWWNgow/gxfjM2htsCahlaMR5
         773i5XNJTVsoqn2RYopuVe9evbvWt6sIdvgwKWlDYFmw9xKm/Ug3iaeOcFXGGiZ8BDkt
         M5WtHycaiuSSPKcsYPRnqbQWTFDPxPz1XNXP+m6atltTystxUrayFz6/7Au5rbDEYBFp
         A14OA1mJeknWL2ineMi9eMCmloBaVG9FzhmuIKzy30rEbRq87mOGXLMuAHuhW0YwEPyX
         WKBro4gWO4mllYfsacNpGcbjVIqy26wBGpQhoBm8UpNajJWq0nGRKc2B+F4KTS5jZLYR
         zWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD3KwJVrSoSFDnHdhsSq1u/h9sH78UzRHgxOi9bsI3c=;
        b=LlyUYgYWSnZf6OdIDe2ZpvBIA9ujG2zblDS9w/0Fw1crfnGVtHbxQ6empUEX5SorrO
         yG/donA45VCkFsmtJFuPU8hlh5zzqpMT57fHs7Jjj4gLnCAkBYeTgkAglbZGd9vb9/QJ
         0LouoT3XFbyZnyGPEwODMdMh86sAy6msPyicQIzvNP6x+YaGZlmRPoa9d7XRNNNXcMGT
         /LRy3l2V4ZoKREwldm18kejol3HLy/W8KzyVgZnpZqmroB176SWLD2pIlehl+PjNEP58
         7TfkeUPV5BrklDZ9zGUMLdmLfrAE1E+R6Zh7yGD1FMMxdidywKJvzp93O4nJKcJucz15
         iITA==
X-Gm-Message-State: ANoB5pn4Uc2xbMiwsPxaMQDsvar9Y9CCRgRWsTqeA5mgU90TasRBEHpy
        3YeiuHfKhPcSqJG43DUrxLuGe2ALO0lHLQ==
X-Google-Smtp-Source: AA0mqf6r//6nfYeVV4BllWjTN4gqg0JqjiXWXEp+e5bSItut341+b7MEwWGWsl/ZyRLEOWNsQw4pbQ==
X-Received: by 2002:a17:902:b282:b0:189:efe8:1e with SMTP id u2-20020a170902b28200b00189efe8001emr25547271plr.68.1671003385193;
        Tue, 13 Dec 2022 23:36:25 -0800 (PST)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b0018853416bbcsm1154896plc.7.2022.12.13.23.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 23:36:24 -0800 (PST)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH -next] fs: coredump: using preprocessor directives for dump_emit_page
Date:   Wed, 14 Dec 2022 15:36:21 +0800
Message-Id: <20221214073621.766757-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

