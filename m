Return-Path: <linux-fsdevel+bounces-61605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBCB58A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2451B26219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF591C5F23;
	Tue, 16 Sep 2025 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGqSC68j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D98FC1D;
	Tue, 16 Sep 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984058; cv=none; b=NS76rlSIvOUeSmL3wtmEYRGeUr5ZHd3TPxRCJmCELWzR0FciqC3i4bD3XNjbnLwMRRCjJT+1RR0OWJVMqgmHUIM0tOe2hDQPduyFCB51JLBkzrAIb99YgcUZ6r86o03NspR73cjQ4c03lKA64AI0UuLCOq4MCN+fobd+bEWZJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984058; c=relaxed/simple;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rolPULzidfrHQs/a/mpz7JqY15C3l7hYVA5l6wgsgQhEI82E25JE1OUxbgZm/Tw2s5xhht92yHSBHmFNhs3nxvysUUTEexp2aY9h6Me8Ff+CBe8Bp4X4UY7wxIDHdCFJuU7jJKC17pl6Se8QAE4nMkKlTrDF199jxp53irsx66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGqSC68j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E474C4CEF1;
	Tue, 16 Sep 2025 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984058;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dGqSC68jqPJjNtavzA+8zFgzqnMBVHP7Mv+D0Khx835IUiGNvF+DhVov5NEjzcIOI
	 cDYtxWh9xKSpa+738sw/+ZelsGeu4r32MHM5k2wlkvAyl+fEEqPgu08zu2cOUyny+a
	 P45nH1HtwzGvmKPDyDooRM0Ok/p0WNADnP1qMqjnoQwISyeRvLP8dzqsUrVubdo//1
	 u84sZY+tBmojovH+Ou9VJNUv1MmWBwcj03787xaiG7RpA2HRTVjbMdI2MV/iWiEhQp
	 ZXF02EmSOnt8icciA9rL18xG+LwB+KkdHK7aOTd11UzROsaJ6Vbw8M7EfZ66FHJftw
	 xPBDRVeA84fBQ==
Date: Mon, 15 Sep 2025 17:54:18 -0700
Subject: [PATCH 14/21] cache: return results of a cache flush
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161028.389252.3791395256672564863.stgit@frogsfrogsfrogs>
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


