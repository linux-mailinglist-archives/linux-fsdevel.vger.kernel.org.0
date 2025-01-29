Return-Path: <linux-fsdevel+bounces-40350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3FA226CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 00:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE181884AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CBC1DF99B;
	Wed, 29 Jan 2025 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PalrjD8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49142A92
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192840; cv=none; b=QnIo/WOJgois4HpIMP2lPapM52KVql0FekvpgTor2dp2+GZu4S6q51pqyKtGfGJYJMGT7bbYSo5tqOSK2My5MX4sr5d80ZuKS3FmasBXKAQTQo+nuAndMlszPmO3ieddQMJNgECbwcFcBtvwVLv+pOPxM+bGjWIQnTMbLpYMKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192840; c=relaxed/simple;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyZ4Z7govv1emP+ac6Qz4zqIq7kRGtADyuKYBuiU8jrXE2mg+no7I3L9ou//sV8KBnb64zSdAzr9uMQTmf0gl/t7JqkrQHnZM/u2OgIdnFefbpZHYhpgCJzlOeJG/Xkrb3CbOSo1IAMhbLIbkl8hGkbQk2uCaTJC9839mCEAryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PalrjD8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20251C4CEE0;
	Wed, 29 Jan 2025 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192839;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PalrjD8FVkA4xgtje1X7gPeghL0t25N8vOxTmvgGylzMhQogWtRlaQ26BTHGcJ82N
	 jM9PJwAvcJMZhSXtAVGqS/fU+Sx8OV/Pg5HA5borgDg2vT44GIhlN9zqawv79g2QFU
	 CA4HoeVYvBk2y2bYoJD4Ype3ZylPhFS93tOkLq5zMaw+bcJEVTvf8FiZSBl2kCynVM
	 w/Ir9KKY1bF78OZ9Np6efaoVICa1QfcUgJnV7KA6EPKJDwEQ5CP+E5GC80xrveFeIY
	 BE6e1DzZzcyCMthxu0+17iEIizmLrgQTPzUHsgWVe0mFqgUqflUgQlvyRaiNfgByov
	 AF4GhWIpj1xnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jan 2025 00:19:51 +0100
Subject: [PATCH 1/4] uidgid: add map_id_range_up()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-work-mnt_idmap-statmount-v1-1-d4ced5874e14@kernel.org>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3667; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2n5YV8R+jWWweNb3R3/dpbdGORZv3bE0QOliy8KkJ
 gfdfR4GHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhfMHwVyr5fKeR15tIdQ/G
 9OSy1r361T+LWNOuleyaf66XeW2aNiPDue2Vb4782Siz4p7SBms3c97JkZ+eeHGzFWvPq7tik9b
 JAQA=
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


