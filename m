Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02B45D0F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352571AbhKXXS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346178AbhKXXSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B8C061748;
        Wed, 24 Nov 2021 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/aIec64rYzvlPvAIZNV8Qzr9X+NGmq0pypwvttkmI2c=; b=T8+yt/AOfazUvt6fq9jnZas6a2
        T9dHp4gTpiroGGQBPuNW8BIuB5GJUiNPL5TNGwftcit3UDzTIKfhRHqnjTfVEafiVh1rWCYa4PzgH
        aRw0n4ZWCTaNYHVjHkByEMfAtFPV/CJWkAnIV8P++/6e29e0G/pJoHQOtDHCni+EsgPQg7ntGYNdp
        2lqCd7x+HWAbrg4u2EtvTLtZhF+Zul3KUEcYTzwm17f+OedOxcZVCwQCTdU4Rc4Gc51mGUeWzwqDz
        aMr8Mh2AgkFWAzZIw+4r3ULYm0S2oPM2li7ot84Q24pw3j9f69J5wPeF3cHWMzQHIQooD943LK0JB
        nKrCuMNQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063yx-Jk; Wed, 24 Nov 2021 23:14:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] firmware_loader: move firmware sysctl to its own files
Date:   Wed, 24 Nov 2021 15:14:28 -0800
Message-Id: <20211124231435.1445213-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move the firmware configuration sysctl table to the only place
where it is used, and make it clear that if sysctls are disabled
this is not used.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: major commit log update to justify the move]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c       |  7 ++++++-
 drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
 drivers/base/firmware_loader/fallback_table.c | 21 +++++++++++++++++--
 include/linux/sysctl.h                        |  1 -
 kernel/sysctl.c                               |  7 -------
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index d7d63c1aa993..4afb0e9312c0 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -199,11 +199,16 @@ static struct class firmware_class = {
 
 int register_sysfs_loader(void)
 {
-	return class_register(&firmware_class);
+	int ret = class_register(&firmware_class);
+
+	if (ret != 0)
+		return ret;
+	return register_firmware_config_sysctl();
 }
 
 void unregister_sysfs_loader(void)
 {
+	unregister_firmware_config_sysctl();
 	class_unregister(&firmware_class);
 }
 
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 3af7205b302f..9f3055d3b4ca 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -42,6 +42,17 @@ void fw_fallback_set_default_timeout(void);
 
 int register_sysfs_loader(void);
 void unregister_sysfs_loader(void);
+#ifdef CONFIG_SYSCTL
+extern int register_firmware_config_sysctl(void);
+extern void unregister_firmware_config_sysctl(void);
+#else
+static inline int register_firmware_config_sysctl(void)
+{
+	return 0;
+}
+static inline void unregister_firmware_config_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */
+
 #else /* CONFIG_FW_LOADER_USER_HELPER */
 static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 					  struct device *device,
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 46a731dede6f..51751c46cdcf 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -24,7 +24,7 @@ struct firmware_fallback_config fw_fallback_config = {
 EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
 
 #ifdef CONFIG_SYSCTL
-struct ctl_table firmware_config_table[] = {
+static struct ctl_table firmware_config_table[] = {
 	{
 		.procname	= "force_sysfs_fallback",
 		.data		= &fw_fallback_config.force_sysfs_fallback,
@@ -45,4 +45,21 @@ struct ctl_table firmware_config_table[] = {
 	},
 	{ }
 };
-#endif
+
+static struct ctl_table_header *firmware_config_sysct_table_header;
+int register_firmware_config_sysctl(void)
+{
+	firmware_config_sysct_table_header =
+		register_sysctl("kernel/firmware_config",
+				firmware_config_table);
+	if (!firmware_config_sysct_table_header)
+		return -ENOMEM;
+	return 0;
+}
+
+void unregister_firmware_config_sysctl(void)
+{
+	unregister_sysctl_table(firmware_config_sysct_table_header);
+	firmware_config_sysct_table_header = NULL;
+}
+#endif /* CONFIG_SYSCTL */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 5e0428a71899..ae6e66177d88 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -217,7 +217,6 @@ extern int no_unaligned_warning;
 
 extern struct ctl_table sysctl_mount_point[];
 extern struct ctl_table random_table[];
-extern struct ctl_table firmware_config_table[];
 
 #else /* CONFIG_SYSCTL */
 static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b09ff41720e3..3032aaa11ed9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2153,13 +2153,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0555,
 		.child		= usermodehelper_table,
 	},
-#ifdef CONFIG_FW_LOADER_USER_HELPER
-	{
-		.procname	= "firmware_config",
-		.mode		= 0555,
-		.child		= firmware_config_table,
-	},
-#endif
 	{
 		.procname	= "overflowuid",
 		.data		= &overflowuid,
-- 
2.33.0

