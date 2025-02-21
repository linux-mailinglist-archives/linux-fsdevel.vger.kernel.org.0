Return-Path: <linux-fsdevel+bounces-42231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13FA3F59C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EBC861B77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19820FAAC;
	Fri, 21 Feb 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVz9Ysuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CD20B812
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143626; cv=none; b=GjuNDhwUXHIIKUIlyGj6X9i3No54kl6df13tctyYW2ayu7kMNHKItdRk8HUBusfuJlaG1unh6OArmUQ2R5Miet/PBt0/EE8v5pPXElUPQyHzmGz46510uU5b5FeCieNa0n6amItLLlmRCu9x3+0eG5KJ8WBx9ntsQD2w8dn3AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143626; c=relaxed/simple;
	bh=fEWBF8PBCKozsKh88Dl8//ir62QTcHuXpifaV5Nu19c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+onIWDfwuft44mEY/zDB3xHJQ004DubIdts/ATLXtJOSWqrcrHziyhdq+4pMVaYQ9X3B1sy5WkUri8BnML2OFvICf3qymfxjzOHGyqHjZLu+FUReA4Ds8GarnYTM5yKo4R4jt9pxPN7p1uHuUclzrBvSUYQ5uyYX+J0OWORcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVz9Ysuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3EBC4CEE4;
	Fri, 21 Feb 2025 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143626;
	bh=fEWBF8PBCKozsKh88Dl8//ir62QTcHuXpifaV5Nu19c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FVz9YsuceClZyFp8iad1UJVKSN7bOU284dvNNwVWeffp278qeaCgqqHehIlcNHst0
	 x2RU7gjp2Ps9+34Lv7g84HW4ESr2DWCmOzGsSy3OjAoXr9y2IGzl8jM0Uf5tZjlNbq
	 lLDuy1u6IjdIVxam5lJcTHDnqRo9BCw0Cj+LaH8nHdbvcs6/rcrgU+2siJrPGhLD+e
	 s5kEbsMwmfCKSvO3oPsd4hFQDovxftGi5OqbfMbl751FV7CnQ7juc2jwMh5lSJfjOy
	 2HjkJ1yC9E7PQ+2zl8cBqn0HfEFEB8ZuGYs4t60pXs2nLWSuF5/1Y3ZR5VlAh5UWJ1
	 e8zHPjvZzwyHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:05 +0100
Subject: [PATCH RFC 06/16] fs: create detached mounts from detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-6-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5082; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fEWBF8PBCKozsKh88Dl8//ir62QTcHuXpifaV5Nu19c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP610XMT/4zokNXGsuumP9vz9Zhq/2ebrzOYsrs9X
 C753lL+2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR41RGhj6R6VmCsu1X21In
 ypywP9pbqL0s6X1YzHKvxkn8qUy5ngz/bHRnzlfc9lzwptKNU4+OMXJJsh3Pu1y24Nq8lLvV71b
 GMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the ability to create detached mounts from detached mounts.

Currently, detached mounts can only be created from attached mounts.
This limitaton prevents various use-cases. For example, the ability to
mount a subdirectory without ever having to make the whole filesystem
visible first.

The current permission model for the OPEN_TREE_CLONE flag of the
open_tree() system call is:

(1) Check that the caller is privileged over the owning user namespace
    of it's current mount namespace.

(2) Check that the caller is located in the mount namespace of the mount
    it wants to create a detached copy of.

While it is not strictly necessary to do it this way it is consistently
applied in the new mount api. This model will also be used when allowing
the creation of detached mount from another detached mount.

The (1) requirement can simply be met by performing the same check as
for the non-detached case, i.e., verify that the caller is privileged
over its current mount namespace.

To meet the (2) requirement it must be possible to infer the origin
mount namespace that the anonymous mount namespace of the detached mount
was created from.

The origin mount namespace of an anonymous mount is the mount namespace
that the mounts that were copied into the anonymous mount namespace
originate from.

The origin mount namespace of the anonymous mount namespace must be the
same as the caller's mount namespace. To establish this the sequence
number of the caller's mount namespace and the origin sequence number of
the anonymous mount namespace are compared.

The caller is always located in a non-anonymous mount namespace since
anonymous mount namespaces cannot be setns()ed into. The caller's mount
namespace will thus always have a valid sequence number.

The owning namespace of any mount namespace, anonymous or non-anonymous,
can never change. A mount attached to a non-anonymous mount namespace
can never change mount namespace.

If the sequence number of the non-anonymous mount namespace and the
origin sequence number of the anonymous mount namespace match, the
owning namespaces must match as well.

Hence, the capability check on the owning namespace of the caller's
mount namespace ensures that the caller has the ability to copy the
mount tree.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c61b9704499a..66b9cea1cf66 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -998,6 +998,12 @@ static inline int check_mnt(struct mount *mnt)
 	return mnt->mnt_ns == current->nsproxy->mnt_ns;
 }
 
+static inline bool check_anonymous_mnt(struct mount *mnt)
+{
+	return is_anon_ns(mnt->mnt_ns) &&
+	       mnt->mnt_ns->seq_origin == current->nsproxy->mnt_ns->seq;
+}
+
 /*
  * vfsmount lock must be held for write
  */
@@ -2822,6 +2828,32 @@ static int do_change_type(struct path *path, int ms_flags)
  *     namespace, i.e., the caller is trying to copy a mount namespace
  *     entry from nsfs.
  * (3) The caller tries to copy a pidfs mount referring to a pidfd.
+ * (4) The caller is trying to copy a mount tree that belongs to an
+ *     anonymous mount namespace.
+ *
+ *     For that to be safe, this helper enforces that the origin mount
+ *     namespace the anonymous mount namespace was created from is the
+ *     same as the caller's mount namespace by comparing the sequence
+ *     numbers.
+ *
+ *     This is not strictly necessary. The current semantics of the new
+ *     mount api enforce that the caller must be located in the same
+ *     mount namespace as the mount tree it interacts with. Using the
+ *     origin sequence number preserves these semantics even for
+ *     anonymous mount namespaces. However, one could envision extending
+ *     the api to directly operate across mount namespace if needed.
+ *
+ *     The ownership of a non-anonymous mount namespace such as the
+ *     caller's cannot change.
+ *     => We know that the caller's mount namespace is stable.
+ *
+ *     If the origin sequence number of the anonymous mount namespace is
+ *     the same as the sequence number of the caller's mount namespace.
+ *     => The owning namespaces are the same.
+ *
+ *     ==> The earlier capability check on the owning namespace of the
+ *         caller's mount namespace ensures that the caller has the
+ *         ability to copy the mount tree.
  *
  * Returns true if the mount tree can be copied, false otherwise.
  */
@@ -2840,9 +2872,13 @@ static inline bool may_copy_tree(struct path *path)
 	if (d_op == &pidfs_dentry_operations)
 		return true;
 
-	return false;
+	if (!is_mounted(path->mnt))
+		return false;
+
+	return check_anonymous_mnt(mnt);
 }
 
+
 static struct mount *__do_loopback(struct path *old_path, int recurse)
 {
 	struct mount *mnt = ERR_PTR(-EINVAL), *old = real_mount(old_path->mnt);

-- 
2.47.2


