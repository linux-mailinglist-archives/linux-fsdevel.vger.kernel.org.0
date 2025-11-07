Return-Path: <linux-fsdevel+bounces-67511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E64C41E51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0194F3C10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C2336ED5;
	Fri,  7 Nov 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e6hAHDYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1B322C99
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555826; cv=none; b=aP4hjnIdWF2Zvtk96lrZX82fBpadhT763PNHluq8KRWsOeNglPH2Gu6ut9uIGq0B2BkGxS0gCzAMpQ9mSu5p1k7jEetMEksMZAPua/nLpa/0ilKlIVCwH9hTZPgJlRbDFRLu/SRQeI2rTsEeyb1mbkMGVk9eY/yVtw+RBCEMvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555826; c=relaxed/simple;
	bh=aVCsq29TRfkUneUg7VcXHP54fL2RXfk+IKU2j2Nc0iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFJq0qwwUrFRsBLsQe1oPR8soCeXN/8BvHsfbew3XDzMDYIZDpT9np7x1jJV1gfEwUu++98MjzvZftvSBaVtmagSCCkD4RtLhhXYVh1y6FZSRRsVMwyiASl58Uj9JCaM5FifMryiPYFrNiN0RrJApPhfX2Hhgc5qP5c41IP5DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e6hAHDYb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed917b5b18so12997141cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555822; x=1763160622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THbr/Y85WnAbuULOZYzy4wMGCXZ829d22z7gMjfvDN0=;
        b=e6hAHDYbggGHZBmB7mlRbzfSodbsoab5X40BEKEdAZvtChHGvKVRcvsW5cBVzpmC9x
         OZ5p3FN0XBihQtUZjxEnRfyP3CFOmBDiMqevLId7SOIRZJOYBxCMnOqG9pfQqvUHcNQz
         LALKEXIIu3Rdrq6orTaIUizrjCrPbUVJM5DMPIJzAexPDeD1DpH080r5glEhUBRVhai0
         O1wndC7SXAr0bJb6OVH5PHJuzBos3O7+uxHK+zct1Unv6Ip5yTEJJSsUhWkwXaUVp6VZ
         vpHU0n9xzukHCYQaUBpYna1FRNPmN7Vwu7ZP3iNP+Uz+S6srFH9d6g7cc4VSxBWlwkYL
         Nrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555822; x=1763160622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THbr/Y85WnAbuULOZYzy4wMGCXZ829d22z7gMjfvDN0=;
        b=jTziMT5HasrbCx/zZq0GyLRmcoUrqFnba4rRIiTGDcbL0TNKeQjGlvGPDcl6stQON8
         /FgoWs1wDFkB21sPjPISdD17f7QbWOudZvuB+Ax+e2tCGJe2+fdtoR0lF07ZId1tIkC7
         mFaXQeAdwf5s6QwyA+RMA1jzdnTx9nUZ5SYOamtK404LQLAlMjmrkPTiFcn1vbdymThC
         l+w8y7yXh6pFR50YNZYfbcZmPGpaquC/Z1cfbPtfgxxiuLwfYyritjhzc3guq4vz9DIs
         N1LE/qLQw5vgHd7jD4q2FiGZftKaAnSSZU6CTw86ZbJCXPBxqGf14MGCdZ785BYQNABg
         7hjw==
X-Forwarded-Encrypted: i=1; AJvYcCXgXtPKQiCFCHUzfAgskmJGivKUgtoAUjXvcOsTeencjYKZURuY9Z8KgPu7pOPk9PMyzhIMw7ERl1gNMyqw@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/M0JOD00tyjqMmaUU0HCj1r5Bpvp5kXd1H9owvJH1zqGIznV
	AZWyPaFRIc6DOljOj2H9vLOPhsDLMZY5TSmilYwNiJ0AOEjn5EvsTE8XLSYWp2u983w=
X-Gm-Gg: ASbGncubE0hvcfArmqhCiGG0YOgVVewCN779uvHZq8SPACnDbkRjRf8isYICzr2rtV7
	6bf0TnArbT8qNhtaa7y07deSpn+ZE+uSmuWMBFxVNa5gYBTaVR1vzeGXycQp+JFNiix60NVBlkV
	6z35B7etMrteVKyySlVIxvDiefIbMpMiGXP0lO6UYA5ReuA/78dJAun08gbVzol/HVPslnIjTNU
	LmBIy5esdQ3Dw1vcX0WDB4SO3lS+cnQq79+tegENIsX3UPoajZ2Tl3iZXOb0erzMui04S7pxFdj
	vOgiqW7H2mYSZxY5JYs0PjFsAHi+M+xNtvQbkrAartwcD5pYoL3kEJ4kEB9NsSDbveuFb8KpDdd
	P9AFaq7A2n030H1svg+D2b4F4UwzXggInQOejbax+p2WJTF3g22+MjVGkisGPfjUhuloFobU5W5
	yHCj/UrJ21tVJ1skcZ6dVYIXrltFhFmjiu7QP7SKu8yUEtfZoE3H1DgYUc13jbIOqpncOtK8pFL
	XOigd2YYpa9fg==
X-Google-Smtp-Source: AGHT+IFWQljTxYPO6CFPNauC805q+VElYGBru+/DO5QGOLDAxl11WHp9VZk3rhHcoNcRJaJ5IM73qw==
X-Received: by 2002:a05:622a:386:b0:4ec:a564:3e66 with SMTP id d75a77b69052e-4eda4ec8aa5mr11288381cf.29.1762555821864;
        Fri, 07 Nov 2025 14:50:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:21 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH 6/9] mm/memory_hotplug: add MHP_PROTECTED_MEMORY flag
Date: Fri,  7 Nov 2025 17:49:51 -0500
Message-ID: <20251107224956.477056-7-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for protected memory blocks/nodes, which signal to
memory_hotplug that a given memory block is considered "protected".

A protected memory block/node is not exposed as SystemRAM by default
via default_sysram_nodes.  Protected memory cannot be added to sysram
nodes, and non-protected memory cannot be added to protected nodes.

This enables these memory blocks to be protected from allocation by
general actions (page faults, demotion, etc) without explicit
integration points which are memory-tier aware.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 23f038a16231..89f4e5b7054d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -74,6 +74,16 @@ typedef int __bitwise mhp_t;
  * helpful in low-memory situations.
  */
 #define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
+/*
+ * The hotplugged memory can only be added to a NUMA node which is
+ * not in default_sysram_nodes.  This prevents the node from be accessible
+ * by the page allocator (mm/page_alloc.c) by way of userland configuration.
+ *
+ * Attempting to hotplug protected memory into a node in default_sysram_nodes
+ * will result in an -EINVAL, and attempting to hotplug non-protected memory
+ * into protected memory node will also result in an -EINVAL.
+ */
+#define MHP_PROTECTED_MEMORY	((__force mhp_t)BIT(4))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..ceab56b7231d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -20,6 +20,7 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -1506,6 +1507,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	struct memory_group *group = NULL;
 	u64 start, size;
 	bool new_node = false;
+	bool node_has_blocks, protected_mem, node_is_sysram;
 	int ret;
 
 	start = res->start;
@@ -1529,6 +1531,19 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
+	/*
+	 * If the NUMA node already has memory blocks, then we can only allow
+	 * additional memory blocks of the same protection type (protected or
+	 * un-protected).  Online/offline does not matter at this point.
+	 */
+	node_has_blocks = node_has_memory_blocks(nid);
+	protected_mem = !!(mhp_flags & MHP_PROTECTED_MEMORY);
+	node_is_sysram = node_isset(nid, *default_sysram_nodes);
+	if (node_has_blocks && (protected_mem ^ node_is_sysram)) {
+		ret = -EINVAL;
+		goto error_mem_hotplug_end;
+	}
+
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 			memblock_flags = MEMBLOCK_DRIVER_MANAGED;
@@ -1574,6 +1589,10 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	register_memory_blocks_under_node_hotplug(nid, PFN_DOWN(start),
 					  PFN_UP(start + size - 1));
 
+	/* At this point if not protected, we can add node to sysram nodes */
+	if (!(mhp_flags & MHP_PROTECTED_MEMORY))
+		node_set(nid, *default_sysram_nodes);
+
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
 		firmware_map_add_hotplug(start, start + size, "System RAM");
@@ -2274,6 +2293,10 @@ static int try_remove_memory(u64 start, u64 size)
 	if (nid != NUMA_NO_NODE)
 		try_offline_node(nid);
 
+	/* If no more memblocks, remove node from default sysram nodemask */
+	if (!node_has_memory_blocks(nid))
+		node_clear(nid, *default_sysram_nodes);
+
 	mem_hotplug_done();
 	return 0;
 }
-- 
2.51.1


