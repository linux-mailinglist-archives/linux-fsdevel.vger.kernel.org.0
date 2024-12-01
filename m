Return-Path: <linux-fsdevel+bounces-36208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0C9DF644
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4851B1631E5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919D1D14E2;
	Sun,  1 Dec 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQ+doSH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15F1632FB;
	Sun,  1 Dec 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067554; cv=fail; b=rNch/dAn45fQZASKPLlXHQTNatgi9JCEiMCNhP5ksWMF+8rfAJ/QvZTfxg1C6LVT72Nv0T0IAeAyMY/GvgskUsWSWjagM2WaoyVDO3N2U0bxq783eTOLtgTO066KrYD+IRMC43AZMxYVVcjjY86Ylob4zdpt86WFN3j3pwhoio8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067554; c=relaxed/simple;
	bh=hZy3TTWshPAxImvze0gZD3WMP0vDm2FY/LGwd0ZCsdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVE/UH8NIS/b0VaLfjFZv4q+OnvkpptRp5K5aVShCi2z5HNweqKoWxbzoRKpkDxFIWVAFZ6xFG2aEbeH6RQm6E228b0JNVDr9BmuCoxtufwaR6SnAuIGj3TxF6QWSzsZoY7JZxcpMdMLAt6NVjC01dCowH2tHZW0U7CFGTOmiAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQ+doSH8; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb5u9F5hK/odT+SAs6kUNC1rDMGYSVBJtXm9Zwtxma3v1WuoAq4QsPfn+p+XZnteauxk3okHDM6NrVvQP3g0pEfzbu/mJLAdVGJ5lFVy0m1TIW+GNpqeuRSfeG6JKbtfcBSnLgPAnI0K7xUOg5pxArqWjvIzS/5UiS4ruQVEo3wSvmwBhFsMFKNMqtKiAEDBl4kzkU0aH2+fnvIzAk8SdkbEaIuDFzDiAKw5lKQsHsS1IUPwCc5SOtoQ3OzKjDpzw0vjEMA0aP7irmAtQGayXEJt8nNEPth+UDz2eCirBsaPNqFoxkZCpYflYByhvmF6qm+SYjVOd/xS5zIxbsO2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THqpOYzVxsi2M9Jxr93ZEPARXIH0jqWyq/8EdCQRhh4=;
 b=tgvggDPG7uUQaZBA64PfPyYFzUMI0hhuuEFZk7Fcyo04dQK4FPdo/vTuwo3GqiXlRGvXkR7aqayoROHdwGDaTseXqnBqWJONB37s5D43UcnOCklqCp+0GGc9EDEhCe7ye7h9OSHN/eH/9kdtRu4Wl6IzSLjYLFvPRmMQohexY92l93gU6ZSeuiXVgHyCrq4Y/TtBdPTJGsT+Fo7SvlYCPwjoDgHGJFmBvhPtNP4wyWc6yVzcTYXcxlBKlBZpTFJK9P8mTCkCaG++IreB33SwKKp47rKuV19sBPWtmzF9iADg7bXXrK4/UoqZYNnA6OdU0odDrW0oW69rBHYeNBOESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THqpOYzVxsi2M9Jxr93ZEPARXIH0jqWyq/8EdCQRhh4=;
 b=pQ+doSH864GJ+c/Ch66pVLvlp6uxuP4vahkZOt56OK8yzVEnUFUDIiYYSrV/nZuqJ/jNpCSDlQNHTrC18qnf7pQjRzObnjZl/xH/sBOThHf6DFMyp09p0LctaRLmBCpsbcOXzXu7tNxmhwNHgkNtHSgOS+xnWEIGCuJolONauVE=
Received: from SJ0PR03CA0203.namprd03.prod.outlook.com (2603:10b6:a03:2ef::28)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sun, 1 Dec
 2024 15:39:04 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cc) by SJ0PR03CA0203.outlook.office365.com
 (2603:10b6:a03:2ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Sun, 1 Dec 2024 15:39:03 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:38:56 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>, <linux-fsdevel@vger.kernel.org>
Subject: [RFC PATCH V0 02/10] mm: Maintain mm_struct list in the system
Date: Sun, 1 Dec 2024 15:38:10 +0000
Message-ID: <20241201153818.2633616-3-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cc5bb9-b9b7-4986-fe6b-08dd121e48b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xxasN5tC1YEgwOqWe7D9mzO3hoMyzCCl7+OGOoIqirHPX/+SMVbHqjhRTSf?=
 =?us-ascii?Q?sTuds4iwOoNBiDOaAA+1nwyaCLXuBGehRfeYhleaeM8rXJQtPYm2G6ntplVo?=
 =?us-ascii?Q?8A35QWIC+nuf9KYRTekb29yor9cdQQnE4g08I8UNxQ1TASQiRabUTuchECm5?=
 =?us-ascii?Q?SbNy8zEjFd743pUomJcFOJGQgMxQwi4zf8FR3nRf8uEJmF24brSwsMe2dPkC?=
 =?us-ascii?Q?JEwUIusuB3+V8Xb20fTT1N1Rp+dbH1fYO6Eh7RwD6Mwgj5EwnoZyeRd8RFv5?=
 =?us-ascii?Q?fhUOekLcLjTB6KMzooeD/BRa71/8nBBmBtz3TCR6/7oE0+MCGO8yh+6oXS63?=
 =?us-ascii?Q?9BcVEtPJSScTVGWJWTBlO6/JXOoPSQ0dz/L1SZBQ/Vuk4ndiWkFJ2x9JLKtr?=
 =?us-ascii?Q?UqKKRMompfQpSXX1Ji1pagoB1gwbqNxJ6BxraZ9oe4pdSgVQxBVWTYZ+SsC8?=
 =?us-ascii?Q?rf6MA4V638/8l04//QVFEaBzs0fbWEC6Ufn+ds005dFKvrGM76+38dSicb9j?=
 =?us-ascii?Q?LWWy8hFpJa0s3fiqFT/+ljlJttFRoVQg+5ew+204ViYbD/TEolWcjgvAOhz5?=
 =?us-ascii?Q?QecOQrYqi5L6cCRhvudR9OvklHUjpyL12V6RoMNmGMb8kN5W/bGvVAS0j+sV?=
 =?us-ascii?Q?+fkbr/nfJn3l24NR3yxyspleymd8+PZP4tuP95ICXcs8bv/Xtd547gnU2roR?=
 =?us-ascii?Q?kSRsUdxuRfB6sdwCDUg3NkRG9ti3QPA+7ZYX93NVzswdg9HUUqYjZ89noQ5j?=
 =?us-ascii?Q?o4j65UTly11UMbyiiIpKzWkz41vzNQ2jAK2CHmQ+ZP43EitJUzKGLObphusp?=
 =?us-ascii?Q?CiDwBXHSd5sBG7NHxiZd6nmXk6GbRFkyREGvR7mFzBaWUM3zAT44tNka9Eou?=
 =?us-ascii?Q?naYYIBJvLQMXh+pXp9w67SFq1R02gJP6d8IcXtR12/JmvjYBkSJF4ZzUKWOx?=
 =?us-ascii?Q?YRzyZOh7wPOSWvojLbhPtC4rehlYrIaPvhrcUfBYLyLHHpgxr+dOdmCkg3vn?=
 =?us-ascii?Q?Pu6GkHbM56FegXgAuqmCrRwHFil5X07ELERSMqqUgR2QB9YYeB2/VgRYc0H7?=
 =?us-ascii?Q?g5tLzBnhY//YIoXh997aylcAh/7pYvNrE1ElQnW2gkTTFQQD6DJwkbdhijFe?=
 =?us-ascii?Q?ewmPDQfrwEBQI2EOJPLVh3nun741yLQ8IlAca7XqeGn77GtJ/j8OQ4Difgm6?=
 =?us-ascii?Q?YFozVb1JwyRKoJyonOZPzR6QeXGLAJZvn/XtIsoysxf4MfG4eRmw0Vwv1a0v?=
 =?us-ascii?Q?t1OQob5QuHR3HKPRynASg8BWiosWsAuLEC6vvGozuOIWMVHsUQrGGqnf1A1F?=
 =?us-ascii?Q?kQr4M4l4zvvadqR1F5hHNpfl7vb++MbjOzsenlOaBN5OIxRw0FPgCVV5WMIO?=
 =?us-ascii?Q?4eTahIK7wsUVoM/d3R2cJ877VGr1aejbc4rqH9PF/qIs03UdgJ7EIDkPkXko?=
 =?us-ascii?Q?HFzRtg74gyZixCNepykqk+vf+B+HfR0TlDFKMoJVhMOiFtLw1nf2Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:03.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cc5bb9-b9b7-4986-fe6b-08dd121e48b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

Add a hook in the fork and exec path to link mm_struct.
Reuse the mm_slot infrastructure to aid insert and lookup of mm_struct.

CC: linux-fsdevel@vger.kernel.org
Suggested-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 fs/exec.c                |  4 ++
 include/linux/kmmscand.h | 30 ++++++++++++++
 kernel/fork.c            |  4 ++
 mm/kmmscand.c            | 86 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kmmscand.h

diff --git a/fs/exec.c b/fs/exec.c
index 98cb7ba9983c..bd72107b2ab1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/kmmscand.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -274,6 +275,8 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	if (err)
 		goto err_ksm;
 
+	kmmscand_execve(mm);
+
 	/*
 	 * Place the stack at the largest stack address the architecture
 	 * supports. Later, we'll move this to an appropriate place. We don't
@@ -296,6 +299,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	return 0;
 err:
 	ksm_exit(mm);
+	kmmscand_exit(mm);
 err_ksm:
 	mmap_write_unlock(mm);
 err_free:
diff --git a/include/linux/kmmscand.h b/include/linux/kmmscand.h
new file mode 100644
index 000000000000..b120c65ee8c6
--- /dev/null
+++ b/include/linux/kmmscand.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KMMSCAND_H_
+#define _LINUX_KMMSCAND_H_
+
+#ifdef CONFIG_KMMSCAND
+extern void __kmmscand_enter(struct mm_struct *mm);
+extern void __kmmscand_exit(struct mm_struct *mm);
+
+static inline void kmmscand_execve(struct mm_struct *mm)
+{
+	__kmmscand_enter(mm);
+}
+
+static inline void kmmscand_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	__kmmscand_enter(mm);
+}
+
+static inline void kmmscand_exit(struct mm_struct *mm)
+{
+	__kmmscand_exit(mm);
+}
+#else /* !CONFIG_KMMSCAND */
+static inline void __kmmscand_enter(struct mm_struct *mm) {}
+static inline void __kmmscand_exit(struct mm_struct *mm) {}
+static inline void kmmscand_execve(struct mm_struct *mm) {}
+static inline void kmmscand_fork(struct mm_struct *mm, struct mm_struct *oldmm) {}
+static inline void kmmscand_exit(struct mm_struct *mm) {}
+#endif
+#endif /* _LINUX_KMMSCAND_H_ */
diff --git a/kernel/fork.c b/kernel/fork.c
index 1450b461d196..812b0032592e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -85,6 +85,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/oom.h>
 #include <linux/khugepaged.h>
+#include <linux/kmmscand.h>
 #include <linux/signalfd.h>
 #include <linux/uprobes.h>
 #include <linux/aio.h>
@@ -659,6 +660,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
+	kmmscand_fork(mm, oldmm);
+
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
@@ -1350,6 +1353,7 @@ static inline void __mmput(struct mm_struct *mm)
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
+	kmmscand_exit(mm);
 	exit_mmap(mm);
 	mm_put_huge_zero_folio(mm);
 	set_mm_exe_file(mm, NULL);
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 23cf5638fe10..957128d4e425 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -7,13 +7,14 @@
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
+#include <linux/kmmscand.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/cleanup.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
-
+#include "mm_slot.h"
 
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
@@ -30,10 +31,21 @@ static bool need_wakeup;
 
 static unsigned long kmmscand_sleep_expire;
 
+static DEFINE_SPINLOCK(kmmscand_mm_lock);
 static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
 
+#define KMMSCAND_SLOT_HASH_BITS 10
+static DEFINE_READ_MOSTLY_HASHTABLE(kmmscand_slots_hash, KMMSCAND_SLOT_HASH_BITS);
+
+static struct kmem_cache *kmmscand_slot_cache __read_mostly;
+
+struct kmmscand_mm_slot {
+	struct mm_slot slot;
+};
+
 struct kmmscand_scan {
 	struct list_head mm_head;
+	struct kmmscand_mm_slot *mm_slot;
 };
 
 struct kmmscand_scan kmmscand_scan = {
@@ -76,6 +88,11 @@ static void kmmscand_migrate_folio(void)
 {
 }
 
+static inline int kmmscand_test_exit(struct mm_struct *mm)
+{
+	return atomic_read(&mm->mm_users) == 0;
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
 	/* placeholder for scanning */
@@ -123,6 +140,65 @@ static int kmmscand(void *none)
 	return 0;
 }
 
+static inline void kmmscand_destroy(void)
+{
+	kmem_cache_destroy(kmmscand_slot_cache);
+}
+
+void __kmmscand_enter(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *kmmscand_slot;
+	struct mm_slot *slot;
+	int wakeup;
+
+	/* __kmmscand_exit() must not run from under us */
+	VM_BUG_ON_MM(kmmscand_test_exit(mm), mm);
+
+	kmmscand_slot = mm_slot_alloc(kmmscand_slot_cache);
+
+	if (!kmmscand_slot)
+		return;
+
+	slot = &kmmscand_slot->slot;
+
+	spin_lock(&kmmscand_mm_lock);
+	mm_slot_insert(kmmscand_slots_hash, mm, slot);
+
+	wakeup = list_empty(&kmmscand_scan.mm_head);
+	list_add_tail(&slot->mm_node, &kmmscand_scan.mm_head);
+	spin_unlock(&kmmscand_mm_lock);
+
+	mmgrab(mm);
+	if (wakeup)
+		wake_up_interruptible(&kmmscand_wait);
+}
+
+void __kmmscand_exit(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *mm_slot;
+	struct mm_slot *slot;
+	int free = 0;
+
+	spin_lock(&kmmscand_mm_lock);
+	slot = mm_slot_lookup(kmmscand_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+	if (mm_slot && kmmscand_scan.mm_slot != mm_slot) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		free = 1;
+	}
+
+	spin_unlock(&kmmscand_mm_lock);
+
+	if (free) {
+		mm_slot_free(kmmscand_slot_cache, mm_slot);
+		mmdrop(mm);
+	} else if (mm_slot) {
+		mmap_write_lock(mm);
+		mmap_write_unlock(mm);
+	}
+}
+
 static int start_kmmscand(void)
 {
 	int err = 0;
@@ -168,6 +244,13 @@ static int __init kmmscand_init(void)
 {
 	int err;
 
+	kmmscand_slot_cache = KMEM_CACHE(kmmscand_mm_slot, 0);
+
+	if (!kmmscand_slot_cache) {
+		pr_err("kmmscand: kmem_cache error");
+		return -ENOMEM;
+	}
+
 	err = start_kmmscand();
 	if (err)
 		goto err_kmmscand;
@@ -176,6 +259,7 @@ static int __init kmmscand_init(void)
 
 err_kmmscand:
 	stop_kmmscand();
+	kmmscand_destroy();
 
 	return err;
 }
-- 
2.39.3


