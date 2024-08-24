Return-Path: <linux-fsdevel+bounces-27051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C495DFBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC30D28299A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7113D525;
	Sat, 24 Aug 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mCLuZi00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E1AD2F
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526638; cv=none; b=Mg2yIcZ5E2xJVpfs6ginfxsxrNCjG2q6rVS6mP2MTihI1rXR8+eVJs/xYPhARiSoVAnefngLbUsr8XrN5edmWy7IdfgAvUWXfwtfUiyZCmpJ4kCJMzxnMjSoGgcKkPXTW2xhJVw/udAzVXi8C1sWriuiR73M/NdQfUbiYQACWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526638; c=relaxed/simple;
	bh=oKgFv7Jp7bpJCvOdgPbRzNv4IjcDB5EtoVbMkFkeg50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwY5ONlfqkXorICHVmhh427cGIiSQO5GunOS3Bto6sS6+PG3ohVY6ctT8Hj138UBiUHG879rcfYojNDEt1/5k7GAz70sifivK+IF6ddiqvVk2RSH9lzJSkquYMkfEXUCpnmz31ZpvbenjQx4riCHip3koiwaRP6wImEutHuekpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mCLuZi00; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKBGRtsPyUvtp5wY3XaRsK5eF/sYhIfHRSgUQREqSSc=;
	b=mCLuZi006yPmOyvt4ug0F4H1yPxKHuV9w05Ji8hemfGYpuf7LzRQHiP+mDAQOJd31WpCHF
	A33rHCZsgG1Pu04hRLc9VGB3RSXW3BcUNa5eYsPdzVsl04tag5XniOIN+/gE/SXw8dJrJ2
	vqZXONnqFtGa2PzU4Y6k31vMpVt0cu8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 06/10] bcachefs: shrinker.to_text() methods
Date: Sat, 24 Aug 2024 15:10:13 -0400
Message-ID: <20240824191020.3170516-7-kent.overstreet@linux.dev>
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds shrinker.to_text() methods for our shrinkers and hooks them up
to our existing to_text() functions.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_cache.c     | 13 +++++++++++++
 fs/bcachefs/btree_key_cache.c | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 662f0f79b7af..9f096fdcaf9a 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -15,6 +15,7 @@
 
 #include <linux/prefetch.h>
 #include <linux/sched/mm.h>
+#include <linux/seq_buf.h>
 
 #define BTREE_CACHE_NOT_FREED_INCREMENT(counter) \
 do {						 \
@@ -487,6 +488,17 @@ static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 	return btree_cache_can_free(bc);
 }
 
+static void bch2_btree_cache_shrinker_to_text(struct seq_buf *s, struct shrinker *shrink)
+{
+	struct bch_fs *c = shrink->private_data;
+	char *cbuf;
+	size_t buflen = seq_buf_get_buf(s, &cbuf);
+	struct printbuf out = PRINTBUF_EXTERN(cbuf, buflen);
+
+	bch2_btree_cache_to_text(&out, &c->btree_cache);
+	seq_buf_commit(s, out.pos);
+}
+
 void bch2_fs_btree_cache_exit(struct bch_fs *c)
 {
 	struct btree_cache *bc = &c->btree_cache;
@@ -570,6 +582,7 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
 	bc->shrink = shrink;
 	shrink->count_objects	= bch2_btree_cache_count;
 	shrink->scan_objects	= bch2_btree_cache_scan;
+	shrink->to_text		= bch2_btree_cache_shrinker_to_text;
 	shrink->seeks		= 4;
 	shrink->private_data	= c;
 	shrinker_register(shrink);
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index 2e49ca71194f..af84516fb607 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -13,6 +13,7 @@
 #include "trace.h"
 
 #include <linux/sched/mm.h>
+#include <linux/seq_buf.h>
 
 static inline bool btree_uses_pcpu_readers(enum btree_id id)
 {
@@ -746,6 +747,18 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
 {
 }
 
+static void bch2_btree_key_cache_shrinker_to_text(struct seq_buf *s, struct shrinker *shrink)
+{
+	struct bch_fs *c = shrink->private_data;
+	struct btree_key_cache *bc = &c->btree_key_cache;
+	char *cbuf;
+	size_t buflen = seq_buf_get_buf(s, &cbuf);
+	struct printbuf out = PRINTBUF_EXTERN(cbuf, buflen);
+
+	bch2_btree_key_cache_to_text(&out, bc);
+	seq_buf_commit(s, out.pos);
+}
+
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 {
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
@@ -770,6 +783,7 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 	bc->shrink = shrink;
 	shrink->count_objects	= bch2_btree_key_cache_count;
 	shrink->scan_objects	= bch2_btree_key_cache_scan;
+	shrink->to_text		= bch2_btree_key_cache_shrinker_to_text;
 	shrink->batch		= 1 << 14;
 	shrink->seeks		= 0;
 	shrink->private_data	= c;
-- 
2.45.2


