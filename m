Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A16BFB54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRPxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCRPxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CF3770E
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81F96B8049B
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB390C433EF;
        Sat, 18 Mar 2023 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154773;
        bh=LtV7iImrTu0495opu03NrQX2+1itSr8tR7WupERJbFM=;
        h=From:Subject:Date:To:Cc:From;
        b=X4lXzWmJz27Hakwz2Sbu7Ar00KwIZkW5+46hYtXtzLb5rg3doRPj2ExJc2SZX0iRl
         5OUwuT1tPC+CSnyMfoKGRz8pwkPMul1sGZBnt6ncvtiKvndaK6T97ofTMyZoFRMAqi
         WQAh4Vhe/sVcIDWd484l8O9mRjb+dnLIomxIlpTQYondY4wHlUEsW+pLe9D72XwaTL
         pOK5dWQHhzbJ4H1wf80EHQV4LYUey2E8TIs9JFV5XGN1nOeu4Cecy/UzZcgNOk7DtS
         GzYbR8nwMqV7gBC/riKTOX8zPg4rBjggHypi7XCvNpG6nnlb7N017eORkX5bevbADJ
         6uL5CH2mpRI+A==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/5] fs: allow to tuck mounts explicitly
Date:   Sat, 18 Mar 2023 16:51:56 +0100
Message-Id: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABzeFWQC/x2NQQqDMBBFryKz7kiMtoVuCx6gW+liTCc1UKPM2
 CCId2/s5sGD//gbKEtghVuxgXAKGqaYpToV4AaKb8bwyg7W2NpkoFccp8QZ37ig8Pwhx0hnssY
 314pNA7ntSRl7oeiGox5JF5YyXcoaxdljMQv7sP6fO3i0d3ju+w9oemezjgAAAA==
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=15719; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LtV7iImrTu0495opu03NrQX2+1itSr8tR7WupERJbFM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gtSW11qef1sa+UnHyWjfYI1CZtuCFziWd1y6oW9fJKr
 or5ARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2bmZkmKLSnLD6vlLzpM+z/pbF9Z
 54EWp1sJJlE/+a7AUz9ZZt7mb4K8kjvVmP2evU+cLwBtfT8uoMR2vzGc7mqcUYCXzJrUhkBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
time. However, when the sytems is updated multiple times it becomes
necessary to unmount the first update on /opt, /usr, /etc and then
propagate the new update. But this means, there's an interval where the
old base system is accessible. This has to be avoided to protect against
downgrade attacks.

The existing mechanism of tucked mounts can be exposed as a new option
when attaching a mount giving userspace the ability to seamlessly
upgrade a mount. Now, instead of only being created as a consequence of
mount propagation they can be created explicitly. Today, tucked mounts
are created in two scenarios:

(1) When a service or container is started in a new mount namespace and
    pivot_root()s into its new rootfs. The way this is done is by
    tucking the new rootfs under the old rootfs:

            fd_newroot = open("/var/lib/machines/fedora", ...);
            fd_oldroot = open("/", ...);
            fchdir(fd_newroot);
            pivot_root(".", ".");

    After the pivot_root(".", ".") call the new rootfs is tucked under
    the old rootfs which can then be unmounted to reveal the underlying
    mount:

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
    words, the propagated mount has been tucked under the preexisting
    mount in that mount namespace.

    Mount namespaces make this easy to illustrate but it's also easy to
    create tucked mounts in the same mount namespace (assuming a shared
    rootfs mount / with peer group id 1):

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

    The /tmp mount is tucked both under the /opt mount and mounted on
    top of the /opt mount. This happens because the rootfs / and the
    /opt mount are shared mounts in the same peer group.

    When the new /tmp mount is supposed to be mounted at the /opt dentry
    then the /tmp mount first propagates to the root mount at the /opt
    dentry. But there already is the /opt mount mounted at the /opt
    dentry. So the old /opt mount at the /opt dentry will be mounted on
    top of the new /tmp mount at the /tmp dentry, i.e. @opt->mnt_parent
    is @tmp and @opt->mnt_mountpoint is /tmp (Note that @opt->mnt_root
    is /opt which is what shows up as /opt under SOURCE). So again, a
    mount will be tucked under a preexisting mount.

    (Fwiw, a few iterations of mount --bind /opt /opt in a loop on a
     shared rootfs is a good example of what could be referred to as
     mount explosion.)

The main point is that tucked mounts allows userspace to umount a top
mount and reveal an underlying mount. So for example, umounting the
tmpfs mount on /mnt that was created in example (1) using mount
namespaces reveals the /opt mount which was tucked beneath it.

In (2) where a tucked mount was created in the same mount namespace
unmounting the top mount would unmount both the top mount and the tucked
mount and in the process remount the original mount on top of the rootfs
mount / at the /opt dentry again. This again, is a result of mount
propagation only this time it's umount propagation. However, this can be
avoided by simply making the parent mount / of the @opt mount a private
or slave mount. Then the top mount and the original mount can be
unmounted to reveal the tucked mount.

The advantage here is that the proposed mechanism already exists and
that it is powerful enough to cover cases where mounts are supposed to
be updated with new versions. Crucially, it offers an important
flexibility. Namely that updates to a system may either be forced or can
be delayed and the umount of the top mount be left to a service if it is
a cooperative one.

This adds a new flag to move_mount() that allows to explicitly create a
tucked mount adhering to the following semantics

* Mounts cannot be tucked under the rootfs. This restriction encompasses
  the rootfs but also chroots via chroot() and pivot_root(). To tuck
  mounts under the rootfs or a chroot pivot_root() can be used as
  illustrated above.
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
* The path to tuck under must be mounted and attached.
* Both the mount to tuck under and its parent must be in the caller's
  mount namespace and the caller must be able to mount in that mount
  namespace.
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
          mount --tuck /tmp /opt

  because both / and /opt are shared mounts/peers in the same peer
  group and the /opt dentry is a subdirectory of both the parent's and
  the child's ->mnt_root. If a mount tree like that is created it almost
  always is an accident or abuse of mount propagation. Realistically
  what most people probably mean in this scenarios is:

          mount --bind /opt /opt
          mount --make-private /opt
          mount --make-shared /opt

  This forces the allocation of a new separate peer group for the /opt
  mount. Aferwards a mount --bind or mount --tuck actually makes sense
  as the / and /opt mount belong to different peer groups. Before that
  it's likely just confusion about what the user wanted to achieve.

Link: https://man7.org/linux/man-pages/man8/systemd-sysext.8.html [1]
Link: https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html [2]
Link: https://github.com/flatcar/sysext-bakery
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1
Link: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_2
Link: https://github.com/systemd/systemd/pull/26013

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Christian Brauner (5):
      fs: add path_mounted()
      pnode: pass mountpoint directly
      fs: fix __lookup_mnt() documentation
      fs: use a for loop when locking a mount
      fs: allow to tuck mounts explicitly

 fs/namespace.c             | 328 ++++++++++++++++++++++++++++++++++++---------
 fs/pnode.c                 |  12 +-
 include/uapi/linux/mount.h |   3 +-
 3 files changed, 274 insertions(+), 69 deletions(-)
---
base-commit: eeac8ede17557680855031c6f305ece2378af326
change-id: 20230202-fs-move-mount-replace-a5a20f471e04

