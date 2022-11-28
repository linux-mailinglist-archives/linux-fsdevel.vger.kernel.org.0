Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3401963B613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 00:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiK1XmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 18:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1XmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:42:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6225C;
        Mon, 28 Nov 2022 15:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AD79B80FE9;
        Mon, 28 Nov 2022 23:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07353C433D7;
        Mon, 28 Nov 2022 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669678940;
        bh=yKpU+kv6QFrmTXdVvxt3iUQATsh8YTBkD/9P1+GJlMU=;
        h=From:To:Cc:Subject:Date:From;
        b=V82mG/53V9AIcSMGKP7eGAs8NHsK9xRejCZjV0PK9WG1IF/Oyvg3TuQ3p+ykjEjzm
         plP90VkSzNBsAdM32GfTtOVp1+JejfMjSVMpnwol7Qv1F/34O4RsT2dHcYEkYVYMSS
         oml1PPbNYJ/+LuDHt0CjYXtZbhxe42rLEt3Ay8tQChiNS9/DJo/+1ctBgGq+BfgnF4
         uysjQHxtR6WPcphVXYSXwkSEiNxCNNTRkuS/qjSmOj3d/LnFUJ7RJu+Aeq+SYCwBiT
         BB+m8wLVyY7Mo7oetBpqN9SKHnXVnRsEUcUQtmK9d44HKLCq8wN+CrRHj6ypSoQqL4
         DP+RLn38DRqPQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] coredump: fix compile warning when ELF_CORE=n while COREDUMP=y
Date:   Tue, 29 Nov 2022 07:32:29 +0800
Message-Id: <20221128233229.3880-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix below build warning when ELF_CORE=n while COREDUMP=y:

fs/coredump.c:834:12: warning: ‘dump_emit_page’ defined but not used [-Wunused-function]
  834 | static int dump_emit_page(struct coredump_params *cprm, struct
      page *page)
      |            ^~~~~~~~~~~~~~

Fixes the warning by moving the definition of dump_emit_page() in the
same #ifdef as of dump_user_range(), since dump_user_range() is the only
caller of dump_emit_page().

Fixes: 06bbaa6dc53c ("[coredump] don't use __kernel_write() on kmap_local_page()")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/coredump.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

Since v1:
 - add Fixes tag
 - collect Reviewed-by
 - fix the warning by moving the definition of dump_emit_page() in
   the same #ifdef as of dump_user_range().

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..1fc8ecc0e8f6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -831,6 +831,30 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	if (cprm->to_skip) {
+		if (!__dump_skip(cprm, cprm->to_skip))
+			return 0;
+		cprm->to_skip = 0;
+	}
+	return __dump_emit(cprm, addr, nr);
+}
+EXPORT_SYMBOL(dump_emit);
+
+void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
+{
+	cprm->to_skip = pos - cprm->pos;
+}
+EXPORT_SYMBOL(dump_skip_to);
+
+void dump_skip(struct coredump_params *cprm, size_t nr)
+{
+	cprm->to_skip += nr;
+}
+EXPORT_SYMBOL(dump_skip);
+
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -864,30 +888,6 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	return 1;
 }
 
-int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
-{
-	if (cprm->to_skip) {
-		if (!__dump_skip(cprm, cprm->to_skip))
-			return 0;
-		cprm->to_skip = 0;
-	}
-	return __dump_emit(cprm, addr, nr);
-}
-EXPORT_SYMBOL(dump_emit);
-
-void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
-{
-	cprm->to_skip = pos - cprm->pos;
-}
-EXPORT_SYMBOL(dump_skip_to);
-
-void dump_skip(struct coredump_params *cprm, size_t nr)
-{
-	cprm->to_skip += nr;
-}
-EXPORT_SYMBOL(dump_skip);
-
-#ifdef CONFIG_ELF_CORE
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len)
 {
-- 
2.37.2

