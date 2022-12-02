Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB063FE86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 04:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLBDEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 22:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:04:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FFFD7572;
        Thu,  1 Dec 2022 19:04:47 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NNd3s2W5mzqSYQ;
        Fri,  2 Dec 2022 11:00:41 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 11:04:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <logang@deltatee.com>, <dan.j.williams@intel.com>,
        <hans.verkuil@cisco.com>, <alexandre.belloni@free-electrons.com>,
        <gregkh@linuxfoundation.org>, <viro@zeniv.linux.org.uk>
Subject: [PATCH resend] chardev: fix error handling in cdev_device_add()
Date:   Fri, 2 Dec 2022 11:02:37 +0800
Message-ID: <20221202030237.520280-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While doing fault injection test, I got the following report:

------------[ cut here ]------------
kobject: '(null)' (0000000039956980): is not initialized, yet kobject_put() is being called.
WARNING: CPU: 3 PID: 6306 at kobject_put+0x23d/0x4e0
CPU: 3 PID: 6306 Comm: 283 Tainted: G        W          6.1.0-rc2-00005-g307c1086d7c9 #1253
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kobject_put+0x23d/0x4e0
Call Trace:
 <TASK>
 cdev_device_add+0x15e/0x1b0
 __iio_device_register+0x13b4/0x1af0 [industrialio]
 __devm_iio_device_register+0x22/0x90 [industrialio]
 max517_probe+0x3d8/0x6b4 [max517]
 i2c_device_probe+0xa81/0xc00

When device_add() is injected fault and returns error, if dev->devt is not set,
cdev_add() is not called, cdev_del() is not needed. Fix this by checking dev->devt
in error path.

Fixes: 233ed09d7fda ("chardev: add helper function to register char devs with a struct device")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
The previous patch link:
https://lore.kernel.org/lkml/20221025113957.693723-1-yangyingliang@huawei.com/
---
 fs/char_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..3f667292608c 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
 	}
 
 	rc = device_add(dev);
-	if (rc)
+	if (rc && dev->devt)
 		cdev_del(cdev);
 
 	return rc;
-- 
2.25.1

