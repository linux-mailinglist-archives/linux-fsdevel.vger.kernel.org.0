Return-Path: <linux-fsdevel+bounces-58562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E5B2EA9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C450D4E47B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2B218AC4;
	Thu, 21 Aug 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1k1nF2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19020B81B;
	Thu, 21 Aug 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739443; cv=none; b=pUc76Ar9iFMkMFe4B2SdQ+UmVAMXaDkDXsBPVNWiPAXDaEbdr2gLllGHWvGh8dtMDQcgCiL3V6hG+y2761BbCN6dVONAl+OhwJuvxgdwEKS/7nG5+/dsI61fC1AB7mAU3ys51mLrX2HFbvhHdS0IunT8cbRjTTyiVw0pIprmtwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739443; c=relaxed/simple;
	bh=BtgeHQ0V3GS2KYWplr9owAhAadOHkJzfP4WUMSgNtIk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km08bKNmPyTd9jUC+0Ex25Q7IFV+YN7qP0dByUZ9GNDUd+ueYiD5OTznnuSd/0Ok2tg7AyJWM1N3W3LEcBUa1HMTcjCg1T0oHVWr/RNvOT+Stohr754X7PZuOZkuyM74QpOSVLUS90hOPXubimTi+HUGxMpHp+R2Ea+S4KX+Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1k1nF2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCAAC4CEE7;
	Thu, 21 Aug 2025 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739443;
	bh=BtgeHQ0V3GS2KYWplr9owAhAadOHkJzfP4WUMSgNtIk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A1k1nF2Q1bk5vTowM4pXJVQZuf/ub3PjApkCLeU6zP4KeGoOK733/2n2hJIRD+Cfa
	 rHPDbweGCYfyudmXYp9yu1GqlQljgnyAMuSjmjcwVNCFLEfQGglsM60Nt//PkN4Cqe
	 OmYdJbKmKsfikH2vrcEaxIB0Zjw0LPtdY83jPY4buO/gIczi3um7mAI5udHSo9baym
	 HorDThTXbxiAoCIsGB/VvkVrOHhUZtd0AK3RVTHuWGoBSgcyDyWqT9Iu4fA0hxkNby
	 A7wxSHiJbNsxVbdd0e+ecXoziB6TuBvdVzv8NNtQexiYcIjCJP7rZe9rNcSi9aPIO9
	 Kh35Bg0GanSDg==
Date: Wed, 20 Aug 2025 18:24:02 -0700
Subject: [PATCH 3/6] iocache: bump buffer mru priority every 50 accesses
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714739.23206.12116207842770589907.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
References: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
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
index f482948a3b6331..5a8e19f5d18e78 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -173,5 +173,6 @@ int cache_node_purge(struct cache *, cache_key_t, struct cache_node *);
 void cache_report(FILE *fp, const char *, struct cache *);
 int cache_overflowed(struct cache *);
 struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node);
+void cache_node_bump_priority(struct cache *cache, struct cache_node *node);
 
 #endif	/* __CACHE_H__ */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 7e1ddc3cc8788d..34df5cb51cd5e4 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -649,6 +649,22 @@ cache_node_put(
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
index ab879e85d18f2a..92d88331bfa54d 100644
--- a/lib/support/iocache.c
+++ b/lib/support/iocache.c
@@ -56,6 +56,7 @@ struct iocache_buf {
 	blk64_t			block;
 	void			*buf;
 	errcode_t		write_error;
+	uint8_t			access;
 	unsigned int		uptodate:1;
 	unsigned int		dirty:1;
 };
@@ -552,6 +553,10 @@ static errcode_t iocache_read_blk64(io_channel channel,
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
@@ -613,6 +618,10 @@ static errcode_t iocache_write_blk64(io_channel channel,
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


