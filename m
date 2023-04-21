Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD56EAC39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjDUOCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDUOCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C2E55;
        Fri, 21 Apr 2023 07:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D479C61583;
        Fri, 21 Apr 2023 14:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC683C433D2;
        Fri, 21 Apr 2023 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682085724;
        bh=GjXQ675p/iRLIFKflcG4u7AegZ/RXFqFmNR23jX6N2M=;
        h=From:To:Cc:Subject:Date:From;
        b=QnZ4BywcF++EQGowkx8Cd7BlnvUfSEfiMTHNH4i1lFu6L0zMuOQN9xpMdlABrSYT7
         Icb7bQDNlza7Z8lxXWQJt2txRa6/otzdVk+9nl+8+bHq93KXzpbbRJbGo5CM+TsMYB
         eMLHNhSvFbRa/aGqQr8/2nP/NrTWfbeBV1N7COx/mSP5HftKXIPqJ+dOqLWw9MrCn9
         5+ltMcUjmNmZj0vhP8Zet52f3SdEsFVN9sDyyz3ZEGL5lIpuvUB/hGHun04U3sNAcg
         dT1J+U1z1V9VszNJVNtbbuz9PD7dYmAEJrqiUWgcd7R9Z2f8dYzQaPV/rq/kZMv3VS
         8p0leTvnv8q3g==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] pipe: nonblocking rw for io_uring
Date:   Fri, 21 Apr 2023 16:01:20 +0200
Message-Id: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=brauner@kernel.org; h=from:subject:message-id; bh=GjXQ675p/iRLIFKflcG4u7AegZ/RXFqFmNR23jX6N2M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4Tddw/94i1OexN8ApvNT/xe230lwXapp59m3QeZizudZq yuyGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl41DP8FfkoJ860307/a6wVd/z9LW c0p0u/2sK683ip6wPmBMY3nxj+Z/Fs5W0wvqn8ccY5F13d0FTZAscU63ufjY1T1hzWu7OYHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
This contains Jens' work to support FMODE_NOWAIT and thus IOCB_NOWAIT
for pipes ensuring that all places can deal with non-blocking requests.

To this end, pass down the information that this is a nonblocking
request so that pipe locking, allocation, and buffer checking correctly
deal with those.

The series is small but it felt standalone enough that I didn't want to
lump it together with other, generic vfs work.

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.pipe

for you to fetch changes up to ec30adeb289d9054efae4e285b269438ce63fe03:

  pipe: set FMODE_NOWAIT on pipes (2023-03-15 11:37:29 -0600)

Please consider pulling these changes from the signed v6.4/vfs.pipe tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/vfs.pipe

----------------------------------------------------------------
Jens Axboe (3):
      fs: add 'nonblock' parameter to pipe_buf_confirm() and fops method
      pipe: enable handling of IOCB_NOWAIT
      pipe: set FMODE_NOWAIT on pipes

 fs/fuse/dev.c             |  4 ++--
 fs/pipe.c                 | 42 ++++++++++++++++++++++++++++++++++--------
 fs/splice.c               | 11 +++++++----
 include/linux/pipe_fs_i.h |  8 +++++---
 4 files changed, 48 insertions(+), 17 deletions(-)
