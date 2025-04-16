Return-Path: <linux-fsdevel+bounces-46560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2467A9043F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54218A2F65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F111BD9D0;
	Wed, 16 Apr 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtu0KuJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703E1DED76
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809468; cv=none; b=OiQY5xUnqNzzpKgZ1Yq1Doy1yIhEURSIprk+PxWQEOylK/HcpsHIU3xsdfFvw8nCrCCxmezu8jakxnht+c6R618oEh5+j/s6bgD3lAMG4uB1V+styqRGmOYTSdTmuQWcTLLDnW58xhMEtPZAposNNGQNBnH5Iys9FdMxiBOlk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809468; c=relaxed/simple;
	bh=ZpcBoDRaLJjfUNCD42ZoutluKwLn0eAAED/EEx7Y08g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2i/eI+KwiMsdNp743Y4Zf6ZvRryMOOGukijQYGDWbSdSMWniGXu53BSoNPFgR9apTLHdIIynFOlyGHzvdafSygQ3WRc9GvXQ95cpVdO0DNy3BGiYaYx+oy1xvfeklv6W98R0bkOJi4hOc+mlPcGtIOXko3u4issJLVj9Y6Go88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtu0KuJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F684C4CEE2;
	Wed, 16 Apr 2025 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744809468;
	bh=ZpcBoDRaLJjfUNCD42ZoutluKwLn0eAAED/EEx7Y08g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jtu0KuJy14v81mVGZ7bwQBsw32DhRDh3ItXaLS4dDeu+hUZLvc/m10rxu8H1lLmr+
	 Ff+R34c3IHLEgeQ2Q21+E3t5QfVcgW+oirS7eeGb7cJRJwv54Oq+XAX/CBoyNesgkW
	 x6/esFJQrkhZIN02zjwLzGDm3qmYd2EvqDWf4ZF3E9oQJ6M4acs3bJMF5pxzCHMBCt
	 0XX9bjqnYwrw840Vxom+Vjj+j/+JtSLmvScgE2Gf+iUT8a9BGe5h8W9p8jYnlnnUj9
	 Gv7ei5LcW0KubDLUv9wkrXO5w+hVG1f8Ciycr6VywWNh3wZwH2gpsRzzH0E1IECjId
	 XLY2NxOmVJWQA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 3/3] mnt_idmapping: inline all low-level helpers
Date: Wed, 16 Apr 2025 15:17:24 +0200
Message-ID: <20250416-work-mnt_idmap-s_user_ns-v1-3-273bef3a61ec@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12181; i=brauner@kernel.org; h=from:subject:message-id; bh=ZpcBoDRaLJjfUNCD42ZoutluKwLn0eAAED/EEx7Y08g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/X/uk8mhfsqbf9OTfyyy+12quiZi8a4r5on/2tWZpS mf6LzDu6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIAwvDP5Wo4hB7JWbHTxv1 q7wPVR2fOPG+Z8yvncmhJz9XPv/3dA8jw4LDWyW9W40uG8vK2FVs9t+iJq5lXf7a9nLf55Wb7va dYwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Let's inline all low-level helpers and use likely()/unlikely() to help
the compiler along.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c            | 145 -----------------------------------------
 include/linux/mnt_idmapping.h | 147 +++++++++++++++++++++++++++++++++++++++---
 kernel/user_namespace.c       |   2 +
 3 files changed, 141 insertions(+), 153 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 5c7e1db8fef8..ba1f752b6fa7 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -10,13 +10,6 @@
 
 #include "internal.h"
 
-/*
- * Outside of this file vfs{g,u}id_t are always created from k{g,u}id_t,
- * never from raw values. These are just internal helpers.
- */
-#define VFSUIDT_INIT_RAW(val) (vfsuid_t){ val }
-#define VFSGIDT_INIT_RAW(val) (vfsgid_t){ val }
-
 /*
  * Carries the initial idmapping of 0:0:4294967295 which is an identity
  * mapping. This means that {g,u}id 0 is mapped to {g,u}id 0, {g,u}id 1 is
@@ -36,144 +29,6 @@ struct mnt_idmap invalid_mnt_idmap = {
 };
 EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
 
-/**
- * make_vfsuid - map a filesystem kuid according to an idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kuid : kuid to be mapped
- *
- * Take a @kuid and remap it from @fs_userns into @idmap. Use this
- * function when preparing a @kuid to be reported to userspace.
- *
- * If initial_idmapping() determines that this is not an idmapped mount
- * we can simply return @kuid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kuid won't change when calling
- * from_kuid() so we can simply retrieve the value via __kuid_val()
- * directly.
- *
- * Return: @kuid mapped according to @idmap.
- * If @kuid has no mapping in either @idmap or @fs_userns INVALID_UID is
- * returned.
- */
-
-vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
-		     struct user_namespace *fs_userns,
-		     kuid_t kuid)
-{
-	uid_t uid;
-
-	if (idmap == &nop_mnt_idmap)
-		return VFSUIDT_INIT(kuid);
-	if (idmap == &invalid_mnt_idmap)
-		return INVALID_VFSUID;
-	if (initial_idmapping(fs_userns))
-		uid = __kuid_val(kuid);
-	else
-		uid = from_kuid(fs_userns, kuid);
-	if (uid == (uid_t)-1)
-		return INVALID_VFSUID;
-	return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
-}
-EXPORT_SYMBOL_GPL(make_vfsuid);
-
-/**
- * make_vfsgid - map a filesystem kgid according to an idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kgid : kgid to be mapped
- *
- * Take a @kgid and remap it from @fs_userns into @idmap. Use this
- * function when preparing a @kgid to be reported to userspace.
- *
- * If initial_idmapping() determines that this is not an idmapped mount
- * we can simply return @kgid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kgid won't change when calling
- * from_kgid() so we can simply retrieve the value via __kgid_val()
- * directly.
- *
- * Return: @kgid mapped according to @idmap.
- * If @kgid has no mapping in either @idmap or @fs_userns INVALID_GID is
- * returned.
- */
-vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
-		     struct user_namespace *fs_userns, kgid_t kgid)
-{
-	gid_t gid;
-
-	if (idmap == &nop_mnt_idmap)
-		return VFSGIDT_INIT(kgid);
-	if (idmap == &invalid_mnt_idmap)
-		return INVALID_VFSGID;
-	if (initial_idmapping(fs_userns))
-		gid = __kgid_val(kgid);
-	else
-		gid = from_kgid(fs_userns, kgid);
-	if (gid == (gid_t)-1)
-		return INVALID_VFSGID;
-	return VFSGIDT_INIT_RAW(map_id_down(&idmap->gid_map, gid));
-}
-EXPORT_SYMBOL_GPL(make_vfsgid);
-
-/**
- * from_vfsuid - map a vfsuid into the filesystem idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @vfsuid : vfsuid to be mapped
- *
- * Map @vfsuid into the filesystem idmapping. This function has to be used in
- * order to e.g. write @vfsuid to inode->i_uid.
- *
- * Return: @vfsuid mapped into the filesystem idmapping
- */
-kuid_t from_vfsuid(struct mnt_idmap *idmap,
-		   struct user_namespace *fs_userns, vfsuid_t vfsuid)
-{
-	uid_t uid;
-
-	if (idmap == &nop_mnt_idmap)
-		return AS_KUIDT(vfsuid);
-	if (idmap == &invalid_mnt_idmap)
-		return INVALID_UID;
-	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
-	if (uid == (uid_t)-1)
-		return INVALID_UID;
-	if (initial_idmapping(fs_userns))
-		return KUIDT_INIT(uid);
-	return make_kuid(fs_userns, uid);
-}
-EXPORT_SYMBOL_GPL(from_vfsuid);
-
-/**
- * from_vfsgid - map a vfsgid into the filesystem idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @vfsgid : vfsgid to be mapped
- *
- * Map @vfsgid into the filesystem idmapping. This function has to be used in
- * order to e.g. write @vfsgid to inode->i_gid.
- *
- * Return: @vfsgid mapped into the filesystem idmapping
- */
-kgid_t from_vfsgid(struct mnt_idmap *idmap,
-		   struct user_namespace *fs_userns, vfsgid_t vfsgid)
-{
-	gid_t gid;
-
-	if (idmap == &nop_mnt_idmap)
-		return AS_KGIDT(vfsgid);
-	if (idmap == &invalid_mnt_idmap)
-		return INVALID_GID;
-	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
-	if (gid == (gid_t)-1)
-		return INVALID_GID;
-	if (initial_idmapping(fs_userns))
-		return KGIDT_INIT(gid);
-	return make_kgid(fs_userns, gid);
-}
-EXPORT_SYMBOL_GPL(from_vfsgid);
-
 #ifdef CONFIG_MULTIUSER
 /**
  * vfsgid_in_group_p() - check whether a vfsuid matches the caller's groups
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 4410672c2828..e6fb905c39bd 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -140,22 +140,153 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 #define AS_KUIDT(val) (kuid_t){ __vfsuid_val(val) }
 #define AS_KGIDT(val) (kgid_t){ __vfsgid_val(val) }
 
+/*
+ * Outside of this file vfs{g,u}id_t are always created from k{g,u}id_t,
+ * never from raw values. These are just internal helpers.
+ */
+#define VFSUIDT_INIT_RAW(val) (vfsuid_t){ val }
+#define VFSGIDT_INIT_RAW(val) (vfsgid_t){ val }
+
 int vfsgid_in_group_p(vfsgid_t vfsgid);
 
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
 
-vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
-		     struct user_namespace *fs_userns, kuid_t kuid);
+/**
+ * make_vfsuid - map a filesystem kuid according to an idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kuid : kuid to be mapped
+ *
+ * Take a @kuid and remap it from @fs_userns into @idmap. Use this
+ * function when preparing a @kuid to be reported to userspace.
+ *
+ * If initial_idmapping() determines that this is not an idmapped mount
+ * we can simply return @kuid unchanged.
+ * If initial_idmapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kuid won't change when calling
+ * from_kuid() so we can simply retrieve the value via __kuid_val()
+ * directly.
+ *
+ * Return: @kuid mapped according to @idmap.
+ * If @kuid has no mapping in either @idmap or @fs_userns INVALID_UID is
+ * returned.
+ */
+static inline vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
+				   struct user_namespace *fs_userns,
+				   kuid_t kuid)
+{
+	uid_t uid;
+
+	if (likely(idmap == &nop_mnt_idmap))
+		return VFSUIDT_INIT(kuid);
+	if (unlikely(idmap == &invalid_mnt_idmap))
+		return INVALID_VFSUID;
+	if (likely(initial_idmapping(fs_userns)))
+		uid = __kuid_val(kuid);
+	else
+		uid = from_kuid(fs_userns, kuid);
+	if (unlikely(uid == (uid_t)-1))
+		return INVALID_VFSUID;
+	return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
+}
 
-vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
-		     struct user_namespace *fs_userns, kgid_t kgid);
+/**
+ * make_vfsgid - map a filesystem kgid according to an idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kgid : kgid to be mapped
+ *
+ * Take a @kgid and remap it from @fs_userns into @idmap. Use this
+ * function when preparing a @kgid to be reported to userspace.
+ *
+ * If initial_idmapping() determines that this is not an idmapped mount
+ * we can simply return @kgid unchanged.
+ * If initial_idmapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kgid won't change when calling
+ * from_kgid() so we can simply retrieve the value via __kgid_val()
+ * directly.
+ *
+ * Return: @kgid mapped according to @idmap.
+ * If @kgid has no mapping in either @idmap or @fs_userns INVALID_GID is
+ * returned.
+ */
+static inline vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
+				   struct user_namespace *fs_userns,
+				   kgid_t kgid)
+{
+	gid_t gid;
+
+	if (likely(idmap == &nop_mnt_idmap))
+		return VFSGIDT_INIT(kgid);
+	if (unlikely(idmap == &invalid_mnt_idmap))
+		return INVALID_VFSGID;
+	if (likely(initial_idmapping(fs_userns)))
+		gid = __kgid_val(kgid);
+	else
+		gid = from_kgid(fs_userns, kgid);
+	if (unlikely(gid == (gid_t)-1))
+		return INVALID_VFSGID;
+	return VFSGIDT_INIT_RAW(map_id_down(&idmap->gid_map, gid));
+}
 
-kuid_t from_vfsuid(struct mnt_idmap *idmap,
-		   struct user_namespace *fs_userns, vfsuid_t vfsuid);
+/**
+ * from_vfsuid - map a vfsuid into the filesystem idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsuid : vfsuid to be mapped
+ *
+ * Map @vfsuid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsuid to inode->i_uid.
+ *
+ * Return: @vfsuid mapped into the filesystem idmapping
+ */
+static inline kuid_t from_vfsuid(struct mnt_idmap *idmap,
+				 struct user_namespace *fs_userns,
+				 vfsuid_t vfsuid)
+{
+	uid_t uid;
+
+	if (likely(idmap == &nop_mnt_idmap))
+		return AS_KUIDT(vfsuid);
+	if (unlikely(idmap == &invalid_mnt_idmap))
+		return INVALID_UID;
+	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
+	if (unlikely(uid == (uid_t)-1))
+		return INVALID_UID;
+	if (likely(initial_idmapping(fs_userns)))
+		return KUIDT_INIT(uid);
+	return make_kuid(fs_userns, uid);
+}
 
-kgid_t from_vfsgid(struct mnt_idmap *idmap,
-		   struct user_namespace *fs_userns, vfsgid_t vfsgid);
+/**
+ * from_vfsgid - map a vfsgid into the filesystem idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsgid : vfsgid to be mapped
+ *
+ * Map @vfsgid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsgid to inode->i_gid.
+ *
+ * Return: @vfsgid mapped into the filesystem idmapping
+ */
+static inline kgid_t from_vfsgid(struct mnt_idmap *idmap,
+				 struct user_namespace *fs_userns,
+				 vfsgid_t vfsgid)
+{
+	gid_t gid;
+
+	if (likely(idmap == &nop_mnt_idmap))
+		return AS_KGIDT(vfsgid);
+	if (unlikely(idmap == &invalid_mnt_idmap))
+		return INVALID_GID;
+	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
+	if (unlikely(gid == (gid_t)-1))
+		return INVALID_GID;
+	if (likely(initial_idmapping(fs_userns)))
+		return KGIDT_INIT(gid);
+	return make_kgid(fs_userns, gid);
+}
 
 /**
  * vfsuid_has_fsmapping - check whether a vfsuid maps into the filesystem
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 682f40d5632d..693c62587571 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -336,6 +336,7 @@ u32 map_id_down(struct uid_gid_map *map, u32 id)
 {
 	return map_id_range_down(map, id, 1);
 }
+EXPORT_SYMBOL_GPL(map_id_down);
 
 /*
  * map_id_up_base - Find idmap via binary search in static extent array.
@@ -402,6 +403,7 @@ u32 map_id_up(struct uid_gid_map *map, u32 id)
 {
 	return map_id_range_up(map, id, 1);
 }
+EXPORT_SYMBOL_GPL(map_id_up);
 
 /**
  *	make_kuid - Map a user-namespace uid pair into a kuid.

-- 
2.47.2


