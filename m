Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031E03AAF06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFQIqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:46:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7348 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQIql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:46:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5Fr02lkyz6yTh;
        Thu, 17 Jun 2021 16:40:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:44:32 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:44:32 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] coredump: remove unnecessary oom message
Date:   Thu, 17 Jun 2021 16:44:04 +0800
Message-ID: <20210617084404.1170-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/coredump.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 07afb5ddb1c4..a693e9230fb6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -679,11 +679,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
 					    GFP_KERNEL);
-		if (!helper_argv) {
-			printk(KERN_WARNING "%s failed to allocate memory\n",
-			       __func__);
+		if (!helper_argv)
 			goto fail_dropcount;
-		}
 		for (argi = 0; argi < argc; argi++)
 			helper_argv[argi] = cn.corename + argv[argi];
 		helper_argv[argi] = NULL;
-- 
2.25.1


