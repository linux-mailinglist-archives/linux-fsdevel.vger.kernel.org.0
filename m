Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA83D59BF4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiHVMLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHVMLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046139BBE;
        Mon, 22 Aug 2022 05:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C66E60F54;
        Mon, 22 Aug 2022 12:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8CEC433D6;
        Mon, 22 Aug 2022 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661170308;
        bh=qlFZMRmORJx3pmxEKn6IHSdAQDOoiVQCJitACZQ+pxw=;
        h=From:To:Cc:Subject:Date:From;
        b=QFJviwCYstOFDQOqrRCt8gOwzCDCAEE5h+veoHYoCCT/3NwFmfxc2Eq9m28PIJv2y
         ChKMNCEtMhEpsBIkhbd4pq7uu+kjzWLnKGZrRIPph7/BX5fXU84Y4/hxQCKUC5xbhP
         imfyjgcV3iM2LZuGVavEuPjnlclfboBnczqbDnRBduOrfvcpnAHD69y4Zu2QUA4XJU
         D6dWTDlqFEFIQx9KfcLf9/8mscMD1Zg6IvsAQTTVEkwHyyKRhk9001qiyj7CasJGJK
         0+OJAWrW6hbMPAr/S6OkzwHrc7pnbc3YMpdbhRjf92ZHUyIkGTXbR7VBcUc0nBCiKl
         kCYCPXxg0b8GQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] fs idmapped fixes for v6.0-rc3
Date:   Mon, 22 Aug 2022 14:11:25 +0200
Message-Id: <20220822121125.715295-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a few fixes:

- Since Seth joined as co-maintainer for idmapped mounts we decided to use a
  shared git tree. Konstantin suggested we use vfs/idmapping.git on kernel.org
  under the vfs/ namespace. So this updates the tree in the maintainers file.

- Ensure that POSIX ACLs checking, getting, and setting works correctly
  for filesystems mountable with a filesystem idmapping that want to support
  idmapped mounts. Since no filesystems mountable with an fs_idmapping do yet
  support idmapped mounts there is no problem. But this could change in the
  future, so add a check to refuse to create idmapped mounts when the mounter
  is not privileged over the mount's idmapping.

- Check that caller is privileged over the idmapping that will be attached to a
  mount. Currently no FS_USERNS_MOUNT filesystems support idmapped mounts, thus
  this is not a problem as only CAP_SYS_ADMIN in init_user_ns is allowed to set
  up idmapped mounts. But this could change in the future, so add a check to
  refuse to create idmapped mounts when the mounter is not privileged over the
  mount's idmapping.

- Fix POSIX ACLs for ntfs3. While looking at our current POSIX ACL handling in
  the context of some overlayfs work I went through a range of other
  filesystems checking how they handle them currently and encountered a few
  bugs in ntfs3. I've sent this some time ago and the fixes haven't been picked
  up even though the pull request for other ntfs3 fixes got sent after. This
  should really be fixed as right now POSIX ACLs are broken in certain
  circumstances for ntfs3.

/* Testing */
All patches are based on v6.0-rc1 and have been sitting in linux-next. No build
failures or warnings were observed and fstests, selftests, and LTP have seen no
regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.fixes.v6.0-rc3

for you to fetch changes up to 0c3bc7899e6dfb52df1c46118a5a670ae619645f:

  ntfs: fix acl handling (2022-08-22 12:52:23 +0200)

Please consider pulling these changes from the signed fs.idmapped.fixes.v6.0-rc3 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.fixes.v6.0-rc3

----------------------------------------------------------------
Christian Brauner (3):
      acl: handle idmapped mounts for idmapped filesystems
      MAINTAINERS: update idmapping tree
      ntfs: fix acl handling

Seth Forshee (1):
      fs: require CAP_SYS_ADMIN in target namespace for idmapped mounts

 MAINTAINERS          |  2 +-
 fs/namespace.c       |  7 +++++++
 fs/ntfs3/xattr.c     | 16 +++++++---------
 fs/overlayfs/inode.c | 11 +++++++----
 fs/posix_acl.c       | 15 +++++++++------
 5 files changed, 31 insertions(+), 20 deletions(-)
