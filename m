Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302676CC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjHBL5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjHBL50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2F271F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E538D61948
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749A6C433C7;
        Wed,  2 Aug 2023 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977443;
        bh=RFH1kJg9NvBpJQ3+1ZvVNxdDp0hoyqkouxzdt7ChuxQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IVvay0GswugZMmx79mqht772gELWYqnntIEmaCkImHir325SjkgzNLx991EvscP6j
         SDiOOu4m7+ilviZ5VkeG9rpGOuNAd7p7eK/qCWpimZhB+AeVv3TEUNhsZRFeAZ/n7f
         hfG55vf2Rfes7i2c1us3D7MvNogciGZqCOkCM7xhV1qduHpZ3DqOTiO0wmKCBzkdUg
         xObNUXlZxvAzDjOyw8UPEq623yE6YvTpterY1od0zKO1+pYM8F1xc5/LBYg8WdDIpm
         tZKzRml0eHmKkgI69D0rsCNyv1+F0bv43hGNKvHdk69A2EyRE5Rd+lw08XWOJRyf+0
         6ur6P0k3QJFqw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 02 Aug 2023 13:57:06 +0200
Subject: [PATCH v2 4/4] fs: add FSCONFIG_CMD_CREATE_EXCL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-vfs-super-exclusive-v2-4-95dc4e41b870@kernel.org>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=14276; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RFH1kJg9NvBpJQ3+1ZvVNxdDp0hoyqkouxzdt7ChuxQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSccpmusLFfQ+C5oU1K1K2nUx/teyLpV/LjQvSCSXc4GKwK
 j9lqdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8hbD/6BM95Umjup2JZaL3LY9/R
 zY+4d9jlSJyvV2uWv5+Vs1JzMyfBK22G0bUPdu38KTtc+e2ghM0jHNXLe43Lbs5mTuLQUbOAA=
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

Summary
=======

This introduces FSCONFIG_CMD_CREATE_EXCL which will allows userspace to
implement something like mount -t ext4 --exclusive /dev/sda /B which
fails if a superblock for the requested filesystem does already exist:

Before this patch
-----------------

$ sudo ./move-mount -f xfs -o source=/dev/sda4 /A
Requesting filesystem type xfs
Mount options requested: source=/dev/sda4
Attaching mount at /A
Moving single attached mount
Setting key(source) with val(/dev/sda4)

$ sudo ./move-mount -f xfs -o source=/dev/sda4 /B
Requesting filesystem type xfs
Mount options requested: source=/dev/sda4
Attaching mount at /B
Moving single attached mount
Setting key(source) with val(/dev/sda4)

After this patch with --exclusive as a switch for FSCONFIG_CMD_CREATE_EXCL
--------------------------------------------------------------------------

$ sudo ./move-mount -f xfs --exclusive -o source=/dev/sda4 /A
Requesting filesystem type xfs
Request exclusive superblock creation
Mount options requested: source=/dev/sda4
Attaching mount at /A
Moving single attached mount
Setting key(source) with val(/dev/sda4)

$ sudo ./move-mount -f xfs --exclusive -o source=/dev/sda4 /B
Requesting filesystem type xfs
Request exclusive superblock creation
Mount options requested: source=/dev/sda4
Attaching mount at /B
Moving single attached mount
Setting key(source) with val(/dev/sda4)
Device or resource busy | move-mount.c: 300: do_fsconfig: i xfs: reusing existing filesystem not allowed

Details
=======

As mentioned on the list (cf. [1]-[3]) mount requests like
mount -t ext4 /dev/sda /A are ambigous for userspace. Either a new
superblock has been created and mounted or an existing superblock has
been reused and a bind-mount has been created.

This becomes clear in the following example where two processes create
the same mount for the same block device:

P1                                                              P2
fd_fs = fsopen("ext4");                                         fd_fs = fsopen("ext4");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");     fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "dax", "always");          fsconfig(fd_fs, FSCONFIG_SET_STRING, "resuid", "1000");

// wins and creates superblock
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
                                                                // finds compatible superblock of P1
                                                                // spins until P1 sets SB_BORN and grabs a reference
                                                                fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)

fd_mnt1 = fsmount(fd_fs);                                       fd_mnt2 = fsmount(fd_fs);
move_mount(fd_mnt1, "/A")                                       move_mount(fd_mnt2, "/B")

Not just does P2 get a bind-mount but the mount options that P2
requestes are silently ignored. The VFS itself doesn't, can't and
shouldn't enforce filesystem specific mount option compatibility. It
only enforces incompatibility for read-only <-> read-write transitions:

mount -t ext4       /dev/sda /A
mount -t ext4 -o ro /dev/sda /B

The read-only request will fail with EBUSY as the VFS can't just
silently transition a superblock from read-write to read-only or vica
versa without risking security issues.

To userspace this silent superblock reuse can become a security issue in
because there is currently no straightforward way for userspace to know
that they did indeed manage to create a new superblock and didn't just
reuse an existing one.

This adds a new FSCONFIG_CMD_CREATE_EXCL command to fsconfig() that
returns EBUSY if an existing superblock would be reused. Userspace that
needs to be sure that it did create a new superblock with the requested
mount options can request superblock creation using this command. If the
command succeeds they can be sure that they did create a new superblock
with the requested mount options.

This requires the new mount api. With the old mount api it would be
necessary to plumb this through every legacy filesystem's
file_system_type->mount() method. If they want this feature they are
most welcome to switch to the new mount api.

Following is an analysis of the effect of FSCONFIG_CMD_CREATE_EXCL on
each high-level superblock creation helper:

(1) get_tree_nodev()

    Always allocate new superblock. Hence, FSCONFIG_CMD_CREATE and
    FSCONFIG_CMD_CREATE_EXCL are equivalent.

    The binderfs or overlayfs filesystems are examples.

(4) get_tree_keyed()

    Finds an existing superblock based on sb->s_fs_info. Hence,
    FSCONFIG_CMD_CREATE would reuse an existing superblock whereas
    FSCONFIG_CMD_CREATE_EXCL would reject it with EBUSY.

    The mqueue or nfsd filesystems are examples.

(2) get_tree_bdev()

    This effectively works like get_tree_keyed().

    The ext4 or xfs filesystems are examples.

(3) get_tree_single()

    Only one superblock of this filesystem type can ever exist.
    Hence, FSCONFIG_CMD_CREATE would reuse an existing superblock
    whereas FSCONFIG_CMD_CREATE_EXCL would reject it with EBUSY.

    The securityfs or configfs filesystems are examples.

    Note that some single-instance filesystems never destroy the
    superblock once it has been created during the first mount. For
    example, if securityfs has been mounted at least onces then the
    created superblock will never be destroyed again as long as there is
    still an LSM making use it. Consequently, even if securityfs is
    unmounted and the superblock seemingly destroyed it really isn't
    which means that FSCONFIG_CMD_CREATE_EXCL will continue rejecting
    reusing an existing superblock.

    This is acceptable thugh since special purpose filesystems such as
    this shouldn't have a need to use FSCONFIG_CMD_CREATE_EXCL anyway
    and if they do it's probably to make sure that mount options aren't
    ignored.

Following is an analysis of the effect of FSCONFIG_CMD_CREATE_EXCL on
filesystems that make use of the low-level sget_fc() helper directly.
They're all effectively variants on get_tree_keyed(), get_tree_bdev(),
or get_tree_nodev():

(5) mtd_get_sb()

    Similar logic to get_tree_keyed().

(6) afs_get_tree()

    Similar logic to get_tree_keyed().

(7) ceph_get_tree()

    Similar logic to get_tree_keyed().

    Already explicitly allows forcing the allocation of a new superblock
    via CEPH_OPT_NOSHARE. This turns it into get_tree_nodev().

(8) fuse_get_tree_submount()

    Similar logic to get_tree_nodev().

(9) fuse_get_tree()

    Forces reuse of existing FUSE superblock.

    Forces reuse of existing superblock if passed in file refers to an
    existing FUSE connection.
    If FSCONFIG_CMD_CREATE_EXCL is specified together with an fd
    referring to an existing FUSE connections this would cause the
    superblock reusal to fail. If reusing is the intent then
    FSCONFIG_CMD_CREATE_EXCL shouldn't be specified.

(10) fuse_get_tree()
     -> get_tree_nodev()

    Same logic as in get_tree_nodev().

(11) fuse_get_tree()
     -> get_tree_bdev()

    Same logic as in get_tree_bdev().

(12) virtio_fs_get_tree()

     Same logic as get_tree_keyed().

(13) gfs2_meta_get_tree()

     Forces reuse of existing gfs2 superblock.

     Mounting gfs2meta enforces that a gf2s superblock must already
     exist. If not, it will error out. Consequently, mounting gfs2meta
     with FSCONFIG_CMD_CREATE_EXCL would always fail. If reusing is the
     intent then FSCONFIG_CMD_CREATE_EXCL shouldn't be specified.

(14) kernfs_get_tree()

     Similar logic to get_tree_keyed().

(15) nfs_get_tree_common()

    Similar logic to get_tree_keyed().

    Already explicitly allows forcing the allocation of a new superblock
    via NFS_MOUNT_UNSHARED. This effectively turns it into
    get_tree_nodev().

Link: [1] https://lore.kernel.org/linux-block/20230704-fasching-wertarbeit-7c6ffb01c83d@brauner
Link: [2] https://lore.kernel.org/linux-block/20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner
Link: [3] https://lore.kernel.org/linux-fsdevel/20230725-einnahmen-warnschilder-17779aec0a97@brauner
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_context.c            |  1 +
 fs/fsopen.c                | 12 ++++++++++--
 fs/super.c                 | 33 ++++++++++++++++++++++++---------
 include/linux/fs_context.h |  1 +
 include/uapi/linux/mount.h |  3 ++-
 5 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 851214d1d013..30d82d2979af 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -692,6 +692,7 @@ void vfs_clean_context(struct fs_context *fc)
 	security_free_mnt_opts(&fc->security);
 	kfree(fc->source);
 	fc->source = NULL;
+	fc->exclusive = false;
 
 	fc->purpose = FS_CONTEXT_FOR_RECONFIGURE;
 	fc->phase = FS_CONTEXT_AWAITING_RECONF;
diff --git a/fs/fsopen.c b/fs/fsopen.c
index a69b7c9cc59c..ce03f6521c88 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -209,7 +209,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	return ret;
 }
 
-static int vfs_cmd_create(struct fs_context *fc)
+static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
 {
 	struct super_block *sb;
 	int ret;
@@ -220,7 +220,12 @@ static int vfs_cmd_create(struct fs_context *fc)
 	if (!mount_capable(fc))
 		return -EPERM;
 
+	/* require the new mount api */
+	if (exclusive && fc->ops == &legacy_fs_context_ops)
+		return -EOPNOTSUPP;
+
 	fc->phase = FS_CONTEXT_CREATING;
+	fc->exclusive = exclusive;
 
 	ret = vfs_get_tree(fc);
 	if (ret) {
@@ -284,7 +289,9 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 		return ret;
 	switch (cmd) {
 	case FSCONFIG_CMD_CREATE:
-		return vfs_cmd_create(fc);
+		return vfs_cmd_create(fc, false);
+	case FSCONFIG_CMD_CREATE_EXCL:
+		return vfs_cmd_create(fc, true);
 	case FSCONFIG_CMD_RECONFIGURE:
 		return vfs_cmd_reconfigure(fc);
 	default:
@@ -381,6 +388,7 @@ SYSCALL_DEFINE5(fsconfig,
 			return -EINVAL;
 		break;
 	case FSCONFIG_CMD_CREATE:
+	case FSCONFIG_CMD_CREATE_EXCL:
 	case FSCONFIG_CMD_RECONFIGURE:
 		if (_key || _value || aux)
 			return -EINVAL;
diff --git a/fs/super.c b/fs/super.c
index 9aaf0fbad036..8eeebd8c4573 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -546,17 +546,28 @@ bool mount_capable(struct fs_context *fc)
  * @test: Comparison callback
  * @set: Setup callback
  *
- * Find or create a superblock using the parameters stored in the filesystem
- * context and the two callback functions.
+ * Create a new superblock or find an existing one.
  *
- * If an extant superblock is matched, then that will be returned with an
- * elevated reference count that the caller must transfer or discard.
+ * The @test callback is used to find a matching existing superblock.
+ * Whether or not the requested parameters in @fc are taken into account
+ * is specific to the @test callback that is used. They may even be
+ * completely ignored.
+ *
+ * If an extant superblock is matched, it will be returned unless:
+ * (1) the namespace the filesystem context @fc and the extant
+ *     superblock's namespace differ
+ * (2) the filesystem context @fc has requested that reusing an extant
+ *     superblock is not allowed
+ * In both cases EBUSY will be returned.
  *
  * If no match is made, a new superblock will be allocated and basic
- * initialisation will be performed (s_type, s_fs_info and s_id will be set and
- * the set() callback will be invoked), the superblock will be published and it
- * will be returned in a partially constructed state with SB_BORN and SB_ACTIVE
- * as yet unset.
+ * initialisation will be performed (s_type, s_fs_info and s_id will be
+ * set and the @set callback will be invoked), the superblock will be
+ * published and it will be returned in a partially constructed state
+ * with SB_BORN and SB_ACTIVE as yet unset.
+ *
+ * Return: On success, an extant or newly created superblock is
+ *         returned. On failure an error pointer is returned.
  */
 struct super_block *sget_fc(struct fs_context *fc,
 			    int (*test)(struct super_block *, struct fs_context *),
@@ -603,9 +614,13 @@ struct super_block *sget_fc(struct fs_context *fc,
 	return s;
 
 share_extant_sb:
-	if (user_ns != old->s_user_ns) {
+	if (user_ns != old->s_user_ns || fc->exclusive) {
 		spin_unlock(&sb_lock);
 		destroy_unused_super(s);
+		if (fc->exclusive)
+			warnfc(fc, "reusing existing filesystem not allowed");
+		else
+			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
 		return ERR_PTR(-EBUSY);
 	}
 	if (!grab_super(old))
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 851b3fe2549c..a33a3b1d9016 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -109,6 +109,7 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool			exclusive:1;    /* create new superblock, reject existing one */
 };
 
 struct fs_context_operations {
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 8eb0d7b758d2..bb242fdcfe6b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -100,8 +100,9 @@ enum fsconfig_command {
 	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
 	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
 	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
-	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
+	FSCONFIG_CMD_CREATE	= 6,	/* Create new or reuse existing superblock */
 	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
+	FSCONFIG_CMD_CREATE_EXCL = 8,	/* Create new superblock, fail if reusing existing superblock */
 };
 
 /*

-- 
2.34.1

