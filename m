Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2824427B29
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhJIPPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234290AbhJIPPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199CC2Ov022736;
        Sat, 9 Oct 2021 11:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wZMiLGZUzgEyouT+WJGGnMy3kyxoJ4X+fjWI2QClu/8=;
 b=KEwQzclcdEFCxe36Tu5haHseOMMjrWuMhOHkP2103CM0r0z+KPdpczO5n+8SBs41kgzk
 s+9qrJL+S7mxh85mhKPpBEevEovud+q6WZ6Zkio9tsiB3nEnMgROK84sn5uPiOXoY2s7
 mKgUo1epCOuU2mIomWZV7UNBazD/R35BW2kA76g9ftcum0KH7RKEWIcuGmBHrnuTAgno
 IJQzw87Nvzm+C7QzoqAACoV5j47XC+SB2mMmlBSGNP9NbQiRkDALahczd21X/SSXsSux
 rdjGVldyKfDSm7GW8hGNufsuNe/+Be4Zp3IR+BHiPdKaLK/4ikOIHGletX7mD/HrtF5i EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkavgj16m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:06 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199FD57I025604;
        Sat, 9 Oct 2021 11:13:05 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkavgj167-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCkkW004709;
        Sat, 9 Oct 2021 15:13:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3bk2q91xrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:13:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199FD1Ae55509256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:13:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F223F42041;
        Sat,  9 Oct 2021 15:13:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125034203F;
        Sat,  9 Oct 2021 15:12:56 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:12:55 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 2/5] ns: Add scrambling functionality to CPU namespace
Date:   Sat,  9 Oct 2021 20:42:40 +0530
Message-Id: <20211009151243.8825-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pm9PiDxxA9uaG63v--115A75QFdFtWFu
X-Proofpoint-GUID: 7d_Pd319ixsMmEMncpgmV3XDMxsDUBnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit adds functionality to map every host CPU to a virtualized CPU
in the namespace.

Every CPU namespace apart from the init namespace has its CPU map
scrambled. The CPUs are mapped in a flat hierarchy. This means that
regardless of the parent-child hierarchy of the namespace, each
translation will map directly from the virtual namespace CPU to
physical CPU without the need of traversal along the hierarchy.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 kernel/cpu_namespace.c | 49 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu_namespace.c b/kernel/cpu_namespace.c
index 6c700522352a..7b8b28f3d0e7 100644
--- a/kernel/cpu_namespace.c
+++ b/kernel/cpu_namespace.c
@@ -27,6 +27,33 @@ static void destroy_cpu_namespace(struct cpu_namespace *ns)
 	put_user_ns(ns->user_ns);
 }
 
+/*
+ * Shuffle
+ * Arrange the N elements of ARRAY in random order.
+ * Only effective if N is much smaller than RAND_MAX;
+ * if this may not be the case, use a better random
+ * number generator. -- Ben Pfaff.
+ */
+#define RAND_MAX	32767
+void shuffle(int *array, size_t n)
+{
+	unsigned int rnd_num;
+	int i, j, t;
+
+	if (n <= 1)
+		return;
+
+	for (i = 0; i < n-1; i++) {
+		get_random_bytes(&rnd_num, sizeof(rnd_num));
+		rnd_num = rnd_num % RAND_MAX;
+
+		j = i + rnd_num / (RAND_MAX / (n - i) + 1);
+		t = array[j];
+		array[j] = array[i];
+		array[i] = t;
+	}
+}
+
 static struct ucounts *inc_cpu_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_CPU_NAMESPACES);
@@ -37,8 +64,9 @@ static struct cpu_namespace *create_cpu_namespace(struct user_namespace *user_ns
 {
 	struct cpu_namespace *ns;
 	struct ucounts *ucounts;
-	int err, i, cpu;
+	int err, i, cpu, n = 0;
 	cpumask_t temp;
+	int *cpu_arr;
 
 	err = -EINVAL;
 	if (!in_userns(parent_cpu_ns->user_ns, user_ns))
@@ -62,10 +90,21 @@ static struct cpu_namespace *create_cpu_namespace(struct user_namespace *user_ns
 	ns->parent = get_cpu_ns(parent_cpu_ns);
 	ns->user_ns = get_user_ns(user_ns);
 
-	for_each_present_cpu(cpu) {
-		ns->p_v_trans_map[cpu] = ns->parent->p_v_trans_map[cpu];
-		ns->v_p_trans_map[cpu] = ns->parent->v_p_trans_map[cpu];
+	cpu_arr = kmalloc_array(num_possible_cpus(), sizeof(int), GFP_KERNEL);
+	if (!cpu_arr)
+		goto out_free_ns;
+
+	for_each_possible_cpu(cpu) {
+		cpu_arr[n++] = cpu;
+	}
+
+	shuffle(cpu_arr, n);
+
+	for (i = 0; i < n; i++) {
+		ns->p_v_trans_map[i] = cpu_arr[i];
+		ns->v_p_trans_map[cpu_arr[i]] = i;
 	}
+
 	cpumask_clear(&temp);
 	cpumask_clear(&ns->v_cpuset_cpus);
 
@@ -80,6 +119,8 @@ static struct cpu_namespace *create_cpu_namespace(struct user_namespace *user_ns
 
 	set_cpus_allowed_ptr(current, &temp);
 
+	kfree(cpu_arr);
+
 	return ns;
 
 out_free_ns:
-- 
2.31.1

