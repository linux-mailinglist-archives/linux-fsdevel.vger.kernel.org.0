Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8643427B2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhJIPP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234609AbhJIPPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1999Ccws020949;
        Sat, 9 Oct 2021 11:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qaKVf2iG3jJrJdTiPzN0ACJ6YGlKml1RY1+qmab/pd4=;
 b=aRTT0GYC6A4Rrx/GXzW1CpLNwxLZSD37TyFEKMyE63m57ioB3Eq7XPEBiYkOlAY3dIWV
 JL/FkNEhwfOC9ApafaVLAUKnPeUwbWupFndhQ7blr1/dENaZCFP0Zk768GUcedVxRpYX
 dTK/51ooNsf8P1u2Qrx7XOt3UaCATEmicaQW4awzjsbU5WoWsDAZYh3UwoHyNWFnoXNW
 jE8PvAb2ONsyycVQyiyt6e2DQOl6uqnsJEuNQwFFuOGGP2znlmeE3uKG1vUzj42uMQZs
 CXWoDPPr93PZiNNoWrE9sC8JiwlQHVBjljNIKh1RFqXxIQ1kmAE7pHrQXYth7UjEKhnV Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bk884c1f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:11 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199FDBbe026498;
        Sat, 9 Oct 2021 11:13:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bk884c1ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCgkB020870;
        Sat, 9 Oct 2021 15:13:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9a4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:13:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199FD6s038207782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:13:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3470142041;
        Sat,  9 Oct 2021 15:13:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79F3642042;
        Sat,  9 Oct 2021 15:13:01 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:13:01 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 3/5] cpuset/cpuns: Make cgroup CPUset CPU namespace aware
Date:   Sat,  9 Oct 2021 20:42:41 +0530
Message-Id: <20211009151243.8825-4-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gv42oO6GxrsSd85JyLdvic8EAmPwXLVy
X-Proofpoint-GUID: Za2OcdZR6J49PblbNW8XI7MUw-qFoZla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a new cgroup is created or a cpuset is updated, the mask supplied
to it looks for its corresponding CPU translations for the restrictions
to apply on.

The patch also updates the display interface such that tasks within the
namespace can view the corresponding virtual CPUset based on the
requested CPU namespace context.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 kernel/cgroup/cpuset.c | 57 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..eb1e950543cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -65,6 +65,7 @@
 #include <linux/mutex.h>
 #include <linux/cgroup.h>
 #include <linux/wait.h>
+#include <linux/cpu_namespace.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -1061,8 +1062,19 @@ static void update_tasks_cpumask(struct cpuset *cs)
 	struct task_struct *task;
 
 	css_task_iter_start(&cs->css, 0, &it);
-	while ((task = css_task_iter_next(&it)))
+	while ((task = css_task_iter_next(&it))) {
+#ifdef CONFIG_CPU_NS
+		cpumask_t pcpus;
+		cpumask_t vcpus;
+
+		pcpus = get_pcpus_cpuns(current->nsproxy->cpu_ns, cs->effective_cpus);
+		vcpus = get_vcpus_cpuns(task->nsproxy->cpu_ns, &pcpus);
+		cpumask_copy(&task->nsproxy->cpu_ns->v_cpuset_cpus, &vcpus);
+		set_cpus_allowed_ptr(task, &pcpus);
+#else
 		set_cpus_allowed_ptr(task, cs->effective_cpus);
+#endif
+	}
 	css_task_iter_end(&it);
 }
 
@@ -2212,8 +2224,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
 		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+#ifdef CONFIG_CPU_NS
+		cpumask_t pcpus;
+		cpumask_t vcpus;
 
+		pcpus = get_pcpus_cpuns(current->nsproxy->cpu_ns, cpus_attach);
+		vcpus = get_vcpus_cpuns(task->nsproxy->cpu_ns, &pcpus);
+		cpumask_copy(&task->nsproxy->cpu_ns->v_cpuset_cpus, &vcpus);
+
+		WARN_ON_ONCE(set_cpus_allowed_ptr(task, &pcpus));
+#else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+#endif
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
 	}
@@ -2436,13 +2458,33 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 
 	switch (type) {
 	case FILE_CPULIST:
+#ifdef CONFIG_CPU_NS
+		if (current->nsproxy->cpu_ns == &init_cpu_ns) {
+			seq_printf(sf, "%*pbl\n",
+				   cpumask_pr_args(cs->cpus_allowed));
+		} else {
+			seq_printf(sf, "%*pbl\n",
+				   cpumask_pr_args(&current->nsproxy->cpu_ns->v_cpuset_cpus));
+		}
+#else
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->cpus_allowed));
+#endif
 		break;
 	case FILE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->mems_allowed));
 		break;
 	case FILE_EFFECTIVE_CPULIST:
+#ifdef CONFIG_CPU_NS
+		if (current->nsproxy->cpu_ns == &init_cpu_ns) {
+			seq_printf(sf, "%*pbl\n",
+				   cpumask_pr_args(cs->effective_cpus));
+		} else {
+			seq_printf(sf, "%*pbl\n",
+				   cpumask_pr_args(&current->nsproxy->cpu_ns->v_cpuset_cpus));
+		}
+#else
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->effective_cpus));
+#endif
 		break;
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
@@ -2884,9 +2926,18 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
  */
 static void cpuset_fork(struct task_struct *task)
 {
+#ifdef CONFIG_CPU_NS
+	cpumask_t vcpus;
+#endif
+
 	if (task_css_is_root(task, cpuset_cgrp_id))
 		return;
-
+#ifdef CONFIG_CPU_NS
+	if (task->nsproxy->cpu_ns != &init_cpu_ns) {
+		vcpus = get_vcpus_cpuns(task->nsproxy->cpu_ns, current->cpus_ptr);
+		cpumask_copy(&task->nsproxy->cpu_ns->v_cpuset_cpus, &vcpus);
+	}
+#endif
 	set_cpus_allowed_ptr(task, current->cpus_ptr);
 	task->mems_allowed = current->mems_allowed;
 }
-- 
2.31.1

