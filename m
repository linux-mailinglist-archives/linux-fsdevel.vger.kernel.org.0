Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116776CC29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjHBL5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjHBL5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9142720
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869B261932
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA7BC433C7;
        Wed,  2 Aug 2023 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977433;
        bh=upJRiB48m4wbdldgU4LcxA2sXj3zqfUee9aq/sYFCOM=;
        h=From:Subject:Date:To:Cc:From;
        b=U5jSuevNmGOPn/lMkMmEnDGRKR9y9ixyzo9+WpCZBde7rVOYdTezXoR5feFJync1V
         6nVAFAlvbGfHaBxq4V4z1AiOWdOfGd5wJqcDFlzsvQaxviDDuLUsy+MHZjNPORJ0+Z
         ppV5KLdpTRBM46f6TDyZRwZThHm5rtL1AR6hyWF0qa71s0nS84azpBHYbcD1TZ4lA0
         AzczzaN9CmPaV/riFtnH/fOKFOgTLwGA6IA9xaz16CHUBrXOhKcZbsiwQXOWp8F6TZ
         q/fL5LgyIyIKyFvNhMWVEZ5A/tebPOj4j7+GTtQpViLxf042FARJm5TMLEaOzaf/Aq
         NOb2L/Lh1B98Q==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] fs: add FSCONFIG_CMD_CREATE_EXCL
Date:   Wed, 02 Aug 2023 13:57:02 +0200
Message-Id: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5EymQC/32OSw6DMAxEr4KyrlESPoWueo+KRQgGoqKA7BJRI
 e7ewAG6fNLMm9kFIzlk8Uh2QRgcu9lH0LdE2NH4AcF1kYWWOpOVVBB6Bl4XJMDNTiu7gGDrUuV
 lp/NW1yI2F8LebZf11URuDSO0ZLwdT1dUpJfizI6OPzN9rwNBnY3/W0GBBGWK6o5Faes+e76RP
 E7pTINojuP4AXgLLT3TAAAA
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=8711; i=brauner@kernel.org;
 h=from:subject:message-id; bh=upJRiB48m4wbdldgU4LcxA2sXj3zqfUee9aq/sYFCOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSccpm+/NqKHfZWmy4Yp6T1Oi2ZcDHJ9tc9HcfJ7lYbly2a
 m+m3rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiAooMf7g2veyItpGXm5H4wcPXtL
 /CVbrjoHmsav+vm/aHDF0abjMytEutE7XmrtTvFui7zHH/7p7LSust1cObs2s+f/mxafVWHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

---
Changes in v2:
- Minor code cleanups.
- Also split out vfs_cmd_reconfigure().
- Expand description for sget_fc().
- Link to v1: https://lore.kernel.org/r/20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org

---



---
base-commit: 1dbd9ceb390c4c61d28cf2c9251dd2015946ce51
change-id: 20230801-vfs-super-exclusive-c96146d24b29

