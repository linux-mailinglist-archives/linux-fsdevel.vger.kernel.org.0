Return-Path: <linux-fsdevel+bounces-40351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99401A226D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 00:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294557A2E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFF1B425D;
	Wed, 29 Jan 2025 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZnZzEhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27419D898
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192842; cv=none; b=fEJ7ExWpb5uEAYI612hlDv26ELEhYXCIjBARjpuWf+iXIMWUa4iJx2W7P8WlQYsYyV0UmtkFytxD71/cJzp3/XAf8ZzRtBnzWoUXjoWRY+pKsMjYfZ7vxlA/6iOBww45gyA1vk66++hnbdoafq4xy3QQ0TbGCP8ItSus/r5pWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192842; c=relaxed/simple;
	bh=Yi0G51p49bIoe58G/MX6QtWfJZ/7DtUi8LiQSMo8y7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIKBeWU9Ho8F27KGcdlsv/gs+ikYk8g8CTd8MLz0p7aUrSnF65bd22uvIS3RwrXEd0tor/nRjp3I9wjSyuIL4C02lw569ZM0js9/xGEGYiep71y6HYR3hyeQ+q8KljHnys3ZC6GVL7N+Ea7/cwmHeasjRpNf/e76Xt5qIoP2zTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZnZzEhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419AFC4CED1;
	Wed, 29 Jan 2025 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192842;
	bh=Yi0G51p49bIoe58G/MX6QtWfJZ/7DtUi8LiQSMo8y7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dZnZzEhgihbxiRT72tom7lKIYMjzeTFIaihLpOKI5m4Mc1lRLLVRyGYHgqYAToEsg
	 /y6/DAn73bpXW67xB/NxRMATvJg/KxgWHNc91A4Kf1DprUycYVk32tFCp/ABs5m0aC
	 f8rA6JEE4ZXolZjUKncpn8wJxevcz3Uk+Knu17k0yuG00kw9NnsAXTS56X9nefRKO5
	 Ds9eyo1zdCxbXMecGHsxYWSgljUDMgVLbXvE9OzdvfyxxkREhLH/xvO77OCUo0pfsS
	 4L88oNaE29rJ9lzpl0c8HUw5RDw9C3PnwJIRpBMUls5XVa7Q+7Lu1RS/9ZzWbOXK0d
	 TamXRDoKwGxdg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jan 2025 00:19:52 +0100
Subject: [PATCH 2/4] statmount: allow to retrieve idmappings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-work-mnt_idmap-statmount-v1-2-d4ced5874e14@kernel.org>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=9808; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Yi0G51p49bIoe58G/MX6QtWfJZ/7DtUi8LiQSMo8y7U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2n54hXQSt3f32pjKpv8NvVY3F7ds1rCYW/XU5NI9p
 /wIcf6bHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhdmdkOHhwgpPRGxFmQ1bd
 d5nnUxv9+8Ik51VNu1QbvuZK5BauPIb/Li3vnmidtozRmNWinMI4R2Xfzob20M6nZaZ9jFPX/fN
 hAwA=
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

But the idmappings might not always be resolvablein the caller's user
namespace. For example:

    unshare --user --map-root

In this case statmount() will indicate the failure to resolve the idmappings
in the caller's user namespace by listing 4294967295 aka (uid_t) -1 as
the target of the mapping while still showing the source and range of
the mapping:

    mnt_id:        2147485087
    mnt_parent_id: 2147484016
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
    mnt_uidmap[0]: 0 4294967295 1000
    mnt_uidmap[1]: 2000 4294967295 1
    mnt_uidmap[2]: 3000 4294967295 1
    mnt_gidmap[0]: 0 4294967295 1000
    mnt_gidmap[1]: 2000 4294967295 1
    mnt_gidmap[2]: 3000 4294967295 1

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
 fs/internal.h              |  1 +
 fs/mnt_idmapping.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c             | 43 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  8 +++++++-
 4 files changed, 99 insertions(+), 2 deletions(-)

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
index 7b1df8cc2821..4aca8e3ba97e 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -6,6 +6,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
 #include <linux/user_namespace.h>
+#include <linux/seq_file.h>
 
 #include "internal.h"
 
@@ -334,3 +335,51 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		free_mnt_idmap(idmap);
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_put);
+
+int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map)
+{
+	struct uid_gid_map *map, *map_up;
+
+	if (idmap == &nop_mnt_idmap || idmap == &invalid_mnt_idmap)
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
+	for (u32 idx = 0; idx < map->nr_extents; idx++) {
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
+		 * resolved 1/4294967295 will be shown as the target of
+		 * the mapping. The source and range are shown as a hint
+		 * to the caller.
+		 */
+		lower = map_id_range_up(map_up, extent->lower_first, extent->count);
+		if (lower == (uid_t) -1)
+			seq_printf(seq, "%u %u %u", extent->first, -1, extent->count);
+		else
+			seq_printf(seq, "%u %u %u", extent->first, lower, extent->count);
+		seq->count++; /* mappings are separated by \0 */
+		if (seq_has_overflowed(seq))
+			return -EAGAIN;
+	}
+
+	return map->nr_extents;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 4013fbac354a..535e4829061f 100644
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
@@ -5185,6 +5186,30 @@ static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
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
+	return 0;
+}
+
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
 	int ret = 0;
@@ -5226,6 +5251,14 @@ static int statmount_string(struct kstatmount *s, u64 flag)
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
@@ -5350,6 +5383,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 		return err;
 
 	s->root = root;
+	s->idmap = mnt_idmap(s->mnt);
 	if (s->mask & STATMOUNT_SB_BASIC)
 		statmount_sb_basic(s);
 
@@ -5383,6 +5417,12 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
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
 
@@ -5406,7 +5446,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
 			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
 			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
-			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
+			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY | \
+			      STATMOUNT_MNT_UIDMAP | STATMOUNT_MNT_GIDMAP)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
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


