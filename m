Return-Path: <linux-fsdevel+bounces-5397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D480B273
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BF81C2093E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1655397;
	Sat,  9 Dec 2023 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqB/lZxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C7710D2;
	Fri,  8 Dec 2023 22:59:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-77f42ee9370so125918685a.2;
        Fri, 08 Dec 2023 22:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105177; x=1702709977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9scieKANHFB2osmlAGqD3i5GhIYjTl8+rxMCO4yMPo=;
        b=WqB/lZxgMBZe+65Tn/ibAnVmwGNn+eJLQ8WWk+8tH73ug0EYSHLsblm0dj9hzSc1u6
         /XIRRWuHdvyKcj7d7spjG4z9a6LvlHhMS/HG1wKW7ysqtnWJetJMVnupi51bU3qRmq8R
         uawlwXP7qJ/We8Dx4sMkUuA+Xzio0FOVljILLKtQR4yR7AlZfmtlp2hQ9TWWhLZSXfDL
         xyO0Cg4JsTWjkDNEnnWY5v3ZDjwKe1azw75xX6yBjL7x/9XMbkUZdI5jfY3yEK/oMlnK
         gDoNRTwyE6BPqx5haUO4fEsY1+hyWOcDtR1d9Wpm9OOvB9muqHDRfEt/UDmZWOFgsqNt
         EfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105177; x=1702709977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9scieKANHFB2osmlAGqD3i5GhIYjTl8+rxMCO4yMPo=;
        b=YKAysHDCp9naYF9F2dF7xbALFMq07+qZK3jG0rdxh9ynSxM/69j7G/kYqHxaBVSXcP
         awuPJPS6NtfbpzbWOU7uwfMZB0SQd5GRtBzhN6JEXuttm5ojfCRIKydIcZWY9sVFFMZk
         ifm9/TFEurL38nQXddvXlHYDL2x3HGxFge6C0ETjrbUGzAH9VZMf8ZgGkH+K6mKJLOa2
         gwhSRIC04wkCv8QQ7xn+rboCQuQ8xKZdjw915OETcAOq+nIkGblboXh6ltocCo6uCnt6
         OUEhbueOyXpNXOjq282UG8hjd5x4lRVZKyEBz10bSr2MBbnOrCBOlSUqlI2Dw2YguKEt
         2edw==
X-Gm-Message-State: AOJu0YwfT2iS86Nu1EJufGdFaVpVqbH7QMy+slkjgVPFPzGybXCmsbTO
	udrXYHPP4o/uIcv6nRK/EA==
X-Google-Smtp-Source: AGHT+IEMklhaVvDfru0A2OrhwoGRMDlqDnscWVBTkeMqKEPA0LfTH+HpFOYp2+eTKbuQszOpQv6Gtg==
X-Received: by 2002:a05:620a:22f5:b0:77e:fba4:39fc with SMTP id p21-20020a05620a22f500b0077efba439fcmr1321966qki.82.1702105176994;
        Fri, 08 Dec 2023 22:59:36 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.22.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:59:36 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
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
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v2 01/11] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Sat,  9 Dec 2023 01:59:21 -0500
Message-Id: <20231209065931.3458-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
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
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN/weight

The sysfs structure is designed as follows.

  $ tree /sys/kernel/mm/mempolicy/
  /sys/kernel/mm/mempolicy/ [1]
  ├── possible_nodes [2]
  └── weighted_interleave [3]
      ├── node0 [4]
      │   └── weight [5]
      └── node1
          └── weight

Each file above can be explained as follows.

[1] mm/mempolicy: configuration interface for mempolicy subsystem

[2] possible_nodes: list of possible nodes

    informational interface which may be used across multiple memory
    policy configurations.  Lists the `possible` nodes for which
    configurations may be required.  A `possible` node is one which has
    been reserved by the kernel at boot, but may or may not be online.

    For example, the weighted_interleave policy generates a nodeN/
    folder for possible node N.

[3] weighted_interleave/: config interface for weighted interleave policy

[4] weighted_interleave/nodeN/:  possible node configurations

[5] weighted_interleave/nodeN/weight: weight for nodeN

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |  18 ++
 ...fs-kernel-mm-mempolicy-weighted-interleave |  21 +++
 mm/mempolicy.c                                | 169 ++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
new file mode 100644
index 000000000000..445377dfd232
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
@@ -0,0 +1,18 @@
+What:		/sys/kernel/mm/mempolicy/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for Mempolicy
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
index 000000000000..7c19a606725f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,21 @@
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration Interface for the Weighted Interleave policy
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/
+		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/weight
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
+		Minimum weight: 1
+		Maximum weight: 255
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..28dfae195beb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,8 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+static char iw_table[MAX_NUMNODES];
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3069,170 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+struct iw_node_info {
+	struct kobject kobj;
+	int nid;
+};
+
+static ssize_t node_weight_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct iw_node_info *node_info = container_of(kobj, struct iw_node_info,
+						      kobj);
+	return sysfs_emit(buf, "%d\n", iw_table[node_info->nid]);
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
+	iw_table[node_info->nid] = weight;
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
+static int add_weight_node(int nid, struct kobject *src_kobj)
+{
+	struct iw_node_info *node_info = NULL;
+	int ret;
+
+	node_info = kzalloc(sizeof(struct iw_node_info), GFP_KERNEL);
+	if (!node_info)
+		return -ENOMEM;
+	node_info->nid = nid;
+
+	kobject_init(&node_info->kobj, &dst_node_kobj_ktype);
+	ret = kobject_add(&node_info->kobj, src_kobj, "node%d", nid);
+	if (ret) {
+		pr_err("kobject_add error [node%d]: %d", nid, ret);
+		kobject_put(&node_info->kobj);
+	}
+	return ret;
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
+
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
+static struct kobj_attribute possible_nodes_attr = __ATTR_RO(possible_nodes);
+
+static struct attribute *mempolicy_attrs[] = {
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
+}
+
+static const struct kobj_type mempolicy_kobj_ktype = {
+	.release = mempolicy_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static int __init mempolicy_sysfs_init(void)
+{
+	int err;
+	struct kobject *root_kobj;
+
+	memset(&iw_table, 1, sizeof(iw_table));
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


