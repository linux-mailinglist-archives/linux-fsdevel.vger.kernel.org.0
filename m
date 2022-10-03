Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C45F2F79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJCLVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJCLVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD448E8C;
        Mon,  3 Oct 2022 04:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7687B80DBB;
        Mon,  3 Oct 2022 11:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA68C433D6;
        Mon,  3 Oct 2022 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796069;
        bh=jg7MY7RrGH/UWzZ2uF9JTzBj8fchRyPXo6PyTxKETEY=;
        h=From:To:Cc:Subject:Date:From;
        b=WYkC+34SOMkYS5vN8WDH+82NNvMrKZY/eQrSdRJ3NkXCJg/od1vsNMsiczLqJsts0
         nezSZY3otsNhEzFwfYDqmPjZwIftQTbI7nyZCqJKE+BdNSSIXcH722FIxQwSIE+M7q
         xgpF5eYl/KxoWvcihFyRf0+vTQbVZgVlFBO3rxbPK9BxRSU9ZuV17FYZWc0URU7E8j
         WEngTlgXncodegiu3v0OIRcD+f0sj+MNgBwi2xDcBgg4HG1AvejwahZv/Z/wzHT6QY
         m8jPFeISnWhZt0Hqh1ltSjXKILT8gxWK539NEv0r5SkJLJJKHTVVmK89YCsXoV5cqH
         f6Qp1IVoe2PcA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] acl updates for v6.1
Date:   Mon,  3 Oct 2022 13:19:42 +0200
Message-Id: <20221003111943.743391-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4612; i=brauner@kernel.org; h=from:subject; bh=jg7MY7RrGH/UWzZ2uF9JTzBj8fchRyPXo6PyTxKETEY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRbHdW5OGH3D+WK7G0fHnVGvheMV/3rkpdoM/GidN3DxI4/ 12ds7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIjOWMDCfNs/eoT3my6WNexWoGU4 ZdPbemC91+fDH3vvqk684vwhsZ/rvNeLTTOVrd2+79LsGvHi0SjEe2GcUd2py/0GWCwdNGKVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
These are general fixes and preparatory changes related to the ongoing posix
acl rework. The actual rework where we build a type safe posix acl api wasn't
ready for this merge window but we're hopeful for the v6.2 merge window.

General fixes:
* Some filesystems like 9p and cifs have to implement custom posix acl handlers
  because they require access to the dentry in order to set and get posix acls
  while the set and get inode operations currently don't. But the ntfs3
  filesystem has no such requirement and thus implemented custom posix acl
  xattr handlers when it really didn't have to. So this pr contains patch that
  just implements set and get inode operations for ntfs3 and switches it to
  rely on the generic posix acl xattr handlers. (We would've appreciated
  reviews from the ntfs3 maintainers but we didn't get any. But hey, if we
  really broke it we'll fix it. But fstests for ntfs3 said it's fine.)
* The posix_acl_fix_xattr_common() helper has been adapted so it can be used by
  a few more callers and avoiding open-coding the same checks over and over.

Other than the two general fixes this series introduces a new helper
vfs_set_acl_prepare(). The reason for this helper is so that we can mitigate
one of the source that change {g,u}id values directly in the uapi struct. With
the vfs_set_acl_prepare() helper we can move the idmapped mount fixup into the
generic posix acl set handler.

The advantage of this is that it allows us to remove the
posix_acl_setxattr_idmapped_mnt() helper which so far we had to call in
vfs_setxattr() to account for idmapped mounts. While semantically correct the
problem with this approach was that we had to keep the value parameter of the
generic vfs_setxattr() call as non-const. This is rectified in this series.

Ultimately, we will get rid of all the extreme kludges and type unsafety once
we have merged the posix api - hopefully during the next merge window - built
solely around get and set inode operations. Which incidentally will also
improve handling of posix acls in security and especially in integrity modesl.
While this will come with temporarily having two inode operation for posix acls
that is nothing compared to the problems we have right now and so well worth
it. We'll end up with something that we can actually reason about instead of
needing to write novels to explain what's going on.

/* Testing */
clang: Ubuntu clang version 14.0.0-1ubuntu1
gcc:   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0

All patches are based on v6.0-rc3 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.prep.v6.1

for you to fetch changes up to 38e316398e4e6338b80223fb5f74415c0513718f:

  xattr: always us is_posix_acl_xattr() helper (2022-09-21 12:01:29 +0200)

Please consider pulling these changes from the signed fs.acl.rework.prep.v6.1 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.acl.rework.prep.v6.1

----------------------------------------------------------------
Christian Brauner (7):
      ntfs3: rework xattr handlers and switch to POSIX ACL VFS helpers
      acl: return EOPNOTSUPP in posix_acl_fix_xattr_common()
      acl: add vfs_set_acl_prepare()
      acl: move idmapping handling into posix_acl_xattr_set()
      ovl: use vfs_set_acl_prepare()
      xattr: constify value argument in vfs_setxattr()
      xattr: always us is_posix_acl_xattr() helper

Deming Wang (1):
      acl: fix the comments of posix_acl_xattr_set

 fs/ntfs3/inode.c                  |   2 -
 fs/ntfs3/xattr.c                  | 102 +-------------
 fs/overlayfs/overlayfs.h          |   2 +-
 fs/overlayfs/super.c              |  15 +-
 fs/posix_acl.c                    | 288 +++++++++++++++++++++++++++++---------
 fs/xattr.c                        |  15 +-
 include/linux/posix_acl_xattr.h   |  12 +-
 include/linux/xattr.h             |   2 +-
 security/integrity/evm/evm_main.c |  17 ++-
 9 files changed, 264 insertions(+), 191 deletions(-)
