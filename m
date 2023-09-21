Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AC7A9E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjIUUDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjIUUC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3055AD9;
        Thu, 21 Sep 2023 10:17:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FB6C4AF76;
        Thu, 21 Sep 2023 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695295279;
        bh=fVVo5CGjmoTrDLohJ9ZKU62AzWMqTdXDrmh8HmbAnAw=;
        h=From:To:Cc:Subject:Date:From;
        b=ODfSb6EjfykZpE3HrSopjEK/BK1PyzLnKbNHkJIkcWyv4bGTmBj3ktIWfVePNGOWZ
         EEJgbpwrwKfkJ9kR9ajlB7VRsj4q8p0UpLaNhb3sbgGbSbR21o8d21jFlm2PtrL7kx
         yhVpj5nLUYhuW/exeh8DqEhrkJkItK6bTYf46L9ziCP/CvriLtx0cUpQ6rzFt1tKyY
         aagqktlEglO3q6N4+qtJUPH2b/n3H58zF8qWJd2V0cQmF1qm7zzJamzsqvV9WBBMop
         3DtFA3fCa4tA596rTyE3Yff3Q0z7v0pxHp3R7bBLDX3saPfzexFaaVAitKVtNoyAVY
         TQv6gCiNkZrxQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL v2] timestamp fixes
Date:   Thu, 21 Sep 2023 13:20:46 +0200
Message-Id: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3925; i=brauner@kernel.org; h=from:subject:message-id; bh=j9lEKBPMAlQacBeEOeO4BOezmWwvVo5irFSmBZvb5CQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTyKAerzjBeL3nFMWUva7Kg2tuwP/WZSSyaDdfWSwccySsO M83uKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhjN4Z/ujpM2g6cx7INrxrxson//3 pZ8cMvXact0/4vLPp1zfu/H8N/F1WB82tyON8Yb+BS2v5Kamf/NKN5XVeDpphKF27bt/Q2EwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Earlier this week we sent a few minor fixes for the multi-grained
timestamp work in [1]. While we were polishing those up after Linus
realized that there might be a nicer way to fix them we received a
regression report in [2] that fine grained timestamps break gnulib tests
and thus possibly other tools.

The kernel will elide fine-grain timestamp updates when no one is
actively querying for them to avoid performance impacts. So a sequence
like write(f1) stat(f2) write(f2) stat(f2) write(f1) stat(f1) may result
in timestamp f1 to be older than the final f2 timestamp even though f1
was last written too but the second write didn't update the timestamp.

Such plotholes can lead to subtle bugs when programs compare timestamps.
For example, the nap() function in [2] will estimate that it needs to
wait one ns on a fine-grain timestamp enabled filesytem between
subsequent calls to observe a timestamp change. But in general we don't
update timestamps with more than one jiffie if we think that no one is
actively querying for fine-grain timestamps to avoid performance
impacts.

While discussing various fixes the decision was to go back to the
drawing board and ultimately to explore a solution that involves only
exposing such fine-grained timestamps to nfs internally and never to
userspace.

As there are multiple solutions discussed the honest thing to do here is
not to fix this up or disable it but to cleanly revert. The general
infrastructure will probably come back but there is no reason to keep
this code in mainline.

The general changes to timestamp handling are valid and a good cleanup
that will stay. The revert is fully bisectable.

Link: [1]: https://lore.kernel.org/all/20230918-hirte-neuzugang-4c2324e7bae3@brauner
Link: [2]: https://lore.kernel.org/all/bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. xfstests pass without
regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert

for you to fetch changes up to 647aa768281f38cb1002edb3a1f673c3d66a8d81:

  Revert "fs: add infrastructure for multigrain timestamps" (2023-09-20 18:05:31 +0200)

Please consider pulling these changes from the signed v6.6-rc3.vfs.ctime.revert tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-rc3.vfs.ctime.revert

----------------------------------------------------------------
Christian Brauner (5):
      Revert "tmpfs: add support for multigrain timestamps"
      Revert "xfs: switch to multigrain timestamps"
      Revert "ext4: switch to multigrain timestamps"
      Revert "btrfs: convert to multigrain timestamps"
      Revert "fs: add infrastructure for multigrain timestamps"

 fs/btrfs/file.c                 | 24 ++++++++++--
 fs/btrfs/super.c                |  5 +--
 fs/ext4/super.c                 |  2 +-
 fs/inode.c                      | 82 ++---------------------------------------
 fs/stat.c                       | 41 +--------------------
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +--
 fs/xfs/xfs_iops.c               |  6 +--
 fs/xfs/xfs_super.c              |  2 +-
 include/linux/fs.h              | 46 +----------------------
 mm/shmem.c                      |  2 +-
 10 files changed, 38 insertions(+), 178 deletions(-)
