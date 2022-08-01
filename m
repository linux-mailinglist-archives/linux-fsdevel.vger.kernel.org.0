Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B21586CB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiHAOUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAOUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A6237F2;
        Mon,  1 Aug 2022 07:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A8E61305;
        Mon,  1 Aug 2022 14:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A34C433D6;
        Mon,  1 Aug 2022 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659363599;
        bh=1QCs0qzsHxnPAI9Bdfuyd55D+HqNh5iQyhLVzRjoDRo=;
        h=From:To:Cc:Subject:Date:From;
        b=j0AlTl1K5v4LB/AM1PKRzJRvGN/BwIIeYfX3RwIYaCHxMNNiZE0s6ER60B7Wurp7E
         +BzR/0Xtt70RZxb9QoSBWQmDllL7NE4R5CQms7YXXv2BH6aw8lkk3RZDjjn/DK0Cy+
         hTlJO50rcZjfBRP8OXFsXi62VXnpV5llQB3/HyWuLVzJtkbFW0c5c19juwwBRLTTjR
         wRoqPbg351J3mQJ/1pwrLmLRBsXDFV3nCLq+WiZOFPIyg6igLlcFH1cmkVEPIOkQbb
         gdsX94TcUBvWeRXYh+0cdGno47synsLs3yDa8wpulG9b4Mj/mNyQaiIheP3IFIjLaQ
         q+N9Yd8y2aNQg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] fs idmapped updates for v5.20/v6.0
Date:   Mon,  1 Aug 2022 16:19:42 +0200
Message-Id: <20220801141942.1525924-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This introduces the new vfs{g,u}id_t types we agreed on. Similar to k{g,u}id_t
the new types are just simple wrapper structs around regular {g,u}id_t types.

They allow to establish a type safety boundary in the VFS for idmapped mounts
preventing confusion betwen {g,u}ids mapped into an idmapped mount and {g,u}ids
mapped into the caller's or the filesystem's idmapping.

An initial set of helpers is introduced that allows to operate on vfs{g,u}id_t
types. We will remove all references to non-type safe idmapped mounts helpers
in the very near future. The patches do already exist.

This pull request converts the core attribute changing codepaths which become
significantly easier to reason about because of this change.

We will just give a few highlights here as the patches give detailed overviews
of what is happening in the commit messages:
* The kernel internal struct iattr contains type safe vfs{g,u}id_t values
  clearly communicating that these values have to take a given mount's
  idmapping into account.
* The ownership values placed in struct iattr to change ownership are identical
  for idmapped and non-idmapped mounts going forward. This also allows to
  simplify stacking filesystems such as overlayfs that change attributes In
  other words, they always represent the values.
* Instead of open coding checks for whether ownership changes have been
  requested and an actual update of the inode is required we now have small
  static inline wrappers that abstract this logic away removing a lot of code
  duplication from individual filesystems that all open-coded the same checks.

There will be a second pull request coming that contains the work to fix posix
acls for stacked filesystems such as overlayfs. This work has been announced by
Miklos in
72a8e05d4f66 ("Merge tag 'ovl-fixes-5.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs")

I could have sent this all in a single pull request but since they have very
distinct topics and the posix acl work came in later this didn't make a lot of
sense.

/* Testing */
All patches are based on v5.19-rc3 and have been sitting in linux-next. No
build failures or warnings were observed and fstests, selftests, and LTP have
seen no regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.vfsuid.v5.20

for you to fetch changes up to 77940f0d96cd2ec9fe2125f74f513a7254bcdd7f:

  mnt_idmapping: align kernel doc and parameter order (2022-06-29 16:34:41 +0200)

Please consider pulling these changes from the signed fs.idmapped.vfsuid.v5.20 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.vfsuid.v5.20

----------------------------------------------------------------
Christian Brauner (12):
      mnt_idmapping: add vfs{g,u}id_t
      fs: add two type safe mapping helpers
      fs: use mount types in iattr
      fs: introduce tiny iattr ownership update helpers
      fs: port to iattr ownership update helpers
      quota: port quota helpers mount ids
      security: pass down mount idmapping to setattr hook
      attr: port attribute changes to new types
      attr: fix kernel doc
      fs: port HAS_UNMAPPED_ID() to vfs{g,u}id_t
      mnt_idmapping: use new helpers in mapped_fs{g,u}id()
      mnt_idmapping: align kernel doc and parameter order

Seth Forshee (1):
      mnt_idmapping: return false when comparing two invalid ids

 fs/attr.c                         |  74 +++++-----
 fs/ext2/inode.c                   |   8 +-
 fs/ext4/inode.c                   |  14 +-
 fs/f2fs/file.c                    |  22 ++-
 fs/f2fs/recovery.c                |  10 +-
 fs/fat/file.c                     |   9 +-
 fs/jfs/file.c                     |   4 +-
 fs/ocfs2/file.c                   |   2 +-
 fs/open.c                         |  60 ++++++--
 fs/overlayfs/copy_up.c            |   4 +-
 fs/overlayfs/overlayfs.h          |  12 +-
 fs/quota/dquot.c                  |  17 ++-
 fs/reiserfs/inode.c               |   4 +-
 fs/xfs/xfs_iops.c                 |  14 +-
 fs/zonefs/super.c                 |   2 +-
 include/linux/evm.h               |   6 +-
 include/linux/fs.h                | 140 ++++++++++++++++++-
 include/linux/mnt_idmapping.h     | 279 +++++++++++++++++++++++++++++++++-----
 include/linux/quotaops.h          |  15 +-
 include/linux/security.h          |   8 +-
 security/integrity/evm/evm_main.c |  12 +-
 security/security.c               |   5 +-
 22 files changed, 546 insertions(+), 175 deletions(-)
