Return-Path: <linux-fsdevel+bounces-58515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B930B2EA35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE7656531E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279A1F8676;
	Thu, 21 Aug 2025 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btyoB9tM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D65FEE6;
	Thu, 21 Aug 2025 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738708; cv=none; b=MfAZPXLblghJ1ZPIcO23q09oibugA6Xt3T0wqALrEUQsttVQVk/QQXMgF6XJZPnGvNrslnm6VVYGAygpP2H0TmbuB6Hxmfkh9UlgwIlssGFjCgOzcXYw/mIgfWUwTVx/o7j0u9lJjnARF+HOiKLA3yAsUr7G6VDSZUstmzPiuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738708; c=relaxed/simple;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk42Au1IdIysZiTgMPEAyuY01JtfjMejXMS6VcX2EQJ8P2Nd8kIIbb0HO/o9ekSpxC2YbqO9Pw7OcdjQPv7aJ8+tPue0QLi2uXXH/rZjAK3NKGL7CpWUenHzSCxJGiHNijuRnq2Hv0nEa6n0yvKGNpJGpKNGSOQ5L7SW6Eqy9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btyoB9tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79393C4CEE7;
	Thu, 21 Aug 2025 01:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738707;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=btyoB9tMiPxaulgCAeaJKnEah3Q1VN20xq3aWluxxyIafy1L8a9sYHw+VUrU4kJyQ
	 RRA2K6Bhd2HNxWmtdbB4Gnc00XnxHZNfHYw/JL9d/Ru2WM/ANdulOXBk/j13It4aSG
	 rbTEAYq99sHCFycC5tetJdpw7Or8ilDfk2m5T/QrxYmmsTHjb3L9SjzbKOqMLu7WtO
	 H7N5bcsBeCz3rIAzGeRtciXO4q9/ctERm5rf7nXQ12XztMr794VS1t1poEJZCS6bJT
	 V9crXC6MI1+CRbhSJOwXujQvJep6ARZKakYcjoKr+T+LFB8JMTA/ip/E3NtnjZ/2j+
	 hbjbYzTO/ACsA==
Date: Wed, 20 Aug 2025 18:11:47 -0700
Subject: [PATCH 15/20] cache: support gradual expansion
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713077.20753.2190936945232727449.stgit@frogsfrogsfrogs>
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

It's probably not a good idea to expand the cache size by powers of two
beyond some random limit, so let the users figure that out if they want
to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   10 ++++++++++
 lib/support/cache.c |   12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 98b2182d49a6e0..ae37945c545f46 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -66,6 +66,14 @@ typedef int (*cache_node_compare_t)(struct cache_node *, cache_key_t);
 typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
 typedef int (*cache_node_get_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_put_t)(struct cache *c, struct cache_node *cn);
+typedef unsigned int (*cache_node_resize_t)(const struct cache *c,
+					    unsigned int curr_size);
+
+static inline unsigned int cache_gradual_resize(const struct cache *cache,
+						unsigned int curr_size)
+{
+	return curr_size * 5 / 4;
+}
 
 struct cache_operations {
 	cache_node_hash_t	hash;
@@ -76,6 +84,7 @@ struct cache_operations {
 	cache_bulk_relse_t	bulkrelse;	/* optional */
 	cache_node_get_t	get;		/* optional */
 	cache_node_put_t	put;		/* optional */
+	cache_node_resize_t	resize;		/* optional */
 };
 
 struct cache_hash {
@@ -113,6 +122,7 @@ struct cache {
 	cache_bulk_relse_t	bulkrelse;	/* bulk release routine */
 	cache_node_get_t	get;		/* prepare cache node after get */
 	cache_node_put_t	put;		/* prepare to put cache node */
+	cache_node_resize_t	resize;		/* compute new maxcount */
 	unsigned int		c_hashsize;	/* hash bucket count */
 	unsigned int		c_hashshift;	/* hash key shift */
 	struct cache_hash	*c_hash;	/* hash table buckets */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 9da6c59b3b6391..dbaddc1bd36d3d 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -62,6 +62,7 @@ cache_init(
 		cache_operations->bulkrelse : cache_generic_bulkrelse;
 	cache->get = cache_operations->get;
 	cache->put = cache_operations->put;
+	cache->resize = cache_operations->resize;
 	pthread_mutex_init(&cache->c_mutex, NULL);
 
 	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
@@ -90,11 +91,18 @@ static void
 cache_expand(
 	struct cache *		cache)
 {
+	unsigned int		new_size = 0;
+
 	pthread_mutex_lock(&cache->c_mutex);
+	if (cache->resize)
+		new_size = cache->resize(cache, cache->c_maxcount);
+	if (new_size <= cache->c_maxcount)
+		new_size = cache->c_maxcount * 2;
 #ifdef CACHE_DEBUG
-	fprintf(stderr, "doubling cache size to %d\n", 2 * cache->c_maxcount);
+	fprintf(stderr, "increasing cache max size from %u to %u\n",
+			cache->c_maxcount, new_size);
 #endif
-	cache->c_maxcount *= 2;
+	cache->c_maxcount = new_size;
 	pthread_mutex_unlock(&cache->c_mutex);
 }
 


