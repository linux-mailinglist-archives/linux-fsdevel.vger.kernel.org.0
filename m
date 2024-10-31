Return-Path: <linux-fsdevel+bounces-33328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596939B7599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 08:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0D1C21B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8481531D2;
	Thu, 31 Oct 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EYMqtLWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B01494CE;
	Thu, 31 Oct 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360791; cv=none; b=ZFGanXeAVlyWyOeTeNSw1YhPkeXTKIxeajrcfN2PVHEfGarStghCShxHlNQyXhAphCP4o6SB22YbT7YO4mO+gm8eS5EVI4qPzJpvVQrVVmToJd0eInefE9pCNg9px784AF/OWeP/JkGEEp9RiI5jyazww4v/3i4yH2SZeZkQHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360791; c=relaxed/simple;
	bh=JKc11Y/ePIV67BpUqe03La6lQoNdPNKgkDTdLM6TL6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMbUUorjMaYCH6kDL5yUSnb8NBbRehXiL6WS6x5ruLV+C+uQdoxsnpisRSL01e27t6bAgZVIA2zdbIq6N/Gs0Te02JKW5kCM8P5tZfuO5vFVqip/UCfyZP5E737i3GYhIoDYwLG46jdNoK+XUxZYSvvqootV7laTvdhV845TcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EYMqtLWX; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730360782; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WwNO7n6jnbJ4T0oonR+GBHNN3lnAN99Ng6tUZqHMNRg=;
	b=EYMqtLWXV9XPACw+3sScXDVgSOG/4Q5WaYViTs3L7aUnVU/4iWJACYLm0IbGM9610t5h1W49w17lPj9d60QncA6L73yfXtg92GDQgXj/LQljsIPQwI1dyrKc50fAkhUTbdsYRp9qa0V6WCHwFBRzx7oR4yBY8Y+WqOERHAYhE5g=
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WIHewyR_1730360780 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 15:46:20 +0800
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
Subject: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting managed interrupts
Date: Thu, 31 Oct 2024 15:46:17 +0800
Message-ID: <20241031074618.3585491-2-guanjun@linux.alibaba.com>
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

Commit c410abbbacb9 (genirq/affinity: Add is_managed to struct irq_affinity_desc)
introduced is_managed bit to struct irq_affinity_desc. Due to queue interrupts
treated as managed interrupts, in scenarios where a large number of
devices are present (using massive msix queue interrupts), an excessive number
of IRQ matrix bits (about num_online_cpus() * nvecs) are reserved during
interrupt allocation. This sequently leads to the situation where interrupts
for some devices cannot be properly allocated.

Support for limiting the number of managed interrupts on every node per allocation.

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 block/blk-mq-cpumap.c                         |  2 +-
 drivers/virtio/virtio_vdpa.c                  |  2 +-
 fs/fuse/virtio_fs.c                           |  2 +-
 include/linux/group_cpus.h                    |  2 +-
 kernel/irq/affinity.c                         | 11 ++--
 lib/group_cpus.c                              | 55 ++++++++++++++++++-
 7 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9b61097a6448..ac80f35d04c9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3238,6 +3238,15 @@
 			different yeeloong laptops.
 			Example: machtype=lemote-yeeloong-2f-7inch
 
+	managed_irqs_per_node=
+			[KNL,SMP] Support for limiting the number of managed
+			interrupts on every node to prevent the case that
+			interrupts cannot be properly allocated where a large
+			number of devices are present. The default number is 0,
+			that means no limit to the number of managed irqs.
+			Format: integer between 0 and num_possible_cpus() / num_possible_nodes()
+			Default: 0
+
 	maxcpus=	[SMP,EARLY] Maximum number of processors that an SMP kernel
 			will bring up during bootup.  maxcpus=n : n >= 0 limits
 			the kernel to bring up 'n' processors. Surely after
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd521..481c81318e00 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -20,7 +20,7 @@ void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 	const struct cpumask *masks;
 	unsigned int queue, cpu;
 
-	masks = group_cpus_evenly(qmap->nr_queues);
+	masks = group_cpus_evenly(qmap->nr_queues, true);
 	if (!masks) {
 		for_each_possible_cpu(cpu)
 			qmap->mq_map[cpu] = qmap->queue_offset;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7364bd53e38d..cd303ac64046 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -330,7 +330,7 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(this_vecs, true);
 
 		if (!result) {
 			kfree(masks);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f68527891929..41b3bcc03f9c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -881,7 +881,7 @@ static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *f
 	return;
 fallback:
 	/* Attempt to map evenly in groups over the CPUs */
-	masks = group_cpus_evenly(fs->num_request_queues);
+	masks = group_cpus_evenly(fs->num_request_queues, true);
 	/* If even this fails we default to all CPUs use queue zero */
 	if (!masks) {
 		for_each_possible_cpu(cpu)
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6..10a12b9a7ed4 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -9,6 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 
-struct cpumask *group_cpus_evenly(unsigned int numgrps);
+struct cpumask *group_cpus_evenly(unsigned int numgrps, bool is_managed);
 
 #endif
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 44a4eba80315..775ab8537ddc 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -64,6 +64,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
+	/* Mark the managed interrupts */
+	for (i = curvec; i < nvecs - affd->post_vectors; i++)
+		masks[i].is_managed = 1;
+
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
@@ -71,7 +75,8 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(this_vecs,
+				masks[curvec].is_managed);
 
 		if (!result) {
 			kfree(masks);
@@ -94,10 +99,6 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 	return masks;
 }
 
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..769a139491bc 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -11,6 +11,30 @@
 
 #ifdef CONFIG_SMP
 
+static unsigned int __read_mostly managed_irqs_per_node;
+static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_aligned_in_smp = {
+	[0 ... MAX_NUMNODES-1] = {CPU_BITS_ALL}
+};
+
+static int __init irq_managed_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtouint(str, 10, &managed_irqs_per_node);
+	if (ret < 0) {
+		pr_warn("managed_irqs_per_node= cannot parse, ignored\n");
+		return 0;
+	}
+
+	if (managed_irqs_per_node * num_possible_nodes() > num_possible_cpus()) {
+		managed_irqs_per_node = num_possible_cpus() / num_possible_nodes();
+		pr_warn("managed_irqs_per_node= cannot be larger than %u\n",
+			managed_irqs_per_node);
+	}
+	return 1;
+}
+__setup("managed_irqs_per_node=", irq_managed_setup);
+
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
@@ -246,6 +270,30 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	}
 }
 
+static void __group_prepare_affinity(struct cpumask *premask,
+				     cpumask_var_t *node_to_cpumask)
+{
+	nodemask_t nodemsk = NODE_MASK_NONE;
+	unsigned int ncpus, n;
+
+	get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
+
+	for_each_node_mask(n, nodemsk) {
+		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], premask);
+		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], node_to_cpumask[n]);
+
+		ncpus = cpumask_weight(&managed_irqs_cpumsk[n]);
+		if (ncpus < managed_irqs_per_node) {
+			/* Reset node n to current node cpumask */
+			cpumask_copy(&managed_irqs_cpumsk[n], node_to_cpumask[n]);
+			continue;
+		}
+
+		grp_spread_init_one(premask, &managed_irqs_cpumsk[n], managed_irqs_per_node);
+	}
+}
+
+
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
@@ -332,6 +380,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 /**
  * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
+ * @is_managed: if these groups managed by kernel
  *
  * Return: cpumask array if successful, NULL otherwise. And each element
  * includes CPUs assigned to this group
@@ -344,7 +393,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int numgrps, bool is_managed)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
@@ -382,6 +431,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	 */
 	cpumask_copy(npresmsk, data_race(cpu_present_mask));
 
+	/* Limit the count of managed interrupts on every node */
+	if (is_managed && managed_irqs_per_node)
+		__group_prepare_affinity(npresmsk, node_to_cpumask);
+
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
-- 
2.43.5


