Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023B4E50F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiCWLEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbiCWLD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6240E66;
        Wed, 23 Mar 2022 04:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524CE612C6;
        Wed, 23 Mar 2022 11:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F274C340E8;
        Wed, 23 Mar 2022 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648033347;
        bh=sg4q872OUuXQuf/NinFOiVBav/JGmM4AocI/ddhr9pQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XLOq242XNSBHLZDDuVsJ8T+6eJB/xp9lUx2MnxwXDg2+WtveP+2wXM0UA7rdzvlUK
         wyJTzMzsPkjIIHwinha6BYBFhn5AYPopDy998IdIKDfB0csdjv81+9dHmxWgofEIjm
         hF3zBKuu2WfKHIIYA57smPGwqdKHOAURgpl5PloS/vCqKaOcsvBoQkOldBNsVKBFP6
         gKqKvCCmj4G35wYtK1a5+RbvhPgTs+owv8qQby9uTAr019hZl26eVL/aaQHCgb+K/I
         8NpJeML7+kxhU/3so6+YxCmOuT3qglmUMFvygv8tzUKnsohKeacWVrJtNOs4OsaIs5
         BlPVEx+YLZgPg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/mount_setattr updates
Date:   Wed, 23 Mar 2022 12:02:09 +0100
Message-Id: <20220323110209.858041-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
This contains a few more patches to massage the mount_setattr() codepaths and
one minor fix to reuse a helper we added some time back. The final two patches
do similar cleanups in different ways. One patch is mine and the other is Al's
who was nice enough to give me a branch for it. Since his came in later and my
branch had been sitting in -next for quite some time we just put his on top
instead of swap them.

/* Testing */
All patches are based on v5.17-rc2 and have been sitting in linux-next. No
build failures or warnings were observed and fstests and selftests have seen no
regressions caused by this patchset.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 538f4f022a4612f969d5324ee227403c9f8b1d72:

  fs: add kernel doc for mnt_{hold,unhold}_writers() (2022-02-14 08:35:32 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.v5.18

for you to fetch changes up to e257039f0fc7da36ac3a522ef9a5cb4ae7852e67:

  mount_setattr(): clean the control flow and calling conventions (2022-03-15 19:17:13 -0400)

Please consider pulling these changes from the signed fs.v5.18 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.v5.18

----------------------------------------------------------------
Al Viro (1):
      mount_setattr(): clean the control flow and calling conventions

Christian Brauner (4):
      fs: add mnt_allow_writers() and simplify mount_setattr_prepare()
      fs: simplify check in mount_setattr_commit()
      fs: don't open-code mnt_hold_writers()
      fs: clean up mount_setattr control flow

 fs/namespace.c | 148 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 70 deletions(-)
