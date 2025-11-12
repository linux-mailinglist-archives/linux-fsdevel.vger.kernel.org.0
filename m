Return-Path: <linux-fsdevel+bounces-68094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEFC5431E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D7F3BA514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25951352FB8;
	Wed, 12 Nov 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pmyCQB+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0E352F8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975815; cv=none; b=ZU2OIMyPMc54QBx0zm1AbsWa5mmd66eZd7gkVGhkQYAkxY6qR+OolV3KCI/4ueVrEU9wIqaHi7xLR4VCXmaqx7OvrHA5Gupr9J5o1DSTfsZmhw6AE2aYrcqBy3YRU4Okfy410az95tQwILdAYccuiuxCEBdG+FvH9kCKlIFNkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975815; c=relaxed/simple;
	bh=CCv29ioHuBPEaztDjypCZpSL1ZEuoaIx0rBLzpHAvqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbKS6vqUCK1hHbuV/L6g1gs6LaQkDoQWgAfhztGeF/psfBmwNS5Dd/Mm85m9OeZKVhL4MqmrDs0XXNsY2oBJHXgx9kwsNvYzzLCozZND8peAQsiRFv16Pj7gKONui4AoD4Qhqk5SInbP3AnSVYj1uETk8Kk60VF/B2CVfb4S338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pmyCQB+I; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2a4b6876fso4360285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975812; x=1763580612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmy6EhUdgU0DNpQaVrJpBZ6lZ48+dr4nIpOCH6X0C1w=;
        b=pmyCQB+Ik15ItccoSBlwNS2FTNxFwsEeYFliMScoNTWXSxdC20VqNEKlWbBuJlgbK+
         bmjs5VcEGpJJvAWqhlzgvX55be1Dn5/UL47vanr9YF292sJ+5lpDVdNRvc4Y896vrVQf
         rJemvkqVbEc8WLvoRCYiXRHMj+ET6hG883YJaus4EOTukTQK5NWRNrxjAPqdb2/3uk7d
         XZKgkbAmyJhRDF+eJ78sUGWdLtjnNW/VFMXNlpxnrhgX21V4/u+c+Q8hiTgI1XRwOyzH
         B8A5bVfGZvq3U6zj/6eT8Hksw8be2UolaWSddsTRHPxNTyejpLooxk8DsYhO21SB0/60
         8C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975812; x=1763580612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmy6EhUdgU0DNpQaVrJpBZ6lZ48+dr4nIpOCH6X0C1w=;
        b=xJo1BMga6t7mHCrUGmkDzCSCAyl/xo50YL6yK7Vg+BueYRKgh/n5Vyfp8+uAljeqZG
         LvVEqWJBLfEF2h1jwobkGx6ZXdrtzw6gWootRAnVeyg8rZMqnqfDQqK1+fNc+iuh1Ufx
         ELfzjTG+zs+Rza6g2mtYnAhjcRgvOe6Pi2vhw2UUoECpslQzyxAhTZww8W6OscHdm5GN
         fdv0y1DJKKVAz71pgav/ItfLjap5a+0MgTjxB9BiBJFkJeqP3x6V4svGEdYB+kHxfqq8
         kMfyeLCSU3lhPu5pnAFzkLyJ6lu9qIo2i4snOYcqNbewmIdJ3eF680fsmYiNq3p4etVP
         W82A==
X-Forwarded-Encrypted: i=1; AJvYcCW2A+02Rz78K7d4OJRaGd+f6ENoPeVPT9u1EbStkP8hU7LgrpyDeIbETo6CUWm0F2AeJGpSEGybCt23fDZD@vger.kernel.org
X-Gm-Message-State: AOJu0YxATcGVcOJHfD9eOQXO6gAVCJMougEEp1Rhs44ZQ0/Vn5bNO1IS
	bFt5vj9hqpuvCJlqmCYcsREnTyaavQu0xYVGj4imOowCiE/rm5BpNBpPv3PfrYJZfqU=
X-Gm-Gg: ASbGncv8x4bGItXy5lR4mpq7Yufvl2ncnwR0XGYzP63gqJAqQjZEKRGm/sGluPmtrBb
	up06VNEASSW9QZwxpFKBMwW5JXqDrVAf94Ofxavu0HjQq+JTn5Wu4q/J4EjjP+8hz+T3lo087Bq
	2lQQw0yCCcc8mLuN04bLhTDcsR1pR9hiWo5h2ClojLDFNCAaa71ZiiGt6YsmnUneyQcVXtQtLqP
	iying7qSarxu9LfTX5UoS0QYBCk9OXO5AGCn/xZOMJcgSozrUSXH0qovyUjkyRsBKc8NgbGEZuR
	TAJjfBLPQxfxxt9bqch4zjIPXxcrQYj8Z5OYVFegU8ikpBJF1gOdx3I4AKv7NaOaQkm4dRLmTVb
	3Ljcvumwb2WUXzl35XtuB0eKmvX3iCrW5zki7CYctR38i7w+vovKuOmLMAubjP1Aq56AqhZDw1M
	ejOyrJNPlFbJipae2uWtTlR+fn0ticKTssIc6RiJniGbibdna0NFifH3lMWVoC1d42
X-Google-Smtp-Source: AGHT+IHrguqekTBYRBdFA9dxH70A9CcZsL7BjLOY758kp78A0w22ToZorWvEFBPVQ4lklZwp+U9JIA==
X-Received: by 2002:a05:620a:29ca:b0:8a3:d644:6944 with SMTP id af79cd13be357-8b29b74d7c0mr602392885a.5.1762975812194;
        Wed, 12 Nov 2025 11:30:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:11 -0800 (PST)
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
Subject: [RFC PATCH v2 08/11] mm/memory_hotplug: add MHP_SPM_NODE flag
Date: Wed, 12 Nov 2025 14:29:24 -0500
Message-ID: <20251112192936.2574429-9-gourry@gourry.net>
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

Add support for Specific Purpose Memory (SPM) NUMA nodes.

A SPM node is managed by the page allocator, but can only allocated
by using the __GFP_SP_NODE flag with an appropriate nodemask.

Check/Set the node type (SysRAM vs SPM) at hotplug time.
Disallow SPM from being added to SysRAM nodes and vice-versa.

This prevents normal allocation paths (page faults, kmalloc, etc)
from being directly exposed to these memories, and provides a clear
integration point for buddy-allocation of SPM memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 23f038a16231..a50c467951ba 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -74,6 +74,16 @@ typedef int __bitwise mhp_t;
  * helpful in low-memory situations.
  */
 #define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
+/*
+ * The hotplugged memory can only be added to a "Specific Purpose Memory"
+ * NUMA node.  SPM Nodes are not generally accessible by the page allocator
+ * by way of userland configuration - as most nodemask interfaces
+ * (mempolicy, cpusets) restrict nodes to SysRAM nodes.
+ *
+ * Hotplugging SPM into a SysRAM Node results in -EINVAL.
+ * Hotplugging SysRAM into a SPM Node results in -EINVAL.
+ */
+#define MHP_SPM_NODE	((__force mhp_t)BIT(4))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..488cdd8e5f6f 100644
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
@@ -1529,6 +1530,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
+	/* Set the NUMA node type and bail out if the type is wrong */
+	ret = mt_set_node_type(nid, (mhp_flags & MHP_SPM_NODE) ?
+				    MT_NODE_TYPE_SPM : MT_NODE_TYPE_SYSRAM);
+	if (ret)
+		goto error_mem_hotplug_end;
+
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 			memblock_flags = MEMBLOCK_DRIVER_MANAGED;
-- 
2.51.1


