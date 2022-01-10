Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075734898F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiAJM60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 07:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiAJM4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:56:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202BC06173F;
        Mon, 10 Jan 2022 04:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9140560E75;
        Mon, 10 Jan 2022 12:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23A7C36AE5;
        Mon, 10 Jan 2022 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641819382;
        bh=AX1VuxxrVVqHBENLERvgpzoDnpMpY/BCtLx68yD5Ue8=;
        h=From:To:Cc:Subject:Date:From;
        b=MikKJ/f0ib+YfyBEBP61X19zAi3ugsjBvgNNYcdYjNmBpBdwGFENQrkFqKSmVwGxM
         Km0SWXdZzT2lpfb6w658pIYsQHXAbypbKc8rcx45Lxp242vVgXZ97p6+oMkYppGvk2
         mHWQtQSU1ZUZDmCZOo/jGGI2aU5KFpo/GJctwu9sXqnkTMawqlfA6KKUxDcGT/HVh6
         h0Mn6g0BVEJ1gTWlLv0NAPm+oPPEHuJt0OZUYyc9FNyzTJE4h+F4DiAix/JXu0jmPE
         kHob0z0kUVc5y1YPOnkKKNVL+kSpkeLJkdErYIVn9BYBmfTsX+rLStO3HzWBKLncSZ
         65XWlvKz+j0yQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs idmapping updates
Date:   Mon, 10 Jan 2022 13:56:00 +0100
Message-Id: <20220110125600.440171-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This contains the work to enable the idmapping infrastructure to support
idmapped mounts of filesystems mounted with an idmapping. In addition this
contains various cleanups that avoid repeated open-coding of the same
functionality and simplify the code in quite a few places. We also finish
the renaming of the mapping helpers we started a few kernel releases back
and move them to a dedicated header to not continue polluting the fs
header needlessly with low-level idmapping helpers. With this series the fs
header only contains idmapping helpers that interact with fs objects.

Currently we only support idmapped mounts for filesystems mounted without
an idmapping themselves. This was a conscious decision mentioned in
multiple places (cf. [1]).

As explained at length in [3] it is perfectly fine to extend support for
idmapped mounts to filesystem's mounted with an idmapping should the need
arise. The need has been there for some time now (cf. [2]).

Before we can port any filesystem that is mountable with an idmapping to
support idmapped mounts in the coming cycles, we need to first extend the
mapping helpers to account for the filesystem's idmapping. This again, is
explained at length in our documentation at [3] and also in the individual
commit messages so here's an overview.

Currently, the low-level mapping helpers implement the remapping algorithms
described in [3] in a simplified manner as we could rely on the fact
that all filesystems supporting idmapped mounts are mounted without an
idmapping.

In contrast, filesystems mounted with an idmapping are very likely to not
use an identity mapping and will instead use a non-identity mapping. So the
translation step from or into the filesystem's idmapping in the remapping
algorithm cannot be skipped for such filesystems.

Non-idmapped filesystems and filesystems not supporting idmapped mounts are
unaffected by this change as the remapping algorithms can take the same
shortcut as before. If the low-level helpers detect that they are dealing
with an idmapped mount but the underlying filesystem is mounted without an
idmapping we can rely on the previous shortcut and can continue to skip the
translation step from or into the filesystem's idmapping. And of course, if
the low-level helpers detect that they are not dealing with an idmapped
mount they can simply return the relevant id unchanged; no remapping needs
to be performed at all.

These checks guarantee that only the minimal amount of work is performed.
As before, if idmapped mounts aren't used the low-level helpers are
idempotent and no work is performed at all.

Link: [1] commit 2ca4dcc4909d ("fs/mount_setattr: tighten permission checks")
Link: [2] https://github.com/containers/podman/issues/10374
Link: [3] Documentations/filesystems/idmappings.rst
Link: [4] commit a65e58e791a1 ("fs: document and rename fsid helpers")

/* Testing */
All patches are based on v5.16-rc3 and have been sitting in linux-next. No
build failures or warnings were observed and fstests are passing:

SECTION       -- xfs
RECREATING    -- xfs on /dev/loop4
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-fs.idmapped.v5.17-88a4b8c3b3c3 #42 SMP PREEMPT Mon Jan 10 10:57:44 UTC 2022
MKFS_OPTIONS  -- -f -f /dev/loop5
MOUNT_OPTIONS -- /dev/loop5 /mnt/scratch

generic/633 25s ...  26s
generic/644 4s ...  16s
generic/645 209s ...  77s
generic/656 14s ...  17s
xfs/152 75s ...  70s
xfs/153 48s ...  43s
Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
Passed all 6 tests

SECTION       -- ext4
RECREATING    -- ext4 on /dev/loop4
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-fs.idmapped.v5.17-88a4b8c3b3c3 #42 SMP PREEMPT Mon Jan 10 10:57:44 UTC 2022
MKFS_OPTIONS  -- -F -F /dev/loop5
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt/scratch

generic/633 26s ...  17s
generic/644 16s ...  4s
generic/645 77s ...  58s
generic/656 17s ...  8s
Ran: generic/633 generic/644 generic/645 generic/656
Passed all 4 tests

SECTION       -- btrfs
RECREATING    -- btrfs on /dev/loop4
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-fs.idmapped.v5.17-88a4b8c3b3c3 #42 SMP PREEMPT Mon Jan 10 10:57:44 UTC 2022
MKFS_OPTIONS  -- -f /dev/loop5
MOUNT_OPTIONS -- /dev/loop5 /mnt/scratch

btrfs/245 11s ...  11s
generic/633 17s ...  21s
generic/644 4s ...  6s
generic/645 58s ...  60s
generic/656 8s ...  8s
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
Passed all 5 tests

SECTION       -- xfs
=========================
Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
Passed all 6 tests

SECTION       -- ext4
=========================
Ran: generic/633 generic/644 generic/645 generic/656
Passed all 4 tests

SECTION       -- btrfs
=========================
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
Passed all 5 tests

/* Conflicts */
At the time of creating this PR no merge conflicts showed up doing a test-merge
with current mainline.

There's a merge conflict reported from -next with David's fscache rewrite.
Although I'm not sure David still intends to send it for the v5.17 merge window
we covered the conflict in thread [1] where stated in [2] that the conflict is
trivial enough for you to resolve during the merge. (I'm posting the links so
you can double-check.)

[1]: https://lore.kernel.org/linux-fsdevel/20211207142405.179428-1-brauner@kernel.org
[2]: https://lore.kernel.org/linux-fsdevel/CAHk-=wjjxBRNkav+RjpdHjDZHRPAJgjdM4wTFi_oEnk0_dc67g@mail.gmail.com

At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.17

for you to fetch changes up to bd303368b776eead1c29e6cdda82bde7128b82a7:

  fs: support mapped mounts of mapped filesystems (2021-12-05 10:28:57 +0100)

Please consider pulling these changes from the signed fs.idmapped.v5.17 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.v5.17

----------------------------------------------------------------
Christian Brauner (10):
      fs: add is_idmapped_mnt() helper
      fs: move mapping helpers
      fs: tweak fsuidgid_has_mapping()
      fs: account for filesystem mappings
      docs: update mapping documentation
      fs: use low-level mapping helpers
      fs: remove unused low-level mapping helpers
      fs: port higher-level mapping helpers
      fs: add i_user_ns() helper
      fs: support mapped mounts of mapped filesystems

 Documentation/filesystems/idmappings.rst |  72 ----------
 fs/cachefiles/bind.c                     |   2 +-
 fs/ecryptfs/main.c                       |   2 +-
 fs/ksmbd/smbacl.c                        |  19 +--
 fs/ksmbd/smbacl.h                        |   5 +-
 fs/namespace.c                           |  53 +++++--
 fs/nfsd/export.c                         |   2 +-
 fs/open.c                                |   8 +-
 fs/overlayfs/super.c                     |   2 +-
 fs/posix_acl.c                           |  17 ++-
 fs/proc_namespace.c                      |   2 +-
 fs/xfs/xfs_inode.c                       |   8 +-
 fs/xfs/xfs_linux.h                       |   1 +
 fs/xfs/xfs_symlink.c                     |   4 +-
 include/linux/fs.h                       | 141 ++++++-------------
 include/linux/mnt_idmapping.h            | 234 +++++++++++++++++++++++++++++++
 security/commoncap.c                     |  15 +-
 17 files changed, 356 insertions(+), 231 deletions(-)
 create mode 100644 include/linux/mnt_idmapping.h
