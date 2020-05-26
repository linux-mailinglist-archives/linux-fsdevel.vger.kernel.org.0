Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937EE1E2721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgEZQdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgEZQdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 12:33:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF4C03E97A
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 09:33:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so16775567wru.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+oqiE+dl4Nn+SGx87ajx1fu0RbxYv6VXwk5p+Wjy2w=;
        b=aIPfLsjZ8az5HMnjEpEJN2VrfzXEg4yi58ahXtoY+VoeXPbbsywnKbkjQhjK2rLI0Z
         rzw7dP2X52UyTusF6Pobx5t1DUxosya15gJ+BTXGv9JLM12006QdVihdgurL58gnObmW
         tuTLH+SFYl8Tl10YtBBmAneP03/Iz+Y294Rs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+oqiE+dl4Nn+SGx87ajx1fu0RbxYv6VXwk5p+Wjy2w=;
        b=nGNckoBXFFKzuihQ1hB9Fr55J3sX/COvUlSRgA+izNPl4mEWmbOn6necdb16mHKqGQ
         qsgWk51+KC8H9rlkoD9PqLrp6Djf8vzHwVMgLIbAGJsaycO7SdywLnKxuAFOh9lfvvQU
         1Kn5wBXpd8K85fe2Et3P15+nPIlZlBJDWqhiIo0cF52FOfOgMnHe05FbQcYPJo2Gch2i
         6GyINTSTIr607KYE/G/SyyfcQxvAwOXZQ7v8dd6Fk1kVaXmZq57r3RtZUVuU4rPHIikf
         +bS3NJd49Rm+NRAXKjKE5LExGuT+uUW5PQAPramfPo+/lT5TUm+0JeymAdOHu5amiEuD
         NW1g==
X-Gm-Message-State: AOAM533lICNtYuz++Nop9Dj56n921lTGXnwITsilroq7k9rHfm2ayxdZ
        q9xWg7qrWJFQvkQFkuiPINmfsQ==
X-Google-Smtp-Source: ABdhPJyHKCzQ/4LSTYapNHIMD11B7Tt/uzke74RLE984cUF24TsbjPP+r+vnSbCcMeL26FjRRhbHcw==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr14097928wrq.196.1590510820550;
        Tue, 26 May 2020 09:33:40 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id k17sm48654wmj.15.2020.05.26.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:33:39 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
Date:   Tue, 26 May 2020 18:33:34 +0200
Message-Id: <20200526163336.63653-3-kpsingh@chromium.org>
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

Similar to bpf_local_storage for sockets, add local storage for inodes.
The life-cycle of storage is managed with the life-cycle of the inode.
i.e. the storage is destroyed along with the owning inode.

Since, the intention is to use this in LSM programs, the destruction is
done after security_inode_free in __destroy_inode.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 fs/inode.c                        |   3 +
 include/linux/bpf_local_storage.h |   6 +
 include/linux/bpf_types.h         |   1 +
 include/linux/fs.h                |   5 +
 include/uapi/linux/bpf.h          |  41 +++-
 kernel/bpf/bpf_local_storage.c    | 321 +++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c              |   3 +-
 kernel/bpf/verifier.c             |  10 +
 tools/bpf/bpftool/map.c           |   1 +
 tools/include/uapi/linux/bpf.h    |  41 +++-
 tools/lib/bpf/libbpf_probes.c     |   5 +-
 11 files changed, 431 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc6e701b7e5d..91c81644f33d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,7 @@
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <trace/events/writeback.h>
+#include <linux/bpf_local_storage.h>
 #include "internal.h"
 
 /*
@@ -257,6 +258,8 @@ void __destroy_inode(struct inode *inode)
 	security_inode_free(inode);
 	fsnotify_inode_delete(inode);
 	locks_free_lock_context(inode);
+	bpf_inode_storage_free(inode);
+
 	if (!inode->i_nlink) {
 		WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) == 0);
 		atomic_long_dec(&inode->i_sb->s_remove_count);
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 85524f18cd91..c6837e7838fc 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -9,6 +9,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto bpf_inode_storage_get_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
@@ -16,6 +18,7 @@ struct nlattr;
 struct sock;
 
 #ifdef CONFIG_BPF_SYSCALL
+void bpf_inode_storage_free(struct inode *inode);
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
 bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs);
@@ -35,6 +38,9 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla)
 {
 	return NULL;
 }
+static inline void void bpf_inode_storage_free(struct inode *inode)
+{
+}
 static inline void bpf_sk_storage_diag_free(struct bpf_sk_storage_diag *diag)
 {
 }
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 29d22752fc87..07181fb89bdd 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -101,6 +101,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
 #if defined(CONFIG_BPF_STREAM_PARSER)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ee9e583bde2..23a6b8fbd381 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -624,6 +624,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_DEFAULT_READLINK	0x0010
 
 struct fsnotify_mark_connector;
+struct bpf_local_storage;
 
 /*
  * Keep mostly read-only and often accessed (especially for
@@ -740,6 +741,10 @@ struct inode {
 	struct fsverity_info	*i_verity_info;
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_local_storage __rcu	*inode_bpf_storage;
+#endif
+
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4a202eea15c0..410fb2e5fdd4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -147,6 +147,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SK_STORAGE,
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3157,6 +3158,42 @@ union bpf_attr {
  *		**bpf_sk_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ *
+ * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from an *inode*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *inode* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *inode*) except this
+ *		helper enforces the key must be an inode and the map must also
+ *		be a **BPF_MAP_TYPE_INODE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *inode* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *inode*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * int bpf_inode_storage_delete(struct bpf_map *map, void *inode)
+ *	Description
+ *		Delete a bpf_local_storage from an *inode*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3288,7 +3325,9 @@ union bpf_attr {
 	FN(seq_printf),			\
 	FN(seq_write),			\
 	FN(sk_cgroup_id),		\
-	FN(sk_ancestor_cgroup_id),
+	FN(sk_ancestor_cgroup_id),	\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0a1caac2f5f7..bf807cfe3a73 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -23,6 +23,7 @@ struct bucket {
 
 enum bpf_local_storage_type {
 	BPF_LOCAL_STORAGE_SK,
+	BPF_LOCAL_STORAGE_INODE,
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -94,6 +95,7 @@ struct bpf_local_storage {
 	 */
 	union {
 		struct sock *sk;
+		struct inode *inode;
 	};
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
@@ -165,6 +167,7 @@ static struct bpf_local_storage_elem *sk_selem_alloc(
 static void __unlink_local_storage(struct bpf_local_storage *local_storage,
 				   bool uncharge_omem)
 {
+	struct inode *inode;
 	struct sock *sk;
 
 	switch (local_storage->stype) {
@@ -178,6 +181,12 @@ static void __unlink_local_storage(struct bpf_local_storage *local_storage,
 		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 		local_storage->sk = NULL;
 		break;
+	case BPF_LOCAL_STORAGE_INODE:
+		inode = local_storage->inode;
+		/* After this RCU_INIT, sk may be freed and cannot be used */
+		RCU_INIT_POINTER(inode->inode_bpf_storage, NULL);
+		local_storage->inode = NULL;
+		break;
 	}
 }
 
@@ -339,6 +348,20 @@ sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 	return __local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
+static struct bpf_local_storage_data *inode_storage_lookup(
+	struct inode *inode, struct bpf_map *map, bool cacheit_lockit)
+{
+	struct bpf_local_storage *inode_storage;
+	struct bpf_local_storage_map *smap;
+
+	inode_storage = rcu_dereference(inode->inode_bpf_storage);
+	if (!inode_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return __local_storage_lookup(inode_storage, smap, cacheit_lockit);
+}
+
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
 		       u64 map_flags)
 {
@@ -435,6 +458,33 @@ static int sk_storage_alloc(struct sock *sk,
 	return err;
 }
 
+static int inode_storage_alloc(struct inode *inode,
+			       struct bpf_local_storage_map *smap,
+			       struct bpf_local_storage_elem *first_selem)
+{
+	struct bpf_local_storage *curr;
+	int err;
+
+	curr = bpf_local_storage_alloc(smap);
+	if (!curr)
+		return -ENOMEM;
+
+	curr->inode = inode;
+	curr->stype = BPF_LOCAL_STORAGE_INODE;
+
+	__selem_link(curr, first_selem);
+	selem_link_map(smap, first_selem);
+
+	err = publish_local_storage(first_selem,
+		(struct bpf_local_storage **)&inode->inode_bpf_storage, curr);
+	if (err) {
+		kfree(curr);
+		return err;
+	}
+
+	return 0;
+}
+
 static int check_update_flags(struct bpf_map *map, u64 map_flags)
 {
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -565,6 +615,109 @@ static struct bpf_local_storage_data *sk_storage_update(struct sock *sk,
 	return ERR_PTR(err);
 }
 
+static struct bpf_local_storage_data *inode_storage_update(
+	struct inode *inode, struct bpf_map *map, void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	int err;
+
+	err = check_update_flags(map, map_flags);
+	if (err)
+		return ERR_PTR(err);
+
+	smap = (struct bpf_local_storage_map *)map;
+	local_storage = rcu_dereference(inode->inode_bpf_storage);
+
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem for this inode */
+		err = check_flags(NULL, map_flags);
+		if (err)
+			return ERR_PTR(err);
+
+		selem = selem_alloc(smap, value);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+
+		err = inode_storage_alloc(inode, smap, selem);
+		if (err) {
+			kfree(selem);
+			return ERR_PTR(err);
+		}
+
+		return SDATA(selem);
+	}
+
+	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
+		/* Hoping to find an old_sdata to do inline update
+		 * such that it can avoid taking the local_storage->lock
+		 * and changing the lists.
+		 */
+		old_sdata = __local_storage_lookup(local_storage, smap, false);
+		err = check_flags(old_sdata, map_flags);
+		if (err)
+			return ERR_PTR(err);
+
+		if (old_sdata && selem_linked_to_node(SELEM(old_sdata))) {
+			copy_map_value_locked(map, old_sdata->data,
+					      value, false);
+			return old_sdata;
+		}
+	}
+
+	raw_spin_lock_bh(&local_storage->lock);
+
+	/* Recheck local_storage->list under local_storage->lock */
+	if (unlikely(hlist_empty(&local_storage->list))) {
+		/* A parallel del is happening and local_storage is going
+		 * away.  It has just been checked before, so very
+		 * unlikely.  Return instead of retry to keep things
+		 * simple.
+		 */
+		err = -EAGAIN;
+		goto unlock_err;
+	}
+
+	old_sdata = __local_storage_lookup(local_storage, smap, false);
+	err = check_flags(old_sdata, map_flags);
+	if (err)
+		goto unlock_err;
+
+	if (old_sdata && (map_flags & BPF_F_LOCK)) {
+		copy_map_value_locked(map, old_sdata->data, value, false);
+		selem = SELEM(old_sdata);
+		goto unlock;
+	}
+
+	selem = selem_alloc(smap, value);
+	if (!selem) {
+		err = -ENOMEM;
+		goto unlock_err;
+	}
+
+	/* First, link the new selem to the map */
+	selem_link_map(smap, selem);
+
+	/* Second, link (and publish) the new selem to sk_storage */
+	__selem_link(local_storage, selem);
+
+	/* Third, remove old selem, SELEM(old_sdata) */
+	if (old_sdata) {
+		selem_unlink_map(SELEM(old_sdata));
+		__selem_unlink(local_storage, SELEM(old_sdata), false);
+	}
+
+unlock:
+	raw_spin_unlock_bh(&local_storage->lock);
+	return SDATA(selem);
+
+unlock_err:
+	raw_spin_unlock_bh(&local_storage->lock);
+	return ERR_PTR(err);
+}
+
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
 	struct bpf_local_storage_data *sdata;
@@ -578,6 +731,19 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 	return 0;
 }
 
+static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = inode_storage_lookup(inode, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
@@ -617,6 +783,46 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
+/* Called by __destroy_inode() */
+void bpf_inode_storage_free(struct inode *inode)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	bool free_inode_storage = false;
+	struct hlist_node *n;
+
+	rcu_read_lock();
+	local_storage = rcu_dereference(inode->inode_bpf_storage);
+	if (!local_storage) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Netiher the bpf_prog nor the bpf-map's syscall
+	 * could be modifying the local_storage->list now.
+	 * Thus, no elem can be added-to or deleted-from the
+	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 *
+	 * It is racing with bpf_local_storage_map_free() alone
+	 * when unlinking elem from the local_storage->list and
+	 * the map's bucket->list.
+	 */
+	raw_spin_lock_bh(&local_storage->lock);
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * local_storage.
+		 */
+		selem_unlink_map(selem);
+		free_inode_storage =
+			__selem_unlink(local_storage, selem, false);
+	}
+	raw_spin_unlock_bh(&local_storage->lock);
+	rcu_read_unlock();
+
+	if (free_inode_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
 static void bpf_local_storage_map_free(struct bpf_map *map)
 {
 	struct bpf_local_storage_elem *selem;
@@ -639,7 +845,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 	 *
 	 * The elem of this map can be cleaned up here
 	 * or by bpf_local_storage_free() during the destruction of the
-	 * owner object. eg. __sk_destruct.
+	 * owner object. eg. __sk_destruct or __destroy_inode.
 	 */
 	for (i = 0; i < (1U << smap->bucket_log); i++) {
 		b = &smap->buckets[i];
@@ -789,6 +995,21 @@ static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
+static void *bpf_inode_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct inode *inode;
+	int err = -EINVAL;
+
+	inode = *(struct inode **)(key);
+	if (inode) {
+		sdata = inode_storage_lookup(inode, map, true);
+		return sdata ? sdata->data : NULL;
+	}
+
+	return ERR_PTR(err);
+}
+
 static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
@@ -808,6 +1029,22 @@ static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
+static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct inode *inode;
+	int err = -EINVAL;
+
+	inode = *(struct inode **)(key);
+	if (inode) {
+		sdata = inode_storage_update(inode, map, value,
+					     map_flags);
+		return PTR_ERR_OR_ZERO(sdata);
+	}
+	return err;
+}
+
 static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct socket *sock;
@@ -823,6 +1060,18 @@ static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
+static int bpf_inode_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct inode *inode;
+	int err = -EINVAL;
+
+	inode = *(struct inode **)(key);
+	if (inode)
+		err = inode_storage_delete(inode, map);
+
+	return err;
+}
+
 static struct bpf_local_storage_elem *
 bpf_sk_storage_clone_elem(struct sock *newsk,
 			  struct bpf_local_storage_map *smap,
@@ -944,6 +1193,29 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	return (unsigned long)NULL;
 }
 
+BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	if (flags > BPF_LOCAL_STORAGE_GET_F_CREATE)
+		return (unsigned long)NULL;
+
+	sdata = inode_storage_lookup(inode, map, true);
+	if (sdata)
+		return (unsigned long)sdata->data;
+
+	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
+	    atomic_inc_not_zero(&inode->i_count)) {
+		sdata = inode_storage_update(inode, map, value, BPF_NOEXIST);
+		iput(inode);
+		return IS_ERR(sdata) ?
+			(unsigned long)NULL : (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
 BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 {
 	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
@@ -957,6 +1229,20 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 	return -ENOENT;
 }
 
+BPF_CALL_2(bpf_inode_storage_delete,
+	   struct bpf_map *, map, struct inode *, inode)
+{
+	int err;
+
+	if (atomic_inc_not_zero(&inode->i_count)) {
+		err = inode_storage_delete(inode, map);
+		iput(inode);
+		return err;
+	}
+
+	return inode_storage_delete(inode, map);
+}
+
 const struct bpf_map_ops sk_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
 	.map_alloc = bpf_local_storage_map_alloc,
@@ -968,6 +1254,17 @@ const struct bpf_map_ops sk_storage_map_ops = {
 	.map_check_btf = bpf_local_storage_map_check_btf,
 };
 
+const struct bpf_map_ops inode_storage_map_ops = {
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = bpf_local_storage_map_alloc,
+	.map_free = bpf_local_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_inode_storage_lookup_elem,
+	.map_update_elem = bpf_inode_storage_update_elem,
+	.map_delete_elem = bpf_inode_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+};
+
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.func		= bpf_sk_storage_get,
 	.gpl_only	= false,
@@ -986,6 +1283,28 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
+static int bpf_inode_storage_get_btf_ids[4];
+const struct bpf_func_proto bpf_inode_storage_get_proto = {
+	.func		= bpf_inode_storage_get,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+	.btf_id		= bpf_inode_storage_get_btf_ids,
+};
+
+static int bpf_inode_storage_delete_btf_ids[2];
+const struct bpf_func_proto bpf_inode_storage_delete_proto = {
+	.func		= bpf_sk_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= bpf_inode_storage_delete_btf_ids,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d13b804ff045..60407c2d8fbd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -765,7 +765,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		if (map->map_type != BPF_MAP_TYPE_HASH &&
 		    map->map_type != BPF_MAP_TYPE_ARRAY &&
 		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_SK_STORAGE)
+		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2e27dba4ac6..ff90e85e243c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4000,6 +4000,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_sk_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INODE_STORAGE:
+		if (func_id != BPF_FUNC_inode_storage_get &&
+		    func_id != BPF_FUNC_inode_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -4073,6 +4078,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_inode_storage_get:
+	case BPF_FUNC_inode_storage_delete:
+		if (map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5fac8068ba1..e8fbafb3e87b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -49,6 +49,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_STACK]			= "stack",
 	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4a202eea15c0..410fb2e5fdd4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -147,6 +147,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SK_STORAGE,
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3157,6 +3158,42 @@ union bpf_attr {
  *		**bpf_sk_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ *
+ * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from an *inode*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *inode* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *inode*) except this
+ *		helper enforces the key must be an inode and the map must also
+ *		be a **BPF_MAP_TYPE_INODE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *inode* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *inode*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * int bpf_inode_storage_delete(struct bpf_map *map, void *inode)
+ *	Description
+ *		Delete a bpf_local_storage from an *inode*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3288,7 +3325,9 @@ union bpf_attr {
 	FN(seq_printf),			\
 	FN(seq_write),			\
 	FN(sk_cgroup_id),		\
-	FN(sk_ancestor_cgroup_id),
+	FN(sk_ancestor_cgroup_id),	\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 2c92059c0c90..795d7938ab56 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -170,7 +170,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	return btf_fd;
 }
 
-static int load_sk_storage_btf(void)
+static int load_local_storage_btf(void)
 {
 	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
 	/* struct bpf_spin_lock {
@@ -229,12 +229,13 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		key_size	= 0;
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
 		max_entries = 0;
 		map_flags = BPF_F_NO_PREALLOC;
-		btf_fd = load_sk_storage_btf();
+		btf_fd = load_local_storage_btf();
 		if (btf_fd < 0)
 			return false;
 		break;
-- 
2.27.0.rc0.183.gde8f92d652-goog

