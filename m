Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB1162877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBROgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:36:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53031 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgBROfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:35:39 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43xt-0000fF-2o; Tue, 18 Feb 2020 14:35:09 +0000
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
Subject: [PATCH v3 05/25] user_namespace: refactor map_write()
Date:   Tue, 18 Feb 2020 15:33:51 +0100
Message-Id: <20200218143411.2389182-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor map_write() to prepare for adding fsid mappings support. This mainly
factors out various open-coded parts into helpers that can be reused in the
follow up patch.

Cc: Jann Horn <jannh@google.com>
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
 kernel/user_namespace.c | 117 +++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 43 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 2cfd1e519cc4..e91141262bcc 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1038,10 +1038,10 @@ static int cmp_extents_reverse(const void *a, const void *b)
 }
 
 /**
- * sort_idmaps - Sorts an array of idmap entries.
+ * sort_map - Sorts an array of idmap entries.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
-static int sort_idmaps(struct uid_gid_map *map)
+static int sort_map(struct uid_gid_map *map)
 {
 	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
 		return 0;
@@ -1064,6 +1064,71 @@ static int sort_idmaps(struct uid_gid_map *map)
 	return 0;
 }
 
+static int sort_idmaps(struct uid_gid_map *map)
+{
+	return sort_map(map);
+}
+
+static int map_from_parent(struct uid_gid_map *new_map,
+			   struct uid_gid_map *parent_map)
+{
+	unsigned idx;
+
+	/* Map the lower ids from the parent user namespace to the
+	 * kernel global id space.
+	 */
+	for (idx = 0; idx < new_map->nr_extents; idx++) {
+		struct uid_gid_extent *e;
+		u32 lower_first;
+
+		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			e = &new_map->extent[idx];
+		else
+			e = &new_map->forward[idx];
+
+		lower_first = map_id_range_down(parent_map, e->lower_first, e->count);
+
+		/* Fail if we can not map the specified extent to
+		 * the kernel global id space.
+		 */
+		if (lower_first == (u32)-1)
+			return -EPERM;
+
+		e->lower_first = lower_first;
+	}
+
+	return 0;
+}
+
+static int map_into_kids(struct uid_gid_map *id_map,
+			 struct uid_gid_map *parent_id_map)
+{
+	return map_from_parent(id_map, parent_id_map);
+}
+
+static void install_idmaps(struct uid_gid_map *id_map,
+			   struct uid_gid_map *new_id_map)
+{
+	if (new_id_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
+		memcpy(id_map->extent, new_id_map->extent,
+		       new_id_map->nr_extents * sizeof(new_id_map->extent[0]));
+	} else {
+		id_map->forward = new_id_map->forward;
+		id_map->reverse = new_id_map->reverse;
+	}
+}
+
+static void free_idmaps(struct uid_gid_map *new_id_map)
+{
+	if (new_id_map->nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
+		kfree(new_id_map->forward);
+		kfree(new_id_map->reverse);
+		new_id_map->forward = NULL;
+		new_id_map->reverse = NULL;
+		new_id_map->nr_extents = 0;
+	}
+}
+
 static ssize_t map_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos,
 			 int cap_setid,
@@ -1073,7 +1138,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	struct seq_file *seq = file->private_data;
 	struct user_namespace *ns = seq->private;
 	struct uid_gid_map new_map;
-	unsigned idx;
 	struct uid_gid_extent extent;
 	char *kbuf = NULL, *pos, *next_line;
 	ssize_t ret;
@@ -1191,61 +1255,28 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
 		goto out;
 
-	ret = -EPERM;
-	/* Map the lower ids from the parent user namespace to the
-	 * kernel global id space.
-	 */
-	for (idx = 0; idx < new_map.nr_extents; idx++) {
-		struct uid_gid_extent *e;
-		u32 lower_first;
-
-		if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-			e = &new_map.extent[idx];
-		else
-			e = &new_map.forward[idx];
-
-		lower_first = map_id_range_down(parent_map,
-						e->lower_first,
-						e->count);
-
-		/* Fail if we can not map the specified extent to
-		 * the kernel global id space.
-		 */
-		if (lower_first == (u32) -1)
-			goto out;
-
-		e->lower_first = lower_first;
-	}
+	ret = map_into_kids(&new_map, parent_map);
+	if (ret)
+		goto out;
 
 	/*
 	 * If we want to use binary search for lookup, this clones the extent
 	 * array and sorts both copies.
 	 */
 	ret = sort_idmaps(&new_map);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	/* Install the map */
-	if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
-		memcpy(map->extent, new_map.extent,
-		       new_map.nr_extents * sizeof(new_map.extent[0]));
-	} else {
-		map->forward = new_map.forward;
-		map->reverse = new_map.reverse;
-	}
+	install_idmaps(map, &new_map);
 	smp_wmb();
 	map->nr_extents = new_map.nr_extents;
 
 	*ppos = count;
 	ret = count;
 out:
-	if (ret < 0 && new_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
-		kfree(new_map.forward);
-		kfree(new_map.reverse);
-		map->forward = NULL;
-		map->reverse = NULL;
-		map->nr_extents = 0;
-	}
+	if (ret < 0)
+		free_idmaps(&new_map);
 
 	mutex_unlock(&userns_state_mutex);
 	kfree(kbuf);
-- 
2.25.0

