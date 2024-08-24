Return-Path: <linux-fsdevel+bounces-27047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13795DFB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84731F220D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF977E583;
	Sat, 24 Aug 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hd8pUDRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D45770F3
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526634; cv=none; b=qWNFHRI11t3m0rzY/1lzeIlzL7Ig4tYv/bpNlB+7rkl7kDCMbhqwMZeuTlf+ZLymAGGkKeJWwEwwMytAnGTPCyvpds68YcZpRDFYeLFgSJ9dLKU0YdWdusAeyeStuSfoQAE48vLFq4RjDZyAGFE6YCMRFCHednIOAiGvRo7VsSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526634; c=relaxed/simple;
	bh=+tUik1Nv/hsGR6qHXEPJn1X6ybWgLRg/Rywa850NncI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOapzMFX37UYhpREtaqBW9vR3yXR0wqRGUIW47VyYrgo6Gl61MzIcR2SbcJ3HsPiTfvgalx0eI134aJ/mt0xoH8JR5/MU9iNJKNc6qrVXg5H7o7AChRYG6HyByZCLYOnDNL84qf3t+s+a+k+tK8COaZQI3Vy8SKxvUCp8WRxImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hd8pUDRY; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EwinnhQJWLN2dpAsOdfTffV0dyCCM/ESmRUthjs8fA=;
	b=hd8pUDRYBSAWcHds+IcAqN78oUmonPqT+4y7lH2sUVv5krRH0pvFcgoJ4Djj25e25KUd1G
	mxD5LSlRWMkLPaxOyPd8+cN6zRNf1PXH4B+L+55uJpKMskDO1PgVM+FG9mF/fgdf8Oeigt
	hXDSXbFiS2guQ9CO5iKc2r52cY7syxo=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Date: Sat, 24 Aug 2024 15:10:09 -0400
Message-ID: <20240824191020.3170516-3-kent.overstreet@linux.dev>
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds a new callback method to shrinkers which they can use to
describe anything relevant to memory reclaim about their internal state,
for example object dirtyness.

This patch also adds shrinkers_to_text(), which reports on the top 10
shrinkers - by object count - in sorted order, to be used in OOM
reporting.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/shrinker.h |  7 +++-
 mm/shrinker.c            | 73 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 1a00be90d93a..6193612617a1 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -24,6 +24,8 @@ struct shrinker_info {
 	struct shrinker_info_unit *unit[];
 };
 
+struct seq_buf;
+
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
  * We consolidate the values for easier extension later.
@@ -80,10 +82,12 @@ struct shrink_control {
  * @flags determine the shrinker abilities, like numa awareness
  */
 struct shrinker {
+	const char *name;
 	unsigned long (*count_objects)(struct shrinker *,
 				       struct shrink_control *sc);
 	unsigned long (*scan_objects)(struct shrinker *,
 				      struct shrink_control *sc);
+	void (*to_text)(struct seq_buf *, struct shrinker *);
 
 	long batch;	/* reclaim batch size, 0 = default */
 	int seeks;	/* seeks to recreate an obj */
@@ -110,7 +114,6 @@ struct shrinker {
 #endif
 #ifdef CONFIG_SHRINKER_DEBUG
 	int debugfs_id;
-	const char *name;
 	struct dentry *debugfs_entry;
 #endif
 	/* objs pending delete, per node */
@@ -135,6 +138,8 @@ __printf(2, 3)
 struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
+void shrinker_to_text(struct seq_buf *, struct shrinker *);
+void shrinkers_to_text(struct seq_buf *);
 
 static inline bool shrinker_try_get(struct shrinker *shrinker)
 {
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..ad52c269bb48 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/memcontrol.h>
+#include <linux/rculist.h>
 #include <linux/rwsem.h>
+#include <linux/seq_buf.h>
 #include <linux/shrinker.h>
-#include <linux/rculist.h>
 #include <trace/events/vmscan.h>
 
 #include "internal.h"
@@ -807,3 +808,73 @@ void shrinker_free(struct shrinker *shrinker)
 	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
 }
 EXPORT_SYMBOL_GPL(shrinker_free);
+
+void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
+{
+	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+
+	seq_buf_puts(out, shrinker->name);
+	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
+
+	if (shrinker->to_text) {
+		shrinker->to_text(out, shrinker);
+		seq_buf_puts(out, "\n");
+	}
+}
+
+/**
+ * shrinkers_to_text - Report on shrinkers with highest usage
+ *
+ * This reports on the top 10 shrinkers, by object counts, in sorted order:
+ * intended to be used for OOM reporting.
+ */
+void shrinkers_to_text(struct seq_buf *out)
+{
+	struct shrinker *shrinker;
+	struct shrinker_by_mem {
+		struct shrinker	*shrinker;
+		unsigned long	mem;
+	} shrinkers_by_mem[10];
+	int i, nr = 0;
+
+	if (!mutex_trylock(&shrinker_mutex)) {
+		seq_buf_puts(out, "(couldn't take shrinker lock)");
+		return;
+	}
+
+	list_for_each_entry(shrinker, &shrinker_list, list) {
+		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+		unsigned long mem = shrinker->count_objects(shrinker, &sc);
+
+		if (!mem || mem == SHRINK_STOP || mem == SHRINK_EMPTY)
+			continue;
+
+		for (i = 0; i < nr; i++)
+			if (mem < shrinkers_by_mem[i].mem)
+				break;
+
+		if (nr < ARRAY_SIZE(shrinkers_by_mem)) {
+			memmove(&shrinkers_by_mem[i + 1],
+				&shrinkers_by_mem[i],
+				sizeof(shrinkers_by_mem[0]) * (nr - i));
+			nr++;
+		} else if (i) {
+			i--;
+			memmove(&shrinkers_by_mem[0],
+				&shrinkers_by_mem[1],
+				sizeof(shrinkers_by_mem[0]) * i);
+		} else {
+			continue;
+		}
+
+		shrinkers_by_mem[i] = (struct shrinker_by_mem) {
+			.shrinker = shrinker,
+			.mem = mem,
+		};
+	}
+
+	for (i = nr - 1; i >= 0; --i)
+		shrinker_to_text(out, shrinkers_by_mem[i].shrinker);
+
+	mutex_unlock(&shrinker_mutex);
+}
-- 
2.45.2


