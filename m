Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE16B7BC902
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbjJGQIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 12:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJGQIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6CBD;
        Sat,  7 Oct 2023 09:08:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038AFC433C7;
        Sat,  7 Oct 2023 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696694893;
        bh=+cyM696m/k2jTAtUrb5GLyUHGjPZa2mGC4WL25ylQ1M=;
        h=From:To:Cc:Subject:Date:From;
        b=PgA/q1P+pmAkZpgECx8Y+iSEiEhiPGRFz8V2Xhb9oWtPTB1+UJP13PUpHhUyvMvVH
         HpqjVUQXnUISxXSwcyU1SLHs/EW2wZlPeDS+CQdWnvY0Oy5w/f9XjKdAw1N1ew7/DY
         ppfHnXQ8UmO2xRPQY2Z3GnvconsI5OGL1R52dyShbbsz2RaiWsNxbAjAtJVdvkW0fm
         rj0YwpSG8I2gfDrDiFBhkaFEY6AJIf+NjnYaDIv+Ic+iYkbJil6u5TmaxXWDxBq1Y0
         Ow94z89oTD8YpPozN81NA6BcBYK5YQnUK/HK0lUFA9sbgZWn1WoNHmXDUlAWdctVrz
         AHQZDLTqGj20g==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.6
Date:   Sat, 07 Oct 2023 21:32:15 +0530
Message-ID: <877cnyiff9.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.6-rc5. The changes are
limited to only bug fixes whose summary is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-3

for you to fetch changes up to 4e69f490d211ce4e11db60c05c0fcd0ac2f8e61e:

  Merge tag 'xfs-fstrim-busy-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.6-fixesC (2023-10-04 08:21:15 +0530)

----------------------------------------------------------------
Bug fixes for 6.6-rc5:

* Prevent filesystem hang when executing fstrim operations on large and slow
  storage.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Chandan Babu R (1):
      Merge tag 'xfs-fstrim-busy-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.6-fixesC

Dave Chinner (3):
      xfs: move log discard work to xfs_discard.c
      xfs: reduce AGF hold times during fstrim operations
      xfs: abort fstrim if kernel is suspending

 fs/xfs/xfs_discard.c     | 266 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_discard.h     |   6 +-
 fs/xfs/xfs_extent_busy.c |  34 ++++--
 fs/xfs/xfs_extent_busy.h |  24 ++++-
 fs/xfs/xfs_log_cil.c     |  93 +++--------------
 fs/xfs/xfs_log_priv.h    |   5 +-
 6 files changed, 311 insertions(+), 117 deletions(-)
