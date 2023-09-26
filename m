Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204217AEA98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjIZKkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjIZKkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:40:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA2E9;
        Tue, 26 Sep 2023 03:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D7C433C7;
        Tue, 26 Sep 2023 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695724838;
        bh=dtT04ZMDIHIvPNTTfwCyt75ZEg4N+PxB7OCPC8ssoos=;
        h=From:To:Cc:Subject:Date:From;
        b=OSJafnELLvZRJG/7gES5p79MhqQRZl1MW77t/hJf6Fj7MxESi2KQs8WvVSsi4O/q5
         9GQvRTqv1B2di1ZLlKh2dEvi8ir8xQSVK7/LSTMJVTtL73C8DtINc+jOxT+RbvDxIv
         ckR4t9HagztbQH4e4Yc34fJoLkuReHh+hhja1SoWkfu11fAj1WnxjNEdEyUP/0C17y
         zJBYpHZOdUhatPp4paSgKzQ5YivCnr0WytREq/IwjC4qjgh/B/Nwiv2Fro+b2bPkBc
         rge/ahvHe7GNNfRWiqGPApSiFPH6pJ2EZtSnBNJSH5M47hNYVmKan+/22rfNIH2oAX
         yWzRDwbMWDWzA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Tue, 26 Sep 2023 12:39:55 +0200
Message-Id: <20230926-vervielfachen-umgegangen-07e8d8f5a3a7@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015; i=brauner@kernel.org; h=from:subject:message-id; bh=dtT04ZMDIHIvPNTTfwCyt75ZEg4N+PxB7OCPC8ssoos=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQKbXkeOtlyW3H64fMH5hRNOpDJvnz9WoVfLxS2bjr20mkJ n5fj2Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ/OBj+M22dPHnuT5dPvkL7iuJVr Rx8/2d+drm3IsfmjLWyv9mdaQxMpwsMVIQ2L/x/rPZDS57dm/fI/Tjg9i3qWYb50ZOZguSMWEDAA==
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
This contains the usual miscellaneous fixes and cleanups for vfs and
individual fses:

Fixes
=====

* Revert ki_pos on error from buffered writes for direct io fallback
* Add missing documentation for block device and superblock handling
  for changes merged this cycle.
* Fix reiserfs flexible array usage
* Ensure that overlayfs sets ctime when setting mtime and atime.
* Disable deferred caller completions with overlayfs writes until proper
  support exists.

Cleanups
========

* Remove duplicate initialization in pipe code.
* Annotate aio kioctx_table with __counted_by.

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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc4.vfs.fixes

for you to fetch changes up to 03dbab3bba5f009d053635c729d1244f2c8bad38:

  overlayfs: set ctime when setting mtime and atime (2023-09-25 14:53:54 +0200)

Please consider pulling these changes from the signed v6.6-rc4.vfs.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-rc4.vfs.fixes

----------------------------------------------------------------
Al Viro (1):
      direct_write_fallback(): on error revert the ->ki_pos update from buffered write

Christian Brauner (3):
      porting: document new block device opening order
      porting: document superblock as block device holder
      ntfs3: put resources during ntfs_fill_super()

Chunhai Guo (1):
      fs-writeback: do not requeue a clean inode having skipped pages

Jeff Layton (1):
      overlayfs: set ctime when setting mtime and atime

Jens Axboe (1):
      ovl: disable IOCB_DIO_CALLER_COMP

Kees Cook (1):
      aio: Annotate struct kioctx_table with __counted_by

Max Kellermann (1):
      fs/pipe: remove duplicate "offset" initializer

Shigeru Yoshida (1):
      reiserfs: Replace 1-element array with C99 style flex-array

 Documentation/filesystems/porting.rst | 96 +++++++++++++++++++++++++++++++++++
 fs/aio.c                              |  2 +-
 fs/fs-writeback.c                     | 11 ++--
 fs/libfs.c                            |  1 +
 fs/ntfs3/super.c                      |  1 +
 fs/overlayfs/copy_up.c                |  2 +-
 fs/overlayfs/file.c                   |  6 +++
 fs/pipe.c                             |  1 -
 fs/reiserfs/reiserfs.h                |  6 +--
 9 files changed, 117 insertions(+), 9 deletions(-)
