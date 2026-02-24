Return-Path: <linux-fsdevel+bounces-78211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APoQJ4zznGk5MQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6EA180482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 241E13030D82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F423815B;
	Tue, 24 Feb 2026 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMPsVPEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9BC1367
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893639; cv=none; b=BUsz+TVLvKpPNnYSwxmMv5eXt/cYDh1aVvnfYnuo1F5NxKK+JryKTb2tq1iPPuNfacTEyRGAWmNKii8Q7DuzTOPB2XL8poRrmCLridFZ7fnOYNdmX1LVJ0aItBMJv5c11WPuybQs8TDXnT4YXGNSPZNbu9KQIiRyDDndagXdVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893639; c=relaxed/simple;
	bh=WRsccR7OrXgoGozkKW6xou9i+8BRzxzIAn5WTRNPtq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9yRdMv4Vp9g4IOypiyR2i1eM+UKsmTjOo/kbfdqNa0meLa7MVTCeg9GE4b7pKtv28L+Yd3nhNryoZtvU5hUHz3Nqmy5g0ggo28B4ibd5fa8cr5+RKdbb6D1eE3sHHL0ZDmmy8R6V+vNdTjpADi0XuephycexDUatkdKXUCStwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMPsVPEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896E0C116C6;
	Tue, 24 Feb 2026 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771893639;
	bh=WRsccR7OrXgoGozkKW6xou9i+8BRzxzIAn5WTRNPtq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UMPsVPEkotzQ8JD2TdjdFHiBoGDhFHfLgcKXXf8T4fP7OKoY7RYfeKHQYN4vgh/fq
	 JdeJo4dHlv4vvy+j0IzJ2UJy3Oo6G5mpqWTwzEWOApnpba7WVhGPbdGii9sZy1KzuC
	 raJ9fe2WdnhRVPokOGuxtvANDq+WpIFVQDW0Nc2GOIr0iSahrxO6fkC6STF1iku+2R
	 Yx7U4QyG9x6+m8sZaSj78aWY3Xyvp0L+2LjeW222+bs0uFiT2HiLSMQruGzBRnBrGT
	 uwRRIsUbr6D8oX4Hp/V3dm4HqDNv0GxKCVI6HwXWYjsKoO55mgnHP1V4EBWMC0k2/D
	 JQmkq3+cGEMaA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Feb 2026 01:40:27 +0100
Subject: [PATCH RFC 2/3] move_mount: allow MOVE_MOUNT_BENEATH on the rootfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-work-mount-beneath-rootfs-v1-2-8c58bf08488f@kernel.org>
References: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
In-Reply-To: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WRsccR7OrXgoGozkKW6xou9i+8BRzxzIAn5WTRNPtq4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO+dxUd2Dfck7f8HOZu4KezChR6psepFJ5b7rNUp9Qv
 Yt3JY/XdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykeh4jw5nQGd8Fns7Wczq7
 r/X0W6Fy++NJVSl9eu8d/hxoPhfgMJHhn/nx17Iz7FgSJkxYe9S8acHU8/O3lC7YdkuQX+O2np3
 oEyYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78211-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mp.mp:url]
X-Rspamd-Queue-Id: 3B6EA180482
X-Rspamd-Action: no action

Allow MOVE_MOUNT_BENEATH to target the caller's rootfs. When the target
of a mount-beneath operation is the caller's root mount, verify that:

(1) The caller is located at the root of the mount, as enforced by
    path_mounted() in do_lock_mount().
(2) Propagation from the parent mount would not overmount the target,
    to avoid propagating beneath the rootfs of other mount namespaces.

The root-switching is decomposed into individually atomic, locally-scoped
steps: mount-beneath inserts the new root under the old one, chroot(".")
switches the caller's root, and umount2(".", MNT_DETACH) removes the old
root. Since each step only modifies the caller's own state, this avoids
cross-namespace vulnerabilities and inherent fork/unshare/setns races
that a chroot_fs_refs()-based approach would have.

Userspace can use the following workflow to switch roots:

    fd_tree = open_tree(-EBADF, "/newroot",
                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
    fchdir(fd_tree);
    move_mount(fd_tree, "", AT_FDCWD, "/",
               MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH);
    chroot(".");
    umount2(".", MNT_DETACH);

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cdde6c6a30ee..fe9136062614 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2725,7 +2725,7 @@ static inline struct mount *where_to_mount(const struct path *path,
  * In all cases the location must not have been unmounted and the
  * chosen mountpoint must be allowed to be mounted on.  For "beneath"
  * case we also require the location to be at the root of a mount
- * that has a parent (i.e. is not a root of some namespace).
+ * that has something mounted on top of it (i.e. has an overmount).
  */
 static void do_lock_mount(const struct path *path,
 			  struct pinned_mountpoint *res,
@@ -3523,8 +3523,6 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * @mnt_to:   mount under which to mount
  * @mp:   mountpoint of @mnt_to
  *
- * - Make sure that nothing can be mounted beneath the caller's current
- *   root or the rootfs of the namespace.
  * - Make sure that the caller can unmount the topmost mount ensuring
  *   that the caller could reveal the underlying mountpoint.
  * - Ensure that nothing has been mounted on top of @mnt_from before we
@@ -3538,7 +3536,7 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  */
 static int can_move_mount_beneath(const struct mount *mnt_from,
 				  const struct mount *mnt_to,
-				  const struct mountpoint *mp)
+				  struct pinned_mountpoint *mp)
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
 
@@ -3546,15 +3544,6 @@ static int can_move_mount_beneath(const struct mount *mnt_from,
 	if (mnt_from->overmount)
 		return -EINVAL;
 
-	/*
-	 * Mounting beneath the rootfs only makes sense when the
-	 * semantics of pivot_root(".", ".") are used.
-	 */
-	if (&mnt_to->mnt == current->fs->root.mnt)
-		return -EINVAL;
-	if (parent_mnt_to == current->nsproxy->mnt_ns->root)
-		return -EINVAL;
-
 	if (mount_is_ancestor(mnt_to, mnt_from))
 		return -EINVAL;
 
@@ -3564,7 +3553,7 @@ static int can_move_mount_beneath(const struct mount *mnt_from,
 	 * propagating a copy @c of @mnt_from on top of @mnt_to. This
 	 * defeats the whole purpose of mounting beneath another mount.
 	 */
-	if (propagation_would_overmount(parent_mnt_to, mnt_to, mp))
+	if (propagation_would_overmount(parent_mnt_to, mnt_to, mp->mp))
 		return -EINVAL;
 
 	/*
@@ -3580,7 +3569,7 @@ static int can_move_mount_beneath(const struct mount *mnt_from,
 	 * @mnt_from beneath @mnt_to.
 	 */
 	if (check_mnt(mnt_from) &&
-	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
+	    propagation_would_overmount(parent_mnt_to, mnt_from, mp->mp))
 		return -EINVAL;
 
 	return 0;
@@ -3689,7 +3678,7 @@ static int do_move_mount(const struct path *old_path,
 
 		if (mp.parent != over->mnt_parent)
 			over = mp.parent->overmount;
-		err = can_move_mount_beneath(old, over, mp.mp);
+		err = can_move_mount_beneath(old, over, &mp);
 		if (err)
 			return err;
 	}

-- 
2.47.3


