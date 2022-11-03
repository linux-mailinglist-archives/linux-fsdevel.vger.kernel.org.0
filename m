Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA36177E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiKCHn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 03:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKCHno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:43:44 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E12F5BA
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 00:43:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667461379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gn462wghp28osuIlM0T+FCxafVC7mLfT1NX9mZHW0Lg=;
        b=qp5WDJY0gHTmOxR3rkHQBUFgGhI3DMUgF88QPZU6MAHOtGTbm8tAy6mfQcJMNZs6uDqbxR
        a95mtQ35GReM8nMCgH2EqsmabvZG/+CFKkJwnqeC38Ewle8Mtwl36TdDhn9KI8OrAAV1N6
        NS0G0GcR0PT07NzQbgZPR8nW1p47E9Q=
From:   Jackie Liu <liu.yun@linux.dev>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] coredump: Fix unused-variable warning
Date:   Thu,  3 Nov 2022 15:42:10 +0800
Message-Id: <20221103074210.3118578-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

If CONFIG_ELF_CORE is not set, gcc warns about unused function:

../fs/coredump.c:834:12: error: ‘dump_emit_page’ defined but not used [-Werror=unused-function]
  834 | static int dump_emit_page(struct coredump_params *cprm, struct page *page)

Fixes: 06bbaa6dc53c ("[coredump] don't use __kernel_write() on kmap_local_page()")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/coredump.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

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
2.25.1

