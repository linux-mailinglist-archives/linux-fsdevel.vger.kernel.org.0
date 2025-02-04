Return-Path: <linux-fsdevel+bounces-40721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D661A2702F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04D0164ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEA20C037;
	Tue,  4 Feb 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr8wOC/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA6206F1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668486; cv=none; b=G1C/BaUVx5VEICxRx4WgUopWzCGTojV8Sh8QC5lSoUS8Vm7G/gfJj5r0/WkBw6hvV4XhfOg8uAuLSBzdGtQLN7zN888zGat6FCEyuyWup2eSXi652dnavJgmDOYAEwKGDXhBL090Ts7aUaqUhwboVeccy/fR+42t6Q/7m0J8/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668486; c=relaxed/simple;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VESDuKEEfKOrTltab9PPzP6UbJ+otjCYJgH0p7+cH5QatgmuD2dgMvsN/F+F+EXdqLW9tEtcXbrSfgU208GMjsJjqNs0p8HrjcTumDfLD0HJtlpGX0f8ZTSKfhjp105Msnfc3oc9N6nxhY4DYm4rCygAMB+3W7TvDB8X081WjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr8wOC/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A30C4CEE4;
	Tue,  4 Feb 2025 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668485;
	bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yr8wOC/CwkeUrLLJct77IxA8ozo3ZpejE8OFxd/viwyzCLtBEreUjRFJjM4cFNS0P
	 Ptf5hyVXFr+RbVJEFPQ4liZuTtR+INPct2JG7XMxo0ZXqyCy8okUVpQVG4KsXRQsFS
	 iG9lrqdaQKiDRiwBIOp1k9wU90r7GLCYzmEVyD4wbnSU5Zk518/3oVH+g6bK7eEofR
	 uv4lBJTIfKSVjOozpaWKTnQCGXwPFK+UPH0glK2nu8tb7UOMfDPeNWYIpWL2jkQm/Q
	 oC4cIXiyA6ZzUmiLzaSK2vYS+07qDQ5DBwWh6Ywy8wYWMSPQiDJReXUI1UKUAMCkqy
	 fssDrJ1aGqj7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:27:46 +0100
Subject: [PATCH v2 1/4] uidgid: add map_id_range_up()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-1-007720f39f2e@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3667; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wTsrhUjhnpw3/U1pdxkhcu+UK+qHYqsWxnahJ8LlV+8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/HngwW3PLWl5j/RPad6U2NSQ/ddYRIUx31ZUumh/H
 oPYjNPzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy1oHhf0TGLjUNp/aaqgsn
 eB7lpXFrr3tv0LBYukLUdZItyx++u4wMm6cu3aNgsHalTrXR2YBCr1xdXnupAJ+OVWJbfXVPLNN
 iBAA=
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


