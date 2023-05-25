Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20936710BF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjEYMXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjEYMXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 08:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38F122;
        Thu, 25 May 2023 05:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBE361B5A;
        Thu, 25 May 2023 12:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE68C433D2;
        Thu, 25 May 2023 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685017381;
        bh=TfsHUqu/blr/IyI0WqAtClGtTQuNcd0hr48jhLxujB0=;
        h=From:To:Cc:Subject:Date:From;
        b=A06iJ7Ql+at001pC6yvvgCL/vwgHmGT8bzViTT563KCukJc8HqSqZm94h78D2ix9S
         RIcavnk1NRsP5128f6XZ+D6DMLzGA0oayyaHIR2KaXsoLi4w5AwM1mDCIziodMsTh/
         rVZuN6RanrOuSWIZPNnx3P96vEdBWCR2xzFOKdK7H4MlnKqDHAP8sqPP5CGY/LzwtH
         q5oeeA/Q2MT8l+x7+rlA5zNwOIU4IY4jQ6WqcNjCXxoOn/n5tv8NECoLEOhJO/K/9m
         PjYkprjrfLBg5DuHFHdeJYXX2RFXqDc5OHV3HN9Z2uOUlfX4tUhMxTYxMQtZXV8NtT
         yziAx2gybaeTg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Thu, 25 May 2023 14:22:35 +0200
Message-Id: <20230525-dickicht-abwirft-04c67a09af05@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=brauner@kernel.org; h=from:subject:message-id; bh=TfsHUqu/blr/IyI0WqAtClGtTQuNcd0hr48jhLxujB0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTkBzO8779nf7p5RXqY/NPu9g6BV7OM9xamtfJMmplx8sLO 0vLzHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZNY2RYckNlzP2nFGi++1vZrxZtf qKBVNfFlNHUNvHlDh33w7jc4wMnawybDMMGM3O91acF3168OXOXWweG/W1M9cWrTZRFdzDCAA=
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
This contains a small set of fixes:

* During the acl rework we merged this cycle the generic_listxattr()
  helper had to be modified in a way that in principle it would allow
  for POSIX ACLs to be reported. At least that was the impression we had
  initially. Because before the acl rework POSIX ACLs would be reported
  if the filesystem did have POSIX ACL xattr handlers in sb->s_xattr.
  That logic changed and now we can simply check whether the superblock
  has SB_POSIXACL set and if the inode has inode->i_{default_}acl set
  report the appropriate POSIX ACL name.

  However, we didn't realize that generic_listxattr() was only ever used
  by two filesystems. Both of them don't support POSIX ACLs via
  sb->s_xattr handlers and so never reported POSIX ACLs via
  generic_listxattr() even if they raised SB_POSIXACL and did contain
  inodes which had acls set. The example here is nfs4. So
  generic_listxattr() suddenly started reporting POSIX ACLs when it
  wouldn't have before.
  Since SB_POSIXACL implies that the umask isn't stripped in the VFS
  nfs4 can't just drop SB_POSIXACL from the superblock as it would also
  alter umask handling for them. So just have generic_listxattr() not
  report POSIX ACLs as it never did anyway. It's documented as such.

* Our SB_* flags currently use a signed integer and we shift the last
  bit causing UBSAN to complain about undefined behavior. Switch to
  using unsigned. While the original patch used an explicit unsigned
  bitshift it's now pretty common to rely on the BIT() macro in a lot of
  headers nowadays. So the patch has been adjusted to use that.

* Add Namjae as ntfs reviewer. They're already active this cycle so
  let's make it explicit right now.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc3/misc.fixes

for you to fetch changes up to 48524463f807ec516a291bdf717dcf2c8e059f51:

  ntfs: Add myself as a reviewer (2023-05-17 15:25:21 +0200)

Please consider pulling these changes from the signed vfs/v6.4-rc2/misc.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs/v6.4-rc2/misc.fixes

----------------------------------------------------------------
Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Jeff Layton (1):
      fs: don't call posix_acl_listxattr in generic_listxattr

Namjae Jeon (1):
      ntfs: Add myself as a reviewer

 MAINTAINERS        |  1 +
 fs/xattr.c         | 15 +++++++++------
 include/linux/fs.h | 42 +++++++++++++++++++++---------------------
 3 files changed, 31 insertions(+), 27 deletions(-)
