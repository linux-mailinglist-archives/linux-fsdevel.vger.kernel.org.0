Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E88462697
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhK2Wyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhK2Wx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A695C0F4B2D;
        Mon, 29 Nov 2021 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YUiFYp6egga9CIc/4TwuNv2icY9cBUMAxRYkAit29I0=; b=BEdnDMhMHXlvjHZbZGIZUpc6ZG
        CZ8+WswVe7qmyDifTA92raDbDO5Adn7lRn4wUsuqlzigIQz8UdF1hTQoO5+VxDfAfjgCcW8Xh18/n
        jlhSdnyp3HHRiyRwbMGVUn0QnLpYMeD6hsrOz3e7iMfyfHJpycus4eIW7VdAfovZ03VBwlsO5YmKS
        PsPVG1njC8j5+HTGaAE32AMTy6BM4RFb9eV78cL3QW85vj43EeSqbPiTxjsfifljyLX+bNqK0JscU
        RuOPzufcv3z35hNNwPLBq0L3K3sd9mEHkBRH4aBaDPFPZB0Q5Y1/ujuG8qbl5ePZukqiO9s7ncP9/
        Vczbjr0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZt-Af; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] fs: move namei sysctls to its own file
Date:   Mon, 29 Nov 2021 12:55:46 -0800
Message-Id: <20211129205548.605569-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move namei's own sysctl knobs to its own file.

Other than the move we also avoid initializing two static
variables to 0 as this is not needed:

  * sysctl_protected_symlinks
  * sysctl_protected_hardlinks

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/namei.c         | 58 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  1 -
 kernel/sysctl.c    | 36 ----------------------------
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..8d4f832f94aa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1020,10 +1020,60 @@ static inline void put_link(struct nameidata *nd)
 		path_put(&last->link);
 }
 
-int sysctl_protected_symlinks __read_mostly = 0;
-int sysctl_protected_hardlinks __read_mostly = 0;
-int sysctl_protected_fifos __read_mostly;
-int sysctl_protected_regular __read_mostly;
+static int sysctl_protected_symlinks __read_mostly;
+static int sysctl_protected_hardlinks __read_mostly;
+static int sysctl_protected_fifos __read_mostly;
+static int sysctl_protected_regular __read_mostly;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table namei_sysctls[] = {
+	{
+		.procname	= "protected_symlinks",
+		.data		= &sysctl_protected_symlinks,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "protected_hardlinks",
+		.data		= &sysctl_protected_hardlinks,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "protected_fifos",
+		.data		= &sysctl_protected_fifos,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "protected_regular",
+		.data		= &sysctl_protected_regular,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{ }
+};
+
+static int __init init_fs_namei_sysctls(void)
+{
+	register_sysctl_init("fs", namei_sysctls);
+	return 0;
+}
+fs_initcall(init_fs_namei_sysctls);
+
+#endif /* CONFIG_SYSCTL */
 
 /**
  * may_follow_link - Check symlink following for unsafe situations
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ff634184f58..233b5ab38fe0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -80,7 +80,6 @@ extern void __init files_maxfiles_init(void);
 
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
-extern int leases_enable, lease_break_time;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 52a86746ac9d..39ba8e09ce31 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2896,42 +2896,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "protected_symlinks",
-		.data		= &sysctl_protected_symlinks,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "protected_hardlinks",
-		.data		= &sysctl_protected_hardlinks,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "protected_fifos",
-		.data		= &sysctl_protected_fifos,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "protected_regular",
-		.data		= &sysctl_protected_regular,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
 	{
 		.procname	= "suid_dumpable",
 		.data		= &suid_dumpable,
-- 
2.33.0

