Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314EB68169D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbjA3QmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbjA3QmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462363D0A3;
        Mon, 30 Jan 2023 08:42:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F256117D;
        Mon, 30 Jan 2023 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B4C433EF;
        Mon, 30 Jan 2023 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096929;
        bh=spTKhIOwCpWESMlTwbq6jQvoegfh5VVyof6YCbDvZiA=;
        h=From:Subject:Date:To:Cc:From;
        b=W4aXvDhu1PQQoT3TqK3C+78F6hJXpfzMa9MQE1upEWlHVyXyzPaFEUR041ZjPTTBt
         UBHuMBtmm6h2rTumdkxVHMKbxpgMvQElm+PbKwyG/4rOyyOUrBCTIsmQiVm8Qv/Owa
         tKVhCJa/VKzEXuE7Royd/+dzxhMgSzXG/aaTnsTmlZRAvAcWwFHkxtzRUgnGBLDeZW
         lbW5F0Ql0CYG8ANGG9O1F4XIs1Vase0A42lQtA+mwoc1d0c6VcQAAubuf0idMYDyv4
         nDjQI47YvRTn6xEZ2Azx5NxkGGTvEnszB5e/usgHav1wSsygcKNDdsKxbCHfuaXcgu
         MGz3AkO5us9hw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/8] acl: remove generic posix acl handlers from all
 xattr handlers
Date:   Mon, 30 Jan 2023 17:41:56 +0100
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTz12MC/5WOQQ6DIBREr2JY9xulQmxXvUfjAvCjpBaaDyE2x
 rsXvUGXbzIzeRuLSA4ju1cbI8wuuuAL8EvFzKz8hODGwow3/Nq0XICNoMwChO+QESb0ZW9gVSk
 RlMG4IEXojMWxF6If+56VK60igiblzXycvVVMSHWWNQcy8mh8CK1bT5HnUHh2MQX6nl65PdI/F
 XILDUhjWyF0d+NaPl5IHpc60MSGfd9/4XJ8uvsAAAA=
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4824; i=brauner@kernel.org;
 h=from:subject:message-id; bh=spTKhIOwCpWESMlTwbq6jQvoegfh5VVyof6YCbDvZiA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf/xy7MHzFC0en5pVbFi3YzJht3qr0faqqWs61Wf67Os8+
 /qd+v6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiCf4M/3Qlu/9u+8bb5/u4m/OAOP
 Nz3qxiFY6vm27/V3hv7v/+vBjDPxW2ydktxi/v3JxlO2Hxd6YXV1bfsT68X50lk2OapMH5M/wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

after we finished the introduction of the new posix acl api last cycle
we still left the generic POSIX ACL xattr handlers around in the
filesystems xattr handler registered at sb->s_xattr for two reasons.
First, because a few filesystems rely on the ->list() method of the
generic POSIX ACL xattr handlers in their ->listxattr() inode operation.
Second, during inode initalization in inode_init_always() the registered
xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
inode->i_opflags.

This series adresses both issues and makes it possible to remove the
generic POSIX ACL xattr handlers from the sb->s_xattr list of all
filesystems. This is a crucial step as the generic POSIX ACL xattr
handlers aren't used for POSIX ACLs anymore. They are never used apart
from the two cases above.

To fix this we make POSIX ACLs independent of IOP_XATTR. For filesystems
like btrfs or reiserfs that want to disable xattrs and POSIX ACLs for
some inodes we give them a dedicated IOP_NOACL flag they can raise as
discussed in the previous iteration.

The series also simplifies a the ->listxattr() implementation for all
filesystems that rely on the ->list() method of the xattr handlers.

After this we've removed the generic POSIX ACL xattr handlers completely
from sb->s_xattr.

All filesystems with reasonable integration into xfstests have been
tested with:

        ./check -g acl,attr,cap,idmapped,io_uring,perms,unlink

All tests pass without regression on xfstests for-next branch.

Since erofs doesn't have integration into xfstests yet afaict I have
tested it with the testuite available in erofs-utils. They also all pass
without any regressions.

Thanks!
Christian

[1]: https://lore.kernel.org/lkml/20230125100040.374709-1-brauner@kernel.org
[2]: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.remove.generic.xattr.handlers.v1

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Please see changelogs of the individual patches.
- Christoph & Christian:
  Remove SB_I_XATTR and instead introduce IOP_NOACL so filesystems can
  opt out of POSIX ACLs for specific inodes. Decouple POSIX ACLs from
  IOP_XATTR.
- Keep generic posix acl xattr handlers so filesystems that use array
  based indexing on xattr handlers can continue to do so.
- Minor fixes.
- Link to v1: https://lore.kernel.org/r/20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org

---
Christian Brauner (8):
      fs: don't use IOP_XATTR for posix acls
      xattr: simplify listxattr helpers
      xattr: add listxattr helper
      xattr: remove unused argument
      fs: drop unused posix acl handlers
      fs: simplify ->listxattr() implementation
      reiserfs: rework ->listxattr() implementation
      fs: rename generic posix acl handlers

 fs/9p/xattr.c                   |   4 --
 fs/bad_inode.c                  |   3 +-
 fs/btrfs/inode.c                |   2 +-
 fs/btrfs/xattr.c                |   4 --
 fs/ceph/xattr.c                 |   4 --
 fs/cifs/xattr.c                 |   4 --
 fs/ecryptfs/inode.c             |   4 --
 fs/erofs/xattr.c                |  12 +----
 fs/erofs/xattr.h                |  20 +++++---
 fs/ext2/xattr.c                 |  25 +++++-----
 fs/ext4/xattr.c                 |  25 +++++-----
 fs/f2fs/xattr.c                 |  24 +++++-----
 fs/gfs2/xattr.c                 |   2 -
 fs/jffs2/xattr.c                |  29 ++++++------
 fs/jfs/xattr.c                  |   4 --
 fs/libfs.c                      |   3 +-
 fs/nfs/nfs3_fs.h                |   1 -
 fs/nfs/nfs3acl.c                |   6 ---
 fs/nfs/nfs3super.c              |   3 --
 fs/nfsd/nfs4xdr.c               |   3 +-
 fs/ntfs3/xattr.c                |   4 --
 fs/ocfs2/xattr.c                |  14 ++----
 fs/orangefs/xattr.c             |   2 -
 fs/overlayfs/copy_up.c          |   4 +-
 fs/overlayfs/super.c            |   8 ----
 fs/posix_acl.c                  |  53 +++++++++++++++++----
 fs/reiserfs/inode.c             |   2 +-
 fs/reiserfs/namei.c             |   4 +-
 fs/reiserfs/reiserfs.h          |   2 +-
 fs/reiserfs/xattr.c             |  74 +++++++++++++++--------------
 fs/xattr.c                      | 101 +++++++++++++++-------------------------
 fs/xfs/xfs_xattr.c              |   4 --
 include/linux/fs.h              |   1 +
 include/linux/posix_acl.h       |   7 +++
 include/linux/posix_acl_xattr.h |   5 +-
 include/linux/xattr.h           |  30 +++++++++++-
 mm/shmem.c                      |   4 --
 37 files changed, 245 insertions(+), 256 deletions(-)
---
base-commit: ab072681eabe1ce0a9a32d4baa1a27a2d046bc4a
change-id: 20230125-fs-acl-remove-generic-xattr-handlers-4cfed8558d88

