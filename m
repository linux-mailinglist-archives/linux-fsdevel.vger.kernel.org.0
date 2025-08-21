Return-Path: <linux-fsdevel+bounces-58509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180EBB2EA29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6501A1BC7FC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211A1F8676;
	Thu, 21 Aug 2025 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6JRn4xL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E845FEE6;
	Thu, 21 Aug 2025 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738614; cv=none; b=jAqbwLCIXMt2x4gyJLzT8noGG+polB+jwWcynW58R4onjAYa/77mHCuuyVJnrGW/FFmJMCO4A0Y3y41PeRijzbOnDb8BUfJoYZenyXLLwNA2cwaeKFlusGeeN2RLI66LFYCjsWcUDBBkIOXkE9Oa8QkIK2fDoCZGACrVqn6G3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738614; c=relaxed/simple;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE5/L9KAlh1HKk9RP1ktLFMIuRp49U/shVF0doG0MTvwHkb3YctLBE5vzfcTYQmYIynRBTHllFrL+0tvqnNW5F02zjJFc3NXVmiKHtWpo6FnwMcVf6hpj8SCxzlFa8AVpegmi5xFVAh4P//jtIY6cyn9HkyB2wzXrdgWiaRgC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6JRn4xL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE164C4CEE7;
	Thu, 21 Aug 2025 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738613;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F6JRn4xLqoyu0VUOzwcU2cpfQkeCyNFjw7SIoiDyi+myh4T3deVZ5JLTVN37UgQHs
	 RkcAP4xyrKiupYgR9oVcaTrgEiIh1Pg5k/M2+uF9Da92VmszfL7/aYv3N47bdTa5i6
	 vkD15I1MtkpEMiKGDmy+bYfaDSCMokTzSBk9Tm++LS3wjVKbL8vdDn2kKY3lXICw6B
	 ECMdKpEz09O11o/R1go+6FbNxTJLlHjgSmvWbkaNvvjamy6ks4o5ZrpKWw6yV6+inv
	 TMy8BgMJdU26iGoxTOStwovpa5vGf5ues/G2l6TeLYkyuu24ie8Z6FJHwFgjThPcb/
	 /3xknJBhox0pw==
Date: Wed, 20 Aug 2025 18:10:13 -0700
Subject: [PATCH 09/20] cache: embed struct cache in the owner
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712970.20753.1034438294852882216.stgit@frogsfrogsfrogs>
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

It'll be easier to embed a struct cache into the object that owns the
cache rather than passing pointers around.  This is the prelude to the
next patch, which will enable cache functions to walk back to the owning
struct.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   10 ++++++++--
 lib/support/cache.c |   38 ++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 20 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 16b17a9b7a1a51..993f1385dedcee 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -122,8 +122,14 @@ struct cache {
 	unsigned int 		c_max;		/* max nodes ever used */
 };
 
-struct cache *cache_init(int, unsigned int, const struct cache_operations *);
-void cache_destroy(struct cache *);
+static inline bool cache_initialized(const struct cache *cache)
+{
+	return cache->hash != NULL;
+}
+
+int cache_init(int flags, unsigned int size,
+	       const struct cache_operations *ops, struct cache *cache);
+void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *, cache_walk_t);
 void cache_purge(struct cache *);
 void cache_flush(struct cache *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index d8f8231ac36d28..8b4f9f03c3899b 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <errno.h>
 
 #include "list.h"
 #include "cache.h"
@@ -33,23 +34,18 @@
 
 static unsigned int cache_generic_bulkrelse(struct cache *, struct list_head *);
 
-struct cache *
+int
 cache_init(
 	int			flags,
 	unsigned int		hashsize,
-	const struct cache_operations	*cache_operations)
+	const struct cache_operations	*cache_operations,
+	struct cache		*cache)
 {
-	struct cache *		cache;
 	unsigned int		i, maxcount;
 
 	maxcount = hashsize * HASH_CACHE_RATIO;
 
-	if (!(cache = malloc(sizeof(struct cache))))
-		return NULL;
-	if (!(cache->c_hash = calloc(hashsize, sizeof(struct cache_hash)))) {
-		free(cache);
-		return NULL;
-	}
+	memset(cache, 0, sizeof(*cache));
 
 	cache->c_flags = flags;
 	cache->c_count = 0;
@@ -57,8 +53,6 @@ cache_init(
 	cache->c_hits = 0;
 	cache->c_misses = 0;
 	cache->c_maxcount = maxcount;
-	cache->c_hashsize = hashsize;
-	cache->c_hashshift = fls(hashsize) - 1;
 	cache->hash = cache_operations->hash;
 	cache->alloc = cache_operations->alloc;
 	cache->flush = cache_operations->flush;
@@ -70,18 +64,26 @@ cache_init(
 	cache->put = cache_operations->put;
 	pthread_mutex_init(&cache->c_mutex, NULL);
 
+	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
+		list_head_init(&cache->c_mrus[i].cm_list);
+		cache->c_mrus[i].cm_count = 0;
+		pthread_mutex_init(&cache->c_mrus[i].cm_mutex, NULL);
+	}
+
+	cache->c_hash = calloc(hashsize, sizeof(struct cache_hash));
+	if (!cache->c_hash)
+		return ENOMEM;
+
+	cache->c_hashsize = hashsize;
+	cache->c_hashshift = fls(hashsize) - 1;
+
 	for (i = 0; i < hashsize; i++) {
 		list_head_init(&cache->c_hash[i].ch_list);
 		cache->c_hash[i].ch_count = 0;
 		pthread_mutex_init(&cache->c_hash[i].ch_mutex, NULL);
 	}
 
-	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
-		list_head_init(&cache->c_mrus[i].cm_list);
-		cache->c_mrus[i].cm_count = 0;
-		pthread_mutex_init(&cache->c_mrus[i].cm_mutex, NULL);
-	}
-	return cache;
+	return 0;
 }
 
 static void
@@ -153,7 +155,7 @@ cache_destroy(
 	}
 	pthread_mutex_destroy(&cache->c_mutex);
 	free(cache->c_hash);
-	free(cache);
+	memset(cache, 0, sizeof(*cache));
 }
 
 static unsigned int


