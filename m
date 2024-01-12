Return-Path: <linux-fsdevel+bounces-7889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D098C82C688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 22:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6230728821B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD37171BC;
	Fri, 12 Jan 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiu/0mmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91967168D8;
	Fri, 12 Jan 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-5f07f9d57b9so69491867b3.1;
        Fri, 12 Jan 2024 13:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705093720; x=1705698520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHg4DTfSl16uJaMczzTNoUC+m5jm+gFdUgSFv3KQQkQ=;
        b=fiu/0mmO9TgyaPtctvyc0HT6HRSNfYeo+xYGdAUfmh+9k/3hHFlugKM9t/qstrBlXF
         1saloReROW2wsz+ZTkawTmM17Bw5TLk8srpniSJsJxn5DWkdJ/5Zkhl6isA6fCHQpm7a
         o7FA9pouRIfhNCOh4U/d3REHuo1nR0OewjArqSZJ/0Hav3ORkdZvj3sXb+lS06s/oTH/
         nw1JaYFwz6TA/Z/KJsgv87R+RQeL7n/79dpBAqBvS3Kh9J54tk5K9i3n24+UXgIEJe52
         UESulmFHS+S7di8uIMGY0xMo+0keLNvczbYjyJZnNvY047I0LvsY3fUvaYAoHD6pI87M
         mCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093720; x=1705698520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHg4DTfSl16uJaMczzTNoUC+m5jm+gFdUgSFv3KQQkQ=;
        b=KOGGmJbEZ00q5fOsrDyLCK1otcfXj10IyyDru12tyfn7zGtd4DRYSLgB7+Q3pltBUN
         oQYw+oOLQ7ZYzxYeDa7ywdgXKFpsKbKjEdTUAHrbpWTS2rNzalD7ek3OGtqdsMxMy1gU
         ilrLV2MLntVbJaRbk3D5242+e3UMbaOgLfQxAQSqBxRGLmgurn6YCexyyyfupE9rN2wo
         N3NETNdrIXA7IMAH86he6TB5YTj0t6gy79+6A2qKKcCH0O2LifAzuORvkkraoZoJMK7O
         lLwSjHiX18MTYjpboNQzv6y1BdHMIs29ibKCxv7n45mOJkrqOYdMTMe7H7wG3GIdYf/S
         gypQ==
X-Gm-Message-State: AOJu0YxiWfYB65jNb3EJqbdRDr7+MeGUD9asNmnhB0/zEUZsNxwiIBoQ
	U2ldpXI2zDgBC+H9hGK6DQ==
X-Google-Smtp-Source: AGHT+IGB5xJXfZj5qM/n1aiXo/TltTalNIGHNrO2SY+vaaKHAwB3V+mO8XaKkRaz4llb/pSubhWHog==
X-Received: by 2002:a81:6d83:0:b0:5ed:c398:c266 with SMTP id i125-20020a816d83000000b005edc398c266mr1845911ywc.52.1705093720370;
        Fri, 12 Jan 2024 13:08:40 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id ci24-20020a05690c0a9800b005f93cc31ff0sm1635518ywb.72.2024.01.12.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:08:39 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	gregory.price@memverge.com,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	mhocko@kernel.org,
	ying.huang@intel.com,
	vtavarespetr@micron.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/3] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Fri, 12 Jan 2024 16:08:32 -0500
Message-Id: <20240112210834.8035-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240112210834.8035-1-gregory.price@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
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
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN

The sysfs structure is designed as follows.

  $ tree /sys/kernel/mm/mempolicy/
  /sys/kernel/mm/mempolicy/ [1]
  └── weighted_interleave [2]
      ├── node0 [3]
      └── node1

Each file above can be explained as follows.

[1] mm/mempolicy: configuration interface for mempolicy subsystem

[2] weighted_interleave/: config interface for weighted interleave policy

[3] weighted_interleave/nodeN: weight for nodeN

Internally, there is a secondary table `default_iw_table`, which holds
kernel-internal default interleave weights for each possible node.

If the value for a node is set to `0`, the default value will be used.

If sysfs is disabled in the config, interleave weights will default
to use `default_iw_table`.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  26 ++
 mm/mempolicy.c                                | 251 ++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
new file mode 100644
index 000000000000..2dcf24f4384a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
@@ -0,0 +1,4 @@
+What:		/sys/kernel/mm/mempolicy/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for Mempolicy
diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
new file mode 100644
index 000000000000..e6a38139bf0f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,26 @@
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration Interface for the Weighted Interleave policy
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Weight configuration interface for nodeN
+
+		The interleave weight for a memory node (N). These weights are
+		utilized by processes which have set their mempolicy to
+		MPOL_WEIGHTED_INTERLEAVE and have opted into global weights by
+		omitting a task-local weight array.
+
+		These weights only affect new allocations, and changes at runtime
+		will not cause migrations on already allocated pages.
+
+		The minimum weight for a node is always 1.
+
+		Minimum weight: 1
+		Maximum weight: 255
+
+		Writing an empty string or `0` will reset the weight to the
+		system default. The system default may be set by the kernel
+		or drivers at boot or during hotplug events.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..5da4fd79fd18 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,30 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+struct iw_table {
+	struct rcu_head rcu;
+	u8 weights[MAX_NUMNODES];
+};
+/*
+ * default_iw_table is the kernel-internal default value interleave
+ * weight table. It is to be set by driver code capable of reading
+ * HMAT/CDAT information, and to provide mempolicy a sane set of
+ * default weight values for WEIGHTED_INTERLEAVE mode.
+ *
+ * By default, prior to HMAT/CDAT information being consumed, the
+ * default weight of all nodes is 1.  The default weight of any
+ * node can only be in the range 1-255. A 0-weight is not allowed.
+ */
+static struct iw_table default_iw_table;
+/*
+ * iw_table is the sysfs-set interleave weight table, a value of 0
+ * denotes that the default_iw_table value should be used.
+ *
+ * iw_table is RCU protected
+ */
+static struct iw_table __rcu *iw_table;
+static DEFINE_MUTEX(iw_table_mtx);
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3091,230 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+#ifdef CONFIG_SYSFS
+struct iw_node_attr {
+	struct kobj_attribute kobj_attr;
+	int nid;
+};
+
+static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct iw_node_attr *node_attr;
+	u8 weight;
+	struct iw_table __rcu *table;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	weight = table->weights[node_attr->nid];
+	rcu_read_unlock();
+
+	return sysfs_emit(buf, "%d\n", weight);
+}
+
+static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct iw_node_attr *node_attr;
+	struct iw_table __rcu *new;
+	struct iw_table __rcu *old;
+	u8 weight = 0;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	if (count == 0 || sysfs_streq(buf, ""))
+		weight = 0;
+	else if (kstrtou8(buf, 0, &weight))
+		return -EINVAL;
+
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&iw_table_mtx);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_mtx));
+	/* If value is 0, revert to default weight */
+	weight = weight ? weight : default_iw_table.weights[node_attr->nid];
+	memcpy(&new->weights, &old->weights, sizeof(new->weights));
+	new->weights[node_attr->nid] = weight;
+	rcu_assign_pointer(iw_table, new);
+	mutex_unlock(&iw_table_mtx);
+	kfree_rcu(old, rcu);
+	return count;
+}
+
+static struct iw_node_attr *node_attrs[MAX_NUMNODES];
+
+static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
+				  struct kobject *parent)
+{
+	if (!node_attr)
+		return;
+	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
+	kfree(node_attr->kobj_attr.attr.name);
+	kfree(node_attr);
+}
+
+static void sysfs_wi_release(struct kobject *wi_kobj)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++)
+		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+	kobject_put(wi_kobj);
+}
+
+static const struct kobj_type wi_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = sysfs_wi_release,
+};
+
+static int add_weight_node(int nid, struct kobject *wi_kobj)
+{
+	struct iw_node_attr *node_attr;
+	char *name;
+
+	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
+	if (!node_attr)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "node%d", nid);
+	if (!name) {
+		kfree(node_attr);
+		return -ENOMEM;
+	}
+
+	sysfs_attr_init(&node_attr->kobj_attr.attr);
+	node_attr->kobj_attr.attr.name = name;
+	node_attr->kobj_attr.attr.mode = 0644;
+	node_attr->kobj_attr.show = node_show;
+	node_attr->kobj_attr.store = node_store;
+	node_attr->nid = nid;
+
+	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
+		kfree(node_attr->kobj_attr.attr.name);
+		kfree(node_attr);
+		pr_err("failed to add attribute to weighted_interleave\n");
+		return -ENOMEM;
+	}
+
+	node_attrs[nid] = node_attr;
+	return 0;
+}
+
+static int add_weighted_interleave_group(struct kobject *root_kobj)
+{
+	struct kobject *wi_kobj;
+	int nid, err;
+
+	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!wi_kobj)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
+				   "weighted_interleave");
+	if (err) {
+		kfree(wi_kobj);
+		return err;
+	}
+
+	memset(node_attrs, 0, sizeof(node_attrs));
+	for_each_node_state(nid, N_POSSIBLE) {
+		err = add_weight_node(nid, wi_kobj);
+		if (err) {
+			pr_err("failed to add sysfs [node%d]\n", nid);
+			break;
+		}
+	}
+	if (err)
+		kobject_put(wi_kobj);
+	return 0;
+}
+
+static void mempolicy_kobj_release(struct kobject *kobj)
+{
+	if (iw_table != &default_iw_table)
+		kfree(iw_table);
+	kfree(kobj);
+}
+
+static const struct kobj_type mempolicy_ktype = {
+	.release = mempolicy_kobj_release
+};
+
+static struct kobject *mempolicy_kobj;
+static int __init mempolicy_sysfs_init(void)
+{
+	int err;
+	struct kobject *mempolicy_kobj;
+	struct iw_table __rcu *table = NULL;
+
+	/*
+	 * If sysfs setup fails, utilize the default weight table
+	 * This at least allows mempolicy to continue functioning safely.
+	 */
+	memset(&default_iw_table.weights, 1, MAX_NUMNODES);
+	iw_table = &default_iw_table;
+
+	table = kzalloc(sizeof(struct iw_table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	memcpy(&table->weights, default_iw_table.weights,
+	       sizeof(table->weights));
+
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
+		kfree(table);
+		pr_err("failed to add mempolicy kobject to the system\n");
+		return -ENOMEM;
+	}
+	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
+				   "mempolicy");
+	if (err) {
+		kfree(table);
+		kfree(mempolicy_kobj);
+		return err;
+	}
+
+	err = add_weighted_interleave_group(mempolicy_kobj);
+
+	if (err) {
+		kobject_put(mempolicy_kobj);
+		return err;
+	}
+
+	iw_table = table;
+	return err;
+}
+
+static void __exit mempolicy_exit(void)
+{
+	if (mempolicy_kobj)
+		kobject_put(mempolicy_kobj);
+}
+
+#else
+static int __init mempolicy_sysfs_init(void)
+{
+	/*
+	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
+	 * MPOL_INTERLEAVE behavior, but is still defined separately to
+	 * allow task-local weighted interleave and system-defaults to
+	 * operate as intended.
+	 *
+	 * In this scenario iw_table cannot (presently) change, so
+	 * there's no need to set up RCU / cleanup code.
+	 */
+	memset(&default_iw_table.weights, 1, sizeof(default_iw_table));
+	iw_table = default_iw_table;
+	return 0;
+}
+
+static void __exit mempolicy_exit(void) { }
+#endif /* CONFIG_SYSFS */
+late_initcall(mempolicy_sysfs_init);
+module_exit(mempolicy_exit);
-- 
2.39.1


