Return-Path: <linux-fsdevel+bounces-3424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A37F468B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3583B20CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E23FE2B;
	Wed, 22 Nov 2023 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ6CnHJ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4C3D999
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55482C433C7;
	Wed, 22 Nov 2023 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700657097;
	bh=m8UauW8T3utqONI/xPOmce94etfNcpHe3Eh/YRiZ0/E=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=gJ6CnHJ5LVlA6y/khMJ7EvZ2I1USaWbOBlFbEYrGn9282raB6g76+SPmzkP+9R7pn
	 AicfM/F2yTVPQBOSDmmauT/TWyiy0BiZzGHxREfgAN2PhplZf9j3KwXw2LpMWFUOom
	 naBe4iwyMwpHlIOLN72DC6tQ3W7sfhJZtNHMRlhvCPIyDLR2MlD8QDDdQxrMhwYQJm
	 g12plgikhN+bZSsMxw3JSUCoGQXZ5k7S9TTZxViyEbpleTGNXtr1vNQjeFBkxDSEF0
	 cr2EbWeyZsc++2fPvLHaXvRDq+ekgZmNzelQi6yX1H26ISxaFdEv0IM2xJy7v8N9v8
	 JVdeN22ZjzADQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Nov 2023 13:44:39 +0100
Subject: [PATCH 3/4] mnt_idmapping: decouple from namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-vfs-mnt_idmap-v1-3-dae4abdde5bd@kernel.org>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
In-Reply-To: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=8406; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m8UauW8T3utqONI/xPOmce94etfNcpHe3Eh/YRiZ0/E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGfj/yS9yra72wf2yZm+D9UMurXRzXrr0zu8O17bDFo
 /37PJbs7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/R5GhrlbJ719uulyn8Ph
 +/lCl4U3T8riL55k1yWdELjgYWv1ExFGhsX5l+PkXrBl5iuvL32ttGCu8QbPEmldpVVe+9clvLn
 5kRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no reason we need to couple mnt idmapping to namespaces in the
way we currently do. Copy the idmapping when an idmapped mount is
created and don't take any reference on the namespace at all.

We also can't easily refcount struct uid_gid_map because it needs to
stay the size of a cacheline otherwise we risk performance regressions
(Ignoring for a second that right now struct uid_gid_map isn't actually
 64 byte but 72 but that's a fix for another patch series.).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c      | 106 +++++++++++++++++++++++++++++++++++++++++-------
 include/linux/uidgid.h  |  13 ++++++
 kernel/user_namespace.c |   4 +-
 3 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 35d78cb3c38a..64c5205e2b5e 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -9,8 +9,16 @@
 
 #include "internal.h"
 
+/*
+ * Outside of this file vfs{g,u}id_t are always created from k{g,u}id_t,
+ * never from raw values. These are just internal helpers.
+ */
+#define VFSUIDT_INIT_RAW(val) (vfsuid_t){ val }
+#define VFSGIDT_INIT_RAW(val) (vfsgid_t){ val }
+
 struct mnt_idmap {
-	struct user_namespace *owner;
+	struct uid_gid_map uid_map;
+	struct uid_gid_map gid_map;
 	refcount_t count;
 };
 
@@ -20,7 +28,6 @@ struct mnt_idmap {
  * mapped to {g,u}id 1, [...], {g,u}id 1000 to {g,u}id 1000, [...].
  */
 struct mnt_idmap nop_mnt_idmap = {
-	.owner	= &init_user_ns,
 	.count	= REFCOUNT_INIT(1),
 };
 EXPORT_SYMBOL_GPL(nop_mnt_idmap);
@@ -65,7 +72,6 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		     kuid_t kuid)
 {
 	uid_t uid;
-	struct user_namespace *mnt_userns = idmap->owner;
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSUIDT_INIT(kuid);
@@ -75,7 +81,7 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		uid = from_kuid(fs_userns, kuid);
 	if (uid == (uid_t)-1)
 		return INVALID_VFSUID;
-	return VFSUIDT_INIT(make_kuid(mnt_userns, uid));
+	return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
 }
 EXPORT_SYMBOL_GPL(make_vfsuid);
 
@@ -103,7 +109,6 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 		     struct user_namespace *fs_userns, kgid_t kgid)
 {
 	gid_t gid;
-	struct user_namespace *mnt_userns = idmap->owner;
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSGIDT_INIT(kgid);
@@ -113,7 +118,7 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 		gid = from_kgid(fs_userns, kgid);
 	if (gid == (gid_t)-1)
 		return INVALID_VFSGID;
-	return VFSGIDT_INIT(make_kgid(mnt_userns, gid));
+	return VFSGIDT_INIT_RAW(map_id_down(&idmap->gid_map, gid));
 }
 EXPORT_SYMBOL_GPL(make_vfsgid);
 
@@ -132,11 +137,10 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
 		   struct user_namespace *fs_userns, vfsuid_t vfsuid)
 {
 	uid_t uid;
-	struct user_namespace *mnt_userns = idmap->owner;
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KUIDT(vfsuid);
-	uid = from_kuid(mnt_userns, AS_KUIDT(vfsuid));
+	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
 	if (uid == (uid_t)-1)
 		return INVALID_UID;
 	if (initial_idmapping(fs_userns))
@@ -160,11 +164,10 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
 		   struct user_namespace *fs_userns, vfsgid_t vfsgid)
 {
 	gid_t gid;
-	struct user_namespace *mnt_userns = idmap->owner;
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KGIDT(vfsgid);
-	gid = from_kgid(mnt_userns, AS_KGIDT(vfsgid));
+	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
 	if (gid == (gid_t)-1)
 		return INVALID_GID;
 	if (initial_idmapping(fs_userns))
@@ -195,16 +198,91 @@ int vfsgid_in_group_p(vfsgid_t vfsgid)
 #endif
 EXPORT_SYMBOL_GPL(vfsgid_in_group_p);
 
+static int copy_mnt_idmap(struct uid_gid_map *map_from,
+			  struct uid_gid_map *map_to)
+{
+	struct uid_gid_extent *forward, *reverse;
+	u32 nr_extents = READ_ONCE(map_from->nr_extents);
+	/* Pairs with smp_wmb() when writing the idmapping. */
+	smp_rmb();
+
+	/*
+	 * Don't blindly copy @map_to into @map_from if nr_extents is
+	 * smaller or equal to UID_GID_MAP_MAX_BASE_EXTENTS. Since we
+	 * read @nr_extents someone could have written an idmapping and
+	 * then we might end up with inconsistent data. So just don't do
+	 * anything at all.
+	 */
+	if (nr_extents == 0)
+		return 0;
+
+	/*
+	 * Here we know that nr_extents is greater than zero which means
+	 * a map has been written. Since idmappings can't be changed
+	 * once they have been written we know that we can safely copy
+	 * from @map_to into @map_from.
+	 */
+
+	if (nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
+		*map_to = *map_from;
+		return 0;
+	}
+
+	forward = kmemdup(map_from->forward,
+			  nr_extents * sizeof(struct uid_gid_extent),
+			  GFP_KERNEL_ACCOUNT);
+	if (!forward)
+		return -ENOMEM;
+
+	reverse = kmemdup(map_from->reverse,
+			  nr_extents * sizeof(struct uid_gid_extent),
+			  GFP_KERNEL_ACCOUNT);
+	if (!reverse) {
+		kfree(forward);
+		return -ENOMEM;
+	}
+
+	/*
+	 * The idmapping isn't exposed anywhere so we don't need to care
+	 * about ordering between extent pointers and @nr_extents
+	 * initialization.
+	 */
+	map_to->forward = forward;
+	map_to->reverse = reverse;
+	map_to->nr_extents = nr_extents;
+	return 0;
+}
+
+static void free_mnt_idmap(struct mnt_idmap *idmap)
+{
+	if (idmap->uid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+		kfree(idmap->uid_map.forward);
+		kfree(idmap->uid_map.reverse);
+	}
+	if (idmap->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+		kfree(idmap->gid_map.forward);
+		kfree(idmap->gid_map.reverse);
+	}
+	kfree(idmap);
+}
+
 struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
 {
 	struct mnt_idmap *idmap;
+	int ret;
 
 	idmap = kzalloc(sizeof(struct mnt_idmap), GFP_KERNEL_ACCOUNT);
 	if (!idmap)
 		return ERR_PTR(-ENOMEM);
 
-	idmap->owner = get_user_ns(mnt_userns);
 	refcount_set(&idmap->count, 1);
+	ret = copy_mnt_idmap(&mnt_userns->uid_map, &idmap->uid_map);
+	if (!ret)
+		ret = copy_mnt_idmap(&mnt_userns->gid_map, &idmap->gid_map);
+	if (ret) {
+		free_mnt_idmap(idmap);
+		idmap = ERR_PTR(ret);
+	}
 	return idmap;
 }
 
@@ -234,9 +312,7 @@ EXPORT_SYMBOL_GPL(mnt_idmap_get);
  */
 void mnt_idmap_put(struct mnt_idmap *idmap)
 {
-	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count)) {
-		put_user_ns(idmap->owner);
-		kfree(idmap);
-	}
+	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count))
+		free_mnt_idmap(idmap);
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index b0542cd11aeb..7806e93b907d 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -17,6 +17,7 @@
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
+struct uid_gid_map;
 
 typedef struct {
 	uid_t val;
@@ -138,6 +139,9 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
 	return from_kgid(ns, gid) != (gid_t) -1;
 }
 
+u32 map_id_down(struct uid_gid_map *map, u32 id);
+u32 map_id_up(struct uid_gid_map *map, u32 id);
+
 #else
 
 static inline kuid_t make_kuid(struct user_namespace *from, uid_t uid)
@@ -186,6 +190,15 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
 	return gid_valid(gid);
 }
 
+static inline u32 map_id_down(struct uid_gid_map *map, u32 id)
+{
+	return id;
+}
+
+static inline u32 map_id_up(struct uid_gid_map *map, u32 id);
+{
+	return id;
+}
 #endif /* CONFIG_USER_NS */
 
 #endif /* _LINUX_UIDGID_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index eabe8bcc7042..a649e58e3b6a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -332,7 +332,7 @@ static u32 map_id_range_down(struct uid_gid_map *map, u32 id, u32 count)
 	return id;
 }
 
-static u32 map_id_down(struct uid_gid_map *map, u32 id)
+u32 map_id_down(struct uid_gid_map *map, u32 id)
 {
 	return map_id_range_down(map, id, 1);
 }
@@ -375,7 +375,7 @@ map_id_up_max(unsigned extents, struct uid_gid_map *map, u32 id)
 		       sizeof(struct uid_gid_extent), cmp_map_id);
 }
 
-static u32 map_id_up(struct uid_gid_map *map, u32 id)
+u32 map_id_up(struct uid_gid_map *map, u32 id)
 {
 	struct uid_gid_extent *extent;
 	unsigned extents = map->nr_extents;

-- 
2.42.0


