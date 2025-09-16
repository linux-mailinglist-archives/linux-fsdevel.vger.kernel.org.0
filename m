Return-Path: <linux-fsdevel+bounces-61606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A17B58A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43EB3BA56D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDB1C8621;
	Tue, 16 Sep 2025 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVzTpuPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B464FC1D;
	Tue, 16 Sep 2025 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984074; cv=none; b=IHKYoz4xxH3OqnML1KrGw54hcbat2PsZdNgQYK592F7C5rej7TBKVKmxwdX/YDERY5k8SEnoFF0+lFGmg1kV9hkYMI3pApxhnYm90MLLaVeCwewTfE/1SA4gS+MQ1wEWYBBhgpLbFrdaJKPUwVoOiIAWItCYwB3CZx70fWBlYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984074; c=relaxed/simple;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6mpmITC59opS9ADtjdVkBB0q6tT2ZLz7QAlcrtofwkG9V48AD7aBPa8uBKcTPn77INssHUypdfL0dViHGUFeMNdT+9wvZAY9UlneLN3XQr7cHDKIq95zsc+x92xF3FBKgj2d9CKK0Mo0HlGpb5XwJCpq8EZZ7uSP120w4nM3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVzTpuPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B56EC4CEF1;
	Tue, 16 Sep 2025 00:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984074;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EVzTpuPBUZD4YO0dQRAj7s6M14HBAh1EAwCVut2CWRKVymLr6WRCq5o0UBI6Qwk7i
	 xBJSOm9hwNwfHJb/GF7slRJ9jRDenEzORv8GzNmfKV8hycOks1uvOIxLO/bJHWfifl
	 TBsJNrdScP74lFNNY00swon77zJhftwSRQOtzh2pfPoW9FcPivfUcSVYfyuncupZ6j
	 KFwQvOGleAhlB0uvBcs/jFJVSN8PYOgnjmCPMz78RAZak40hikfbikakA5+9gNEhnO
	 mONZdY2PtZFsMywJXolQUDjXU00ZB2Qtl4CCJTRkQQYlugn53a4mrJRaq6xtvrrzcZ
	 87/P7GpZ/Zphw==
Date: Mon, 15 Sep 2025 17:54:33 -0700
Subject: [PATCH 15/21] cache: add a "get only if incore" flag to
 cache_node_get
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161046.389252.16365666297772843985.stgit@frogsfrogsfrogs>
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

Add a new flag to cache_node_get so that callers can specify that they
only want the cache to return an existing cache node, and not create a
new one.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    5 ++++-
 lib/support/cache.c |    7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 8d39ca5c02a285..98b2182d49a6e0 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -134,7 +134,10 @@ void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
 
-int cache_node_get(struct cache *, cache_key_t, struct cache_node **);
+/* don't allocate a new node */
+#define CACHE_GET_INCORE	(1U << 0)
+int cache_node_get(struct cache *c, cache_key_t key, unsigned int cgflags,
+		   struct cache_node **nodep);
 void cache_node_put(struct cache *, struct cache_node *);
 void cache_node_set_priority(struct cache *, struct cache_node *, int);
 int cache_node_get_priority(struct cache_node *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index fa07b4ad8222d2..9da6c59b3b6391 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -403,6 +403,7 @@ int
 cache_node_get(
 	struct cache		*cache,
 	cache_key_t		key,
+	unsigned int		cgflags,
 	struct cache_node	**nodep)
 {
 	struct cache_hash	*hash;
@@ -456,6 +457,12 @@ cache_node_get(
 			continue;	/* what the hell, gcc? */
 		}
 		pthread_mutex_unlock(&hash->ch_mutex);
+
+		if (cgflags & CACHE_GET_INCORE) {
+			*nodep = NULL;
+			return 0;
+		}
+
 		/*
 		 * not found, allocate a new entry
 		 */


