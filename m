Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD53749B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjGFLxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFLxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9161BD4;
        Thu,  6 Jul 2023 04:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3A96190E;
        Thu,  6 Jul 2023 11:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02643C433C7;
        Thu,  6 Jul 2023 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644406;
        bh=mzhbekHsQQZ7JMCbjp27AXUnPPgSBiGhJ3MSsnWoL8M=;
        h=From:To:Cc:Subject:Date:From;
        b=bdyJKtE5KQBzmf6I0TmfV6BVpxsLwTuUE03WIHTApia9i6ZGPoOnZd/rNXgafVh+R
         PfwlVM5Wp8hG+UiMI0kQKeA5qTAlr9jmKXpmWnbDbmlgtgowUkTp8DGXNZXI30Jd+x
         AT1No9O9Mjr8Yp+TNq96BhCZDOEiwlBssF/0ydVvh4Pph7Q0VjuPHbsZREABHWlE8B
         QG2V3t1gxWlrjOsbh0MJUzv5Dn5Mj507rMfcOdqSsTCyzcMLdUsuSmPRBT76P2Xuu/
         /htmQQyf8lXsngdQOo/SzIh+uzBu3d7p7lLsXhhbBBm82+ClORwtc7sT7F1tobhRei
         tSoL5+yNSHOrw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Thu,  6 Jul 2023 13:52:59 +0200
Message-Id: <20230706-anlehnen-fichtenwald-1b7c46c068f6@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=brauner@kernel.org; h=from:subject:message-id; bh=Sreh9vLDpolerKKV2/Pv64bPn7vM+vd09MND2LWpXrs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsW/WeT2Cm0ucTs+9bZk2sty1K7DPz/DR/X2L4TZ0VAlsL VnQJdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk506G/+lHWu4W/lhccPDcoY87bO bdn3Tywz5v7pYDHzwT8remPuBlZDh9ilGicAYvZ07ev3aZ160loQsPtVyzFvbdsJctV0fuKwsA
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
This contains two minor fixes for Jan's rename locking work:
(1) Unlocking the source inode was guarded by a check whether source was
    non-NULL. This doesn't make sense because source must be non-NULL
    and the commit message explains in detail why.
(2) The lock_two_nondirectories() helper called WARN_ON_ONCE() and
    dereferenced the inodes unconditionally but the underlying
    lock_two_inodes() helper and the kernel documentation for that
    function are clear that it is valid to pass NULL arguments. So here
    a non-NULL check is needed. No caller does pass non-NULL arguments
    but let's not knowingly leave landmines around.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

All patches are based on current mainline. No build failures or warnings
were observed. All old and new tests in fstests, selftests, and LTP pass
without regressions.

The following changes since commit 24be4d0b46bb0c3c1dc7bacd30957d6144a70dfc:

  arch/arm64/mm/fault: Fix undeclared variable error in do_page_fault() (2023-07-03 19:04:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes.2

for you to fetch changes up to 33ab231f83cc12d0157711bbf84e180c3be7d7bc:

  fs: don't assume arguments are non-NULL (2023-07-04 10:21:11 +0200)

Please consider pulling these changes from the signed v6.5/vfs.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.fixes.2

----------------------------------------------------------------
Christian Brauner (1):
      fs: don't assume arguments are non-NULL

Jan Kara (1):
      fs: no need to check source

 fs/inode.c | 6 ++++--
 fs/namei.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)
