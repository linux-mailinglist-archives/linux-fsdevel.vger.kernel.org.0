Return-Path: <linux-fsdevel+bounces-61608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD89B58A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E913A66E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132191D31B9;
	Tue, 16 Sep 2025 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqX/mwz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4F2BB13;
	Tue, 16 Sep 2025 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984105; cv=none; b=D1ifUVHXWTizROEwvwjj2X49lJQior8bM/k1GaoCW5z2jsZda0MDFnYbrEIQ/Dolg+olMWrMHtFT8g7obXa2PnL9qly46k1ABO/7V6XIK10NOOpSAp67UI/YyQ4x1WxJssgP32P0TPNgSTYwBy1gyGpVMNEAjPLSp5ujf6Zgg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984105; c=relaxed/simple;
	bh=eYWafbLYwz1zY14uiR8oxHr5ill3pPDiMFDQkhs1pEE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG2zdXq9wPtUIUocAKa8CNBwyFm3+6wWi6LtlrGlxwJMJaEi3wDLWmhzx1dCU3GwDRyJfpMBHg6tcVDPnaZYupopHmUNOrCuaXa3Z1nB4Ejc5EiN3SNA0t1Z2TQGUjbdCCM6Y+YAynVWmfaRCrw809RYuuNK6DvBiVmmLjWmjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqX/mwz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E30C4CEF1;
	Tue, 16 Sep 2025 00:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984105;
	bh=eYWafbLYwz1zY14uiR8oxHr5ill3pPDiMFDQkhs1pEE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tqX/mwz75KVuJYjBJNVj9v4Vxt/pEre9KmyckKgOx5/R6BxJDfQUA4qa9tW86rkPc
	 cSJRDs2ZlK4+T2pgXweY3iOtZ78q6xNqt9pC13trIx5SEIFRGA19uHZhAhH/a6xWGY
	 a4QBQN+C/ogFKip9CzpFNcV3eJIn+1uoaCFJXnGDfrW8o9o7RefUL9zhpunZAMdEN3
	 wjfLoa9GKW8a4Uc0zrUQbWfvPwOulmS6/Gl3pTqEGQwThJbGwo8gz/026AAj5C2LKI
	 1svqtSlLJdU78FsLk7Nk2JIs8DQ6Ncg8nIAKlR+UMm9q+alfpuQIY6fwtPvvc8qvMs
	 wwojBxPwu2CJw==
Date: Mon, 15 Sep 2025 17:55:04 -0700
Subject: [PATCH 17/21] cache: implement automatic shrinking
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161081.389252.792881872242373984.stgit@frogsfrogsfrogs>
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

Shrink the cache whenever maxcount has been expanded beyond its initial
value, we release a cached object to one of the mru lists and the number
of objects sitting on the mru is enough to drop the cache count down a
level.  This enables a cache to reduce its memory consumption after a
spike in which reclamation wasn't possible.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   17 ++++++-
 lib/support/cache.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 126 insertions(+), 9 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index ae37945c545f46..cd738b6cd3a460 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -16,6 +16,9 @@
  */
 #define CACHE_MISCOMPARE_PURGE	(1 << 0)
 
+/* Automatically shrink the cache's max_count when possible. */
+#define CACHE_CAN_SHRINK	(1U << 1)
+
 /*
  * cache object campare return values
  */
@@ -67,12 +70,18 @@ typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
 typedef int (*cache_node_get_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_put_t)(struct cache *c, struct cache_node *cn);
 typedef unsigned int (*cache_node_resize_t)(const struct cache *c,
-					    unsigned int curr_size);
+					    unsigned int curr_size,
+					    int dir);
 
 static inline unsigned int cache_gradual_resize(const struct cache *cache,
-						unsigned int curr_size)
+						unsigned int curr_size,
+						int dir)
 {
-	return curr_size * 5 / 4;
+	if (dir < 0)
+		return curr_size * 9 / 10;
+	else if (dir > 0)
+		return curr_size * 5 / 4;
+	return curr_size;
 }
 
 struct cache_operations {
@@ -111,6 +120,7 @@ struct cache_node {
 
 struct cache {
 	int			c_flags;	/* behavioural flags */
+	unsigned int		c_orig_max;	/* original max cache nodes */
 	unsigned int		c_maxcount;	/* max cache nodes */
 	unsigned int		c_count;	/* count of nodes */
 	pthread_mutex_t		c_mutex;	/* node count mutex */
@@ -143,6 +153,7 @@ void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
+void cache_shrink(struct cache *cache);
 
 /* don't allocate a new node */
 #define CACHE_GET_INCORE	(1U << 0)
diff --git a/lib/support/cache.c b/lib/support/cache.c
index dbaddc1bd36d3d..7e1ddc3cc8788d 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -53,6 +53,7 @@ cache_init(
 	cache->c_hits = 0;
 	cache->c_misses = 0;
 	cache->c_maxcount = maxcount;
+	cache->c_orig_max = maxcount;
 	cache->hash = cache_operations->hash;
 	cache->alloc = cache_operations->alloc;
 	cache->flush = cache_operations->flush;
@@ -95,7 +96,7 @@ cache_expand(
 
 	pthread_mutex_lock(&cache->c_mutex);
 	if (cache->resize)
-		new_size = cache->resize(cache, cache->c_maxcount);
+		new_size = cache->resize(cache, cache->c_maxcount, 1);
 	if (new_size <= cache->c_maxcount)
 		new_size = cache->c_maxcount * 2;
 #ifdef CACHE_DEBUG
@@ -226,7 +227,8 @@ static unsigned int
 cache_shake(
 	struct cache *		cache,
 	unsigned int		priority,
-	bool			purge)
+	bool			purge,
+	unsigned int		nr_to_shake)
 {
 	struct cache_mru	*mru;
 	struct cache_hash	*hash;
@@ -274,7 +276,7 @@ cache_shake(
 		pthread_mutex_unlock(&node->cn_mutex);
 
 		count++;
-		if (!purge && count == CACHE_SHAKE_COUNT)
+		if (!purge && count == nr_to_shake)
 			break;
 	}
 	pthread_mutex_unlock(&mru->cm_mutex);
@@ -287,7 +289,7 @@ cache_shake(
 		pthread_mutex_unlock(&cache->c_mutex);
 	}
 
-	return (count == CACHE_SHAKE_COUNT) ? priority : ++priority;
+	return (count == nr_to_shake) ? priority : ++priority;
 }
 
 /*
@@ -477,7 +479,7 @@ cache_node_get(
 		node = cache_node_allocate(cache, key);
 		if (node)
 			break;
-		priority = cache_shake(cache, priority, false);
+		priority = cache_shake(cache, priority, false, CACHE_SHAKE_COUNT);
 		/*
 		 * We start at 0; if we free CACHE_SHAKE_COUNT we get
 		 * back the same priority, if not we get back priority+1.
@@ -507,12 +509,112 @@ cache_node_get(
 	return 1;
 }
 
+static unsigned int cache_mru_count(const struct cache *cache)
+{
+	const struct cache_mru	*mru = cache->c_mrus;
+	unsigned int		mru_count = 0;
+	unsigned int		i;
+
+	for (i = 0; i < CACHE_NR_PRIORITIES; i++, mru++)
+		mru_count += mru->cm_count;
+
+	return mru_count;
+}
+
+
+void cache_shrink(struct cache *cache)
+{
+	unsigned int		mru_count = 0;
+	unsigned int		threshold = 0;
+	unsigned int		priority = 0;
+	unsigned int		new_size;
+
+	pthread_mutex_lock(&cache->c_mutex);
+	/* Don't shrink below the original cache size */
+	if (cache->c_maxcount <= cache->c_orig_max)
+		goto out_unlock;
+
+	mru_count = cache_mru_count(cache);
+
+	/*
+	 * If there's not even a batch of nodes on the MRU to try to free,
+	 * don't bother with the rest.
+	 */
+	if (mru_count < CACHE_SHAKE_COUNT)
+		goto out_unlock;
+
+	/*
+	 * Figure out the next step down in size, but don't go below the
+	 * original size.
+	 */
+	if (cache->resize)
+		new_size = cache->resize(cache, cache->c_maxcount, -1);
+	else
+		new_size = cache->c_maxcount / 2;
+	if (new_size >= cache->c_maxcount)
+		goto out_unlock;
+	if (new_size < cache->c_orig_max)
+		new_size = cache->c_orig_max;
+
+	/*
+	 * If we can't purge enough nodes to get the node count below new_size,
+	 * don't resize the cache.
+	 */
+	if (cache->c_count - mru_count >= new_size)
+		goto out_unlock;
+
+#ifdef CACHE_DEBUG
+	fprintf(stderr, "decreasing cache max size from %u to %u (currently %u)\n",
+		cache->c_maxcount, new_size, cache->c_count);
+#endif
+	cache->c_maxcount = new_size;
+
+	/* Try to reduce the number of cached objects. */
+	do {
+		unsigned int new_priority;
+
+		/*
+		 * The threshold is the amount we need to purge to get c_count
+		 * below the new maxcount.  Try to free some objects off the
+		 * MRU.  Drop c_mutex because cache_shake will take it.
+		 */
+		threshold = cache->c_count - new_size;
+		pthread_mutex_unlock(&cache->c_mutex);
+
+		new_priority = cache_shake(cache, priority, false, threshold);
+
+		/* Either we made no progress or we ran out of MRU levels */
+		if (new_priority == priority ||
+		    new_priority > CACHE_MAX_PRIORITY)
+			return;
+		priority = new_priority;
+
+		pthread_mutex_lock(&cache->c_mutex);
+		/*
+		 * Someone could have walked in and changed the cache maxsize
+		 * again while we had the lock dropped.  If that happened, stop
+		 * clearing.
+		 */
+		if (cache->c_maxcount != new_size)
+			goto out_unlock;
+
+		mru_count = cache_mru_count(cache);
+		if (cache->c_count - mru_count >= new_size)
+			goto out_unlock;
+	} while (1);
+
+out_unlock:
+	pthread_mutex_unlock(&cache->c_mutex);
+	return;
+}
+
 void
 cache_node_put(
 	struct cache *		cache,
 	struct cache_node *	node)
 {
 	struct cache_mru *	mru;
+	bool was_put = false;
 
 	pthread_mutex_lock(&node->cn_mutex);
 #ifdef CACHE_DEBUG
@@ -528,6 +630,7 @@ cache_node_put(
 	}
 #endif
 	node->cn_count--;
+	was_put = (node->cn_count == 0);
 
 	if (node->cn_count == 0 && cache->put)
 		cache->put(cache, node);
@@ -541,6 +644,9 @@ cache_node_put(
 	}
 
 	pthread_mutex_unlock(&node->cn_mutex);
+
+	if (was_put && (cache->c_flags & CACHE_CAN_SHRINK))
+		cache_shrink(cache);
 }
 
 void
@@ -632,7 +738,7 @@ cache_purge(
 	int			i;
 
 	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++)
-		cache_shake(cache, i, true);
+		cache_shake(cache, i, true, CACHE_SHAKE_COUNT);
 
 #ifdef CACHE_DEBUG
 	if (cache->c_count != 0) {


