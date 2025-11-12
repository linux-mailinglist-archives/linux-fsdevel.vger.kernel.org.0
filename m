Return-Path: <linux-fsdevel+bounces-68090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65464C542DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083F73B87F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006C350A16;
	Wed, 12 Nov 2025 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="su++Ku3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609C351FB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975803; cv=none; b=GAMoeqC1JqxaSFjqdxRPlbHu8HDZqFaa3q5RgMh8HNCD2hl6MBdaWOILZGv4uTeXyKhqZYVbwImeGg2BoQOTdqdK0NeLAxj7Cyt7KPdC1czuSeWi0HsvPKEL5XQgQhamlGh/U01mB2QKF0S7eiWPEm5DVJctqA68G8ufv3nIelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975803; c=relaxed/simple;
	bh=eHEbONvZIj37o0CRFSIwDW5/+99mEJwz4WMdReKTyos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5GHKl217516sX+CbIVKutwq+oG7IzSaa04ElhEkJM7wUjnauu8DxoavEVLApZd7sAQ1V9V8UxNJpkiKdKZ6O/B7rAvMm9461MbVOaT1AbrWJrWQmtvIJwtAEty8zUY9PnburFWlZglUsoLWApqD+7I2/ZBFjJvIsc2AweyZkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=su++Ku3T; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a3eac7ca30so2789585a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975800; x=1763580600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ3STVw+04anWCoqtoEILU8J9sgMLUtAldTEWscHkZw=;
        b=su++Ku3TZuZIylJVYIjsRg+bG6Ff5F1yniZAeMEwZV5B9SRxtgO8Pa7ZA5qW344eAl
         ALBiIvLqY/UMYydvLNIpsyxsZ7eedw6gfFhdmcmcwRrCXiQCtPN19XthORu1knmMPizB
         yu9ljJXEC3e3JIq91X/s5iu48q7lYyN2yMNpAwHQTU7JoCN6O1Cc3aaG+APdqlXkh2CZ
         RqlI8414oV1/m9eAoOHuFZWL5fxiSBQ2UnAcMG27CVyqvAIVSzb+U7eNyXS5A+H7jXzN
         C+JF2TMOqJg3HCzBJdrplR2Cu7b+E6bjFE+nXrCYec/cSczQZfl+KbCLWRQYN4toikkz
         oPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975800; x=1763580600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJ3STVw+04anWCoqtoEILU8J9sgMLUtAldTEWscHkZw=;
        b=S6QZOHIU/iOCPQ11j/aoA2aBMWCJTDbbX71iCVRQ6FhsrMD9I6HJFmYqmYBD2HtbKs
         zJ16jim6H6CHAn4bQ0DxKr7nuQrCOeOxKTizSgXNhMg38Jf+q1XA7pI1EiyzVb0i/iKy
         QsB4trKV8cZxjKpbekWVazNXvVD/FGn//Ec7vxUzX+LCdB/Edcj1dSrPTU7tmnrASUvi
         7n2HYqkxY7jMlOybtSNznLJ0MuZ2/5utwUCetUUZn9RZdjucnfycXwDPLA/F3HsBxDDA
         gLnzpAioPsJ93CdWBx22kEQjWnirsFBbc1ikADAUr3BAjY9ZVXLPpnDmPBx/qi/r180k
         15CA==
X-Forwarded-Encrypted: i=1; AJvYcCW+mpf0Z0rFHwry/gRh5q2lN/XZUUsuUrMqoSUPQ2dJo5/2HrcrHe+O+n4iwnlEVWzBG2m2aO1a+HL8IYCt@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1xmIIcN0gylnAUEIKRlStD3qEmpHxFLwn1izsS1hftNk2Fff
	wNMghcjlgY18DqG9gws6Yp3Tvts8rLhT9b75eRpAfP4RKc8ULjVLl7QEYA7s7kFz8Qo=
X-Gm-Gg: ASbGnctgfgBH4j1xgje0wYUGoLMzsqu5WVsk/uyZGujNk+1uodh1k0uckicpxcxJRme
	Vg2Rv6+5Qlnc9b+TM9JjYoWyTfbVTkSMwoy5m6YoTEKIzLdEBEPpoa2Q0r58gLXRlnBzxbD5hUn
	HJGr8QJEuIt7T4BmnkcjLKoa5y2N+8TAqjxcsMHbBQsxoDXDwOr8QIdEzXkB136QxCBpTRxoNPi
	1Uq73zq+ou1wxahnlBF3jubYyUvlomkBwfOrJAbQRNC0rdH+T8LhKo/r5YCmnQR17kFhRLPdrZ6
	keOMiEoq16J36V10PjZL8R02xBohzBGV+j9KYPHnPYivzN4V8uDWDrsNVY7pxHRtNDD0Nl9Nz5s
	z8sWezzbalgRx1rKKS9OzkMsCBvjJRqx4gCOa9Obos6Iu3Fs2WE4ymzcR+svc2x6ycFMsHeaGSC
	7YkblY22hvk7XPO360ToOOURIUHoB6QnvnfwwO1lj0dABqHKPk+W/D4fSpdE5JhD0V
X-Google-Smtp-Source: AGHT+IFpnJx+AzJWivjhYu5iwBOCku4YiBEji1yF3XFF/JbCkfgSDAdwWhiHUxXnRZSwthPc0nD5rw==
X-Received: by 2002:a05:620a:40c1:b0:8b1:ac18:acc9 with SMTP id af79cd13be357-8b29b77ad4bmr554239985a.32.1762975799847;
        Wed, 12 Nov 2025 11:29:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH v2 04/11] memory-tiers: Introduce SysRAM and Specific Purpose Memory Nodes
Date: Wed, 12 Nov 2025 14:29:20 -0500
Message-ID: <20251112192936.2574429-5-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create Memory Node "types" (SysRAM and Specific Purpose) which can be
set at memory hotplug time.

SysRAM nodes present at __init time are added to the mt_sysram_nodelist
and memory hotplug will decide whether hotplugged nodes will be placed
in mt_sysram_nodelist or mt_spm_nodelist.

SPM nodes are not included in demotion targets.

Setting a node type is permanent and cannot be switched once set, this
prevents type-change race conditions on the global mt_sysram_nodelist.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory-tiers.h | 47 +++++++++++++++++++++++++
 mm/memory-tiers.c            | 66 ++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 7a805796fcfd..59443cbfaec3 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -35,10 +35,44 @@ struct memory_dev_type {
 
 struct access_coordinate;
 
+enum {
+	MT_NODE_TYPE_SYSRAM,
+	MT_NODE_TYPE_SPM
+};
+
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
 extern struct memory_dev_type *default_dram_type;
 extern nodemask_t default_dram_nodes;
+extern nodemask_t mt_sysram_nodelist;
+extern nodemask_t mt_spm_nodelist;
+static inline nodemask_t *mt_sysram_nodemask(void)
+{
+	if (nodes_empty(mt_sysram_nodelist))
+		return NULL;
+	return &mt_sysram_nodelist;
+}
+static inline void mt_nodemask_sysram_mask(nodemask_t *dst, nodemask_t *mask)
+{
+	/* If the sysram filter isn't available, this allows all */
+	if (nodes_empty(mt_sysram_nodelist)) {
+		nodes_or(*dst, *mask, NODE_MASK_NONE);
+		return;
+	}
+	nodes_and(*dst, *mask, mt_sysram_nodelist);
+}
+static inline bool mt_node_is_sysram(int nid)
+{
+	/* if sysram filter isn't setup, this allows all */
+	return nodes_empty(mt_sysram_nodelist) ||
+	       node_isset(nid, mt_sysram_nodelist);
+}
+static inline bool mt_node_allowed(int nid, gfp_t gfp_mask)
+{
+	if (gfp_mask & __GFP_SPM_NODE)
+		return true;
+	return mt_node_is_sysram(nid);
+}
 struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
@@ -73,11 +107,19 @@ static inline bool node_is_toptier(int node)
 }
 #endif
 
+int mt_set_node_type(int node, int type);
+
 #else
 
 #define numa_demotion_enabled	false
 #define default_dram_type	NULL
 #define default_dram_nodes	NODE_MASK_NONE
+#define mt_sysram_nodelist	NODE_MASK_NONE
+#define mt_spm_nodelist		NODE_MASK_NONE
+static inline nodemask_t *mt_sysram_nodemask(void) { return NULL; }
+static inline void mt_nodemask_sysram_mask(nodemask_t *dst, nodemask_t *mask) {}
+static inline bool mt_node_is_sysram(int nid) { return true; }
+static inline bool mt_node_allowed(int nid, gfp_t gfp_mask) { return true; }
 /*
  * CONFIG_NUMA implementation returns non NULL error.
  */
@@ -151,5 +193,10 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 static inline void mt_put_memory_types(struct list_head *memory_types)
 {
 }
+
+int mt_set_node_type(int node, int type)
+{
+	return 0;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0ea5c13f10a2..dd6cfaa4c667 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -44,7 +44,15 @@ static LIST_HEAD(memory_tiers);
 static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
-nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
+
+/* default_dram_nodes is the list of nodes with both CPUs and RAM */
+nodemask_t default_dram_nodes = NODE_MASK_NONE;
+
+/* mt_sysram_nodelist is the list of nodes with SysramRAM */
+nodemask_t mt_sysram_nodelist = NODE_MASK_NONE;
+
+/* mt_spm_nodelist is the list of nodes with Specific Purpose Memory */
+nodemask_t mt_spm_nodelist = NODE_MASK_NONE;
 
 static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
@@ -427,6 +435,14 @@ static void establish_demotion_targets(void)
 	disable_all_demotion_targets();
 
 	for_each_node_state(node, N_MEMORY) {
+		/*
+		 * If this is not a sysram node, direct-demotion is not allowed
+		 * and must be managed by special logic that understands the
+		 * memory features of that particular node.
+		 */
+		if (!node_isset(node, mt_sysram_nodelist))
+			continue;
+
 		best_distance = -1;
 		nd = &node_demotion[node];
 
@@ -457,7 +473,8 @@ static void establish_demotion_targets(void)
 				break;
 
 			distance = node_distance(node, target);
-			if (distance == best_distance || best_distance == -1) {
+			if ((distance == best_distance || best_distance == -1) &&
+			    node_isset(target, mt_sysram_nodelist)) {
 				best_distance = distance;
 				node_set(target, nd->preferred);
 			} else {
@@ -689,6 +706,48 @@ void mt_put_memory_types(struct list_head *memory_types)
 }
 EXPORT_SYMBOL_GPL(mt_put_memory_types);
 
+/**
+ * mt_set_node_type() - Set a NUMA Node's Memory type.
+ * @node: The node type to set
+ * @type: The type to set
+ *
+ * This is a one-way setting, once a type is assigned it cannot be cleared
+ * without resetting the system.  This is to avoid race conditions associated
+ * with moving nodes from one type to another during memory hotplug.
+ *
+ * Once a node is added as a SysRAM node, it will be used by default in
+ * the page allocator as a valid target when the calling does not provide
+ * a node or nodemask.  This is safe as the page allocator iterates through
+ * zones and uses this nodemask to filter zones - if a node is present but
+ * has no zones the node is ignored.
+ *
+ * Return: 0 if the node type is set successfully (or it's already set)
+ *         -EBUSY if the node has a different type already
+ *         -ENODEV if the type is invalid
+ */
+int mt_set_node_type(int node, int type)
+{
+	int err;
+
+	mutex_lock(&memory_tier_lock);
+	if (type == MT_NODE_TYPE_SYSRAM)
+		err = node_isset(node, mt_spm_nodelist) ? -EBUSY : 0;
+	else if (type == MT_NODE_TYPE_SPM)
+		err = node_isset(node, mt_sysram_nodelist) ? -EBUSY : 0;
+	if (err)
+		goto out;
+
+	if (type == MT_NODE_TYPE_SYSRAM)
+		node_set(node, mt_sysram_nodelist);
+	else if (type == MT_NODE_TYPE_SPM)
+		node_set(node, mt_spm_nodelist);
+	else
+		err = -ENODEV;
+out:
+	mutex_unlock(&memory_tier_lock);
+	return err;
+}
+
 /*
  * This is invoked via `late_initcall()` to initialize memory tiers for
  * memory nodes, both with and without CPUs. After the initialization of
@@ -922,6 +981,9 @@ static int __init memory_tier_init(void)
 	nodes_and(default_dram_nodes, node_states[N_MEMORY],
 		  node_states[N_CPU]);
 
+	/* Record all nodes with non-hotplugged memory as default SYSRAM nodes */
+	mt_sysram_nodelist = node_states[N_MEMORY];
+
 	hotplug_node_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
 	return 0;
 }
-- 
2.51.1


