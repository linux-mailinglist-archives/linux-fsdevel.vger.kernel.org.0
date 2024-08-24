Return-Path: <linux-fsdevel+bounces-27035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33895DF60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB551C20756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1171664C6;
	Sat, 24 Aug 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PA8TAr8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7352F70
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522708; cv=none; b=c8uEiLfFsEonKWASWQeEQjHyYcuqSkC/F6sIM5wKsSJFSGq5b5+Y7AfDbyfeOIK//kp8DAQfvyIJQRfoks0vWYQrXpvkzb410bm+icPXLUFvrUfjCxZFRfH4nlneyoSL3S1hId1bOIFiGCWPf/uDpvxq63EswzN0Z6CP0EvhUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522708; c=relaxed/simple;
	bh=+tUik1Nv/hsGR6qHXEPJn1X6ybWgLRg/Rywa850NncI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJH84PQVV27fGJH0d5cPnwnrJMw0ctFm6JabIH1vTXFj1XgXQr1jEtHHJprbMhtSLd0gF1FcqJm9bqdiAn5g3jFmuwJ2llrKhRLUtS/tDYQHxGiDCr8yDWfDnxHBh0ZSqYblMuZeFzU8u278SoseitdWs7ZCGLK5dEXKn+Tw9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PA8TAr8Z; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EwinnhQJWLN2dpAsOdfTffV0dyCCM/ESmRUthjs8fA=;
	b=PA8TAr8ZBwgEDgS3dUduPbEF9QAcFTyYQrLdS+F6lb/qJjT5BGllUtY7YTKcmWlNrK0BCN
	BtjA9L1dgvKCxHgm2n8T3qLkBM6Hs85YLVJ0tbuZaS3AVU1RMNAH8NASKH8/c/EEhzVlJc
	/rtRv8/XbP6iq2PnOXKIUfq5AQ7p7YY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Date: Sat, 24 Aug 2024 14:04:44 -0400
Message-ID: <20240824180454.3160385-3-kent.overstreet@linux.dev>
In-Reply-To: <20240824180454.3160385-1-kent.overstreet@linux.dev>
References: <20240824180454.3160385-1-kent.overstreet@linux.dev>
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


