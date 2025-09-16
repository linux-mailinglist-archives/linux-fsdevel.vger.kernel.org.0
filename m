Return-Path: <linux-fsdevel+bounces-61603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2CB58A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E4D2A2C78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513391C5F23;
	Tue, 16 Sep 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWp+mZEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB581FC1D;
	Tue, 16 Sep 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984028; cv=none; b=YbAf9lGo6O6tIfKYuzefe6on1X2YB+kpC30RxpdfTwQbhAnW7N7xh7+3IwzteXG6Uxdpn0L1KFnZSqiNAu8oeFNjt5T+Igtp3mMqxDNfUxNi96MufZVzVAoTo+8P5qIvt0xl0IRSwnqS8xRaKn6uf1SE67/M0NikOdsrSxuypLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984028; c=relaxed/simple;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8wqpiibW1WCIobXqdb79zfTg3GXMXyw0jMMa/48bQZl4Li4FiPLTM8UD8U5W979CkxUQ3xZH7WtVo0FTnuZF0rKmzgj18x+Kcd1U1ihEExtRAm/2bm72P3VzZ6rSDk8uUjSqBmX09LpJIzSo2rqo4tDyxwA4eCdUSt4UQ4em1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWp+mZEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36266C4CEF1;
	Tue, 16 Sep 2025 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984027;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DWp+mZEnLHMIz+gfdEC420CiNthAP1+wU9nzLS084Hd1OkNXWG7M5tWx4N+7ImFgT
	 Bgn91YK2MEjKsWJ4GGBkJEem5SYNSshw2iRhwydPLVMeCvd36LwS7XbElTr1lpAqVU
	 3xwwmKBoVN9msyVNqAT9OOEbdtl7xN1KF9h1Aj2BGHwAlErIkmUddRbog5c1px2Upi
	 JPRVkm8d6v/8f/OikADsLp9s5XT8p3QA4nA5hLV5KMonxpDQ+PlfxsRmK0wqysKLoX
	 cYHSggfVOP0e2OroZLEUU8f7dAhAxnS2TWtrAoYd0dq5O6Kr6VRfbkB1Wzqz1prEiO
	 lpj821O7pKQ8Q==
Date: Mon, 15 Sep 2025 17:53:46 -0700
Subject: [PATCH 12/21] cache: pass a private data pointer through cache_walk
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160992.389252.947373793069862824.stgit@frogsfrogsfrogs>
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


