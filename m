Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF138615CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiKBH2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKBH2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:28:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAC1CFFC
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 00:28:10 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2JLC01rnzpW7t;
        Wed,  2 Nov 2022 15:24:34 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 15:28:07 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <gregkh@linuxfoundation.org>,
        <abbotti@mev.co.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2] chardev: Fix potential memory leak when cdev_add() failed
Date:   Wed, 2 Nov 2022 15:26:59 +0800
Message-ID: <20221102072659.23671-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some init function of cdev(like comedi) will call kobject_set_name()
before cdev_add(), but won't free the cdev.kobj.name or put the ref cnt
of cdev.kobj when cdev_add() failed. As the result, cdev.kobj.name will
be leaked.

Free the name of kobject in cdev_add() fail path to prevent memleak. With
this fix, the callers don't need to care about freeing the name of
kobject if cdev_add() fails.

unreferenced object 0xffff8881000fa8c0 (size 8):
  comm "modprobe", pid 239, jiffies 4294905173 (age 51.308s)
  hex dump (first 8 bytes):
    63 6f 6d 65 64 69 00 ff                          comedi..
  backtrace:
    [<000000005f9878f7>] __kmalloc_node_track_caller+0x4c/0x1c0
    [<000000000fd70302>] kstrdup+0x3f/0x70
    [<000000009428bc33>] kstrdup_const+0x46/0x60
    [<00000000ed50d9de>] kvasprintf_const+0xdb/0xf0
    [<00000000b2766964>] kobject_set_name_vargs+0x3c/0xe0
    [<00000000f2424ef7>] kobject_set_name+0x62/0x90
    [<000000005d5a125b>] 0xffffffffa0013098
    [<00000000f331e663>] do_one_initcall+0x7a/0x380
    [<00000000aa7bac96>] do_init_module+0x5c/0x230
    [<000000005fd72335>] load_module+0x227d/0x2420
    [<00000000ad550cf1>] __do_sys_finit_module+0xd5/0x140
    [<00000000069a60c5>] do_syscall_64+0x3f/0x90
    [<00000000c5e0d521>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- free the name inside of cdev_add() instead of in comedi_init().
---
 fs/char_dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..340e4543b24a 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,17 +483,24 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 	p->dev = dev;
 	p->count = count;
 
-	if (WARN_ON(dev == WHITEOUT_DEV))
-		return -EBUSY;
+	if (WARN_ON(dev == WHITEOUT_DEV)) {
+		error = -EBUSY;
+		goto err;
+	}
 
 	error = kobj_map(cdev_map, dev, count, NULL,
 			 exact_match, exact_lock, p);
 	if (error)
-		return error;
+		goto err;
 
 	kobject_get(p->kobj.parent);
 
 	return 0;
+
+err:
+	kfree_const(p->kobj.name);
+	p->kobj.name = NULL;
+	return error;
 }
 
 /**
-- 
2.17.1

