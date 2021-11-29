Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC646271C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhK2XBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhK2XA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02FAC061A29;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rBNVpRPd5ZL8yjJjpxEaVKNdJd4SrY41srBrEyEXnxo=; b=Qt98r2/k1vgwNlzzpBeBx2uLdf
        PUQVE3XpKMeXv21ZO04daNJmh1lWN0NVJCaIUBEp6SoubVi8P4ISukgVkeNmow/kwiwEpfS6fRq6C
        nKDjok7ryYQoCZm0VW+PVqq4KniTEcuejoga9AoC789zfLunqgE6bzKNb/H2ErXlFmKVQiBh17Mc8
        ylpqGbHyOg07pALu5iBwJEv56yZAX6eVwDWIoo7H+f6XuREd4nqnu+fS8RGWyYsXU9LFV2cB0UA4B
        bOVpYG1+WBkMqEIIA5YXRY/cS5nng5q6iwsP1MzJu1WyDkBz/obAOQ9VKOuK08rk8YITn2/kes5hb
        QuFW6j9g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002gZw-Ks; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sysctl: add and use base directory declarer and registration helper
Date:   Mon, 29 Nov 2021 13:19:38 -0800
Message-Id: <20211129211943.640266-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129211943.640266-1-mcgrof@kernel.org>
References: <20211129211943.640266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a set of helpers which can be used to declare and register
base directory sysctls on their own. We do this so we can later
move each of the base sysctl directories like "fs", "kernel", etc,
to their own respective files instead of shoving the declarations
and registrations all on kernel/sysctl.c. The lazy approach has
caught up and with this, we just end up extending the list of
base directories / sysctls on one file and this makes maintenance
difficult due to merge conflicts from many developers.

The declarations is used first by kernel/sysctl.c for registration
its own base which over time we'll try to clean up. It will be used
in the next patch to demonstrate how to cleanly deal with base sysctl
directories.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  |  9 +++++++++
 include/linux/sysctl.h | 23 +++++++++++++++++++++++
 kernel/sysctl.c        | 41 ++++++++++-------------------------------
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 675b625fa898..93a49ca82d64 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1646,6 +1646,15 @@ struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 }
 EXPORT_SYMBOL(register_sysctl_table);
 
+int __register_sysctl_base(struct ctl_table *base_table)
+{
+	struct ctl_table_header *hdr;
+
+	hdr = register_sysctl_table(base_table);
+	kmemleak_not_leak(hdr);
+	return 0;
+}
+
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 4294e9668bd5..b4b280e7b6c1 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -194,6 +194,19 @@ struct ctl_path {
 
 #ifdef CONFIG_SYSCTL
 
+#define DECLARE_SYSCTL_BASE(_name, _table)				\
+static struct ctl_table _name##_base_table[] = {			\
+	{								\
+		.procname	= #_name,				\
+		.mode		= 0555,					\
+		.child		= _table,				\
+	},								\
+}
+
+extern int __register_sysctl_base(struct ctl_table *base_table);
+
+#define register_sysctl_base(_name) __register_sysctl_base(_name##_base_table)
+
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
 
 extern void setup_sysctl_set(struct ctl_table_set *p,
@@ -236,6 +249,16 @@ extern int no_unaligned_warning;
 extern struct ctl_table sysctl_mount_point[];
 
 #else /* CONFIG_SYSCTL */
+
+#define DECLARE_SYSCTL_BASE(_name, _table)
+
+static inline int __register_sysctl_base(struct ctl_table *base_table)
+{
+	return 0;
+}
+
+#define register_sysctl_base(table) __register_sysctl_base(table)
+
 static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
 {
 	return NULL;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a4cde441635d..bbbafe545723 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2850,41 +2850,20 @@ static struct ctl_table dev_table[] = {
 	{ }
 };
 
-static struct ctl_table sysctl_base_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= kern_table,
-	},
-	{
-		.procname	= "vm",
-		.mode		= 0555,
-		.child		= vm_table,
-	},
-	{
-		.procname	= "fs",
-		.mode		= 0555,
-		.child		= fs_table,
-	},
-	{
-		.procname	= "debug",
-		.mode		= 0555,
-		.child		= debug_table,
-	},
-	{
-		.procname	= "dev",
-		.mode		= 0555,
-		.child		= dev_table,
-	},
-	{ }
-};
+DECLARE_SYSCTL_BASE(kernel, kern_table);
+DECLARE_SYSCTL_BASE(vm, vm_table);
+DECLARE_SYSCTL_BASE(fs, fs_table);
+DECLARE_SYSCTL_BASE(debug, debug_table);
+DECLARE_SYSCTL_BASE(dev, dev_table);
 
 int __init sysctl_init(void)
 {
-	struct ctl_table_header *hdr;
+	register_sysctl_base(kernel);
+	register_sysctl_base(vm);
+	register_sysctl_base(fs);
+	register_sysctl_base(debug);
+	register_sysctl_base(dev);
 
-	hdr = register_sysctl_table(sysctl_base_table);
-	kmemleak_not_leak(hdr);
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
-- 
2.33.0

