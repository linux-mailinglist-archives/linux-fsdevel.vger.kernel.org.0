Return-Path: <linux-fsdevel+bounces-40722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A0A27030
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ED63A6583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8520C03F;
	Tue,  4 Feb 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K24p4QkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B26206F1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668489; cv=none; b=LHBoFCrJYdEelmy8tsYMgVT+sRY6HSr6BYsTRe9Mb8oPbeh4FLpnslMLA8WXmAwEvfk/8c2o2BJtO3NljAcybsx7Vd97jveccFqI0FC6a7mP4UQxhkpj6rNmJP2OCeICk6DDYE1meiAH3fZiULSmxPK3ARHBfTU5bnAk2kvl7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668489; c=relaxed/simple;
	bh=VfZlxiFOtghC/SuXJwma5LbLkFY0sbz0INZU7+l72w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYFFoUMsKpC31wWjWUD0ljf+NSfgqxRJY60QvPnsDq61Nr26ilVeqnu6UXbUVKSYW42+PIJHB3o4j/B5GxH1RXccaiEqiNSIsgyY4lhYwc12BF/XLjPdp5cDA+E1yY37sPB06Yy2fcK5njl3ov7D4SYBypz0Obuzfn9HVLQR5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K24p4QkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF87C4CEDF;
	Tue,  4 Feb 2025 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668488;
	bh=VfZlxiFOtghC/SuXJwma5LbLkFY0sbz0INZU7+l72w0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K24p4QkFC2NnEL1HHzZuTVY3+QtRRsKZGtjQDqh3IKjhu5WzBZNID86jlpCMBPZhR
	 6lvBQxPPTYFdVdtYsSD+XfZqMLxxZ97g5xUHi9CFUc3g9icbF9txha6ooJvYKpY3XH
	 hDy8A4s9PjFt82/C4ZPiD4Yd7YKwpPLibVEOlE+Ol2tUJvXl2TwmXIJ7LG3cHlbBAp
	 wz2mwoEEEJlYiXy1dlLXbovdzbWc6o/Nk/rXlYR39gpvMhVU8GYVDhBGxi1rvjVYYh
	 IzRZOsouZpsPlfSZJ02l1EMHTSH4aBKg8IOZyrdIV+OUQc5+lUoD+ajJt1CzXJX0MY
	 pfjEmARrDxKFA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:27:47 +0100
Subject: [PATCH v2 2/4] statmount: allow to retrieve idmappings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-2-007720f39f2e@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=10961; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VfZlxiFOtghC/SuXJwma5LbLkFY0sbz0INZU7+l72w0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/Hlg16WCS7FP3t2Jlm1WakrNDhV4wbLnV+knla8b9
 NdGLEhb0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARv9OMDGsW6uvpmikH8P5R
 vbhu8+8ll8J/Tazfpigp7NpyVLMyiJvhf9SbpVsdTlSnBgdriL2Uu+hq//Va3sfCpzvt9t7ZW/r
 chQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds the STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP options.
It allows the retrieval of idmappings via statmount().

Currently it isn't possible to figure out what idmappings are applied to
an idmapped mount. This information is often crucial. Before statmount()
the only realistic options for an interface like this would have been to
add it to /proc/<pid>/fdinfo/<nr> or to expose it in
/proc/<pid>/mountinfo. Both solution would have been pretty ugly and
would've shown information that is of strong interest to some
application but not all. statmount() is perfect for this.

The idmappings applied to an idmapped mount are shown relative to the
caller's user namespace. This is the most useful solution that doesn't
risk leaking information or confuse the caller.

For example, an idmapped mount might have been created with the
following idmappings:

    mount --bind -o X-mount.idmap="0:10000:1000 2000:2000:1 3000:3000:1" /srv /opt

Listing the idmappings through statmount() in the same context shows:

    mnt_id:        2147485088
    mnt_parent_id: 2147484816
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
    mnt_uidmap[0]: 0 10000 1000
    mnt_uidmap[1]: 2000 2000 1
    mnt_uidmap[2]: 3000 3000 1
    mnt_gidmap[0]: 0 10000 1000
    mnt_gidmap[1]: 2000 2000 1
    mnt_gidmap[2]: 3000 3000 1

But the idmappings might not always be resolvable in the caller's user
namespace. For example:

    unshare --user --map-root

In this case statmount() will skip any mappings that fil to resolve in
the caller's idmapping:

    mnt_id:        2147485087
    mnt_parent_id: 2147484016
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/

The caller can differentiate between a mount not being idmapped and a
mount that is idmapped but where all mappings fail to resolve in the
caller's idmapping by check for the STATMOUNT_MNT_{G,U}IDMAP flag being
raised but the number of mappings in ->mnt_{g,u}idmap_num being zero.

Note that statmount() requires that the whole range must be resolvable
in the caller's user namespace. If a subrange fails to map it will still
list the map as not resolvable. This is a practical compromise to avoid
having to find which subranges are resovable and wich aren't.

Idmappings are listed as a string array with each mapping separated by
zero bytes. This allows to retrieve the idmappings and immediately use
them for writing to e.g., /proc/<pid>/{g,u}id_map and it also allow for
simple iteration like:

    if (stmnt->mask & STATMOUNT_MNT_UIDMAP) {
            const char *idmap = stmnt->str + stmnt->mnt_uidmap;

            for (size_t idx = 0; idx < stmnt->mnt_uidmap_nr; idx++) {
                    printf("mnt_uidmap[%lu]: %s\n", idx, idmap);
                    idmap += strlen(idmap) + 1;
            }
    }

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h                 |  1 +
 fs/mnt_idmapping.c            | 51 +++++++++++++++++++++++++++++++++++++
 fs/namespace.c                | 59 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mnt_idmapping.h |  5 ++++
 include/uapi/linux/mount.h    |  8 +++++-
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..db6094d5cb0b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -338,3 +338,4 @@ static inline bool path_mounted(const struct path *path)
 	return path->mnt->mnt_root == path->dentry;
 }
 void file_f_owner_release(struct file *file);
+int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);
diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 7b1df8cc2821..a37991fdb194 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -6,6 +6,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
 #include <linux/user_namespace.h>
+#include <linux/seq_file.h>
 
 #include "internal.h"
 
@@ -334,3 +335,53 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		free_mnt_idmap(idmap);
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_put);
+
+int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map)
+{
+	struct uid_gid_map *map, *map_up;
+	u32 idx, nr_mappings;
+
+	if (!is_valid_mnt_idmap(idmap))
+		return 0;
+
+	/*
+	 * Idmappings are shown relative to the caller's idmapping.
+	 * This is both the most intuitive and most useful solution.
+	 */
+	if (uid_map) {
+		map = &idmap->uid_map;
+		map_up = &current_user_ns()->uid_map;
+	} else {
+		map = &idmap->gid_map;
+		map_up = &current_user_ns()->gid_map;
+	}
+
+	for (idx = 0, nr_mappings = 0; idx < map->nr_extents; idx++) {
+		uid_t lower;
+		struct uid_gid_extent *extent;
+
+		if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			extent = &map->extent[idx];
+		else
+			extent = &map->forward[idx];
+
+		/*
+		 * Verify that the whole range of the mapping can be
+		 * resolved in the caller's idmapping. If it cannot be
+		 * resolved skip the mapping.
+		 */
+		lower = map_id_range_up(map_up, extent->lower_first, extent->count);
+		if (lower == (uid_t) -1)
+			continue;
+
+		seq_printf(seq, "%u %u %u", extent->first, lower, extent->count);
+
+		seq->count++; /* mappings are separated by \0 */
+		if (seq_has_overflowed(seq))
+			return -EAGAIN;
+
+		nr_mappings++;
+	}
+
+	return nr_mappings;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cb..cd6efef1fdc2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4915,6 +4915,7 @@ struct kstatmount {
 	struct statmount __user *buf;
 	size_t bufsize;
 	struct vfsmount *mnt;
+	struct mnt_idmap *idmap;
 	u64 mask;
 	struct path root;
 	struct statmount sm;
@@ -5185,6 +5186,46 @@ static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static inline int statmount_mnt_uidmap(struct kstatmount *s, struct seq_file *seq)
+{
+	int ret;
+
+	ret = statmount_mnt_idmap(s->idmap, seq, true);
+	if (ret < 0)
+		return ret;
+
+	s->sm.mnt_uidmap_num = ret;
+	/*
+	 * Always raise STATMOUNT_MNT_UIDMAP even if there are no valid
+	 * mappings. This allows userspace to distinguish between a
+	 * non-idmapped mount and an idmapped mount where none of the
+	 * individual mappings are valid in the caller's idmapping.
+	 */
+	if (is_valid_mnt_idmap(s->idmap))
+		s->sm.mask |= STATMOUNT_MNT_UIDMAP;
+	return 0;
+}
+
+static inline int statmount_mnt_gidmap(struct kstatmount *s, struct seq_file *seq)
+{
+	int ret;
+
+	ret = statmount_mnt_idmap(s->idmap, seq, false);
+	if (ret < 0)
+		return ret;
+
+	s->sm.mnt_gidmap_num = ret;
+	/*
+	 * Always raise STATMOUNT_MNT_GIDMAP even if there are no valid
+	 * mappings. This allows userspace to distinguish between a
+	 * non-idmapped mount and an idmapped mount where none of the
+	 * individual mappings are valid in the caller's idmapping.
+	 */
+	if (is_valid_mnt_idmap(s->idmap))
+		s->sm.mask |= STATMOUNT_MNT_GIDMAP;
+	return 0;
+}
+
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
 	int ret = 0;
@@ -5226,6 +5267,14 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->sb_source = start;
 		ret = statmount_sb_source(s, seq);
 		break;
+	case STATMOUNT_MNT_UIDMAP:
+		sm->mnt_uidmap = start;
+		ret = statmount_mnt_uidmap(s, seq);
+		break;
+	case STATMOUNT_MNT_GIDMAP:
+		sm->mnt_gidmap = start;
+		ret = statmount_mnt_gidmap(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5350,6 +5399,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 		return err;
 
 	s->root = root;
+	s->idmap = mnt_idmap(s->mnt);
 	if (s->mask & STATMOUNT_SB_BASIC)
 		statmount_sb_basic(s);
 
@@ -5383,6 +5433,12 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_SB_SOURCE)
 		err = statmount_string(s, STATMOUNT_SB_SOURCE);
 
+	if (!err && s->mask & STATMOUNT_MNT_UIDMAP)
+		err = statmount_string(s, STATMOUNT_MNT_UIDMAP);
+
+	if (!err && s->mask & STATMOUNT_MNT_GIDMAP)
+		err = statmount_string(s, STATMOUNT_MNT_GIDMAP);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5406,7 +5462,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
 			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
 			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
-			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
+			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY | \
+			      STATMOUNT_MNT_UIDMAP | STATMOUNT_MNT_GIDMAP)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index b1b219bc3422..e71a6070a8f8 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -25,6 +25,11 @@ static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
 static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
 static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
 
+static inline bool is_valid_mnt_idmap(const struct mnt_idmap *idmap)
+{
+	return idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap;
+}
+
 #ifdef CONFIG_MULTIUSER
 static inline uid_t __vfsuid_val(vfsuid_t uid)
 {
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index c07008816aca..0be6ac4c1624 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -179,7 +179,11 @@ struct statmount {
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
 	__u32 opt_sec_num;	/* Number of security options */
 	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
-	__u64 __spare2[46];
+	__u32 mnt_uidmap_num;	/* Number of uid mappings */
+	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers namespace) */
+	__u32 mnt_gidmap_num;	/* Number of gid mappings */
+	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers namespace) */
+	__u64 __spare2[44];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -217,6 +221,8 @@ struct mnt_id_req {
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
+#define STATMOUNT_MNT_UIDMAP		0x00001000U	/* Want/got uidmap... */
+#define STATMOUNT_MNT_GIDMAP		0x00002000U	/* Want/got gidmap... */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.2


