Return-Path: <linux-fsdevel+bounces-58511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F9B2EA1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B864B5C3B39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48771F8676;
	Thu, 21 Aug 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atRPT4D6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484891A9F9F;
	Thu, 21 Aug 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738645; cv=none; b=bYPHcvXhxGIeht7TquAtzOicw7ZNQHRri/OdSk69ja6dnX+romYpvcNOQXVHDPIR2PWg4ePGWui7jMolhsco8M9fGYQdo3KONoBTJDTi+nhlBAK1wU50oJtc4h9T1VNwypWEvr6fJMCRf6fagZcmEXSF1pSkyHqUredkb18QnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738645; c=relaxed/simple;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Us3w/6cIRoKFKW3VcCnAfnglVV1Wq0ojlSC60soBp49iruW0gmoeuIn0f2a+Vx/vrJDOG174xfI5lGOaGuzeG1ny0oRneZvWdcN060fUn0kgnoZbCzGJkJkf08RI4vbGgCrPerSEAD/NTQPMYsSXmE+ylbiiLKy6hywKwswngPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atRPT4D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C2BC4CEE7;
	Thu, 21 Aug 2025 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738645;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=atRPT4D6ER/Z7NCxs7/eNt5sftA7/K+D6W5krkPBJF2oImAxRNrdITchTYW2CxUkQ
	 FmN1nIbBaN+vn8G7+biUiummgE+GKkZEYXLUgBt51eb2Cr253cuHPSxAnBKkWu3feO
	 8Y19F3L49kOSJmCo0kiaL6PXrYZY6p7JAytVwsP5hh7eHDv+sp9zm6ncMB563icpxc
	 A5u6WgE3if709KN3WPduqBNSseig3d8kgq3erexuAMIN+W6t/pzItHtq5HTMIneBM2
	 cJfrCxsjyCOIYuUIV8QMJd4fAEyezG14Oc72laay0GI2hKvoCQ5vBTAvQaGpXPmNZj
	 qzXk9pq95rn6A==
Date: Wed, 20 Aug 2025 18:10:44 -0700
Subject: [PATCH 11/20] cache: pass a private data pointer through cache_walk
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713006.20753.6517578177154029451.stgit@frogsfrogsfrogs>
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

Allow cache_walk callers to pass a pointer to the callback function.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    4 ++--
 lib/support/cache.c |   10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 0168fdca027896..b18b6d3325e9ad 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -56,7 +56,7 @@ struct cache_node;
 
 typedef void *cache_key_t;
 
-typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn);
+typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn, void *d);
 typedef struct cache_node * (*cache_node_alloc_t)(struct cache *c, cache_key_t k);
 typedef int (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_relse_t)(struct cache *c, struct cache_node *cn);
@@ -130,7 +130,7 @@ static inline bool cache_initialized(const struct cache *cache)
 int cache_init(int flags, unsigned int size,
 	       const struct cache_operations *ops, struct cache *cache);
 void cache_destroy(struct cache *cache);
-void cache_walk(struct cache *, cache_walk_t);
+void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 void cache_flush(struct cache *);
 
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 2e2e36ccc3ef78..606acd5453cf10 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -101,7 +101,8 @@ cache_expand(
 void
 cache_walk(
 	struct cache		*cache,
-	cache_walk_t		visit)
+	cache_walk_t		visit,
+	void			*data)
 {
 	struct cache_hash	*hash;
 	struct cache_node	*pos;
@@ -111,7 +112,7 @@ cache_walk(
 		hash = &cache->c_hash[i];
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(pos, &hash->ch_list, cn_hash)
-			visit(cache, pos);
+			visit(cache, pos, data);
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
 }
@@ -126,7 +127,8 @@ cache_walk(
 static void
 cache_zero_check(
 	struct cache		*cache,
-	struct cache_node	*node)
+	struct cache_node	*node,
+	void			*data)
 {
 	if (node->cn_count > 0) {
 		fprintf(stderr, "%s: refcount is %u, not zero (node=%p)\n",
@@ -134,7 +136,7 @@ cache_zero_check(
 		cache_abort();
 	}
 }
-#define cache_destroy_check(c)	cache_walk((c), cache_zero_check)
+#define cache_destroy_check(c)	cache_walk((c), cache_zero_check, NULL)
 #else
 #define cache_destroy_check(c)	do { } while (0)
 #endif


