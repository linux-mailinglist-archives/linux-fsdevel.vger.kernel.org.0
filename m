Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48E4AA609
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 03:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379035AbiBECvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 21:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBECvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:51:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D9C061346;
        Fri,  4 Feb 2022 18:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3B4DB83993;
        Sat,  5 Feb 2022 02:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03DEC004E1;
        Sat,  5 Feb 2022 02:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644029460;
        bh=zCkSrwsTvXNWHFZqcGD+oPhhhUqH+dS9wc6XoB/LPoI=;
        h=Date:From:To:Cc:Subject:From;
        b=Kga+CoEfYETsRUtYR9CiX4upq7s1vdi08iK/kFs0/z7fvpgidPpJOOJXw7+c+mi/f
         wRKIydzJkATbhy5iJRx8G2mlMuijfhoe98TiL4YHJn3N3X6pTJf2sI98/wKLB75VoS
         PW6BODJ9f4Mu1kRAd39cNLMUGfwbdMoOVpZY1sGz4cPKz9fns32oNReh2AwQTxuBr+
         QcZMRnizYnx/0SM3ZTShlTC0eotU1vsSGboGTdtjiQ8MQeJp8Cnc70yzhjEFOzw8a4
         2laAvfCgpyXPRyS/tRHzZJ+9QJXtYuPJQKtfUgThB3sJx+LjmvdKjaufvbWF29uyNu
         Y8xWPO6Ig+lYA==
Date:   Fri, 4 Feb 2022 18:51:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] vfs: fixes for 5.17-rc1
Message-ID: <20220205025100.GW8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch of VFS bugfixes for 5.17-rc3.  I was auditing
the sync_fs code paths recently and noticed that most callers of
->sync_fs ignore its return value (and many implementations never return
nonzero even if the fs is broken!), which means that internal fs errors
and corruption are not passed up to userspace callers of syncfs(2) or
FIFREEZE.  Hence fixing the common code and XFS, and I'll start working
on the ext4/btrfs folks if this is merged.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.17-fixes-2

for you to fetch changes up to 2d86293c70750e4331e9616aded33ab6b47c299d:

  xfs: return errors in xfs_fs_sync_fs (2022-01-30 08:59:47 -0800)

----------------------------------------------------------------
Fixes for 5.17-rc3:
 - Fix a bug where callers of ->sync_fs (e.g. sync_filesystem and
   syncfs(2)) ignore the return value.
 - Fix a bug where callers of sync_filesystem (e.g. fs freeze) ignore
   the return value.
 - Fix a bug in XFS where xfs_fs_sync_fs never passed back error
   returns.

----------------------------------------------------------------
Darrick J. Wong (4):
      vfs: make freeze_super abort when sync_filesystem returns error
      vfs: make sync_filesystem return errors from ->sync_fs
      quota: make dquot_quota_sync return errors from ->sync_fs
      xfs: return errors in xfs_fs_sync_fs

 fs/quota/dquot.c   | 11 ++++++++---
 fs/super.c         | 19 ++++++++++++-------
 fs/sync.c          | 18 ++++++++++++------
 fs/xfs/xfs_super.c |  6 +++++-
 4 files changed, 37 insertions(+), 17 deletions(-)
