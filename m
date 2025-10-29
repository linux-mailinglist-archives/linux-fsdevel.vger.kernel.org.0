Return-Path: <linux-fsdevel+bounces-66128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1EC17D89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE70B189A407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B02D027E;
	Wed, 29 Oct 2025 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F79sMLSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00036EEBB;
	Wed, 29 Oct 2025 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700670; cv=none; b=qyOCh118KMgLPfUWBqHj7/4QmiGzvQ7MxN4O91EG9haFy8rgvp+0qM2ZfH82vP2RZEH7a+ufnaIgwEOe4ykYLlKHGMxMSM6ezymFZ5b5FIux52h+V5WmUKu+O29EyImOjuHOI0e2Pw14/M9hvPqirqKTMi/hfGFvTS8+FjWxlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700670; c=relaxed/simple;
	bh=W/NmN718d1BvO8qDpfeWL6yUTR2/1Vt6UTwaUeEsqmY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0NR8ptYdXi9vH9ZOvhkFkon8r5gHC/Qu4I8vdRQXlRKBSgu2XLomNworUNMGsQcPNk5UBrgsYNWFJ7UM668JRH47UoVHA9GTjRQACu6hQrXCrnqJPuGDMFu31xhZB8Ru9YvlU4gxDSzd+r7yI5gYvLSKNN9xTfDkWplMOQSgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F79sMLSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0EAC4CEE7;
	Wed, 29 Oct 2025 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700669;
	bh=W/NmN718d1BvO8qDpfeWL6yUTR2/1Vt6UTwaUeEsqmY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F79sMLSBiZu7yJGO81p7VH85ea2Ne491K+pVkDBxROTIQP60vsI7LCwveJspbM9E8
	 Uqf5YOENWlXfJR92tbO4/jbatvEOTb6e/gljhh5is95C8RGdH1yEz+8IYyCrkPoFrt
	 /afY8QZsPLKhqlmGaESBsdPdgxEGsEC+THaZjfHPrsrOqDWOXo10toZ+W8rUAQhNdI
	 tCjwox4F9Iusa2gC/7C11BhNgiCidqwdoWTp9zZl1v131/FkdSyyNLHclI+cnxicsJ
	 zuG3zmfqbVZLx0pomxI+Tt2YzilIQqB0yXHjNbBsBuQa3D7Lf+LzAoC8QcCd1EmFXV
	 51bXy2zkUdjOA==
Date: Tue, 28 Oct 2025 18:17:49 -0700
Subject: [PATCH 3/6] iocache: bump buffer mru priority every 50 accesses
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818816.1431012.10277271474771347610.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
References: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If a buffer is hot enough to survive more than 50 access without being
reclaimed, bump its priority to the next MRU so it sticks around longer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h   |    1 +
 lib/support/cache.c   |   16 ++++++++++++++++
 lib/support/iocache.c |    9 +++++++++
 3 files changed, 26 insertions(+)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 71fb9762f97866..d81726288bdc88 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -180,5 +180,6 @@ int cache_node_purge(struct cache *, cache_key_t, struct cache_node *);
 void cache_report(FILE *fp, const char *, struct cache *);
 int cache_overflowed(struct cache *);
 struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node);
+void cache_node_bump_priority(struct cache *cache, struct cache_node *node);
 
 #endif	/* __CACHE_H__ */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 3a9e276f11af72..513a71829193a8 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -678,6 +678,22 @@ cache_node_put(
 		cache_shrink(cache);
 }
 
+/* Bump the priority of a cache node.  Caller must hold cn_mutex. */
+void
+cache_node_bump_priority(
+	struct cache		*cache,
+	struct cache_node	*node)
+{
+	int			*priop;
+
+	if (node->cn_priority == CACHE_DIRTY_PRIORITY)
+		priop = &node->cn_old_priority;
+	else
+		priop = &node->cn_priority;
+	if (*priop < CACHE_MAX_PRIORITY)
+		(*priop)++;
+}
+
 void
 cache_node_set_priority(
 	struct cache *		cache,
diff --git a/lib/support/iocache.c b/lib/support/iocache.c
index dc83b92bf53a25..1bcae2e7e98eed 100644
--- a/lib/support/iocache.c
+++ b/lib/support/iocache.c
@@ -57,6 +57,7 @@ struct iocache_buf {
 	blk64_t			block;
 	void			*buf;
 	errcode_t		write_error;
+	uint8_t			access;
 	unsigned int		uptodate:1;
 	unsigned int		dirty:1;
 };
@@ -566,6 +567,10 @@ static errcode_t iocache_read_blk64(io_channel channel,
 		}
 		if (ubuf->uptodate)
 			memcpy(buf, ubuf->buf, channel->block_size);
+		if (++ubuf->access > 50) {
+			cache_node_bump_priority(&data->cache, node);
+			ubuf->access = 0;
+		}
 		iocache_buf_unlock(ubuf);
 		cache_node_put(&data->cache, node);
 		if (retval)
@@ -627,6 +632,10 @@ static errcode_t iocache_write_blk64(io_channel channel,
 				     ubuf->uptodate ? CACHE_HIT : CACHE_MISS);
 		ubuf->dirty = 1;
 		ubuf->uptodate = 1;
+		if (++ubuf->access > 50) {
+			cache_node_bump_priority(&data->cache, node);
+			ubuf->access = 0;
+		}
 		iocache_buf_unlock(ubuf);
 		cache_node_put(&data->cache, node);
 	}


