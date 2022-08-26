Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3295A3145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiHZVrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiHZVrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25206BE4CB;
        Fri, 26 Aug 2022 14:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A953161262;
        Fri, 26 Aug 2022 21:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279A4C433D6;
        Fri, 26 Aug 2022 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661550427;
        bh=mvfUetTQSU0z0A8jrDKhU0i3r8eb9afKtfhlAOCnk1c=;
        h=From:To:Cc:Subject:Date:From;
        b=HmYzIge0wCpr7KDG+1qpIoRCMtA/hc9uQF+y3qciRiIzjOZjL13FHap5Tucb51Kcw
         BslTB43uaNtYz+uPnwgBdjoxg9sMJtihdb/ZLUanvBgRMTjwYNANo1AR6VzPJRSkho
         KaS67bl8Erxl5CV/yjL8zgd5InJw45rd0zJAabKM4nLsAOC7shmdFfqtqIK/soPaUf
         /NiSEwy5UYIEYQ9IMHFkxdFrJfGBJO3b2y4fSjWQsv0Xn501Lb+CzHQ++HK6MUX9N4
         qJAHA4zJ5L7ddJakJwyNOb28qizWsmLfJi7InKu3rmDxtcpAX3Va4AkAlP/jgwo64d
         ebNX10Max/bZw==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 0/7] vfs: clean up i_version behavior and expose it via statx
Date:   Fri, 26 Aug 2022 17:46:56 -0400
Message-Id: <20220826214703.134870-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of this patchset is two-fold:

1/ correct performance issues in the existing i_version counter
implementations and (hopefully) to bring them into behavioral
alignment.

2/ expose the i_version field to userland via statx. This is useful for
testing the various i_version implementations, but may also be useful for
userland applications that want a way to tell whether a file might
have changed.

The i_version field in Linux has been around since 1994, but its meaning
and behavior has subtly changed over time [1]. The first patch in this
series fleshes out the comments in iversion.h to try and give a clear
explanation of what's expected from the filesystem. My first ask is for
feedback on this -- does the proposed definition seem reasonable for
presenting to userland?

There are two main consumers of i_version in the kernel: nfsd and IMA.
They both only want to see a change to the i_version iff there was an
explicit change to the inode. They can cope with an implementation that
does more increments than that, but that measurably harms performance.

I'll argue that atime-only updates SHOULD be excluded from i_version
bumps since they don't represent a "real" change to the inode. Spurious
updates to the i_version have real, measurable performance impacts with
NFSv4, and possibly with IMA.

There are 3 kernel-managed i_version implementations in the kernel:
btrfs, ext4 and xfs.

btrfs seems to work as we'd expect. It doesn't bump the i_version
on atime-only updates and seems to bump it appropriately for other
activity.

ext4 currently bumps the i_version even when only the atime is being
updated. I have a patch to fix this that Jan and Christian have
Reviewed, but I haven't yet heard from Ted or Andreas.

xfs has the same issue as ext4 bumping i_version on atime updates.  He
has NACK'ed the patch I proposed since there are evidently tools that
depend on every log transaction being represented in i_version.

I've included the xfs patch in this series, but if it's not suitable I'm
open to fixing this other ways, but I'll need some feedback as to what
the xfs developers would like to do here. Should we add a new on-disk
field to the inode? Try to do something clever with "unused" parts of
the ctime? What would be best?

Lastly, there are patches to allow NFS and Ceph to report this value
as well. They should be fairly straightforward once the earlier pile is
resolved.

Note that I dropped the patch to make AFS report STATX_INO_VERSION since
its semantics don't match the proposed definition.

[1]: Now, for your entertainment...

A BRIEF HISTORY OF THE I_VERSION FIELD
======================================

PRE-GIT-HISTORY ERA:
--------------------
The i_version field first appears in v1.1.30 (summer 1994) with more increments
added to ext2 over next few v1.1.x versions. There were ioctls to set and fetch
the value in ext2. They're still there but they access the i_generation
counter now.

It was mostly used to catch races in lookup and readdir due to directory
changes, and a lot of filesystems still use it that way today. Non-directory
inodes would have this value set, but the kernel didn't do much with it.

GIT HISTORY ERA:
----------------
Then in 2.6.24, Jean Noel Cordenner from Bull increased the size to 64
bits, added the MS_I_VERSION flag, and started incrementing it in
file_update_time:

    commit 7a224228ed79d587ece2304869000aad1b8e97dd
    Author: Jean Noel Cordenner <jean-noel.cordenner@bull.net>
    Date:   Mon Jan 28 23:58:27 2008 -0500

        vfs: Add 64 bit i_version support

        The i_version field of the inode is changed to be a 64-bit counter that
        is set on every inode creation and that is incremented every time the
        inode data is modified (similarly to the "ctime" time-stamp).
        The aim is to fulfill a NFSv4 requirement for rfc3530.
        This first part concerns the vfs, it converts the 32-bit i_version in
        the generic inode to a 64-bit, a flag is added in the super block in
        order to check if the feature is enabled and the i_version is
        incremented in the vfs.

        Signed-off-by: Mingming Cao <cmm@us.ibm.com>
        Signed-off-by: Jean Noel Cordenner <jean-noel.cordenner@bull.net>
        Signed-off-by: Kalpak Shah <kalpak@clusterfs.com>

Then he added support to ext4, plus the mount option to enable it. The
problem with the i_version being incremented during atime updates
probably dates back to this patch. I imagine it was probably just an
oversight, though it could just have been due to unclear definition for
the change attr in the NFSv4.0 spec:

    commit 25ec56b518257a56d2ff41a941d288e4b5ff9488
    Author: Jean Noel Cordenner <jean-noel.cordenner@bull.net>
    Date:   Mon Jan 28 23:58:27 2008 -0500

        ext4: Add inode version support in ext4

        This patch adds 64-bit inode version support to ext4. The lower 32 bits
        are stored in the osd1.linux1.l_i_version field while the high 32 bits
        are stored in the i_version_hi field newly created in the ext4_inode.
        This field is incremented in case the ext4_inode is large enough. A
        i_version mount option has been added to enable the feature.

        Signed-off-by: Mingming Cao <cmm@us.ibm.com>
        Signed-off-by: Andreas Dilger <adilger@clusterfs.com>
        Signed-off-by: Kalpak Shah <kalpak@clusterfs.com>
        Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
        Signed-off-by: Jean Noel Cordenner <jean-noel.cordenner@bull.net>

Bruce then added support for it to nfsd:

    commit c654b8a9cba6002aad1c01919e4928a79a4a6dcf
    Author: J. Bruce Fields <bfields@citi.umich.edu>
    Date:   Thu Apr 16 17:33:25 2009 -0400

        nfsd: support ext4 i_version

        ext4 supports a real NFSv4 change attribute, which is bumped whenever
        the ctime would be updated, including times when two updates arrive
        within a jiffy of each other.  (Note that although ext4 has space for
        nanosecond-precision ctime, the real resolution is lower: it actually
        uses jiffies as the time-source.)  This ensures clients will invalidate
        their caches when they need to.

        There is some fear that keeping the i_version up-to-date could have
        performance drawbacks, so for now it's turned on only by a mount option.
        We hope to do something better eventually.

        Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
        Cc: Theodore Tso <tytso@mit.edu>

Josef converted btrfs to use it instead of their own internal counter.
It looks like the btrfs implementation has probably avoided the issue
with atime updates causing i_version bumps.

    commit 0c4d2d95d06e920e0c61707e62c7fffc9c57f63a
    Author: Josef Bacik <josef@redhat.com>
    Date:   Thu Apr 5 15:03:02 2012 -0400

        Btrfs: use i_version instead of our own sequence

        We've been keeping around the inode sequence number in hopes that somebody
        would use it, but nobody uses it and people actually use i_version which
        serves the same purpose, so use i_version where we used the incore inode's
        sequence number and that way the sequence is updated properly across the
        board, and not just in file write.  Thanks,

        Signed-off-by: Josef Bacik <josef@redhat.com>

Then, in 2013 Dave added support for xfs with v3 superblocks. There were
some later changes of how it was stored, but its behavior has largely
been the same on xfs since then. Note that at the time, the stated
reason for adding this was to provide NFSv4 semantics:

    commit dc037ad7d24f3711e431a45c053b5d425995e9e4
    Author: Dave Chinner <dchinner@redhat.com>
    Date:   Thu Jun 27 16:04:59 2013 +1000

        xfs: implement inode change count

        For CRC enabled filesystems, add support for the monotonic inode
        version change counter that is needed by protocols like NFSv4 for
        determining if the inode has changed in any way at all between two
        unrelated operations on the inode.

        This bumps the change count the first time an inode is dirtied in a
        transaction. Since all modifications to the inode are logged, this
        will catch all changes that are made to the inode, including
        timestamp updates that occur during data writes.

        Signed-off-by: Dave Chinner <dchinner@redhat.com>
        Reviewed-by: Mark Tinguely <tinguely@sgi.com>
        Reviewed-by: Chandra Seetharaman <sekharan@us.ibm.com>
        Signed-off-by: Ben Myers <bpm@sgi.com>

Jeff Layton (7):
  iversion: update comments with info about atime updates
  ext4: fix i_version handling in ext4
  ext4: unconditionally enable the i_version counter
  xfs: don't bump the i_version on an atime update in xfs_vn_update_time
  vfs: report an inode version in statx for IS_I_VERSION inodes
  nfs: report the inode version in statx if requested
  ceph: fill in the change attribute in statx requests

 fs/ceph/inode.c                 | 14 +++++++++-----
 fs/ext4/inode.c                 | 10 +++++-----
 fs/ext4/ioctl.c                 |  4 ++++
 fs/ext4/move_extent.c           |  6 ++++++
 fs/ext4/super.c                 | 13 ++++---------
 fs/ext4/xattr.c                 |  1 +
 fs/nfs/inode.c                  |  7 +++++--
 fs/stat.c                       |  7 +++++++
 fs/xfs/libxfs/xfs_log_format.h  |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_iops.c               | 11 +++++++++--
 include/linux/iversion.h        | 23 +++++++++++++++++++++--
 include/linux/stat.h            |  1 +
 include/uapi/linux/stat.h       |  3 ++-
 samples/vfs/test-statx.c        |  8 ++++++--
 15 files changed, 82 insertions(+), 30 deletions(-)

-- 
2.37.2

