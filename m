Return-Path: <linux-fsdevel+bounces-58513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C46CB2EA30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7441C83360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B41F78E6;
	Thu, 21 Aug 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcjbWsN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9805FEE6;
	Thu, 21 Aug 2025 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738676; cv=none; b=U1mPC7wKUxXmCKo0pMURfFUtGeT/MosevVLuBGJnyfFcdY73B8EOfrStJOOkmdeq8qw/Fm+msR1/gsJcsrC+Ww9I57M58aaoHTnAcJdDo3y5bsuDEg84pnQGJVxaZFLxdPO/M4NyI9vAZX4047BiO9Qh5Jl4YRIhhYjQOXad8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738676; c=relaxed/simple;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br8LmEB1vuUpy+caNXeKQsoOBR6OyV/94Ltj1jxWAL/zrw0CyrgFPbVdyXL7vEBKGYEtGYoxaQbtQvsaR+64jW0/4DYrpdPQJIhLurNfWpbOJnsIuCRoi0q+P4caqJMSnuRQnj6fVHaVPeB1GqSOwf/Fh2DnuC9hly8cJ4piBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcjbWsN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BE2C4CEE7;
	Thu, 21 Aug 2025 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738676;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qcjbWsN7Hx8HVJgIjhbOrDP9/FKioyAJBWK0KVCswpIaIuT5ni5G97TvYuakL7xrv
	 g3RipiujowWJeSZf7TtRtV7+F6bBnnzYMQObbiNktgX0XYQcSH9mxMZAjFkQtbdZeV
	 9XUlWJ9GAj3GU6Vk07DAI0S0WA6HUHWe2EpxGjlymJySOXpXNTzR5tWP6o7OGTv89A
	 oEQmI+EBOzqGcWPpt604dn+13f6Vx8qg/Xr8bYHZP/L02H6rnSW8lhXj0jK42QwyTX
	 aMqHr9q8XZcpZGQgiX6s2uGYyvmn86LUSuvPYfu7JbtPQKcqRGNrUm6+n44G5F1BJy
	 hmfiNny34dO2Q==
Date: Wed, 20 Aug 2025 18:11:15 -0700
Subject: [PATCH 13/20] cache: return results of a cache flush
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713041.20753.2528481564012056345.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Modify cache_flush to return whether or not there were errors whilst
flushing the cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    4 ++--
 lib/support/cache.c |   11 +++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index e8f1c82ef7869c..8d39ca5c02a285 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -58,7 +58,7 @@ typedef void *cache_key_t;
 
 typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn, void *d);
 typedef struct cache_node * (*cache_node_alloc_t)(struct cache *c, cache_key_t k);
-typedef int (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
+typedef bool (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_relse_t)(struct cache *c, struct cache_node *cn);
 typedef unsigned int (*cache_node_hash_t)(cache_key_t, unsigned int,
 					  unsigned int);
@@ -132,7 +132,7 @@ int cache_init(int flags, unsigned int size,
 void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
-void cache_flush(struct cache *);
+bool cache_flush(struct cache *cache);
 
 int cache_node_get(struct cache *, cache_key_t, struct cache_node **);
 void cache_node_put(struct cache *, struct cache_node *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 49568ffa6de2e4..fa07b4ad8222d2 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -631,18 +631,19 @@ cache_purge(
 }
 
 /*
- * Flush all nodes in the cache to disk.
+ * Flush all nodes in the cache to disk.  Returns true if the flush succeeded.
  */
-void
+bool
 cache_flush(
 	struct cache		*cache)
 {
 	struct cache_hash	*hash;
 	struct cache_node	*node;
 	int			i;
+	bool			still_dirty = false;
 
 	if (!cache->flush)
-		return;
+		return true;
 
 	for (i = 0; i < cache->c_hashsize; i++) {
 		hash = &cache->c_hash[i];
@@ -650,11 +651,13 @@ cache_flush(
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(node, &hash->ch_list, cn_hash) {
 			pthread_mutex_lock(&node->cn_mutex);
-			cache->flush(cache, node);
+			still_dirty |= cache->flush(cache, node);
 			pthread_mutex_unlock(&node->cn_mutex);
 		}
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
+
+	return !still_dirty;
 }
 
 #define	HASH_REPORT	(3 * HASH_CACHE_RATIO)


