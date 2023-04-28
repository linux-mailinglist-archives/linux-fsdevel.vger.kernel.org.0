Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24AF6F2171
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbjD1X5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbjD1X5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474C40F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 207EB6319B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57904C433D2;
        Fri, 28 Apr 2023 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726253;
        bh=jgh/XWu9tpotsHkzPkvcNpwhoDMEJT7QIUjURfuduRg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RZeUZ5dtpuxXkZ8QG7TiQ9IrifN0RUGALLVJ+EV4IGggiNmf0hx/ukovD+3UyS+ox
         2Y1heAA7c9p4nytfShZ3CxlkeAvHHG6WD6ZiyjiKtY9rpaJl6K/l5YFC+cCAsirxQj
         iZMsfOaZkUqLhlerfX4fawfBW5xJH/q3W/cteZ1ZpuRQc44LOfujMnMGVpkIFQj70l
         90bJ7gybv3wCn3AmNTdVDfBcV2G087OwFcfSh5qf5a59470Dt3Oa7aurqIgwEs4cBa
         slT9vbFmHgrROYnKk7FXO8jtfa37qbYlbZI9l5PXYhCFwTkQGZ43wT8PkyL1h++w+2
         Q7376mUuI78qA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 29 Apr 2023 01:57:21 +0200
Subject: [PATCH v3 4/4] fs: allow to mount beneath top mount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230202-fs-move-mount-replace-v3-4-377893f74bc8@kernel.org>
References: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=36669; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jgh/XWu9tpotsHkzPkvcNpwhoDMEJT7QIUjURfuduRg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT4xKaWTJLQl8/skA55XnaK0TvgFcPcZ1edV1Q9ehCW/05Y
 pdi3o4SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ+TgzfHQ77m9Ze8dpsdfZN/JqMKk
 kRkyMv7rAGKf+N5vxw8/w+hv9lC73ZMj59uCfxxzmn9+bR6mUXls6Uf9clr1Wh8zWhbAc3AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Acquire a stable reference on $realmnt->mnt_mountpoint when
  locking the destination mount tree. Ensure that the mountpoint is
  still valid after we acquired $namespace_sem.
- Refuse to mount source trees whose root has been overmounted after
  path resolution of the source path has finished but before we grabbed
  the namespace semaphore. This avoids the creation of shadow mounts.
- Refuse to mount if the mount we're mounting beneath has been moved to
  a different mountpoint before we grabbed the namespace semaphore.
- Refuse to mount if the mount we're mounting beneath has been unmounted
  before we grabbed the namespace semaphore.
- Remove attach_mnt_beneath() and simply extend attach_mnt() to take a
  boolean argument.
- Ensure that the root of the source mount tree hasn't been overmounted.
- Don't duplicate checks by calling can_umount(). Just move the required
  checks into can_move_mount_beneath().

Changes in v2:
- Fix kernel documentation of attach_mnt_beneath().
---
 fs/namespace.c             | 324 ++++++++++++++++++++++++++++++++++++++-------
 fs/pnode.c                 |  25 ++++
 fs/pnode.h                 |   1 +
 include/uapi/linux/mount.h |   3 +-
 4 files changed, 304 insertions(+), 49 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 11157d0abe8f..f26f48cb15bd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -926,6 +926,30 @@ void mnt_set_mountpoint(struct mount *mnt,
 	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
 }
 
+/**
+ * mnt_set_mountpoint_beneath - mount a mount beneath another one
+ *
+ * @new_parent: the source mount
+ * @top_mnt:    the mount beneath which @new_parent is mounted
+ * @new_mp:     the new mountpoint of @top_mnt on @new_parent
+ *
+ * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
+ * parent @top_mnt->mnt_parent and mount it on top of @new_parent at
+ * @new_mp. And mount @new_parent on the old parent and old
+ * mountpoint of @top_mnt.
+ */
+static void mnt_set_mountpoint_beneath(struct mount *new_parent,
+				       struct mount *top_mnt,
+				       struct mountpoint *new_mp)
+{
+	struct mount *old_top_parent = top_mnt->mnt_parent;
+	struct mountpoint *old_top_mp = top_mnt->mnt_mp;
+
+	mnt_set_mountpoint(old_top_parent, old_top_mp, new_parent);
+	mnt_change_mountpoint(new_parent, new_mp, top_mnt);
+}
+
+
 static void __attach_mnt(struct mount *mnt, struct mount *parent)
 {
 	hlist_add_head_rcu(&mnt->mnt_hash,
@@ -933,15 +957,41 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
 	list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
 }
 
-/*
- * vfsmount lock must be held for write
+/**
+ * attach_mnt - mount a mount, attach to @mount_hashtable and parent's
+ *              list of child mounts
+ * @parent:  the parent
+ * @mnt:     the new mount
+ * @mp:      the new mountpoint
+ * @beneath: whether to mount @mnt beneath or on top of @parent
+ *
+ * If @beneath is false, mount @mnt at @mp on @parent. Then attach @mnt
+ * to @parent's child mount list and to @mount_hashtable.
+ *
+ * If @beneath is true, remove @mnt from its current parent and
+ * mountpoint and mount it on @mp on @parent, and mount @parent on the
+ * old parent and old mountpoint of @mnt. Finally, attach @parent to
+ * @mnt_hashtable and @parent->mnt_parent->mnt_mounts.
+ *
+ * Note, when __attach_mnt() is called @mnt->mnt_parent already points
+ * to the correct parent.
+ *
+ * Context: This function expects lock_mount_hash() to be held.
  */
-static void attach_mnt(struct mount *mnt,
-			struct mount *parent,
-			struct mountpoint *mp)
+static void attach_mnt(struct mount *mnt, struct mount *parent,
+		       struct mountpoint *mp, bool beneath)
 {
-	mnt_set_mountpoint(parent, mp, mnt);
-	__attach_mnt(mnt, parent);
+	if (beneath)
+		mnt_set_mountpoint_beneath(mnt, parent, mp);
+	else
+		mnt_set_mountpoint(parent, mp, mnt);
+	/*
+	 * Note, @mnt->mnt_parent has to be used. If @mnt was mounted
+	 * beneath @parent then @mnt will need to be attached to
+	 * @parent's old parent, not @parent. IOW, @mnt->mnt_parent
+	 * isn't the same mount as @parent.
+	 */
+	__attach_mnt(mnt, mnt->mnt_parent);
 }
 
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
@@ -953,7 +1003,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	hlist_del_init(&mnt->mnt_mp_list);
 	hlist_del_init_rcu(&mnt->mnt_hash);
 
-	attach_mnt(mnt, parent, mp);
+	attach_mnt(mnt, parent, mp, false);
 
 	put_mountpoint(old_mp);
 	mnt_add_count(old_parent, -1);
@@ -1954,7 +2004,7 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
 				goto out;
 			lock_mount_hash();
 			list_add_tail(&q->mnt_list, &res->mnt_list);
-			attach_mnt(q, parent, p->mnt_mp);
+			attach_mnt(q, parent, p->mnt_mp, false);
 			unlock_mount_hash();
 		}
 	}
@@ -2163,12 +2213,17 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 	return 0;
 }
 
-/*
- *  @source_mnt : mount tree to be attached
- *  @nd         : place the mount tree @source_mnt is attached
- *  @parent_nd  : if non-null, detach the source_mnt from its parent and
- *  		   store the parent mount and mountpoint dentry.
- *  		   (done when source_mnt is moved)
+typedef enum mnt_tree_flags_t {
+	MNT_TREE_MOVE		= BIT(0),
+	MNT_TREE_BENEATH	= BIT(1),
+} mnt_tree_flags_t;
+
+/**
+ * attach_recursive_mnt - attach a source mount tree
+ *  @source_mnt: mount tree to be attached
+ *  @top_mnt:    mount that @source_mnt will be mounted on or mounted beneath
+ *  @dest_mp:    the mountpoint @source_mnt will be mounted at
+ *  @flags:      modify how @source_mnt is supposed to be attached
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -2227,20 +2282,22 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
  * in allocations.
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
-			struct mount *dest_mnt,
-			struct mountpoint *dest_mp,
-			bool moving)
+				struct mount *top_mnt,
+				struct mountpoint *dest_mp,
+				mnt_tree_flags_t flags)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
-	struct mnt_namespace *ns = dest_mnt->mnt_ns;
+	struct mnt_namespace *ns = top_mnt->mnt_ns;
 	struct mountpoint *smp;
-	struct mount *child, *p;
+	struct mount *child, *dest_mnt, *p;
 	struct hlist_node *n;
-	int err;
+	int err = 0;
+	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
 
-	/* Preallocate a mountpoint in case the new mounts need
-	 * to be tucked under other mounts.
+	/*
+	 * Preallocate a mountpoint in case the new mounts need to be
+	 * mounted beneath mounts on the same mountpoint.
 	 */
 	smp = get_mountpoint(source_mnt->mnt.mnt_root);
 	if (IS_ERR(smp))
@@ -2253,29 +2310,41 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			goto out;
 	}
 
+	if (beneath)
+		dest_mnt = top_mnt->mnt_parent;
+	else
+		dest_mnt = top_mnt;
+
 	if (IS_MNT_SHARED(dest_mnt)) {
 		err = invent_group_ids(source_mnt, true);
 		if (err)
 			goto out;
 		err = propagate_mnt(dest_mnt, dest_mp, source_mnt, &tree_list);
-		lock_mount_hash();
-		if (err)
-			goto out_cleanup_ids;
+	}
+	lock_mount_hash();
+	if (err)
+		goto out_cleanup_ids;
+
+	if (IS_MNT_SHARED(dest_mnt)) {
 		for (p = source_mnt; p; p = next_mnt(p, source_mnt))
 			set_mnt_shared(p);
-	} else {
-		lock_mount_hash();
 	}
+
 	if (moving) {
+		if (beneath)
+			dest_mp = smp;
 		unhash_mnt(source_mnt);
-		attach_mnt(source_mnt, dest_mnt, dest_mp);
+		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
 			/* move from anon - the caller will destroy */
 			list_del_init(&source_mnt->mnt_ns->list);
 		}
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+		if (beneath)
+			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
+		else
+			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		commit_tree(source_mnt);
 	}
 
@@ -2315,28 +2384,73 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	return err;
 }
 
-static struct mountpoint *lock_mount(struct path *path)
+/**
+ * do_lock_mount - lock mount and mountpoint
+ * @path:    target path
+ * @beneath: whether we intend to mount beneath @path
+ *
+ * Follow the mount stack on @path until the top mount is found.
+ *
+ * If we intend to mount on top of @path->mnt acquire the inode_lock()
+ * for the top mount's ->mnt_root to protect against concurrent removal
+ * of our prospective mountpoint from another mount namespace.
+ *
+ * If we intend to mount beneath the top mount @m acquire the
+ * inode_lock() on @m's mountpoint @mp on @m->mnt_parent. Otherwise we
+ * risk racing with someone who unlinked @mp from another mount
+ * namespace where @m doesn't have a child mount mounted @mp. We don't
+ * care if @m->mnt_root/@path->dentry is removed (as long as
+ * @path->dentry isn't equal to @m->mnt_mountpoint of course).
+ *
+ * Return: Either the target mountpoint on the top mount or the top
+ *         mount's mountpoint.
+ */
+static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 {
-	struct vfsmount *mnt;
+	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
-	struct mountpoint *mp;
+	struct mountpoint *mp = ERR_PTR(-ENOENT);
 
 	for (;;) {
-		dentry = path->dentry;
+		struct mount *m;
+
+		if (beneath) {
+			m = real_mount(mnt);
+			read_seqlock_excl(&mount_lock);
+			dentry = dget(m->mnt_mountpoint);
+			read_sequnlock_excl(&mount_lock);
+		} else {
+			dentry = path->dentry;
+		}
+
 		inode_lock(dentry->d_inode);
 		if (unlikely(cant_mount(dentry))) {
 			inode_unlock(dentry->d_inode);
-			return ERR_PTR(-ENOENT);
+			goto out;
 		}
 
 		namespace_lock();
 
+		/*
+		 * @mnt may have been unmounted or moved from its
+		 * current mountpoint in between dropping @mount_lock
+		 * and acquiring @namespace_sem.
+		 */
+		if (beneath &&
+		    (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {
+			namespace_unlock();
+			inode_unlock(dentry->d_inode);
+			goto out;
+		}
+
 		mnt = lookup_mnt(path);
 		if (likely(!mnt))
 			break;
 
 		namespace_unlock();
 		inode_unlock(dentry->d_inode);
+		if (beneath)
+			dput(dentry);
 		path_put(path);
 		path->mnt = mnt;
 		path->dentry = dget(mnt->mnt_root);
@@ -2348,9 +2462,18 @@ static struct mountpoint *lock_mount(struct path *path)
 		inode_unlock(dentry->d_inode);
 	}
 
+out:
+	if (beneath)
+		dput(dentry);
+
 	return mp;
 }
 
+static inline struct mountpoint *lock_mount(struct path *path)
+{
+	return do_lock_mount(path, false);
+}
+
 static void unlock_mount(struct mountpoint *where)
 {
 	struct dentry *dentry = where->m_dentry;
@@ -2372,7 +2495,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, false);
+	return attach_recursive_mnt(mnt, p, mp, 0);
 }
 
 /*
@@ -2857,7 +2980,97 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 	return err;
 }
 
-static int do_move_mount(struct path *old_path, struct path *new_path)
+/**
+ * path_overmounted - check if path is overmounted
+ * @path: path to check
+ *
+ * Check if path is overmounted, i.e., if there's a mount on top of
+ * @path->mnt with @path->dentry as mountpoint.
+ *
+ * Context: This function expects namespace_lock() to be held.
+ * Return: If path is overmounted true is returned, false if not.
+ */
+static inline bool path_overmounted(const struct path *path)
+{
+	rcu_read_lock();
+	if (unlikely(__lookup_mnt(path->mnt, path->dentry))) {
+		rcu_read_unlock();
+		return true;
+	}
+	rcu_read_unlock();
+	return false;
+}
+
+/**
+ * can_move_mount_beneath - check that we can mount beneath the top mount
+ * @from: mount to mount beneath
+ * @to:   mount under which to mount
+ *
+ * - Make sure that the source mount isn't a shared mount so we force
+ *   the kernel to allocate a new peer group id. This simplifies the
+ *   mount trees that can be created and limits propagation events in
+ *   cases where @to, and/or @to->mnt_parent are in the same peer group.
+ *   Something that's a nuisance already today.
+ * - Make sure that @to->dentry is actually the root of a mount under
+ *   which we can mount another mount.
+ * - Make sure that nothing can be mounted beneath under the caller's
+ *   current root or the rootfs of the namespace.
+ * - Make sure that the caller can unmount the topmost mount ensuring
+ *   that the caller could reveal the underlying mountpoint.
+ * - Ensure that nothing has been mounted on top of @from before we
+ *   grabbed @namespace_sem to avoid creating pointless shadow mounts.
+ *
+ * Context: This function expects namespace_lock() to be held.
+ * Return: On success 0, and on error a negative error code is returned.
+ */
+static int can_move_mount_beneath(const struct path *from,
+				  const struct path *to,
+				  const struct mountpoint *mp)
+{
+	struct mount *mnt_from = real_mount(from->mnt),
+		     *mnt_to = real_mount(to->mnt);
+
+	/* Avoid creating shadow mounts during mount propagation. */
+	if (path_overmounted(from))
+		return -EINVAL;
+
+	if (!mnt_has_parent(mnt_to))
+		return -EINVAL;
+
+	if (!path_mounted(to))
+		return -EINVAL;
+
+	if (mnt_to->mnt.mnt_flags & MNT_LOCKED)
+		return -EINVAL;
+
+	/*
+	 * Mounting beneath the rootfs only makes sense when the
+	 * semantics of pivot_root(".", ".") are used.
+	 */
+	if (&mnt_to->mnt == current->fs->root.mnt)
+		return -EINVAL;
+	if (mnt_to->mnt_parent == current->nsproxy->mnt_ns->root)
+		return -EINVAL;
+
+	for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
+		if (p == mnt_to)
+			return -EINVAL;
+
+	/*
+	 * If the parent mount propagates to the child mount this would
+	 * mean mounting @mnt_from beneath @mnt_to and then propagating
+	 * a copy of @mnt_from on top of @mnt_to which defeats the whole
+	 * purpose of mounting beneath another mount. And also why?
+	 */
+	if (would_propagate(mnt_to->mnt_parent, mnt_to) &&
+	    is_subdir(mp->m_dentry, mnt_to->mnt.mnt_root))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int do_move_mount(struct path *old_path, struct path *new_path,
+			 bool beneath)
 {
 	struct mnt_namespace *ns;
 	struct mount *p;
@@ -2866,8 +3079,9 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	struct mountpoint *mp, *old_mp;
 	int err;
 	bool attached;
+	mnt_tree_flags_t flags = 0;
 
-	mp = lock_mount(new_path);
+	mp = do_lock_mount(new_path, beneath);
 	if (IS_ERR(mp))
 		return PTR_ERR(mp);
 
@@ -2875,6 +3089,8 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
+	if (attached)
+		flags |= MNT_TREE_MOVE;
 	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
@@ -2905,6 +3121,17 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	 */
 	if (attached && IS_MNT_SHARED(parent))
 		goto out;
+
+	if (beneath) {
+		err = can_move_mount_beneath(old_path, new_path, mp);
+		if (err)
+			goto out;
+
+		err = -EINVAL;
+		p = p->mnt_parent;
+		flags |= MNT_TREE_BENEATH;
+	}
+
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
 	 * mount which is shared.
@@ -2918,8 +3145,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 		if (p == old)
 			goto out;
 
-	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   attached);
+	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
 	if (err)
 		goto out;
 
@@ -2951,7 +3177,7 @@ static int do_move_mount_old(struct path *path, const char *old_name)
 	if (err)
 		return err;
 
-	err = do_move_mount(&old_path, path);
+	err = do_move_mount(&old_path, path, false);
 	path_put(&old_path);
 	return err;
 }
@@ -3117,13 +3343,10 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 		err = -ENOENT;
 		goto discard_locked;
 	}
-	rcu_read_lock();
-	if (unlikely(__lookup_mnt(path->mnt, dentry))) {
-		rcu_read_unlock();
+	if (path_overmounted(path)) {
 		err = 0;
 		goto discard_locked;
 	}
-	rcu_read_unlock();
 	mp = get_mountpoint(dentry);
 	if (IS_ERR(mp)) {
 		err = PTR_ERR(mp);
@@ -3815,6 +4038,10 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & ~MOVE_MOUNT__MASK)
 		return -EINVAL;
 
+	if ((flags & (MOVE_MOUNT_BENEATH | MOVE_MOUNT_SET_GROUP)) ==
+	    (MOVE_MOUNT_BENEATH | MOVE_MOUNT_SET_GROUP))
+		return -EINVAL;
+
 	/* If someone gives a pathname, they aren't permitted to move
 	 * from an fd that requires unmount as we can't get at the flag
 	 * to clear it afterwards.
@@ -3844,7 +4071,8 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_SET_GROUP)
 		ret = do_set_group(&from_path, &to_path);
 	else
-		ret = do_move_mount(&from_path, &to_path);
+		ret = do_move_mount(&from_path, &to_path,
+				    (flags & MOVE_MOUNT_BENEATH));
 
 out_to:
 	path_put(&to_path);
@@ -3977,9 +4205,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
 	}
 	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp);
+	attach_mnt(root_mnt, old_mnt, old_mp, false);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, root_parent, root_mp);
+	attach_mnt(new_mnt, root_parent, root_mp, false);
 	mnt_add_count(root_parent, -1);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
diff --git a/fs/pnode.c b/fs/pnode.c
index 468e4e65a615..cf785bb6ab98 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -356,6 +356,31 @@ static inline int do_refcount_check(struct mount *mnt, int count)
 	return mnt_get_count(mnt) > count;
 }
 
+/**
+ * would_propagate - check whether @from would propagate mounts to @to
+ * @from: shared mount
+ * @to:   mount to check
+ *
+ * If @from propagates mounts to @to, @from and @to must either be peers
+ * or one of the masters in the hierarchy of masters of @to must be a
+ * peer of @from.
+ *
+ * Context: This function expects namespace_lock() to be held.
+ * Return: If @from propagates to @to, true is returned, false if not.
+ */
+bool would_propagate(struct mount *from, struct mount *to)
+{
+	if (!IS_MNT_SHARED(from))
+		return false;
+
+	for (struct mount *m = to; m; m = m->mnt_master) {
+		if (peers(from, m))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * check if the mount 'mnt' can be unmounted successfully.
  * @mnt: the mount to be checked for unmount
diff --git a/fs/pnode.h b/fs/pnode.h
index 988f1aa9b02a..92be06b64c13 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -53,4 +53,5 @@ struct mount *copy_tree(struct mount *, struct dentry *, int);
 bool is_path_reachable(struct mount *, struct dentry *,
 			 const struct path *root);
 int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
+bool would_propagate(struct mount *from, struct mount *to);
 #endif /* _LINUX_PNODE_H */
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4d93967f8aea..8eb0d7b758d2 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -74,7 +74,8 @@
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
 #define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
-#define MOVE_MOUNT__MASK		0x00000177
+#define MOVE_MOUNT_BENEATH		0x00000200 /* Mount beneath top mount */
+#define MOVE_MOUNT__MASK		0x00000377
 
 /*
  * fsopen() flags.

-- 
2.34.1

