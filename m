Return-Path: <linux-fsdevel+bounces-59220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D763B36B25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B2F1C27666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B935A2AC;
	Tue, 26 Aug 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yOiQu691"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A72BEC45;
	Tue, 26 Aug 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218229; cv=none; b=rwcQUlsmAkzGy+9bSbohIjzWl+/62gVT3jqtTdik+jB6/EX+ZSVDpCb/gSNb6CD61RXsxJ28x41T2B/rVxG1e93A4AYYiXuypxZd8SNSmplrUzDFcE2G8KPNGS8naRy71CpPq4OAwdvJYlYweCPvBm3CvwLDKmfQjx0sxbb8qnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218229; c=relaxed/simple;
	bh=wa+v2l0fKGLq36lzyqyo5nk+MHZnyDcewGmpz9FX1VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljLN9NV7NtVWutlhYTrFj1xFZVUNznSMBhfg+eaGWa7V8/kYYOaIbc/KzE6k1p+PU5JpXXfrsLLCcDEyRmBQMydGXy9E1JN0LsrMh6+bsBSvPdcE6wHizGWFFyIDHPaRaKgMkpHLJh1lGAVjxJP4h0hyue20+3JJ4HBi0Gi4wdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yOiQu691; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11773C113CF;
	Tue, 26 Aug 2025 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218229;
	bh=wa+v2l0fKGLq36lzyqyo5nk+MHZnyDcewGmpz9FX1VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yOiQu6913ScU5v3lwRFQ0Un0w9LnSMn13gJF/ci23P7GsgQYTyeUzPPZCvU0bnZmo
	 rf4XsJIwmxNbU/8iQYoJ8llehu9NZpAYSUIU/ccKX7wcwZoSTn9R3EysAVvLTdbyye
	 VM4ow2EZyIDCNwqbYsHrLzAXi3tkSvOZgo23wrgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Mattias Nissler <mnissler@chromium.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrei Vagin <avagin@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 402/523] move_mount: allow to add a mount into an existing group
Date: Tue, 26 Aug 2025 13:10:12 +0200
Message-ID: <20250826110934.374957988@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

[ Upstream commit 9ffb14ef61bab83fa818736bf3e7e6b6e182e8e2 ]

Previously a sharing group (shared and master ids pair) can be only
inherited when mount is created via bindmount. This patch adds an
ability to add an existing private mount into an existing sharing group.

With this functionality one can first create the desired mount tree from
only private mounts (without the need to care about undesired mount
propagation or mount creation order implied by sharing group
dependencies), and next then setup any desired mount sharing between
those mounts in tree as needed.

This allows CRIU to restore any set of mount namespaces, mount trees and
sharing group trees for a container.

We have many issues with restoring mounts in CRIU related to sharing
groups and propagation:
- reverse sharing groups vs mount tree order requires complex mounts
  reordering which mostly implies also using some temporary mounts
(please see https://lkml.org/lkml/2021/3/23/569 for more info)

- mount() syscall creates tons of mounts due to propagation
- mount re-parenting due to propagation
- "Mount Trap" due to propagation
- "Non Uniform" propagation, meaning that with different tricks with
  mount order and temporary children-"lock" mounts one can create mount
  trees which can't be restored without those tricks
(see https://www.linuxplumbersconf.org/event/7/contributions/640/)

With this new functionality we can resolve all the problems with
propagation at once.

Link: https://lore.kernel.org/r/20210715100714.120228-1-ptikhomirov@virtuozzo.com
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Mattias Nissler <mnissler@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Stable-dep-of: cffd0441872e ("use uniform permission checks for all mount propagation changes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c             | 77 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 +-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ee6d139f7529..7f7ccc9e53b8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2692,6 +2692,78 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
 	return ret;
 }
 
+static int do_set_group(struct path *from_path, struct path *to_path)
+{
+	struct mount *from, *to;
+	int err;
+
+	from = real_mount(from_path->mnt);
+	to = real_mount(to_path->mnt);
+
+	namespace_lock();
+
+	err = -EINVAL;
+	/* To and From must be mounted */
+	if (!is_mounted(&from->mnt))
+		goto out;
+	if (!is_mounted(&to->mnt))
+		goto out;
+
+	err = -EPERM;
+	/* We should be allowed to modify mount namespaces of both mounts */
+	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		goto out;
+	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		goto out;
+
+	err = -EINVAL;
+	/* To and From paths should be mount roots */
+	if (from_path->dentry != from_path->mnt->mnt_root)
+		goto out;
+	if (to_path->dentry != to_path->mnt->mnt_root)
+		goto out;
+
+	/* Setting sharing groups is only allowed across same superblock */
+	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
+		goto out;
+
+	/* From mount root should be wider than To mount root */
+	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
+		goto out;
+
+	/* From mount should not have locked children in place of To's root */
+	if (has_locked_children(from, to->mnt.mnt_root))
+		goto out;
+
+	/* Setting sharing groups is only allowed on private mounts */
+	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
+		goto out;
+
+	/* From should not be private */
+	if (!IS_MNT_SHARED(from) && !IS_MNT_SLAVE(from))
+		goto out;
+
+	if (IS_MNT_SLAVE(from)) {
+		struct mount *m = from->mnt_master;
+
+		list_add(&to->mnt_slave, &m->mnt_slave_list);
+		to->mnt_master = m;
+	}
+
+	if (IS_MNT_SHARED(from)) {
+		to->mnt_group_id = from->mnt_group_id;
+		list_add(&to->mnt_share, &from->mnt_share);
+		lock_mount_hash();
+		set_mnt_shared(to);
+		unlock_mount_hash();
+	}
+
+	err = 0;
+out:
+	namespace_unlock();
+	return err;
+}
+
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
 	struct mnt_namespace *ns;
@@ -3667,7 +3739,10 @@ SYSCALL_DEFINE5(move_mount,
 	if (ret < 0)
 		goto out_to;
 
-	ret = do_move_mount(&from_path, &to_path);
+	if (flags & MOVE_MOUNT_SET_GROUP)
+		ret = do_set_group(&from_path, &to_path);
+	else
+		ret = do_move_mount(&from_path, &to_path);
 
 out_to:
 	path_put(&to_path);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index dd8306ea336c..fc6a2e63130b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -71,7 +71,8 @@
 #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
-#define MOVE_MOUNT__MASK		0x00000077
+#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
+#define MOVE_MOUNT__MASK		0x00000177
 
 /*
  * fsopen() flags.
-- 
2.50.1




