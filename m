Return-Path: <linux-fsdevel+bounces-68089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EAC5439F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1AF84F783A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C05351FA9;
	Wed, 12 Nov 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aTwvNscC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5A34D38F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975799; cv=none; b=OETMokx5DE08RJmsFlz7lLLDn5WZRasqk0QTbL4Z2AKL43mol57c6IU2XCAw5y5Jyu53BO1q7wk0x0FU5MeDKGdZMDyt8ydDErO1OsdYWw/lmOa0T34Z9O/PFyjcjgH4OGfaJZ4e3hrrhW883VUBCbUkwYoqoLjILS5nRlBtoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975799; c=relaxed/simple;
	bh=0RDVQa7L0OnIu08nxQH3yL1ogWBg2dkj/2taZUo7yjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoUOkGuO3W8N5Lrky4Ocmrznxxv7RLpyUmg6o3xrli137Z0zacwsQmOAxo7sP7oXeEG9GuC393Dkt/6mTV0obv9jdO3KnSHFv+HUYab9xowavvTgWEyn1w+prgB27hh+l8Ahb54haEiJvv1WR+vtcXtHA2sPS+ty7FHal/KLzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aTwvNscC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a3eac7ca30so2785085a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975797; x=1763580597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nze/QytclSTH4fFVa9JSQZznz6m85tFFzurTQmWSt3g=;
        b=aTwvNscCNINUUy1Sifr92j+E6x4+KZxRLycf5i1o5rm86Fqd3MYahZywGTryVCqANs
         ZUh/JKvGp51yrCxyyTH1h1BVLSO3PGnTCADcDxHrSkHefQPVgrMpwbvjFzLfAmWVmr8f
         AL9LXgZO8hEzfx6eMenGwYlIgsi+HdAyIXQQgj3jO6Y1iJ3KwAAXHT77R3WF3yl0Bf9b
         G4UsVoMj+AaF52ZeLKLOv8QfmCyOxAaY8gBebVoQx5BeDkIhvt94Kmx6vOdBnPCY5a6c
         WSGTM34laehVBAoFnzTTNYmEYFKvsRveLuUbhpF8Kj+ReI4jl1tB8wa/toeD3Ok0f64l
         /btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975797; x=1763580597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nze/QytclSTH4fFVa9JSQZznz6m85tFFzurTQmWSt3g=;
        b=E7ubYLGwLoKQqrB7IJfWndO0ENAlXMXfDNQigcU3CvFYcRwXYZCXUe+sRl1p+03TQS
         XKhp1KAkBVbczMK6eF/kK0Os9L+qFzLasB9rKdh6RKVSWwFDw+7Vx2HPZ4lrSwxecfAD
         BOubR7V73DVduDIcn0wHaqwMvDNElP9XeKzRHoI6Mf732HxWO9krpaqGQyggYv7ERJxs
         r/RqgGBBQL/jNbRb4S7E4ylOPKZ1+LSuwWtSeQGkz9+ApGmsZHxS2gU5ZW67Be2P1+EO
         h83GKWhdqdlerrICkqsca2L7NzJOh/dC40O5Nl5dlByb14qxAyDU/ssFklY7FMTR74SW
         AG3g==
X-Forwarded-Encrypted: i=1; AJvYcCXeh4BxTr3Nm9TphZsVNNT1yJe+WgHME99fr/7VfiFRCu1ivP7VuTRGgLJNJxR0Vur1Q30le1hXda5eYjb+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95pmyAygSaN03CKoBikMZ8wovQ4EO9elUQ/HmSPUxOANfY3Ft
	X+N1m4NFUGohk+JcJ6hiRNq/+rJAyN9gCUdJSX79dJ1I6XcFHzscc0g7j5PmDArnE64=
X-Gm-Gg: ASbGncstW+MqUeY+9vQ+Az7XcogdAvxDkHQHoaSbZ+5D4Umiw0sWg79fGVcnvrKfcXd
	MbkUwew/Yq23fyuhzlvEPyRQkL0uvx3DTq9zyGPPPrMvzVAp8V+updXaySWyE93QQ3qPD08MFeM
	s44QIJcTqzh2Dlxlk2pWI9SQnZiicENOr9tXVs/PgcRV22O6pX4QxznzzXqpK7eASCvx4wQu9rl
	zXLFIj3ac5B5ML+tFD6GXbgKx2TlWl/risWpVhEcjNaY+REQOlEUkz/TAdxmMA+13Do6F+OVUrq
	Cu0W5dK29Cdi945J7vCwKDGgab6X9J1KzTXNeNSn8k+PDbG+XZXkXqtpWyTmrbd1JKSoI2q9cNk
	n7VOHP1DIpPH6BVCMJqDQFSZDadlQSWoZouYjyi595oN+i+ibJpngEf+E+itK5o2lH3VXpVVJ+i
	HOBtA2Wge6N8NlhBv12aOSrhvoXcCMYyMj1Cp9tgXSsvEJoRhcmTLwWjzgedObWUWm
X-Google-Smtp-Source: AGHT+IH1lDcByGDzgs1svKTRXfQs8NRaQexk4Q0+NImfdOthU+jf0vqFA5hw/PqFsiRTGmnVj1m8eQ==
X-Received: by 2002:a05:620a:1a0f:b0:890:2e24:a543 with SMTP id af79cd13be357-8b29b77b3c0mr590594985a.34.1762975796840;
        Wed, 12 Nov 2025 11:29:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:56 -0800 (PST)
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
Subject: [RFC PATCH v2 03/11] gfp: Add GFP_SPM_NODE for Specific Purpose Memory (SPM) allocations
Date: Wed, 12 Nov 2025 14:29:19 -0500
Message-ID: <20251112192936.2574429-4-gourry@gourry.net>
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

GFP_SPM_NODE changes the nodemask checks in the page allocator to include
the full set memory nodes, rather than just SysRAM nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..525ae891420e 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_SPM_NODE_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,7 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#define ___GFP_SPM_NODE		BIT(___GFP_SPM_NODE_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -145,6 +147,8 @@ enum {
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
  *
  * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
+ *
+ * %__GFP_SPM_NODE allows the use of Specific Purpose Memory Nodes
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
@@ -152,6 +156,7 @@ enum {
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
 #define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
+#define __GFP_SPM_NODE	((__force gfp_t)___GFP_SPM_NODE)
 
 /**
  * DOC: Watermark modifiers
-- 
2.51.1


