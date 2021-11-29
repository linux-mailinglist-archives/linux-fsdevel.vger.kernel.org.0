Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80A2462713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhK2XA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhK2XA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E2C061A2B;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=64vsI4dbfjkrGelXbwngfuUDjOTcfd+jb6DHjfeWIbU=; b=pDnunMYeu3e7P9Pui4VLjA5+AB
        TrhrEzFEoMFfGDcJHmShM0t6Lu9s4MMA1o5uASd4Oa52lv3nS2HdIbV1M7LSm7spx9N7KX58HDbaM
        mpxHMw0wF9oCTpKj4eX1feZTufqTxYhI47hQtcWQ8ZPVXZ3e+6F6Nh/SzKFDKSwLEF66rmNhBVM//
        aRo00TdIOQKYFgHy8nI2mAmlRIv4/Wfkq5d1M5oGK+Yi5RFgW6C6e20+cKtJ3mZCMZIo7uWrpqpg+
        jbAMlVCL6zdfS9UcIkL7EnDp6YrKPmfnOhwBqURvZj4zqazatmQuDV+TF802vISkSHVv9MRyWp9am
        grYhQtkw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002ga1-PC; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] kernel/sysctl.c: rename sysctl_init() to sysctl_init_bases()
Date:   Mon, 29 Nov 2021 13:19:40 -0800
Message-Id: <20211129211943.640266-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129211943.640266-1-mcgrof@kernel.org>
References: <20211129211943.640266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename sysctl_init() to sysctl_init_bases() so to reflect exactly
what this is doing.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/arm/mm/alignment.c | 2 +-
 arch/sh/mm/alignment.c  | 2 +-
 fs/proc/proc_sysctl.c   | 4 ++--
 include/linux/sysctl.h  | 2 +-
 kernel/sysctl.c         | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index ea81e89e7740..714dc9e43818 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -1005,7 +1005,7 @@ static int __init noalign_setup(char *__unused)
 __setup("noalign", noalign_setup);
 
 /*
- * This needs to be done after sysctl_init, otherwise sys/ will be
+ * This needs to be done after sysctl_init_bases(), otherwise sys/ will be
  * overwritten.  Actually, this shouldn't be in sys/ at all since
  * it isn't a sysctl, and it doesn't contain sysctl information.
  * We now locate it in /proc/cpu/alignment instead.
diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index 20aaee8db36d..3a76a766f423 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -161,7 +161,7 @@ static const struct proc_ops alignment_proc_ops = {
 };
 
 /*
- * This needs to be done after sysctl_init, otherwise sys/ will be
+ * This needs to be done after sysctl_init_bases(), otherwise sys/ will be
  * overwritten.  Actually, this shouldn't be in sys/ at all since
  * it isn't a sysctl, and it doesn't contain sysctl information.
  * We now locate it in /proc/cpu/alignment instead.
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 93a49ca82d64..46cd5ff256cd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1419,7 +1419,7 @@ EXPORT_SYMBOL(register_sysctl);
  * Context: Can only be called after your respective sysctl base path has been
  * registered. So for instance, most base directories are registered early on
  * init before init levels are processed through proc_sys_init() and
- * sysctl_init().
+ * sysctl_init_bases().
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
@@ -1768,7 +1768,7 @@ int __init proc_sys_init(void)
 	proc_sys_root->proc_dir_ops = &proc_sys_dir_file_operations;
 	proc_sys_root->nlink = 0;
 
-	return sysctl_init();
+	return sysctl_init_bases();
 }
 
 struct sysctl_alias {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b4b280e7b6c1..70acd2a100fd 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -227,7 +227,7 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 
 void unregister_sysctl_table(struct ctl_table_header * table);
 
-extern int sysctl_init(void);
+extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8d4cab1fbe9f..421d29a86c73 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2843,7 +2843,7 @@ DECLARE_SYSCTL_BASE(vm, vm_table);
 DECLARE_SYSCTL_BASE(debug, debug_table);
 DECLARE_SYSCTL_BASE(dev, dev_table);
 
-int __init sysctl_init(void)
+int __init sysctl_init_bases(void)
 {
 	register_sysctl_base(kernel);
 	register_sysctl_base(vm);
-- 
2.33.0

