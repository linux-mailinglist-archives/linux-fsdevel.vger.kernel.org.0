Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3895B160A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIHHzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiIHHzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:55:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD060506;
        Thu,  8 Sep 2022 00:55:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MNWY21X2jz14QQt;
        Thu,  8 Sep 2022 15:51:50 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 15:55:39 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 15:55:39 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH v2 1/2] kernel/sysctl.c: move sysctl_vals and sysctl_long_vals to sysctl.c
Date:   Thu, 8 Sep 2022 16:29:46 +0800
Message-ID: <20220908082947.2842179-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908082947.2842179-1-liushixin2@huawei.com>
References: <20220908082947.2842179-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

sysctl_vals and sysctl_long_vals are declared even if sysctl is disabled.
Move its definition to sysctl.c to make sure their integrity in any case.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/proc/proc_sysctl.c | 7 -------
 kernel/sysctl.c       | 9 ++++++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 021e83fe831f..42a7cdbe514b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -28,13 +28,6 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
-/* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
-EXPORT_SYMBOL(sysctl_vals);
-
-const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
-EXPORT_SYMBOL_GPL(sysctl_long_vals);
-
 /* Support for permanently empty directories */
 
 struct ctl_table sysctl_mount_point[] = {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f10a610aa834..8ccd8d755c5f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -82,9 +82,16 @@
 #include <linux/rtmutex.h>
 #endif
 
+/* shared constants to be used in various sysctls */
+const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
+EXPORT_SYMBOL(sysctl_vals);
+
+const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
+EXPORT_SYMBOL_GPL(sysctl_long_vals);
+
 #if defined(CONFIG_SYSCTL)
 
-/* Constants used for minimum and  maximum */
+/* Constants used for minimum and maximum */
 
 #ifdef CONFIG_PERF_EVENTS
 static const int six_hundred_forty_kb = 640 * 1024;
-- 
2.25.1

