Return-Path: <linux-fsdevel+bounces-33330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDD9B75A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 08:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CF9282068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E416E886;
	Thu, 31 Oct 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p/9aLeKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F814D6E1;
	Thu, 31 Oct 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360794; cv=none; b=iBRo/Z5C4iWWx1wBsUObJHJj4A7OADRic2RI3JF55v8Vcnelo/fNn766jqADBYKcOESUL6DrBrAetRti416IXd5cozz4/bPRpUIvDCv8vGqzlubOG0yq6PAqs7Fa+WnfjHNWZDg1KT57D2ggMLeGkyQnmuYQrOmB8n0x7l/FJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360794; c=relaxed/simple;
	bh=33phXrmK8nmqMHKYFyD3A7lDPDZpmvZXuiUrbzomsjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYY62HABN7zDxMfKgvqrOVbAssxSsxChrux8PqPdZYJq2+4llW3JA0OTTv3X2jUshcJdP/skSSXEyQeGscd3MlGbKl97+gCKpcNdbCzpoK0gsa/ijDW1W9Aoi1Ue0BDfOy6fjGvygN7BKNjT3qUU1jIPIqTVuiHxyP2IxHl6hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p/9aLeKN; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730360783; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Yi5S3FvCJe7m8m05OvpuB+dWdFv2eUKXm00/bjW1XKs=;
	b=p/9aLeKNdV7LAhkpLU0Yi0xqx/6MIYfXioKHCjax2wPa3KwsB5tWyUcjtW9Xu7oHJtba19gKZmq4Fnhrrr2vsBWMbXK0Fc9sKt1PCvg/NWP+jgQYkrQb06dkPb/btpTeRmSt2OHeFVUv4c2Y84ZmSwlpVnLfXn5Fe0/S1+cw53Q=
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WIHewz0_1730360781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 15:46:22 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: corbet@lwn.net,
	axboe@kernel.dk,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu,
	tglx@linutronix.de,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	bp@alien8.de,
	xiongwei.song@windriver.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: guanjun@linux.alibaba.com
Subject: [PATCH RFC v1 2/2] genirq/cpuhotplug: Handle managed IRQs when the last CPU hotplug out in the affinity
Date: Thu, 31 Oct 2024 15:46:18 +0800
Message-ID: <20241031074618.3585491-3-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

Once we limit the number of managed interrupts, if the last online CPU in
the affinity goes offline, it will result in the interrupt becoming unavailable
util one of the assigned CPUs comes online again. So prevent the last online
CPU in the affinity from going offline, and return -EBUSY in this situation.

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 include/linux/irq.h                           |  2 +
 kernel/cpu.c                                  |  2 +-
 kernel/irq/cpuhotplug.c                       | 51 +++++++++++++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac80f35d04c9..173598cbf4a6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3244,6 +3244,9 @@
 			interrupts cannot be properly allocated where a large
 			number of devices are present. The default number is 0,
 			that means no limit to the number of managed irqs.
+			Once we limit the number of managed interrupts, the last
+			online CPU in the affinity goes offline will fail with
+			the error code -EBUSY.
 			Format: integer between 0 and num_possible_cpus() / num_possible_nodes()
 			Default: 0
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f80957b..68ce05a74079 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -615,8 +615,10 @@ extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_IRQ_MIGRATION)
 extern void irq_migrate_all_off_this_cpu(void);
 extern int irq_affinity_online_cpu(unsigned int cpu);
+extern int irq_affinity_offline_cpu(unsigned int cpu);
 #else
 # define irq_affinity_online_cpu	NULL
+# define irq_affinity_offline_cpu	NULL
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index c4aaf73dec9e..672d920970b2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2219,7 +2219,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_AP_IRQ_AFFINITY_ONLINE] = {
 		.name			= "irq/affinity:online",
 		.startup.single		= irq_affinity_online_cpu,
-		.teardown.single	= NULL,
+		.teardown.single	= irq_affinity_offline_cpu,
 	},
 	[CPUHP_AP_PERF_ONLINE] = {
 		.name			= "perf:online",
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 15a7654eff68..e6f068198e4a 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -232,6 +232,31 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 		irq_set_affinity_locked(data, affinity, false);
 }
 
+static int irq_check_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	const struct cpumask *affinity = irq_data_get_affinity_mask(data);
+	unsigned int cur;
+
+	if (!irqd_affinity_is_managed(data) || !desc->action ||
+	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
+		return 0;
+
+	for_each_cpu(cur, affinity)
+		if (cur != cpu && cpumask_test_cpu(cur, cpu_online_mask))
+			return 0;
+
+	/*
+	 * If the onging offline CPU is the last one in the affinity,
+	 * the managed interrupts will be unavailable until one of
+	 * the assigned CPUs comes online. To prevent this unavailability,
+	 * return -EBUSY directly in this case.
+	 */
+	pr_warn("Affinity %*pbl of managed IRQ%u contains only one CPU%u that online\n",
+		cpumask_pr_args(affinity), data->irq, cpu);
+	return -EBUSY;
+}
+
 /**
  * irq_affinity_online_cpu - Restore affinity for managed interrupts
  * @cpu:	Upcoming CPU for which interrupts should be restored
@@ -252,3 +277,29 @@ int irq_affinity_online_cpu(unsigned int cpu)
 
 	return 0;
 }
+
+/**
+ * irq_affinity_offline_cpu - Check affinity for managed interrupts
+ * to prevent the unavailability caused by taking the last CPU in the
+ * affinity offline.
+ * @cpu:	Upcoming CPU for which interrupts should be checked
+ */
+int irq_affinity_offline_cpu(unsigned int cpu)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+	int ret = 0;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		desc = irq_to_desc(irq);
+		raw_spin_lock_irq(&desc->lock);
+		ret = irq_check_affinity_of_irq(desc, cpu);
+		raw_spin_unlock_irq(&desc->lock);
+		if (ret < 0)
+			break;
+	}
+	irq_unlock_sparse();
+
+	return ret;
+}
-- 
2.43.5


