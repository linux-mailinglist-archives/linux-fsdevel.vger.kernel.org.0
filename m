Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF594AB0A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiBFQ2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 11:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBFQ2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:28:15 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E8C06173B;
        Sun,  6 Feb 2022 08:28:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V3h3zbK_1644164890;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0V3h3zbK_1644164890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 00:28:11 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com
Subject: [PATCH] chardev: call tty_init() in real chrdev_init()
Date:   Mon,  7 Feb 2022 00:27:31 +0800
Message-Id: <4e753e51d0516413fbf557cf861d654ca73486cc.1644164597.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is confusing that tty_init() in called in the initialization of
memdev, i.e., static chr_dev_init().

Through blame, it is introduced by commit 31d1d48e199e ("Fix init
ordering of /dev/console vs callers of modprobe"), which fixes the
initialization order of /dev/console driver. However, there seems
to be a typo in the patch, i.e., chrdev_init, instead of chr_dev_init.

This fixes the typo, IIUC.

Note that the return value of tty_init() is always 0, and thus no error
handling is provided in chrdev_init().

Fixes: 31d1d48e199e ("Fix init ordering of /dev/console vs callers of modprobe")
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 drivers/char/mem.c | 2 +-
 fs/char_dev.c      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..8c90881f8115 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -775,7 +775,7 @@ static int __init chr_dev_init(void)
 			      NULL, devlist[minor].name);
 	}
 
-	return tty_init();
+	return 0;
 }
 
 fs_initcall(chr_dev_init);
diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..fc042a0a098f 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -667,6 +667,7 @@ static struct kobject *base_probe(dev_t dev, int *part, void *data)
 void __init chrdev_init(void)
 {
 	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
+	tty_init();
 }
 
 
-- 
2.20.1.2432.ga663e714

