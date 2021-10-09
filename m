Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642BF427B31
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhJIPP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234619AbhJIPPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199AfUWW005018;
        Sat, 9 Oct 2021 11:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H8oRUsAit0rbQ+tvsmlBm/55SJ3NXZybEbA2lrRQqhU=;
 b=pb7/HlUaF/JN7XGr75/+++4CjYbe3MJeWEoGzVfTzPzo3PNuUgkART0iGDnw9A+MBcQu
 kyOoFASIZxKOKT8+xGE3DAZfHWbfZ6GNErJsW9l4fZLbJJh9oqe8CHYl5krLnMuhjmuV
 nlaS+p5LDcFmx51dsoeRcRa9wRShJy0sTYvxvmstc/mbYwjnbnhtUhGm2vjQqi87QSiR
 e8dJEV97wAQ43my2/t9Kw3gBEtCG3eeQO713kICmlhxFvIQKE2UAgZ6DZGl2KOlBOC3Z
 uBcXbX6NKNSvqysLOfoR9/I3OkgVLFT53bmcO89OyCgq3dIcHfPGO/RIvPxuWVkPxYi9 +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bk9j433bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:17 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199FABmu028995;
        Sat, 9 Oct 2021 11:13:17 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bk9j433b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCU23032346;
        Sat, 9 Oct 2021 15:13:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3bk2bhj9fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:13:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199FDBvo983654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:13:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBAF34203F;
        Sat,  9 Oct 2021 15:13:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C96ED42042;
        Sat,  9 Oct 2021 15:13:06 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:13:06 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 4/5] cpu/cpuns: Make sysfs CPU namespace aware
Date:   Sat,  9 Oct 2021 20:42:42 +0530
Message-Id: <20211009151243.8825-5-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvNsiQwer9Aj3u42IvPIGh1FzxHfBS04
X-Proofpoint-ORIG-GUID: u6QKf1J9uBMUGIKpJ3Gxy9kgwujLaOJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit adds support to sysfs files like online, offline, present to
be CPU namespace context aware. It presents virtualized CPU information
which is coherent to the cgroup cpuset restrictions that are set upon
the tasks.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 drivers/base/cpu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 5ef14db97904..1487b23e5472 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/sched/isolation.h>
+#include <linux/cpu_namespace.h>
 
 #include "base.h"
 
@@ -203,6 +204,24 @@ struct cpu_attr {
 	const struct cpumask *const map;
 };
 
+#ifdef CONFIG_CPU_NS
+static ssize_t show_cpuns_cpus_attr(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct cpu_attr *ca = container_of(attr, struct cpu_attr, attr);
+
+	if (current->nsproxy->cpu_ns == &init_cpu_ns)
+		return cpumap_print_to_pagebuf(true, buf, ca->map);
+
+	return cpumap_print_to_pagebuf(true, buf,
+				       &current->nsproxy->cpu_ns->v_cpuset_cpus);
+}
+
+#define _CPU_CPUNS_ATTR(name, map) \
+	{ __ATTR(name, 0444, show_cpuns_cpus_attr, NULL), map }
+#endif
+
 static ssize_t show_cpus_attr(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -217,9 +236,14 @@ static ssize_t show_cpus_attr(struct device *dev,
 
 /* Keep in sync with cpu_subsys_attrs */
 static struct cpu_attr cpu_attrs[] = {
+#ifdef CONFIG_CPU_NS
+	_CPU_CPUNS_ATTR(online, &__cpu_online_mask),
+	_CPU_CPUNS_ATTR(present, &__cpu_present_mask),
+#else
 	_CPU_ATTR(online, &__cpu_online_mask),
-	_CPU_ATTR(possible, &__cpu_possible_mask),
 	_CPU_ATTR(present, &__cpu_present_mask),
+#endif
+	_CPU_ATTR(possible, &__cpu_possible_mask),
 };
 
 /*
@@ -244,7 +268,16 @@ static ssize_t print_cpus_offline(struct device *dev,
 	/* display offline cpus < nr_cpu_ids */
 	if (!alloc_cpumask_var(&offline, GFP_KERNEL))
 		return -ENOMEM;
+#ifdef CONFIG_CPU_NS
+	if (current->nsproxy->cpu_ns == &init_cpu_ns) {
+		cpumask_andnot(offline, cpu_possible_mask, cpu_online_mask);
+	} else {
+		cpumask_andnot(offline, cpu_possible_mask,
+			       &current->nsproxy->cpu_ns->v_cpuset_cpus);
+	}
+#else
 	cpumask_andnot(offline, cpu_possible_mask, cpu_online_mask);
+#endif
 	len += sysfs_emit_at(buf, len, "%*pbl", cpumask_pr_args(offline));
 	free_cpumask_var(offline);
 
-- 
2.31.1

