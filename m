Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B614BB76D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiBRLAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 06:00:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiBRLAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:00:32 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F2238901
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 03:00:15 -0800 (PST)
X-QQ-mid: bizesmtp67t1645181999tkqrwa4u
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Feb 2022 18:59:53 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00M0000000
X-QQ-FEAT: Lrjk7Ti9kjiycnf/HJB03UJzBsueqWUhUXioFSdAl8z5DeJyXcGEgbTEWkY8Z
        tlSY2FaakRoz9rxks4ej69Dr5xLalOMJjc9Cp/HothRGQOPZ9KH4sygP3ietuFRK9YQzkUE
        CfPvhl+SxQ7OZe7hSJlZSvwNJPIixEaAXB9kTW9mbACkWlU/TgM1iE6dBjCs3Lt+rMewEoD
        z1BeFW4mkjpb/rYmXknsPh6ncO0R6pL7+xY1opKDZvJuTKzgHCKEpJ+xBCT9UpbG9SaF+Kq
        IENOVLHeq9kM3OHPVDm6LEmGRkHpDwBj9xYxJnOIHVuQ9DMKRvdzz571Wv8Jhlt2f7X845l
        KJ1PRox6Qj2jQVeeMVLZA7L1PLIsFKcQfd9tDsDuqK/sc8ZgvI=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 5/5] kernel/do_mount_initrd: move real_root_dev sysctls to its own file
Date:   Fri, 18 Feb 2022 18:59:49 +0800
Message-Id: <20220218105949.13125-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
follows the commit of fs, move the real_root_dev sysctl to its own file,
kernel/do_mount_initrd.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/initrd.h  |  2 --
 init/do_mounts_initrd.c | 22 +++++++++++++++++++++-
 kernel/sysctl.c         |  9 ---------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 1bbe9af48dc3..f1a1f4c92ded 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -29,8 +29,6 @@ static inline void wait_for_initramfs(void) {}
 extern phys_addr_t phys_initrd_start;
 extern unsigned long phys_initrd_size;
 
-extern unsigned int real_root_dev;
-
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 533d81ed74d4..327962ea354c 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -14,12 +14,32 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
+static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_do_mounts_initrd_table[] = {
+	{
+		.procname       = "real-root-dev",
+		.data           = &real_root_dev,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static __init int kernel_do_mounts_initrd_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
+	return 0;
+}
+late_initcall(kernel_do_mounts_initrd_sysctls_init);
+#endif /* CONFIG_SYSCTL */
+
 static int __init no_initrd(char *str)
 {
 	mount_initrd = 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e448f43a8988..64d368d59a58 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1699,15 +1699,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_latencytop,
 	},
-#endif
-#ifdef CONFIG_BLK_DEV_INITRD
-	{
-		.procname	= "real-root-dev",
-		.data		= &real_root_dev,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #endif
 	{
 		.procname	= "print-fatal-signals",
-- 
2.20.1



