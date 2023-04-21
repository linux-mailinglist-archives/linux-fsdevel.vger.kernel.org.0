Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C56EAC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjDUODT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDUODN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D6610243;
        Fri, 21 Apr 2023 07:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D844F60FFF;
        Fri, 21 Apr 2023 14:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B65C433EF;
        Fri, 21 Apr 2023 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682085784;
        bh=TzSt5rPtlHC5/DwRXlxq0+rhkiv5h7lAEaw4wlk0u6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=dZSCqNfaKDjPH1rgAYVT9j+20tukT3bklGBsPZElXQpdYPo7Sg03LjWVmYlye3wLH
         cRTjZj0MqmToOTubzAYi2t+cUx6SPCahOsDTyo9jcwSE2tQtxoqdek6c2umUQrhXyv
         4wOroZiWxPzpUEPCU0+ge+0GJWjAr6I7isbvzozl8zAiCjGpY1iTK4WQdD32bTi5r0
         CSHkatr4f9b59LeyueuKkum1+YNpUr/iZ2LHdILYvacN+lk9YKohZtZiNZp2BP+eUI
         6qPQntl3Wub4tzi2zaYhjS3Ef8C2zmVtO94jEjv7QJvDgt9j6sjL7PpWnlHbcq5OGY
         YAnu4PIEFtZSA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
Date:   Fri, 21 Apr 2023 16:02:56 +0200
Message-Id: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6423; i=brauner@kernel.org; h=from:subject:message-id; bh=TzSt5rPtlHC5/DwRXlxq0+rhkiv5h7lAEaw4wlk0u6Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4TU+cMsdn0mJLgZaKR+uTFaa9kqg7/C+8eVp9w3HDljXT V8kv7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/xiGfzZzT6Wn7+g41lk8nzvdiP VGzCxzhY8+7FmtB3ctDr+10pWRoU3JbL+B46fUGIas3ynfPHUezU62/CR4fdm3tr+XVy0pZwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
EINVAL ist keinmal: This contains the changes to make O_DIRECTORY when
specified together with O_CREAT an invalid request.

The wider background is that a regression report about the behavior of
O_DIRECTORY | O_CREAT was sent to fsdevel about a behavior that was
changed multiple years and LTS releases earlier during v5.7 development.

On kernels prior to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
had the following semantics:

        open("/tmp/d", O_DIRECTORY | O_CREAT)
        * d doesn't exist:                create regular file
        * d exists and is a regular file: ENOTDIR
        * d exists and is a directory:    EISDIR

        open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
        * d doesn't exist:                create regular file
        * d exists and is a regular file: EEXIST
        * d exists and is a directory:    EEXIST

        open("/tmp/d", O_DIRECTORY | O_EXCL)
        * d doesn't exist:                ENOENT
        * d exists and is a regular file: ENOTDIR
        * d exists and is a directory:    open directory

On kernels since to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
have the following semantics:

        open("/tmp/d", O_DIRECTORY | O_CREAT)
        * d doesn't exist:                ENOTDIR (create regular file)
        * d exists and is a regular file: ENOTDIR
        * d exists and is a directory:    EISDIR

        open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
        * d doesn't exist:                ENOTDIR (create regular file)
        * d exists and is a regular file: EEXIST
        * d exists and is a directory:    EEXIST

        open("/tmp/d", O_DIRECTORY | O_EXCL)
        * d doesn't exist:                ENOENT
        * d exists and is a regular file: ENOTDIR
        * d exists and is a directory:    open directory

This is a fairly substantial semantic change that userspace didn't
notice until someone took the time to _deliberately_ figure out corner
cases. Since no one noticed this breakage it can somewhat safely be
assumed that O_DIRECTORY | O_CREAT combinations are likely unused.

The v5.7 breakage is especially weird because while ENOTDIR is returned
indicating failure a regular file is actually created. This doesn't make
a lot of sense.

Time was spent finding potential users of this combination. Searching on
codesearch.debian.net showed that codebases often express semantical
expectations about O_DIRECTORY | O_CREAT which are completely contrary
to what the code has done and currently does.

The expectation often is that this particular combination would create
and open a directory. This suggests users who tried to use that
combination would stumble upon the counterintuitive behavior no matter
if pre-v5.7 or post v5.7 and quickly realize neither semantics give them
what they want.

There are various ways to address this issue. The lazy/simple option
would be to restore the pre-v5.7 behavior and to just live with that bug
forever. But since there's a real chance that the O_DIRECTORY | O_CREAT
quirk isn't relied upon it was agreed to make this an invalid request
instead.

With this pull request, EINVAL is returned for O_DIRECTORY | O_CREAT
combinations. Now, the following semantics apply:

        open("/tmp/d", O_DIRECTORY | O_CREAT)
        * d doesn't exist:                EINVAL
        * d exists and is a regular file: EINVAL
        * d exists and is a directory:    EINVAL

        open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
        * d doesn't exist:                EINVAL
        * d exists and is a regular file: EINVAL
        * d exists and is a directory:    EINVAL

        open("/tmp/d", O_DIRECTORY | O_EXCL)
        * d doesn't exist:                ENOENT
        * d exists and is a regular file: ENOTDIR
        * d exists and is a directory:    open directory

One additional note, O_TMPFILE is implemented as:

        #define __O_TMPFILE    020000000
        #define O_TMPFILE      (__O_TMPFILE | O_DIRECTORY)
        #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

For older kernels it was important to return an explicit error when
O_TMPFILE wasn't supported. So O_TMPFILE requires that O_DIRECTORY is
raised alongside __O_TMPFILE. It also enforced that O_CREAT wasn't
specified. Since O_DIRECTORY | O_CREAT could be used to create a regular
allowing that combination together with __O_TMPFILE would've meant that
false positives were possible, i.e., that a regular file was created
instead of a O_TMPFILE. This could've been used to trick userspace into
thinking it operated on a O_TMPFILE when it wasn't. Now that O_DIRECTORY
with O_CREAT is completely blocked the interaction and checks for
O_TMPFILE are simplified as well.

This has also been covered in

        https://lwn.net/Articles/926782/

which should be publicly available by now. It provides an excellent
summary of the discussion.

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc3 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.open

for you to fetch changes up to 43b450632676fb60e9faeddff285d9fac94a4f58:

  open: return EINVAL for O_DIRECTORY | O_CREAT (2023-03-22 11:06:55 +0100)

Please consider pulling these changes from the signed v6.4/vfs.open tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/vfs.open

----------------------------------------------------------------
Christian Brauner (1):
      open: return EINVAL for O_DIRECTORY | O_CREAT

 fs/open.c                              | 18 +++++++++++++-----
 include/uapi/asm-generic/fcntl.h       |  1 -
 tools/include/uapi/asm-generic/fcntl.h |  1 -
 3 files changed, 13 insertions(+), 7 deletions(-)
