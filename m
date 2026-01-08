Return-Path: <linux-fsdevel+bounces-72932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4CD061F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C9443017C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF770330B0B;
	Thu,  8 Jan 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vc9olPry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A133066F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904725; cv=none; b=Vt+DEzR1MtQuPJjg2I9puALYVuRGxLjWnkxW53/82qg1HzocXO0mZhtF014tc7ZHbzLWaIiie0gXkT6rsaIkNunGlgwgnFCn7J79zrObH+v7Nw2swyoI7Pa3TWfOWmag63dKEF4XyVhlvporQMsjBlUDGWUElWP6d6MQS+iVtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904725; c=relaxed/simple;
	bh=CQhA3mC1HF2mDq9BwlheTKnKhYcNJHlD3RCOWwoDAu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A176W9ILGF+Fiw3v62M9VRdCSgAlyE8CEPoAzEPNdhqX2nm3Tbjm0s2Hmjd0qWjciuhR8fCh2lGIJEGnZONedGC/DU5/wbankm2Vnmh25Id5iaJBVVYpQf3VRxb+sJprHJuudf5waSl9jJgp4fH7J1YV7n1jEGCyr2/J1JERtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vc9olPry; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8bc53dae8c2so496704585a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904721; x=1768509521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOrL3864bJGfwtl8UioEmR5rhRGdyu2H2uXt3HWEC2Y=;
        b=Vc9olPryHSrK4DKO+GwbXZOMPYDfRm7YzoSfgtJe6rN6i8gfBNR9tTrqGNbcXaUFWd
         C9WEL29I5PIp0nOnrW802TWA3kNBNevF9AH3pNznfb4rmwzo+Bv+gQ96J3tYolmltk0o
         HlcrfHtIsggqzRY7iR5kYp3H6uMdTasBQJNqNKuGoQGDOWklzqB7ZZocvqtqCyloK2hA
         kHd2g7Xc6tGa++2wYYZB5rmd3E7H3re7TTKNWLluo1Z+xCNkptLtsv71k8UePjFzf95/
         g2VuHi6dj8VTYlzIGUcEOc1j01CasObHAsrgMFZR1EzcH17OxGSQGTgbWaTH+UestQc6
         gTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904721; x=1768509521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOrL3864bJGfwtl8UioEmR5rhRGdyu2H2uXt3HWEC2Y=;
        b=QAjSOC/npE6XbgE1c8BHmHxaCUlM/e19n1sUEA8YoeuRPwzv+HcjwhJVoxSaPygvU8
         y5nWRHr70OTbVlVaAcfiNvxxgzuGF3Abr+48fpLkjxS5zKvPZbJE3obcEUWyGewcFk/H
         8ediwryW4IX9HqYwsEmKWNhzhqlqYGnFdvB8OCuY+U+1OjxiYrlPppWKv3ZnQ8ApjA4L
         ucNzm20FTYPz8rj6DCbm/kiQI6VqD3yBzbxjHvlKx1zvcW5HG0oudoqn+ZMmKGqrqO6A
         D6PXBh5JX6pLrkpk7GFjVUB55Ue6/yOrF/4MORU0z8ohvk4RF1bUXKrntkZ2X/sUGSPX
         lypg==
X-Forwarded-Encrypted: i=1; AJvYcCXYUFZZ2zzUKSHtF3/VKTNEkplRAzPxpY2rYnujv4oc79jM9ZO7lRbqBCAUFQtJ5cr7KwhYMbSnStXoRbJM@vger.kernel.org
X-Gm-Message-State: AOJu0YxemM40sQ4Npep6QN2z68AR4HSZa9DTjQPr/yYa943t4EYUyN/d
	1iRLNcXrwH3PkItssbpBYpwlgOAw9VKik6ZXkUi1A2++sZXoz+OUMJ4huTaQCZmpLUs=
X-Gm-Gg: AY/fxX7nrT35q+5RpWTYbiP7ZFfgZpwpbEiMo0/Yudbva0zDywMxUncNBO59fQ7sZwd
	6ovM/Kz26PKE1LLmqLx3h9Cd7S9uOmS9hYwClf6c21w1IyZ/yb4pWDgT7VJeXvEcszdwpKrgRyh
	OG0vFsDSQlGdl0Xjx0V7hPZ2f4Ei70lYGRVwuq2HX3u05xUwPx/lnaSXDqtOdc6DSrvmvJcw6jM
	2P4LRBMkKmJpqw61xJeGX0+5p75nDK9D6pQWHumuiY6yEYBeCt26w9ZFt4HsNt+USj4txGlkC/P
	GzkQVvWqUvDTZJOSa9K+7yXUePXjJfWfwvnaziYF4vqM7r+KNIrrBpHh+oDPNRn3fjNg8AFB2NN
	j1tnbmiMwVjEQ/eb08qGvh1i9L3odStO8eb0p44J4Jc+DlHUQRMuEbzFij588G7RfTRyg8y7DAN
	t0t7GgUTDrPUt0+i+3ov1+kRRombzMBwN1iu6jN6ARb6ShFxThgxV3gdGQWeGxXGPGdymVl2e/R
	xs=
X-Google-Smtp-Source: AGHT+IErusoCASFUMJ5xblQXCL2hFphAjRCx8AogbVf/OleyczW51nyjXSqkJjk86aDTspqXYukd7w==
X-Received: by 2002:a05:620a:6ccd:b0:8b2:e17a:37 with SMTP id af79cd13be357-8c3893f239bmr1013342785a.43.1767904720528;
        Thu, 08 Jan 2026 12:38:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:40 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [RFC PATCH v3 1/8] numa,memory_hotplug: create N_PRIVATE (Private Nodes)
Date: Thu,  8 Jan 2026 15:37:48 -0500
Message-ID: <20260108203755.1163107-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

N_MEMORY nodes are intended to contain general System RAM.  Today, some
device drivers hotplug their memory (marked Specific Purpose or Reserved)
to get access to mm/ services, but don't intend it for general consumption.

This creates reliability issues as there are no isolation guarantees.

Create N_PRIVATE for memory nodes whose memory is not intended for
general consumption.  This state is mutually exclusive with N_MEMORY.

This will allow existing service code (like page_alloc.c) to manage
N_PRIVATE nodes without exposing N_MEMORY users to that memory.

Add `node_mark_private()` for device drivers to call to mark a node
as private prior to hotplugging memory.  This fails if the node is
already online or already has N_MEMORY.

Private nodes must have a memory types so that multiple drivers
trying to online private memory onto the same node are warned
when a conflict occurs.

Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c      | 199 +++++++++++++++++++++++++++++++++++++++
 include/linux/node.h     |  60 ++++++++++++
 include/linux/nodemask.h |   1 +
 mm/memory_hotplug.c      |   2 +-
 4 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 00cf4532f121..b503782ea109 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -861,6 +861,193 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 			   (void *)&nid, register_mem_block_under_node_hotplug);
 	return;
 }
+
+static enum private_memtype *private_nodes;
+/* Per-node list of private node operations callbacks */
+static struct list_head private_node_ops_list[MAX_NUMNODES];
+static DEFINE_MUTEX(private_node_ops_lock);
+static bool private_node_ops_initialized;
+
+/*
+ * Note: private_node_ops_list is initialized in node_dev_init() before
+ * any calls to node_register_private() can occur.
+ */
+
+/**
+ * node_register_private - Mark a node as private and register ops
+ * @nid: Node identifier
+ * @ops: Callback operations structure (required, but callbacks may be NULL)
+ *
+ * Mark a node as private and register the given ops structure. The ops
+ * structure must have res_start and res_end set to the physical address
+ * range covered by this registration, and memtype set to the private
+ * memory type. Multiple registrations for the same node are allowed as
+ * long as they have the same memtype.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int node_register_private(int nid, struct private_node_ops *ops)
+{
+	int rc = 0;
+	enum private_memtype ctype;
+	enum private_memtype type;
+
+	if (!ops)
+		return -EINVAL;
+
+	type = ops->memtype;
+
+	if (!node_possible(nid) || !private_nodes || type >= NODE_MAX_MEMTYPE)
+		return -EINVAL;
+
+	/* Validate resource bounds */
+	if (ops->res_start > ops->res_end)
+		return -EINVAL;
+
+	mutex_lock(&private_node_ops_lock);
+
+	/* hotplug lock must be held while checking online/node state */
+	mem_hotplug_begin();
+
+	/*
+	 * N_PRIVATE and N_MEMORY are mutually exclusive. Fail if the node
+	 * already has N_MEMORY set, regardless of online state.
+	 */
+	if (node_state(nid, N_MEMORY)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	ctype = private_nodes[nid];
+	if (ctype > NODE_MEM_NOTYPE && ctype != type) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* Initialize the ops list entry and add to the node's list */
+	INIT_LIST_HEAD(&ops->list);
+	list_add_tail_rcu(&ops->list, &private_node_ops_list[nid]);
+
+	private_nodes[nid] = type;
+	node_set_state(nid, N_PRIVATE);
+out:
+	mem_hotplug_done();
+	mutex_unlock(&private_node_ops_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(node_register_private);
+
+/**
+ * node_unregister_private - Unregister ops and potentially unmark node as private
+ * @nid: Node identifier
+ * @ops: Callback operations structure to remove
+ *
+ * Remove the given ops structure from the node's ops list. If this is
+ * the last ops structure for the node and the node is offline, the
+ * node is unmarked as private.
+ */
+void node_unregister_private(int nid, struct private_node_ops *ops)
+{
+	if (!node_possible(nid) || !private_nodes || !ops)
+		return;
+
+	mutex_lock(&private_node_ops_lock);
+	mem_hotplug_begin();
+
+	list_del_rcu(&ops->list);
+	/* If list is now empty, clear private state */
+	if (list_empty(&private_node_ops_list[nid])) {
+		private_nodes[nid] = NODE_MEM_NOTYPE;
+		node_clear_state(nid, N_PRIVATE);
+	}
+
+	mem_hotplug_done();
+	mutex_unlock(&private_node_ops_lock);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(node_unregister_private);
+
+/**
+ * node_private_allocated - Validate a page allocation from a private node
+ * @page: The allocated page
+ *
+ * Find the ops structure whose region contains the page's physical address
+ * and call its page_allocated callback if one is registered.
+ *
+ * Returns:
+ *   0 if the callback succeeds or no callback is registered for this region
+ *   -ENXIO if the page is not found in any registered region
+ *   Other negative error code if the callback indicates the page is not safe
+ */
+int node_private_allocated(struct page *page)
+{
+	struct private_node_ops *ops;
+	phys_addr_t page_phys;
+	int nid = page_to_nid(page);
+	int ret = -ENXIO;
+
+	if (!node_possible(nid) || nid >= MAX_NUMNODES)
+		return -ENXIO;
+
+	if (!private_node_ops_initialized)
+		return -ENXIO;
+
+	page_phys = page_to_phys(page);
+
+	/*
+	 * Use RCU to safely traverse the list without holding locks.
+	 * Writers use list_add_tail_rcu/list_del_rcu with synchronize_rcu()
+	 * to ensure safe concurrent access.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &private_node_ops_list[nid], list) {
+		if (page_phys >= ops->res_start && page_phys <= ops->res_end) {
+			if (ops->page_allocated)
+				ret = ops->page_allocated(page, ops->data);
+			else
+				ret = 0;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_private_allocated);
+
+/**
+ * node_private_freed - Notify that a page from a private node is being freed
+ * @page: The page being freed
+ *
+ * Find the ops structure whose region contains the page's physical address
+ * and call its page_freed callback if one is registered.
+ */
+void node_private_freed(struct page *page)
+{
+	struct private_node_ops *ops;
+	phys_addr_t page_phys;
+	int nid = page_to_nid(page);
+
+	if (!node_possible(nid) || nid >= MAX_NUMNODES)
+		return;
+
+	if (!private_node_ops_initialized)
+		return;
+
+	page_phys = page_to_phys(page);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &private_node_ops_list[nid], list) {
+		if (page_phys >= ops->res_start && page_phys <= ops->res_end) {
+			if (ops->page_freed)
+				ops->page_freed(page, ops->data);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(node_private_freed);
+
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 /**
@@ -959,6 +1146,7 @@ static struct node_attr node_state_attr[] = {
 	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
+	[N_PRIVATE] = _NODE_ATTR(has_private_memory, N_PRIVATE),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
@@ -972,6 +1160,7 @@ static struct attribute *node_state_attrs[] = {
 	&node_state_attr[N_HIGH_MEMORY].attr.attr,
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
+	&node_state_attr[N_PRIVATE].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
 	NULL
@@ -1007,5 +1196,15 @@ void __init node_dev_init(void)
 			panic("%s() failed to add node: %d\n", __func__, ret);
 	}
 
+	private_nodes = kzalloc(sizeof(enum private_memtype) * MAX_NUMNODES,
+				GFP_KERNEL);
+	if (!private_nodes)
+		pr_warn("Failed to allocate private_nodes, private node support disabled\n");
+
+	/* Initialize private node ops lists */
+	for (i = 0; i < MAX_NUMNODES; i++)
+		INIT_LIST_HEAD(&private_node_ops_list[i]);
+	private_node_ops_initialized = true;
+
 	register_memory_blocks_under_nodes();
 }
diff --git a/include/linux/node.h b/include/linux/node.h
index 0269b064ba65..53a9fb63b60e 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -62,6 +62,47 @@ enum cache_mode {
 	NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR,
 };
 
+enum private_memtype {
+	NODE_MEM_NOTYPE,
+	NODE_MEM_ZSWAP,
+	NODE_MEM_COMPRESSED,
+	NODE_MEM_ACCELERATOR,
+	NODE_MEM_DEMOTE_ONLY,
+	NODE_MAX_MEMTYPE,
+};
+
+/**
+ * struct private_node_ops - Callbacks for private node operations
+ * @list: List node for per-node ops list
+ * @res_start: Start physical address of the memory region
+ * @res_end: End physical address of the memory region (inclusive)
+ * @memtype: Private node memory type for this region
+ * @page_allocated: Called after a page is allocated from this region
+ *                  to validate that the page is safe to use. Returns 0
+ *                  on success, negative error code on failure. If this
+ *                  returns an error, the caller should free the page
+ *                  and try another node. May be NULL if no validation
+ *                  is needed.
+ * @page_freed: Called when a page from this region is being freed.
+ *              Allows the driver to update its internal tracking.
+ *              May be NULL if no notification is needed.
+ * @data: Driver-private data passed to callbacks
+ *
+ * Multiple drivers may register ops for a single private node. Each
+ * registration covers a specific physical memory region. When a page
+ * is allocated, the appropriate ops structure is found by matching
+ * the page's physical address against the registered regions.
+ */
+struct private_node_ops {
+	struct list_head list;
+	resource_size_t res_start;
+	resource_size_t res_end;
+	enum private_memtype memtype;
+	int (*page_allocated)(struct page *page, void *data);
+	void (*page_freed)(struct page *page, void *data);
+	void *data;
+};
+
 /**
  * struct node_cache_attrs - system memory caching attributes
  *
@@ -121,6 +162,10 @@ extern struct node *node_devices[];
 #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
 void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 					       unsigned long end_pfn);
+int node_register_private(int nid, struct private_node_ops *ops);
+void node_unregister_private(int nid, struct private_node_ops *ops);
+int node_private_allocated(struct page *page);
+void node_private_freed(struct page *page);
 #else
 static inline void register_memory_blocks_under_node_hotplug(int nid,
 							     unsigned long start_pfn,
@@ -130,6 +175,21 @@ static inline void register_memory_blocks_under_node_hotplug(int nid,
 static inline void register_memory_blocks_under_nodes(void)
 {
 }
+static inline int node_register_private(int nid, struct private_node_ops *ops)
+{
+	return -ENODEV;
+}
+static inline void node_unregister_private(int nid,
+					   struct private_node_ops *ops)
+{
+}
+static inline int node_private_allocated(struct page *page)
+{
+	return -ENXIO;
+}
+static inline void node_private_freed(struct page *page)
+{
+}
 #endif
 
 struct node_notify {
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index bd38648c998d..dac250c6f1a9 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -391,6 +391,7 @@ enum node_states {
 	N_HIGH_MEMORY = N_NORMAL_MEMORY,
 #endif
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
+	N_PRIVATE,		/* The node's memory is private */
 	N_CPU,		/* The node has one or more cpus */
 	N_GENERIC_INITIATOR,	/* The node has one or more Generic Initiators */
 	NR_NODE_STATES
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 389989a28abe..57463fcb4021 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1207,7 +1207,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	if (node_arg.nid >= 0)
+	if (node_arg.nid >= 0 && !node_state(nid, N_PRIVATE))
 		node_set_state(nid, N_MEMORY);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
-- 
2.52.0


