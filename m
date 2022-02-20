Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D84BCCD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiBTGCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbiBTGCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:02:43 -0500
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 22:02:19 PST
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179AF1B
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:02:18 -0800 (PST)
X-QQ-mid: bizesmtp83t1645336917tfkame2n
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:01:51 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: 4LFlwc+MlXkQ8gqbBA0q6azNy4FS1Wp5//1Uq4m3wJCqupGWBCLm4SAGWY39E
        d+iIj+Wv2qwxluAPiItIHm2vHTu9tlW2cYh9/+NYMgheyjVewkcP5Ia8AQ6oKZPoBm8OCrn
        XGx+2RzTo0DYxdemrR2ynLPwTWRgT3E7ZwgvFoZUzkT8uKT5sm61ndzj4FVNF4ww1PlRxeW
        XjKH4OQRKd4bh6wTqC4MwRkMZOSBpycSD7ou4QzwsFSgPnPPgF43ILh/iij7P5hxrgiDKsG
        VfSYnxCDrK3098yCmiAhwujlQx8XSn2FdMIYs2o2auaA91PQr7gofumlnImAAAXWDShmI6n
        b3S9MB2w68SHzCsrEQ4wPaebW5diY714Dx+mjye
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 09/11] mm/filemap: move filemap sysctls to its own file
Date:   Sun, 20 Feb 2022 14:01:49 +0800
Message-Id: <20220220060149.14110-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the filemap sysctls to its own file,
mm/filemap.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    |  8 --------
 mm/filemap.c       | 24 +++++++++++++++++++++++-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..c3c7cb58c847 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,8 +39,6 @@ struct anon_vma_chain;
 struct user_struct;
 struct pt_regs;
 
-extern int sysctl_page_lock_unfairness;
-
 void init_mm_internals(void);
 
 #ifndef CONFIG_NUMA		/* Don't use mapnrs, do it properly */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1a1504862f4f..b51b0b92fdc1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2261,14 +2261,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{
-		.procname	= "page_lock_unfairness",
-		.data		= &sysctl_page_lock_unfairness,
-		.maxlen		= sizeof(sysctl_page_lock_unfairness),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 #ifdef CONFIG_MMU
 	{
 		.procname	= "max_map_count",
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..f264e7e12f59 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1235,7 +1235,29 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 }
 
 /* How many times do we accept lock stealing from under a waiter? */
-int sysctl_page_lock_unfairness = 5;
+static int sysctl_page_lock_unfairness = 5;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_filemap_table[] = {
+	{
+
+		.procname       = "page_lock_unfairness",
+		.data           = &sysctl_page_lock_unfairness,
+		.maxlen         = sizeof(sysctl_page_lock_unfairness),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+	},
+	{ }
+};
+
+static __init int vm_filemap_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_filemap_table);
+	return 0;
+}
+late_initcall(vm_filemap_sysctls_init);
+#endif /* CONFIG_SYSCTL */
 
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
-- 
2.20.1



