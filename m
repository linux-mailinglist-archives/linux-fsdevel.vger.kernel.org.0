Return-Path: <linux-fsdevel+bounces-6415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A68817B2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6236F284A85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08F7346A;
	Mon, 18 Dec 2023 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUsczWxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600272066;
	Mon, 18 Dec 2023 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d39e2f1089so18976735ad.1;
        Mon, 18 Dec 2023 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928804; x=1703533604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDed0UIc9OzNQfDEhqciny76MTGnL2wnvbADB9nJS3M=;
        b=BUsczWxIRKTB/DYBHzhYtNwk83rJW0Am5y20X6UaV4Al4Ay5k05f6ILiPXu9ctI0IA
         +BO+/vYkalzkQlh3hZBLAJg1j4V9wxbx2siIAMA3FSfXUYsVpf5ml6VY9KyzmkUA+ga+
         Lke8HSQFAwF9bet+Cg7eCGb1EKlhR+Kxi/d49b16r4b+1Qd04TJ8JiPXl7aFW4NJz7gy
         xt418ZkqfnPMfdPWyGS+V6PjpYg9GRo4VEmGTIieRfSd0AbC9Pc6Gwff1E8Q/QSWAlWE
         NlraFjEJmKdnW3pE14IIk2WIB3mhPSRzDObXYsVA6qU0FHVokDkC5yZ/Z69Ky92g1b4+
         k0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928804; x=1703533604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDed0UIc9OzNQfDEhqciny76MTGnL2wnvbADB9nJS3M=;
        b=s0JbYif9DtCsbX5/XC4Hv/riDcAQwdvYQXDghou+IUS6SFYTlULMqP+seTaz+361Jh
         qrP+436ejEBBrmh4x8ek1rN04Pv1YmHDYfF+kG7/uEpLkM5i2TjSJ54gGx210t6HY0av
         7VBfqehqMXborf69KNepiM8SEuXIJov9aV4uslmsKNjammMeb2x8UCrWunZztkGWPjqX
         TkOiLAnzj5Dw5n9P5h7vILB3Jmh98JHSKrQxojrgeH8Nwmoi9zRHH+Jog5DtbPQpritc
         HrJL/p3keQPlwFeIz8yrIcWlQqDiKG+xQIDPG/McDJWeyLosAI6TKrfTUjRNXJDWXpzV
         v25A==
X-Gm-Message-State: AOJu0YyzCMFg01jSCiNd9+Avj8PKBIOgZmoKuUGHRCFIOuDljxnhYgmh
	PtTfwtEq0k2LbmfiwWbaPkIYKUPjpn8LuIE=
X-Google-Smtp-Source: AGHT+IFg3J8Dsv+P0eii5AMyUDNzVQXkAy+ScbpR0dK1IzX9SZNTNXOAML1PC5nJWGGmYFJ4t9e3sg==
X-Received: by 2002:a17:903:32c5:b0:1d0:a53e:2662 with SMTP id i5-20020a17090332c500b001d0a53e2662mr20372154plr.104.1702928803785;
        Mon, 18 Dec 2023 11:46:43 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:46:43 -0800 (PST)
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
Subject: [PATCH v4 01/11] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Mon, 18 Dec 2023 14:46:21 -0500
Message-Id: <20231218194631.21667-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
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

If sysfs is disabled in the config, the global interleave weights
will default to "1" for all nodes.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  22 +++
 mm/mempolicy.c                                | 156 ++++++++++++++++++
 3 files changed, 182 insertions(+)
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
index 10a590ee1c89..0e77633b07a5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,8 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+static char iw_table[MAX_NUMNODES];
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3069,157 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
+#else
+static int __init mempolicy_sysfs_init(void)
+{
+	/*
+	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
+	 * MPOL_INTERLEAVE behavior, but is still defined separately to
+	 * allow task-local weighted interleave to operate as intended.
+	 */
+	memset(&iw_table, 1, sizeof(iw_table));
+	return 0;
+}
+#endif /* CONFIG_SYSFS */
+late_initcall(mempolicy_sysfs_init);
-- 
2.39.1


