Return-Path: <linux-fsdevel+bounces-40726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D656A27034
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CA17A4B43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4220C038;
	Tue,  4 Feb 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRIOGvgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD120C032
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668536; cv=none; b=Zx/MFCxkNaQFK530c0nuIO37lw/0YTYDcU5Xf6HPHWRWFwE+6dOkFwW+sAC8bxwfM1xE2S0Icyo/x0ykq742CqRtnZiAefRxiNE4YVSiM30ZFubNd8xO91DAbWVPXDKqRog09XZXiBlCBLJkKBOY1bBryRgXozHSCicXWXKUeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668536; c=relaxed/simple;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mxwu5MoiSb1sQkw+xsmJnYl+d1jHTvx2kNbfBYF0hJfD1FB+gztziMTnLPYwHtZ9C/p0h2XO3W5cApPTcE7jByTQiEB8/Lx2JfqIWx8CVRxuj2wm9JOPZpdS/5Em8yPkOi9Lx2DEnhbFwzDCTz2VKMrnLrSz3jjKpZ6nbdlJowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRIOGvgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDE3C4CEE4;
	Tue,  4 Feb 2025 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668535;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FRIOGvguAjuTs3+YzqQUcGjtQUYR66EKXffdvaeSiV7yGbhgzTknRhBTzyHMGekeU
	 pJSj6yon7Huiyo+0d9n9C1E8KSZmLtVwF2VIATLiZ1+jMdSA2iqz/q5aMa0fp9NV11
	 0Z3uG0ZexQ46yO/POYZABJEanSESGIYU6F1H+CjDVgekNjgd8kw2tNE9WIyfVR1Tu1
	 4N2nwitxchRJmq8uof2k/1nsX1CAAeRYw7r2wmMwQk3Hgb1Nvx8+VDYlUBT0IhEB5M
	 Lutsp+fheL1BcX+P3qPFBCJknz3LspRnmqKb/StSGZH8RYSKMkr7VHXnBAKNv9vQmN
	 XnLwSc/MxwpyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:28:46 +0100
Subject: [PATCH v2 1/4] uidgid: add map_id_range_up()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-1-0ef9b19b27c3@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-0ef9b19b27c3@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-0ef9b19b27c3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3667; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/PmpX5DN8f/cnZE6a7zCd8uu52Y7VmQ8/ca/er7P9
 0K1ykMXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkuwnD/5ze1GyGStlfu/YY
 5F87d858+o2q5Wrbmh+d2mxqPdG3qJrhf9iKmXaRb9vmysx+/KEo0Szj6gy1OueHei2/tH6GfLr
 +hRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add map_id_range_up() to verify that the full kernel id range can be
mapped up in a given idmapping. This will be used in follow-up patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/uidgid.h  |  6 ++++++
 kernel/user_namespace.c | 26 +++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index f85ec5613721..2dc767e08f54 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -132,6 +132,7 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
 
 u32 map_id_down(struct uid_gid_map *map, u32 id);
 u32 map_id_up(struct uid_gid_map *map, u32 id);
+u32 map_id_range_up(struct uid_gid_map *map, u32 id, u32 count);
 
 #else
 
@@ -186,6 +187,11 @@ static inline u32 map_id_down(struct uid_gid_map *map, u32 id)
 	return id;
 }
 
+static inline u32 map_id_range_up(struct uid_gid_map *map, u32 id, u32 count)
+{
+	return id;
+}
+
 static inline u32 map_id_up(struct uid_gid_map *map, u32 id)
 {
 	return id;
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index aa0b2e47f2f2..682f40d5632d 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -238,7 +238,7 @@ EXPORT_SYMBOL(__put_user_ns);
 struct idmap_key {
 	bool map_up; /* true  -> id from kid; false -> kid from id */
 	u32 id; /* id to find */
-	u32 count; /* == 0 unless used with map_id_range_down() */
+	u32 count;
 };
 
 /*
@@ -343,16 +343,19 @@ u32 map_id_down(struct uid_gid_map *map, u32 id)
  * UID_GID_MAP_MAX_BASE_EXTENTS.
  */
 static struct uid_gid_extent *
-map_id_up_base(unsigned extents, struct uid_gid_map *map, u32 id)
+map_id_range_up_base(unsigned extents, struct uid_gid_map *map, u32 id, u32 count)
 {
 	unsigned idx;
-	u32 first, last;
+	u32 first, last, id2;
+
+	id2 = id + count - 1;
 
 	/* Find the matching extent */
 	for (idx = 0; idx < extents; idx++) {
 		first = map->extent[idx].lower_first;
 		last = first + map->extent[idx].count - 1;
-		if (id >= first && id <= last)
+		if (id >= first && id <= last &&
+		    (id2 >= first && id2 <= last))
 			return &map->extent[idx];
 	}
 	return NULL;
@@ -363,28 +366,28 @@ map_id_up_base(unsigned extents, struct uid_gid_map *map, u32 id)
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
 static struct uid_gid_extent *
-map_id_up_max(unsigned extents, struct uid_gid_map *map, u32 id)
+map_id_range_up_max(unsigned extents, struct uid_gid_map *map, u32 id, u32 count)
 {
 	struct idmap_key key;
 
 	key.map_up = true;
-	key.count = 1;
+	key.count = count;
 	key.id = id;
 
 	return bsearch(&key, map->reverse, extents,
 		       sizeof(struct uid_gid_extent), cmp_map_id);
 }
 
-u32 map_id_up(struct uid_gid_map *map, u32 id)
+u32 map_id_range_up(struct uid_gid_map *map, u32 id, u32 count)
 {
 	struct uid_gid_extent *extent;
 	unsigned extents = map->nr_extents;
 	smp_rmb();
 
 	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-		extent = map_id_up_base(extents, map, id);
+		extent = map_id_range_up_base(extents, map, id, count);
 	else
-		extent = map_id_up_max(extents, map, id);
+		extent = map_id_range_up_max(extents, map, id, count);
 
 	/* Map the id or note failure */
 	if (extent)
@@ -395,6 +398,11 @@ u32 map_id_up(struct uid_gid_map *map, u32 id)
 	return id;
 }
 
+u32 map_id_up(struct uid_gid_map *map, u32 id)
+{
+	return map_id_range_up(map, id, 1);
+}
+
 /**
  *	make_kuid - Map a user-namespace uid pair into a kuid.
  *	@ns:  User namespace that the uid is in

-- 
2.47.2


