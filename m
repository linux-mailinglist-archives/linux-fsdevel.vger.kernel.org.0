Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C23609697
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJWVqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWVqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:46:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7D63877;
        Sun, 23 Oct 2022 14:46:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e18so24889235edj.3;
        Sun, 23 Oct 2022 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Se5sq1EWvaobTMZtui44x/tF75brtlSQy3TINeor1Uc=;
        b=F+mnlfCBJOk1C3VHVHiVUyhy05lA5cd3iEx2MuQW06JKKIeXEH9bay4qzgVRDBKa5w
         6mcyTlZxA82FzBWXDPAuGM1S1MweGWDH6nQJZ4FM6Is35UG0dp8kc+AIcpwX7NUnd0+n
         X79ER9swKhIe31UyJKO3b/kyKgglHF0ECJblPMDbbfKvmwdwEIBnu0aa5xg2V0k8eL/a
         9o6i0KMMyUtbKwC4x7A2MhEltJtN0LNMQ1DnXZY2SCp1fexi8xHd9l3rWswBBEz/sbpG
         BAVkWyeNxyLys66ysuIHgoMq3qbgqEGzDkbzsmED3/zBwDt2Xja0b2Ew33DUh0CTpnnc
         J/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Se5sq1EWvaobTMZtui44x/tF75brtlSQy3TINeor1Uc=;
        b=c3KbvywkH2y/LqdFGmFJuOuFFxXq+cyivC2XnmF+eSb8SUV2edqb9ABO0VI3D6bE9M
         uCNwegtpRdbJlTQAXn4R055UuKkaFn6EwyvJQ/DdjefgtOAShMeW1XgNKSc943gGlmwQ
         fVtYN5WE89IcyKu6CWbEdRGgaucRO/L1SVoVdVo9nz3bTu40F3ZE6P9p/o8q39NFs+sH
         GY+5noJ+aTotsmwCYU6wCDyywQUGcTUYJNX1prjUoWwKfWX89tjGXzB++Sz2VryOv0NE
         p4wLfWx1//rhrJsNmA1Vl2NJTLTEuk81/idnLH56Y9Vene5v2fttEqw4Px6Yjt7ezKv5
         sQCQ==
X-Gm-Message-State: ACrzQf07Ct8NZ5gDzOuimtqIY7n/D/VTR1+/n6GX0YKps+xuSwlGl7lo
        ymIyV+zCu+KrKD2Z3ggXWTH7xdLnSJw=
X-Google-Smtp-Source: AMsMyM4OIc2lpOybZrRYmDMRJ1dY78X60wTLMm+rLyYGD363q6PdC2Au+61wGGv2HpSeC894xJ2NSQ==
X-Received: by 2002:a17:907:3da2:b0:78d:51c4:5b80 with SMTP id he34-20020a1709073da200b0078d51c45b80mr24518652ejc.716.1666561602214;
        Sun, 23 Oct 2022 14:46:42 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id j16-20020aa7c0d0000000b0045bccd8ab83sm1371407edp.1.2022.10.23.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 14:46:41 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     namcaov@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: wrap dump_emit_page() in #ifdef CONFIG_ELF_CORE
Date:   Sun, 23 Oct 2022 23:46:19 +0200
Message-Id: <20221023214619.128702-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function dump_emit_page() is only called in dump_user_range(), which
is wrapped in #ifdef CONFIG_ELF_CORE. This causes a build error when
CONFIG_ELF_CORE is disabled:

  CC      fs/coredump.o
fs/coredump.c:834:12: error: ‘dump_emit_page’ defined but not used [-Werror=unused-function]
  834 | static int dump_emit_page(struct coredump_params *cprm, struct page *page)
      |            ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Wrap dump_emit_page() in #ifdef CONFIG_ELF_CORE to avoid build problem.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..8663042ebe9c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -831,6 +831,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -863,6 +864,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.25.1

