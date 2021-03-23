Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9D34696B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCWUAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhCWUAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53FC061574;
        Tue, 23 Mar 2021 13:00:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A653D1F44DA2
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 0/4] mm: shmem: Add case-insensitive support for tmpfs
Date:   Tue, 23 Mar 2021 16:59:37 -0300
Message-Id: <20210323195941.69720-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patchset adds support for case-insensitive file name lookups in
tmpfs. The implementation (and even the commit message) was based on the
work done at b886ee3e778e ("ext4: Support case-insensitive file name
lookups").

* Use case

The use case for this feature is similar to the use case for ext4, to
better support compatibility layers (like Wine), particularly in
combination with sandboxing/container tools (like Flatpak). Those
containerization tools can share a subset of the host filesystem with an
application. In the container, the root directory and any parent
directories required for a shared directory are on tmpfs, with the
shared directories bind-mounted into the container's view of the
filesystem.

If the host filesystem is using case-insensitive directories, then the
application can do lookups inside those directories in a
case-insensitive way, without this needing to be implemented in
user-space. However, if the host is only sharing a subset of a
case-insensitive directory with the application, then the parent
directories of the mount point will be part of the container's root
tmpfs. When the application tries to do case-insensitive lookups of
those parent directories on a case-sensitive tmpfs, the lookup will
fail.

For example, if /srv/games is a case-insensitive directory on the host,
then applications will expect /srv/games/Steam/Half-Life and
/srv/games/steam/half-life to be interchangeable; but if the
container framework is only sharing /srv/games/Steam/Half-Life and
/srv/games/Steam/Portal (and not the rest of /srv/games) with the
container, with /srv, /srv/games and /srv/games/Steam as part of the
container's tmpfs root, then making /srv/games a case-insensitive
directory inside the container would be necessary to meet that
expectation.

* The patchset

Note that, since there's no on disk information about this filesystem
(and thus, no mkfs support) we need to pass this information in the
mount options. This is the main difference with other fs supporting
casefolding like ext4 and f2fs. The folder attribute uses the same value
used by ext4/f2fs, so userspace tools like chattr already works with
this implementation.

- Patch 1 reverts the unexportation of casefolding functions for dentry
operations that are going to be used by tmpfs.

- Patch 2 does the wiring up of casefold functions inside tmpfs, along
with creating the mounting options for casefold support.

- Patch 3 gives tmpfs support for IOCTL for get/set file flags. This is
needed since the casefold is done in a per-directory basis at supported
mount points, via directory flags.

- Patch 4 documents the new options, along with an usage example.

This work is also available at
https://gitlab.collabora.com/tonyk/linux/-/tree/tmpfs-ic

* Testing

xfstests already has a test for casefold filesystems (generic/556). I
have adapted it to work with tmpfs in a hacky way and this work can be
found at https://gitlab.collabora.com/tonyk/xfstests. All tests succeed.

Whenever we manage to get in a common ground around the interface, I'll
make it more upstreamable so it can get merged along with the kernel
work.

* FAQ

- Can't this be done in userspace?

Yes, but it's slow and can't assure correctness (imagine two files named
file.c and FILE.C; an app asks for FiLe.C, which one is the correct?).

- Which changes are required in userspace?

Apart of the container tools that will use this feature, no change is
needed. Both mount and chattr already work with this patchset.

- This will completely obliterate my setup!
  
Casefold support in tmpfs is disabled by default.

Thanks,
	André

André Almeida (4):
  Revert "libfs: unexport generic_ci_d_compare() and
    generic_ci_d_hash()"
  mm: shmem: Support case-insensitive file name lookups
  mm: shmem: Add IOCTL support for tmpfs
  docs: tmpfs: Add casefold options

 Documentation/filesystems/tmpfs.rst |  26 +++++
 fs/libfs.c                          |   8 +-
 include/linux/fs.h                  |   5 +
 include/linux/shmem_fs.h            |   5 +
 mm/shmem.c                          | 175 +++++++++++++++++++++++++++-
 5 files changed, 213 insertions(+), 6 deletions(-)

-- 
2.31.0

