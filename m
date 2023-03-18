Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611296BFB58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCRPxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRPxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217F19AF
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ABF160EBF
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDEC4339E;
        Sat, 18 Mar 2023 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154780;
        bh=1VKVtUctMUHVoNJu1dmmljIq4Ret/remT9MFCPHe8XY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BTkNazpmzaRtoKodOoaBM4DwH2iiBvJbUv03l2YgaxmXx3RQzizU50EWxsMAkDNu7
         JWz4TnCsfE0mQraCDxj7bf/knGPHU6OMC859SxxjUF9qDBsgn5LLXV8VrmkIVgO2KD
         zUSEz16S3p6vjiOYKljSR23WERscyrTu/noK9Sz0ryjkFiAWGDDfjRw5uxSt8kofdV
         oQgeyqAmcy6SP+Uul260BIP51Uf8EzS7NW/pGC7ufCXR9ex09Mm8JAkDPK7ilQF3dZ
         vNQRRWTK0dTcoGr2aBx1pvfWlSvx9+wFbNwYHfvHnOHqxXHZavTflPxK4PYy5feXy/
         y6937nrHM2F3w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 18 Mar 2023 16:52:01 +0100
Subject: [PATCH RFC 5/5] fs: allow to tuck mounts explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230202-fs-move-mount-replace-v1-5-9b73026d5f10@kernel.org>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=28109; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1VKVtUctMUHVoNJu1dmmljIq4Ret/remT9MFCPHe8XY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gsOUV9uHpigpXDCrFVvl0fShp7r9yZ/4glbpVTuvEBj
 81LbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0pTEy/GCsmqGQ3pY1X7aQr6qSo6
 TPLnmugkd3psHv/MCodfYBjAwb134KWeKRI5b5Y/lamdWKP9i57VVvNSzhej133Y+A+1KcAA==
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
 fs/namespace.c             | 231 ++++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/mount.h |   3 +-
 2 files changed, 207 insertions(+), 27 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7f22fcfd8eab..93f8902c6589 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -935,6 +935,62 @@ static void attach_mnt(struct mount *mnt,
 	__attach_mnt(mnt, parent);
 }
 
+/**
+ * mnt_tuck_mountpoint - tuck a mount beneath another one
+ *
+ * @tucked_mnt: the mount to tuck
+ * @top_mnt:	the mount to tuck @tucked_mnt under
+ * @tucked_mp:	the new mountpoint of @top_mnt on @tucked_mnt
+ *
+ * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
+ * parent @top_mnt->mnt_parent and mount it on top of @tucked_mnt at
+ * @tucked_mp. And mount @tucked_mnt on the old parent and old
+ * mountpoint of @top_mnt.
+ *
+ * Note that we keep the reference count in tact when we remove @top_mnt
+ * from its old mountpoint and parent to prevent UAF issues. Once we've
+ * mounted @top_mnt on @tucked_mnt the reference count gets bumped once
+ * more. So make sure that we drop it to not leak the mount and
+ * mountpoint.
+ */
+static void mnt_tuck_mountpoint(struct mount *tucked_mnt, struct mount *top_mnt,
+				struct mountpoint *tucked_mp)
+{
+	struct mount *old_top_parent = top_mnt->mnt_parent;
+	struct mountpoint *old_top_mp;
+
+	old_top_mp = unhash_mnt(top_mnt);
+	attach_mnt(top_mnt, tucked_mnt, tucked_mp);
+	mnt_set_mountpoint(old_top_parent, old_top_mp, tucked_mnt);
+	put_mountpoint(old_top_mp);
+	mnt_add_count(old_top_parent, -1);
+}
+
+/**
+ * tuck_mnt - tuck a mount beneath another one, attach to
+ *            @mount_hashtable and parent's list of child mounts
+ *
+ * @tucked_mnt: the mount to tuck
+ * @top_mnt:	the mount to tuck @tucked_mnt under
+ * @tucked_mp:	the new mountpoint of @top_mnt on @tucked_mnt
+ *
+ * Remove @top_mnt from its current parent and mountpoint and mount it
+ * on @tucked_mp on @tucked_mnt, and mount @tucked_mnt on the old
+ * parent and old mountpoint of @top_mnt. Finally, attach @tucked_mnt
+ * mount to @mnt_hashtable and @tucked_mnt->mnt_parent->mnt_mounts.
+ *
+ * Note, when we call __attach_mnt() we've already mounted @tucked_mnt
+ * on top of @top_mnt's old parent so @tucked_mnt->mnt_parent will point
+ * to the correct parent.
+ */
+static void tuck_mnt(struct mount *tucked_mnt,
+		     struct mount *top_mnt,
+		     struct mountpoint *tucked_mp)
+{
+	mnt_tuck_mountpoint(tucked_mnt, top_mnt, tucked_mp);
+	__attach_mnt(tucked_mnt, tucked_mnt->mnt_parent);
+}
+
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
 {
 	struct mountpoint *old_mp = mnt->mnt_mp;
@@ -2154,12 +2210,16 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 	return 0;
 }
 
+typedef enum mnt_tree_flags_t {
+	MNT_TREE_MOVE	= BIT(0),
+	MNT_TREE_TUCK	= BIT(1),
+} mnt_tree_flags_t;
+
 /*
  *  @source_mnt : mount tree to be attached
- *  @nd         : place the mount tree @source_mnt is attached
- *  @parent_nd  : if non-null, detach the source_mnt from its parent and
- *  		   store the parent mount and mountpoint dentry.
- *  		   (done when source_mnt is moved)
+ *  @top_mnt	: mount that @source_mnt will be mounted on or tucked under
+ *  @dest_mp	: the mountpoint @source_mnt will be mounted at
+ *  @flags	: modify how @source_mnt is supposed to be attached
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -2218,17 +2278,18 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
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
+	bool moving = flags & MNT_TREE_MOVE, tuck = flags & MNT_TREE_TUCK;
 
 	/* Preallocate a mountpoint in case the new mounts need
 	 * to be tucked under other mounts.
@@ -2244,29 +2305,48 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			goto out;
 	}
 
+	if (tuck)
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
+	/* Recheck with lock_mount_hash() held. */
+	if (tuck && IS_MNT_LOCKED(top_mnt)) {
+		err = -EINVAL;
+		goto out_cleanup_ids;
+	}
+
+	if (IS_MNT_SHARED(dest_mnt)) {
 		for (p = source_mnt; p; p = next_mnt(p, source_mnt))
 			set_mnt_shared(p);
-	} else {
-		lock_mount_hash();
 	}
+
 	if (moving) {
 		unhash_mnt(source_mnt);
-		attach_mnt(source_mnt, dest_mnt, dest_mp);
+		if (tuck)
+			tuck_mnt(source_mnt, top_mnt, smp);
+		else
+			attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
 			/* move from anon - the caller will destroy */
 			list_del_init(&source_mnt->mnt_ns->list);
 		}
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+		if (tuck)
+			mnt_tuck_mountpoint(source_mnt, top_mnt, smp);
+		else
+			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		commit_tree(source_mnt);
 	}
 
@@ -2306,14 +2386,35 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	return err;
 }
 
-static struct mountpoint *lock_mount(struct path *path)
+/**
+ * lock_mount_mountpoint - lock mount and mountpoint
+ * @path: target path
+ * @tuck: whether we intend to tuck a mount beneath @path
+ *
+ * Follow the mount stack on @path until the top mount is found.
+ *
+ * If we intend to mount on top of @path->mnt acquire the inode_lock()
+ * for the top mount's ->mnt_root to protect against concurrent removal
+ * of our prospective mountpoint from another mount namespace.
+ *
+ * If we intend to tuck beneath the top mount @m acquire the
+ * inode_lock() on @m's mountpoint @mp on @m->mnt_parent. Otherwise we
+ * risk racing with someone who unlinked @mp from another mount
+ * namespace where @m doesn't have a child mount mounted @mp. We don't
+ * care if @m->mnt_root/@path->dentry is removed (as long as
+ * @path->dentry isn't equal to @m->mnt_mountpoint of course).
+ *
+ * Return: Either the target mountpoint on the top mount or the top
+ *         mount's mountpoint.
+ */
+static struct mountpoint *lock_mount_mountpoint(struct path *path, bool tuck)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct mountpoint *mp;
 
 	for (;;) {
-		dentry = path->dentry;
+		dentry = tuck ? real_mount(mnt)->mnt_mountpoint : path->dentry;
 		inode_lock(dentry->d_inode);
 		if (unlikely(cant_mount(dentry))) {
 			inode_unlock(dentry->d_inode);
@@ -2343,6 +2444,11 @@ static struct mountpoint *lock_mount(struct path *path)
 	return mp;
 }
 
+static inline struct mountpoint *lock_mount(struct path *path)
+{
+	return lock_mount_mountpoint(path, false);
+}
+
 static void unlock_mount(struct mountpoint *where)
 {
 	struct dentry *dentry = where->m_dentry;
@@ -2364,7 +2470,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, false);
+	return attach_recursive_mnt(mnt, p, mp, 0);
 }
 
 /*
@@ -2849,7 +2955,64 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 	return err;
 }
 
-static int do_move_mount(struct path *old_path, struct path *new_path)
+/**
+ * can_tuck_mount - check that we can tuck a mount
+ * @from: mount to tuck under
+ * @to:   mount under which to tuck
+ *
+ * - Make sure that the mount to tuck under isn't a shared mount so we
+ *   force the kernel to allocate a new peer group id. This simplifies
+ *   the mount trees that can be created and limits propagation events
+ *   in cases where @to, and/or @to->mnt_parent are in the same peer
+ *   group. Something that's a nuisance already today.
+ * - Make sure that @to->dentry is actually the root of a mount under
+ *   which we can tuck another mount.
+ * - Make sure that nothing can be tucked under the caller's current
+ *   root or the rootfs of the namespace.
+ * - Make sure that the caller can unmount the topmost mount ensuring
+ *   that the caller could reveal the underlying mountpoint.
+ *
+ * Return: On success 0, and on error a negative error code is returned.
+ */
+static int can_tuck_mount(struct path *from, struct path *to)
+{
+	struct mount *mnt_from = real_mount(from->mnt),
+		     *mnt_to = real_mount(to->mnt);
+
+	if (!check_mnt(mnt_to))
+		return -EINVAL;
+
+	if (!mnt_has_parent(mnt_to))
+		return -EINVAL;
+
+	if (IS_MNT_SHARED(mnt_from))
+		return -EINVAL;
+
+	if (!path_mounted(to))
+		return -EINVAL;
+
+	if (mnt_from == mnt_to)
+		return -EINVAL;
+
+	/*
+	 * Tucking a mount beneath the rootfs only makes sense when the
+	 * tuck semantics of pivot_root(".", ".") are used.
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
+	/* Ensure the caller could reveal the underlying mount. */
+	return can_umount(to, 0);
+}
+
+static int do_move_mount(struct path *old_path, struct path *new_path,
+			 bool tuck)
 {
 	struct mnt_namespace *ns;
 	struct mount *p;
@@ -2858,8 +3021,9 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	struct mountpoint *mp, *old_mp;
 	int err;
 	bool attached;
+	mnt_tree_flags_t flags = 0;
 
-	mp = lock_mount(new_path);
+	mp = lock_mount_mountpoint(new_path, tuck);
 	if (IS_ERR(mp))
 		return PTR_ERR(mp);
 
@@ -2867,9 +3031,20 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
+	if (attached)
+		flags |= MNT_TREE_MOVE;
 	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
+	if (tuck) {
+		err = can_tuck_mount(old_path, new_path);
+		if (err)
+			goto out;
+
+		p = p->mnt_parent;
+		flags |= MNT_TREE_TUCK;
+	}
+
 	err = -EINVAL;
 	/* The mountpoint must be in our namespace. */
 	if (!check_mnt(p))
@@ -2910,8 +3085,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 		if (p == old)
 			goto out;
 
-	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   attached);
+	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
 	if (err)
 		goto out;
 
@@ -2943,7 +3117,7 @@ static int do_move_mount_old(struct path *path, const char *old_name)
 	if (err)
 		return err;
 
-	err = do_move_mount(&old_path, path);
+	err = do_move_mount(&old_path, path, false);
 	path_put(&old_path);
 	return err;
 }
@@ -3807,6 +3981,10 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & ~MOVE_MOUNT__MASK)
 		return -EINVAL;
 
+	if ((flags & (MOVE_MOUNT_TUCK | MOVE_MOUNT_SET_GROUP)) ==
+	    (MOVE_MOUNT_TUCK | MOVE_MOUNT_SET_GROUP))
+		return -EINVAL;
+
 	/* If someone gives a pathname, they aren't permitted to move
 	 * from an fd that requires unmount as we can't get at the flag
 	 * to clear it afterwards.
@@ -3836,7 +4014,8 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_SET_GROUP)
 		ret = do_set_group(&from_path, &to_path);
 	else
-		ret = do_move_mount(&from_path, &to_path);
+		ret = do_move_mount(&from_path, &to_path,
+				    (flags & MOVE_MOUNT_TUCK));
 
 out_to:
 	path_put(&to_path);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4d93967f8aea..751089e3e0bd 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -74,7 +74,8 @@
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
 #define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
-#define MOVE_MOUNT__MASK		0x00000177
+#define MOVE_MOUNT_TUCK			0x00000200 /* tuck mount */
+#define MOVE_MOUNT__MASK		0x00000377
 
 /*
  * fsopen() flags.

-- 
2.34.1

