Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6260A44025C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ2Srw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhJ2Sri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9566C0613F5;
        Fri, 29 Oct 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=daxyne+rgfhLB2iCcxtK7JtrdUqP/GkbwY1AJXraErc=; b=GH8/FI0J9w70bdbLZAUCrvL0xX
        LM5O7QvOlaZ6dNoRttdCgnL0gfbHheoYh66LtvrXWIa5gL6D2vrSx+5lrIiYixOpHJsobzVTQJ3o9
        ty+o7VPTqW7XYO6LAh7+vq9BgXv3uAPaa/gjgs91woTxIg+Jp5WEdBdfhlIE5nqNUihx3gyvrquVD
        RDRBuAs3txx+w/Yc5zla9Sx2a6X9GpeDCG6U2NPEdFJVh5vB9zGR+wZaFwtN1YOXSYuZZLfFmODb4
        EZoDfHnE2KyTKR31lEoOquFjPHkPzDmUN1v4F/Wfqlj4j8VXwcJylF6ZJYB7mPYISWhByILr49Ozb
        EnP1PntQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgWsA-00Bq0V-Eb; Fri, 29 Oct 2021 18:45:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/6] kernfs: add initial failure injection support
Date:   Fri, 29 Oct 2021 11:44:58 -0700
Message-Id: <20211029184500.2821444-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029184500.2821444-1-mcgrof@kernel.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds initial failure injection support to kernfs. We start
off with debug knobs which when enabled allow test drivers, such as
test_sysfs, to then make use of these to try to force certain
difficult races to take place with a high degree of certainty.

This only adds runtime code *iff* the new bool CONFIG_FAIL_KERNFS_KNOBS is
enabled in your kernel. If you don't have this enabled this provides
no new functional. When CONFIG_FAIL_KERNFS_KNOBS is disabled the new
routine may_wait_kernfs_debug() ends up being transformed to a no-op
and so the compiler should optimize these out as dead code producing no
new effective binary changes.

We start off with enabling failure injections in kernfs by allowing us to
alter the way kernfs_fop_write_iter() behaves. We allow for the routine
kernfs_fop_write_iter() to wait for a certain condition in the kernel to
occur, after which it will sleep a configurable amount of time. This lets
kernfs users to time exactly when it want kernfs_fop_write_iter() to
complete, allowing for developing race conditions and test for correctness
in kernfs.

You'd boot with this enabled on your kernel command line:

fail_kernfs_fop_write_iter=1,100,0,1

The values are <interval,probability,size,times>, we don't care for
size, so for now we ignore it. The above ensures a failure will trigger
only once.

*How* we allow for this routine to change behaviour is left to knobs we
expose under debugfs:

 # ls -1 /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/
wait_after_active
wait_after_mutex
wait_at_start
wait_before_mutex

A debugfs entry also exists to allow us to sleep a configurabler amount
of time after the completion:

/sys/kernel/debug/fail_kernfs/sleep_after_wait_ms

These two sets of knobs allow us to construct races and demonstrate
how the kernfs active reference should suffice to protect against
races.

Enabling CONFIG_FAULT_INJECTION_DEBUG_FS enables us to configure the
different fault injection parameters for the new fail_kernfs_fop_write_iter
fault injection at run time:

ls -1 /sys/kernel/debug/fail_kernfs/fail_kernfs_fop_write_iter/
interval
probability
space
task-filter
times
verbose
verbose_ratelimit_burst
verbose_ratelimit_interval_ms

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../fault-injection/fault-injection.rst       | 50 ++++++++++
 MAINTAINERS                                   |  2 +-
 fs/kernfs/Makefile                            |  1 +
 fs/kernfs/fault_inject.c                      | 93 +++++++++++++++++++
 fs/kernfs/file.c                              |  9 ++
 fs/kernfs/kernfs-internal.h                   | 70 ++++++++++++++
 include/linux/kernfs.h                        |  5 +
 lib/Kconfig.debug                             | 10 ++
 8 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 fs/kernfs/fault_inject.c

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 4a25c5eb6f07..af05f285b441 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -28,6 +28,19 @@ Available fault injection capabilities
 
   injects kernel RPC client and server failures.
 
+- fail_kernfs_fop_write_iter
+
+  Allows for failures to be enabled inside kernfs_fop_write_iter(). Enabling
+  this does not immediately enable any errors to occur. You must configure
+  how you want this routine to fail or change behaviour by using the respective
+  debugfs knobs for it documented below under
+  /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/
+
+  If you enable CONFIG_FAULT_INJECTION_DEBUG_FS the fail_add_disk failure
+  injection parameters are placed under:
+
+  /sys/kernel/debug/kernfs/fail_kernfs_fop_write_iter/
+
 - fail_make_request
 
   injects disk IO errors on devices permitted by setting
@@ -155,6 +168,43 @@ configuration of fault-injection capabilities.
 	default is 'N', setting it to 'Y' will disable failure injections
 	when dealing with private (address space) futexes.
 
+- /sys/kernel/debug/fail_kernfs/sleep_after_wait_ms
+
+	Format: { digit-representing-milliseconds }
+
+  Configure how long to sleep in ms after a kernfs_debug_wait_completion
+  wait for completion. This completion is currently only used if any of the
+  waits are enabled under
+  /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/
+
+- /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/wait_after_active
+
+	Format: { 'Y' | 'N' }
+
+  Whether or not to issue a wait for completion after the kernfs_get_active()
+  completes on the kernfs_fop_write_iter() routine.
+
+- /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/wait_after_mutex
+
+	Format: { 'Y' | 'N' }
+
+  Whether or not to issue a wait for completion after the struct
+  kernfs_open_file mutex is taken on the routine kernfs_fop_write_iter().
+
+- /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/wait_at_start
+
+	Format: { 'Y' | 'N' }
+
+  Whether or not to issue a wait for completion after the very beginning of the
+  routine kernfs_fop_write_iter().
+
+- /sys/kernel/debug/fail_kernfs/config_fail_kernfs_fop_write_iter/wait_before_mutex
+
+	Format: { 'Y' | 'N' }
+
+  Whether or not to issue a wait for completion before the struct
+  kernfs_open_file mutex is taken on the routine kernfs_fop_write_iter().
+
 - /sys/kernel/debug/fail_sunrpc/ignore-client-disconnect:
 
 	Format: { 'Y' | 'N' }
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b458c4dd577..61a89bab1d73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10469,7 +10469,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Tejun Heo <tj@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
-F:	fs/kernfs/
+F:	fs/kernfs/*
 F:	include/linux/kernfs.h
 
 KEXEC
diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
index 4ca54ff54c98..79ac7688b108 100644
--- a/fs/kernfs/Makefile
+++ b/fs/kernfs/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-y		:= mount.o inode.o dir.o file.o symlink.o
+obj-$(CONFIG_FAIL_KERNFS_KNOBS)    += fault_inject.o
diff --git a/fs/kernfs/fault_inject.c b/fs/kernfs/fault_inject.c
new file mode 100644
index 000000000000..f887f26646aa
--- /dev/null
+++ b/fs/kernfs/fault_inject.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fault-inject.h>
+#include <linux/delay.h>
+
+#include "kernfs-internal.h"
+
+static DECLARE_FAULT_ATTR(fail_kernfs_fop_write_iter);
+struct kernfs_config_fail kernfs_config_fail;
+
+#define kernfs_config_fail(when) \
+	kernfs_config_fail.kernfs_fop_write_iter_fail.wait_ ## when
+
+#define kernfs_config_fail(when) \
+	kernfs_config_fail.kernfs_fop_write_iter_fail.wait_ ## when
+
+static int __init setup_fail_kernfs_fop_write_iter(char *str)
+{
+	return setup_fault_attr(&fail_kernfs_fop_write_iter, str);
+}
+
+__setup("fail_kernfs_fop_write_iter=", setup_fail_kernfs_fop_write_iter);
+
+struct dentry *kernfs_debugfs_root;
+struct dentry *config_fail_kernfs_fop_write_iter;
+
+static int __init kernfs_init_failure_injection(void)
+{
+	kernfs_config_fail.sleep_after_wait_ms = 100;
+	kernfs_debugfs_root = debugfs_create_dir("fail_kernfs", NULL);
+
+	fault_create_debugfs_attr("fail_kernfs_fop_write_iter",
+				  kernfs_debugfs_root, &fail_kernfs_fop_write_iter);
+
+	config_fail_kernfs_fop_write_iter =
+		debugfs_create_dir("config_fail_kernfs_fop_write_iter",
+				   kernfs_debugfs_root);
+
+	debugfs_create_u32("sleep_after_wait_ms", 0600,
+			   kernfs_debugfs_root,
+			   &kernfs_config_fail.sleep_after_wait_ms);
+
+	debugfs_create_bool("wait_at_start", 0600,
+			    config_fail_kernfs_fop_write_iter,
+			    &kernfs_config_fail(at_start));
+	debugfs_create_bool("wait_before_mutex", 0600,
+			    config_fail_kernfs_fop_write_iter,
+			    &kernfs_config_fail(before_mutex));
+	debugfs_create_bool("wait_after_mutex", 0600,
+			    config_fail_kernfs_fop_write_iter,
+			    &kernfs_config_fail(after_mutex));
+	debugfs_create_bool("wait_after_active", 0600,
+			    config_fail_kernfs_fop_write_iter,
+			    &kernfs_config_fail(after_active));
+	return 0;
+}
+late_initcall(kernfs_init_failure_injection);
+
+DECLARE_COMPLETION(kernfs_debug_wait_completion);
+EXPORT_SYMBOL_NS_GPL(kernfs_debug_wait_completion, KERNFS_DEBUG_PRIVATE);
+
+static void kernfs_debug_wait(void)
+{
+	unsigned long timeout;
+
+	timeout = wait_for_completion_timeout(&kernfs_debug_wait_completion,
+					      msecs_to_jiffies(3000));
+	if (!timeout)
+		pr_info("waiting for kernfs_debug_wait_completion timed out\n");
+	else
+		pr_info("received completion with time left on timeout %u ms\n",
+			jiffies_to_msecs(timeout));
+
+	/**
+	 * The goal is wait for an event, and *then* once we have
+	 * reached it, the other side will try to do something which
+	 * it thinks will break. So we must give it some time to do
+	 * that. The amount of time is configurable.
+	 */
+	msleep(kernfs_config_fail.sleep_after_wait_ms);
+	pr_info("wait for kernfs_debug_wait_completion ended\n");
+}
+
+void __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate)
+{
+	if (!evaluate)
+		return;
+
+	if (should_fail(&fail_kernfs_fop_write_iter, 0))
+		kernfs_debug_wait();
+}
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 60e2a86c535e..860fc8912520 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -259,6 +259,8 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	const struct kernfs_ops *ops;
 	char *buf;
 
+	may_wait_kernfs_debug(kernfs_fop_write_iter, at_start);
+
 	if (of->atomic_write_len) {
 		if (len > of->atomic_write_len)
 			return -E2BIG;
@@ -280,17 +282,24 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 	buf[len] = '\0';	/* guarantee string termination */
 
+	may_wait_kernfs_debug(kernfs_fop_write_iter, before_mutex);
+
 	/*
 	 * @of->mutex nests outside active ref and is used both to ensure that
 	 * the ops aren't called concurrently for the same open file.
 	 */
 	mutex_lock(&of->mutex);
+
+	may_wait_kernfs_debug(kernfs_fop_write_iter, after_mutex);
+
 	if (!kernfs_get_active(of->kn)) {
 		mutex_unlock(&of->mutex);
 		len = -ENODEV;
 		goto out_free;
 	}
 
+	may_wait_kernfs_debug(kernfs_fop_write_iter, after_active);
+
 	ops = kernfs_ops(of->kn);
 	if (ops->write)
 		len = ops->write(of, buf, len, iocb->ki_pos);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1..278bd935982d 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -18,6 +18,7 @@
 
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
+#include <linux/stringify.h>
 
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
@@ -147,4 +148,73 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+/*
+ * failure-injection.c
+ */
+#ifdef CONFIG_FAIL_KERNFS_KNOBS
+
+/**
+ * struct kernfs_fop_write_iter_fail - how kernfs_fop_write_iter_fail fails
+ *
+ * This lets you configure what part of kernfs_fop_write_iter() should behave
+ * in a specific way to allow userspace to capture possible failures in
+ * kernfs. The wait knobs are allowed to let you design capture possible
+ * race conditions which would otherwise be difficult to reproduce. A
+ * secondary driver would tell kernfs's wait completion when it is done.
+ *
+ * The point to the wait completion failure injection tests are to confirm
+ * that the kernfs active refcount suffice to ensure other objects in other
+ * layers are also gauranteed to exist, even they are opaque to kernfs. This
+ * includes kobjects, devices, and other objects built on top of this, like
+ * the block layer when using sysfs block device attributes.
+ *
+ * @wait_at_start: waits for completion from a third party at the start of
+ *	the routine.
+ * @wait_before_mutex: waits for completion from a third party before we
+ *	are allowed to continue before the of->mutex is held.
+ * @wait_after_mutex: waits for completion from a third party after we
+ *	have held the of->mutex.
+ * @wait_after_active: waits for completion from a thid party after we
+ *	have refcounted the struct kernfs_node.
+ */
+struct kernfs_fop_write_iter_fail {
+	bool wait_at_start;
+	bool wait_before_mutex;
+	bool wait_after_mutex;
+	bool wait_after_active;
+};
+
+/**
+ * struct kernfs_config_fail - kernfs configuration for failure injection
+ *
+ * You can kernfs failure injection on boot, and in particular we currently
+ * only support failures for kernfs_fop_write_iter(). However, we don't
+ * want to always enable errors on this call when failure injection is enabled
+ * as this routine is used by many parts of the kernel for proper functionality.
+ * The compromise we make is we let userspace start enabling which parts it
+ * wants to fail after boot, if and only if failure injection has been enabled.
+ *
+ * @kernfs_fop_write_iter_fail: configuration for how we want to allow
+ *	for failure injection on kernfs_fop_write_iter()
+ * @sleep_after_wait_ms: how many ms to wait after completion is received.
+ */
+struct kernfs_config_fail {
+	struct kernfs_fop_write_iter_fail kernfs_fop_write_iter_fail;
+	u32 sleep_after_wait_ms;
+};
+
+extern struct kernfs_config_fail kernfs_config_fail;
+
+#define __kernfs_config_wait_var(func, when) \
+	(kernfs_config_fail.func  ##_fail.wait_  ##when)
+#define __kernfs_debug_should_wait_func_name(func) __kernfs_debug_should_wait_## func
+
+#define may_wait_kernfs_debug(func, when) \
+	__kernfs_debug_should_wait_func_name(func)(__kernfs_config_wait_var(func, when))
+void __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate);
+#else
+static inline void kernfs_init_failure_injection(void) {}
+#define may_wait_kernfs_debug(func, when) do { } while(0)
+#endif
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 3ccce6f24548..cd968ee2b503 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -411,6 +411,11 @@ void kernfs_init(void);
 
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
+
+#ifdef CONFIG_FAIL_KERNFS_KNOBS
+extern struct completion kernfs_debug_wait_completion;
+#endif
+
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ec531b423c0e..04d2c3f53d2a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1902,6 +1902,16 @@ config FAULT_INJECTION_USERCOPY
 	  Provides fault-injection capability to inject failures
 	  in usercopy functions (copy_from_user(), get_user(), ...).
 
+config FAIL_KERNFS_KNOBS
+	bool "Fault-injection support in kernfs"
+	depends on FAULT_INJECTION
+	help
+	  Provide fault-injection capability for kernfs. This only enables
+	  the error injection functionality. To use it you must configure which
+	  which path you want to trigger on error on using debugfs under
+	  /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/. By
+	  default all of these are disabled.
+
 config FAIL_MAKE_REQUEST
 	bool "Fault-injection capability for disk IO"
 	depends on FAULT_INJECTION && BLOCK
-- 
2.30.2

