Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420E764DEE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLOQoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiLOQoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:44:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B6379F7;
        Thu, 15 Dec 2022 08:44:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83CF261DE1;
        Thu, 15 Dec 2022 16:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A7FC433EF;
        Thu, 15 Dec 2022 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122655;
        bh=nx+NAAzYOuwGZhcQwQLKlwkWqZKRCHdBqu/CAuLJa14=;
        h=From:To:Cc:Subject:Date:From;
        b=Ao6n1DJ+me4j4PoHQeoEXJWDSB1xNi9od41FnsE+u/QY5tbwsq8cSD6Qlqqh+mTXs
         ac0qwYwE65VmDxv0mvhiwAGE1uwpgo3fdjQpYDC5Ve1FFlkRLSmoImN0mFm+VpV8az
         zmJJvvwbI57uuftyIZdhv9j82bWS7bB5OB+V+dfxG8AASHp0U+FmY2ARQSd351MNWw
         U496RJ4RH6p2NOejGpgZttehF96d2bQMVTj9qI2UXDCi/xNNR2+vF4hsqDSScP4XQC
         Aw6de5547wDYh5XB38+8i+BiDrqkeB8JLYk/h6V4zw5MKpDJPzUHOjODtVyO5eWYpv
         8L6VKq0vzZlXA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: move dump_emit_page() into CONFIG_ELF_CORE check
Date:   Thu, 15 Dec 2022 17:44:02 +0100
Message-Id: <20221215164409.1025791-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

If CONFIG_ELF_CORE is disabled, dump_emit_page() is unused, which
causes a warning:

fs/coredump.c:834:12: error: 'dump_emit_page' defined but not used [-Werror=unused-function]

There is only one caller, so move the definition next to it.

Fixes: 06bbaa6dc53c ("[coredump] don't use __kernel_write() on kmap_local_page()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/coredump.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..a25ecec9ca7c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -838,6 +838,30 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
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
@@ -871,30 +895,6 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
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
2.35.1

