Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672045AD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhKWU13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKWU11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4575C06173E;
        Tue, 23 Nov 2021 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0uiVVfCrmrnA3HyskcCNM7wqu1ahLKV+lp229wsLino=; b=WhbMjlS7eKgsfwy6XNC60TzaMi
        dEp5WwXp+u44cMCV3ojUjj5OZquL8ZahocP+N1O0hu+JrRRh8DTprbWdO+PrsPCamtZ1w35eIsMRy
        nAwKKmpYcB61+IPkoFdZFB9hk/wkyfHgfLeBGZIacsIPUHioiBgVlGTg57wtRKkBFrSWgxeB9EkNM
        Xo73iKnh3M1x2N6UEAvVhQzneOCn+MX3DDnwIxuwbS8669IR8N7zW/8rg8L8ZgrFGyA+Rvb77bL4w
        McgSYBkTZ5JvS4wo029cZ9onCptO9Cg1Kgssz2fEw2/c8zuKHHAiKizjjGKaHa9si3UxPT843lY/G
        DLMNDmMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qr6-CL; Tue, 23 Nov 2021 20:23:48 +0000
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
Subject: [PATCH v2 8/9] aio: move aio sysctl to aio.c
Date:   Tue, 23 Nov 2021 12:23:46 -0800
Message-Id: <20211123202347.818157-9-mcgrof@kernel.org>
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

Move aio sysctl to aio.c and use the new register_sysctl_init() to
register the sysctl interface for aio.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: adjust commit log to justify the move]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/aio.c            | 31 +++++++++++++++++++++++++++++--
 include/linux/aio.h |  4 ----
 kernel/sysctl.c     | 17 -----------------
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9c81cf611d65..83ef2341e73f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -219,9 +219,35 @@ struct aio_kiocb {
 
 /*------ sysctl variables----*/
 static DEFINE_SPINLOCK(aio_nr_lock);
-unsigned long aio_nr;		/* current system wide number of aio requests */
-unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
+static unsigned long aio_nr;		/* current system wide number of aio requests */
+static unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
+#ifdef CONFIG_SYSCTL
+static struct ctl_table aio_sysctls[] = {
+	{
+		.procname	= "aio-nr",
+		.data		= &aio_nr,
+		.maxlen		= sizeof(aio_nr),
+		.mode		= 0444,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "aio-max-nr",
+		.data		= &aio_max_nr,
+		.maxlen		= sizeof(aio_max_nr),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{}
+};
+
+static void __init aio_sysctl_init(void)
+{
+	register_sysctl_init("fs", aio_sysctls);
+}
+#else
+#define aio_sysctl_init() do { } while (0)
+#endif
 
 static struct kmem_cache	*kiocb_cachep;
 static struct kmem_cache	*kioctx_cachep;
@@ -274,6 +300,7 @@ static int __init aio_setup(void)
 
 	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
 	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
+	aio_sysctl_init();
 	return 0;
 }
 __initcall(aio_setup);
diff --git a/include/linux/aio.h b/include/linux/aio.h
index b83e68dd006f..86892a4fe7c8 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -20,8 +20,4 @@ static inline void kiocb_set_cancel_fn(struct kiocb *req,
 				       kiocb_cancel_fn *cancel) { }
 #endif /* CONFIG_AIO */
 
-/* for sysctl: */
-extern unsigned long aio_nr;
-extern unsigned long aio_max_nr;
-
 #endif /* __LINUX__AIO_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 597ab5ad4879..20326d67b814 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/aio.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -3110,22 +3109,6 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_AIO
-	{
-		.procname	= "aio-nr",
-		.data		= &aio_nr,
-		.maxlen		= sizeof(aio_nr),
-		.mode		= 0444,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "aio-max-nr",
-		.data		= &aio_max_nr,
-		.maxlen		= sizeof(aio_max_nr),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif /* CONFIG_AIO */
 #ifdef CONFIG_INOTIFY_USER
 	{
 		.procname	= "inotify",
-- 
2.33.0

