Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC1162869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBROgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:36:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBROfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:35:40 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43xu-0000fF-4M; Tue, 18 Feb 2020 14:35:10 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 06/25] user_namespace: make map_write() support fsid mappings
Date:   Tue, 18 Feb 2020 15:33:52 +0100
Message-Id: <20200218143411.2389182-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Based on discussions with Jann we decided in order to cleanly handle nested
user namespaces that fsid mappings can only be written before the corresponding
id mappings have been written. Writing id mappings before writing the
corresponding fsid mappings causes fsid mappings to mirror id mappings.

Consider creating a user namespace NS1 with the initial user namespace as
parent. Assume NS1 receives id mapping 0 100000 100000 and fsid mappings 0
300000 100000. Files that root in NS1 will create will map to kfsuid=300000 and
kfsgid=300000 and will hence be owned by uid=300000 and gid 300000 on-disk in
the initial user namespace.
Now assume user namespace NS2 is created in user namespace NS1. Assume that NS2
receives id mapping 0 10000 65536 and an fsid mapping of 0 10000 65536. Files
that root in NS2 will create will map to kfsuid=10000 and kfsgid=10000 in NS1.
hence, files created by NS2 will hence be appear to be be owned by uid=10000
and gid=10000 on-disk in NS1. Looking at the initial user namespace, files
created by NS2 will map to kfsuid=310000 and kfsgid=310000 and hence will be
owned by uid=310000 and gid=310000 on-disk.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch added
- Jann Horn <jannh@google.com>:
  - Split changes to map_write() to implement fsid mappings into three separate
    patches: basic fsid helpers, preparatory changes to map_write(), actual
    fsid mapping support in map_write().
---
 kernel/user_namespace.c | 165 ++++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 22 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index e91141262bcc..7905ca19dfab 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -25,9 +25,18 @@
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
 
+enum idmap_type {
+	UID_MAP,
+	GID_MAP,
+	FSUID_MAP,
+	FSGID_MAP,
+	PROJID_MAP,
+};
+
 static bool new_idmap_permitted(const struct file *file,
 				struct user_namespace *ns, int cap_setid,
-				struct uid_gid_map *map);
+				struct uid_gid_map *map,
+				enum idmap_type idmap_type);
 static void free_user_ns(struct work_struct *work);
 
 static struct ucounts *inc_user_namespaces(struct user_namespace *ns, kuid_t uid)
@@ -913,6 +922,16 @@ const struct seq_operations proc_projid_seq_operations = {
 	.show = projid_m_show,
 };
 
+static inline bool idmap_exists(const struct uid_gid_map *map)
+{
+	return map && map->nr_extents != 0;
+}
+
+static inline bool idmap_type_wants_fsidmap(enum idmap_type type)
+{
+	return type == UID_MAP || type == GID_MAP;
+}
+
 #ifdef CONFIG_USER_NS_FSID
 const struct seq_operations proc_fsuid_seq_operations = {
 	.start = fsuid_m_start,
@@ -927,6 +946,31 @@ const struct seq_operations proc_fsgid_seq_operations = {
 	.next = m_next,
 	.show = fsgid_m_show,
 };
+
+static int idmap_to_fsidmap(struct uid_gid_map *id_map,
+			    struct uid_gid_map *fsid_map,
+			    struct uid_gid_map *new_fsid_map,
+			    enum idmap_type type)
+{
+	if (!idmap_type_wants_fsidmap(type) || idmap_exists(fsid_map))
+		return 0;
+
+	/* fsid maps mirror id maps. */
+	if (id_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
+		memcpy(new_fsid_map, id_map, sizeof(struct uid_gid_map));
+		return 0;
+	}
+
+	memset(new_fsid_map, 0, sizeof(struct uid_gid_map));
+	new_fsid_map->forward = kmemdup(id_map->forward,
+			id_map->nr_extents * sizeof(struct uid_gid_extent),
+			GFP_KERNEL);
+	if (!new_fsid_map->forward)
+		return -ENOMEM;
+	new_fsid_map->nr_extents = id_map->nr_extents;
+
+	return 0;
+}
 #endif
 
 static bool mappings_overlap(struct uid_gid_map *new_map,
@@ -1064,9 +1108,17 @@ static int sort_map(struct uid_gid_map *map)
 	return 0;
 }
 
-static int sort_idmaps(struct uid_gid_map *map)
+static int sort_idmaps(struct uid_gid_map *map,
+		       struct uid_gid_map *new_fsid_map)
 {
-	return sort_map(map);
+	int ret;
+
+	ret = sort_map(map);
+	if (ret)
+		return ret;
+
+	/* Sort fsid maps in case they mirror id maps. */
+	return sort_map(new_fsid_map);
 }
 
 static int map_from_parent(struct uid_gid_map *new_map,
@@ -1101,13 +1153,31 @@ static int map_from_parent(struct uid_gid_map *new_map,
 }
 
 static int map_into_kids(struct uid_gid_map *id_map,
-			 struct uid_gid_map *parent_id_map)
+			 struct uid_gid_map *parent_id_map,
+			 struct user_namespace *ns,
+			 struct uid_gid_map *new_fsid_map, enum idmap_type type)
 {
-	return map_from_parent(id_map, parent_id_map);
+	int ret;
+
+	ret = map_from_parent(id_map, parent_id_map);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_USER_NS_FSID
+	/* fsid maps mirror id maps. */
+	if (idmap_type_wants_fsidmap(type) && idmap_exists(new_fsid_map))
+		ret = map_from_parent(new_fsid_map,
+				      type == UID_MAP ? &ns->parent->fsuid_map :
+							&ns->parent->fsgid_map);
+#endif
+	return ret;
 }
 
 static void install_idmaps(struct uid_gid_map *id_map,
-			   struct uid_gid_map *new_id_map)
+			   struct uid_gid_map *new_id_map,
+			   struct uid_gid_map *fsid_map,
+			   struct uid_gid_map *new_fsid_map,
+			   enum idmap_type type)
 {
 	if (new_id_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
 		memcpy(id_map->extent, new_id_map->extent,
@@ -1116,9 +1186,21 @@ static void install_idmaps(struct uid_gid_map *id_map,
 		id_map->forward = new_id_map->forward;
 		id_map->reverse = new_id_map->reverse;
 	}
+
+	if (idmap_type_wants_fsidmap(type) && idmap_exists(new_fsid_map)) {
+		/* fsid maps mirror id maps. */
+		if (new_fsid_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
+			memcpy(fsid_map->extent, new_fsid_map->extent,
+			       new_fsid_map->nr_extents * sizeof(new_fsid_map->extent[0]));
+		} else {
+			fsid_map->forward = new_fsid_map->forward;
+			fsid_map->reverse = new_fsid_map->reverse;
+		}
+	}
 }
 
-static void free_idmaps(struct uid_gid_map *new_id_map)
+static void free_idmaps(struct uid_gid_map *new_id_map,
+			struct uid_gid_map *new_fsid_map)
 {
 	if (new_id_map->nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
 		kfree(new_id_map->forward);
@@ -1127,17 +1209,28 @@ static void free_idmaps(struct uid_gid_map *new_id_map)
 		new_id_map->reverse = NULL;
 		new_id_map->nr_extents = 0;
 	}
+
+	/* fsid maps mirror id maps. */
+	if (new_fsid_map->nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+		kfree(new_fsid_map->forward);
+		kfree(new_fsid_map->reverse);
+		new_fsid_map->forward = NULL;
+		new_fsid_map->reverse = NULL;
+		new_fsid_map->nr_extents = 0;
+	}
 }
 
 static ssize_t map_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos,
 			 int cap_setid,
 			 struct uid_gid_map *map,
-			 struct uid_gid_map *parent_map)
+			 struct uid_gid_map *parent_map,
+			 enum idmap_type type)
 {
 	struct seq_file *seq = file->private_data;
 	struct user_namespace *ns = seq->private;
-	struct uid_gid_map new_map;
+	struct uid_gid_map *fsid_map = NULL;
+	struct uid_gid_map new_map, new_fsid_map;
 	struct uid_gid_extent extent;
 	char *kbuf = NULL, *pos, *next_line;
 	ssize_t ret;
@@ -1173,6 +1266,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	mutex_lock(&userns_state_mutex);
 
 	memset(&new_map, 0, sizeof(struct uid_gid_map));
+	new_fsid_map.nr_extents = 0;
 
 	ret = -EPERM;
 	/* Only allow one successful write to the map */
@@ -1252,10 +1346,21 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 
 	ret = -EPERM;
 	/* Validate the user is allowed to use user id's mapped to. */
-	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
+	if (!new_idmap_permitted(file, ns, cap_setid, &new_map, type))
+		goto out;
+
+#ifdef CONFIG_USER_NS_FSID
+	/* Take pointer to fsid maps in case we're mirroring id maps. */
+	if (type == UID_MAP)
+		fsid_map = &ns->fsuid_map;
+	else if (type == GID_MAP)
+		fsid_map = &ns->fsgid_map;
+	ret = idmap_to_fsidmap(&new_map, fsid_map, &new_fsid_map, type);
+	if (ret)
 		goto out;
+#endif
 
-	ret = map_into_kids(&new_map, parent_map);
+	ret = map_into_kids(&new_map, parent_map, ns, &new_fsid_map, type);
 	if (ret)
 		goto out;
 
@@ -1263,20 +1368,22 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	 * If we want to use binary search for lookup, this clones the extent
 	 * array and sorts both copies.
 	 */
-	ret = sort_idmaps(&new_map);
+	ret = sort_idmaps(&new_map, &new_fsid_map);
 	if (ret)
 		goto out;
 
 	/* Install the map */
-	install_idmaps(map, &new_map);
+	install_idmaps(map, &new_map, fsid_map, &new_fsid_map, type);
 	smp_wmb();
 	map->nr_extents = new_map.nr_extents;
+	if (idmap_exists(&new_fsid_map))
+		fsid_map->nr_extents = new_fsid_map.nr_extents;
 
 	*ppos = count;
 	ret = count;
 out:
 	if (ret < 0)
-		free_idmaps(&new_map);
+		free_idmaps(&new_map, &new_fsid_map);
 
 	mutex_unlock(&userns_state_mutex);
 	kfree(kbuf);
@@ -1297,7 +1404,7 @@ ssize_t proc_uid_map_write(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	return map_write(file, buf, size, ppos, CAP_SETUID,
-			 &ns->uid_map, &ns->parent->uid_map);
+			 &ns->uid_map, &ns->parent->uid_map, UID_MAP);
 }
 
 ssize_t proc_gid_map_write(struct file *file, const char __user *buf,
@@ -1314,7 +1421,7 @@ ssize_t proc_gid_map_write(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	return map_write(file, buf, size, ppos, CAP_SETGID,
-			 &ns->gid_map, &ns->parent->gid_map);
+			 &ns->gid_map, &ns->parent->gid_map, GID_MAP);
 }
 
 ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
@@ -1332,7 +1439,7 @@ ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
 
 	/* Anyone can set any valid project id no capability needed */
 	return map_write(file, buf, size, ppos, -1,
-			 &ns->projid_map, &ns->parent->projid_map);
+			 &ns->projid_map, &ns->parent->projid_map, PROJID_MAP);
 }
 
 #ifdef CONFIG_USER_NS_FSID
@@ -1350,7 +1457,7 @@ ssize_t proc_fsuid_map_write(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	return map_write(file, buf, size, ppos, CAP_SETUID, &ns->fsuid_map,
-			 &ns->parent->fsuid_map);
+			 &ns->parent->fsuid_map, FSUID_MAP);
 }
 
 ssize_t proc_fsgid_map_write(struct file *file, const char __user *buf,
@@ -1367,15 +1474,25 @@ ssize_t proc_fsgid_map_write(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	return map_write(file, buf, size, ppos, CAP_SETGID, &ns->fsgid_map,
-			 &ns->parent->fsgid_map);
+			 &ns->parent->fsgid_map, FSGID_MAP);
 }
 #endif
 
 static bool new_idmap_permitted(const struct file *file,
 				struct user_namespace *ns, int cap_setid,
-				struct uid_gid_map *new_map)
+				struct uid_gid_map *new_map,
+				enum idmap_type idmap_type)
 {
 	const struct cred *cred = file->f_cred;
+
+	/* Don't allow writing fsuid maps when uid maps have been written. */
+	if (idmap_type == FSUID_MAP && idmap_exists(&ns->uid_map))
+		return false;
+
+	/* Don't allow writing fsgid maps when gid maps have been written. */
+	if (idmap_type == FSGID_MAP && idmap_exists(&ns->gid_map))
+		return false;
+
 	/* Don't allow mappings that would allow anything that wouldn't
 	 * be allowed without the establishment of unprivileged mappings.
 	 */
@@ -1383,11 +1500,15 @@ static bool new_idmap_permitted(const struct file *file,
 	    uid_eq(ns->owner, cred->euid)) {
 		u32 id = new_map->extent[0].lower_first;
 		if (cap_setid == CAP_SETUID) {
-			kuid_t uid = make_kuid(ns->parent, id);
+			kuid_t uid = idmap_type == FSUID_MAP ?
+					     make_kfsuid(ns->parent, id) :
+					     make_kuid(ns->parent, id);
 			if (uid_eq(uid, cred->euid))
 				return true;
 		} else if (cap_setid == CAP_SETGID) {
-			kgid_t gid = make_kgid(ns->parent, id);
+			kgid_t gid = idmap_type == FSGID_MAP ?
+					     make_kfsgid(ns->parent, id) :
+					     make_kgid(ns->parent, id);
 			if (!(ns->flags & USERNS_SETGROUPS_ALLOWED) &&
 			    gid_eq(gid, cred->egid))
 				return true;
-- 
2.25.0

