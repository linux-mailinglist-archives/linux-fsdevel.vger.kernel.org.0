Return-Path: <linux-fsdevel+bounces-11922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D98592A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39961C220EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C27F7F9;
	Sat, 17 Feb 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKKwFZ37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C827EEF6;
	Sat, 17 Feb 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201444; cv=none; b=pbJ/J5lzUyr9ya4iOqBG4Aa6YxjHifo+tGcPKmibd4WxwPmu6zyXPYMEMycmX5Pp0BOQaGj7ohbz8wfUt7PgiZy+R4zL5BMCuzeUsi5mYUbKXbAdPZb+V5lUwMbQ47dDoOuHevTHpMBFH5x07LeKZkuBvQztyh9yeoyEuurLr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201444; c=relaxed/simple;
	bh=B9f3lBdgCzE5vmYqmwo7dByZImNHwFkUKnKEUUxLAe8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bypAK7cDnMOjxr++vqKsoaLywbIxuiXLvSbaIOBbQ0eynB6eaBBFS1xPeqiie1pFUqhNWVBGdSUWypA9xhqEwJKLHyDWMlfLTgDJPtdvSo6klTFZ3C8NbBCeSEWCW4j8RLI/zCitSqQ8NLZpZ4OQWTPDsUYqYmpY8GkYBC1u61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKKwFZ37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44EAC43390;
	Sat, 17 Feb 2024 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201443;
	bh=B9f3lBdgCzE5vmYqmwo7dByZImNHwFkUKnKEUUxLAe8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LKKwFZ378z7nftyteopcpFImAvTgQDtbs6xRUS2AQ1HltVj6RhcqOIUwjYinyg1U0
	 GDDicWz5fjRAz4dbG9+0SL6K5hMzvUbHJ35XkN5ywzAsR9cfQwY7TiXSjSZ5oW5sit
	 undKjeWvGc1a7gM6AwMn9yB8nc1zUm8pz2QzWsQo05o28qpCqLf2sWiKayXQCsipgw
	 jNNOwjHB+9U8UjoIo9pD7Bo4l23YoRl2ygwooQhBOhzIhhnzp4mn5QrKSRmh/jZqPz
	 q+XtUJWAzB7Cp2QTyfet6z7B5fjdWN0dgaLuOaU6PxCE6WYPA56RHSrvUhzJQpBufG
	 lsiQTs4cxaUfA==
Subject: [PATCH v2 4/6] maple_tree: Add mtree_alloc_cyclic()
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:24:01 -0500
Message-ID: 
 <170820144179.6328.12838600511394432325.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

I need a cyclic allocator for the simple_offset implementation in
fs/libfs.c.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/maple_tree.h |    7 +++
 lib/maple_tree.c           |   93 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index b3d63123b945..a53ad4dabd7e 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -171,6 +171,7 @@ enum maple_type {
 #define MT_FLAGS_LOCK_IRQ	0x100
 #define MT_FLAGS_LOCK_BH	0x200
 #define MT_FLAGS_LOCK_EXTERN	0x300
+#define MT_FLAGS_ALLOC_WRAPPED	0x0800
 
 #define MAPLE_HEIGHT_MAX	31
 
@@ -319,6 +320,9 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
@@ -499,6 +503,9 @@ void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6f241bb38799..af0970288727 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4290,6 +4290,56 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+/**
+ * mas_alloc_cyclic() - Internal call to find somewhere to store an entry
+ * @mas: The maple state.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, or -EBUSY if there are no
+ * free entries.
+ */
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	unsigned long min = range_lo;
+	int ret = 0;
+
+	range_lo = max(min, *next);
+	ret = mas_empty_area(mas, range_lo, range_hi, 1);
+	if ((mas->tree->ma_flags & MT_FLAGS_ALLOC_WRAPPED) && ret == 0) {
+		mas->tree->ma_flags &= ~MT_FLAGS_ALLOC_WRAPPED;
+		ret = 1;
+	}
+	if (ret < 0 && range_lo > min) {
+		ret = mas_empty_area(mas, min, range_hi, 1);
+		if (ret == 0)
+			ret = 1;
+	}
+	if (ret < 0)
+		return ret;
+
+	do {
+		mas_insert(mas, entry);
+	} while (mas_nomem(mas, gfp));
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
+
+	*startp = mas->index;
+	*next = *startp + 1;
+	if (*next == 0)
+		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
+
+	return ret;
+}
+EXPORT_SYMBOL(mas_alloc_cyclic);
+
 static __always_inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
 retry:
@@ -6443,6 +6493,49 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 }
 EXPORT_SYMBOL(mtree_alloc_range);
 
+/**
+ * mtree_alloc_cyclic() - Find somewhere to store this entry in the tree.
+ * @mt: The maple tree.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Finds an empty entry in @mt after @next, stores the new index into
+ * the @id pointer, stores the entry at that index, then updates @next.
+ *
+ * @mt must be initialized with the MT_FLAGS_ALLOC_RANGE flag.
+ *
+ * Context: Any context.  Takes and releases the mt.lock.  May sleep if
+ * the @gfp flags permit.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * allocated, -EINVAL if @mt cannot be used, or -EBUSY if there are no
+ * free entries.
+ */
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	int ret;
+
+	MA_STATE(mas, mt, 0, 0);
+
+	if (!mt_is_alloc(mt))
+		return -EINVAL;
+	if (WARN_ON_ONCE(mt_is_reserved(entry)))
+		return -EINVAL;
+	mtree_lock(mt);
+	ret = mas_alloc_cyclic(&mas, startp, entry, range_lo, range_hi,
+			       next, gfp);
+	mtree_unlock(mt);
+	return ret;
+}
+EXPORT_SYMBOL(mtree_alloc_cyclic);
+
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp)



