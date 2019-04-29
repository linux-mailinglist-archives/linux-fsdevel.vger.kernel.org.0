Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9591ECB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfD2W0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:26:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2W0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:26:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so18382524wrp.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 15:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTZ5RSyHfx5GXQDAKv+eaknfTx2wVK71/62ZuMkURI0=;
        b=ewLEwvVDrmauNeJPR8RzVu8BWMXMLqWOEJB1bNpa4flSWzw2XgKnZuXyEbNtjjEDWR
         Pz+lcCud6eirS+0m3bhdFx0e/EmD9kgsSYY00te5MMg+HsLGYHMotJfNqIqw3Kl32/Tk
         q+H4OyUBMfjl6Ao7h58o1Ce/dyTPVAMGvHxfh42KSDJWf0WXJX4aVW2SK0uunPiYzwk0
         hxnC6acysrHc4W9qvJ+nPFpXxf8g9dyvz7iLM264t0ThjBCJFfyJcHusHuRMGhJPJNTV
         lu8wOG0mLKThWX578RMeYE4/5I6RIJAeiVNqjKwy3AUkpe7UXY4VdXB7NUAiq5N4QGCB
         910Q==
X-Gm-Message-State: APjAAAVJ0WKUWeI1QWHMaZWnI8FL50ibX7j3R1siX+WuxKdfM2fZGDbH
        sJel/FepTJ0CFHB/C0X6m6oqGQ==
X-Google-Smtp-Source: APXvYqzHlUb7gCgPVnUYjiJo5VyXcrAafkXeqwgm95x98tgYJWhz9h0Auun4X0qfGZpCZKXZuUn+0Q==
X-Received: by 2002:adf:9792:: with SMTP id s18mr14519598wrb.133.1556576774648;
        Mon, 29 Apr 2019 15:26:14 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id j190sm909684wmb.19.2019.04.29.15.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 15:26:13 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] proc/sysctl: add shared variables for range check
Date:   Tue, 30 Apr 2019 00:26:13 +0200
Message-Id: <20190429222613.13345-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the sysctl code the proc_dointvec_minmax() function is often used to
validate the user supplied value between an allowed range. This function
uses the extra1 and extra2 members from struct ctl_table as minimum and
maximum allowed value.

On sysctl handler declaration, in every source file there are some readonly
variables containing just an integer which address is assigned to the
extra1 and extra2 members, so the sysctl range is enforced.

The special values 0, 1 and INT_MAX are very often used as range boundary,
leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
different source files:

    $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
    248

Add a const int array containing the most commonly used values,
some macros to refer more easily to the correct array member,
and use them instead of creating a local one for every object file.

This is the bloat-o-meter output comparing the old and new binary
compiled with the default Fedora config:

    # scripts/bloat-o-meter -d vmlinux.o.old vmlinux.o
    add/remove: 2/2 grow/shrink: 0/2 up/down: 24/-188 (-164)
    Data                                         old     new   delta
    sysctl_vals                                    -      12     +12
    __kstrtab_sysctl_vals                          -      12     +12
    max                                           14      10      -4
    int_max                                       16       -     -16
    one                                           68       -     -68
    zero                                         128      28    -100
    Total: Before=20583249, After=20583085, chg -0.00%

Also make extra1 and extra2 const for better safety
and avoid ugly casts upon struct initialization.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/s390/appldata/appldata_base.c            |  15 +-
 arch/s390/kernel/topology.c                   |   6 +-
 arch/x86/entry/vdso/vdso32-setup.c            |   7 +-
 arch/x86/kernel/itmt.c                        |   6 +-
 drivers/base/firmware_loader/fallback_table.c |  11 +-
 drivers/gpu/drm/i915/i915_perf.c              |   8 +-
 drivers/hv/vmbus_drv.c                        |   6 +-
 drivers/s390/char/sclp_async.c                |   7 +-
 drivers/tty/tty_ldisc.c                       |   6 +-
 drivers/xen/balloon.c                         |   7 +-
 fs/eventpoll.c                                |   3 +-
 fs/notify/inotify/inotify_user.c              |   8 +-
 fs/proc/proc_sysctl.c                         |   4 +
 include/linux/sysctl.h                        |  11 +-
 ipc/ipc_sysctl.c                              |  35 ++--
 kernel/pid_namespace.c                        |   3 +-
 kernel/sysctl.c                               | 193 +++++++++---------
 kernel/ucount.c                               |   6 +-
 net/core/neighbour.c                          |  20 +-
 net/core/sysctl_net_core.c                    |  34 ++-
 net/dccp/sysctl.c                             |  16 +-
 net/ipv4/sysctl_net_ipv4.c                    |  60 +++---
 net/ipv6/addrconf.c                           |   6 +-
 net/ipv6/route.c                              |   7 +-
 net/ipv6/sysctl_net_ipv6.c                    |   8 +-
 net/mpls/af_mpls.c                            |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c                |   3 +-
 net/rxrpc/sysctl.c                            |   9 +-
 net/sctp/sysctl.c                             |  35 ++--
 net/sunrpc/xprtrdma/transport.c               |   3 +-
 net/tipc/sysctl.c                             |   4 +-
 security/keys/sysctl.c                        |  26 ++-
 security/loadpin/loadpin.c                    |   6 +-
 security/yama/yama_lsm.c                      |   3 +-
 34 files changed, 268 insertions(+), 324 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index e4b58240ec53..aa738cad1338 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -220,15 +220,13 @@ appldata_timer_handler(struct ctl_table *ctl, int write,
 			   void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int timer_active = appldata_timer_active;
-	int zero = 0;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &timer_active,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -255,13 +253,12 @@ appldata_interval_handler(struct ctl_table *ctl, int write,
 			   void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int interval = appldata_interval;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &interval,
 		.maxlen		= sizeof(int),
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	};
 
 	rc = proc_dointvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -289,13 +286,11 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
 	struct list_head *lh;
 	int rc, found;
 	int active;
-	int zero = 0;
-	int one = 1;
 	struct ctl_table ctl_entry = {
 		.data		= &active,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	};
 
 	found = 0;
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 8964a3f60aad..2db6fb405a9a 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -587,15 +587,13 @@ static int topology_ctl_handler(struct ctl_table *ctl, int write,
 {
 	int enabled = topology_is_enabled();
 	int new_mode;
-	int zero = 0;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &enabled,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 42d4c89f990e..240626e7f55a 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -65,9 +65,6 @@ subsys_initcall(sysenter_setup);
 /* Register vsyscall32 into the ABI table */
 #include <linux/sysctl.h>
 
-static const int zero;
-static const int one = 1;
-
 static struct ctl_table abi_table2[] = {
 	{
 		.procname	= "vsyscall32",
@@ -75,8 +72,8 @@ static struct ctl_table abi_table2[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (int *)&zero,
-		.extra2		= (int *)&one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{}
 };
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index d177940aa090..12dc30924bf4 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -69,8 +69,6 @@ static int sched_itmt_update_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static unsigned int zero;
-static unsigned int one = 1;
 static struct ctl_table itmt_kern_table[] = {
 	{
 		.procname	= "sched_itmt_enabled",
@@ -78,8 +76,8 @@ static struct ctl_table itmt_kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_itmt_update_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{}
 };
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 776dd69cf5be..58d4a1263480 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -16,9 +16,6 @@
  * firmware fallback configuration table
  */
 
-static unsigned int zero;
-static unsigned int one = 1;
-
 struct firmware_fallback_config fw_fallback_config = {
 	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
 	.loading_timeout = 60,
@@ -33,8 +30,8 @@ struct ctl_table firmware_config_table[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "ignore_sysfs_fallback",
@@ -42,8 +39,8 @@ struct ctl_table firmware_config_table[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 9ebf99f3d8d3..a87d896c6686 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -271,8 +271,6 @@
 #define POLL_PERIOD (NSEC_PER_SEC / POLL_FREQUENCY)
 
 /* for sysctl proc_dointvec_minmax of dev.i915.perf_stream_paranoid */
-static int zero;
-static int one = 1;
 static u32 i915_perf_stream_paranoid = true;
 
 /* The maximum exponent the hardware accepts is 63 (essentially it selects one
@@ -3345,8 +3343,8 @@ static struct ctl_table oa_table[] = {
 	 .maxlen = sizeof(i915_perf_stream_paranoid),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = &zero,
-	 .extra2 = &one,
+	 .extra1 = SYSCTL_ZERO,
+	 .extra2 = SYSCTL_ONE,
 	 },
 	{
 	 .procname = "oa_max_sample_rate",
@@ -3354,7 +3352,7 @@ static struct ctl_table oa_table[] = {
 	 .maxlen = sizeof(i915_oa_max_sample_rate),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = &zero,
+	 .extra1 = SYSCTL_ZERO,
 	 .extra2 = &oa_sample_rate_hard_limit,
 	 },
 	{}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 000b53e5a17a..61443b62b40f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1190,8 +1190,6 @@ static struct kmsg_dumper hv_kmsg_dumper = {
 };
 
 static struct ctl_table_header *hv_ctl_table_hdr;
-static int zero;
-static int one = 1;
 
 /*
  * sysctl option to allow the user to control whether kmsg data should be
@@ -1204,8 +1202,8 @@ static struct ctl_table hv_ctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
 	},
 	{}
 };
diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index e69b12a40636..24a540de979d 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -64,9 +64,6 @@ static struct notifier_block call_home_panic_nb = {
 	.priority = INT_MAX,
 };
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table callhome_table[] = {
 	{
 		.procname	= "callhome",
@@ -74,8 +71,8 @@ static struct ctl_table callhome_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{}
 };
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index e38f104db174..c882b05241b3 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -855,8 +855,6 @@ void tty_ldisc_deinit(struct tty_struct *tty)
 	tty->ldisc = NULL;
 }
 
-static int zero;
-static int one = 1;
 static struct ctl_table tty_table[] = {
 	{
 		.procname	= "ldisc_autoload",
@@ -864,8 +862,8 @@ static struct ctl_table tty_table[] = {
 		.maxlen		= sizeof(tty_ldisc_autoload),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index d37dd5bb7a8f..37a36c6b9f93 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -77,9 +77,6 @@ static int xen_hotplug_unpopulated;
 
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table balloon_table[] = {
 	{
 		.procname	= "hotplug_unpopulated",
@@ -87,8 +84,8 @@ static struct ctl_table balloon_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &zero,
-		.extra2         = &one,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a0e98d87fcc..772e831882f5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -296,7 +296,6 @@ static LIST_HEAD(tfile_check_list);
 
 #include <linux/sysctl.h>
 
-static long zero;
 static long long_max = LONG_MAX;
 
 struct ctl_table epoll_table[] = {
@@ -306,7 +305,7 @@ struct ctl_table epoll_table[] = {
 		.maxlen		= sizeof(max_user_watches),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &long_max,
 	},
 	{ }
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 7b53598c8804..d082b2584bf7 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -54,8 +54,6 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 #include <linux/sysctl.h>
 
-static int zero;
-
 struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
@@ -63,7 +61,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "max_user_watches",
@@ -71,7 +69,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "max_queued_events",
@@ -79,7 +77,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero
+		.extra1		= SYSCTL_ZERO
 	},
 	{ }
 };
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7325baa8f9d4..9526cb73ce3c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -21,6 +21,10 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
+/* shared constants to be used in various sysctls */
+const int sysctl_vals[] = { 0, 1, INT_MAX };
+EXPORT_SYMBOL(sysctl_vals);
+
 /* Support for permanently empty directories */
 
 struct ctl_table sysctl_mount_point[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecfcc3bd..deabe503deab 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,6 +37,13 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
+/* Keep the same order as in fs/proc/proc_sysctl.c */
+#define SYSCTL_ZERO	&sysctl_vals[0]
+#define SYSCTL_ONE	&sysctl_vals[1]
+#define SYSCTL_INT_MAX	&sysctl_vals[2]
+
+extern const int sysctl_vals[];
+
 typedef int proc_handler (struct ctl_table *ctl, int write,
 			  void __user *buffer, size_t *lenp, loff_t *ppos);
 
@@ -119,8 +126,8 @@ struct ctl_table
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
+	const void *extra1;
+	const void *extra2;
 } __randomize_layout;
 
 struct ctl_node {
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 49f9bf4ffc7f..fce2c396b4d0 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -117,9 +117,6 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 #define proc_ipc_sem_dointvec	   NULL
 #endif
 
-static int zero;
-static int one = 1;
-static int int_max = INT_MAX;
 static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
@@ -143,7 +140,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
 	},
 	{
@@ -152,8 +149,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "msgmax",
@@ -161,8 +158,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "msgmni",
@@ -170,7 +167,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
 	},
 	{
@@ -179,8 +176,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_auto_msgmni,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	=  "msgmnb",
@@ -188,8 +185,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sem",
@@ -205,8 +202,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "msg_next_id",
@@ -214,8 +211,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "shm_next_id",
@@ -223,8 +220,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
 	{}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index aa6e72fb7c08..1c13c2a70344 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -290,14 +290,13 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 }
 
 extern int pid_max;
-static int zero = 0;
 static struct ctl_table pid_ns_ctl_table[] = {
 	{
 		.procname = "ns_last_pid",
 		.maxlen = sizeof(int),
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
-		.extra1 = &zero,
+		.extra1 = SYSCTL_ZERO,
 		.extra2 = &pid_max,
 	},
 	{ }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9ec050bcf46..32c38a42033f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -123,9 +123,6 @@ static int sixty = 60;
 #endif
 
 static int __maybe_unused neg_one = -1;
-
-static int zero;
-static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
@@ -388,8 +385,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_schedstats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_SCHEDSTATS */
 #endif /* CONFIG_SMP */
@@ -421,7 +418,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "numa_balancing",
@@ -429,8 +426,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
@@ -462,8 +459,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -473,7 +470,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 #endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
@@ -483,8 +480,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_energy_aware_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_PROVE_LOCKING
@@ -549,7 +546,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
-		.extra2		= &one,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_LATENCYTOP
@@ -683,8 +680,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_MODULES
@@ -702,8 +699,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_UEVENT_HELPER
@@ -862,7 +859,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ten_thousand,
 	},
 	{
@@ -878,8 +875,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "kptr_restrict",
@@ -887,7 +884,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 #endif
@@ -912,8 +909,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "watchdog_thresh",
@@ -921,7 +918,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_thresh,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &sixty,
 	},
 	{
@@ -930,8 +927,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
 		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "watchdog_cpumask",
@@ -947,8 +944,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_soft_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "softlockup_panic",
@@ -956,8 +953,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -966,8 +963,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -978,8 +975,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -988,8 +985,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -1102,8 +1099,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "hung_task_check_count",
@@ -1111,7 +1108,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "hung_task_timeout_secs",
@@ -1188,7 +1185,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
 		.proc_handler	= perf_proc_update_handler,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "perf_cpu_time_max_percent",
@@ -1196,7 +1193,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1205,7 +1202,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &six_hundred_forty_kb,
 	},
 	{
@@ -1214,7 +1211,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_thousand,
 	},
 #endif
@@ -1224,8 +1221,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
@@ -1234,8 +1231,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= timer_migration_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_BPF_SYSCALL
@@ -1246,8 +1243,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "bpf_stats_enabled",
@@ -1255,8 +1252,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_bpf_stats_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_stats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
@@ -1266,8 +1263,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
@@ -1277,8 +1274,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= stack_erasing_sysctl,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{ }
@@ -1291,7 +1288,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -1300,7 +1297,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_oom),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -1337,7 +1334,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "dirty_background_ratio",
@@ -1345,7 +1342,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_background_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_background_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1362,7 +1359,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_dirty_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1386,7 +1383,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "dirtytime_expire_seconds",
@@ -1394,7 +1391,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirtytime_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= dirtytime_interval_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "swappiness",
@@ -1402,7 +1399,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_swappiness),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1427,8 +1424,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen			= sizeof(int),
 		.mode			= 0644,
 		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1			= &zero,
-		.extra2			= &one,
+		.extra1			= SYSCTL_ZERO,
+		.extra2			= SYSCTL_ONE,
 	},
 #endif
 	 {
@@ -1459,7 +1456,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &four,
 	},
 #ifdef CONFIG_COMPACTION
@@ -1485,8 +1482,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 
 #endif /* CONFIG_COMPACTION */
@@ -1496,7 +1493,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(min_free_kbytes),
 		.mode		= 0644,
 		.proc_handler	= min_free_kbytes_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "watermark_boost_factor",
@@ -1504,7 +1501,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_boost_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_boost_factor_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "watermark_scale_factor",
@@ -1512,7 +1509,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_scale_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &one_thousand,
 	},
 	{
@@ -1521,7 +1518,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(percpu_pagelist_fraction),
 		.mode		= 0644,
 		.proc_handler	= percpu_pagelist_fraction_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #ifdef CONFIG_MMU
 	{
@@ -1530,7 +1527,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_max_map_count),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #else
 	{
@@ -1539,7 +1536,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_nr_trim_pages),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #endif
 	{
@@ -1555,7 +1552,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(block_dump),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "vfs_cache_pressure",
@@ -1563,7 +1560,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 	{
@@ -1572,7 +1569,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_legacy_va_layout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #endif
 #ifdef CONFIG_NUMA
@@ -1582,7 +1579,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(node_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "min_unmapped_ratio",
@@ -1590,7 +1587,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1599,7 +1596,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_slab_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_hundred,
 	},
 #endif
@@ -1650,7 +1647,7 @@ static struct ctl_table vm_table[] = {
 #endif
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #endif
 #ifdef CONFIG_HIGHMEM
@@ -1660,8 +1657,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_highmem_is_dirtyable),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 #ifdef CONFIG_MEMORY_FAILURE
@@ -1671,8 +1668,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "memory_failure_recovery",
@@ -1680,8 +1677,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_recovery),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{
@@ -1853,8 +1850,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "protected_hardlinks",
@@ -1862,8 +1859,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "protected_fifos",
@@ -1871,7 +1868,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -1880,7 +1877,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -1889,7 +1886,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_coredump,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
@@ -1926,7 +1923,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 	{ }
 };
@@ -1948,8 +1945,8 @@ static struct ctl_table debug_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_kprobes_optimization_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{ }
diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..c56a44539ca6 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -57,16 +57,14 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static int zero = 0;
-static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
 	{						\
 		.procname	= name,			\
 		.maxlen		= sizeof(int),		\
 		.mode		= 0644,			\
 		.proc_handler	= proc_dointvec_minmax,	\
-		.extra1		= &zero,		\
-		.extra2		= &int_max,		\
+		.extra1		= SYSCTL_ZERO,		\
+		.extra2		= SYSCTL_INT_MAX,	\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 30f6fd8f68e0..d345f084064e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3352,8 +3352,6 @@ void neigh_app_ns(struct neighbour *n)
 EXPORT_SYMBOL(neigh_app_ns);
 
 #ifdef CONFIG_SYSCTL
-static int zero;
-static int int_max = INT_MAX;
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 
 static int proc_unres_qlen(struct ctl_table *ctl, int write,
@@ -3362,7 +3360,7 @@ static int proc_unres_qlen(struct ctl_table *ctl, int write,
 	int size, ret;
 	struct ctl_table tmp = *ctl;
 
-	tmp.extra1 = &zero;
+	tmp.extra1 = SYSCTL_ZERO;
 	tmp.extra2 = &unres_qlen_max;
 	tmp.data = &size;
 
@@ -3427,8 +3425,8 @@ static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
 	struct ctl_table tmp = *ctl;
 	int ret;
 
-	tmp.extra1 = &zero;
-	tmp.extra2 = &int_max;
+	tmp.extra1 = SYSCTL_ZERO;
+	tmp.extra2 = SYSCTL_INT_MAX;
 
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	neigh_proc_update(ctl, write);
@@ -3573,24 +3571,24 @@ static struct neigh_sysctl_table {
 			.procname	= "gc_thresh1",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH2] = {
 			.procname	= "gc_thresh2",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH3] = {
 			.procname	= "gc_thresh3",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		{},
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 84bf2861f45f..21a65146b339 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -22,8 +22,6 @@
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
 
-static int zero = 0;
-static int one = 1;
 static int two __maybe_unused = 2;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
@@ -390,10 +388,10 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 # else
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 # endif
 	},
@@ -404,7 +402,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -413,8 +411,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 # endif
 	{
@@ -461,8 +459,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
 	},
 #ifdef CONFIG_RPS
 	{
@@ -493,7 +491,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "busy_read",
@@ -501,7 +499,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #endif
 #ifdef CONFIG_NET_SCHED
@@ -533,7 +531,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &max_skb_frags,
 	},
 	{
@@ -542,7 +540,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
@@ -550,8 +548,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "devconf_inherit_init_net",
@@ -559,7 +557,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{ }
@@ -571,7 +569,7 @@ static struct ctl_table netns_core_table[] = {
 		.data		= &init_net.core.sysctl_somaxconn,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.proc_handler	= proc_dointvec_minmax
 	},
 	{ }
diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index 53731e45403c..4d6147934179 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -19,9 +19,7 @@
 #endif
 
 /* Boundary values */
-static int		zero     = 0,
-			one      = 1,
-			u8_max   = 0xFF;
+static int		u8_max   = 0xFF;
 static unsigned long	seqw_min = DCCPF_SEQ_WMIN,
 			seqw_max = 0xFFFFFFFF;		/* maximum on 32 bit */
 
@@ -41,7 +39,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_rx_ccid),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &u8_max,		/* RFC 4340, 10. */
 	},
 	{
@@ -50,7 +48,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_tx_ccid),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &u8_max,		/* RFC 4340, 10. */
 	},
 	{
@@ -59,7 +57,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_request_retries),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &u8_max,
 	},
 	{
@@ -68,7 +66,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_retries1),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &u8_max,
 	},
 	{
@@ -77,7 +75,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_retries2),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &u8_max,
 	},
 	{
@@ -86,7 +84,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_tx_qlen),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "sync_ratelimit",
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index eeb4041fa5f9..18c1cb102b91 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -28,8 +28,6 @@
 #include <net/protocol.h>
 #include <net/netevent.h>
 
-static int zero;
-static int one = 1;
 static int two = 2;
 static int four = 4;
 static int thousand = 1000;
@@ -533,7 +531,7 @@ static struct ctl_table ipv4_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "icmp_msgs_burst",
@@ -541,7 +539,7 @@ static struct ctl_table ipv4_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "udp_mem",
@@ -610,8 +608,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{
@@ -699,8 +697,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = ipv4_fwd_update_priority,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "ip_nonlocal_bind",
@@ -730,8 +728,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{
@@ -791,7 +789,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= SYSCTL_ONE
 	},
 #endif
 	{
@@ -896,7 +894,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
 	{
@@ -933,7 +931,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_tfo_blackhole_detect_timeout,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 	},
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	{
@@ -942,8 +940,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "fib_multipath_hash_policy",
@@ -951,8 +949,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_policy,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{
@@ -969,8 +967,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{
@@ -1000,7 +998,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &four,
 	},
 	{
@@ -1144,7 +1142,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &gso_max_segs,
 	},
 	{
@@ -1153,7 +1151,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &one_day_secs
 	},
 	{
@@ -1162,8 +1160,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "tcp_invalid_ratelimit",
@@ -1178,7 +1176,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &thousand,
 	},
 	{
@@ -1187,7 +1185,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &thousand,
 	},
 	{
@@ -1196,7 +1194,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_wmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "tcp_rmem",
@@ -1204,7 +1202,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "tcp_comp_sack_delay_ns",
@@ -1219,7 +1217,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &comp_sack_nr_max,
 	},
 	{
@@ -1228,7 +1226,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_rmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= SYSCTL_ONE
 	},
 	{
 		.procname	= "udp_wmem_min",
@@ -1236,7 +1234,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_wmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= SYSCTL_ONE
 	},
 	{ }
 };
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4ae17a966ae3..685f5f4ff31f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6417,8 +6417,6 @@ int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
 }
 
 static int minus_one = -1;
-static const int zero = 0;
-static const int one = 1;
 static const int two_five_five = 255;
 
 static const struct ctl_table addrconf_sysctl[] = {
@@ -6435,7 +6433,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&two_five_five,
 	},
 	{
@@ -6794,7 +6792,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&zero,
+		.extra1		= (void *)SYSCTL_ZERO,
 		.extra2		= (void *)&two_five_five,
 	},
 	{
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7178e32eb15d..f92ab3439dc5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5147,9 +5147,6 @@ int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 	return 0;
 }
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table ipv6_route_table_template[] = {
 	{
 		.procname	=	"flush",
@@ -5227,8 +5224,8 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
 		.proc_handler	=	proc_dointvec,
-		.extra1		=	&zero,
-		.extra2		=	&one,
+		.extra1		=	SYSCTL_ZERO,
+		.extra2		=	SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index e15cd37024fd..4c6adfccc3d2 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -21,8 +21,6 @@
 #include <net/calipso.h>
 #endif
 
-static int zero;
-static int one = 1;
 static int auto_flowlabels_min;
 static int auto_flowlabels_max = IP6_AUTO_FLOW_LABEL_MAX;
 
@@ -149,8 +147,8 @@ static struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_rt6_multipath_hash_policy,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "seg6_flowlabel",
@@ -176,7 +174,7 @@ static struct ctl_table ipv6_rotable[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= SYSCTL_ONE
 	},
 #ifdef CONFIG_NETLABEL
 	{
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index f7c544592ec8..13f9fa1dc80e 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -36,8 +36,6 @@
 
 #define MPLS_NEIGH_TABLE_UNSPEC (NEIGH_LINK_TABLE + 1)
 
-static int zero = 0;
-static int one = 1;
 static int label_limit = (1 << 20) - 1;
 static int ttl_max = 255;
 
@@ -2604,7 +2602,7 @@ static int mpls_platform_labels(struct ctl_table *table, int write,
 		.data		= &platform_labels,
 		.maxlen		= sizeof(int),
 		.mode		= table->mode,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &label_limit,
 	};
 
@@ -2633,8 +2631,8 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "default_ttl",
@@ -2642,7 +2640,7 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &ttl_max,
 	},
 	{ }
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 053cd96b9c76..87cf0d0ce54f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1655,7 +1655,6 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 
 #ifdef CONFIG_SYSCTL
 
-static int zero;
 static int three = 3;
 
 static int
@@ -1864,7 +1863,7 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &three,
 	},
 	{
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index d75bd15151e6..fa765799c6f8 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -15,7 +15,6 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int one = 1;
 static const unsigned int four = 4;
 static const unsigned int thirtytwo = 32;
 static const unsigned int n_65535 = 65535;
@@ -101,7 +100,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&rxrpc_max_client_connections,
 	},
 	{
@@ -119,7 +118,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&n_max_acks,
 	},
 	{
@@ -128,7 +127,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&n_65535,
 	},
 	{
@@ -137,7 +136,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&four,
 	},
 
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 33ca5b73cdb3..ec452407bed1 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -40,10 +40,7 @@
 #include <net/sctp/sctp.h>
 #include <linux/sysctl.h>
 
-static int zero = 0;
-static int one = 1;
 static int timer_max = 86400000; /* ms in one day */
-static int int_max = INT_MAX;
 static int sack_timer_min = 1;
 static int sack_timer_max = 500;
 static int addr_scope_max = SCTP_SCOPE_POLICY_MAX;
@@ -107,7 +104,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = &timer_max
 	},
 	{
@@ -116,7 +113,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_rto_min,
-		.extra1         = &one,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = &init_net.sctp.rto_max
 	},
 	{
@@ -152,8 +149,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "cookie_preserve_enable",
@@ -175,7 +172,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = &timer_max
 	},
 	{
@@ -193,7 +190,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = &timer_max
 	},
 	{
@@ -202,8 +199,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "path_max_retrans",
@@ -211,8 +208,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "max_init_retransmits",
@@ -220,8 +217,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "pf_retrans",
@@ -229,8 +226,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sndbuf_policy",
@@ -301,7 +298,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &addr_scope_max,
 	},
 	{
@@ -310,7 +307,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &rwnd_scale_max,
 	},
 	{
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 5d261353bd90..e22155fcfb71 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -80,7 +80,6 @@ static unsigned int min_slot_table_size = RPCRDMA_MIN_SLOT_TABLE;
 static unsigned int max_slot_table_size = RPCRDMA_MAX_SLOT_TABLE;
 static unsigned int min_inline_size = RPCRDMA_MIN_INLINE;
 static unsigned int max_inline_size = RPCRDMA_MAX_INLINE;
-static unsigned int zero;
 static unsigned int max_padding = PAGE_SIZE;
 static unsigned int min_memreg = RPCRDMA_BOUNCEBUFFERS;
 static unsigned int max_memreg = RPCRDMA_LAST - 1;
@@ -122,7 +121,7 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= &max_padding,
 	},
 	{
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 9df82a573aa7..0cb92556fbb4 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -49,7 +49,7 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "named_timeout",
@@ -57,7 +57,7 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_named_timeout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &zero,
+		.extra1         = SYSCTL_ZERO,
 	},
 	{
 		.procname       = "sk_filter",
diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b68faa1a5cfd..1659dc3eac91 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -13,8 +13,6 @@
 #include <linux/sysctl.h>
 #include "internal.h"
 
-static const int zero, one = 1, max = INT_MAX;
-
 struct ctl_table key_sysctls[] = {
 	{
 		.procname = "maxkeys",
@@ -22,8 +20,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ONE,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 	{
 		.procname = "maxbytes",
@@ -31,8 +29,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ONE,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 	{
 		.procname = "root_maxkeys",
@@ -40,8 +38,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ONE,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 	{
 		.procname = "root_maxbytes",
@@ -49,8 +47,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ONE,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 	{
 		.procname = "gc_delay",
@@ -58,8 +56,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &zero,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ZERO,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	{
@@ -68,8 +66,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &zero,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) SYSCTL_ZERO,
+		.extra2 = (void *) SYSCTL_INT_MAX,
 	},
 #endif
 	{ }
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 055fb0a64169..11f804444cc4 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -49,8 +49,6 @@ static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 #ifdef CONFIG_SYSCTL
-static int zero;
-static int one = 1;
 
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
@@ -65,8 +63,8 @@ static struct ctl_table loadpin_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = &zero,
-		.extra2         = &one,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index efac68556b45..bf8871301020 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -449,7 +449,6 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
 }
 
-static int zero;
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 static struct ctl_path yama_sysctl_path[] = {
@@ -465,7 +464,7 @@ static struct ctl_table yama_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = yama_dointvec_minmax,
-		.extra1         = &zero,
+		.extra1         = SYSCTL_ZERO,
 		.extra2         = &max_scope,
 	},
 	{ }
-- 
2.21.0

