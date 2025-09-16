Return-Path: <linux-fsdevel+bounces-61657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E7B58AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B370B2A3DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEDE1E1C02;
	Tue, 16 Sep 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Wkq34E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FA1C84B8;
	Tue, 16 Sep 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984857; cv=none; b=Rx8Utr5nypXoUfxw7Tmm8qoI5S9o2BqFWFIXIVIOs53c40PWanKXw5SFcPHGrn6k1BI/OJUg7O54mQnkVGtyiOPruzLmGF50x2kaZ9E07qW5pid61q3rSmSmyu+6lHU40BG0g3Fd/SIz+c7B10ZKTIMzNsp+8ZWfdhry9qISYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984857; c=relaxed/simple;
	bh=BtgeHQ0V3GS2KYWplr9owAhAadOHkJzfP4WUMSgNtIk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRWueTRIprK0f/8wjhd7RzR1XURA//mavWo0zfxQU5/3QnfeXjrgcZ/+gHdjDO0VYiOZH6CFCxQsm7Pm94NwFuPCY6ke08O26RKKLBAc3DoyoUXxymuZ2G86T133sJhTfQvHcm+kMcDOaFY9Ad6N3XRxY+9DPcUnS3ijYS5OOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Wkq34E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E849C4CEF1;
	Tue, 16 Sep 2025 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984857;
	bh=BtgeHQ0V3GS2KYWplr9owAhAadOHkJzfP4WUMSgNtIk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V1Wkq34ECtbHH6y4fciZISeBJaqdCDwSrKMlm+RehlLD+OjqVJmafJ0q6Y3De2ZTu
	 dJ6Mq6NvdOoqR113jS91Wt8Wl+F0Wa259DdnVVJ3PpodEawuR9BkMD8zrPue900OmM
	 2OiIhKpgcCG+WYw/IYX++i0SGRL9Rk1Z20KPjJ0o4Up5ZVWTNjsPG2x3KAxPLY2dcg
	 JFDFZfrMOEahJ2+nuqK0Qr9BdrjchIob4joaOmP093a4D4seYGjUBl0VtxXeO3v1Nr
	 6jgKCh/wsC9I1S3zVBaZgtolxd9a2FfK5SUdOOBrAl40nPHcBn73jgd/oee5wNNlEZ
	 JBL4DbVt5RF7g==
Date: Mon, 15 Sep 2025 18:07:36 -0700
Subject: [PATCH 3/6] iocache: bump buffer mru priority every 50 accesses
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162906.391868.12371905303539413042.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
References: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
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


