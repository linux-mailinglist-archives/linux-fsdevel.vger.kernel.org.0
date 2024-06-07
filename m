Return-Path: <linux-fsdevel+bounces-21157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA38FF9D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DD8B2285B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A111CAB;
	Fri,  7 Jun 2024 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DC72yR0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6912E47
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725605; cv=none; b=n3WNEwv5KxU4EN3sQ/0ktOydgQSpbzEBGRjHYu8EGDKZfite76/JZcln1moyNziMgTWRYoiWSnZ8FjWgAnBPJKYkWui/MfeTchwb8acnLbh4ePyVI2MqRmtSJXfnPnjevs4H4rw9sLxkqE/BiMT1NnnKZCkxLkmSEzK83AACVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725605; c=relaxed/simple;
	bh=MsxG2gEwsGvABkY+L5M5Rynj70mCM2XMNbYRCqmdx+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8hy5UsboX81XYf6buXNSgYIphcoTavaZ2wJVFHw2cPZtTK3wjGUc+fN7khXENbaWLzupBwV9UeiQAaDqC7DfKVeImV0BszAOWILPcYgrdTR4Y+L7I+14aifK6EE6CMP0B0CuTbkb6pXyt7Fvq0KQ/hi18r+Aticwz2UO+x8F1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DC72yR0r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fsdeA7K3N3CYXqOETnSeXoOfVIx5rHGPVZjKCQDlE7g=; b=DC72yR0rseSmzFTjsWPzpdp38l
	4hiqavg8avm7ntZOhek6KnZnSbn7OAMoXKvVVq2mKiZ3OqbvALgJ5+qpDdaCN4vJvTL9EBe04fD2o
	nJl2jWGmm4rAhcDujAbsC6VUi9opBsZQzje3g5/BnBuwgZrjBRhX83twg2hIn+3VihWWfoQ6AeSnB
	/J4cQ3ctidJ55akmtiNPxkW26UNxH0rtwnWCW8aWDp+q7JmZqYLn5koS1BFYuPAWLehL4OoKK6C//
	IJytpJ5Vlet+VMe2qHGqQtBodhNKN/m4sa5ZceNw5mHZqmZrBMc7winCjeGASkA7HX0Z2DWStEhFG
	vv1oGBtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtb-009xCH-2b;
	Fri, 07 Jun 2024 01:59:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 12/19] bpf: switch to CLASS(fd, ...)
Date: Fri,  7 Jun 2024 02:59:50 +0100
Message-Id: <20240607015957.2372428-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

        Calling conventions for __bpf_map_get() would be more convenient
if it left fpdut() on failure to callers.  Makes for simpler logics
in the callers.

	Among other things, the proof of memory safety no longer has to
rely upon file->private_data never being ERR_PTR(...) for bpffs files.
Original calling conventions made it impossible for the caller to tell
whether __bpf_map_get() has returned ERR_PTR(-EINVAL) because it has found
the file not be a bpf map one (in which case it would've done fdput())
or because it found that ERR_PTR(-EINVAL) in file->private_data of a
bpf map file (in which case fdput() would _not_ have been done).

	With that calling conventions change it's easy to switch all
bpffs users to CLASS(fd, ...)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/bpf.h     |   9 ++-
 kernel/bpf/map_in_map.c |  37 +++-------
 kernel/bpf/syscall.c    | 149 ++++++++++++----------------------------
 kernel/bpf/verifier.c   |  20 +-----
 net/core/sock_map.c     |  23 ++-----
 5 files changed, 72 insertions(+), 166 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..a98f21fc4ac9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2226,7 +2226,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
-struct bpf_map *__bpf_map_get(struct fd f);
+
+struct bpf_map *bpf_file_to_map(struct file *f);
+static inline struct bpf_map *__bpf_map_get(struct fd f)
+{
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	return bpf_file_to_map(fd_file(f));
+}
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index b4f18c85d7bc..21536904b42e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -11,24 +11,18 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
 	u32 inner_map_meta_size;
-	struct fd f;
-	int ret;
+	CLASS(fd, f)(inner_map_ufd);
 
-	f = fdget(inner_map_ufd);
 	inner_map = __bpf_map_get(f);
 	if (IS_ERR(inner_map))
 		return inner_map;
 
 	/* Does not support >1 level map-in-map */
-	if (inner_map->inner_map_meta) {
-		ret = -EINVAL;
-		goto put;
-	}
+	if (inner_map->inner_map_meta)
+		return ERR_PTR(-EINVAL);
 
-	if (!inner_map->ops->map_meta_equal) {
-		ret = -ENOTSUPP;
-		goto put;
-	}
+	if (!inner_map->ops->map_meta_equal)
+		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
@@ -36,10 +30,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		inner_map_meta_size = sizeof(struct bpf_array);
 
 	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
-	if (!inner_map_meta) {
-		ret = -ENOMEM;
-		goto put;
-	}
+	if (!inner_map_meta)
+		return ERR_PTR(-ENOMEM);
 
 	inner_map_meta->map_type = inner_map->map_type;
 	inner_map_meta->key_size = inner_map->key_size;
@@ -53,8 +45,9 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
-		ret = PTR_ERR(inner_map_meta->record);
-		goto free;
+		struct bpf_map *ret = ERR_CAST(inner_map_meta->record);
+		kfree(inner_map_meta);
+		return ret;
 	}
 	/* Note: We must use the same BTF, as we also used btf_record_dup above
 	 * which relies on BTF being same for both maps, as some members like
@@ -78,13 +71,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
 	}
 
-	fdput(f);
 	return inner_map_meta;
-free:
-	kfree(inner_map_meta);
-put:
-	fdput(f);
-	return ERR_PTR(ret);
 }
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
@@ -110,9 +97,8 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 			 int ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
-	struct fd f;
+	CLASS(fd, f)(ufd);
 
-	f = fdget(ufd);
 	inner_map = __bpf_map_get(f);
 	if (IS_ERR(inner_map))
 		return inner_map;
@@ -123,7 +109,6 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	else
 		inner_map = ERR_PTR(-EINVAL);
 
-	fdput(f);
 	return inner_map;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fd833a2b7c1b..4b3d770673dd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1418,19 +1418,11 @@ static int map_create(union bpf_attr *attr)
 	return err;
 }
 
-/* if error is returned, fd is released.
- * On success caller should complete fd access with matching fdput()
- */
-struct bpf_map *__bpf_map_get(struct fd f)
+struct bpf_map *bpf_file_to_map(struct file *f)
 {
-	if (!fd_file(f))
-		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_map_fops) {
-		fdput(f);
+	if (unlikely(f->f_op != &bpf_map_fops))
 		return ERR_PTR(-EINVAL);
-	}
-
-	return fd_file(f)->private_data;
+	return f->private_data;
 }
 
 void bpf_map_inc(struct bpf_map *map)
@@ -1448,15 +1440,11 @@ EXPORT_SYMBOL_GPL(bpf_map_inc_with_uref);
 
 struct bpf_map *bpf_map_get(u32 ufd)
 {
-	struct fd f = fdget(ufd);
-	struct bpf_map *map;
-
-	map = __bpf_map_get(f);
-	if (IS_ERR(map))
-		return map;
+	CLASS(fd, f)(ufd);
+	struct bpf_map *map = __bpf_map_get(f);
 
-	bpf_map_inc(map);
-	fdput(f);
+	if (!IS_ERR(map))
+		bpf_map_inc(map);
 
 	return map;
 }
@@ -1464,15 +1452,11 @@ EXPORT_SYMBOL(bpf_map_get);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 {
-	struct fd f = fdget(ufd);
-	struct bpf_map *map;
-
-	map = __bpf_map_get(f);
-	if (IS_ERR(map))
-		return map;
+	CLASS(fd, f)(ufd);
+	struct bpf_map *map = __bpf_map_get(f);
 
-	bpf_map_inc_with_uref(map);
-	fdput(f);
+	if (!IS_ERR(map))
+		bpf_map_inc_with_uref(map);
 
 	return map;
 }
@@ -1537,11 +1521,9 @@ static int map_lookup_elem(union bpf_attr *attr)
 {
 	void __user *ukey = u64_to_user_ptr(attr->key);
 	void __user *uvalue = u64_to_user_ptr(attr->value);
-	int ufd = attr->map_fd;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
-	struct fd f;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
@@ -1550,26 +1532,20 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (attr->flags & ~BPF_F_LOCK)
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
-		err = -EPERM;
-		goto err_put;
-	}
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
+		return -EPERM;
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		err = -EINVAL;
-		goto err_put;
-	}
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
 
 	key = __bpf_copy_key(ukey, map->key_size);
-	if (IS_ERR(key)) {
-		err = PTR_ERR(key);
-		goto err_put;
-	}
+	if (IS_ERR(key))
+		return PTR_ERR(key);
 
 	value_size = bpf_map_value_size(map);
 
@@ -1600,8 +1576,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	kvfree(value);
 free_key:
 	kvfree(key);
-err_put:
-	fdput(f);
 	return err;
 }
 
@@ -1612,17 +1586,15 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
 	bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
-	int ufd = attr->map_fd;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
-	struct fd f;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_UPDATE_ELEM))
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -1660,7 +1632,6 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	kvfree(key);
 err_put:
 	bpf_map_write_active_dec(map);
-	fdput(f);
 	return err;
 }
 
@@ -1669,16 +1640,14 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
-	int ufd = attr->map_fd;
 	struct bpf_map *map;
-	struct fd f;
 	void *key;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_DELETE_ELEM))
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -1715,7 +1684,6 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 	kvfree(key);
 err_put:
 	bpf_map_write_active_dec(map);
-	fdput(f);
 	return err;
 }
 
@@ -1726,30 +1694,24 @@ static int map_get_next_key(union bpf_attr *attr)
 {
 	void __user *ukey = u64_to_user_ptr(attr->key);
 	void __user *unext_key = u64_to_user_ptr(attr->next_key);
-	int ufd = attr->map_fd;
 	struct bpf_map *map;
 	void *key, *next_key;
-	struct fd f;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_GET_NEXT_KEY))
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
-		err = -EPERM;
-		goto err_put;
-	}
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
+		return -EPERM;
 
 	if (ukey) {
 		key = __bpf_copy_key(ukey, map->key_size);
-		if (IS_ERR(key)) {
-			err = PTR_ERR(key);
-			goto err_put;
-		}
+		if (IS_ERR(key))
+			return PTR_ERR(key);
 	} else {
 		key = NULL;
 	}
@@ -1781,8 +1743,6 @@ static int map_get_next_key(union bpf_attr *attr)
 	kvfree(next_key);
 free_key:
 	kvfree(key);
-err_put:
-	fdput(f);
 	return err;
 }
 
@@ -2011,11 +1971,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 {
 	void __user *ukey = u64_to_user_ptr(attr->key);
 	void __user *uvalue = u64_to_user_ptr(attr->value);
-	int ufd = attr->map_fd;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
-	struct fd f;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
@@ -2024,7 +1982,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	if (attr->flags & ~BPF_F_LOCK)
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -2094,7 +2052,6 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	kvfree(key);
 err_put:
 	bpf_map_write_active_dec(map);
-	fdput(f);
 	return err;
 }
 
@@ -2102,27 +2059,22 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 
 static int map_freeze(const union bpf_attr *attr)
 {
-	int err = 0, ufd = attr->map_fd;
+	int err = 0;
 	struct bpf_map *map;
-	struct fd f;
 
 	if (CHECK_ATTR(BPF_MAP_FREEZE))
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS || !IS_ERR_OR_NULL(map->record)) {
-		fdput(f);
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS || !IS_ERR_OR_NULL(map->record))
 		return -ENOTSUPP;
-	}
 
-	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
-		fdput(f);
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE))
 		return -EPERM;
-	}
 
 	mutex_lock(&map->freeze_mutex);
 	if (bpf_map_write_active(map)) {
@@ -2137,7 +2089,6 @@ static int map_freeze(const union bpf_attr *attr)
 	WRITE_ONCE(map->frozen, true);
 err_put:
 	mutex_unlock(&map->freeze_mutex);
-	fdput(f);
 	return err;
 }
 
@@ -2407,18 +2358,6 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
 				O_RDWR | O_CLOEXEC);
 }
 
-static struct bpf_prog *____bpf_prog_get(struct fd f)
-{
-	if (!fd_file(f))
-		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_prog_fops) {
-		fdput(f);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return fd_file(f)->private_data;
-}
-
 void bpf_prog_add(struct bpf_prog *prog, int i)
 {
 	atomic64_add(i, &prog->aux->refcnt);
@@ -2474,20 +2413,22 @@ bool bpf_prog_get_ok(struct bpf_prog *prog,
 static struct bpf_prog *__bpf_prog_get(u32 ufd, enum bpf_prog_type *attach_type,
 				       bool attach_drv)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_prog *prog;
 
-	prog = ____bpf_prog_get(f);
-	if (IS_ERR(prog))
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (fd_file(f)->f_op != &bpf_prog_fops)
+		return ERR_PTR(-EINVAL);
+
+	prog = fd_file(f)->private_data;
+	if (IS_ERR(prog))	// can that actually happen?
 		return prog;
-	if (!bpf_prog_get_ok(prog, attach_type, attach_drv)) {
-		prog = ERR_PTR(-EINVAL);
-		goto out;
-	}
+
+	if (!bpf_prog_get_ok(prog, attach_type, attach_drv))
+		return ERR_PTR(-EINVAL);
 
 	bpf_prog_inc(prog);
-out:
-	fdput(f);
 	return prog;
 }
 
@@ -5154,14 +5095,13 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 			 cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH;
 	bool has_write = cmd != BPF_MAP_LOOKUP_BATCH;
 	struct bpf_map *map;
-	int err, ufd;
-	struct fd f;
+	int err;
 
 	if (CHECK_ATTR(BPF_MAP_BATCH))
 		return -EINVAL;
 
-	ufd = attr->batch.map_fd;
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->batch.map_fd);
+
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -5189,7 +5129,6 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 		maybe_wait_bpf_programs(map);
 		bpf_map_write_active_dec(map);
 	}
-	fdput(f);
 	return err;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..cfd30e79ac76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18399,7 +18399,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-			struct fd f;
 			u64 addr;
 			u32 fd;
 
@@ -18462,7 +18461,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			f = fdget(fd);
+			CLASS(fd, f)(fd);
+
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
 				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
@@ -18470,10 +18470,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			}
 
 			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err) {
-				fdput(f);
+			if (err)
 				return err;
-			}
 
 			aux = &env->insn_aux_data[i];
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
@@ -18484,13 +18482,11 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 
 				if (off >= BPF_MAX_VAR_OFF) {
 					verbose(env, "direct value offset of %u is not allowed\n", off);
-					fdput(f);
 					return -EINVAL;
 				}
 
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
-					fdput(f);
 					return -EINVAL;
 				}
 
@@ -18498,7 +18494,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				if (err) {
 					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
 						map->value_size, off);
-					fdput(f);
 					return err;
 				}
 
@@ -18513,7 +18508,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			for (j = 0; j < env->used_map_cnt; j++) {
 				if (env->used_maps[j] == map) {
 					aux->map_index = j;
-					fdput(f);
 					goto next_insn;
 				}
 			}
@@ -18521,7 +18515,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			if (env->used_map_cnt >= MAX_USED_MAPS) {
 				verbose(env, "The total number of maps per program has reached the limit of %u\n",
 					MAX_USED_MAPS);
-				fdput(f);
 				return -E2BIG;
 			}
 
@@ -18540,39 +18533,32 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
 				verbose(env, "only one cgroup storage of each type is allowed\n");
-				fdput(f);
 				return -EBUSY;
 			}
 			if (map->map_type == BPF_MAP_TYPE_ARENA) {
 				if (env->prog->aux->arena) {
 					verbose(env, "Only one arena per program\n");
-					fdput(f);
 					return -EBUSY;
 				}
 				if (!env->allow_ptr_leaks || !env->bpf_capable) {
 					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
-					fdput(f);
 					return -EPERM;
 				}
 				if (!env->prog->jit_requested) {
 					verbose(env, "JIT is required to use arena\n");
-					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				if (!bpf_jit_supports_arena()) {
 					verbose(env, "JIT doesn't support arena\n");
-					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				env->prog->aux->arena = (void *)map;
 				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
-					fdput(f);
 					return -EINVAL;
 				}
 			}
 
-			fdput(f);
 next_insn:
 			insn++;
 			i++;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9402889840bf..3151dc1c8b3d 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -67,46 +67,39 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
 {
-	u32 ufd = attr->target_fd;
 	struct bpf_map *map;
-	struct fd f;
 	int ret;
 
 	if (attr->attach_flags || attr->replace_bpf_fd)
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->target_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 	mutex_lock(&sockmap_mutex);
 	ret = sock_map_prog_update(map, prog, NULL, NULL, attr->attach_type);
 	mutex_unlock(&sockmap_mutex);
-	fdput(f);
 	return ret;
 }
 
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 {
-	u32 ufd = attr->target_fd;
 	struct bpf_prog *prog;
 	struct bpf_map *map;
-	struct fd f;
 	int ret;
 
 	if (attr->attach_flags || attr->replace_bpf_fd)
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->target_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
 	prog = bpf_prog_get(attr->attach_bpf_fd);
-	if (IS_ERR(prog)) {
-		ret = PTR_ERR(prog);
-		goto put_map;
-	}
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
 
 	if (prog->type != ptype) {
 		ret = -EINVAL;
@@ -118,8 +111,6 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 	mutex_unlock(&sockmap_mutex);
 put_prog:
 	bpf_prog_put(prog);
-put_map:
-	fdput(f);
 	return ret;
 }
 
@@ -1556,18 +1547,17 @@ int sock_map_bpf_prog_query(const union bpf_attr *attr,
 			    union bpf_attr __user *uattr)
 {
 	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
-	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
+	u32 prog_cnt = 0, flags = 0;
 	struct bpf_prog **pprog;
 	struct bpf_prog *prog;
 	struct bpf_map *map;
-	struct fd f;
 	u32 id = 0;
 	int ret;
 
 	if (attr->query.query_flags)
 		return -EINVAL;
 
-	f = fdget(ufd);
+	CLASS(fd, f)(attr->target_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -1599,7 +1589,6 @@ int sock_map_bpf_prog_query(const union bpf_attr *attr,
 	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
 		ret = -EFAULT;
 
-	fdput(f);
 	return ret;
 }
 
-- 
2.39.2


