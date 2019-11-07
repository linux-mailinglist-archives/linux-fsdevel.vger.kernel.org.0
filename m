Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B54F25E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 04:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKGDQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 22:16:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:33378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfKGDQn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:16:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 19:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="233106400"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 19:16:39 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] x86/resctrl: Add task resctrl information display
Date:   Thu,  7 Nov 2019 11:27:31 +0800
Message-Id: <20191107032731.7790-1-yu.c.chen@intel.com>
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
reading /proc/{pid}/resctrl returns an error:
cat: /proc/1193/resctrl: No such device

Tested-by: Jinshi Chen <jinshi.chen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>

---
 arch/x86/include/asm/resctrl_sched.h   |  4 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++++++
 fs/proc/base.c                         |  9 +++++
 3 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index f6b7fe2833cc..bba362e0e00f 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_X86_CPU_RESCTRL
 
 #include <linux/sched.h>
+#include <linux/proc_fs.h>
 #include <linux/jump_label.h>
 
 #define IA32_PQR_ASSOC	0x0c8f
@@ -84,6 +85,9 @@ static inline void resctrl_sched_in(void)
 		__resctrl_sched_in();
 }
 
+int proc_resctrl_show(struct seq_file *m, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk);
+
 #else
 
 static inline void resctrl_sched_in(void) {}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..2317174174e9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -727,6 +727,52 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk)
+{
+	struct rdtgroup *rdtg;
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Make sure resctrl has been mounted. */
+	if (!static_branch_unlikely(&rdt_enable_key)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
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
+		if (rdtg->closid == tsk->closid) {
+			seq_printf(s, "CTRL_MON:/%s\n", rdtg->kn->name);
+			list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+					    mon.crdtgrp_list) {
+				if (tsk->rmid != crg->mon.rmid)
+					continue;
+				seq_printf(s, "MON:%s%s/mon_groups/%s\n",
+					   rdtg == &rdtgroup_default ? "" : "/",
+					   rdtg->kn->name, crg->kn->name);
+				goto unlock;
+			}
+			goto unlock;
+		}
+	}
+	ret = -ENOENT;
+unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+
 static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 				    struct seq_file *seq, void *v)
 {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..d8a61db78db5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,6 +95,9 @@
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
+#ifdef CONFIG_X86_CPU_RESCTRL
+#include <asm/resctrl_sched.h>
+#endif
 #include "internal.h"
 #include "fd.h"
 
@@ -3060,6 +3063,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_X86_CPU_RESCTRL
+	ONE("resctrl", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score",  S_IRUGO, proc_oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
@@ -3460,6 +3466,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_X86_CPU_RESCTRL
+	ONE("resctrl", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score", S_IRUGO, proc_oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
-- 
2.17.1

