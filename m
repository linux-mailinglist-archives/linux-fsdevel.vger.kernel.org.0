Return-Path: <linux-fsdevel+bounces-9558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DF842B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674C31F276D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD4157E95;
	Tue, 30 Jan 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiWvGuc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF68157E6C;
	Tue, 30 Jan 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638859; cv=none; b=VihQIKSpEfHGBPtaMEaCldLqL0EEkO0qBlkxU2U0bzGMiXrke3ymgFx1P+kyN9XHqKXc3ye03dEIdXrrKkaFDFuYzih2Ng11ikRvHRusxvVkPo+AOYh5FQBUATrPcGJ+8OhNULjStgHqZeCDLnfgapB89lKVa9cHI3LNl6JbR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638859; c=relaxed/simple;
	bh=NIUzAXrRV7ZDE0Mb5WeD6b/AYmdSkN2e52tVP9wKT0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgdE/R613Swec6FO2wPQsyvxZXPwVA7kZ7GJJxJQ4/hSOqokNxxl4J6uD5Ud4ziGuL3IDoiaui9SWdku2zIAKLIcpoFx2zfiQuqzOZfOQhSpemC9DQvLE9z6oJk7lqeQCNZ7XLJ5eW6ZkMZOWFgW3iTynGkibDi8TPo5brDcaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiWvGuc2; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d8ef972451so11499505ad.2;
        Tue, 30 Jan 2024 10:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638856; x=1707243656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZMn6sDMi1uCxjmVz8fP6z7yvojLb9nEQHXs3aNIFG4=;
        b=SiWvGuc2j3JPgJn44/Jt2h/mncFCM2iyfV6Q/EmppyYbdxU6YjL8yKKFLRnExllVz3
         RL366Xh+uhnDYhV/a88jTWc4Xok+ncuD856GIlOw67jqd11mZ/nEjW9p60DXMLtiBYKC
         VMXEjNSQO6HtE1izZbYK6xQxTB89lW4AfmrzH8m7tQMetQxDTsC7VDotldnYRAkX3cV2
         cH2LrdD5j0KMf00TwnocXjSi9pMWnWVNOP5aH9/ZMN3ruqt330rhGH2vheay4KjJJDGH
         VyKKTlL+cV7kJlbA5mA70UP92yVRsFtQdxYKQ7BJ1foSJGu41zAoXe+qTGBjcoJdw20o
         eBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638856; x=1707243656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZMn6sDMi1uCxjmVz8fP6z7yvojLb9nEQHXs3aNIFG4=;
        b=k2gmISHvZOaO9XgUEapjxryZ4SkEhuHLlhmAXrLNLHGek3TKWGEBK7SAw1sSFO4CPg
         9l1toDOixKxxYO7QcH+d4c0/vwN3cRx9HzWQ1UcsNBE6+xbKWHq4bfSxzQxrg8uSi7NH
         bgNX2tnwrG85aMhaiPeM+BnZ7brKdZuhQaXl3vy0WhJPRCJJO2A3hT/1j06P7yY+K/a7
         nts4nSn4GqT05UCddhhsotmIROitY+B6kk4X/21rtb9flrcT5Q8GQg62Iniu6wgLJAEW
         LmXnLY2DV9XhAqByeMIFFJGk/2y961o/+x7OS/vthFwNwaCwlzE7GNMGsfGpxICebkM1
         lKVA==
X-Gm-Message-State: AOJu0YyoCfxXkhNJMTkfkzaGqURRpHGY0gHnDQamF6mOy6oJElePuJN1
	f+YO8fpAnDfIWF1FXs0oAjer6Y8tvwp9o7bQ64i+GEGA6OqBN4i2KcWxBFMdhAc9
X-Google-Smtp-Source: AGHT+IHt0cjlyHl0KL24KfAI1BtOVueUlhISU+9jt8XD1LbCPQo9Jx7uDvV7iI3p0+67jXuwN4211w==
X-Received: by 2002:a05:6a21:4487:b0:19b:4349:5447 with SMTP id vo7-20020a056a21448700b0019b43495447mr4623581pzb.29.1706638856462;
        Tue, 30 Jan 2024 10:20:56 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b006d9ce7d3258sm8460143pfg.204.2024.01.30.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:20:56 -0800 (PST)
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
Subject: [PATCH v4 1/3] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Tue, 30 Jan 2024 13:20:44 -0500
Message-Id: <20240130182046.74278-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240130182046.74278-1-gregory.price@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
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
 mm/mempolicy.c                                | 223 ++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
new file mode 100644
index 000000000000..8ac327fd7fb6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
@@ -0,0 +1,4 @@
+What:		/sys/kernel/mm/mempolicy/
+Date:		January 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for Mempolicy
diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
new file mode 100644
index 000000000000..0b7972de04e9
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
+		utilized by tasks which have set their mempolicy to
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
index 10a590ee1c89..440128a398ef 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,32 @@ static struct mempolicy default_policy = {
 
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
+static u8 get_il_weight(int node)
+{
+	u8 __rcu *table;
+	u8 weight;
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	/* if no iw_table, use system default */
+	weight = table ? table[node] : 1;
+	/* if value in iw_table is 0, use system default */
+	weight = weight ? weight : 1;
+	rcu_read_unlock();
+	return weight;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3093,200 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	weight = get_il_weight(node_attr->nid);
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
+	new = kzalloc(nr_node_ids, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	if (old)
+		memcpy(new, old, nr_node_ids);
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


