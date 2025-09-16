Return-Path: <linux-fsdevel+bounces-61601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C3B58A32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705503B22F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B41C8621;
	Tue, 16 Sep 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDl9MeTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADAFC1D;
	Tue, 16 Sep 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983996; cv=none; b=sykihahDVdPTzeZwArFKwyi5Cq93Is5aWrNODvqlmHzjMvBho/wvgxRHpW9sUKNRceIecgw4FeP528YEKy8NMY2niLs+wmJcobc6G0t2nIxx16q0KVU0pJjocbLNTTDhJpVsIbg4qcp518cbMtzc3Pw9Mq4FNDWZKDCYBhNioTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983996; c=relaxed/simple;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayQvdq+WByzsJQUyIwBBP3Fz/Cki4WqXI8KFrd6dGaiai1BIFMobZoJGMI3rRCZH/4d8bx9LbnjBHAV7cYfK0vBMTrp0reR4x3ZZKFonUV569QsAyWg4UcOEFMmn+pu35iv7xKvfqJKCYFmD2z9kS1irJLofKCaXElAIoDpNcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDl9MeTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F12C4CEF1;
	Tue, 16 Sep 2025 00:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983996;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QDl9MeTUllJc8IIPvz+WkKPOTcaUw9XzhcmUF2fyrCFHngEb2SJ/EMq3dQhgDm2Kl
	 xRQM18g9paagZouInvgV59FHbpWu2S/2tJU4ifGQ+gjTb/AGEkEt+qZSD76TZL1MCX
	 NqqidxdQ6tuwvhd4f2RICHVBmG9oNypcZOfQVMdXgKjOi8J1jjwqS/r/JrciCh0wMJ
	 a072+mg5BUtTuVUy2l7DKSc7uWEzL7uK3ZNP9ndewL/Hw7gQdzwEAhZrAbev6pJnot
	 F8SYUiu8sz1f/1x6Sf3j4L4jeFLACxuwTjwK2G+pp12jHFjkoX1nJoWQm0feOulOg8
	 Ig7ZFHJ9d4adw==
Date: Mon, 15 Sep 2025 17:53:15 -0700
Subject: [PATCH 10/21] cache: embed struct cache in the owner
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160956.389252.5079220981540747785.stgit@frogsfrogsfrogs>
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


