Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF245AD3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhKWU1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhKWU12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6101C06174A;
        Tue, 23 Nov 2021 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=42+rcJP+POcnX3Rb0pZBSJe7gq96j01b4VwcjFqS9Hs=; b=s35rZbJnqRzDZZ+VkD3mcuq4S9
        P/LaVvaGmMfOg5oPaZIyQqEbMWWBA73rq0asSpW0cW2mzdPy5cutTPXsGoBCPO8uKRIaaZmFgIymD
        UEr2Hod0u/GhuvEB2qRI5lRuT2oL8P03vQiqJvDWl/RuXCUR6q03PPsIw3A/D4T6PSS4tIaUlUQVf
        p8x8YcS3LpVREiKQgxbHjeVwWRPvtVxgnHwwfL0nUfV3igSvnzOop33hcuCKxj9c9/nnrxB8ZdmlA
        KdPcxoPTZAYSpDINaHJuvzCUy/dpyHHFWOZYpon//fNOeaKRnOlUabtn4DN96TN3nsVZa/3Uf4+yo
        QhrZUwyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qqs-3n; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/9] sysctl: add a new register_sysctl_init() interface
Date:   Tue, 23 Nov 2021 12:23:39 -0800
Message-Id: <20211123202347.818157-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
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

Today though folks heavily rely on tables on kernel/sysctl.c so
they can easily just extend this table with their needed sysctls.
In order to help users move their sysctls out we need to provide a
helper which can be used during code initialization.

We special-case the initialization use of register_sysctl() since
it *is* safe to fail, given all that sysctls do is provide a dynamic
interface to query or modify at runtime an existing variable. So the
use case of register_sysctl() on init should *not* stop if the sysctls
don't end up getting registered. It would be counter productive to
stop boot if a simple sysctl registration failed.

Provide a helper for init then, and document the recommended init
levels to use for callers of this routine. We will later use this
in subsequent patches to start slimming down kernel/sysctl.c tables
and moving sysctl registration to the code which actually needs
these sysctls.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[mcgrof: major commit log and documentation rephrasing
 also moved to fs/proc/proc_sysctl.c                  ]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/sysctl.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5d66faecd4ef..b4950843d90a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/mount.h>
+#include <linux/kmemleak.h>
 #include "internal.h"
 
 static const struct dentry_operations proc_sys_dentry_operations;
@@ -1384,6 +1385,38 @@ struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *tab
 }
 EXPORT_SYMBOL(register_sysctl);
 
+/**
+ * __register_sysctl_init() - register sysctl table to path
+ * @path: path name for sysctl base
+ * @table: This is the sysctl table that needs to be registered to the path
+ * @table_name: The name of sysctl table, only used for log printing when
+ *              registration fails
+ *
+ * The sysctl interface is used by userspace to query or modify at runtime
+ * a predefined value set on a variable. These variables however have default
+ * values pre-set. Code which depends on these variables will always work even
+ * if register_sysctl() fails. If register_sysctl() fails you'd just loose the
+ * ability to query or modify the sysctls dynamically at run time. Chances of
+ * register_sysctl() failing on init are extremely low, and so for both reasons
+ * this function does not return any error as it is used by initialization code.
+ *
+ * Context: Can only be called after your respective sysctl base path has been
+ * registered. So for instance, most base directories are registered early on
+ * init before init levels are processed through proc_sys_init() and
+ * sysctl_init().
+ */
+void __init __register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name)
+{
+	struct ctl_table_header *hdr = register_sysctl(path, table);
+
+	if (unlikely(!hdr)) {
+		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		return;
+	}
+	kmemleak_not_leak(hdr);
+}
+
 static char *append_path(const char *path, char *pos, const char *name)
 {
 	int namelen;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 1fa2b69c6fc3..d3ab7969b6b5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -199,6 +199,9 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+extern void __register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name);
+#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
 void do_sysctl_args(void);
 
 extern int pwrsw_enabled;
-- 
2.33.0

