Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D926F1035CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKTIF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 03:05:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:59852 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKTIFz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:05:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="237639608"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2019 00:05:52 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v3] x86/resctrl: Add task resctrl information display
Date:   Wed, 20 Nov 2019 16:16:28 +0800
Message-Id: <20191120081628.26701-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Monitoring tools that want to find out which resctrl CTRL
and MONITOR groups a task belongs to must currently read
the "tasks" file in every group until they locate the process
ID.

Add an additional file /proc/{pid}/resctrl to provide this
information.

For example:
 cat /proc/1193/resctrl
CTRL_MON:/ctrl_grp0
MON:/ctrl_grp0/mon_groups/mon_grp0

If the resctrl filesystem has not been mounted,
reading /proc/{pid}/resctrl returns an empty string.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Reduce indentation level in proc_resctrl_show()
    according to Boris's suggestion.
    Create the include/linux/resctrl.h header and
    declare proc_resctrl_show() in this file, so
    that other architectures would probably use it
    in the future. Different architectures should
    implement architectural specific proc_resctrl_show()
    accordingly.

v3: Return empty string if the resctrl filesystem has
    not been mounted per Boris's suggestion.
    Rename the config from CPU_RESCTRL to PROC_CPU_RESCTRL
    to better represent its usage. Move PROC_CPU_RESCTRL
    from arch/Kconfig to fs/proc/Kconfig.
    And let PROC_CPU_RESCTRL to be depended on PROC_FS.
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
 fs/proc/Kconfig                        |  4 ++
 fs/proc/base.c                         |  7 ++++
 include/linux/resctrl.h                | 16 ++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 include/linux/resctrl.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8ef85139553f..252364d18887 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -455,6 +455,7 @@ config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
+	select PROC_CPU_RESCTRL		if PROC_FS
 	help
 	  Enable x86 CPU resource control support.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..657c21ffbdfa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -725,6 +725,58 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk)
+{
+	struct rdtgroup *rdtg;
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Return empty if resctrl has not been mounted. */
+	if (!static_branch_unlikely(&rdt_enable_key))
+		goto unlock;
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		/*
+		 * Task information is only relevant for shareable
+		 * and exclusive groups.
+		 */
+		if (rdtg->mode != RDT_MODE_SHAREABLE &&
+		    rdtg->mode != RDT_MODE_EXCLUSIVE)
+			continue;
+
+		if (rdtg->closid != tsk->closid)
+			continue;
+
+		seq_printf(s, "CTRL_MON:/%s\n", rdtg->kn->name);
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (tsk->rmid != crg->mon.rmid)
+				continue;
+			seq_printf(s, "MON:%s%s/mon_groups/%s\n",
+				   rdtg == &rdtgroup_default ? "" : "/",
+				   rdtg->kn->name, crg->kn->name);
+			goto unlock;
+		}
+		goto unlock;
+	}
+	/*
+	 * The above search should succeed. Otherwise return
+	 * with an error.
+	 */
+	ret = -ENOENT;
+unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+#endif
+
 static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 				    struct seq_file *seq, void *v)
 {
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index cb5629bd5fff..ae96a339d24d 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -103,3 +103,7 @@ config PROC_CHILDREN
 config PROC_PID_ARCH_STATUS
 	def_bool n
 	depends on PROC_FS
+
+config PROC_CPU_RESCTRL
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..0e4b8bf2b986 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/resctrl.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3060,6 +3061,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("resctrl", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score",  S_IRUGO, proc_oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
@@ -3460,6 +3464,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("resctrl", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score", S_IRUGO, proc_oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
new file mode 100644
index 000000000000..50b147784d55
--- /dev/null
+++ b/include/linux/resctrl.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RESCTRL_H
+#define _RESCTRL_H
+
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+#include <linux/proc_fs.h>
+
+int proc_resctrl_show(struct seq_file *m,
+		      struct pid_namespace *ns,
+		      struct pid *pid,
+		      struct task_struct *tsk);
+
+#endif
+
+#endif /* _RESCTRL_H */
-- 
2.17.1

