Return-Path: <linux-fsdevel+bounces-40214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD58A2089A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163EF3A4C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2D19E97F;
	Tue, 28 Jan 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaKf3KyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8119E965
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060441; cv=none; b=VtGOBZ976B4w41rmqjPg8Za6+tzG/dzQnfqOd1/mGINppQlroBn4eACgxWNLh6iIOLQUuRluI+5F/JVxEcteI1JJ+6aut1FA18CMFgc0s6YPYHlkuMgqCVqReLedy6o3RiJXDTIxooGWCWzVOMhMSoSkAZtxxlzxf8dW/cKKMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060441; c=relaxed/simple;
	bh=SXqIb4wiU9jrIVy6IaQ9xgECORp+T+exBtc7CooDL78=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pXeqrYvF8o/13yfERgRpjeqa2bq286LsmS/ZKeTBE+zuHREL3/CzBWoxewYRfYNQy36EUm9n5MilzNezX+19o2ojv6uUxNb9gVMnrFQxZYsFZ+KKyk8x9S+SDA67jZcm66+JcZuQLGLaMM2rhr6KlRMJUtmd3DKOM4JWcZDEcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaKf3KyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABF3C4CED3;
	Tue, 28 Jan 2025 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060441;
	bh=SXqIb4wiU9jrIVy6IaQ9xgECORp+T+exBtc7CooDL78=;
	h=From:Subject:Date:To:Cc:From;
	b=YaKf3KyOeUFdSudmhFxFG01aFOuZ/oO4+RoqrE0pNEY3UJ7p9yTVUIEk13rZw+Fq0
	 Ez/v6+9ttyMS4QJ5wki4KSJhqA2021jYCLO5ddnWE+nXBF4OpQMVHojt6K3oqe/vf+
	 Sv5fOx9uKn01DCXNnFJBvwhxUYiseQnEOgQIwU0w4v0fxlNyzvq7lBehYph7VTBuvP
	 PjkahUMBR+BsQRcIinbVDdEv9L7HrpKPnuoWX9TkOHpdaTHYTtB99oRDziGdjPtccg
	 S8WdVgUz2mBxk1ldN3pjr7HfZlpqeCd1Sp+YjcNWRs3dGxtV1/zGQrq+JMabFddzO2
	 /Be6d//b8K3Uw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] fs: allow changing idmappings
Date: Tue, 28 Jan 2025 11:33:38 +0100
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKymGcC/x3MQQrCMBBA0auUWTuSBEqrVxGRSTK1QZKGSaxC6
 d1NXb7F/xsUlsAFrt0GwmsoYUkN+tSBmyk9GYNvBqNMr7Qe8bPIC2Oqj+AjZXxnT5VxNdhbS5f
 BTWowDC3PwlP4/te3e7OlwmiFkpuPYaRSWc7HF5VGM8K+/wBM8WrFjgAAAA==
X-Change-ID: 20250118-work-mnt_idmap-update-v2-5bba97cf072e
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=10029; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SXqIb4wiU9jrIVy6IaQ9xgECORp+T+exBtc7CooDL78=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DS19F+cU/L7Z7Wy6962BMnJ5a7dGNYo3LdjwRWlX
 fv9hbMVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCU8fwP1xZ+FXH2x3xX3hZ
 Fkd/spl/XMNLNa7U9fMK/8TSK61nUhgZnv34vaI6k2Xnrs6+e6FaNtM8ApvW2te03fsT2Od8M5G
 TFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently, it isn't possible to change the idmapping of an idmapped
mount. This is becoming an obstacle for various use-cases.

  /* idmapped home directories with systemd-homed */

  On newer systems /home is can be an idmapped mount such that each file
  on disk is owned by 65536 and a subfolder exists for foreign id ranges
  such as containers. For example, a home directory might look like this
  (using an arbitrary folder as an example):

  user1@localhost:~/data/mount-idmapped$ ls -al /data/
  total 16
  drwxrwxrwx 1      65536      65536  36 Jan 27 12:15 .
  drwxrwxr-x 1      root       root  184 Jan 27 12:06 ..
  -rw-r--r-- 1      65536      65536   0 Jan 27 12:07 aaa
  -rw-r--r-- 1      65536      65536   0 Jan 27 12:07 bbb
  -rw-r--r-- 1      65536      65536   0 Jan 27 12:07 cc
  drwxr-xr-x 1 2147352576 2147352576   0 Jan 27 19:06 containers

  When logging in home is mounted as an idmapped mount with the following
  idmappings:

  65536:$(id -u):1            // uid mapping
  65536:$(id -g):1            // gid mapping
  2147352576:2147352576:65536 // uid mapping
  2147352576:2147352576:65536 // gid mapping

  So for a user with uid/gid 1000 an idmapped /home would like like this:

  user1@localhost:~/data/mount-idmapped$ ls -aln /mnt/
  total 16
  drwxrwxrwx 1       1000       1000  36 Jan 27 12:15 .
  drwxrwxr-x 1          0          0 184 Jan 27 12:06 ..
  -rw-r--r-- 1       1000       1000   0 Jan 27 12:07 aaa
  -rw-r--r-- 1       1000       1000   0 Jan 27 12:07 bbb
  -rw-r--r-- 1       1000       1000   0 Jan 27 12:07 cc
  drwxr-xr-x 1 2147352576 2147352576   0 Jan 27 19:06 containers

  In other words, 65536 is mapped to the user's uid/gid and the range
  2147352576 up to 2147352576 + 65536 is an identity mapping for
  containers.

  When a container is started a transient uid/gid range is allocated
  outside of both mappings of the idmapped mount. For example, the
  container might get the idmapping:

  $ cat /proc/1742611/uid_map
           0  537985024      65536

  This container will be allowed to write to disk within the allocated
  foreign id range 2147352576 to 2147352576 + 65536. To do this an
  idmapped mount must be created from an already idmapped mount such that:

  - The mappings for the user's uid/gid must be dropped, i.e., the
    following mappings are removed:

    65536:$(id -u):1            // uid mapping
    65536:$(id -g):1            // gid mapping

  - A mapping for the transient uid/gid range to the foreign uid/gid range
    is added:

    2147352576:537985024:65536

  In combination this will mean that the container will write to disk
  within the foreign id range 2147352576 to 2147352576 + 65536.

  /* nested containers */

  When the outer container makes use of idmapped mounts it isn't posssible
  to create an idmapped mount for the inner container with a differen
  idmapping from the outer container's idmapped mount.

There are other usecases and the two above just serve as an illustration
of the problem.

This patchset makes it possible to create a new idmapped mount from an
already idmapped mount. It aims to adhere to current performance
constraints and requirements:

- Idmapped mounts aim to have near zero performance implications for
  path lookup. That is why no refernce counting, locking or any other
  mechanism can be required that would impact performance.

  This works be ensuring that a regular mount transitions to an idmapped
  mount once going from a static nop_mnt_idmap mapping to a non-static
  idmapping.

- The idmapping of a mount change anymore for the lifetime of the mount
  afterwards. This not just avoids UAF issues it also avoids pitfalls
  such as generating non-matching uid/gid values.

Changing idmappings could be solved by:

- Idmappings could simply be reference counted (above the simple
  reference count when sharing them across multiple mounts).

  This would require pairing mnt_idmap_get() with mnt_idmap_put() which
  would end up being sprinkled everywhere into the VFS and some
  filesystems that access idmappings directly.

  It wouldn't just be quite ugly and introduce new complexity it would
  have a noticeable performance impact.

- Idmappings could gain RCU protection. This would help the LOOKUP_RCU
  case and avoids taking reference counts under RCU.

  When not under LOOKUP_RCU reference counts need to be acquired on each
  idmapping. This would require pairing mnt_idmap_get() with
  mnt_idmap_put() which would end up being sprinkled everywhere into the
  VFS and some filesystems that access idmappings directly.

  This would have the same downsides as mentioned earlier.

- The earlier solutions work by updating the mnt->mnt_idmap pointer with
  the new idmapping. Instead of this it would be possible to change the
  idmapping itself to avoid UAF issues.

  To do this a sequence counter would have to be added to struct mount.
  When retrieving the idmapping to generate uid/gid values the sequence
  counter would need to be sampled and the generation of the uid/gid
  would spin until the update of the idmap is finished.

  This has problems as well but the biggest issue will be that this can
  lead to inconsistent permission checking and inconsistent uid/gid
  pairs even more than this is already possible today. Specifically,
  during creation it could happen that:

  idmap = mnt_idmap(mnt);
  inode_permission(idmap, ...);
  may_create(idmap);
  // create file with uid/gid based on @idmap

  in between the permission checking and the generation of the uid/gid
  value the idmapping could change leading to the permission checking
  and uid/gid value that is actually used to create a file on disk being
  out of sync.

  Similarly if two values are generated like:

  idmap = mnt_idmap(mnt)
  vfsgid = make_vfsgid(idmap);
  // idmapping gets update concurrently
  vfsuid = make_vfsuid(idmap);

  @vfsgid and @vfsuid could be out of sync if the idmapping was changed
  in between. The generation of vfsgid/vfsuid could span a lot of
  codelines so to guard against this a sequence count would have to be
  passed around.

  The performance impact of this solutio are less clear but very likely
  not zero.

- Using SRCU similar to fanotify that can sleep. I find that not just
  ugly but it would have memory consumption implications and is overall
  pretty ugly.

/* solution */

So, to avoid all of these pitfalls creating an idmapped mount from an
already idmapped mount will be done atomically, i.e., a new detached
mount is created and a new set of mount properties applied to it without
it ever having been exposed to userspace at all.

This can be done in two ways. A new flag to open_tree() is added
OPEN_TREE_CLEAR_IDMAP that clears the old idmapping and returns a mount
that isn't idmapped. And then it is possible to set mount attributes on
it again including creation of an idmapped mount.

This has the consequence that a file descriptor must exist in userspace
that doesn't have any idmapping applied and it will thus never work in
unpriviledged scenarios. As a container would be able to remove the
idmapping of the mount it has been given. That should be avoided.

Instead, we add open_tree_attr() which works just like open_tree() but
takes an optional struct mount_attr parameter. This is useful beyond
idmappings as it fills a gap where a mount never exists in userspace
without the necessary mount properties applied.

This is particularly useful for mount options such as
MOUNT_ATTR_{RDONLY,NOSUID,NODEV,NOEXEC}.

To create a new idmapped mount the following works:

// Create a first idmapped mount
struct mount_attr attr = {
        .attr_set = MOUNT_ATTR_IDMAP
        .userns_fd = fd_userns
};

fd_tree = open_tree(-EBADF, "/", OPEN_TREE_CLONE, &attr, sizeof(attr));
move_mount(fd_tree, "", -EBADF, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

// Create a second idmapped mount from the first idmapped mount
attr.attr_set = MOUNT_ATTR_IDMAP;
attr.userns_fd = fd_userns2;
fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));

// Create a second non-idmapped mount from the first idmapped mount:
memset(&attr, 0, sizeof(attr));
attr.attr_clr = MOUNT_ATTR_IDMAP;
fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (5):
      fs: add vfs_open_tree() helper
      fs: add copy_mount_setattr() helper
      fs: add open_tree_attr()
      fs: add kflags member to struct mount_kattr
      fs: allow changing idmappings

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/tools/syscall_32.tbl             |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/namespace.c                              | 229 ++++++++++++++++++----------
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 scripts/syscall.tbl                         |   1 +
 20 files changed, 172 insertions(+), 82 deletions(-)
---
base-commit: 6d61a53dd6f55405ebcaea6ee38d1ab5a8856c2c
change-id: 20250118-work-mnt_idmap-update-v2-5bba97cf072e


