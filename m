Return-Path: <linux-fsdevel+bounces-58512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C848EB2EA24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D4DA26469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B261F4188;
	Thu, 21 Aug 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeL8BmIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D61A9F9F;
	Thu, 21 Aug 2025 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738661; cv=none; b=CSKB+pgE6cludFCaeVstt1wBC0ueHj+xXN5FmtW2rwhbbr2fgALLSpYg4YfQKxtmkSMwFZjTDbrwhBT4CEnMleL/uvz9LGo5rLyerwyCJK6SE3b6mrQE2UXUNtku/ha0wiJuibs1n5/jWSSDN/qMm8devqtIyVlGXWLa10ddEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738661; c=relaxed/simple;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHCfJ3aoACr3uAjYPfb8MpekTF66q8E3OoqqfSV5WrowEfHVOHzseZ0147uhUwNJno/woTsLtGDc4PsGSnO8QbV0THUiANBt6u8h1xQo4EXw8vygYu/nDbnsFhpfYQf9aSg2XRq9EBksZqNAn8UvqeP1Gnfn5MkCknm9pM32HS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeL8BmIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4B1C4CEE7;
	Thu, 21 Aug 2025 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738660;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NeL8BmIWyDPiFyElc4O6XACV+8DtFJJE7hN3snuz/gNBUrlA5dFEhpPebJIbkV+ns
	 EayvzLwUCKc2cBPYMzCzWdlBDHVQ+5luSIy0QMKbGL2ILjzlRgWmWXqIjn8uocKrIQ
	 LqET9IjDJt0vj0SH4RaJ+zgJsKpUu/ubrPffGIqVQq2y8RROaJF7aQjY8NY5Ay/v/C
	 GiMPI5XK+oIiy2EgDsuDc5Otr927i/pEb6LZKI4ytQkJxt5+5k+M2bHN1PrZv0fBxJ
	 L4hUCXk1sNcU6y32PbZGBTLwAMDrlvmZljMB78rlGjo93njCkDDVDhpyoq3ooXHzOH
	 D5QBwHbBRmgWg==
Date: Wed, 20 Aug 2025 18:11:00 -0700
Subject: [PATCH 12/20] cache: add a helper to grab a new refcount for a
 cache_node
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713023.20753.17208085171701652235.stgit@frogsfrogsfrogs>
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

Create a helper to bump the refcount of a cache node.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    1 +
 lib/support/cache.c |   57 +++++++++++++++++++++++++++++----------------------
 2 files changed, 33 insertions(+), 25 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index b18b6d3325e9ad..e8f1c82ef7869c 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -141,5 +141,6 @@ int cache_node_get_priority(struct cache_node *);
 int cache_node_purge(struct cache *, cache_key_t, struct cache_node *);
 void cache_report(FILE *fp, const char *, struct cache *);
 int cache_overflowed(struct cache *);
+struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node);
 
 #endif	/* __CACHE_H__ */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 606acd5453cf10..49568ffa6de2e4 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -362,6 +362,35 @@ __cache_node_purge(
 	return 0;
 }
 
+/* Grab a new refcount to the cache node object.  Caller must hold cn_mutex. */
+struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node)
+{
+	struct cache_mru *mru;
+
+	if (node->cn_count == 0 && cache->get) {
+		int err = cache->get(cache, node);
+		if (err)
+			return NULL;
+	}
+	if (node->cn_count == 0) {
+		ASSERT(node->cn_priority >= 0);
+		ASSERT(!list_empty(&node->cn_mru));
+		mru = &cache->c_mrus[node->cn_priority];
+		pthread_mutex_lock(&mru->cm_mutex);
+		mru->cm_count--;
+		list_del_init(&node->cn_mru);
+		pthread_mutex_unlock(&mru->cm_mutex);
+		if (node->cn_old_priority != -1) {
+			ASSERT(node->cn_priority ==
+					CACHE_DIRTY_PRIORITY);
+			node->cn_priority = node->cn_old_priority;
+			node->cn_old_priority = -1;
+		}
+	}
+	node->cn_count++;
+	return node;
+}
+
 /*
  * Lookup in the cache hash table.  With any luck we'll get a cache
  * hit, in which case this will all be over quickly and painlessly.
@@ -377,7 +406,6 @@ cache_node_get(
 	struct cache_node	**nodep)
 {
 	struct cache_hash	*hash;
-	struct cache_mru	*mru;
 	struct cache_node	*node = NULL, *n;
 	unsigned int		hashidx;
 	int			priority = 0;
@@ -411,31 +439,10 @@ cache_node_get(
 			 * from its MRU list, and update stats.
 			 */
 			pthread_mutex_lock(&node->cn_mutex);
-
-			if (node->cn_count == 0 && cache->get) {
-				int err = cache->get(cache, node);
-				if (err) {
-					pthread_mutex_unlock(&node->cn_mutex);
-					goto next_object;
-				}
+			if (!cache_node_grab(cache, node)) {
+				pthread_mutex_unlock(&node->cn_mutex);
+				goto next_object;
 			}
-			if (node->cn_count == 0) {
-				ASSERT(node->cn_priority >= 0);
-				ASSERT(!list_empty(&node->cn_mru));
-				mru = &cache->c_mrus[node->cn_priority];
-				pthread_mutex_lock(&mru->cm_mutex);
-				mru->cm_count--;
-				list_del_init(&node->cn_mru);
-				pthread_mutex_unlock(&mru->cm_mutex);
-				if (node->cn_old_priority != -1) {
-					ASSERT(node->cn_priority ==
-							CACHE_DIRTY_PRIORITY);
-					node->cn_priority = node->cn_old_priority;
-					node->cn_old_priority = -1;
-				}
-			}
-			node->cn_count++;
-
 			pthread_mutex_unlock(&node->cn_mutex);
 			pthread_mutex_unlock(&hash->ch_mutex);
 


