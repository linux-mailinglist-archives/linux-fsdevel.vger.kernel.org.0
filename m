Return-Path: <linux-fsdevel+bounces-58514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC8B2EA33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEC4560186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F621F873B;
	Thu, 21 Aug 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITj0ND7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1345FEE6;
	Thu, 21 Aug 2025 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738692; cv=none; b=bwhIIR8H+9opUFaIuPFwU0w8yW1LPldAawT1fuvknrVsikLW/+l5orQo51lZn2eXUedUVheBSaksmqxsmTaIbDTgGlqSCxj0MbY1VuERRpqhq9qP9GZR2w5sIfAVFVhfzuck2RFTXLWdXPmwVvoJislmIlWW4NdRfIA2mJ+qodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738692; c=relaxed/simple;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i77azAxwyeHm3/Q5cWmRXP36MgoOnBLsfpHDQul1QT7m2xZT8bgMzh6JodtBVW5h/+ICSi3Et4GshcKfaXB4IpDaqNS8ngenuKkTfr2CrTaSJsNr3F2XO/ojl4HheKE04sFLEqyH2KmqdeKyjQBeAGCnQM+bhjC70XiipzDwA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITj0ND7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DC7C4CEE7;
	Thu, 21 Aug 2025 01:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738692;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ITj0ND7SklT6zxX38zEaD0HflxCvqZT1buBlzfBRdu1apMdy/AhCfOMpiVMcRUVuS
	 eG/FlUW8ZOYVdseJGWY8mdxwqRRO5trccofHyQzUFYePK0P0LhFFUiUnb+6ajDw+YI
	 9YEtWWG9ooLPyQ8LDy+pC8uIRA2fBFlap6hKmrn2OPFYv6RqASUj6HpNGy3iYwNp4y
	 HF9y0sSigV/TabNPJ+fvEewrsTsAdtwymoE/z0sNobHnnCwZVJ1HhxBOYNuAkHKabb
	 +5148+Ekrhvcs+4wcXmJTzEA2BKn0kGc/TtBVE2exldO/7lNNegv9HE97AOVc6b5Mv
	 thUJStAt0grKQ==
Date: Wed, 20 Aug 2025 18:11:31 -0700
Subject: [PATCH 14/20] cache: add a "get only if incore" flag to
 cache_node_get
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713060.20753.7102446050470625029.stgit@frogsfrogsfrogs>
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


