Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C54B60CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiBOCI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 21:08:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBOCI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:08:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F036B0EB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 18:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VxT5+TzYaXUngLzkpp0wLjeCZ8njF59V4ZINZ5d0e68=; b=MRXjtI+ud5DO2jHBLU2o4TVrmM
        xeh3JrdrH+eHLul/Hj0BKEIegmmrDwhaCEYsBDJftrFKM6jlfp/QcEOJQBnpd2j7KGc0RSCh200w3
        f3IGkPMW2bdv+kBnapbBx4G3k2u1VARqtVgh8BkypDfzl1M06krk4fd0EY70EvL5DshW2hM2s5Oai
        FZy1YGOQ/b6JBL1I8O6vd7PD9QVJoswDcnmvKUFWbmaOOCIIZYYRZkc0gUxXV/GsEA3cu3pWT9WWq
        02oXXNMqIfpMz7D6Fhm86sg7TjwnEc4pPv+qeS7+5iqhzU/GUqX6HSqh/kRBFk/G3q+vtuNLBoipX
        sM2OoKPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJnGX-00HXek-Qc; Tue, 15 Feb 2022 02:08:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com
Cc:     sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        patches@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] fs/file_table: fix adding missing kmemleak_not_leak()
Date:   Mon, 14 Feb 2022 18:08:28 -0800
Message-Id: <20220215020828.4180911-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b42bc9a3c511 ("Fix regression due to
"fs: move binfmt_misc sysctl to its own file") fixed
a regression, however it failed to add a kmemleak_not_leak().

Fixes: b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to its own file")
Reported-by: Tong Zhang <ztong0001@gmail.com>
Cc: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

The fix for the regression was applied before we could
say Satoshi Nakamoto, and so it failed to carry the
little tidbit of using kmemleak_not_leak() to avoid the
false positive splat. Fix this.

 fs/file_table.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4969021fa676..7d2e692b66a9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -27,6 +27,7 @@
 #include <linux/task_work.h>
 #include <linux/ima.h>
 #include <linux/swap.h>
+#include <linux/kmemleak.h>
 
 #include <linux/atomic.h>
 
@@ -119,8 +120,11 @@ static struct ctl_table fs_stat_sysctls[] = {
 static int __init init_fs_stat_sysctls(void)
 {
 	register_sysctl_init("fs", fs_stat_sysctls);
-	if (IS_ENABLED(CONFIG_BINFMT_MISC))
-		register_sysctl_mount_point("fs/binfmt_misc");
+	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
+		struct ctl_table_header *hdr;
+		hdr = register_sysctl_mount_point("fs/binfmt_misc");
+		kmemleak_not_leak(hdr);
+	}
 	return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
-- 
2.34.1

