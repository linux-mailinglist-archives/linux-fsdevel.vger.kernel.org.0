Return-Path: <linux-fsdevel+bounces-61604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADEB58A38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF0D3B89B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6F1C5F23;
	Tue, 16 Sep 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlPMdyzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252CFC1D;
	Tue, 16 Sep 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984043; cv=none; b=FckjvbWrsgmGmhADwdCNsb2KEMSjt9Qc8du+A02UOQ5oDSN3m5z/bRrTQQ9dZ5oboKfy4DLPmZneKSuQbrBfmAvzLehZFhgvpeGVxTcMde3c96JG2DR9P1JQSlBnMvOPgiVCCldivdEgTJAl+qHN7K+FJILYab1t5kDFO8SOE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984043; c=relaxed/simple;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+QgX7bkRZSnYgbuu+peVchpPZ0svmPf5r4q/nAosYrNTLte0JUB+B8b1dcDitij5Ies+u50cfNfocXQMyWEfChJ4FGH8yzaHRnoCEcpcDMdGmJJc5TiTUCMISpnpj3qq79LPWDevnr9Uyq1xKSC7TfrrUD100E9fbQgO/KPLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlPMdyzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33AAC4CEF1;
	Tue, 16 Sep 2025 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984042;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LlPMdyzGAYd2Kpv1qm6JhIEL+vuhbc5k6zfiSidKv0wouYsMi3sm+fCC6zJ1+lFQc
	 F9FM6k2lRtQO3l29rb8174JpN1ROt5ONIV8NRVBdhDLVzowbj3R/9kw/nEI4dhxJj/
	 w3iZ5wErCf895aDFfg+N46McyQbQsO++gLpFNDPs4/mYTYrhauuFEmeNaDr2dJw9kR
	 DxgVKYVoSVNyD9jxhYHyfPueVf/j3QhAAxXbp2FdiRkQ3eMYsCY75yXjCgJ/Zyru07
	 Kl7vzEXVnukXy16jAg9yM3dQC1LZY2ygg2JHZFeZZ8oLv9v7AFcNitFM1pJQIC1h/z
	 vRAtu6BmSraHQ==
Date: Mon, 15 Sep 2025 17:54:02 -0700
Subject: [PATCH 13/21] cache: add a helper to grab a new refcount for a
 cache_node
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161010.389252.14054436598306478504.stgit@frogsfrogsfrogs>
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
 


