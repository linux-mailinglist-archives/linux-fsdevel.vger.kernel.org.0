Return-Path: <linux-fsdevel+bounces-72938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FCD06268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B69B230879C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083B331235;
	Thu,  8 Jan 2026 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AfZQstJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027393328FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904756; cv=none; b=ayDaKHedAWWiiKHZoz3APsIZpTvEn5Zn21oAni8yjRptHaIabfiU9dQxWJcG/LhyQ8KuWPT7uV1REZEvvdhD37DulL19JIkCufW+71+9KSm6Oa3+dxVISZCTVJbgPHuOot5SQmV5X9w7EXwrSkwgMCYDCNdYcOcxDcKpIYQhtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904756; c=relaxed/simple;
	bh=Q6n6H6pGLwW6lg8o+yJkMzcp5ygcedJTXlkaT5WaISo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HySx8IQnja8rxCdRLvzqDrya0xv5jXf0VeCDgnonYR/8+7ZmVj4/SJxXtlx2u3lTL7DhNUqIVSBdp1J8V31ln9xtNbXaoIX3f0QmtqfnOGLCI+vAMnip34pxaYdKxVeuU2WFtwbrdkLnIviKBRUtTsASaBQ1IclUerjdtjYkbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AfZQstJT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee13dc0c52so30322791cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904750; x=1768509550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTZsz9YEfzZ2R8Vdeqp1RCaOkKgwxKsmSu+J9FA9fQ=;
        b=AfZQstJTicHT8cU0FpbOpZQ226cG57nxuzO9CXkQR2+q1EpDMkbKf6rUuAVsxrGdTh
         v6crsNu+AYUpEvyGFd60KQYYnTuKPc9OACtbdGy0jGPVY91zv6lyHAUaabz5uhDce9gt
         iY7+Aa2Nt4/6bImyHuiist25XkTpKbeWo8KK6FajaQ6+ranNVv4zReewKrjXTfhiu+o0
         n/wuib40Q1w5he3k9YH0trpvMh7uZy/SavVCwu1PyWvfBoqpOPGa/VuIcJRMGnkO82cM
         /7oqylfUe9lJIzHM3fNaOzy0rWjLtTtk7dU/bk+cn9qklC4SXwr+6sCGibE8ZCp7ZWeV
         OrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904750; x=1768509550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OTZsz9YEfzZ2R8Vdeqp1RCaOkKgwxKsmSu+J9FA9fQ=;
        b=XdqPnd1S8BY+NNVayQLj0vY3hO+moSHXxd3t++5ircf24jcE1fCVnvEq+k/D94nJWO
         5QxsA5nh+hLdiBxgPToEQaqoTH5oWSKQ1Z8wg9muvjIG0hn05IG5gyBmhju/IG5+CJY+
         FrtqXJSWR+/ivx9NTEpkDZrPG3ts69SRoBuSPrk3jkeSW0yBhLzL0zDPBeJjtiu6L7ZC
         7WqMQy/CLsHv9W1xg3JrR/JShUgG0iUaLq+tRCiTzFH71v7Qwq06V9HeA2+wB3GxEGLv
         K95mXskVDWak8g8lzDaVhbJ7QrhXSqYDta5IOvxxbfvvlQWF4SN3L8pP2ylBRRgRIO4/
         gu1w==
X-Forwarded-Encrypted: i=1; AJvYcCX3S1v/07zAs7/GGD4Erz29dVKuLGdl0JXMQlKhgKtPgMGLp1giB2k+EmOcmsTqNfUL4jGXb7iEXQz2zgFc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5Aeo8NACXpZ2A0WUfZROCaz/B072cgQn6Pe+HCvEGqwiZNlr
	1U7mtvViBstJt4IW53+A3Yys92tKEGs33Qb0SbNjmqrbK4/y/UAERRwgX4nGh7DBnPI=
X-Gm-Gg: AY/fxX5qDRA2bblFOkzr1EoosMgPHIwBxvHPtx1+YZtMpZDyf6blL0xQYF03vT3vnRS
	cNeJqhPffeLgnavB3y/v8NKAWnXIGU0Ml81mGrz5Z/FID9wQ0hOqULzd9oFK2hEhjsNiGaeyu1/
	ug1HQhWywFX7/Q23PJ1mWzs8mSZ9vSe+R691JgrUuxcxpVQ26rXTM5Bfhj1tfmlub8hwm4Y9oK1
	deLqIwcxjV29po94WquJHb6H61BwDjyrKTDGRgfe67Ce0IzUh6qglGwmzo5BnKp+3159hRI/rG8
	1rit+7YXZiC6+z4eDafyJHB8xdsYlLf+1qOeShi/7ew6F2uStMbcQITleDCTvz4OU7sZiK1uky8
	+Dq2Kxf81fwY4qMR+fCDAYhSibe3cueonTIUJdsxUVHkHLTTQJDsDYtaUoEOMGEwLytqPYbhQ9S
	GcjZm0eN93Wqy2Ur50ZHyGWTglc2YFaTi+HY8PjSW1N70LUJFCQxmbfVKKf3zv+dw2aD+k+eu7t
	z8=
X-Google-Smtp-Source: AGHT+IHjrJedObjQLnkqlATuK0iiTd2ReDzXEhDuZpiEE8iScOlIeLDoodxwtlrvEQjvQ0kp+C8/HQ==
X-Received: by 2002:a05:622a:554:b0:4ee:26bd:13fa with SMTP id d75a77b69052e-4ffb4a38073mr98924131cf.80.1767904749843;
        Thu, 08 Jan 2026 12:39:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:39:09 -0800 (PST)
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
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Date: Thu,  8 Jan 2026 15:37:54 -0500
Message-ID: <20260108203755.1163107-8-gourry@gourry.net>
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

If a private zswap-node is available, skip the entire software
compression process and memcpy directly to a compressed memory
folio, and store the newly allocated compressed memory page as
the zswap entry->handle.

On decompress we do the opposite: copy directly from the stored
page to the destination, and free the compressed memory page.

The driver callback is responsible for preventing run-away
compression ratio failures by checking that the allocated page is
safe to use (i.e. a compression ratio limit hasn't been crossed).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/zswap.h |   5 ++
 mm/zswap.c            | 106 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..4b52fe447e7e 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -35,6 +35,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+void zswap_add_direct_node(int nid);
+void zswap_remove_direct_node(int nid);
 #else
 
 struct zswap_lruvec_state {};
@@ -69,6 +71,9 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline void zswap_add_direct_node(int nid) {}
+static inline void zswap_remove_direct_node(int nid) {}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index de8858ff1521..aada588c957e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
 #include <linux/zsmalloc.h>
+#include <linux/node.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -190,6 +191,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	bool referenced;
+	bool direct;
 	struct zswap_pool *pool;
 	unsigned long handle;
 	struct obj_cgroup *objcg;
@@ -199,6 +201,20 @@ struct zswap_entry {
 static struct xarray *zswap_trees[MAX_SWAPFILES];
 static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
+/* Nodemask for compressed RAM nodes used by zswap_compress_direct */
+static nodemask_t zswap_direct_nodes = NODE_MASK_NONE;
+
+void zswap_add_direct_node(int nid)
+{
+	node_set(nid, zswap_direct_nodes);
+}
+
+void zswap_remove_direct_node(int nid)
+{
+	if (!node_online(nid))
+		node_clear(nid, zswap_direct_nodes);
+}
+
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
 /* protects zswap_pools list modification */
@@ -716,7 +732,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	if (entry->direct) {
+		struct page *page = (struct page *)entry->handle;
+
+		node_private_freed(page);
+		__free_page(page);
+	} else
+		zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -849,6 +871,58 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 	mutex_unlock(&acomp_ctx->mutex);
 }
 
+static struct page *zswap_compress_direct(struct page *src,
+					  struct zswap_entry *entry)
+{
+	int nid;
+	struct page *dst;
+	gfp_t gfp;
+	nodemask_t tried_nodes = NODE_MASK_NONE;
+
+	if (nodes_empty(zswap_direct_nodes))
+		return NULL;
+
+	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE |
+	      __GFP_THISNODE;
+
+	for_each_node_mask(nid, zswap_direct_nodes) {
+		int ret;
+
+		/* Skip nodes we've already tried and failed */
+		if (node_isset(nid, tried_nodes))
+			continue;
+
+		dst = __alloc_pages(gfp, 0, nid, &zswap_direct_nodes);
+		if (!dst)
+			continue;
+
+		/*
+		 * Check with the device driver that this page is safe to use.
+		 * If the device reports an error (e.g., compression ratio is
+		 * too low and the page can't safely store data), free the page
+		 * and try another node.
+		 */
+		ret = node_private_allocated(dst);
+		if (ret) {
+			__free_page(dst);
+			node_set(nid, tried_nodes);
+			continue;
+		}
+
+		goto found;
+	}
+
+	return NULL;
+
+found:
+	/* If we fail to copy at this point just fallback */
+	if (copy_mc_highpage(dst, src)) {
+		__free_page(dst);
+		dst = NULL;
+	}
+	return dst;
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -860,6 +934,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
+	struct page *zpage;
+
+	/* Try to shunt directly to compressed ram */
+	zpage = zswap_compress_direct(page, entry);
+	if (zpage) {
+		entry->handle = (unsigned long)zpage;
+		entry->length = PAGE_SIZE;
+		entry->direct = true;
+		return true;
+	}
+	/* otherwise fallback to normal zswap */
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
@@ -913,6 +998,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	zs_obj_write(pool->zs_pool, handle, dst, dlen);
 	entry->handle = handle;
 	entry->length = dlen;
+	entry->direct = false;
 
 unlock:
 	if (mapped)
@@ -936,6 +1022,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	int decomp_ret = 0, dlen = PAGE_SIZE;
 	u8 *src, *obj;
 
+	/* compressed ram page */
+	if (entry->direct) {
+		struct page *src = (struct page *)entry->handle;
+		struct folio *zfolio = page_folio(src);
+
+		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
+		goto direct_done;
+	}
+
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
 
@@ -969,6 +1064,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
+direct_done:
 	if (!decomp_ret && dlen == PAGE_SIZE)
 		return true;
 
@@ -1483,7 +1579,13 @@ static bool zswap_store_page(struct page *page,
 	return true;
 
 store_failed:
-	zs_free(pool->zs_pool, entry->handle);
+	if (entry->direct) {
+		struct page *freepage = (struct page *)entry->handle;
+
+		node_private_freed(freepage);
+		__free_page(freepage);
+	} else
+		zs_free(pool->zs_pool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.52.0


