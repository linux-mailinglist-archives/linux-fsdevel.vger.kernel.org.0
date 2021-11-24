Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E0545D0FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352601AbhKXXSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346233AbhKXXSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9CBC06174A;
        Wed, 24 Nov 2021 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6mHHcyDVvmaaWAZWfzLVXCeFxFqvaI0dcZ+/wo61JNE=; b=PcrUj+Oyhwva3894+5ogE5C8Eq
        gjWAPPu11SjDee+tj8pmC9JTSV8okNKSNwQgHY6mH6hONupNAbzEY9rPIo1QVoPo65upx32ayD/6O
        wDGpOMVfikzVGemkeOFJUIHff3HBoArnQlYL5KNOoiyC+GkxEgVjrBF8cxcx4Mbbyfwh1RfFwa3eU
        tuU89jBld0XUv7WuEmdOoMNZo8HKG8aAnSPzSzykulv5XY96ev9B8I4fyf8k1vPo8J9Do6rpexgz+
        fRen0SyRopWNqpCHsCDrlGnmVJhsAwmSSOMMUxLN9by6cjmjGkxba06Y2K5RnYFZQ72QIThvo2ekt
        8neUjt5Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063zE-Qa; Wed, 24 Nov 2021 23:14:36 +0000
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
Subject: [PATCH v2 6/8] scsi/sg: move sg-big-buff sysctl to scsi/sg.c
Date:   Wed, 24 Nov 2021 15:14:33 -0800
Message-Id: <20211124231435.1445213-7-mcgrof@kernel.org>
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

So move the sg-big-buff sysctl from kernel/sysctl.c to
drivers/scsi/sg.c and use register_sysctl() to register the
sysctl interface.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: commit log update]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sg.c | 35 ++++++++++++++++++++++++++++++++++-
 include/scsi/sg.h |  4 ----
 kernel/sysctl.c   | 12 ------------
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 141099ab9092..32129bb16521 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -77,7 +77,7 @@ static int sg_proc_init(void);
 
 #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
 
-int sg_big_buff = SG_DEF_RESERVED_SIZE;
+static int sg_big_buff = SG_DEF_RESERVED_SIZE;
 /* N.B. This variable is readable and writeable via
    /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
    of this size (or less if there is not enough memory) will be reserved
@@ -1634,6 +1634,37 @@ MODULE_PARM_DESC(scatter_elem_sz, "scatter gather element "
 MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
 MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow))");
 
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+
+static struct ctl_table sg_sysctls[] = {
+	{
+		.procname	= "sg-big-buff",
+		.data		= &sg_big_buff,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{}
+};
+
+static struct ctl_table_header *hdr;
+static void register_sg_sysctls(void)
+{
+	if (!hdr)
+		hdr = register_sysctl("kernel", sg_sysctls);
+}
+
+static void unregister_sg_sysctls(void)
+{
+	if (hdr)
+		unregister_sysctl_table(hdr);
+}
+#else
+#define register_sg_sysctls() do { } while (0)
+#define unregister_sg_sysctls() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
 static int __init
 init_sg(void)
 {
@@ -1666,6 +1697,7 @@ init_sg(void)
 		return 0;
 	}
 	class_destroy(sg_sysfs_class);
+	register_sg_sysctls();
 err_out:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
@@ -1674,6 +1706,7 @@ init_sg(void)
 static void __exit
 exit_sg(void)
 {
+	unregister_sg_sysctls();
 #ifdef CONFIG_SCSI_PROC_FS
 	remove_proc_subtree("scsi/sg", NULL);
 #endif				/* CONFIG_SCSI_PROC_FS */
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index 843cefb8efce..068e35d36557 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -29,10 +29,6 @@
  * For utility and test programs see: http://sg.danny.cz/sg/sg3_utils.html
  */
 
-#ifdef __KERNEL__
-extern int sg_big_buff; /* for sysctl */
-#endif
-
 
 typedef struct sg_iovec /* same structure as used by readv() Linux system */
 {                       /* call. It defines one scatter-gather element. */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 02ef27804601..a4bda4a11ea8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -94,9 +94,6 @@
 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_LOCK_STAT)
 #include <linux/lockdep.h>
 #endif
-#ifdef CONFIG_CHR_DEV_SG
-#include <scsi/sg.h>
-#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/stackleak.h>
 #endif
@@ -2089,15 +2086,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dostring,
 	},
 #endif
-#ifdef CONFIG_CHR_DEV_SG
-	{
-		.procname	= "sg-big-buff",
-		.data		= &sg_big_buff,
-		.maxlen		= sizeof (int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	{
 		.procname	= "acct",
-- 
2.33.0

