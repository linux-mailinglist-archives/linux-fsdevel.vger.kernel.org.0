Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A755AD22F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiIEMNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIEMNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:13:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2E5E569;
        Mon,  5 Sep 2022 05:13:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLnPX1LlSzkWwB;
        Mon,  5 Sep 2022 20:09:20 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:13:06 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 20:13:05 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] sysctl: remove max_extfrag_threshold
Date:   Mon, 5 Sep 2022 20:47:24 +0800
Message-ID: <20220905124724.2233267-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove max_extfrag_threshold and replace by SYSCTL_ONE_THOUSAND.

No functional change.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 kernel/sysctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f10a610aa834..48dbe154d939 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -129,11 +129,6 @@ static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
 int sysctl_legacy_va_layout;
 #endif
 
-#ifdef CONFIG_COMPACTION
-/* min_extfrag_threshold is SYSCTL_ZERO */;
-static const int max_extfrag_threshold = 1000;
-#endif
-
 #endif /* CONFIG_SYSCTL */
 
 /*
@@ -2224,7 +2219,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&max_extfrag_threshold,
+		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 	{
 		.procname	= "compact_unevictable_allowed",
-- 
2.25.1

