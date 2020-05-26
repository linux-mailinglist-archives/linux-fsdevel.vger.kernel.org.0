Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B681E271C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbgEZQdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgEZQdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 12:33:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C06BC03E96F
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 09:33:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so6980818wru.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LS90sTALd8NA7/cmV0YDVxNZyjsIa6ptfH5wlHsa5io=;
        b=Blo2qDxOJplXQ6zslD8qIDWVLd8bWHl2nb2DDJ/wyWbnE2+NKd/CkFu91/gTomj3IK
         Q87orf5ffNk6LhW+aDLJyIDsT4a7wGM+hpcVLGeQD0bnLwFTAClUSDp3Y0uwdWjMc4iT
         bk06ozm91Vcti7BAw5q7P+nLPtAGfCTqucU80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LS90sTALd8NA7/cmV0YDVxNZyjsIa6ptfH5wlHsa5io=;
        b=optH5bwfapv0iW2Hh2pTO//qMSJHtWJ/6FyJcSGEGtSZQX7bhVtCiDlN5bvy4VvAfU
         q6liIufgoqYtFhfYrPyHlnjMQQ/34Gj5BezBidqKPBfW7mmgLodewPYr1sZb2h+PzfFz
         tXIH/6ai9VVGi1LqPIrniF9i8+801PlCAcT26qbeGVMTK6BCXkCY38p68NQd17uCWj4f
         uKDOe+MGOJ/c1GHDeiMfoPFbg7rMIP6rHWHl9HKSGdsmZu2MmfVjGt87/Jn75llY6ZuC
         oS4yZ3ByBipt6p6/MINAhGk6pIgzwFtmlAlbtnxGYeubkaF9hYKk119KdSDga1Usfwl+
         ObUQ==
X-Gm-Message-State: AOAM532cwSWiqe1XMkuzxUXx1Y1ypvJa98SFi/vLa1044chUMYLbmBZQ
        NBdp76t33D01RTjBbfgEjs8frw==
X-Google-Smtp-Source: ABdhPJxWgfoH9yiX3rP2woDNw4FDLvNtqHCl7MYPyFiZ8pjikrxK8QnY0lsDYDkj0donn2Ue/POSrw==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr19279970wrs.356.1590510819423;
        Tue, 26 May 2020 09:33:39 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id k17sm48654wmj.15.2020.05.26.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:33:38 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 1/4] bpf: Generalize bpf_sk_storage
Date:   Tue, 26 May 2020 18:33:33 +0200
Message-Id: <20200526163336.63653-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200526163336.63653-1-kpsingh@chromium.org>
References: <20200526163336.63653-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Refactor the functionality in bpf_sk_storage.c so that concept of
storage linked to kernel objects can be extended to other objects like
inode, task_struct etc.

bpf_sk_storage is updated to be bpf_local_storage with a union that
contains a pointer to the owner object. The type of the
bpf_local_storage can be determined using the newly added
bpf_local_storage_type enum.

Each new local storage will still be a separate map and provide its own
set of helpers. This allows for future object specific extensions and
still share a lot of the underlying implementation.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf_local_storage.h}                      |   6 +-
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  13 +-
 kernel/bpf/Makefile                           |   4 +
 .../bpf/bpf_local_storage.c                   | 593 ++++++++++--------
 kernel/bpf/cgroup.c                           |   2 +-
 net/bpf/test_run.c                            |   2 +-
 net/core/Makefile                             |   1 -
 net/core/filter.c                             |   2 +-
 net/core/sock.c                               |   2 +-
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/ipv4/inet_diag.c                          |   2 +-
 tools/include/uapi/linux/bpf.h                |  13 +-
 13 files changed, 365 insertions(+), 281 deletions(-)
 rename include/{net/bpf_sk_storage.h => linux/bpf_local_storage.h} (93%)
 rename net/core/bpf_sk_storage.c => kernel/bpf/bpf_local_storage.c (63%)

diff --git a/include/net/bpf_sk_storage.h b/include/linux/bpf_local_storage.h
similarity index 93%
rename from include/net/bpf_sk_storage.h
rename to include/linux/bpf_local_storage.h
index 5036c94c0503..85524f18cd91 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2019 Facebook */
-#ifndef _BPF_SK_STORAGE_H
-#define _BPF_SK_STORAGE_H
+#ifndef _BPF_LOCAL_STORAGE_H
+#define _BPF_LOCAL_STORAGE_H
 
 struct sock;
 
@@ -47,4 +47,4 @@ static inline int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 }
 #endif
 
-#endif /* _BPF_SK_STORAGE_H */
+#endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 3e8c6d4b4b59..06b093788eb6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -245,7 +245,7 @@ struct sock_common {
 	/* public: */
 };
 
-struct bpf_sk_storage;
+struct bpf_local_storage;
 
 /**
   *	struct sock - network layer representation of sockets
@@ -516,7 +516,7 @@ struct sock {
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
-	struct bpf_sk_storage __rcu	*sk_bpf_storage;
+	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 97e1fd19ff58..4a202eea15c0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2788,10 +2788,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
- *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
- *		together with **BPF_SK_STORAGE_GET_F_CREATE** to specify
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
  *		the initial value of a bpf-local-storage.  If *value* is
  *		**NULL**, the new bpf-local-storage will be zero initialized.
  *	Return
@@ -3388,11 +3388,16 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
 
+
 /* BPF_FUNC_read_branch_records flags. */
 enum {
 	BPF_F_GET_BRANCH_RECORDS_SIZE	= (1ULL << 0),
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 375b933010dd..0d2c6703e279 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,6 +12,10 @@ obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o
+ifeq ($(CONFIG_XDP_SOCKETS),y)
+obj-$(CONFIG_BPF_SYSCALL) += xskmap.o
+endif
 obj-$(CONFIG_BPF_SYSCALL) += offload.o
 endif
 ifeq ($(CONFIG_PERF_EVENTS),y)
diff --git a/net/core/bpf_sk_storage.c b/kernel/bpf/bpf_local_storage.c
similarity index 63%
rename from net/core/bpf_sk_storage.c
rename to kernel/bpf/bpf_local_storage.c
index d2c4d16dadba..0a1caac2f5f7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -6,14 +6,14 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/bpf.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
 
 static atomic_t cache_idx;
 
-#define SK_STORAGE_CREATE_FLAG_MASK					\
+#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
 	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
 struct bucket {
@@ -21,11 +21,15 @@ struct bucket {
 	raw_spinlock_t lock;
 };
 
-/* Thp map is not the primary owner of a bpf_sk_storage_elem.
+enum bpf_local_storage_type {
+	BPF_LOCAL_STORAGE_SK,
+};
+
+/* Thp map is not the primary owner of a bpf_local_storage_elem.
  * Instead, the sk->sk_bpf_storage is.
  *
- * The map (bpf_sk_storage_map) is for two purposes
- * 1. Define the size of the "sk local storage".  It is
+ * The map (bpf_local_storage_map) is for two purposes
+ * 1. Define the size of the "local storage".  It is
  *    the map's value_size.
  *
  * 2. Maintain a list to keep track of all elems such
@@ -34,12 +38,12 @@ struct bucket {
  * When a bpf local storage is being looked up for a
  * particular sk,  the "bpf_map" pointer is actually used
  * as the "key" to search in the list of elem in
- * sk->sk_bpf_storage.
+ * the respective bpf_local_storage owned by the object.
  *
- * Hence, consider sk->sk_bpf_storage is the mini-map
- * with the "bpf_map" pointer as the searching key.
+ * e.g. sk->sk_bpf_storage is the mini-map with the "bpf_map" pointer
+ * as the searching key.
  */
-struct bpf_sk_storage_map {
+struct bpf_local_storage_map {
 	struct bpf_map map;
 	/* Lookup elem does not require accessing the map.
 	 *
@@ -53,46 +57,51 @@ struct bpf_sk_storage_map {
 	u16 cache_idx;
 };
 
-struct bpf_sk_storage_data {
+struct bpf_local_storage_data {
 	/* smap is used as the searching key when looking up
 	 * from sk->sk_bpf_storage.
 	 *
 	 * Put it in the same cacheline as the data to minimize
 	 * the number of cachelines access during the cache hit case.
 	 */
-	struct bpf_sk_storage_map __rcu *smap;
+	struct bpf_local_storage_map __rcu *smap;
 	u8 data[] __aligned(8);
 };
 
-/* Linked to bpf_sk_storage and bpf_sk_storage_map */
-struct bpf_sk_storage_elem {
-	struct hlist_node map_node;	/* Linked to bpf_sk_storage_map */
-	struct hlist_node snode;	/* Linked to bpf_sk_storage */
-	struct bpf_sk_storage __rcu *sk_storage;
+/* Linked to bpf_local_storage and bpf_local_storage_map */
+struct bpf_local_storage_elem {
+	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
+	struct hlist_node snode;	/* Linked to bpf_local_storage */
+	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
 	/* 8 bytes hole */
 	/* The data is stored in aother cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
-	struct bpf_sk_storage_data sdata ____cacheline_aligned;
+	struct bpf_local_storage_data sdata ____cacheline_aligned;
 };
 
-#define SELEM(_SDATA) container_of((_SDATA), struct bpf_sk_storage_elem, sdata)
+#define SELEM(_SDATA)                                                          \
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_SK_STORAGE_CACHE_SIZE	16
-
-struct bpf_sk_storage {
-	struct bpf_sk_storage_data __rcu *cache[BPF_SK_STORAGE_CACHE_SIZE];
-	struct hlist_head list;	/* List of bpf_sk_storage_elem */
-	struct sock *sk;	/* The sk that owns the the above "list" of
-				 * bpf_sk_storage_elem.
-				 */
+#define BPF_STORAGE_CACHE_SIZE	16
+
+struct bpf_local_storage {
+	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
+	struct hlist_head list;		/* List of bpf_local_storage_elem */
+	/* The object that owns the the above "list" of
+	 * bpf_local_storage_elem
+	 */
+	union {
+		struct sock *sk;
+	};
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	enum bpf_local_storage_type stype;
 };
 
-static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
-				    struct bpf_sk_storage_elem *selem)
+static struct bucket *select_bucket(struct bpf_local_storage_map *smap,
+				    struct bpf_local_storage_elem *selem)
 {
 	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
 }
@@ -109,24 +118,20 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
-static bool selem_linked_to_sk(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_node(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
-static bool selem_linked_to_map(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
 }
 
-static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
-					       struct sock *sk, void *value,
-					       bool charge_omem)
+static struct bpf_local_storage_elem *selem_alloc(
+	struct bpf_local_storage_map *smap, void *value)
 {
-	struct bpf_sk_storage_elem *selem;
-
-	if (charge_omem && omem_charge(sk, smap->elem_size))
-		return NULL;
+	struct bpf_local_storage_elem *selem;
 
 	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
 	if (selem) {
@@ -135,94 +140,103 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
 		return selem;
 	}
 
+	return NULL;
+}
+
+static struct bpf_local_storage_elem *sk_selem_alloc(
+	struct bpf_local_storage_map *smap, struct sock *sk, void *value,
+	bool charge_omem)
+{
+	struct bpf_local_storage_elem *selem;
+
+	if (charge_omem && omem_charge(sk, smap->elem_size))
+		return NULL;
+
+	selem = selem_alloc(smap, value);
+	if (selem)
+		return selem;
+
 	if (charge_omem)
 		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
 
 	return NULL;
 }
 
-/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
+static void __unlink_local_storage(struct bpf_local_storage *local_storage,
+				   bool uncharge_omem)
+{
+	struct sock *sk;
+
+	switch (local_storage->stype) {
+	case BPF_LOCAL_STORAGE_SK:
+		sk = local_storage->sk;
+		if (uncharge_omem)
+			atomic_sub(sizeof(struct bpf_local_storage),
+				   &sk->sk_omem_alloc);
+
+		/* After this RCU_INIT, sk may be freed and cannot be used */
+		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+		local_storage->sk = NULL;
+		break;
+	}
+}
+
+/* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
+ *
+ * uncharge_omem is only relevant when:
+ *
+ *	local_storage->stype == BPF_LOCAL_STORAGE_SK
+ *
  */
-static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
-			      struct bpf_sk_storage_elem *selem,
-			      bool uncharge_omem)
+static bool __selem_unlink(struct bpf_local_storage *local_storage,
+			   struct bpf_local_storage_elem *selem,
+			   bool uncharge_omem)
 {
-	struct bpf_sk_storage_map *smap;
-	bool free_sk_storage;
-	struct sock *sk;
+	struct bpf_local_storage_map *smap;
+	bool free_local_storage;
 
 	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = sk_storage->sk;
-
-	/* All uncharging on sk->sk_omem_alloc must be done first.
-	 * sk may be freed once the last selem is unlinked from sk_storage.
+	free_local_storage = hlist_is_singular_node(&selem->snode,
+						    &local_storage->list);
+
+	/* local_storage is not freed now.  local_storage->lock is
+	 * still held and raw_spin_unlock_bh(&local_storage->lock)
+	 * will be done by the caller.
+	 * Although the unlock will be done under
+	 * rcu_read_lock(),  it is more intutivie to
+	 * read if kfree_rcu(local_storage, rcu) is done
+	 * after the raw_spin_unlock_bh(&local_storage->lock).
+	 *
+	 * Hence, a "bool free_local_storage" is returned
+	 * to the caller which then calls the kfree_rcu()
+	 * after unlock.
 	 */
-	if (uncharge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+	if (free_local_storage)
+		__unlink_local_storage(local_storage, uncharge_omem);
 
-	free_sk_storage = hlist_is_singular_node(&selem->snode,
-						 &sk_storage->list);
-	if (free_sk_storage) {
-		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
-		sk_storage->sk = NULL;
-		/* After this RCU_INIT, sk may be freed and cannot be used */
-		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 
-		/* sk_storage is not freed now.  sk_storage->lock is
-		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
-		 * will be done by the caller.
-		 *
-		 * Although the unlock will be done under
-		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(sk_storage, rcu) is done
-		 * after the raw_spin_unlock_bh(&sk_storage->lock).
-		 *
-		 * Hence, a "bool free_sk_storage" is returned
-		 * to the caller which then calls the kfree_rcu()
-		 * after unlock.
-		 */
-	}
 	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
 	    SDATA(selem))
-		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	kfree_rcu(selem, rcu);
 
-	return free_sk_storage;
+	return free_local_storage;
 }
 
-static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
+static void __selem_link(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage *sk_storage;
-	bool free_sk_storage = false;
-
-	if (unlikely(!selem_linked_to_sk(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	sk_storage = rcu_dereference(selem->sk_storage);
-	raw_spin_lock_bh(&sk_storage->lock);
-	if (likely(selem_linked_to_sk(selem)))
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
-	raw_spin_unlock_bh(&sk_storage->lock);
-
-	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
-}
-
-static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
-			    struct bpf_sk_storage_elem *selem)
-{
-	RCU_INIT_POINTER(selem->sk_storage, sk_storage);
-	hlist_add_head(&selem->snode, &sk_storage->list);
+	RCU_INIT_POINTER(selem->local_storage, local_storage);
+	hlist_add_head(&selem->snode, &local_storage->list);
 }
 
-static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
+static void selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	struct bucket *b;
 
 	if (unlikely(!selem_linked_to_map(selem)))
@@ -237,8 +251,8 @@ static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_link_map(struct bpf_sk_storage_map *smap,
-			   struct bpf_sk_storage_elem *selem)
+static void selem_link_map(struct bpf_local_storage_map *smap,
+			   struct bpf_local_storage_elem *selem)
 {
 	struct bucket *b = select_bucket(smap, selem);
 
@@ -248,31 +262,46 @@ static void selem_link_map(struct bpf_sk_storage_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_unlink(struct bpf_sk_storage_elem *selem)
+static void selem_unlink(struct bpf_local_storage_elem *selem)
 {
-	/* Always unlink from map before unlinking from sk_storage
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+
+	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
-	 * the sk_storage.
+	 * the local_storage.
 	 */
 	selem_unlink_map(selem);
-	selem_unlink_sk(selem);
+
+	if (unlikely(!selem_linked_to_node(selem)))
+		/* selem has already been unlinked from its owner */
+		return;
+
+	local_storage = rcu_dereference(selem->local_storage);
+	raw_spin_lock_bh(&local_storage->lock);
+	if (likely(selem_linked_to_node(selem)))
+		free_local_storage = __selem_unlink(local_storage, selem, true);
+	raw_spin_unlock_bh(&local_storage->lock);
+
+	if (free_local_storage)
+		kfree_rcu(local_storage, rcu);
 }
 
-static struct bpf_sk_storage_data *
-__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
-		    struct bpf_sk_storage_map *smap,
+static struct bpf_local_storage_data *
+__local_storage_lookup(struct bpf_local_storage *local_storage,
+		    struct bpf_local_storage_map *smap,
 		    bool cacheit_lockit)
 {
-	struct bpf_sk_storage_data *sdata;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_elem *selem;
 
 	/* Fast path (cache hit) */
-	sdata = rcu_dereference(sk_storage->cache[smap->cache_idx]);
+	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
 	if (sdata && rcu_access_pointer(sdata->smap) == smap)
 		return sdata;
 
 	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
 		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
 			break;
 
@@ -284,33 +313,33 @@ __sk_storage_lookup(struct bpf_sk_storage *sk_storage,
 		/* spinlock is needed to avoid racing with the
 		 * parallel delete.  Otherwise, publishing an already
 		 * deleted sdata to the cache will become a use-after-free
-		 * problem in the next __sk_storage_lookup().
+		 * problem in the next __local_storage_lookup().
 		 */
-		raw_spin_lock_bh(&sk_storage->lock);
-		if (selem_linked_to_sk(selem))
-			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
-					   sdata);
-		raw_spin_unlock_bh(&sk_storage->lock);
+		raw_spin_lock_bh(&local_storage->lock);
+		if (selem_linked_to_node(selem))
+			rcu_assign_pointer(
+				local_storage->cache[smap->cache_idx], sdata);
+		raw_spin_unlock_bh(&local_storage->lock);
 	}
 
 	return sdata;
 }
 
-static struct bpf_sk_storage_data *
+static struct bpf_local_storage_data *
 sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_map *smap;
 
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		return NULL;
 
-	smap = (struct bpf_sk_storage_map *)map;
-	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
+	smap = (struct bpf_local_storage_map *)map;
+	return __local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
-static int check_flags(const struct bpf_sk_storage_data *old_sdata,
+static int check_flags(const struct bpf_local_storage_data *old_sdata,
 		       u64 map_flags)
 {
 	if (old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
@@ -324,93 +353,129 @@ static int check_flags(const struct bpf_sk_storage_data *old_sdata,
 	return 0;
 }
 
-static int sk_storage_alloc(struct sock *sk,
-			    struct bpf_sk_storage_map *smap,
-			    struct bpf_sk_storage_elem *first_selem)
+static struct bpf_local_storage *
+bpf_local_storage_alloc(struct bpf_local_storage_map *smap)
 {
-	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
-	int err;
+	struct bpf_local_storage *storage;
 
-	err = omem_charge(sk, sizeof(*sk_storage));
-	if (err)
-		return err;
+	storage = kzalloc(sizeof(*storage), GFP_ATOMIC | __GFP_NOWARN);
+	if (!storage)
+		return NULL;
 
-	sk_storage = kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
-	if (!sk_storage) {
-		err = -ENOMEM;
-		goto uncharge;
-	}
-	INIT_HLIST_HEAD(&sk_storage->list);
-	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->sk = sk;
+	INIT_HLIST_HEAD(&storage->list);
+	raw_spin_lock_init(&storage->lock);
+	return storage;
+}
 
-	__selem_link_sk(sk_storage, first_selem);
-	selem_link_map(smap, first_selem);
-	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
-	 * Hence, atomic ops is used to set sk->sk_bpf_storage
-	 * from NULL to the newly allocated sk_storage ptr.
-	 *
-	 * From now on, the sk->sk_bpf_storage pointer is protected
-	 * by the sk_storage->lock.  Hence,  when freeing
-	 * the sk->sk_bpf_storage, the sk_storage->lock must
-	 * be held before setting sk->sk_bpf_storage to NULL.
-	 */
-	prev_sk_storage = cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_storage,
-				  NULL, sk_storage);
-	if (unlikely(prev_sk_storage)) {
-		selem_unlink_map(first_selem);
-		err = -EAGAIN;
-		goto uncharge;
+/* Publish local_storage to the address.  This is used because we are already
+ * in a region where we cannot grab a lock on the object owning the storage (
+ * (e.g sk->sk_lock). Hence, atomic ops is used.
+ *
+ * From now on, the addr pointer is protected
+ * by the local_storage->lock.  Hence, upon freeing,
+ * the local_storage->lock must be held before unlinking the storage from the
+ * owner.
+ */
+static int publish_local_storage(struct bpf_local_storage_elem *first_selem,
+				 struct bpf_local_storage **addr,
+				 struct bpf_local_storage *curr)
+{
+	struct bpf_local_storage *prev;
 
+	prev = cmpxchg(addr, NULL, curr);
+	if (unlikely(prev)) {
 		/* Note that even first_selem was linked to smap's
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
-		 * bpf_sk_storage_map_free() does a
+		 * bpf_local_storage_map_free() does a
 		 * synchronize_rcu() before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
 		 * bucket->list under rcu_read_lock().
 		 */
+		selem_unlink_map(first_selem);
+		return -EAGAIN;
 	}
 
 	return 0;
+}
+
+static int sk_storage_alloc(struct sock *sk,
+			    struct bpf_local_storage_map *smap,
+			    struct bpf_local_storage_elem *first_selem)
+{
+	struct bpf_local_storage *curr;
+	int err;
+
+	err = omem_charge(sk, sizeof(*curr));
+	if (err)
+		return err;
+
+	curr = bpf_local_storage_alloc(smap);
+	if (!curr) {
+		err = -ENOMEM;
+		goto uncharge;
+	}
+
+	curr->sk = sk;
+	curr->stype = BPF_LOCAL_STORAGE_SK;
+
+	__selem_link(curr, first_selem);
+	selem_link_map(smap, first_selem);
+
+	err = publish_local_storage(first_selem,
+		(struct bpf_local_storage **)&sk->sk_bpf_storage, curr);
+	if (err)
+		goto uncharge;
+
+	return 0;
 
 uncharge:
-	kfree(sk_storage);
-	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
+	kfree(curr);
+	atomic_sub(sizeof(*curr), &sk->sk_omem_alloc);
 	return err;
 }
 
+static int check_update_flags(struct bpf_map *map, u64 map_flags)
+{
+	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
+	    /* BPF_F_LOCK can only be used in a value with spin_lock */
+	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* sk cannot be going away because it is linking new elem
  * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
+static struct bpf_local_storage_data *sk_storage_update(struct sock *sk,
 						     struct bpf_map *map,
 						     void *value,
 						     u64 map_flags)
 {
-	struct bpf_sk_storage_data *old_sdata = NULL;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
 	int err;
 
-	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
-	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
-		return ERR_PTR(-EINVAL);
+	err = check_update_flags(map, map_flags);
+	if (err)
+		return ERR_PTR(err);
 
-	smap = (struct bpf_sk_storage_map *)map;
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
+	smap = (struct bpf_local_storage_map *)map;
+
+	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	if (!local_storage || hlist_empty(&local_storage->list)) {
 		/* Very first elem for this sk */
 		err = check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
 
-		selem = selem_alloc(smap, sk, value, true);
+		selem = sk_selem_alloc(smap, sk, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -426,25 +491,26 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 
 	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
 		/* Hoping to find an old_sdata to do inline update
-		 * such that it can avoid taking the sk_storage->lock
+		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
 		 */
-		old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+		old_sdata = __local_storage_lookup(local_storage, smap, false);
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
+
+		if (old_sdata && selem_linked_to_node(SELEM(old_sdata))) {
 			copy_map_value_locked(map, old_sdata->data,
 					      value, false);
 			return old_sdata;
 		}
 	}
 
-	raw_spin_lock_bh(&sk_storage->lock);
+	raw_spin_lock_bh(&local_storage->lock);
 
-	/* Recheck sk_storage->list under sk_storage->lock */
-	if (unlikely(hlist_empty(&sk_storage->list))) {
-		/* A parallel del is happening and sk_storage is going
+	/* Recheck local_storage->list under local_storage->lock */
+	if (unlikely(hlist_empty(&local_storage->list))) {
+		/* A parallel del is happening and local_storage is going
 		 * away.  It has just been checked before, so very
 		 * unlikely.  Return instead of retry to keep things
 		 * simple.
@@ -453,7 +519,7 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock_err;
 	}
 
-	old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+	old_sdata = __local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
 		goto unlock_err;
@@ -464,15 +530,15 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock;
 	}
 
-	/* sk_storage->lock is held.  Hence, we are sure
+	/* local_storage->lock is held.  Hence, we are sure
 	 * we can unlink and uncharge the old_sdata successfully
 	 * later.  Hence, instead of charging the new selem now
 	 * and then uncharge the old selem later (which may cause
 	 * a potential but unnecessary charge failure),  avoid taking
 	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during __selem_unlink_sk().
+	 * old_sdata will not be uncharged later during __selem_unlink().
 	 */
-	selem = selem_alloc(smap, sk, value, !old_sdata);
+	selem = sk_selem_alloc(smap, sk, value, !old_sdata);
 	if (!selem) {
 		err = -ENOMEM;
 		goto unlock_err;
@@ -481,27 +547,27 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 	/* First, link the new selem to the map */
 	selem_link_map(smap, selem);
 
-	/* Second, link (and publish) the new selem to sk_storage */
-	__selem_link_sk(sk_storage, selem);
+	/* Second, link (and publish) the new selem to local_storage */
+	__selem_link(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
 		selem_unlink_map(SELEM(old_sdata));
-		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
+		__selem_unlink(local_storage, SELEM(old_sdata), false);
 	}
 
 unlock:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return SDATA(selem);
 
 unlock_err:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return ERR_PTR(err);
 }
 
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	sdata = sk_storage_lookup(sk, map, false);
 	if (!sdata)
@@ -515,8 +581,8 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage = false;
 	struct hlist_node *n;
 
@@ -530,9 +596,9 @@ void bpf_sk_storage_free(struct sock *sk)
 	/* Netiher the bpf_prog nor the bpf-map's syscall
 	 * could be modifying the sk_storage->list now.
 	 * Thus, no elem can be added-to or deleted-from the
-	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
 	 *
-	 * It is racing with bpf_sk_storage_map_free() alone
+	 * It is racing with bpf_local_storage_map_free() alone
 	 * when unlinking elem from the sk_storage->list and
 	 * the map's bucket->list.
 	 */
@@ -542,7 +608,7 @@ void bpf_sk_storage_free(struct sock *sk)
 		 * sk_storage.
 		 */
 		selem_unlink_map(selem);
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
+		free_sk_storage = __selem_unlink(sk_storage, selem, true);
 	}
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
@@ -551,14 +617,14 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-static void bpf_sk_storage_map_free(struct bpf_map *map)
+static void bpf_local_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 	struct bucket *b;
 	unsigned int i;
 
-	smap = (struct bpf_sk_storage_map *)map;
+	smap = (struct bpf_local_storage_map *)map;
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
@@ -569,11 +635,11 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
-	 * to the sk->sk_bpf_storage or to the map bucket's list.
+	 * to the bpf_local_storage or to the map bucket's list.
 	 *
 	 * The elem of this map can be cleaned up here
-	 * or
-	 * by bpf_sk_storage_free() during __sk_destruct().
+	 * or by bpf_local_storage_free() during the destruction of the
+	 * owner object. eg. __sk_destruct.
 	 */
 	for (i = 0; i < (1U << smap->bucket_log); i++) {
 		b = &smap->buckets[i];
@@ -581,7 +647,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 		rcu_read_lock();
 		/* No one is adding to b->list now */
 		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
-						 struct bpf_sk_storage_elem,
+						 struct bpf_local_storage_elem,
 						 map_node))) {
 			selem_unlink(selem);
 			cond_resched_rcu();
@@ -589,17 +655,17 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 		rcu_read_unlock();
 	}
 
-	/* bpf_sk_storage_free() may still need to access the map.
-	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
+	/* bpf_local_storage_free() may still need to access the map.
+	 * e.g. bpf_local_storage_free() has unlinked selem from the map
 	 * which then made the above while((selem = ...)) loop
 	 * exited immediately.
 	 *
-	 * However, the bpf_sk_storage_free() still needs to access
+	 * However, the bpf_local_storage_free() still needs to access
 	 * the smap->elem_size to do the uncharging in
-	 * __selem_unlink_sk().
+	 * __selem_unlink().
 	 *
 	 * Hence, wait another rcu grace period for the
-	 * bpf_sk_storage_free() to finish.
+	 * bpf_local_storage_free() to finish.
 	 */
 	synchronize_rcu();
 
@@ -612,12 +678,13 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
  */
 #define MAX_VALUE_SIZE							\
 	min_t(u32,							\
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem)), \
-	      (U16_MAX - sizeof(struct bpf_sk_storage_elem)))
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -			\
+	       sizeof(struct bpf_local_storage_elem)),			\
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
-	if (attr->map_flags & ~SK_STORAGE_CREATE_FLAG_MASK ||
+	if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
@@ -634,9 +701,11 @@ static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
+
+static struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
 	u64 cost;
@@ -672,9 +741,10 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
+	smap->elem_size =
+		sizeof(struct bpf_local_storage_elem) + attr->value_size;
 	smap->cache_idx = (unsigned int)atomic_inc_return(&cache_idx) %
-		BPF_SK_STORAGE_CACHE_SIZE;
+		BPF_STORAGE_CACHE_SIZE;
 
 	return &smap->map;
 }
@@ -685,7 +755,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
+static int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 					const struct btf *btf,
 					const struct btf_type *key_type,
 					const struct btf_type *value_type)
@@ -702,11 +772,11 @@ static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
+static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
-	int fd, err;
+	int fd, err = -EINVAL;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
@@ -719,17 +789,18 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
-static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
+static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
-	int fd, err;
+	int fd, err = -EINVAL;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = sk_storage_update(sock->sk, map, value, map_flags);
+		sdata = sk_storage_update(sock->sk, map, value,
+						map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -737,30 +808,29 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
+static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct socket *sock;
-	int fd, err;
+	int fd, err = -EINVAL;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
 		err = sk_storage_delete(sock->sk, map);
 		sockfd_put(sock);
-		return err;
 	}
 
 	return err;
 }
 
-static struct bpf_sk_storage_elem *
+static struct bpf_local_storage_elem *
 bpf_sk_storage_clone_elem(struct sock *newsk,
-			  struct bpf_sk_storage_map *smap,
-			  struct bpf_sk_storage_elem *selem)
+			  struct bpf_local_storage_map *smap,
+			  struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_elem *copy_selem;
+	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = selem_alloc(smap, newsk, NULL, true);
+	copy_selem = sk_selem_alloc(smap, newsk, NULL, true);
 	if (!copy_selem)
 		return NULL;
 
@@ -776,9 +846,9 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 {
-	struct bpf_sk_storage *new_sk_storage = NULL;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage *new_sk_storage = NULL;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
@@ -790,8 +860,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		goto out;
 
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
-		struct bpf_sk_storage_elem *copy_selem;
-		struct bpf_sk_storage_map *smap;
+		struct bpf_local_storage_elem *copy_selem;
+		struct bpf_local_storage_map *smap;
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
@@ -799,7 +869,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			continue;
 
 		/* Note that for lockless listeners adding new element
-		 * here can race with cleanup in bpf_sk_storage_map_free.
+		 * here can race with cleanup in bpf_local_storage_map_free.
 		 * Try to grab map refcnt to make sure that it's still
 		 * alive and prevent concurrent removal.
 		 */
@@ -816,7 +886,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 
 		if (new_sk_storage) {
 			selem_link_map(smap, copy_selem);
-			__selem_link_sk(new_sk_storage, copy_selem);
+			__selem_link(new_sk_storage, copy_selem);
 		} else {
 			ret = sk_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
@@ -827,7 +897,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 				goto out;
 			}
 
-			new_sk_storage = rcu_dereference(copy_selem->sk_storage);
+			new_sk_storage =
+				rcu_dereference(copy_selem->local_storage);
 		}
 		bpf_map_put(map);
 	}
@@ -836,7 +907,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	rcu_read_unlock();
 
 	/* In case of an error, don't free anything explicitly here, the
-	 * caller is responsible to call bpf_sk_storage_free.
+	 * caller is responsible to call bpf_local_storage_free.
 	 */
 
 	return ret;
@@ -845,7 +916,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
@@ -854,7 +925,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	if (sdata)
 		return (unsigned long)sdata->data;
 
-	if (flags == BPF_SK_STORAGE_GET_F_CREATE &&
+	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
 	    /* Cannot add new elem to a going away sk.
 	     * Otherwise, the new elem may become a leak
 	     * (and also other memory issues during map
@@ -887,14 +958,14 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 }
 
 const struct bpf_map_ops sk_storage_map_ops = {
-	.map_alloc_check = bpf_sk_storage_map_alloc_check,
-	.map_alloc = bpf_sk_storage_map_alloc,
-	.map_free = bpf_sk_storage_map_free,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = bpf_local_storage_map_alloc,
+	.map_free = bpf_local_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
-	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
-	.map_update_elem = bpf_fd_sk_storage_update_elem,
-	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
-	.map_check_btf = bpf_sk_storage_map_check_btf,
+	.map_lookup_elem = bpf_sk_storage_lookup_elem,
+	.map_update_elem = bpf_sk_storage_update_elem,
+	.map_delete_elem = bpf_sk_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
@@ -975,7 +1046,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 	u32 nr_maps = 0;
 	int rem, err;
 
-	/* bpf_sk_storage_map is currently limited to CAP_SYS_ADMIN as
+	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
 	 * the map_alloc_check() side also does.
 	 */
 	if (!bpf_capable())
@@ -1025,10 +1096,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 }
 EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
 
-static int diag_get(struct bpf_sk_storage_data *sdata, struct sk_buff *skb)
+static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 {
 	struct nlattr *nla_stg, *nla_value;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 
 	/* It cannot exceed max nlattr's payload */
 	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < MAX_VALUE_SIZE);
@@ -1067,9 +1138,9 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1122,8 +1193,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_data *sdata;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1150,8 +1221,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 	saved_len = skb->len;
 	for (i = 0; i < diag->nr_maps; i++) {
-		sdata = __sk_storage_lookup(sk_storage,
-				(struct bpf_sk_storage_map *)diag->maps[i],
+		sdata = __local_storage_lookup(sk_storage,
+				(struct bpf_local_storage_map *)diag->maps[i],
 				false);
 
 		if (!sdata)
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5c0e964105ac..a6018ece357f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -14,8 +14,8 @@
 #include <linux/string.h>
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock.h>
-#include <net/bpf_sk_storage.h>
 
 #include "../cgroup/cgroup-internal.h"
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index bfd4ccd80847..b1547efcc842 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -7,7 +7,7 @@
 #include <linux/etherdevice.h>
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <linux/error-injection.h>
diff --git a/net/core/Makefile b/net/core/Makefile
index 3e2c378e5f31..9ddc2f3ecd97 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -34,4 +34,3 @@ obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
 obj-$(CONFIG_FAILOVER) += failover.o
-obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
diff --git a/net/core/filter.c b/net/core/filter.c
index bd2853d23b50..b1556baa1235 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -72,7 +72,7 @@
 #include <net/seg6_local.h>
 #include <net/lwtunnel.h>
 #include <net/ipv6_stubs.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
diff --git a/net/core/sock.c b/net/core/sock.c
index fd85e651ce28..26e25b868dda 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -130,8 +130,8 @@
 #include <linux/sock_diag.h>
 
 #include <linux/filter.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock_reuseport.h>
-#include <net/bpf_sk_storage.h>
 
 #include <trace/events/sock.h>
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e3939f76b024..075abf1c6d7e 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -7,7 +7,7 @@
 #include <linux/btf.h>
 #include <linux/filter.h>
 #include <net/tcp.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 
 static u32 optional_ops[] = {
 	offsetof(struct tcp_congestion_ops, init),
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 125f4f8a36b4..ce22867cce5d 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -23,7 +23,7 @@
 #include <net/inet_hashtables.h>
 #include <net/inet_timewait_sock.h>
 #include <net/inet6_hashtables.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 #include <net/netlink.h>
 
 #include <linux/inet.h>
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 97e1fd19ff58..4a202eea15c0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2788,10 +2788,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
- *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
- *		together with **BPF_SK_STORAGE_GET_F_CREATE** to specify
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
  *		the initial value of a bpf-local-storage.  If *value* is
  *		**NULL**, the new bpf-local-storage will be zero initialized.
  *	Return
@@ -3388,11 +3388,16 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
 
+
 /* BPF_FUNC_read_branch_records flags. */
 enum {
 	BPF_F_GET_BRANCH_RECORDS_SIZE	= (1ULL << 0),
-- 
2.27.0.rc0.183.gde8f92d652-goog

