Return-Path: <linux-fsdevel+bounces-69911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10905C8B88C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9B4E4B45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3F33F8BB;
	Wed, 26 Nov 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yPL4pWf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6E3126BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184336; cv=none; b=XoFQW80pDXxAT7ZCGyCf+pIQ9eVvhLlN84Ehambb6hg83+9JdD4S5x/AWFowGDvpuoRoeI49tNGaZ82GrKwu2Qj62Sphfj7aDfDG+Q52vfE/BpzIxS00IuYVcEeUSlAPHDg40xPLO6ya7PCVvUgkQG0Cg9IOI3Hg/9p9vnY0Bzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184336; c=relaxed/simple;
	bh=MYPmJeeroH1wQfrkLQY++QSq2PrHtXpQnolG186cJ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqFa5KM8xpvHcuKFMCi8+GYL0DVOQO9D/odAGym17KR0ugww9sZqPxio3d5zjJM/GPLwDrU7VW7RtAMkic8Y+mqVdK6vbAf8RKwAtx/NrHvA98wD1Hqwey0SJGMpZa2gBJ/6UX6jq+z6LtSmQtZl/N+Aki8Pmnv9dlddmvdfcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yPL4pWf2; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dGq1c5qHBzHK8;
	Wed, 26 Nov 2025 20:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764184324;
	bh=VFG8VPI6FEZ/uZQxne4bvpIfCSnmW2ZvyjgWVbvOfaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPL4pWf2FEVgf9sgIkddOTyLzr4Hj+LxOuimRLC5BAJz/zrOD8kcTCyXaRgzEbGrO
	 T5o13AZy/ukdfbgKVF/1rnhHKVP/GhbbyB+bLWtOtgs0E4HM/A027Ebd6aYoCt34xi
	 5Bl1jv+ju5H808K+/haU7ofD36Y0Fed6R/5Rntxw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dGq1c1kXDzt22;
	Wed, 26 Nov 2025 20:12:04 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 1/4] landlock: Fix handling of disconnected directories
Date: Wed, 26 Nov 2025 20:11:54 +0100
Message-ID: <20251126191159.3530363-2-mic@digikod.net>
In-Reply-To: <20251126191159.3530363-1-mic@digikod.net>
References: <20251126191159.3530363-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Disconnected files or directories can appear when they are visible and
opened from a bind mount, but have been renamed or moved from the source
of the bind mount in a way that makes them inaccessible from the mount
point (i.e. out of scope).

Previously, access rights tied to files or directories opened through a
disconnected directory were collected by walking the related hierarchy
down to the root of the filesystem, without taking into account the
mount point because it couldn't be found. This could lead to
inconsistent access results, potential access right widening, and
hard-to-debug renames, especially since such paths cannot be printed.

For a sandboxed task to create a disconnected directory, it needs to
have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
the underlying source of the bind mount, and read access to the related
mount point.   Because a sandboxed task cannot acquire more access
rights than those defined by its Landlock domain, this could lead to
inconsistent access rights due to missing permissions that should be
inherited from the mount point hierarchy, while inheriting permissions
from the filesystem hierarchy hidden by this mount point instead.

Landlock now handles files and directories opened from disconnected
directories by taking into account the filesystem hierarchy when the
mount point is not found in the hierarchy walk, and also always taking
into account the mount point from which these disconnected directories
were opened.  This ensures that a rename is not allowed if it would
widen access rights [1].

The rationale is that, even if disconnected hierarchies might not be
visible or accessible to a sandboxed task, relying on the collected
access rights from them improves the guarantee that access rights will
not be widened during a rename because of the access right comparison
between the source and the destination (see LANDLOCK_ACCESS_FS_REFER).
It may look like this would grant more access on disconnected files and
directories, but the security policies are always enforced for all the
evaluated hierarchies.  This new behavior should be less surprising to
users and safer from an access control perspective.

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix the related comment.

Because opened files have their access rights stored in the related file
security properties, there is no impact for disconnected or unlinked
files.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
- Simplify the approach by checking both the filesystem hierarchy and
  the mount point hierarchy for disconnected directories.  Remove the
  related snapshot mechanism. See [1].
- Update erratum.
- Do not expose path_connected() anymore, and remove related Acked-by.

Changes since v2:
- Fix domain check mode reset, spotted by Tingmao.  Replace a
  conditional branch (when all accesses are granted) by only looking for
  a rule when needed.  This simplifies code and remove a call to
  path_connected().  Add a new is_dom_check_bkp to safely handle race
  conditions and move initial backup for layer_masks_parent1.
- Fix layer masks parent backup initialization, spotted by Tingmao.
- Add more comments, suggested by Tingmao.
- Reformat erratum.

Changes since v1:
- Remove useless else branch in is_access_to_paths_allowed().
- Update commit message and squash "landlock: Remove warning in
  collect_domain_accesses()":
  https://lore.kernel.org/r/20250618134734.1673254-1-mic@digikod.net
- Remove "extern" for path_connected() in fs.h, requested by Christian.
- Add Acked-by Christian.
- Fix docstring and improve doc for collect_domain_accesses().
- Remove path_connected() check for the real root.
- Fix allowed_parent* resets to be consistent with their initial values
  infered from the evaluated domain.
- Add Landlock erratum.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
- Simplify the approach by checking both the filesystem hierarchy and
  the mount point hierarchy for disconnected directories.  Remove the
  related snapshot mechanism. See [1].
- Do not expose path_connected() anymore.

Changes since v2:
- Fix domain check mode reset, spotted by Tingmao.  Replace a
  conditional branch (when all accesses are granted) by only looking for
  a rule when needed.  This simplifies code and remove a call to
  path_connected().  Add a new is_dom_check_bkp to safely handle race
  conditions and move initial backup for layer_masks_parent1.
- Fix layer masks parent backup initialization, spotted by Tingmao.
- Add more comments, suggested by Tingmao.
- Reformat erratum.

Changes since v1:
- Remove useless else branch in is_access_to_paths_allowed().
- Update commit message and squash "landlock: Remove warning in
  collect_domain_accesses()":
  https://lore.kernel.org/r/20250618134734.1673254-1-mic@digikod.net
- Remove "extern" for path_connected() in fs.h, requested by Christian.
- Add Acked-by Christian.
- Fix docstring and improve doc for collect_domain_accesses().
- Remove path_connected() check for the real root.
- Fix allowed_parent* resets to be consistent with their initial values
  infered from the evaluated domain.
- Add Landlock erratum.
---
 security/landlock/errata/abi-1.h | 16 +++++++++++++
 security/landlock/fs.c           | 40 ++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 12 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
new file mode 100644
index 000000000000..e8a2bff2e5b6
--- /dev/null
+++ b/security/landlock/errata/abi-1.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_3
+ *
+ * Erratum 3: Disconnected directory handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue with disconnected directories that occur when a
+ * directory is moved outside the scope of a bind mount.  The change ensures
+ * that evaluated access rights include both those from the disconnected file
+ * hierarchy down to its filesystem root and those from the related mount point
+ * hierarchy.  This prevents access right widening through rename or link
+ * actions.
+ */
+LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d9c12b993fa7..26d5c274a4c9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -909,21 +909,31 @@ static bool is_access_to_paths_allowed(
 				break;
 			}
 		}
+
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
-			 */
-			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
+				/*
+				 * Stops and allows access when reaching disconnected root
+				 * directories that are part of internal filesystems (e.g. nsfs,
+				 * which is reachable through /proc/<pid>/ns/<namespace>).
+				 */
 				allowed_parent1 = true;
 				allowed_parent2 = true;
+				break;
 			}
-			break;
+
+			/*
+			 * We reached a disconnected root directory from a bind mount.
+			 * Let's continue the walk with the current mount root.
+			 */
+			dput(walker_path.dentry);
+			walker_path.dentry = walker_path.mnt->mnt_root;
+			dget(walker_path.dentry);
+		} else {
+			parent_dentry = dget_parent(walker_path.dentry);
+			dput(walker_path.dentry);
+			walker_path.dentry = parent_dentry;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
 
@@ -1021,6 +1031,9 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * file.  While walking from @dir to @mnt_root, we record all the domain's
  * allowed accesses in @layer_masks_dom.
  *
+ * Because of disconnected directories, this walk may not reach @mnt_dir.  In
+ * this case, the walk will continue to @mnt_dir after this call.
+ *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
  * accesses.
@@ -1062,8 +1075,11 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/*
+		 * Stops at the mount point or the filesystem root for a disconnected
+		 * directory.
+		 */
+		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
 			break;
 
 		parent_dentry = dget_parent(dir);
-- 
2.51.0


