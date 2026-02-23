Return-Path: <linux-fsdevel+bounces-78189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAGhNf/mnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DC17FF4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FE03135E83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4C37FF7C;
	Mon, 23 Feb 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwXpNKoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDF37FF63;
	Mon, 23 Feb 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890328; cv=none; b=sC1zS2+FgEkQ9OJ5AQU3EGwcb2CFJQOAxInO+b8Sge93wwBfLDHzuVaTUQjaadOZuZGnbLpvybuW+iEpUa7Gh1d8YNf7w+jPEWYA3nC4XkWeYdklezRP46z3Ks7JyatXS99uIp6wXLHaK2BBZDwEdd9l71w6UldPEVWwoyhUVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890328; c=relaxed/simple;
	bh=1GTxVZsgRq6tzKbJvKBuXlUgWCknnr/GJP2gVnSsads=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ4brBIyCiKTtmU5I3c+15Vmh1Y6DcECW2Yl5u6tFICrPz9DA8Oo7ruoi/qu5vIfCauUU3G5NHkdwPpLi/mGr8gUGNvfSkK8pqI3rMGSkK+r++qv0C42Oy9gY42KYQ4zr8ULAZsDjnlw/k/7yWOwtkj9wqsL9n2rn7qkRG2j8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwXpNKoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC0C116C6;
	Mon, 23 Feb 2026 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890327;
	bh=1GTxVZsgRq6tzKbJvKBuXlUgWCknnr/GJP2gVnSsads=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HwXpNKoyI+2QmlDkqHsvv1aqD3MZPKMewYBjlJq8orRNdynub2kuZtA86f3tZjZy4
	 GqiKXaN4IKP5dpRXGIJasP2rzlmGTNKA3y4OTX8y9j9htafT1FmC3vkUtZ90lYC/iu
	 XkB1TMHXqCx0p4Ay+v9D/fb1VzMqnKoqvnqeHIaLeb6OVOT48kzG6rZzaIOMR4KnBK
	 5badTiVFcE+Lttl+1xCNNEGoSQ8+4l+UwJwA05uCGXEX34szdG4PPSflit6fpZG3sR
	 lX94X9wet6hGbuyqufl0tOCbxBaiuPe+E8eBcyalqSAQP/qGNwLNw6Jmvp/pH2v7nA
	 14MHk4EzeQI0w==
Date: Mon, 23 Feb 2026 15:45:27 -0800
Subject: [PATCH 3/6] iocache: bump buffer mru priority every 50 accesses
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745746.3944626.16444737231427152879.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
References: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78189-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 847DC17FF4C
X-Rspamd-Action: no action

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
index b72dcb7ebb470a..478d89174422df 100644
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


