Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA94A84F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350730AbiBCNOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiBCNOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C07BC061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 05:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE4C26181B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA1C340EB;
        Thu,  3 Feb 2022 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894093;
        bh=ZYDZdJq9E6TdeKXjWJmi2UIy460h1uKegq7T5Lp78H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsthdNfdd+S71cKA4lOGT0eoqvqmGr+IoRAcWOLu+7CRggD34qEuLd0PenjoGhzTn
         uafH045jkx8Up4unH6OuCksfbWjJmttkFykMQ2AiIOToI+ekxusZ+y2CvFJDE4CNic
         FktuLnUt9KbUom5VXbXAschKqj67G18g1mz4Fi9h/QCcsDL8IVtgctW7mmmw5M+jxi
         NOwP96Moed23KTmGcuxTtjwoLzOjjzdDJKsTAvI/vcBGj5dgYt56ePzbBJA+N/GZO5
         pZSDhgOTgzUQiKfz7iiuATvh1IBGnvdWMGi8U1GXYv9+SkLGrtdt/oI3lrHAjJePSr
         psuapZRYiRxHw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 7/7] fs: clean up mount_setattr control flow
Date:   Thu,  3 Feb 2022 14:14:11 +0100
Message-Id: <20220203131411.3093040-8-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5232; h=from:subject; bh=ZYDZdJq9E6TdeKXjWJmi2UIy460h1uKegq7T5Lp78H0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsr8OXcuw+2cP0aBOXcTwnZ8Zc/eq546w/7+7+m6QWHz mPROdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8SQjw/Styszf1kU8ftm4N+W70H RxT5ft7Wu2Z6x/tJCB60vNsgWMDN+/txaJRzzhmNuisSI52XPuPKaHpht+2X+7vuPZG8fP7awA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify the control flow of mount_setattr_{prepare,commit} so they
became easiert to follow. We kept using both an integer error variable
that was passed by pointer as well as a pointer as an indicator for
whether or not we need to revert or commit the prepared changes.
Simplify this and just use the pointer. If we successfully changed
properties the revert pointer will be NULL and if we failed to change
properties it will indicate where we failed and thus need to stop
reverting.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 00762f9a736a..0e342e2ade83 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -82,6 +82,7 @@ struct mount_kattr {
 	unsigned int lookup_flags;
 	bool recurse;
 	struct user_namespace *mnt_userns;
+	struct mount *revert;
 };
 
 /* /sys/fs */
@@ -4011,46 +4012,34 @@ static inline bool mnt_allow_writers(const struct mount_kattr *kattr,
 	       (mnt->mnt.mnt_flags & MNT_READONLY);
 }
 
-static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
-					   struct mount *mnt, int *err)
+static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 {
-	struct mount *m = mnt, *last = NULL;
-
-	if (!is_mounted(&m->mnt)) {
-		*err = -EINVAL;
-		goto out;
-	}
-
-	if (!(mnt_has_parent(m) ? check_mnt(m) : is_anon_ns(m->mnt_ns))) {
-		*err = -EINVAL;
-		goto out;
-	}
+	struct mount *m = mnt;
 
 	do {
+		int err = -EPERM;
 		unsigned int flags;
 
-		flags = recalc_flags(kattr, m);
-		if (!can_change_locked_flags(m, flags)) {
-			*err = -EPERM;
-			goto out;
-		}
+		kattr->revert = m;
 
-		*err = can_idmap_mount(kattr, m);
-		if (*err)
-			goto out;
+		flags = recalc_flags(kattr, m);
+		if (!can_change_locked_flags(m, flags))
+			return err;
 
-		last = m;
+		err = can_idmap_mount(kattr, m);
+		if (err)
+			return err;
 
 		if (mnt_allow_writers(kattr, m))
 			continue;
 
-		*err = mnt_hold_writers(m);
-		if (*err)
-			goto out;
+		err = mnt_hold_writers(m);
+		if (err)
+			return err;
 	} while (kattr->recurse && (m = next_mnt(m, mnt)));
 
-out:
-	return last;
+	kattr->revert = NULL;
+	return 0;
 }
 
 static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
@@ -4078,14 +4067,12 @@ static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 		put_user_ns(old_mnt_userns);
 }
 
-static void mount_setattr_commit(struct mount_kattr *kattr,
-				 struct mount *mnt, struct mount *last,
-				 int err)
+static void mount_setattr_finish(struct mount_kattr *kattr, struct mount *mnt)
 {
 	struct mount *m = mnt;
 
 	do {
-		if (!err) {
+		if (!kattr->revert) {
 			unsigned int flags;
 
 			do_idmap_mount(kattr, m);
@@ -4097,24 +4084,24 @@ static void mount_setattr_commit(struct mount_kattr *kattr,
 		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
 			mnt_unhold_writers(m);
 
-		if (!err && kattr->propagation)
+		if (!kattr->revert && kattr->propagation)
 			change_mnt_propagation(m, kattr->propagation);
 
 		/*
 		 * On failure, only cleanup until we found the first mount
 		 * we failed to handle.
 		 */
-		if (err && m == last)
-			break;
+		if (kattr->revert == m)
+			return;
 	} while (kattr->recurse && (m = next_mnt(m, mnt)));
 
-	if (!err)
+	if (!kattr->revert)
 		touch_mnt_namespace(mnt->mnt_ns);
 }
 
 static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 {
-	struct mount *mnt = real_mount(path->mnt), *last = NULL;
+	struct mount *mnt = real_mount(path->mnt);
 	int err = 0;
 
 	if (path->dentry != mnt->mnt.mnt_root)
@@ -4135,16 +4122,31 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 		}
 	}
 
+	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Ensure that this isn't anything purely vfs internal. */
+	if (!is_mounted(&mnt->mnt))
+		goto out;
+
 	/*
-	 * Get the mount tree in a shape where we can change mount
-	 * properties without failure.
+	 * If this is an attached mount make sure it's located in the callers
+	 * mount namespace. If it's not don't let the caller interact with it.
+	 * If this is a detached mount make sure it has an anonymous mount
+	 * namespace attached to it, i.e. we've created it via OPEN_TREE_CLONE.
 	 */
-	last = mount_setattr_prepare(kattr, mnt, &err);
-	if (last) /* Commit all changes or revert to the old state. */
-		mount_setattr_commit(kattr, mnt, last, err);
+	if (!(mnt_has_parent(mnt) ? check_mnt(mnt) : is_anon_ns(mnt->mnt_ns)))
+		goto out;
 
+	/*
+	 * First, we get the mount tree in a shape where we can change mount
+	 * properties without failure. If we succeeded to do so we commit all
+	 * changes and if we failed we clean up.
+	 */
+	err = mount_setattr_prepare(kattr, mnt);
+	mount_setattr_finish(kattr, mnt);
+
+out:
 	unlock_mount_hash();
 
 	if (kattr->propagation) {
-- 
2.32.0

