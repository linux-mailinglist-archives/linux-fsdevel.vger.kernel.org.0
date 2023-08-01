Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A376B583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHANKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHANKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0810E
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 06:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 187A2615A3
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 13:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74FAC433C9;
        Tue,  1 Aug 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690895406;
        bh=GM8MGMwj55jTJGnmSyT5FgtWtJ46Wk9lVZJZag9uTl8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=c4LqmJad27f+wRthVGI+3+H/x5MjE5aOGeQC2MmGcZDJM12w1oN6dmbdJibUnwW1t
         PTnZxp++VM3IfB7CXC+JItarlUZapJuJpA8TFenoAzSr4jjyYlMUKztnnzgL6rYdyZ
         BakRhFnWyk+SRidGteOEBNyhL2LGRJ87J937YXTpM0H94CrtDo+xUbCmIjHDsl3K9A
         /MbE8kk7ocTMZVXgTpNOIVWX/BHICcCI5Spkpa3ZFfoxMqmu4JfhCSKNqFO9gcSHTi
         uAyeVXpcXn07bY34uejzQff/KM54OzJ25YC8WURxEP/a6NqBfssM/GgDGbwTEYEA6H
         0NzbFoQI3bMdg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Aug 2023 15:09:02 +0200
Subject: [PATCH RFC 3/3] fs: add FSCONFIG_CMD_CREATE_EXCL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-vfs-super-exclusive-v1-3-1a587e56c9f3@kernel.org>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
In-Reply-To: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=12241; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GM8MGMwj55jTJGnmSyT5FgtWtJ46Wk9lVZJZag9uTl8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScZFFb4RM1qzyFVS1646dVzlpT1p7dUVDYtyLuiPTXCSf2
 GvqUdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEOJmRYZ5y1HOrruVumw6mMBndX/
 D9w0Xrnekt268c8T0e5rf6cScjw2LHqUK3Z/edrTezdN0XsKHLjy2n8FnYtjl3GTk3/izyZgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Device or resource busy | move-mount.c: 300: do_fsconfig: i xfs: reusing existing superblock not allowed

Details
=======

As mentioned on the list (cf. [1]-[3]) mount requests like
mount -t ext4 /dev/sda /A are ambigous for userspace. Either a new
superblock has been created and mounted or an existing superblock has
been reused and a bind-mount has been created.

This becomes clear if we consider two processes creating the same mount
for the same block device:

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

Not just does P2 get a bind-mount for nearly all filesystems the mount
options for P2 are usually completely ignored. The VFS itself doesn't
and shouldn't enforce filesystem specific mount option compatibility. It
only enforces incompatibility for read-only <-> read-write transitions:

mount -t ext4       /dev/sda /A
mount -t ext4 -o ro /dev/sda /B

The read-only request will fail with EBUSY as the VFS can't just
silently transition a superblock from read-write to read-only or vica
versa without risking security issues.

To userspace this silent superblock reuse can be security issue in
certain circumstances because there is currently no simple way for them
to know that they did indeed manage to create the superblock and didn't
just reuse an existing one.

This adds a new FSCONFIG_CMD_CREATE_EXCL command to fsconfig() that
returns EBUSY if an existing superblock is found. Userspace that needs
to be sure that they did create the superblock with the requested mount
options can request superblock creation using this command. If it
succeeds they can be sure that they did create the superblock with the
requested mount options.

This requires the new mount api. With the old mount api we would have to
plumb this through every legacy filesystem's file_system_type->mount()
method. If they want this feature they are most welcome to switch to the
new mount api.

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

    This has a further consequence. Some filesystems will never destroy
    the superblock once it has been created. For example, if securityfs
    is mounted the allocated superblock will never be destroyed again as
    long as there is still an LSM making use it. Consequently, even if
    securityfs is unmounted and seemingly destroyed it really isn't
    which means that FSCONFIG_CMD_CREATE_EXCL will continue rejecting
    reusing the existing superblock.

    This is unintuitive but not a problem. Such special purpose
    filesystems aren't mounted multiple times anyway.

Following is an analysis of the effect of FSCONFIG_CMD_CREATE_EXCL on
filesystems that make use of the low-level sget_fc() helper directly.
They're all effectively variants on get_tree_keyed() or get_tree_bdev():

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
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_context.c            |  1 +
 fs/fsopen.c                | 18 +++++++++++++++---
 fs/super.c                 |  4 +++-
 include/linux/fs_context.h |  1 +
 include/uapi/linux/mount.h |  3 ++-
 5 files changed, 22 insertions(+), 5 deletions(-)

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
index af2ff05dcee5..e510bc7983e8 100644
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
@@ -220,16 +220,24 @@ static int vfs_cmd_create(struct fs_context *fc)
 	if (!mount_capable(fc))
 		return -EPERM;
 
+	/* require the new mount api */
+	if (exclusive && (fc->ops == &legacy_fs_context_ops))
+		return -EOPNOTSUPP;
+
 	fc->phase = FS_CONTEXT_CREATING;
+	fc->exclusive = exclusive;
 
 	ret = vfs_get_tree(fc);
-	if (ret)
+	if (ret) {
+		fc->exclusive = false;
 		return ret;
+	}
 
 	sb = fc->root->d_sb;
 	ret = security_sb_kern_mount(sb);
 	if (unlikely(ret)) {
 		fc_drop_locked(fc);
+		fc->exclusive = false;
 		return ret;
 	}
 
@@ -253,8 +261,10 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 	if (ret)
 		return ret;
 	switch (cmd) {
+	case FSCONFIG_CMD_CREATE_EXCL:
+		fallthrough;
 	case FSCONFIG_CMD_CREATE:
-		ret = vfs_cmd_create(fc);
+		ret = vfs_cmd_create(fc, cmd == FSCONFIG_CMD_CREATE_EXCL);
 		if (ret)
 			break;
 		return 0;
@@ -369,6 +379,8 @@ SYSCALL_DEFINE5(fsconfig,
 		if (!_key || _value || aux < 0)
 			return -EINVAL;
 		break;
+	case FSCONFIG_CMD_CREATE_EXCL:
+		fallthrough;
 	case FSCONFIG_CMD_CREATE:
 	case FSCONFIG_CMD_RECONFIGURE:
 		if (_key || _value || aux)
diff --git a/fs/super.c b/fs/super.c
index c086ce4929cd..61dcd7922a10 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -603,9 +603,11 @@ struct super_block *sget_fc(struct fs_context *fc,
 	return s;
 
 share_extant_sb:
-	if (user_ns != old->s_user_ns) {
+	if (user_ns != old->s_user_ns || fc->exclusive) {
 		spin_unlock(&sb_lock);
 		destroy_unused_super(s);
+		if (fc->exclusive)
+			infofc(fc, "reusing existing superblock not allowed");
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

