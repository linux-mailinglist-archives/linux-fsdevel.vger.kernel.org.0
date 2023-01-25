Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AEE67B13B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjAYL36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjAYL31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D42CFF6;
        Wed, 25 Jan 2023 03:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072FE614B8;
        Wed, 25 Jan 2023 11:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAC2C433EF;
        Wed, 25 Jan 2023 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646165;
        bh=iVepgeT7psmWqr/2L8LpCH4RngFmQJ2i/zddXU3Ybms=;
        h=From:Subject:Date:To:Cc:From;
        b=aa0adWk8JIHYbDKjUCphZ1mzhrcTx2e5m+zTBZn9obQWuMBhYiKhvxE/PfkC0DrMo
         n+Ti2ja6VfjxgUnPOpsi1+/EmtHqmyra/AonZ5w9wjQlfzKpsP+4TOI050CJaL0N1y
         bKz7YhLgOmOvqok9PjXvsoVl3tKqVYUbksPXEapn+w0KefS9YB16xUcTypEO9pAwIN
         evQ3wG1KZlyA608u+IFmR08EX1UGoUJze8vveYRXvWqAxEv1eQ5rc5zD6Fc879yXFq
         13JMMXTEhD0lFVC6szsgPPomAG4klotXLnPAg8gEVmP0MH1tcrAZMyEp+bDrceHz66
         q2f2/uwZQY7jw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/12] acl: remove remaining posix acl handlers
Date:   Wed, 25 Jan 2023 12:28:45 +0100
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4S0WMC/x2O0QqDMBAEf0XuuSeaVgj9ldKHmGw0YGO5UxHEf
 2/s47DMsAcpJEHpWR0k2JKmORdobxX50eUBnEJhMo25N63pOCo7P7HgM2/gAbn4nne3LMJFCBN
 E+eEjgu06G6ylkuqdgntx2Y9XLGodV0VdQtf6FcS0/0+83uf5A07KJIqUAAAA
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iVepgeT7psmWqr/2L8LpCH4RngFmQJ2i/zddXU3Ybms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJq42SCo7mej0syzO7/VS69Ps21sFO48f9znuHr/fZEX
 p52lO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSeIbhn+X/3zmPrKtsko21fh3Smv
 5k/WvP2Uo6Sw92TuXesanV+BYjw7wCO68bLxsFprMsyP59RaXIcbL7hMBFnntnmxRL2pSJsAIA
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
we still left the generic POSIX ACL xattr handler around for two
reasons. First, because a few filesystems relied on the ->list() method
of the generic POSIX ACL xattr handlers in their ->listxattr() inode
operation. Second, during inode initalization in inode_init_always() the
registered xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
inode->i_opflags.

With the removal of the legacy POSIX ACL handlers it is at least
possible for a filesystem to only implement POSIX ACLs but no other
xattrs. If that were to happen we would miss to raise IOP_XATTR because
sb->s_xattr would be NULL.

Fix these things and then get rid of the misleading and effectively
already unused generic POSIX ACL handlers.

For most filesystems it is a trivial removal of the generic POSIX ACL
handlers. Only for erofs, ext2, ext4, f2fs, jffs2, reiserfs, oc2fs the
handler is used but rather easy to fix.

All filesystems with reasonable integration into xfstests have been
tested with:

        ./check -g acl,attr,cap,idmapped,io_uring,perms,unlink

All tests pass without regression on xfstests for-next branch.

Since erofs doesn't have integration into xfstests yet afaict I have
tested it with the testuite available in erofs-utils. They also all pass
without any regressions.

This branch depends on [1] which hopefully should be merged soon and can
be pulled from [2] which already includes [1] so it's easy to test and
compile.

With this all remnants of the old POSIX ACL xattr handling will be gone.

Thanks!
Christian

[1]: https://lore.kernel.org/lkml/20230125100040.374709-1-brauner@kernel.org
[2]: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.remove.generic.xattr.handlers.v1

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Christian Brauner (12):
      xattr: simplify listxattr helpers
      xattr, posix acl: add listxattr helpers
      xattr: remove unused argument
      fs: drop unused posix acl handlers
      erofs: drop posix acl handlers
      ext2: drop posix acl handlers
      ext4: drop posix acl handlers
      f2fs: drop posix acl handlers
      jffs2: drop posix acl handlers
      ocfs2: drop posix acl handlers
      reiserfs: drop posix acl handlers
      acl: remove posix acl handlers

 fs/9p/xattr.c                   |   4 --
 fs/btrfs/xattr.c                |   4 --
 fs/ceph/xattr.c                 |   4 --
 fs/cifs/xattr.c                 |   4 --
 fs/ecryptfs/inode.c             |   4 --
 fs/erofs/xattr.c                |  49 ++++++++++++----
 fs/erofs/xattr.h                |  21 -------
 fs/ext2/xattr.c                 |  60 +++++++++++--------
 fs/ext4/xattr.c                 |  71 +++++++++++++----------
 fs/f2fs/xattr.c                 |  63 ++++++++++++--------
 fs/gfs2/xattr.c                 |   2 -
 fs/jffs2/xattr.c                |  42 +++++++-------
 fs/jfs/xattr.c                  |   4 --
 fs/nfs/nfs3_fs.h                |   1 -
 fs/nfs/nfs3acl.c                |   6 --
 fs/nfs/nfs3super.c              |   3 -
 fs/nfsd/nfs4xdr.c               |   3 +-
 fs/ntfs3/xattr.c                |   4 --
 fs/ocfs2/xattr.c                |  41 +++++++------
 fs/orangefs/xattr.c             |   2 -
 fs/overlayfs/super.c            |   8 ---
 fs/posix_acl.c                  |  20 -------
 fs/reiserfs/xattr.c             |  38 ++++++------
 fs/xattr.c                      | 124 ++++++++++++++++++++--------------------
 fs/xfs/xfs_xattr.c              |   4 --
 include/linux/posix_acl_xattr.h |   6 +-
 include/linux/xattr.h           |   8 ++-
 mm/shmem.c                      |   4 --
 28 files changed, 290 insertions(+), 314 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230125-fs-acl-remove-generic-xattr-handlers-4cfed8558d88

