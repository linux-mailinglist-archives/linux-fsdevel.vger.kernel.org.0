Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73762135A97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbgAINvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:51:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:22710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbgAINvz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:51:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 05:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="272119356"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2020 05:51:52 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND v5] x86/resctrl: Add task resctrl information display
Date:   Thu,  9 Jan 2020 21:50:01 +0800
Message-Id: <20200109135001.10076-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Monitoring tools that want to find out which resctrl control
and monitor groups a task belongs to must currently read
the "tasks" file in every group until they locate the process
ID.

Add an additional file /proc/{pid}/resctrl to provide this
information.

The output is as followed according to Thomas's suggestion,
for example:

 1)   ""
      Resctrl is not available.

 2)   "/"
      Task is part of the root group, task is not associated to
      any monitoring group.

 3)   "/mon_groups/mon0"
      Task is part of the root group and monitoring group mon0.

 4)   "/group0"
      Task is part of control group group0, task is not associated
      to any monitoring group.

 5)   "/group0/mon_groups/mon1"
      Task is part of control group group0 and monitoring group mon1.

Tested-by: Jinshi Chen <jinshi.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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

v4: According to Thomas's suggestion, changed the output
    from multiple lines to one single line.

v5: According to Alexey's feedback, removed the header file
    proc_fs.h in resctrl.h, and changed seq_puts() to
    seq_putc() for simplicity.
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++++++++++++
 fs/proc/Kconfig                        |  4 ++
 fs/proc/base.c                         |  7 +++
 include/linux/resctrl.h                | 14 +++++
 5 files changed, 104 insertions(+)
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
index 2e3b06d6bbc6..f786e7626a65 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -725,6 +725,84 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+/*
+ * A task can only be part of one control
+ * group and of one monitoring group which
+ * is associated to that control group.
+ * So one line is simple and clear enough:
+ *
+ * 1)   ""
+ *    Resctrl is not available.
+ *
+ * 2)   "/"
+ *    Task is part of the root group, and it is
+ *    not associated to any monitoring group.
+ *
+ * 3)   "/mon_groups/mon0"
+ *    Task is part of the root group and monitoring
+ *    group mon0.
+ *
+ * 4)   "/group0"
+ *    Task is part of control group group0, and it is
+ *    not associated to any monitoring group.
+ *
+ * 5)   "/group0/mon_groups/mon1"
+ *    Task is part of control group group0 and monitoring
+ *    group mon1.
+ */
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
+		seq_printf(s, "/%s", rdtg->kn->name);
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (tsk->rmid != crg->mon.rmid)
+				continue;
+			seq_printf(s, "%smon_groups/%s",
+				   rdtg == &rdtgroup_default ? "" : "/",
+				   crg->kn->name);
+			break;
+		}
+		seq_putc(s, '\n');
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
index 000000000000..daf5cf64c6a6
--- /dev/null
+++ b/include/linux/resctrl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RESCTRL_H
+#define _RESCTRL_H
+
+#ifdef CONFIG_PROC_CPU_RESCTRL
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

