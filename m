Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D403B5EF8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiI2PbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiI2Paz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4432058;
        Thu, 29 Sep 2022 08:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32157618D7;
        Thu, 29 Sep 2022 15:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44B7C433C1;
        Thu, 29 Sep 2022 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465452;
        bh=LL8NejFbocWSy+AvSUtjXMIjl5uWCqF/UI1pdqvEzPg=;
        h=From:To:Cc:Subject:Date:From;
        b=qUj/ZM2JERsNRbYvA60slQIPan31PZUZJ4BulTKVKN2tW465By7tfIN4cUdGbBcag
         dvXN9qK/rdbawI69dJQ0W++tCYWVe3GyyIKqd/fNqMCNVvjtk1yss0m0eNfUnHN1DD
         EwTnt7lzZKRPzfYkfSgY6KHX2xwibMc+gS9wqwPA1eT6oKtee0+74EP3knhG/3w/Bw
         DA+7PkdbbOTn8hBzcsu8ZVqOc/0NX62UntXV7Dl0+sfuUM2ECGfWC2wHvfJFdum4Fn
         ldIxjvq/VzYIc4F6l01OpYV48MiBnBEfykN0FpjwyJhMw/XPvjPgw1X6sf97jvtLdi
         Cx20ivNoGXDcQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 00/30] acl: add vfs posix acl api
Date:   Thu, 29 Sep 2022 17:30:10 +0200
Message-Id: <20220929153041.500115-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14865; i=brauner@kernel.org; h=from:subject; bh=t07fl0LHVWk+O2Gxdp1eWyXQ0q+ftyK1Eg7M4h+Pc1Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hKUm3nEv876uUO65dko8f+mpmeN45/1qHCvvrKqWD7h ytb3HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJlWD4py31eVIU70OuTawPWPd+ef +pU8CeXeWmx+x4fVPr46sFTzP8T+AR2Hv/WJ/uDe89LI/9A33WKMyIYNiuc4x9/+pFNfLFLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

/* v4 */
Various minor changes. Details in the notes to the commits.

As we discussed and seen multiple times the current state of how posix
acls are handled isn't nice and comes with a lot of problems. For a long
and detailed explanation for just some of the issues [1] provides a good
summary.

The current way of handling posix acls via the generic xattr api is
error prone, hard to maintain, and type unsafe for the vfs until we call
into the filesystem's dedicated get and set inode operations.

It is already the case that posix acls are special-cased to death all
the way through the vfs. There are an uncounted number of hacks that
operate on the uapi posix acl struct instead of the dedicated vfs struct
posix_acl. And the vfs must be involved in order to interpret and fixup
posix acls before storing them to the backing store, caching them,
reporting them to userspace, or for permission checking.

Currently a range of hacks and duct tape exist to make this work. As
with most things this is really no ones fault it's just something that
happened over time. But the code is hard to understand and difficult
to maintain and one is constantly at risk of introducing bugs and
regressions when having to touch it.

Instead of continuing to hack posix acls through the xattr handlers this
series builds a dedicated posix acl api solely around the get and set
inode operations. Going forward, the vfs_get_acl(), vfs_remove_acl(),
and vfs_set_acl() helpers must be used in order to interact with posix
acls. They operate directly on the vfs internal struct posix_acl instead
of abusing the uapi posix acl struct as we currently do. In the end this
removes all of the hackiness, makes the codepaths easier to maintain,
and gets us type safety.

This series passes the LTP and xfstests suites without any regressions.
For xfstests the following combinations were tested:

* xfs
* ext4
* btrfs
* overlayfs
* overlayfs on top of idmapped mounts

For people wanting to run their own xfstests I'd recommend to shorten
their test runs via:

./check -g acl,attr,cap,idmapped,io_uring,perms,subvol,unlink

I would appreciate if the 9p and cifs folks could run any posix acl
related tests as I have no setup to really do this without causing me a
lot of pain.

Very likely there's a lot more simplifications for posix acls that we
can make in the future if the basic api has made it.

A few implementation details:

* The series makes sure to retain exactly the same security and
  integrity module permission checks. See [2] for annotated callchains.
  Especially for the integrity modules this api is a win because right
  now they convert the uapi posix acl struct passed to them via a void
  pointer into the vfs struct posix_acl format to perform permission
  checking on the mode.

  There's a new dedicated security hook for setting posix acls which
  passes the vfs struct posix_acl not a void pointer. Basing checking on
  the posix acl stored in the uapi format is really unreliable. The vfs
  currently hacks around directly in the uapi struct storing values that
  frankly the security and integrity modules can't correctly interpret
  as evidenced by bugs we reported and fixed in this area. It's not
  necessarily even their fault it's just that the format we provide to
  them is sub optimal.

* Some filesystems like 9p and cifs need access to the dentry in order
  to get and set posix acls which is why they either only partially or
  not even at all implement get and set inode operations. For example,
  cifs allows setxattr() and getxattr() operations but doesn't allow
  permission checking based on posix acls because it can't implement a
  get acl inode operation.

  Thus, this patch series updates the set acl inode operation to take a
  dentry instead of an inode argument. However, for the get acl inode
  operation we can't do this as the old get acl method is called in
  e.g., generic_permission() and inode_permission(). These helpers in
  turn are called in various filesystem's permission inode operation. So
  passing a dentry argument to the old get acl inode operation would
  amount to passing a dentry to the permission inode operation which we
  shouldn't and probably can't do.

  So instead of extending the existing inode operation Christoph
  suggested to add a new one. He also requested to ensure that the get
  and set acl inode operation taking a dentry are consistently named. So
  for this version the old get acl operation is renamed to
  ->get_inode_acl() and a new ->get_acl() inode operation taking a
  dentry is added. With this we can give both 9p and cifs get and set
  acl inode operations and in turn remove their complex custom posix
  xattr handlers.

* I've done a full audit of every codepaths using variant of the
  current generic xattr api to get and set posix acls and surprisingly
  it isn't that many places. There's of course always a chance that I
  might have missed some and I'm sure we'll find them soon enough.

  The crucial codepaths to be converted are obviously stacking
  filesystems such as ecryptfs and overlayfs.

  For a list of all callers currently using generic xattr api helpers
  see [2] including comments whether they support posix acls or not.

* The old vfs generic posix acl infrastructure doesn't obey
  the create and replace semantics promised on the setxattr(2) manpage.
  This patch series doesn't address this. It really is something we
  should revisit later though.

The patch series is roughly organized as follows:

// intended to be a non-functional change
1. Change existing set acl inode operation to take a dentry argument.

// intended to be a non-functional change
2. Rename existing get acl method.

// intended to be a non-functional change
3. Implement get and set acl inode operations for filesystems that
   couldn't implement one before because of the missing dentry. That's
   mostly 9p and cifs.

// intended to be a non-functional change
4. Build posix acl api, i.e., add vfs_get_acl(), vfs_remove_acl(), and
   vfs_set_acl() including security and integrity hooks.

// intended to be a non-functional change
5. Implement get and set acl inode operations for stacking filesystems.

// semantical change
6. Switch posix acl handling in stacking filesystems to new posix acl
   api now that all filesystems it can stack upon support it.

// semantical change
7. Switch vfs to new posix acl api

8. Remove all now unused helpers

The series can be pulled from:

https://gitlab.com/brauner/linux/-/commits/fs.acl.rework
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework

The series contains a few preliminary patches which are scheduled for
the next merge window. It was just easier to base the series on top of
them. But if you pull this branch you'll get them included.

I've been working on this for a while and before going any further it'd
be nice to get some reviews. I think that it should be fine to have get
and set acl inode operations that operate on the dentry at least nothing
stuck out immediately that would prevent this. But obviously having
other people point out issues with that would be helpful.

Thanks to Seth for a lot of good discussion around this and
encouragement and input from Christoph.

[1]: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org
[2]: https://gist.github.com/brauner/12c795b93a05dc3b3056b1982549a633

Thanks!
Christian

/* v1 */
Link: https://lore.kernel.org/linux-cifs/20220922151728.1557914-1-brauner@kernel.org

/* v2 */
Link: https://lore.kernel.org/linux-cifs/20220926140827.142806-1-brauner@kernel.org
This fixes various things pointed out during review. The individual
commits contain more details were appropriate.

/* v3 */
Link: https://lore.kernel.org/linux-cifs/20220928160843.382601-1-brauner@kernel.org
As requested this adds dedicated get and remove security hooks in
addition to the set hook instead of reusing the generic xattr hooks.

Christian Brauner (30):
  orangefs: rework posix acl handling when creating new filesystem
    objects
  fs: pass dentry to set acl method
  fs: rename current get acl method
  fs: add new get acl method
  cifs: implement get acl method
  cifs: implement set acl method
  9p: implement get acl method
  9p: implement set acl method
  security: add get, remove and set acl hook
  selinux: implement get, set and remove acl hook
  smack: implement get, set and remove acl hook
  integrity: implement get and set acl hook
  evm: add post set acl hook
  internal: add may_write_xattr()
  acl: add vfs_set_acl()
  acl: add vfs_get_acl()
  acl: add vfs_remove_acl()
  ksmbd: use vfs_remove_acl()
  ecryptfs: implement get acl method
  ecryptfs: implement set acl method
  ovl: implement get acl method
  ovl: implement set acl method
  ovl: use posix acl api
  xattr: use posix acl api
  evm: remove evm_xattr_acl_change()
  ecryptfs: use stub posix acl handlers
  ovl: use stub posix acl handlers
  cifs: use stub posix acl handlers
  9p: use stub posix acl handlers
  acl: remove a slew of now unused helpers

 Documentation/filesystems/locking.rst |   4 +-
 Documentation/filesystems/porting.rst |   4 +-
 Documentation/filesystems/vfs.rst     |   3 +-
 fs/9p/acl.c                           | 295 ++++++-----
 fs/9p/acl.h                           |   8 +-
 fs/9p/vfs_inode_dotl.c                |   4 +
 fs/9p/xattr.c                         |   7 +-
 fs/9p/xattr.h                         |   2 -
 fs/bad_inode.c                        |   4 +-
 fs/btrfs/acl.c                        |   3 +-
 fs/btrfs/ctree.h                      |   2 +-
 fs/btrfs/inode.c                      |   8 +-
 fs/ceph/acl.c                         |   3 +-
 fs/ceph/dir.c                         |   2 +-
 fs/ceph/inode.c                       |   4 +-
 fs/ceph/super.h                       |   2 +-
 fs/cifs/cifsacl.c                     | 141 +++++
 fs/cifs/cifsfs.c                      |   4 +
 fs/cifs/cifsproto.h                   |  20 +-
 fs/cifs/cifssmb.c                     | 206 +++++---
 fs/cifs/xattr.c                       |  68 +--
 fs/ecryptfs/inode.c                   |  32 ++
 fs/erofs/inode.c                      |   6 +-
 fs/erofs/namei.c                      |   2 +-
 fs/ext2/acl.c                         |   3 +-
 fs/ext2/acl.h                         |   2 +-
 fs/ext2/file.c                        |   2 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext2/namei.c                       |   4 +-
 fs/ext4/acl.c                         |   3 +-
 fs/ext4/acl.h                         |   2 +-
 fs/ext4/file.c                        |   2 +-
 fs/ext4/ialloc.c                      |   2 +-
 fs/ext4/inode.c                       |   2 +-
 fs/ext4/namei.c                       |   4 +-
 fs/f2fs/acl.c                         |   4 +-
 fs/f2fs/acl.h                         |   2 +-
 fs/f2fs/file.c                        |   4 +-
 fs/f2fs/namei.c                       |   4 +-
 fs/fuse/acl.c                         |   3 +-
 fs/fuse/dir.c                         |   4 +-
 fs/fuse/fuse_i.h                      |   2 +-
 fs/gfs2/acl.c                         |   3 +-
 fs/gfs2/acl.h                         |   2 +-
 fs/gfs2/inode.c                       |   6 +-
 fs/internal.h                         |   5 +
 fs/jffs2/acl.c                        |   3 +-
 fs/jffs2/acl.h                        |   2 +-
 fs/jffs2/dir.c                        |   2 +-
 fs/jffs2/file.c                       |   2 +-
 fs/jffs2/fs.c                         |   2 +-
 fs/jfs/acl.c                          |   3 +-
 fs/jfs/file.c                         |   4 +-
 fs/jfs/jfs_acl.h                      |   2 +-
 fs/jfs/namei.c                        |   2 +-
 fs/ksmbd/smb2pdu.c                    |   8 +-
 fs/ksmbd/smbacl.c                     |   6 +-
 fs/ksmbd/vfs.c                        |  21 +-
 fs/ksmbd/vfs.h                        |   4 +-
 fs/namei.c                            |   4 +-
 fs/nfs/nfs3_fs.h                      |   2 +-
 fs/nfs/nfs3acl.c                      |   9 +-
 fs/nfs/nfs3proc.c                     |   4 +-
 fs/nfsd/nfs2acl.c                     |   8 +-
 fs/nfsd/nfs3acl.c                     |   8 +-
 fs/nfsd/nfs4acl.c                     |   4 +-
 fs/nfsd/vfs.c                         |   4 +-
 fs/ntfs3/file.c                       |   4 +-
 fs/ntfs3/namei.c                      |   4 +-
 fs/ntfs3/ntfs_fs.h                    |   4 +-
 fs/ntfs3/xattr.c                      |   9 +-
 fs/ocfs2/acl.c                        |   3 +-
 fs/ocfs2/acl.h                        |   2 +-
 fs/ocfs2/file.c                       |   4 +-
 fs/ocfs2/namei.c                      |   2 +-
 fs/orangefs/acl.c                     |  47 +-
 fs/orangefs/inode.c                   |  47 +-
 fs/orangefs/namei.c                   |   2 +-
 fs/orangefs/orangefs-kernel.h         |   8 +-
 fs/orangefs/orangefs-utils.c          |  12 +-
 fs/overlayfs/copy_up.c                |  38 ++
 fs/overlayfs/dir.c                    |  22 +-
 fs/overlayfs/inode.c                  | 153 +++++-
 fs/overlayfs/overlayfs.h              |  34 +-
 fs/overlayfs/super.c                  | 107 +---
 fs/posix_acl.c                        | 728 +++++++++++++-------------
 fs/reiserfs/acl.h                     |   6 +-
 fs/reiserfs/file.c                    |   2 +-
 fs/reiserfs/inode.c                   |   2 +-
 fs/reiserfs/namei.c                   |   4 +-
 fs/reiserfs/xattr_acl.c               |  11 +-
 fs/xattr.c                            |  82 +--
 fs/xfs/xfs_acl.c                      |   3 +-
 fs/xfs/xfs_acl.h                      |   2 +-
 fs/xfs/xfs_iops.c                     |  16 +-
 include/linux/evm.h                   |  49 ++
 include/linux/fs.h                    |  10 +-
 include/linux/ima.h                   |  21 +
 include/linux/lsm_hook_defs.h         |   6 +
 include/linux/lsm_hooks.h             |  12 +
 include/linux/posix_acl.h             |  41 +-
 include/linux/posix_acl_xattr.h       |  43 +-
 include/linux/security.h              |  29 +
 include/linux/xattr.h                 |   6 +
 mm/shmem.c                            |   2 +-
 security/integrity/evm/evm_main.c     | 134 ++---
 security/integrity/ima/ima_appraise.c |   9 +
 security/security.c                   |  42 ++
 security/selinux/hooks.c              |  24 +
 security/smack/smack_lsm.c            |  69 +++
 110 files changed, 1766 insertions(+), 1094 deletions(-)


base-commit: 38e316398e4e6338b80223fb5f74415c0513718f
-- 
2.34.1

