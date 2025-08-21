Return-Path: <linux-fsdevel+bounces-58508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE73B2EA1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E8D5C3B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC720B218;
	Thu, 21 Aug 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll7L3L9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BA1FF7C5;
	Thu, 21 Aug 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738598; cv=none; b=W7XbNTfsSZUurCHIJb9zRGCnjN/qV2ijM29Ss0WrNUv6GyMFY7MTdX5roikqxGNxPfenDEtz9nK07Cc0jjELkN2C8aQ9L7iGthshHkLYZFIGiBzGQ8zd25xPNWil7OK6SLZIkl096g2p68Vmn0ieynccZurDJKepCPvFnP/n6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738598; c=relaxed/simple;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeJ5miNNz3pAFSpr6hG8Kqen18LCV77eW+pD8AEYrA/DU/X4uDa7HOJc9EXruTOXFvGmrtu7qmqMK3BU3R8P6YhLss4KnwTCOeshN2xQPM+MOnnl8oq4iDtJwu8iqk4+deZJBcDevnaw2mHJchl6XVOZielBioh0hPd2qv50cE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll7L3L9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC80C4CEE7;
	Thu, 21 Aug 2025 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738598;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ll7L3L9SwH8LTwpwVJ6rYiSnDddfFbxgqtJdKr6tg6+R2FzfvNuu5dDVdfCtmsMZl
	 7e7bl7XU0tl2Zj3z36dCTTM1GaiEzoR1dmbZBiUwQqUvakhyqYNWzryEkzhbYcrVhy
	 rT5chmQUDFanSJ4vW4WkwFWvAyqVXZmwaO6haIJnnMwnXu1jRqGluWYhWE7Y/Slnxn
	 LZdEGu6ATAQ7xV4r82wAz4EhYooijXJluJh5sO8RcCGuBmLPRLhjy1dDHYfmX8WvlF
	 Ipdu1D0ZR/TFUzH/qz3htVeQ2O+9qBXi/An+gbBqZu87GNNXWqAGJl+3lJIJCZiSSZ
	 UlOkAMzIEauHg==
Date: Wed, 20 Aug 2025 18:09:57 -0700
Subject: [PATCH 08/20] cache: use modern list iterator macros
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712951.20753.1271939752055610279.stgit@frogsfrogsfrogs>
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


