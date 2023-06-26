Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA673E1EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFZOTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjFZOS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8312107;
        Mon, 26 Jun 2023 07:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7769A60E97;
        Mon, 26 Jun 2023 14:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61542C433C8;
        Mon, 26 Jun 2023 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687789030;
        bh=BOzC/zp900A38XZK7DqrLUshoDl3W3HHt/1PX0OCZlM=;
        h=From:Subject:Date:To:Cc:From;
        b=j+o3JYQLjU1j7B91+xXv5ToOou8YorIO7/1rhaYcMJiqK+GIJa5dFGQBifYb+tmdT
         abXcob7ba3OKBihm4WTroV+mCADGAGoBgUTv8GGqTpj7AYJPOWz6wwPS7Sl8lTODRN
         lljJicJuMX8qsQqkmX8CT1ybtmfLBvuZv86iXYp0DUvCqfNc+P+ZudqplyPmNHXpDM
         r6s+yOzvXgGzL9dMhjFtJ255l5Tu1LrspPA1WH48OxC/5FHTsd7N3670M7eSiaN+La
         nLY/eAzvoU2H/7444YGAPSe/Lx9eS2FKLvMtCbYPOn122bWzbDfbaTr03fw7Dwuoa/
         MKWA9etXA856g==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] btrfs: port to new mount api
Date:   Mon, 26 Jun 2023 16:16:49 +0200
Message-Id: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGdmWQC/x2NQQrCMBBFr1Jm7dSkNqF4FXGRpBM7qEmZVBFK7
 27azYcH//FWKCRMBa7NCkJfLpxTBX1qIEwuPQh5rAyd6i7KaoOxoF+k7jt/0oJuZhxVPwy6t0Z
 7BVX0rhB6cSlMu+pfOTzbmAVta84H7a9ZKPLvSN/u2/YHRqZ4UooAAAA=
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=12817; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BOzC/zp900A38XZK7DqrLUshoDl3W3HHt/1PX0OCZlM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMnPtEQuZVl2muv0+13JTo9e8dV3+ZkcF4afKqgm33i3TF
 9BeGdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkVxrDf/eVK28tFr+ociftXUW7xq
 Ejgg4yYbq1s+atqjbaY//3UiDDf1fbbwtPP1r02P3iKROzlKhwRaaaQM+ZK9yPcUZI7XnOxAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This ports btrfs to the new mount api.

This passes xfstests for me with a single failure:

Failures: btrfs/277
Failed 1 of 821 tests

which warns about FS_IOC_MEASURE_VERITY failing on
'/mnt/scratch/subv/file.fsv' with ENODATA.

This whole thing ends up being close to a rewrite in some places. I
haven't found a really elegant way to split this into smaller chunks.
Such ports to the new mount api are rather clunky and chunky in general.
My last port for overlayfs was big even after splitting it up with the
help of preparatory patches from the maintainers.

I've done my best to make this somewhat workable but I've retained a lot
of the old structure where possible. There's probably more cleanup
possible in the future based on this.

This is curently based on Jens' for-6.5/block to minimize conflicts with
Christoph's changes to how the exclusive holder of a device is indicated
which changes the signatures for various bdev helpers. This should be
merged early this week.

Structural changes
==================

Structurally, this adds two new files param.{c,h} which contain most
code for the new mount api including all parameter parsing, superblock
creation logic, parameter verification and so on.

This allows us to keep everything related to fs_context handling hidden
and inaccessible to other pieces of the codebase that really shouldn't
need to know anything about this.

We only expose the following types and helpers to super.c which are
required for fs_context handling in btrfs:

(1) a struct fs_parameter_spec defining all supported mount options
(2) a helper to verify a set of paramters after the on-disk superblock
    has been read into memory
(3) a ->get_tree() helper responsible for creating a new or finding a
    matching existing superblock
(4) a ->init_fs_context() helper responsible to initialize internal data
    structures for a newly created btrfs fs_context

The super.{c,h} file only exposes the btrfs_fill_super() helper which is
used in the btrfs ->get_tree() helper when a new superblock is created
and needs to be initialized.

Parameter parsing and on-disk superblock information availability
=================================================================

There are big semantical differences between the new and old mount api
that have consequences for how mounting a btrfs instance works.

The old mount uses a single system call that does parameter parsing and
superblock creation in one step. This means a filesystem was free to
choose to read a superblock from disk before parsing mount parameters.

By defering mount parameter parsing after reading the on-disk superblock
into memory and allocating internal data structures to be stashed in
sb->s_fs_info, it was possible to take on-disk superblock information
into account during parameter parsing.

The new mount api splits parameter parsing and superblock creation into
distinct system calls. A new superblock is only created after all
parameter parsing has finished and this order is enforced by the VFS.

Btrfs was one of the filesystems who had such a parameter parsing order:

        btrfs_mount_root()
        -> btrfs_fill_super()
           -> open_ctree()
               -> memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy))
               -> btrfs_parse_options()

This has two main consequences:

(1) This has the consequences that struct btrfs_fs_info->super_copy was
    always initialized and available during superblock creation when
    btrfs_parse_options() was called. Thus, it was possible to check for
    various defaults set on sb->s_fs_info right at mount parameter
    parsing time.
(2) btrfs_parse_options() didn't really need to distinguish between a
    remount and a new superblock creation because in both cases a valid
    sb->s_fs_info was set and initialized.

This doesn't work with the new mount api. When parameter parsing happens
the on-disk superblock will not have been read into memory. This isn't a
problem though as parameter parsing can happen with a separate
verification step of the mount parameters after the superblock has been
created in ->get_tree() and the on-disk superblock has been read into
memory. This verification is done in btrfs_fs_params_verify(). All
filesystems supporting the new mount api more or less do it this way.

Introduction of struct btrfs_fs_context
=======================================

To clearly separate the parameter parsing context from the final
superblock info context stashed in sb->s_fs_info a new struct
btrfs_fs_context is introduced. This context is used during parameter
parsing and superblock creation or reconfiguration to hold information
about the requested mount options. The new mount api specifically has
design for this via the fc->fs_private member where this struct
btrfs_fs_context is stashed. The new context is allocated in
btrfs_init_fs_context() which initializes new btrfs context whenever a
new btrfs mount or a remount is requested.

After the verification step the mount information stashed in struct
btrfs_fs_context is committed to struct btrfs_fs_info which is stashed
in sb->s_fs_info:

* If a new superblock is created no existing mount information and
  struct btrfs_fs_info information exists. So we're starting with a
  blank sheet when parsing parameters.
* If a remount is requested we transfer the existing mount information
  from struct btrfs_fs_info into the btrfs_fs_context during
  btrfs_init_fs_context() so that information is available for parameter
  parsing. This is crucial to correctly handle mount option changes.

Subtree (subvolume) mounting - Part I
=====================================

Subtree mounting basically amounts to swapping out the root dentry for a
given superblock so that only a part of the filesystem is exposed when a
mount is created for it.

For this to work a superblock and a mount for the superblock must be
created so that the dentry for the subtree can be looked up in the
filesystem. Afterwards the mount for the superblock can be discarded and
the root dentry swapped out for the subtree dentry. Easy peasy...

The current btrfs code is mucho convoluted though tbh. Two different
btrfs filesystem types exist with the justification that having the
second filesystem type making things easier to follow. Without throwing
shade on anyone but I'm not really seeing that. It's a bit clumsy.

In any case, we need to kill this for the new mount api anyway and I
hopefully ended up with something cleaner.

As part of the port to the new mount api the reliance on
vfs_kern_mount() is removed and thus the need for a second separate
filesystem type. The callchain now is:

-> btrfs_init_fs_context() # main filesystem context
   -> btrfs_get_tree()
      -> btrfs_get_tree_common()
         -> vfs_dup_fs_context() # superblock filesystems context
            -> fc_mount()
               -> btrfs_get_tree_super()
         -> mount_subvol()

An enum indicator for the phase of the mount is kept in struct
btrfs_fs_context. A second, separate filesystem context is created that
only exists for the creation of the superblock leaving the original
filesystem context pristine.

However, the struct btrfs_fs_context is shared between the two filesytem
context via a simple refcount which is a very lightweight solution that
allows to share the mount context avoiding useless memory duplications.
The btrfs_fs_context is always freed by the original filesystem context
which is responsible for parameter parsing and subtree mounting.

The original filesystem context transfers all information that is only
relevant for superblock creation to the second filesystem context. This
specifically includes the source in fc->source and the security
information in fc->security.

The second filesystem context is also the one that allocates struct
btrfs_fs_info as this is the actual code that is responsible for
initializing sb->s_fs_info. The first filesystem context only handles
subtree creation and consumes the mount we created for the superblock.

Subtree (subvolume) mounting - Part II
======================================

(A good chunk of this can also be found as a comment in the code).

Ever since commit 0723a0473fb4 ("btrfs: allow mounting btrfs subvolumes
with different ro/rw options") the following works:

       (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
      (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar

which looks nice and innocent but is actually pretty intricate and
deserves a long comment.

On another filesystem a subvolume mount is close to something like:

     (iii) # create rw superblock + initial mount
           mount -t xfs /dev/sdb /opt/

           # create ro bind mount
           mount --bind -o ro /opt/foo /mnt/foo

           # unmount initial mount
           umount /opt

Of course, there's some special subvolume sauce and there's the fact
that the sb->s_root dentry is really swapped after mount_subtree(). But
conceptually it's very close and will help us understand the issue.

The old mount api didn't cleanly distinguish between a mount being made
ro and a superblock being made ro. The only way to change the ro state
of either object was by passing MS_RDONLY. If a new mount was created
via mount(2) such as:

     mount("/dev/sdb", "/mnt", "xfs", MS_RDONLY, NULL);

the MS_RDONLY flag being specified had two effects:

(1) MNT_READONLY was raised -> the resulting mount got
    @mnt->mnt_flags |= MNT_READONLY raised.

(2) MS_RDONLY was passed to the filesystem's mount method and the
    filesystems made the superblock ro. Note, how SB_RDONLY has the same
    value as MS_RDONLY and is raised whenever MS_RDONLY is passed
    through mount(2).

Creating a subtree mount via (iii) ends up leaving a rw superblock with
a subtree mounted ro.

But consider the effect of the old mount api on btrfs subvolume mounting
which combines the distinct steps in (iii) into a a single step.

By first issuing (i) both the mount and the superblock are turned ro due
to (1) and (2). Now when (ii) is issued the superblock is ro and thus
even if the mount created for (ii) is rw it wouldn't help.

Hence, for subtree mounting to work correctly, btrfs needed to
transition the superblock from ro to rw for (ii). It did this using an
internal remount call (a bold choice...).

IOW, subvolume mounting was inherently messy due to the ambiguity of
MS_RDONLY in mount(2). Note, this ambiguity also has mount(8) always
translate "ro" to MS_RDONLY. (The only time there's a real difference is
for MS_REMOUNT | MS_BIND | MS_RDONLY.) IOW, in both (i) and (ii) "ro"
becomes MS_RDONLY when passed by mount(8) to mount(2).

The new mount api however disambiguates making a mount ro and making a
superblock ro:

(3) To turn a mount ro the MOUNT_ATTR_RDONLY flag can be used with
    either fsmount() or mount_setattr(). This is a pure VFS level change
    for a specific mount or mount tree that is never seen by the
    filesystem itself. IOW, it has no effect on the superblock.

(4) To turn a superblock ro the "ro" flag must be used with
    fsconfig(FSCONFIG_SET_FLAG, "ro"). This option is seen by the
    filesytem in fc->sb_flags.

This disambiguation has rather positive consequences. Mounting a
subvolume ro will not also turn the superblock ro. Only the mount for
the subvolume will become ro.

So, if the superblock creation request comes from the new mount api the
caller must've explicitly done something such as:

     fsconfig(FSCONFIG_SET_FLAG, "ro")
     fsmount/mount_setattr(MOUNT_ATTR_RRDONLY)

IOW, at some point the caller must have explicitly turned the whole
superblock ro and so we shouldn't just undo it like we did for the old
mount api.

So the port gets rid of this nasty internal remount hack at least for
requests coming from the new mount api.

So the remounting hack must only be used for requests originating from
the old mount api and imho should be marked for full deprecation so it
can be completely turned off in a couple of years.

The new mount api has no reason to support this. It is also a somewhat
bold choice because the VFS may very well apply additional protection
steps when transitioning a superblock from ro to rw which can easily be
missed in btrfs code.

In any case, I think we might end up with a singificantly cleaner way of
mounting a btrfs subtree after these changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---



---
base-commit: b6f3f28f604ba3de4724ad82bea6adb1300c0b5f
change-id: 20230615-fs-btrfs-mount-api-d048814651b0

