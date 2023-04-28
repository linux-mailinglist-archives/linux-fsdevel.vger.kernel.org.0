Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2036F216E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbjD1X5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbjD1X5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496BF268D
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0A161577
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8475C433D2;
        Fri, 28 Apr 2023 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726247;
        bh=gfe2vJ+HV0KkUA8ae8ltCrH8SOMFxNcozSwpdAoGyNk=;
        h=From:Subject:Date:To:Cc:From;
        b=WEC0FC0lX3bZ8Yw0vA6eQsTxVQaSeppUMuHTe5GXk8Qw0elOmq2sM3vNtykuLxk+W
         6QM80ewa1W3eYfw3KXl82MS12bibFu7JiYvBKJTATag1vcQaOEMY/L5jlv8nf2p950
         cR11jDalCwjzLYfBeDjkt5JuomBhY8WOVAGuHgWVLgOtk9i2RobeKrS2Kv8MCyQxmE
         dlFBwpfeSXaH3y509oNNVHGcCmRmFvLBXJOtv8mhNJz4yImim1s+lTy0e3jdotBX5H
         8bs0x8WLJNjXx6jEZ66hzGesTChiPDbRDsqNXowJ0S85H9e6YfHnuTG7I8R7jUV00C
         z+PM9/BgpWmIg==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/4] fs: allow to mount beneath top mount
Date:   Sat, 29 Apr 2023 01:57:17 +0200
Message-Id: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF1dTGQC/42OzQ6CMBCEX4X0bEl/+AmefA/jodAtNGJLtthoC
 O9uy82TXiaZ3Z1vdiMB0EIg52IjCNEG610y8lSQYVJuBGp18kQwIVkSagJ9+AhJnm6lCMusBqC
 qVoKZquXAKpKyvQpAe1RumHL6ocIKWMamlHm7IBj7Olqvt+QnG1aP7+OJyPP0V1/klNGub9NNo
 2vD2eUO6GAuPY4kI6P4CyMSxtRy0JLrRnbiC7Pv+we7Lbj5IAEAAA==
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=18509; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gfe2vJ+HV0KkUA8ae8ltCrH8SOMFxNcozSwpdAoGyNk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT4xKZ8ffN8zmq/aQza32P3zxTceO3sil9++drWU37nZqrJ
 OqdqdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkQykjQ3/dwYd2S696BZiqXsmU8C
 6wn5SzyL59Sr/jFu5bs1vu+zP8sxAt1HnH9tr5w7kXd2K/Gbk+Z7GtffUssmS7p2XoFL4L3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes in v3:
* Refuse to mount source trees whose root has been overmounted after
  path resolution of the source path has finished but before we grabbed
  the namespace semaphore. This avoids the creation of shadow mounts.
* Refuse to mount if the mount we're mounting beneath has been moved to
  a different mountpoint before we grabbed the namespace semaphore.
* Refuse to mount if the mount we're mounting beneath has been unmounted
  before we grabbed the namespace semaphore.

Various distributions are adding or are in the process of adding support
for system extensions and in the future configuration extensions through
various tools. A more detailed explanation on system and configuration
extensions can be found on the manpage which is listed below at [1].

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

For people not too familar with mount propagation, the master:1 means
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
inserting mounts directly. For the interested reader the blogpost in [2]
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
mounted beneath an existing mount. Such mounts are internally refered to
as "tucked". The patch series exposes the ability to mount beneath a top
mount through the new MOVE_MOUNT_BENEATH flag for the move_mount()
system call. This allows userspace to seamlessly upgrade mounts. After
this series the only thing that will have changed is that mounting
beneath an existing mount can be done explicitly instead of just
implicitly.

Today, there are two scenarios where a mount can be mounted beneath an
existing mount instead of on top of it:

(1) When a service or container is started in a new mount namespace and
    pivot_root()s into its new rootfs. The way this is done is by
    mounting the new rootfs beneath the old rootfs:

            fd_newroot = open("/var/lib/machines/fedora", ...);
            fd_oldroot = open("/", ...);
            fchdir(fd_newroot);
            pivot_root(".", ".");

    After the pivot_root(".", ".") call the new rootfs is mounted
    beneath the old rootfs which can then be unmounted to reveal the
    underlying mount:

            fchdir(fd_oldroot);
            umount2(".", MNT_DETACH);

    Since pivot_root() moves the caller into a new rootfs no mounts must
    be propagated out of the new rootfs as a consequence of the
    pivot_root() call. Thus, the mounts cannot be shared.

(2) When a mount is propagated to a mount that already has another mount
    mounted on the same dentry.

    The easiest example for this is to create a new mount namespace. The
    following commands will create a mount namespace where the rootfs
    mount / will be a slave to the peer group of the host rootfs /
    mount's peer group. IOW, it will receive propagation from the host:

            mount --make-shared /
            unshare --mount --propagation=slave

    Now a new mount on the /mnt dentry in that mount namespace is
    created. (As it can be confusing it should be spelled out that the
    tmpfs mount on the /mnt dentry that was just created doesn't
    propagate back to the host because the rootfs mount / of the mount
    namespace isn't a peer of the host rootfs.):

            mount -t tmpfs tmpfs /mnt

            TARGET  SOURCE  FSTYPE  PROPAGATION
            └─/mnt  tmpfs   tmpfs

    Now another terminal in the host mount namespace can observe that
    the mount indeed hasn't propagated back to into the host mount
    namespace. A new mount can now be created on top of the /mnt dentry
    with the rootfs mount / as its parent:

            mount --bind /opt /mnt

            TARGET  SOURCE           FSTYPE  PROPAGATION
            └─/mnt  /dev/sda2[/opt]  ext4    shared:1

    The mount namespace that was created earlier can now observe that
    the bind mount created on the host has propagated into it:

            TARGET    SOURCE           FSTYPE  PROPAGATION
            └─/mnt    /dev/sda2[/opt]  ext4    master:1
              └─/mnt  tmpfs            tmpfs

    But instead of having been mounted on top of the tmpfs mount at the
    /mnt dentry the /opt mount has been mounted on top of the rootfs
    mount at the /mnt dentry. And the tmpfs mount has been remounted on
    top of the propagated /opt mount at the /opt dentry. So in other
    words, the propagated mount has been mounted beneath the preexisting
    mount in that mount namespace.

    Mount namespaces make this easy to illustrate but it's also easy to
    mount beneath an existing mount in the same mount namespace
    (The following example assumes a shared rootfs mount / with peer
     group id 1):

            mount --bind /opt /opt

            TARGET   SOURCE          FSTYPE  MNT_ID  PARENT_ID  PROPAGATION
            └─/opt  /dev/sda2[/opt]  ext4    188     29         shared:1

    If another mount is mounted on top of the /opt mount at the /opt
    dentry:

            mount --bind /tmp /opt

    The following clunky mount tree will result:

            TARGET      SOURCE           FSTYPE  MNT_ID  PARENT_ID  PROPAGATION
            └─/opt      /dev/sda2[/tmp]  ext4    405      29        shared:1
              └─/opt    /dev/sda2[/opt]  ext4    188     405        shared:1
                └─/opt  /dev/sda2[/tmp]  ext4    404     188        shared:1

    The /tmp mount is mounted beneath the /opt mount and another copy is
    mounted on top of the /opt mount. This happens because the rootfs /
    and the /opt mount are shared mounts in the same peer group.

    When the new /tmp mount is supposed to be mounted at the /opt dentry
    then the /tmp mount first propagates to the root mount at the /opt
    dentry. But there already is the /opt mount mounted at the /opt
    dentry. So the old /opt mount at the /opt dentry will be mounted on
    top of the new /tmp mount at the /tmp dentry, i.e. @opt->mnt_parent
    is @tmp and @opt->mnt_mountpoint is /tmp (Note that @opt->mnt_root
    is /opt which is what shows up as /opt under SOURCE). So again, a
    mount will be mounted beneath a preexisting mount.

    (Fwiw, a few iterations of mount --bind /opt /opt in a loop on a
     shared rootfs is a good example of what could be referred to as
     mount explosion.)

The main point is that such mounts allows userspace to umount a top
mount and reveal an underlying mount. So for example, umounting the
tmpfs mount on /mnt that was created in example (1) using mount
namespaces reveals the /opt mount which was mounted beneath it.

In (2) where a mount was mounted beneath the top mount in the same mount
namespace unmounting the top mount would unmount both the top mount and
the mount beneath. In the process the original mount would be remounted
on top of the rootfs mount / at the /opt dentry again.

This again, is a result of mount propagation only this time it's umount
propagation. However, this can be avoided by simply making the parent
mount / of the @opt mount a private or slave mount. Then the top mount
and the original mount can be unmounted to reveal the mount beneath.

These two examples are fairly arcane and are merely added to make it
clear how mount propagation has effects on current and future features.

More common use-cases will just be things like:

        mount -t btrfs /dev/sdA /mnt
        mount -t xfs   /dev/sdB --beneath /mnt
        umount /mnt

after which we'll have updated from a btrfs filesystem to a xfs
filesystem without ever revealing the underlying mountpoint.

The crux is that the proposed mechanism already exists and that it is so
powerful as to cover cases where mounts are supposed to be updated with
new versions. Crucially, it offers an important flexibility. Namely that
updates to a system may either be forced or can be delayed and the
umount of the top mount be left to a service if it is a cooperative one.

This adds a new flag to move_mount() that allows to explicitly move a
beneath the top mount adhering to the following semantics:

* Mounts cannot be mounted beneath the rootfs. This restriction
  encompasses the rootfs but also chroots via chroot() and pivot_root().
  To mount a mount beneath the rootfs or a chroot, pivot_root() can be
  used as illustrated above.
* The source mount must be a private mount to force the kernel to
  allocate a new, unused peer group id. This isn't a required
  restriction but a voluntary one. It avoids repeating a semantical
  quirk that already exists today. If bind mounts which already have a
  peer group id are inserted into mount trees that have the same peer
  group id this can cause a lot of mount propagation events to be
  generated (For example, consider running mount --bind /opt /opt in a
  loop where the parent mount is a shared mount.).
* Avoid getting rid of the top mount in the kernel. Cooperative services
  need to be able to unmount the top mount themselves.
  This also avoids a good deal of additional complexity. The umount
  would have to be propagated which would be another rather expensive
  operation. So namespace_lock() and lock_mount_hash() would potentially
  have to be held for a long time for both a mount and umount
  propagation. That should be avoided.
* The path to mount beneath must be mounted and attached.
* The top mount and its parent must be in the caller's mount namespace
  and the caller must be able to mount in that mount namespace.
* The caller must be able to unmount the top mount to prove that they
  could reveal the underlying mount.
* The propagation tree is calculated based on the destination mount's
  parent mount and the destination mount's mountpoint on the parent
  mount. Of course, if the parent of the destination mount and the
  destination mount are shared mounts in the same peer group and the
  mountpoint of the new mount to be mounted is a subdir of their
  ->mnt_root then both will receive a mount of /opt. That's probably
  easier to understand with an example. Assuming a standard shared
  rootfs /:

          mount --bind /opt /opt
          mount --bind /tmp /opt

  will cause the same mount tree as:

          mount --bind /opt /opt
          mount --beneath /tmp /opt

  because both / and /opt are shared mounts/peers in the same peer
  group and the /opt dentry is a subdirectory of both the parent's and
  the child's ->mnt_root. If a mount tree like that is created it almost
  always is an accident or abuse of mount propagation. Realistically
  what most people probably mean in this scenarios is:

          mount --bind /opt /opt
          mount --make-private /opt
          mount --make-shared /opt

  This forces the allocation of a new separate peer group for the /opt
  mount. Aferwards a mount --bind or mount --beneath actually makes
  sense as the / and /opt mount belong to different peer groups. Before
  that it's likely just confusion about what the user wanted to achieve.
* Refuse to mount source trees whose root has been overmounted after
  path resolution of the source path has finished but before we grabbed
  the namespace semaphore. This avoids the creation of shadow mounts.
* Refuse to mount if the mount we're mounting beneath has been moved to
  a different mountpoint before we grabbed the namespace semaphore.
* Refuse to mount if the mount we're mounting beneath has been unmounted
  before we grabbed the namespace semaphore.

Link: https://man7.org/linux/man-pages/man8/systemd-sysext.8.html [1]
Link: https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html [2]
Link: https://github.com/flatcar/sysext-bakery
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_2
Link: https://github.com/systemd/systemd/pull/26013

A sample program to play with all of this is at:
https://github.com/brauner/move-mount-beneath

        sudo mount -t tmpfs tmpfs /opt
        sudo ./move_mount_beneath -b /tmp /opt

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Refuse to mount source trees whose root has been overmounted after
  path resolution of the source path has finished but before we grabbed
  the namespace semaphore. This avoids the creation of shadow mounts.
- Refuse to mount if the mount we're mounting beneath has been moved to
  a different mountpoint before we grabbed the namespace semaphore.
- Refuse to mount if the mount we're mounting beneath has been unmounted
  before we grabbed the namespace semaphore.
- Link to v2: https://lore.kernel.org/r/20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org

Changes in v2:
- s/MOVE_MOUNT_TUCK/MOVE_MOUNT_BENEATH/ which is a much clearer name.
- Improve commit message.
- Link to v1: https://lore.kernel.org/r/20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org

---
Christian Brauner (4):
      fs: add path_mounted()
      fs: properly document __lookup_mnt()
      fs: use a for loop when locking a mount
      fs: allow to mount beneath top mount

 fs/namespace.c             | 423 ++++++++++++++++++++++++++++++++++++---------
 fs/pnode.c                 |  25 +++
 fs/pnode.h                 |   1 +
 include/uapi/linux/mount.h |   3 +-
 4 files changed, 371 insertions(+), 81 deletions(-)
---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230202-fs-move-mount-replace-a5a20f471e04

