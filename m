Return-Path: <linux-fsdevel+bounces-61600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E8B58A30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729221B238A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C41D31B9;
	Tue, 16 Sep 2025 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQN7iPKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92A3A1D2;
	Tue, 16 Sep 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983981; cv=none; b=obmvRC80crn6H/UP9V3ZtFAYF6Qi6bvJaiy1D57I6cDilubDeWe17aHZtpSk4kFKnUa9VxewBRi4JGcDPLa7CgCHif7vkhb9nbKbDi5jjqA6YMycJ+dynPTABY+2g3b/GmvqoWh9yDrnQd66/DJXcV2YiM8iOMJQPXmYNsTxlAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983981; c=relaxed/simple;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyPNXbSIViwOJBlBJvgB/x26p5DnU5BoX8XOxnp4zy/FkoNGlrOQ64S97Zw72Z//g4njbzuvEAo5ryGeYFACxcU7645TfI6XmV/pywEHoFVgiXvPiC7Y5XJW6MGUEicAE+6cMBU5IOLkMG0bs/MDAu3onLmBCmVaQ6/Y68WaZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQN7iPKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD78C4CEF1;
	Tue, 16 Sep 2025 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983980;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GQN7iPKmvPvIqmuXRUTjPmFqXxlvRHybbnspjM3c8aCbenD09lZzH1s31ddyVYgop
	 AzmNnU3qH92DW3hCIj5JfxDKrbrp2RIEyZkM0O6yu660GEP0j8E9eCNpYJwxyv9lug
	 kb6XpIzA9t6xVvEVmadQd9XLYTvlRLE4pGGKv8ok9QOOo7rmrEwlNafcY9Qpf4kvQU
	 Cx8BOSfkjDhxQ17thGT9/qZCV+X9EU21Rm2QCQN+Myl26TR9fn3Imjsn+hgbOq+E95
	 ykSoWlPK02GbzhT7eBnp9Lh+suAO/tw6+1xukvs4rNyX53f7rEBIzS7htZv6z/6aDW
	 U4sH584vkHelg==
Date: Mon, 15 Sep 2025 17:53:00 -0700
Subject: [PATCH 09/21] cache: use modern list iterator macros
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160938.389252.2482010267887209947.stgit@frogsfrogsfrogs>
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

Use the list iterator macros from list.h.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.c |   71 +++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 47 deletions(-)


diff --git a/lib/support/cache.c b/lib/support/cache.c
index 08e0b484cca298..d8f8231ac36d28 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -98,20 +98,18 @@ cache_expand(
 
 void
 cache_walk(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_walk_t		visit)
 {
-	struct cache_hash *	hash;
-	struct list_head *	head;
-	struct list_head *	pos;
+	struct cache_hash	*hash;
+	struct cache_node	*pos;
 	unsigned int		i;
 
 	for (i = 0; i < cache->c_hashsize; i++) {
 		hash = &cache->c_hash[i];
-		head = &hash->ch_list;
 		pthread_mutex_lock(&hash->ch_mutex);
-		for (pos = head->next; pos != head; pos = pos->next)
-			visit((struct cache_node *)pos);
+		list_for_each_entry(pos, &hash->ch_list, cn_hash)
+			visit(pos);
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
 }
@@ -218,12 +216,9 @@ cache_shake(
 	bool			purge)
 {
 	struct cache_mru	*mru;
-	struct cache_hash *	hash;
+	struct cache_hash	*hash;
 	struct list_head	temp;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
-	struct cache_node *	node;
+	struct cache_node	*node, *n;
 	unsigned int		count;
 
 	ASSERT(priority <= CACHE_DIRTY_PRIORITY);
@@ -233,13 +228,9 @@ cache_shake(
 	mru = &cache->c_mrus[priority];
 	count = 0;
 	list_head_init(&temp);
-	head = &mru->cm_list;
 
 	pthread_mutex_lock(&mru->cm_mutex);
-	for (pos = head->prev, n = pos->prev; pos != head;
-						pos = n, n = pos->prev) {
-		node = list_entry(pos, struct cache_node, cn_mru);
-
+	list_for_each_entry_safe_reverse(node, n, &mru->cm_list, cn_mru) {
 		if (pthread_mutex_trylock(&node->cn_mutex) != 0)
 			continue;
 
@@ -376,31 +367,25 @@ __cache_node_purge(
  */
 int
 cache_node_get(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_key_t		key,
-	struct cache_node **	nodep)
+	struct cache_node	**nodep)
 {
-	struct cache_node *	node = NULL;
-	struct cache_hash *	hash;
-	struct cache_mru *	mru;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
+	struct cache_hash	*hash;
+	struct cache_mru	*mru;
+	struct cache_node	*node = NULL, *n;
 	unsigned int		hashidx;
 	int			priority = 0;
 	int			purged = 0;
 
 	hashidx = cache->hash(key, cache->c_hashsize, cache->c_hashshift);
 	hash = cache->c_hash + hashidx;
-	head = &hash->ch_list;
 
 	for (;;) {
 		pthread_mutex_lock(&hash->ch_mutex);
-		for (pos = head->next, n = pos->next; pos != head;
-						pos = n, n = pos->next) {
+		list_for_each_entry_safe(node, n, &hash->ch_list, cn_hash) {
 			int result;
 
-			node = list_entry(pos, struct cache_node, cn_hash);
 			result = cache->compare(node, key);
 			switch (result) {
 			case CACHE_HIT:
@@ -568,23 +553,19 @@ cache_node_get_priority(
  */
 int
 cache_node_purge(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_key_t		key,
-	struct cache_node *	node)
+	struct cache_node	*node)
 {
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
-	struct cache_hash *	hash;
+	struct cache_node	*pos, *n;
+	struct cache_hash	*hash;
 	int			count = -1;
 
 	hash = cache->c_hash + cache->hash(key, cache->c_hashsize,
 					   cache->c_hashshift);
-	head = &hash->ch_list;
 	pthread_mutex_lock(&hash->ch_mutex);
-	for (pos = head->next, n = pos->next; pos != head;
-						pos = n, n = pos->next) {
-		if ((struct cache_node *)pos != node)
+	list_for_each_entry_safe(pos, n, &hash->ch_list, cn_hash) {
+		if (pos != node)
 			continue;
 
 		count = __cache_node_purge(cache, node);
@@ -642,12 +623,10 @@ cache_purge(
  */
 void
 cache_flush(
-	struct cache *		cache)
+	struct cache		*cache)
 {
-	struct cache_hash *	hash;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct cache_node *	node;
+	struct cache_hash	*hash;
+	struct cache_node	*node;
 	int			i;
 
 	if (!cache->flush)
@@ -657,9 +636,7 @@ cache_flush(
 		hash = &cache->c_hash[i];
 
 		pthread_mutex_lock(&hash->ch_mutex);
-		head = &hash->ch_list;
-		for (pos = head->next; pos != head; pos = pos->next) {
-			node = (struct cache_node *)pos;
+		list_for_each_entry(node, &hash->ch_list, cn_hash) {
 			pthread_mutex_lock(&node->cn_mutex);
 			cache->flush(node);
 			pthread_mutex_unlock(&node->cn_mutex);


