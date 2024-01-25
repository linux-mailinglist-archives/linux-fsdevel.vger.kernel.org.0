Return-Path: <linux-fsdevel+bounces-8998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D354083CB59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1723EB214F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E6134751;
	Thu, 25 Jan 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hifNVbpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510651339A1;
	Thu, 25 Jan 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208242; cv=none; b=n9OF42a5cPT5Lguie12lNhWxlVUhyj9mO6c2GxV4NBePxjOTE1lmp0wqWyoMUbUg97kz1gtCEH5dlCxcjXFhErYjDCa+dAQxmXa5yPxV+RC8Z+ZUna9Yz/aNl0tkVbCfFQzKAjlIrS0P5gqwkqwgYlkmgS3QLp+3bmEQZ20DUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208242; c=relaxed/simple;
	bh=A/gwmbB4WkG+E8bBcS0jJdPNtFmTOMm9P1nybo3YutU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bALPm4G8Srh3Q/K8tM365n3evE8SJAMU6qbdQfXwucTRb0ttM01os2952KnUsxX+iF9ddHQityVPL5aORDHx6i7LKv0UEQSSFT/5brEQi4yIDwM3+xBmxtPrg+lSvzcRoWgfESfv4nPB9Wk+WiKAe+scCaHzMR6LqItTnf3agwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hifNVbpO; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6dd85328325so2900256b3a.1;
        Thu, 25 Jan 2024 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208236; x=1706813036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmYsuLrbhfeS9FkHVAV0PwAEzQixEgg+6xUQTYSEcCU=;
        b=hifNVbpOC+IlOedi1L35htrXItG0a/6V2RuZ0wZhMRCYAiKenm34MSzHOG0y33Ig9z
         OeMX/pTXWg/qrW4VnVQlV3S8+xvJtXGOecwUXXOMwMcI6rR8BXeynvR3Af9rPH0jyBc1
         6ovwsxpk18ZCiqZantFg4R+a+jeDgs3fnkSOQXpc8WeGLuxw62jkrxI0TSmQJ0b+nC7Z
         IOjW7mlbh/0K3bE5TDGm/XBwk9bXA3RJyxI3YbM8GJKrmM5ugBxZShcWEKz3yyTJu7f+
         NPwXq48IVa+ZIavPkwV0KeYzVABjO6Km7i8UH4O1wHVfOC4vTps+mcIb8q4NLz+jDmS9
         lCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208236; x=1706813036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmYsuLrbhfeS9FkHVAV0PwAEzQixEgg+6xUQTYSEcCU=;
        b=j2wF8hfIJv0ecmKKFiHY0qTGuT2wWJEHIgHZ3qLAzKW+S/+IM3mQ658Uz2DloY9Rqo
         couvvr6szS+0ZW8RJXT1PJ+7UOvQvQUCuBuvTtEGbPKsTNAB5crlZGCzJMbFb14cQTcs
         IMoRSShbdtUM8keRAFTv+IpX3JiaXTHb7IV1jdZkv15Oy2wysuysfkIpzr12YfCneLDa
         Ku5nm1vibEfICddU03dc/xM7s5/gYREH4dnTsWJ3cZccgCxEZ3TU0qXvXT17u+NIxOYf
         gzmj7RlqLW3cRAgRvlIm77SRIlhoLh+drtRReRhoesL7H04grQPr06b2Kywgv5vx9RO2
         a9FQ==
X-Gm-Message-State: AOJu0YzuP+NHIRRlORkEokGQqG4Uwtf+Dzy2jyug0XZ0QhODbbh+CGRl
	m2bBRUkVbGItdoMh96NFX4T2OjN60VQ4Zu7Jwl/D5aKcTL8fgI0=
X-Google-Smtp-Source: AGHT+IEqg27yq8B6HkgUKSGyfBqEu8l7uYy3U7f2VU4V68PFsFDVS5Uu2mKsvyuU8Sy0tPawAHsrNg==
X-Received: by 2002:a05:6a00:db:b0:6dd:8891:81ef with SMTP id e27-20020a056a0000db00b006dd889181efmr134165pfj.43.1706208236405;
        Thu, 25 Jan 2024 10:43:56 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b006ddcf56fb78sm1815070pfn.62.2024.01.25.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:43:56 -0800 (PST)
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
Subject: [PATCH v3 1/4] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Thu, 25 Jan 2024 13:43:42 -0500
Message-Id: <20240125184345.47074-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240125184345.47074-1-gregory.price@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
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

If a node value is set to `0`, the system-default value will be used.
As of this patch, the system-default for all nodes is always 1.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  25 ++
 mm/mempolicy.c                                | 224 ++++++++++++++++++
 3 files changed, 253 insertions(+)
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
index 000000000000..0062b02703ff
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,25 @@
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
+Date:		January 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration Interface for the Weighted Interleave policy
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN
+Date:		January 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Weight configuration interface for nodeN
+
+		The interleave weight for a memory node (N). These weights are
+		utilized by taskss which have set their mempolicy to
+		MPOL_WEIGHTED_INTERLEAVE.
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
index 10a590ee1c89..f1627d45b0c8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,17 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/*
+ * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
+ * system-default value should be used. A NULL iw_table also denotes that
+ * system-default values should be used. Until the system-default table
+ * is implemented, the system-default is always 1.
+ *
+ * iw_table is RCU protected
+ */
+static u8 __rcu *iw_table;
+static DEFINE_MUTEX(iw_table_lock);
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3078,216 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
+	u8 __rcu *table;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	weight = table ? table[node_attr->nid] : 1;
+	rcu_read_unlock();
+
+	return sysfs_emit(buf, "%d\n", weight);
+}
+
+static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct iw_node_attr *node_attr;
+	u8 __rcu *new;
+	u8 __rcu *old;
+	u8 weight = 0;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	if (count == 0 || sysfs_streq(buf, ""))
+		weight = 0;
+	else if (kstrtou8(buf, 0, &weight))
+		return -EINVAL;
+
+	/*
+	 * The default weight is 1, for now. When the kernel-internal
+	 * default weight array is implemented, 0 will be a directive to
+	 * the allocators to use the system-default weight instead.
+	 */
+	if (!weight)
+		weight = 1;
+
+	new = kmalloc(nr_node_ids, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	if (old)
+		memcpy(new, old, nr_node_ids);
+	else
+		memset(new, 1, nr_node_ids);
+	new[node_attr->nid] = weight;
+	rcu_assign_pointer(iw_table, new);
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	kfree(old);
+	return count;
+}
+
+static struct iw_node_attr **node_attrs;
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
+	for (i = 0; i < nr_node_ids; i++)
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
+	u8 __rcu *old;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	rcu_assign_pointer(iw_table, NULL);
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	kfree(old);
+	kfree(node_attrs);
+	kfree(kobj);
+}
+
+static const struct kobj_type mempolicy_ktype = {
+	.release = mempolicy_kobj_release
+};
+
+static int __init mempolicy_sysfs_init(void)
+{
+	int err;
+	static struct kobject *mempolicy_kobj;
+
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs) {
+		err = -ENOMEM;
+		goto mempol_out;
+	}
+
+	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
+				   "mempolicy");
+	if (err)
+		goto node_out;
+
+	err = add_weighted_interleave_group(mempolicy_kobj);
+	if (err) {
+		pr_err("mempolicy sysfs structure failed to initialize\n");
+		kobject_put(mempolicy_kobj);
+		return err;
+	}
+
+	return err;
+node_out:
+	kfree(node_attrs);
+mempol_out:
+	kfree(mempolicy_kobj);
+err_out:
+	pr_err("failed to add mempolicy kobject to the system\n");
+	return err;
+}
+
+late_initcall(mempolicy_sysfs_init);
+#endif /* CONFIG_SYSFS */
-- 
2.39.1


