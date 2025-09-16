Return-Path: <linux-fsdevel+bounces-61607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F162B58A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F83C3BAE78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C21C5F23;
	Tue, 16 Sep 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/LnmOij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A3FC1D;
	Tue, 16 Sep 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984089; cv=none; b=oq8WRB00Pr4JG1469XYVXGqhweTY8GYwmrZBVDIl4CNAd2blMfmP8XGtNoHYFU3GivEpkT0y4ryFDxjs/01naZGozaVLWAzwj3nfXi6bS8PeL21Ss6oKY9FkcquOql81ZB8gsAH+zr771/EkEgRBvrdQSjYx6UYLWbawb9TBXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984089; c=relaxed/simple;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td5/PBMn8LO6GFltzvnBDdYFo7kTkk+wAPbLmLyXv1vi3WM7HRLP/tEMca8J5lQB6JRJ/LPdqYMvnHQjQ+R8v75dq5o+tYyYAJI9cEnBsNNkKNETVNz3EX03rVCNapBEameSFtd12ybcEGBR5FeVO6cHei2jqZPVaHRZ9UII8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/LnmOij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B15C4CEF1;
	Tue, 16 Sep 2025 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984089;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W/LnmOijwsbV5r18xMewIv3ReCOVz1iynlMWxsM74m/7+h1ZfB1REj01dB851Jitz
	 ZGHy5FB0LiiCLm2Wm6skihOKNL/hD1suAmuLzpybwo8uWp+/RgH75WX8NuVVtSsi+4
	 qhlvSMAv2KWRnwKpNAL/s1VGBzEV+9/v/nWFxIwh+SRcznC4G4yCy16lYTBFIGMWSB
	 +hioGN2uWUodHBs538b9uFhIuSSrQYyul9Jc8rrnEvjw3Tc7+LnayuNZau0VNeKQNF
	 XmFQV5DdvSSExdJ8QvRmF98ZDaIeaRc5hdE/nvVzYhOG2n7dQcsRMM5X9EOBILMnI2
	 TJqLYlQ55ZIHA==
Date: Mon, 15 Sep 2025 17:54:49 -0700
Subject: [PATCH 16/21] cache: support gradual expansion
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161064.389252.14627358765195200164.stgit@frogsfrogsfrogs>
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
 


