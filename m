Return-Path: <linux-fsdevel+bounces-8322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D8B832E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A74F1C23C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C55674D;
	Fri, 19 Jan 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CON4dxMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFC56460;
	Fri, 19 Jan 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687063; cv=none; b=OHH0/44o71HduEE78HyWGXnlVlZrxVh4AhuPCddrAHb6xrqZMM4TGadL3hJG0GJXua1GW+dRmTrQMOxpQs7KKMLNBmIuPUVAnhKixBv7U2hjBAVUt08D0EiOxJGg7gcKONmQsqD4UDaYr3hMd5hC4l8jgTSLkKH4oc8jsgODkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687063; c=relaxed/simple;
	bh=C460omkZRUSdm05XwFXOmPQUAD2BXxYLjrnejerH89w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNo7Oo44DQhBKTLL3XcTWQDbfwLi8nU8FHI28I3GJKnSlGEBAdTnQYxWhgEXpa6yJ1rayzZ7E5Ij8LkNI+a0Hga3+ILH9uQIoqW6jUDkWPz9xxkOKrRABJmD/oav2iYELV27kGRPOhyfGWAa4a+ufZfOpu2pBOTIouBH4iAA9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CON4dxMZ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d41bb4da91so7883325ad.0;
        Fri, 19 Jan 2024 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687061; x=1706291861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzw6SdZaeK2jrAaH6d8PgXbdWYKC65awTrsEF5AqC90=;
        b=CON4dxMZa9fR2hZM3xSldFJWHWbfIz9JH9K9deEmJpj9ddigwYIRYLoCpReDwXll44
         ptrehbwCJBRapiKitaPrnXPwdfmltgioqWK23X5G2Rb89n23LUxTteheBjNWHDVYeaVr
         9jlL3D39+TNUZyYEj60SZ6XtrYwwS+jFLkkuWfJux5xJU4RDaKMuHuan8uZxVHHSY7TA
         ToHgIaVIUtqBn+KgupmLrggLJxOPexdQAzRhPM+LNzDzWxkAq6zOEFsbUILWDMPnAcB1
         xsPIWhJLJ49F6brwjtc4V8Dce/TyOWEsYKi/Vo61Y/rS+rLPQvIOrcUaDZ74HGQKfHq4
         zJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687061; x=1706291861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzw6SdZaeK2jrAaH6d8PgXbdWYKC65awTrsEF5AqC90=;
        b=mwkNUY8eWkO4YL2X5WvUnanh9g9hIYDD+lS0/00sW+L5nx0zKQOxf9hOeUp5zRJyDU
         h870yFwUM4pwl26M9dDRNi6CqmNqKiGQQT1i1F8ZLcORC3HXuFMpu4CHa5S1PGhBjVJf
         uqEQzU5gF314h5z1ZHErnrIE4KZfXkA97W2XlZz6/UZn3MjXMq6qrK7+9bnxV6QBWrrj
         2R7YQGjbXbn/++2wpWSc1CEluuy9sp/J7TEbURNlMQz7qZE2B/Y0rPtYeVYFClkLu2lr
         Qb/qhJDYIZy8ufKJgb/YQO1m1U8AWbBpwa3vA+sUsF5KMJA14l3fLD0zG1aR6ptqe53X
         ewiw==
X-Gm-Message-State: AOJu0Yzi6GcG5XMnoncm/RBFoI7I4L1Z85NieTHwCzBfg/vYzQamnedC
	dnK55YOeololZhunLFQ8inowglMgYTqRvhicA53jTZQJvlHcL6w=
X-Google-Smtp-Source: AGHT+IGsslwhQGAovuczoPu0gi+OrlhPxdslNLYVva2i5bayKK1+A7zarxdDbhWYspWcK5KCvgtn/A==
X-Received: by 2002:a17:90a:d80b:b0:28e:7baf:6fb5 with SMTP id a11-20020a17090ad80b00b0028e7baf6fb5mr129790pjv.64.1705687061109;
        Fri, 19 Jan 2024 09:57:41 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b002901ded7356sm4202670pjb.2.2024.01.19.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:57:40 -0800 (PST)
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
Subject: [PATCH v2 1/3] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Fri, 19 Jan 2024 12:57:28 -0500
Message-Id: <20240119175730.15484-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240119175730.15484-1-gregory.price@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
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
 ...fs-kernel-mm-mempolicy-weighted-interleave |  26 ++
 mm/mempolicy.c                                | 231 ++++++++++++++++++
 3 files changed, 261 insertions(+)
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
index 10a590ee1c89..ae925216798f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,16 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/*
+ * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
+ * system-default value should be used. Until system-defaults are implemented,
+ * the system-default is always 1.
+ *
+ * iw_table is RCU protected
+ */
+static u8 __rcu *iw_table;
+static DEFINE_MUTEX(iw_table_lock);
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3077,224 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
+	 * The default weight is 1 (for now), when the kernel-internal
+	 * default weight array is implemented, this should be updated to
+	 * collect the system-default weight of the node if the user passes 0.
+	 */
+	if (!weight)
+		weight = 1;
+
+	/* We only need to allocate up to the number of possible nodes */
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
+	u8 __rcu *old;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	rcu_assign_pointer(iw_table, NULL);
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	/* Never free the default table, it's always in use */
+	kfree(old);
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
+
+	/* A NULL iw_table is interpreted by interleave logic as "all 1s" */
+	iw_table = NULL;
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
+		pr_err("failed to add mempolicy kobject to the system\n");
+		return -ENOMEM;
+	}
+	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
+				   "mempolicy");
+	if (err) {
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
+	/* A NULL iw_table is interpreted by interleave logic as "all 1s" */
+	iw_table = NULL;
+	return 0;
+}
+
+static void __exit mempolicy_exit(void) { }
+#endif /* CONFIG_SYSFS */
+late_initcall(mempolicy_sysfs_init);
+module_exit(mempolicy_exit);
-- 
2.39.1


