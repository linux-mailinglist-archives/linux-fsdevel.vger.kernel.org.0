Return-Path: <linux-fsdevel+bounces-72179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A409CE6D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0372B300F5A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC127288520;
	Mon, 29 Dec 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQq0crpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494681DF759
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013419; cv=none; b=WnxiqcGmBVa9f0pvkYHw2FvZYOpfAYkQGlvfg7cULQFws/NrOQ6Xd2BKez/3DrAb/TYF0ZxiU1WJrNsPp2U4oU0d2ceyiu+QmaqRY9fwWn2qSyG+eszbtRcfEkx7lUqWg2sgO2KPAgI8WFUtE3aYTEcX3nlUMuMf54YncX1Uy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013419; c=relaxed/simple;
	bh=3PaYhMqtCaXILxQESluYsq/Tpcaa2qYxyWmEO9LDcLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jbh8amDeQcC2xDnNSR/BTWCr+aOMfpLNb7dhyDG7Hze09J4o9a0PYYwRNQWLduBAJPWFlKppAHvEj/WQYLyatcwnLScp9RPDavg+oFN9bZUD8roYWc9lCHNOX6/+KdJldIRomytzERy/CWk3cqWrOPetXynKdRYg8MebFgIfEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQq0crpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128AAC4CEF7;
	Mon, 29 Dec 2025 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767013418;
	bh=3PaYhMqtCaXILxQESluYsq/Tpcaa2qYxyWmEO9LDcLY=;
	h=From:Subject:Date:To:Cc:From;
	b=iQq0crpzXUtRG07pvrWs9GTGzusgQfu+IZ3qkVmUy4GZX73tzWV5MvNJM3vGqUD1e
	 3zSY6Bw2x/AWd8UVw5pKNSjULiPasBnxIlIA48C2zx2YztoD76i1x1DRzMj24nz1en
	 I7SqeeGVQIdQ2A3wJ/wmBLyYrD08AoRWtA3pti/GP8cnoh8T3jxUdEzq41yMeNy5jG
	 2pQk4UNl2w77jU//VCMrSXXSKcvMxG7w9I2E3XeQpHw6Y5mIUzI5QsuPuLrClQ/kB3
	 jOkd+YucbTu2M4ylwNcvWE4keQarZFrBZahpoF4q/dKGI5K2Fs85HGmMnMem0I9W4m
	 3YjijOFVq0h6A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Mon, 29 Dec 2025 14:03:23 +0100
Message-Id: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABt8UmkC/x3MwQ6CMAyA4VchPVvCajCZr2I8lFFkMRtLS1BDe
 Henx+/w/zuYaBSDa7ODyhYtLrnCnRoIM+eHYByrgTrqHZHH16JPlFTWD2ZOYoWD4Lkn9oHGSTq
 GmhaVKb7/29u9emATHJRzmH+zxLaKttuldR41ODiOL9R4bpmJAAAA
X-Change-ID: 20251229-work-empty-namespace-352a9c2dfe0a
To: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3438; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3PaYhMqtCaXILxQESluYsq/Tpcaa2qYxyWmEO9LDcLY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQG1ag392g2vzrEqnorovbqdtb/P3Tm2Aob6Py745e84
 qne3QNsHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxdWFkmHrcVFV/Nd9EoY3n
 uHdfZ3fp1mj6sMvNRLmjoPrD4uuWuYwMJ3ZdORxR5cGyoD7rRonL8Q06v1rZdObffhLptau+ZL4
 WKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When creating containers the setup usually involves using CLONE_NEWNS
via clone3() or unshare(). This copies the caller's complete mount
namespace. The runtime will also assemble a new rootfs and then use
pivot_root() to switch the old mount tree with the new rootfs. Afterward
it will recursively umount the old mount tree thereby getting rid of all
mounts.

On a basic system here where the mount table isn't particularly large
this still copies about 30 mounts. Copying all of these mounts only to
get rid of them later is pretty wasteful.

This is exacerbated if intermediary mount namespaces are used that only
exist for a very short amount of time and are immediately destroyed
again causing a ton of mounts to be copied and destroyed needlessly.

With a large mount table and a system where thousands or ten-thousands
of namespaces are spawned in parallel this quickly becomes a bottleneck
increasing contention on the semaphore.

Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
returning a file descriptor referring to that mount tree
OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
to a new mount namespace. In that new mount namespace the copied mount
tree has been mounted on top of a copy of the real rootfs.

The caller can setns() into that mount namespace and perform any
additionally setup such as move_mount()ing detached mounts in there.

This allows OPEN_TREE_NAMESPACE to function as a combined
unshare(CLONE_NEWNS) and pivot_root().

A caller may for example choose to create an extremely minimal rootfs:

fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);

This will create a mount namespace where "wootwoot" has become the
rootfs mounted on top of the real rootfs. The caller can now setns()
into this new mount namespace and assemble additional mounts.

This also works with user namespaces:

unshare(CLONE_NEWUSER);
fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);

which creates a new mount namespace owned by the earlier created user
namespace with "wootwoot" as the rootfs mounted on top of the real
rootfs.

This will scale a lot better when creating tons of mount namespaces and
will allow to get rid of a lot of unnecessary mount and umount cycles.
It also allows to create mount namespaces without needing to spawn
throwaway helper processes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      mount: add OPEN_TREE_NAMESPACE
      selftests/open_tree: add OPEN_TREE_NAMESPACE tests

 fs/internal.h                                      |    1 +
 fs/namespace.c                                     |  155 ++-
 fs/nsfs.c                                          |   13 +
 include/uapi/linux/mount.h                         |    3 +-
 .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.c        |   26 +
 tools/testing/selftests/filesystems/utils.h        |    1 +
 9 files changed, 1223 insertions(+), 17 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251229-work-empty-namespace-352a9c2dfe0a


