Return-Path: <linux-fsdevel+bounces-22249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B6F9152E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D291281F96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0319D8A1;
	Mon, 24 Jun 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ywMPHRLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DF19D885
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244245; cv=none; b=RbIJoDp6NKeXZraT7c738SfYTgY0j6dcFquzPCrEOrDyQgTECsehtudljIftwQj4BCorTViOWy5mSI94ZBcRksH2T2o09Y9V+eoj3u2DmVi3ccAhI30sTkUosJOpAXdmVBtPicbG4yG3iyZWITChCBaGdR8XRaixZZlh4EvYR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244245; c=relaxed/simple;
	bh=zTg9qQu1Q9PfFTRVh7ZIBSS+v7sQuQTOSzFfZLxIEzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj/uvbPckOG5OrI5xkEVCQ/dLqerV5GJdxvGXBuMThsGBPU+oHFPy24OZfILdslrwWbNM7oN/KaFFeZYLRYW/IeSRv0ZwtBeT6uzOxvBTV+5u/sZHIP/ysZrPsGlNGNzrj6QRopF/g4n8M52l3tQPXheaVRyWmwjB54zw1sAl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ywMPHRLN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bc513ade5so35495737b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244242; x=1719849042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGXgHLDoX3hzupbKihgZmrg0zvt9l8kNFstnfMyRs4I=;
        b=ywMPHRLNc5hNVJV1pVLjiDz1gaP8jqM1eeZxl/iITPqYWHvGAcfz/E0n0+MCccGdVT
         6Ndsi2r028Cc8stXXTnpdmJU3Jxb4KjejuduKsHcpSyJ5tgUPbcQUOI6KoTqi403eUHj
         GNfy3oXghWxRGvw42L1aHFgHbXP2AyLtKMuitvcGoNw1h7X8b7xFMajQUZwuBtsdK8Zk
         169GZwjKYxfjctjUKMuRxJaftwbjh128uCfKqeTm3QaPgnSZ3Vngsf1ilUTgEuRSiQ6w
         0u+HdisaRgAPazAgGtOFR0OjezI4RuzF47lhAhIeBJQMCod8qZA9tp7PDbAcTxgLM7jY
         5WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244242; x=1719849042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGXgHLDoX3hzupbKihgZmrg0zvt9l8kNFstnfMyRs4I=;
        b=Ile9a/dJXrBCkDpA9KBSeADfj4JxwLWqi8sDdYhcGE5iJQNKVadVlIrNm8XXIiaaJE
         tKUIel0+1IQVmfuT1NBmplQWfMvJs6WEzv3MW1ku2gQ4YQ0ZtmhFWmPyif/jxmj45f+N
         iEYGnj3q8oUu32Te7zc/sE45NYcJOgcxNrlI9G7tN4YwhA1wFv/DmSKYx/FISQpSusAs
         mYcI6XiEvmSefjSboOsgSsI6jKvXW1HLRPrdKlZaZpPkHp0xkR+XKG/p2T7u2xK/63fX
         7WM+1ZTdH9NiACd8IkE+pS5NLrTsVTjFEJQqVRaS+/FYWKRjiOWsc+BWrZC1u8DaV1Ve
         w9Pw==
X-Gm-Message-State: AOJu0YyBSqmYnPg4O5MPp/o7Cxenrd3GhpgYaAG0fuEWzwkjRdVN8ZjZ
	sfMrZa5GCPboDBmGrF0p43iwgMKCwfxZQRLQNe5niOXp9MfBEv6JWtrj9ofL4gH1M03R3NJGhME
	R
X-Google-Smtp-Source: AGHT+IG2EDUM3icEp6NwDWZ4vGDXcxUbczZAi0r6lPd/6j9tfFhMZQODGPxohoQzz5SSg3x0e1vYxA==
X-Received: by 2002:a81:b65b:0:b0:632:a329:921b with SMTP id 00721157ae682-643aa5a2029mr46523947b3.1.1719244242457;
        Mon, 24 Jun 2024 08:50:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14a3caa9sm29236307b3.86.2024.06.24.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/8] fs: keep an index of current mount namespaces
Date: Mon, 24 Jun 2024 11:49:46 -0400
Message-ID: <e5fdd78a90f5b00a75bd893962a70f52a2c015cd.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to allow for listmount() to be used on different namespaces we
need a way to lookup a mount ns by its id.  Keep a rbtree of the current
!anonymous mount name spaces indexed by ID that we can use to look up
the namespace.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |   2 +
 fs/namespace.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 4adce73211ae..ad4b1ddebb54 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -16,6 +16,8 @@ struct mnt_namespace {
 	u64 event;
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
+	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
+	refcount_t		passive; /* number references not pinning @mounts */
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index 45df82f2a059..babdebdb0a9c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,6 +78,8 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static DEFINE_RWLOCK(mnt_ns_tree_lock);
+static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by namespace_sem */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -103,6 +105,109 @@ EXPORT_SYMBOL_GPL(fs_kobj);
  */
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
 
+static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
+{
+	u64 seq_b = ns->seq;
+
+	if (seq < seq_b)
+		return -1;
+	if (seq > seq_b)
+		return 1;
+	return 0;
+}
+
+static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
+{
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
+}
+
+static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
+	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
+	u64 seq_a = ns_a->seq;
+
+	return mnt_ns_cmp(seq_a, ns_b) < 0;
+}
+
+static void mnt_ns_tree_add(struct mnt_namespace *ns)
+{
+	guard(write_lock)(&mnt_ns_tree_lock);
+	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
+}
+
+static void mnt_ns_release(struct mnt_namespace *ns)
+{
+	lockdep_assert_not_held(&mnt_ns_tree_lock);
+
+	/* keep alive for {list,stat}mount() */
+	if (refcount_dec_and_test(&ns->passive)) {
+		put_user_ns(ns->user_ns);
+		kfree(ns);
+	}
+}
+DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
+
+static void mnt_ns_tree_remove(struct mnt_namespace *ns)
+{
+	/* remove from global mount namespace list */
+	if (!is_anon_ns(ns)) {
+		guard(write_lock)(&mnt_ns_tree_lock);
+		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
+	}
+
+	mnt_ns_release(ns);
+}
+
+/*
+ * Returns the mount namespace which either has the specified id, or has the
+ * next smallest id afer the specified one.
+ */
+static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
+{
+	struct rb_node *node = mnt_ns_tree.rb_node;
+	struct mnt_namespace *ret = NULL;
+
+	lockdep_assert_held(&mnt_ns_tree_lock);
+
+	while (node) {
+		struct mnt_namespace *n = node_to_mnt_ns(node);
+
+		if (mnt_ns_id <= n->seq) {
+			ret = node_to_mnt_ns(node);
+			if (mnt_ns_id == n->seq)
+				break;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Lookup a mount namespace by id and take a passive reference count. Taking a
+ * passive reference means the mount namespace can be emptied if e.g., the last
+ * task holding an active reference exits. To access the mounts of the
+ * namespace the @namespace_sem must first be acquired. If the namespace has
+ * already shut down before acquiring @namespace_sem, {list,stat}mount() will
+ * see that the mount rbtree of the namespace is empty.
+ */
+static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
+{
+       struct mnt_namespace *ns;
+
+       guard(read_lock)(&mnt_ns_tree_lock);
+       ns = mnt_ns_find_id_at(mnt_ns_id);
+       if (!ns || ns->seq != mnt_ns_id)
+               return NULL;
+
+       refcount_inc(&ns->passive);
+       return ns;
+}
+
 static inline void lock_mount_hash(void)
 {
 	write_seqlock(&mount_lock);
@@ -3736,8 +3841,7 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 	if (!is_anon_ns(ns))
 		ns_free_inum(&ns->ns);
 	dec_mnt_namespaces(ns->ucounts);
-	put_user_ns(ns->user_ns);
-	kfree(ns);
+	mnt_ns_tree_remove(ns);
 }
 
 /*
@@ -3776,7 +3880,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	if (!anon)
 		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
 	refcount_set(&new_ns->ns.count, 1);
+	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
+	RB_CLEAR_NODE(&new_ns->mnt_ns_tree_node);
 	init_waitqueue_head(&new_ns->poll);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
@@ -3853,6 +3959,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
+	mnt_ns_tree_add(new_ns);
 	namespace_unlock();
 
 	if (rootmnt)
@@ -5208,6 +5315,8 @@ static void __init init_mount_tree(void)
 
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
+
+	mnt_ns_tree_add(ns);
 }
 
 void __init mnt_init(void)
-- 
2.43.0


