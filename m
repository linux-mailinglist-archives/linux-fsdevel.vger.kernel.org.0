Return-Path: <linux-fsdevel+bounces-6007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA788121AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E841F21927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F27FBB9;
	Wed, 13 Dec 2023 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFawR2xm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC01E0;
	Wed, 13 Dec 2023 14:41:25 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5d6b9143782so68126677b3.0;
        Wed, 13 Dec 2023 14:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507284; x=1703112084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvF8XP3toqTj9OsWUmBPBjL8Vx7rS+7EittbCVzs1w4=;
        b=WFawR2xmJuz3IWOcfH/7O97+Q5IYFDwcmVcm/t3liFuYP5Xb4Av9TvlfAIdJMrHi9L
         /LGtZuJLNZLe4HB5NmrsginLg5sFJ03pwXt8qCBZndbXmnxy847aqzulGVmORK3umUh8
         6uZ081nb9J0crQFl0CyKBgWPWu8V4frgBgXLRyLa6OfonDS0Dg5ITc835zwjTIv6f7LG
         r0ojEE1hOEqkx+rLYbwXEF4H4EIsgEcsOsPlCydsWGXRZ/NLwCBRMv/xTssox0VfdAFc
         n1kn/gNKfMuyMKS81KXfc08RO4BAgUZl48jk0vizA5Qf/zQU97cUWgV3rjI5jM6l3KSS
         +YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507284; x=1703112084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvF8XP3toqTj9OsWUmBPBjL8Vx7rS+7EittbCVzs1w4=;
        b=EN/o21zPv0/PT32R9JV7ipqilyBX/WcWR5AskrtkQ6dXN9R4IVR3NHuYsIWP4hA2xY
         TYQQoCJ6yscDBy7jN6p0DeP2jM/MSzI+Wl26q28UiOW8Gt7EhpMgyZsGrHYfMmhzS8J9
         Jag3WgzfAsi25oWA/3+QiQIUYJwa9Cf6KML8HFF+GHqDEu+Vc/sFZmBHD/Fp3oNRhomG
         INM7dJLUhzNqhKZ4wEvq+8kLATifOvNF7tqY3TyjIg/WG/XSHHscZ2IXMy9zUMpqr7c8
         LtSrimaVzQvmcEX6fn7SzZYiwV0nB7lTgNlgGk4+jDIx+RJzbgHRdtYyZ4NkhwxgDMMu
         YhKw==
X-Gm-Message-State: AOJu0Yz0ewnnhI76eayafVDtmTi4VfZpjX+G87UzZCUHA8POb+oEMvaN
	k3HPFoY4fIRpvlxLniucMg==
X-Google-Smtp-Source: AGHT+IFlmStwxigHm34C0TZtRXyNvC2pOZtDqxjEvfnM76EBY13SftV96kVUouIoklqHelxIbJeuVA==
X-Received: by 2002:a81:8410:0:b0:5d7:1940:7d67 with SMTP id u16-20020a818410000000b005d719407d67mr7001727ywf.62.1702507283960;
        Wed, 13 Dec 2023 14:41:23 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:23 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
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
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v3 01/11] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Wed, 13 Dec 2023 17:41:08 -0500
Message-Id: <20231213224118.1949-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
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

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  22 +++
 mm/mempolicy.c                                | 143 ++++++++++++++++++
 3 files changed, 169 insertions(+)
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
index 000000000000..aa27fdf08c19
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,22 @@
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
+		Writing an empty string resets the weight value to 1.
+
+		Minimum weight: 1
+		Maximum weight: 255
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..5310021181ab 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,8 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+static char iw_table[MAX_NUMNODES];
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3069,144 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+struct iw_node_attr {
+	struct kobj_attribute kobj_attr;
+	int nid;
+};
+
+static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct iw_node_attr *node_attr;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	return sysfs_emit(buf, "%d\n", iw_table[node_attr->nid]);
+}
+
+static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct iw_node_attr *node_attr;
+	unsigned char weight = 0;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	/* If no input, set default weight to 1 */
+	if (count == 0 || sysfs_streq(buf, ""))
+		weight = 1;
+	else if (kstrtou8(buf, 0, &weight) || !weight)
+		return -EINVAL;
+
+	iw_table[node_attr->nid] = weight;
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
+static void sysfs_mempolicy_release(struct kobject *mempolicy_kobj)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++)
+		sysfs_wi_node_release(node_attrs[i], mempolicy_kobj);
+	kobject_put(mempolicy_kobj);
+}
+
+static const struct kobj_type mempolicy_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = sysfs_mempolicy_release,
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
+	sysfs_attr_init(&node_attr->attr);
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
+	err = kobject_init_and_add(wi_kobj, &mempolicy_ktype, root_kobj,
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
+static int __init mempolicy_sysfs_init(void)
+{
+	int err;
+	struct kobject *root_kobj;
+
+	memset(&iw_table, 1, sizeof(iw_table));
+
+	root_kobj = kobject_create_and_add("mempolicy", mm_kobj);
+	if (!root_kobj) {
+		pr_err("failed to add mempolicy kobject to the system\n");
+		return -ENOMEM;
+	}
+
+	err = add_weighted_interleave_group(root_kobj);
+
+	if (err)
+		kobject_put(root_kobj);
+	return err;
+
+}
+late_initcall(mempolicy_sysfs_init);
-- 
2.39.1


