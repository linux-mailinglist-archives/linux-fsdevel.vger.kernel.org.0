Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423D473B5D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFWLE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjFWLEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A231211E;
        Fri, 23 Jun 2023 04:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09DD061A24;
        Fri, 23 Jun 2023 11:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5445FC433C0;
        Fri, 23 Jun 2023 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687518291;
        bh=RiiVlQwV/9GSBWBPyiAF9NjTeA5hjoUr8371OTnuyH0=;
        h=From:To:Cc:Subject:Date:From;
        b=nMMi6VI1w5v3O+9fK0/pVyz4rMdq8qo5YZ5Vp0dstzMXDlgiyWmtO/SbrSzCA11VM
         i3UbWnS1dT4VbLl8MOlQeRYcHfsgQ1+YtIK47sZJ+cR+KgHXDF/XnHx1uuNoYbAsTI
         TDwqgFl2XxXeetGnV1Gvm+GQx7YysPHa325jnDm32YajymDQGbAry8kh7TL/aOtHu0
         oLys+lQjtP2BDGUKnmhU/xriY6Wu0AIVZUd/HTAk3x6i9WdkIcwljOQVPofOERHDP/
         v7/cu+8QOSpyOvEe2oseEqhADlSG0Ms4BpLCKqW36CKMbO/WqW6gIgjXK55TyS//c9
         5eSoqXPFClUVg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs: mount
Date:   Fri, 23 Jun 2023 13:03:58 +0200
Message-Id: <20230623-leise-anlassen-5499500f0ce0@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9363; i=brauner@kernel.org; h=from:subject:message-id; bh=RiiVlQwV/9GSBWBPyiAF9NjTeA5hjoUr8371OTnuyH0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMrRFmvJ5bm9KwMJbp874Q/0s7BBW/MXJUGR1r6NY3nnB/ htusjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsE2P4pzhR7WCXzqMNc7meHpRfU+ I7cV1M9l4jdzZ7y2WK1+YtusjwT0GnMIx35uRlSxrqH05JN5yx5toB3d7HCRWdEu1dNWbmXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains the work to extend move_mount() to allow adding a mount
beneath the topmost mount of a mount stack.

There are two LWN articles about this. One covers the original patch
series in [1]. The other in [2] summarizes the session and roughly the
discussion between Al and me at LSFMM. The second article also goes into
some good questions from attendees.

Since all details are found in the relevant commit with a technical dive
into semantics and locking at the end I'm only adding the motivation and
core functionality for this from commit message and leave out the
invasive details. The code is also heavily commented and annotated as
well which was explicitly requested.

TL;DR:

> mount -t ext4 /dev/sda /mnt
  |
  └─/mnt    /dev/sda    ext4

> mount --beneath -t xfs /dev/sdb /mnt
  |
  └─/mnt    /dev/sdb    xfs
    └─/mnt  /dev/sda    ext4

> umount /mnt
  |
  └─/mnt    /dev/sdb    xfs

The longer motivation is that various distributions are adding or are in
the process of adding support for system extensions and in the future
configuration extensions through various tools. A more detailed
explanation on system and configuration extensions can be found on the
manpage which is listed below at [3].

System extension images may – dynamically at runtime — extend the /usr/
and /opt/ directory hierarchies with additional files. This is
particularly useful on immutable system images where a /usr/ and/or
/opt/ hierarchy residing on a read-only file system shall be extended
temporarily at runtime without making any persistent modifications.

When one or more system extension images are activated, their /usr/ and
/opt/ hierarchies are combined via overlayfs with the same hierarchies
of the host OS, and the host /usr/ and /opt/ overmounted with it
("merging"). When they are deactivated, the mount point is disassembled
— again revealing the unmodified original host version of the hierarchy
("unmerging"). Merging thus makes the extension's resources suddenly
appear below the /usr/ and /opt/ hierarchies as if they were included in
the base OS image itself. Unmerging makes them disappear again, leaving
in place only the files that were shipped with the base OS image itself.

System configuration images are similar but operate on directories
containing system or service configuration.

On nearly all modern distributions mount propagation plays a crucial
role and the rootfs of the OS is a shared mount in a peer group (usually
with peer group id 1):

       TARGET  SOURCE  FSTYPE  PROPAGATION  MNT_ID  PARENT_ID
       /       /       ext4    shared:1     29      1

On such systems all services and containers run in a separate mount
namespace and are pivot_root()ed into their rootfs. A separate mount
namespace is almost always used as it is the minimal isolation mechanism
services have. But usually they are even much more isolated up to the
point where they almost become indistinguishable from containers.

Mount propagation again plays a crucial role here. The rootfs of all
these services is a slave mount to the peer group of the host rootfs.
This is done so the service will receive mount propagation events from
the host when certain files or directories are updated.

In addition, the rootfs of each service, container, and sandbox is also
a shared mount in its separate peer group:

       TARGET  SOURCE  FSTYPE  PROPAGATION         MNT_ID  PARENT_ID
       /       /       ext4    shared:24 master:1  71      47

For people not too familiar with mount propagation, the master:1 means
that this is a slave mount to peer group 1. Which as one can see is the
host rootfs as indicated by shared:1 above. The shared:24 indicates that
the service rootfs is a shared mount in a separate peer group with peer
group id 24.

A service may run other services. Such nested services will also have a
rootfs mount that is a slave to the peer group of the outer service
rootfs mount.

For containers things are just slighly different. A container's rootfs
isn't a slave to the service's or host rootfs' peer group. The rootfs
mount of a container is simply a shared mount in its own peer group:

       TARGET                    SOURCE  FSTYPE  PROPAGATION  MNT_ID  PARENT_ID
       /home/ubuntu/debian-tree  /       ext4    shared:99    61      60

So whereas services are isolated OS components a container is treated
like a separate world and mount propagation into it is restricted to a
single well known mount that is a slave to the peer group of the shared
mount /run on the host:

       TARGET                  SOURCE              FSTYPE  PROPAGATION  MNT_ID  PARENT_ID
       /propagate/debian-tree  /run/host/incoming  tmpfs   master:5     71      68

Here, the master:5 indicates that this mount is a slave to the peer
group with peer group id 5. This allows to propagate mounts into the
container and served as a workaround for not being able to insert mounts
into mount namespaces directly. But the new mount api does support
inserting mounts directly. For the interested reader the blogpost in [4]
might be worth reading where I explain the old and the new approach to
inserting mounts into mount namespaces.

Containers of course, can themselves be run as services. They often run
full systems themselves which means they again run services and
containers with the exact same propagation settings explained above.

The whole system is designed so that it can be easily updated, including
all services in various fine-grained ways without having to enter every
single service's mount namespace which would be prohibitively expensive.
The mount propagation layout has been carefully chosen so it is possible
to propagate updates for system extensions and configurations from the
host into all services.

The simplest model to update the whole system is to mount on top of
/usr, /opt, or /etc on the host. The new mount on /usr, /opt, or /etc
will then propagate into every service. This works cleanly the first
time. However, when the system is updated multiple times it becomes
necessary to unmount the first update on /opt, /usr, /etc and then
propagate the new update. But this means, there's an interval where the
old base system is accessible. This has to be avoided to protect against
downgrade attacks.

The vfs already exposes a mechanism to userspace whereby mounts can be
mounted beneath an existing mount. Such mounts are internally referred
to as "tucked". The patch series exposes the ability to mount beneath a
top mount through the new MOVE_MOUNT_BENEATH flag for the move_mount()
system call. This allows userspace to seamlessly upgrade mounts. After
this series the only thing that will have changed is that mounting
beneath an existing mount can be done explicitly instead of just
implicitly.

The crux is that the proposed mechanism already exists and that it is so
powerful as to cover cases where mounts are supposed to be updated with
new versions. Crucially, it offers an important flexibility. Namely that
updates to a system may either be forced or can be delayed and the
umount of the top mount be left to a service if it is a cooperative one.

Link: https://lwn.net/Articles/927491 [1]
Link: https://lwn.net/Articles/934094 [2]
Link: https://man7.org/linux/man-pages/man8/systemd-sysext.8.html [3]
Link: https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html [4]
Link: https://github.com/flatcar/sysext-bakery
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_2
Link: https://github.com/systemd/systemd/pull/26013

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.mount

for you to fetch changes up to 6ac392815628f317fcfdca1a39df00b9cc4ebc8b:

  fs: allow to mount beneath top mount (2023-05-19 04:30:22 +0200)

Please consider pulling these changes from the signed v6.5/vfs.mount tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.mount

----------------------------------------------------------------
Christian Brauner (4):
      fs: add path_mounted()
      fs: properly document __lookup_mnt()
      fs: use a for loop when locking a mount
      fs: allow to mount beneath top mount

 fs/namespace.c             | 451 +++++++++++++++++++++++++++++++++++++--------
 fs/pnode.c                 |  42 ++++-
 fs/pnode.h                 |   3 +
 include/uapi/linux/mount.h |   3 +-
 4 files changed, 417 insertions(+), 82 deletions(-)
