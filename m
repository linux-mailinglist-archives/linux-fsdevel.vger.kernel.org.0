Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E7631342
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTJx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 04:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTJx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 04:53:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBE15A34
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Nov 2022 01:53:25 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFQn36nmrzmW0H;
        Sun, 20 Nov 2022 17:52:55 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 17:53:23 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <naohiro.aota@wdc.com>,
        <jth@kernel.org>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] zonefs: Fix race between modprobe and mount
Date:   Sun, 20 Nov 2022 18:57:59 +0800
Message-ID: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a race between modprobe and mount as below:

 modprobe zonefs                | mount -t zonefs
--------------------------------|-------------------------
 zonefs_init                    |
  register_filesystem       [1] |
                                | zonefs_fill_super    [2]
  zonefs_sysfs_init         [3] |

1. register zonefs suceess, then
2. user can mount the zonefs
3. if sysfs initialize failed, the module initialize failed.

Then the mount process maybe some error happened since the module
initialize failed.

Let's register zonefs after all dependency resource ready. And
reorder the dependency resource release in module exit.

Fixes: 9277a6d4fbd4 ("zonefs: Export open zone resource information through sysfs")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/zonefs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..625749fbedf4 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1905,18 +1905,18 @@ static int __init zonefs_init(void)
 	if (ret)
 		return ret;
 
-	ret = register_filesystem(&zonefs_type);
+	ret = zonefs_sysfs_init();
 	if (ret)
 		goto destroy_inodecache;
 
-	ret = zonefs_sysfs_init();
+	ret = register_filesystem(&zonefs_type);
 	if (ret)
-		goto unregister_fs;
+		goto sysfs_exit;
 
 	return 0;
 
-unregister_fs:
-	unregister_filesystem(&zonefs_type);
+sysfs_exit:
+	zonefs_sysfs_exit();
 destroy_inodecache:
 	zonefs_destroy_inodecache();
 
@@ -1925,9 +1925,9 @@ static int __init zonefs_init(void)
 
 static void __exit zonefs_exit(void)
 {
+	unregister_filesystem(&zonefs_type);
 	zonefs_sysfs_exit();
 	zonefs_destroy_inodecache();
-	unregister_filesystem(&zonefs_type);
 }
 
 MODULE_AUTHOR("Damien Le Moal");
-- 
2.31.1

