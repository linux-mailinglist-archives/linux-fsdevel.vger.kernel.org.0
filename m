Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA573B5CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjFWLDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjFWLCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB533122;
        Fri, 23 Jun 2023 04:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 504B7619E0;
        Fri, 23 Jun 2023 11:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB18C433C0;
        Fri, 23 Jun 2023 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687518170;
        bh=mlI8K08MzM5m3JjVgDq9GxCQe4cRTjyatamBhWUUweo=;
        h=From:To:Cc:Subject:Date:From;
        b=te3ffebRjh7keh6XQMXGwSfWE6jgKiETiay197E0+yQsaL/4CXgmreoEcPAeWlIBM
         QZStydpBYOx+zJG7ginnoRJSKhsxXwk3J+wDqNsabInFTIc2Ipljz2cc4yNEovHkbO
         O81Ugv9wV02UrZsGdEx2rBrdYNfSKTSkpmRY+r9W3l5lYr9isfQByGuxdjheK/4O5S
         5GYej0e9d6LvG71c9+mqMEZ1P7Az/WVs3JwMsCxdE4g7rgW7VP90HGVSud0NHQdSgc
         RoClv0wp0QCgRn28jfUHgim3gNT8ct//Npea8Gfqs85ExTCacQWno+H+3Upb1U/dm9
         qWobMiGR6xjbw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs: rename
Date:   Fri, 23 Jun 2023 13:02:37 +0200
Message-Id: <20230623-gebacken-abenteuer-00d6913052b6@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; i=brauner@kernel.org; h=from:subject:message-id; bh=mlI8K08MzM5m3JjVgDq9GxCQe4cRTjyatamBhWUUweo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMrT66Yf6frc8mlJzR7clxmtNl7OF/SmLBuyt2J6qvbb+3 R2l9dEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEZK8w/LMXFNh6L/GJxeOo1SWL2s 9c15+/eoHqqk41pgTxm256TTKMDGs0O+a8n5K6+qS2ddi7pPepL81/dIsdZfvOFOyTfGf6Pj4A
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
This contains the work from Jan to fix problems with cross-directory
renames originally reported in [1].

To quickly sum it up some filesystems (so far we know at least about
ext4, udf, f2fs, ocfs2, likely also reiserfs, gfs2 and others) need to
lock the directory when it is being renamed into another directory.

This is because we need to update the parent pointer in the directory in
that case and if that races with other operations on the directory, in
particular a conversion from one directory format into another, bad
things can happen.

So far we've done the locking in the filesystem code but recently
Darrick pointed out in [2] that the RENAME_EXCHANGE case was missing.
That one is particularly nasty because RENAME_EXCHANGE can arbitrarily
mix regular files and directories and proper lock ordering is not
achievable in the filesystems alone.

This patch set adds locking into vfs_rename() so that not only parent
directories but also moved inodes, regardless of whether they are
directories or not, are locked when calling into the filesystem.

This means establishing a locking order for unrelated directories. New
helpers are added for this purpose and our documentation is updated to
cover this in detail.

The locking is now actually easier to follow as we now always lock
source and target. We've always locked the target independent of whether
it was a directory or file and we've always locked source if it was a
regular file. The exact details for why this came about can be found in
[3] and [4].

Link: https://lore.kernel.org/all/20230117123735.un7wbamlbdihninm@quack3 [1]
Link: https://lore.kernel.org/all/20230517045836.GA11594@frogsfrogsfrogs [2]
Link: https://lore.kernel.org/all/20230526-schrebergarten-vortag-9cd89694517e@brauner [3]
Link: https://lore.kernel.org/all/20230530-seenotrettung-allrad-44f4b00139d4@brauner [4]

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.rename.locking

for you to fetch changes up to 2454ad83b90afbc6ed2c22ec1310b624c40bf0d3:

  fs: Restrict lock_two_nondirectories() to non-directory inodes (2023-06-07 09:15:11 +0200)

Please consider pulling these changes from the signed v6.5/vfs.rename.locking tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.rename.locking

----------------------------------------------------------------
Jan Kara (6):
      ext4: Remove ext4 locking of moved directory
      Revert "udf: Protect rename against modification of moved directory"
      Revert "f2fs: fix potential corruption when moving a directory"
      fs: Establish locking order for unrelated directories
      fs: Lock moved directories
      fs: Restrict lock_two_nondirectories() to non-directory inodes

 Documentation/filesystems/directory-locking.rst | 26 ++++++-----
 fs/ext4/namei.c                                 | 17 +------
 fs/f2fs/namei.c                                 | 16 +------
 fs/inode.c                                      | 62 +++++++++++++++++++++----
 fs/internal.h                                   |  2 +
 fs/namei.c                                      | 26 +++++++----
 fs/udf/namei.c                                  | 14 +-----
 7 files changed, 89 insertions(+), 74 deletions(-)
