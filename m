Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7B6EABFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjDUNq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjDUNqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15087133;
        Fri, 21 Apr 2023 06:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A602E6507D;
        Fri, 21 Apr 2023 13:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FE3C433D2;
        Fri, 21 Apr 2023 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682084789;
        bh=UoefKGfKhzh10p7jTXglm4Jte6XmHnasaWYjMkPRhrE=;
        h=From:To:Cc:Subject:Date:From;
        b=MrigxdfIDdqoNIV7Ebl7e0uMGs/4lu+/tY/wzhXNtnYtp7nEEpLax/E+X+A0TzgHa
         RerzLbxrmzminyWpVl67kONUxzn7D2QX7StX6pJDyybYNmT4MWB1m3cvXAAKNyTq+p
         IgIfDMJRZe9GkLZrsjNlMS8q7lxG9VK7GMYezbUEO59ZkP85bEuNbx7CnsFZ6LKVwF
         RMIKjs2LYPm8KWAhzpCvvY6NPQDHZNKX8uCtUYGnTUJBIBBxsWWc+pWur2J4x2ZKwj
         gttFMLg0bzsOAwolJuGpFeH95v9FR3mNj3aXnAHb3zqgH7lBXHQDkCDPh+7c09gvaU
         9Fvaq14pp7HmQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] acl updates
Date:   Fri, 21 Apr 2023 15:45:57 +0200
Message-Id: <20230421-kundgeben-filmpreis-0e443f89efe2@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=brauner@kernel.org; h=from:subject:message-id; bh=CElFwJJsdhb5H3omQYDWvBjwmfUBTfBiJN3iddr8r4U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4TY4oO18gplp2mkNx57rYysPtRuEPs1+u6rkXI/twFWPF AYfgjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImwxzIyNORlL83t0Hg8W+qX0ZIkT2 aflV4nza0N1HnmvwutZ758jZFh1mL39TOeZe3vdJ+236Pt3YlOoWkfY/aw5Au7it17MH0aIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
After finishing the introduction of the new posix acl api last cycle the
generic POSIX ACL xattr handlers are still around in the filesystems
xattr handlers for two reasons:

(1) Because a few filesystems rely on the ->list() method of the generic
    POSIX ACL xattr handlers in their ->listxattr() inode operation.
(2) POSIX ACLs are only available if IOP_XATTR is raised. The IOP_XATTR
    flag is raised in inode_init_always() based on whether the
    sb->s_xattr pointer is non-NULL. IOW, the registered xattr handlers
    of the filesystem are used to raise IOP_XATTR.
    Removing the generic POSIX ACL xattr handlers from all filesystems
    would risk regressing filesystems that only implement POSIX ACL
    support and no other xattrs (nfs3 comes to mind).

This pull request contains the work to decouple POSIX ACLs from
the IOP_XATTR flag as they don't depend on xattr handlers anymore. So
it's now possible to remove the generic POSIX ACL xattr handlers from
the sb->s_xattr list of all filesystems. This is a crucial step as the
generic POSIX ACL xattr handlers aren't used for POSIX ACLs anymore and
POSIX ACLs don't depend on the xattr infrastructure anymore.

Adressing problem (1) will require more long-term work. It would be best
to get rid of the ->list() method of xattr handlers completely at some
point.

For erofs, ext{2,4}, f2fs, jffs2, ocfs2, and reiserfs the nop POSIX ACL
xattr handler is kept around so they can continue to use array-based
xattr handler indexing. The pull request does simplify the ->listxattr()
implementation of all these filesystems however.

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
The following merge conflict including a proposed conflict resolution
was reported from linux-next in:

(1) linux-next: manual merge of the erofs tree with the vfs-idmapping tree
    https://lore.kernel.org/linux-next/4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk

At the time of creating this PR no merge conflicts showed up doing a
test-merge with current mainline.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.acl

for you to fetch changes up to e499214ce3ef50c50522719e753a1ffc928c2ec1:

  acl: don't depend on IOP_XATTR (2023-03-06 09:59:20 +0100)

Please consider pulling these changes from the signed v6.4/vfs.acl tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/vfs.acl

----------------------------------------------------------------
Christian Brauner (10):
      xattr: simplify listxattr helpers
      xattr: add listxattr helper
      xattr: remove unused argument
      fs: drop unused posix acl handlers
      fs: simplify ->listxattr() implementation
      reiserfs: rework ->listxattr() implementation
      fs: rename generic posix acl handlers
      reiserfs: rework priv inode handling
      ovl: check for ->listxattr() support
      acl: don't depend on IOP_XATTR

 fs/9p/xattr.c                   |   4 --
 fs/btrfs/xattr.c                |   4 --
 fs/ceph/xattr.c                 |   4 --
 fs/cifs/xattr.c                 |   4 --
 fs/ecryptfs/inode.c             |   4 --
 fs/erofs/xattr.c                |  12 +---
 fs/erofs/xattr.h                |  20 ++++---
 fs/ext2/xattr.c                 |  25 ++++----
 fs/ext4/xattr.c                 |  25 ++++----
 fs/f2fs/xattr.c                 |  24 ++++----
 fs/gfs2/xattr.c                 |   2 -
 fs/jffs2/xattr.c                |  29 +++++-----
 fs/jfs/xattr.c                  |   4 --
 fs/nfs/nfs3_fs.h                |   1 -
 fs/nfs/nfs3acl.c                |   6 --
 fs/nfs/nfs3super.c              |   3 -
 fs/nfsd/nfs4xdr.c               |   3 +-
 fs/ntfs3/xattr.c                |   4 --
 fs/ocfs2/xattr.c                |  14 ++---
 fs/orangefs/xattr.c             |   2 -
 fs/overlayfs/copy_up.c          |   3 +-
 fs/overlayfs/super.c            |   8 ---
 fs/posix_acl.c                  |  61 +++++++++++++++-----
 fs/reiserfs/file.c              |   7 +++
 fs/reiserfs/inode.c             |   6 +-
 fs/reiserfs/namei.c             |  50 ++++++++++++++--
 fs/reiserfs/reiserfs.h          |   2 +
 fs/reiserfs/xattr.c             |  55 +++++++++---------
 fs/xattr.c                      | 124 ++++++++++++++++++++--------------------
 fs/xfs/xfs_xattr.c              |   4 --
 include/linux/posix_acl.h       |   7 +++
 include/linux/posix_acl_xattr.h |   5 +-
 include/linux/xattr.h           |  19 +++++-
 mm/shmem.c                      |   4 --
 34 files changed, 292 insertions(+), 257 deletions(-)
