Return-Path: <linux-fsdevel+bounces-61602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5409B58A34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855633B82B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11451C5F23;
	Tue, 16 Sep 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDROsEve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFF2BB13;
	Tue, 16 Sep 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984012; cv=none; b=rdcrYyTBkat9wBmLPZY5fCzTee7SZVZATehxUGPrpxAXWoI/5CRZxXZ2tPq0beCyKlDeCEcDIBYKuqnyZT45BW/n+jOA/croJ39yXONXPOp0bvhA49xutGVFDQRBc5c4Ce0GakAykc5Xo1wrapzWqNeTQmUzfjXmBmRiUAv8BWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984012; c=relaxed/simple;
	bh=JE9SIozXz14GFFFQeqnHj7+Yf0BTCtt13v22XW+jb/k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRH5ezPunlJZ8dQSiBAo0+RrXEFry9s4Ww0/ShWiOH5IvR3xMncPcMTpbDkTvTxNtlUVASmai3ycdT98cMdmGXlJCE7B9irRnPJMzxd9L5FjOdRF4dXB9FzdQdWfeIommafYUzHKss5HaHnPh0F9QaeSy759NQqbE7W17VLOZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDROsEve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C3BC4CEF1;
	Tue, 16 Sep 2025 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984011;
	bh=JE9SIozXz14GFFFQeqnHj7+Yf0BTCtt13v22XW+jb/k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bDROsEveoEiymXKW5wkSGDA9mU1shY5USiQmEAoaU1EMzpVnVIPcKTyaUBrt72y7p
	 0u8KhnGjRqBqZ7pblahPGUfZgiObP3wF+DcO3e5fH00uzLCQNVdN8Mtfapf1QIpxSn
	 4K/gwUaGQ8UO6qWt1L9kUHciNnZcDqaJiE48U5BvgXQSPHSaRjSFqfI1nkbImJQRuU
	 bVGGZ1nKavmchcVV5aQZXjGhO5qbGqYwSqZcbM7ZMi2NS4ZRR8IuUceyCRuPd9CbWP
	 c3UMYHNkPR7ymZ/E9pzp6MgjzqeMg+RIT7gWOChr68h8oXbW3RiAlFuXlLUE8+RnZh
	 2ph6sHrNLrQqA==
Date: Mon, 15 Sep 2025 17:53:31 -0700
Subject: [PATCH 11/21] cache: pass cache pointer to callbacks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160974.389252.11192612990267795501.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Pass the cache pointer to the cache node callbacks so that subsequent
patches don't have to waste memory putting pointers to struct fuse4fs in
the cached objects.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   12 ++++++------
 lib/support/cache.c |   21 +++++++++++----------
 2 files changed, 17 insertions(+), 16 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 993f1385dedcee..0168fdca027896 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -56,16 +56,16 @@ struct cache_node;
 
 typedef void *cache_key_t;
 
-typedef void (*cache_walk_t)(struct cache_node *);
-typedef struct cache_node * (*cache_node_alloc_t)(cache_key_t);
-typedef int (*cache_node_flush_t)(struct cache_node *);
-typedef void (*cache_node_relse_t)(struct cache_node *);
+typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn);
+typedef struct cache_node * (*cache_node_alloc_t)(struct cache *c, cache_key_t k);
+typedef int (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
+typedef void (*cache_node_relse_t)(struct cache *c, struct cache_node *cn);
 typedef unsigned int (*cache_node_hash_t)(cache_key_t, unsigned int,
 					  unsigned int);
 typedef int (*cache_node_compare_t)(struct cache_node *, cache_key_t);
 typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
-typedef int (*cache_node_get_t)(struct cache_node *);
-typedef void (*cache_node_put_t)(struct cache_node *);
+typedef int (*cache_node_get_t)(struct cache *c, struct cache_node *cn);
+typedef void (*cache_node_put_t)(struct cache *c, struct cache_node *cn);
 
 struct cache_operations {
 	cache_node_hash_t	hash;
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 8b4f9f03c3899b..2e2e36ccc3ef78 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -111,7 +111,7 @@ cache_walk(
 		hash = &cache->c_hash[i];
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(pos, &hash->ch_list, cn_hash)
-			visit(pos);
+			visit(cache, pos);
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
 }
@@ -125,7 +125,8 @@ cache_walk(
 #ifdef CACHE_DEBUG
 static void
 cache_zero_check(
-	struct cache_node *	node)
+	struct cache		*cache,
+	struct cache_node	*node)
 {
 	if (node->cn_count > 0) {
 		fprintf(stderr, "%s: refcount is %u, not zero (node=%p)\n",
@@ -170,7 +171,7 @@ cache_generic_bulkrelse(
 		node = list_entry(list->next, struct cache_node, cn_mru);
 		pthread_mutex_destroy(&node->cn_mutex);
 		list_del_init(&node->cn_mru);
-		cache->relse(node);
+		cache->relse(cache, node);
 		count++;
 	}
 
@@ -237,7 +238,7 @@ cache_shake(
 			continue;
 
 		/* memory pressure is not allowed to release dirty objects */
-		if (cache->flush(node) && !purge) {
+		if (cache->flush(cache, node) && !purge) {
 			list_del(&node->cn_mru);
 			mru->cm_count--;
 			node->cn_priority = -1;
@@ -302,7 +303,7 @@ cache_node_allocate(
 	pthread_mutex_unlock(&cache->c_mutex);
 	if (!nodesfree)
 		return NULL;
-	node = cache->alloc(key);
+	node = cache->alloc(cache, key);
 	if (node == NULL) {	/* uh-oh */
 		pthread_mutex_lock(&cache->c_mutex);
 		cache->c_count--;
@@ -341,7 +342,7 @@ __cache_node_purge(
 	}
 
 	/* can't purge dirty objects */
-	if (cache->flush(node)) {
+	if (cache->flush(cache, node)) {
 		pthread_mutex_unlock(&node->cn_mutex);
 		return 1;
 	}
@@ -355,7 +356,7 @@ __cache_node_purge(
 	pthread_mutex_unlock(&node->cn_mutex);
 	pthread_mutex_destroy(&node->cn_mutex);
 	list_del_init(&node->cn_hash);
-	cache->relse(node);
+	cache->relse(cache, node);
 	return 0;
 }
 
@@ -410,7 +411,7 @@ cache_node_get(
 			pthread_mutex_lock(&node->cn_mutex);
 
 			if (node->cn_count == 0 && cache->get) {
-				int err = cache->get(node);
+				int err = cache->get(cache, node);
 				if (err) {
 					pthread_mutex_unlock(&node->cn_mutex);
 					goto next_object;
@@ -505,7 +506,7 @@ cache_node_put(
 	node->cn_count--;
 
 	if (node->cn_count == 0 && cache->put)
-		cache->put(node);
+		cache->put(cache, node);
 	if (node->cn_count == 0) {
 		/* add unreferenced node to appropriate MRU for shaker */
 		mru = &cache->c_mrus[node->cn_priority];
@@ -640,7 +641,7 @@ cache_flush(
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(node, &hash->ch_list, cn_hash) {
 			pthread_mutex_lock(&node->cn_mutex);
-			cache->flush(node);
+			cache->flush(cache, node);
 			pthread_mutex_unlock(&node->cn_mutex);
 		}
 		pthread_mutex_unlock(&hash->ch_mutex);


