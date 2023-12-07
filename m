Return-Path: <linux-fsdevel+bounces-5073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89C807D52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7001F20FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9531868
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEdiuJrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D1137;
	Wed,  6 Dec 2023 16:28:12 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5d33574f64eso1035697b3.3;
        Wed, 06 Dec 2023 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908892; x=1702513692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9wIViZkBU87Y2XRyOX6ijFii9lZTEeqQT/4TV/pkeE=;
        b=HEdiuJrs90Xh8R9YEdM3A+7WJTBsnUyKolauuBM3/iGJxnOuguWm5xddce7xoRqwpZ
         jHZejWLKDPP+tr1ceFp/DsLP9A4Hstk0bLzD+Y6M+AGg7VhmBPKMPrmq0EhPELyKPXV8
         0rLJ47fqz7G+epOPG0P7RZL6czvHfoaZn/zBHFlI7bd82YiavqKvphpmBfjU2/O2IQKM
         UjEaT8AyY07A5o/ccbGRuEC2tLAo8O81st/ulovuzXgJo274wwspuNq0ceLEBQQs7c/T
         GXyawTrLBIVkH4biJRmEL/IBaoitc2eXivi0IAz6y26U/Jnyn3f4xzutFzGBSWKmUSo1
         7k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908892; x=1702513692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9wIViZkBU87Y2XRyOX6ijFii9lZTEeqQT/4TV/pkeE=;
        b=OFFEx6Il7qKDra5ZHZqo0fjKmd2djn7rJMndRCDp7KBe1ETBA/7Az0D6W0rTmza7gs
         0fTpROKzyU4//LUawvbQ+eA6SpfuGxVX49sepjzDsIkD2v+xibK7vRKeQ7VemY9qOetl
         SFtRsJsyXNvpp96hpxtJ/zkCNV/Q1BErAH9C9toaqA9oNFYrVN13auccd7ZjtJbCrAzU
         RBtxggIxZJpZxTpJxhqsYFAA+10PxUBjvq/l48P+drDwT5rHOSWBaOmiG87Vr0ReUh/0
         7LktWdhHcBwaXV8Ty65eDgm4uo83705mmx6R5MU8Qg1aeTfVWaCWMQFALdQOPEGXf0KE
         6lCg==
X-Gm-Message-State: AOJu0YzfabPjyOH15y31HpW8XIpuYDUWijGquZCpykpyO7Jez1NHXBL1
	HMeOyEABW5EMysdBj0z66Dtp7FfOlt4D
X-Google-Smtp-Source: AGHT+IFsypp4HiyFtXvyk2o+SL5aq0zamwJAkzXlggLGMQm5qgsPFIqsLXEuF5xWNcgX6pcVEg7qoA==
X-Received: by 2002:a05:690c:3612:b0:5d7:1940:b37f with SMTP id ft18-20020a05690c361200b005d71940b37fmr1838437ywb.75.1701908891675;
        Wed, 06 Dec 2023 16:28:11 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:11 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org
Subject: [RFC PATCH 01/11] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Wed,  6 Dec 2023 19:27:49 -0500
Message-Id: <20231207002759.51418-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231207002759.51418-1-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rakie Kim <rakie.kim@sk.com>

This patch provides a way to set interleave weight information under
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/node*/node*/weight

The sysfs structure is designed as follows.

  $ tree /sys/kernel/mm/mempolicy/
  /sys/kernel/mm/mempolicy/ [1]
  ├── cpu_nodes [2]
  ├── possible_nodes [3]
  └── weighted_interleave [4]
      ├── node0 [5]
      │   ├── node0 [6]
      │   │     └── weight [7]
      │   └── node1
      │         └── weight
      └── node1
          ├── node0
          │     └── weight
          └── node1
                └── weight

Each file above can be explained as follows.

[1] mm/mempolicy: configuration interface for mempolicy subsystem

[2] cpu_nodes: list of cpu nodes

    information interface which is used to describe which nodes
    may generate sub-folders under each policy interface. For example,
    the weighted_interleave policy generates a nodeN folder for each
    cpu node.

[3] possible_nodes: list of possible nodes

    informational interface which may be used across multiple memory
    policy configurations.  Lists the `possible` nodes for which
    configurations may be required.  A `possible` node is one which has
    been reserved by the kernel at boot, but may or may not be online.

    For example, the weighted_interleave policy generates a nodeN/nodeM
    folder for each cpu node and memory node combination [N,M].

[4] weighted_interleave/: config interface for weighted interleave policy

[5] weighted_interleave/nodeN/:  initiator node configurations

    Each CPU node receives its own weighting table, allowing for (src,dst)
    weighting to be accomplished, where src is the cpu node the task is
    running on, and dst is an index into the array of weights for that
    source node.

[6] weighted_interleave/nodeN/nodeM/:  memory node configurations

[7] weighted_interleave/nodeN/nodeM/weight: weight for [N,M]

    The weight table for nodeN which can be programmed to weight each
    target (nodeM) differently.  This is important for allowing re-weight
    to occur automatically on a task migration event, either via scheduler
    initiated migration or a cgroup.cpusets/mems_allowed policy change.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |  33 +++
 ...fs-kernel-mm-mempolicy-weighted-interleave |  35 +++
 mm/mempolicy.c                                | 226 ++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
new file mode 100644
index 000000000000..8dc1129d4ab1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
@@ -0,0 +1,33 @@
+What:		/sys/kernel/mm/mempolicy/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for Mempolicy
+
+What:		/sys/kernel/mm/mempolicy/cpu_nodes
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	The numa nodes from which accesses can be generated
+
+		A cpu numa node is one which has at least 1 CPU. These nodes
+		are capable of generating accesses to memory numa nodes, and
+		will have an interleave weight table.
+
+		Example output:
+
+		=====         =================================================
+		"0,1"         nodes 0 and 1 have CPUs which may generate access
+		=====         =================================================
+
+What:		/sys/kernel/mm/mempolicy/possible_nodes
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	The numa nodes which are possible to come online
+
+		A possible numa node is one which has been reserved by the
+		system at boot, but may or may not be online at runtime.
+
+		Example output:
+
+		=========     ========================================
+		"0,1,2,3"     nodes 0-3 are possibly online or offline
+		=========     ========================================
diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
new file mode 100644
index 000000000000..75554895ede3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,35 @@
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration Interface for the Weighted Interleave policy
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration interface for accesses initiated from nodeN
+
+		The directory to configure access initiator weights for nodeN.
+
+		Possible numa nodes which have not been marked as a CPU node
+		at boot will not have a nodeN directory made for them at boot.
+		Hotplug for CPU nodes is not supported.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM
+		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM/weight
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration interface for target nodes accessed from nodeNN
+
+		The interleave weight for a memory node (M) from initiating
+		node (N). These weights are utilized by processes which have set
+		the mempolicy to MPOL_WEIGHTED_INTERLEAVE and have opted into
+		global weights by omitting a task-local weight array.
+
+		These weights only affect new allocations, and changes at runtime
+		will not cause migrations on already allocated pages.
+
+		If the weight of 0 is desired, the appropriate way to do this is
+		by removing the node from the weighted interleave nodemask.
+
+		Minimum weight: 1
+		Maximum weight: 255
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..ce332b5e7a03 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,11 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+struct interleave_weight_table {
+	unsigned char weights[MAX_NUMNODES];
+};
+static struct interleave_weight_table *iw_table;
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3072,224 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+struct iw_node_info {
+	struct kobject kobj;
+	int src;
+	int dst;
+};
+
+static ssize_t node_weight_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct iw_node_info *node_info = container_of(kobj, struct iw_node_info,
+						      kobj);
+	return sysfs_emit(buf, "%d\n",
+			  iw_table[node_info->src].weights[node_info->dst]);
+}
+
+static ssize_t node_weight_store(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 const char *buf, size_t count)
+{
+	unsigned char weight = 0;
+	struct iw_node_info *node_info = NULL;
+
+	node_info = container_of(kobj, struct iw_node_info, kobj);
+
+	if (kstrtou8(buf, 0, &weight) || !weight)
+		return -EINVAL;
+
+	iw_table[node_info->src].weights[node_info->dst] = weight;
+
+	return count;
+}
+
+static struct kobj_attribute node_weight =
+	__ATTR(weight, 0664, node_weight_show, node_weight_store);
+
+static struct attribute *dst_node_attrs[] = {
+	&node_weight.attr,
+	NULL,
+};
+
+static struct attribute_group dst_node_attr_group = {
+	.attrs = dst_node_attrs,
+};
+
+static const struct attribute_group *dst_node_attr_groups[] = {
+	&dst_node_attr_group,
+	NULL,
+};
+
+static const struct kobj_type dst_node_kobj_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = dst_node_attr_groups,
+};
+
+static int add_dst_node(int src, int dst, struct kobject *src_kobj)
+{
+	struct iw_node_info *node_info = NULL;
+	int ret;
+
+	node_info = kzalloc(sizeof(struct iw_node_info), GFP_KERNEL);
+	if (!node_info)
+		return -ENOMEM;
+	node_info->src = src;
+	node_info->dst = dst;
+
+	kobject_init(&node_info->kobj, &dst_node_kobj_ktype);
+	ret = kobject_add(&node_info->kobj, src_kobj, "node%d", dst);
+	if (ret) {
+		pr_err("kobject_add error [%d-node%d]: %d", src, dst, ret);
+		kobject_put(&node_info->kobj);
+	}
+	return ret;
+}
+
+static int add_src_node(int src, struct kobject *root_kobj)
+{
+	int err, dst;
+	struct kobject *src_kobj;
+	char name[24];
+
+	snprintf(name, 24, "node%d", src);
+	src_kobj = kobject_create_and_add(name, root_kobj);
+	if (!src_kobj) {
+		pr_err("failed to create source node kobject\n");
+		return -ENOMEM;
+	}
+	for_each_node_state(dst, N_POSSIBLE) {
+		err = add_dst_node(src, dst, src_kobj);
+		if (err)
+			break;
+	}
+	if (err)
+		kobject_put(src_kobj);
+	return err;
+}
+
+static int add_weighted_interleave_group(struct kobject *root_kobj)
+{
+	struct kobject *wi_kobj;
+	int nid, err;
+
+	wi_kobj = kobject_create_and_add("weighted_interleave", root_kobj);
+	if (!wi_kobj) {
+		pr_err("failed to create node kobject\n");
+		return -ENOMEM;
+	}
+
+	for_each_node_state(nid, N_CPU) {
+		err = add_src_node(nid, wi_kobj);
+		if (err) {
+			pr_err("failed to add sysfs [node%d]\n", nid);
+			break;
+		}
+	}
+	if (err)
+		kobject_put(wi_kobj);
+	return 0;
+
+}
+
+static ssize_t cpu_nodes_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	int nid, next_nid;
+	int len = 0;
+
+	for_each_node_state(nid, N_CPU) {
+		len += sysfs_emit_at(buf, len, "%d", nid);
+		next_nid = next_node(nid, node_states[N_CPU]);
+		if (next_nid < MAX_NUMNODES)
+			len += sysfs_emit_at(buf, len, ",");
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static ssize_t possible_nodes_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	int nid, next_nid;
+	int len = 0;
+
+	for_each_node_state(nid, N_POSSIBLE) {
+		len += sysfs_emit_at(buf, len, "%d", nid);
+		next_nid = next_node(nid, node_states[N_POSSIBLE]);
+		if (next_nid < MAX_NUMNODES)
+			len += sysfs_emit_at(buf, len, ",");
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static struct kobj_attribute cpu_nodes_attr = __ATTR_RO(cpu_nodes);
+static struct kobj_attribute possible_nodes_attr = __ATTR_RO(possible_nodes);
+
+static struct attribute *mempolicy_attrs[] = {
+	&cpu_nodes_attr.attr,
+	&possible_nodes_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mempolicy_attr_group = {
+	.attrs = mempolicy_attrs,
+	NULL,
+};
+
+static void mempolicy_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+	kfree(iw_table);
+}
+
+static const struct kobj_type mempolicy_kobj_ktype = {
+	.release = mempolicy_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static int __init mempolicy_sysfs_init(void)
+{
+	int err, nid;
+	int cpunodes = 0;
+	struct kobject *root_kobj;
+
+	for_each_node_state(nid, N_CPU)
+		cpunodes += 1;
+	iw_table = kmalloc_array(cpunodes, sizeof(*iw_table), GFP_KERNEL);
+	if (!iw_table) {
+		pr_err("failed to create interleave weight table\n");
+		err = -ENOMEM;
+		goto fail_obj;
+	}
+	memset(iw_table, 1, cpunodes * sizeof(*iw_table));
+
+	root_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!root_kobj)
+		return -ENOMEM;
+
+	kobject_init(root_kobj, &mempolicy_kobj_ktype);
+	err = kobject_add(root_kobj, mm_kobj, "mempolicy");
+	if (err) {
+		pr_err("failed to add kobject to the system\n");
+		goto fail_obj;
+	}
+
+	err = sysfs_create_group(root_kobj, &mempolicy_attr_group);
+	if (err) {
+		pr_err("failed to register mempolicy group\n");
+		goto fail_obj;
+	}
+
+	err = add_weighted_interleave_group(root_kobj);
+fail_obj:
+	if (err)
+		kobject_put(root_kobj);
+	return err;
+
+}
+late_initcall(mempolicy_sysfs_init);
-- 
2.39.1


