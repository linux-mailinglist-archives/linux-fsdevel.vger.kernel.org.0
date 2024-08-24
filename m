Return-Path: <linux-fsdevel+bounces-27036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CB95DF61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A01F21731
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5AA6F2EE;
	Sat, 24 Aug 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjuVLsG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F85B5D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522709; cv=none; b=Mi7VnvpvoxWV74HTB4MyfswZ9j6uVgJjw/aBnBhPtLeL+ugVEpTYkGP8LswoRFgq1AFcdZ/oT7DMbVsyIVPhsW+sCzjmU5JiEymEG6b47EpvJmnTESljwdmHtwQu1oVHTdFF44/ZChP91tJ50s7HnDMGyROaLqH+fRErIBuGg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522709; c=relaxed/simple;
	bh=LwgOU9R/qKMk0z//TKkJvBh68HELAvHKnc6jbloS0uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLQuT1ugfT4CEZKm458P+zh4vqNKplKcaVGuUgBU+nvixt/U/oYxRSy9+BmPzCb9qCj9iVSD922OPbeUBcmVtw/FjsdRSXwLKe4goZIYya2YRh1MpXTOIhN/P3qQLWG4KVYQ3ir3lX2GQxxrlVebKlolPUN+BkFibq2RG8ecTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjuVLsG2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1cr4HFsHjQtQrwgw0v0pluuE8by2jRYsZZv2/hFaZA=;
	b=ZjuVLsG2af5BTL4yTIoOCaNYOnmQsVvqocvTVD8x5DMshfnenznngvORvY0M2a/LPdMelH
	j84ABf3my8Usx7Mih1zSSJodMHSVl255PRv3tceacTMhKb7nGd0p4VtNsTjD5GdvmVMhYo
	IYB1NomBNdGKl2rJYJJVuPS61jXjwfk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm: shrinker: Add new stats for .to_text()
Date: Sat, 24 Aug 2024 14:04:45 -0400
Message-ID: <20240824180454.3160385-4-kent.overstreet@linux.dev>
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

Add a few new shrinker stats.

number of objects requested to free, number of objects freed:

Shrinkers won't necessarily free all objects requested for a variety of
reasons, but if the two counts are wildly different something is likely
amiss.

.scan_objects runtime:

If one shrinker is taking an excessive amount of time to free
objects that will block kswapd from running other shrinkers.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/shrinker.h |  6 ++++++
 mm/shrinker.c            | 23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6193612617a1..106622ddac77 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -118,6 +118,12 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+
+	atomic_long_t	objects_requested_to_free;
+	atomic_long_t	objects_freed;
+	unsigned long	last_freed;	/* timestamp, in jiffies */
+	unsigned long	last_scanned;	/* timestamp, in jiffies */
+	atomic64_t	ns_run;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/shrinker.c b/mm/shrinker.c
index ad52c269bb48..feaa8122afc9 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -430,13 +430,24 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	       total_scan >= freeable) {
 		unsigned long ret;
 		unsigned long nr_to_scan = min(batch_size, total_scan);
+		u64 start_time = ktime_get_ns();
+
+		atomic_long_add(nr_to_scan, &shrinker->objects_requested_to_free);
 
 		shrinkctl->nr_to_scan = nr_to_scan;
 		shrinkctl->nr_scanned = nr_to_scan;
 		ret = shrinker->scan_objects(shrinker, shrinkctl);
+
+		atomic64_add(ktime_get_ns() - start_time, &shrinker->ns_run);
 		if (ret == SHRINK_STOP)
 			break;
 		freed += ret;
+		unsigned long now = jiffies;
+		if (ret) {
+			atomic_long_add(ret, &shrinker->objects_freed);
+			shrinker->last_freed = now;
+		}
+		shrinker->last_scanned = now;
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
 		total_scan -= shrinkctl->nr_scanned;
@@ -812,9 +823,19 @@ EXPORT_SYMBOL_GPL(shrinker_free);
 void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
 {
 	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+	unsigned long nr_freed = atomic_long_read(&shrinker->objects_freed);
 
 	seq_buf_puts(out, shrinker->name);
-	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
+	seq_buf_putc(out, '\n');
+
+	seq_buf_printf(out, "objects:             %lu\n", shrinker->count_objects(shrinker, &sc));
+	seq_buf_printf(out, "requested to free:   %lu\n", atomic_long_read(&shrinker->objects_requested_to_free));
+	seq_buf_printf(out, "objects freed:       %lu\n", nr_freed);
+	seq_buf_printf(out, "last scanned:        %li sec ago\n", (jiffies - shrinker->last_scanned) / HZ);
+	seq_buf_printf(out, "last freed:          %li sec ago\n", (jiffies - shrinker->last_freed) / HZ);
+	seq_buf_printf(out, "ns per object freed: %llu\n", nr_freed
+		       ? div64_ul(atomic64_read(&shrinker->ns_run), nr_freed)
+		       : 0);
 
 	if (shrinker->to_text) {
 		shrinker->to_text(out, shrinker);
-- 
2.45.2


