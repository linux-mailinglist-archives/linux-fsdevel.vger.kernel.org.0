Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD078EB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjHaLFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345243AbjHaLE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E60CE43;
        Thu, 31 Aug 2023 04:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9393063221;
        Thu, 31 Aug 2023 11:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D800BC433C8;
        Thu, 31 Aug 2023 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693479895;
        bh=vWoc8KTXEEK6B+D0jPTgV83l+LRGF5l6NIZxozLDDOE=;
        h=From:To:Cc:Subject:Date:From;
        b=ilvGCw/JT1csKQG5NraDS+HWFddlwK4YxWxqTwGd6/yX4TSiZBvgKilQGQ4wEBj4g
         gj38eP7fHg/X3Bc6DdAViTsDJvHgKwj4cPpccjlYyb1NcXuAnyL+bOTjTCMNULxQ8a
         Ueydy2Ux+jOvEd+9bc2nOtUAqU0vyx321M67dNJKkCRegCk29h1eKS+ZkkuX+Oo04v
         EhaPBYfLsbsNTOTeOueKuLtR/ZipqOP8rAkLBBYgaU6ZSJFSbPLY74FfidPkpEtNhv
         UJGljOQdlg7k0vNPsL46tMt875K675jG7Nbt2PcMVm/eebsV5d1yW6tyd8SwmYsxaK
         3C5z6eKmeemPA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.6] super fixes
Date:   Thu, 31 Aug 2023 13:04:04 +0200
Message-Id: <20230831-innung-pumpwerk-dd12f922783b@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522; i=brauner@kernel.org; h=from:subject:message-id; bh=vWoc8KTXEEK6B+D0jPTgV83l+LRGF5l6NIZxozLDDOE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR8KJ5SvIr1qXb9XhGLZZm3kqQn/7h3Qo+/ZbLBrRkTZ+4V 7lt9q6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiHjMY/hnvmd2iq8QX/s3mqrqTtS I7+9WnZ+umL+D6a3L9+/yjf88wMqzcdt09gFdB83mVH9vvy495v166pylw/kts6ZyoZo5JfmwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains two more small follow-up fixes for the super work this
cycle. I went through all filesystems once more and detected two minor
issues that still needed fixing:

* Some filesystems support mtd devices (e.g., mount -t jffs2 mtd2 /mnt).
  The mtd infrastructure uses the sb->s_mtd pointer to find an existing
  superblock. When the mtd device is put and sb->s_mtd cleared the
  superblock can still be found fs_supers and so this risks a
  use-after-free.

  Add a small patch that aligns mtd with what we did for regular block
  devices and switch keying to rely on sb->s_dev.

  (This was tested with mtd devices and jffs2 as xfstests doesn't
   support mtd devices.)

* Switch nfs back to rely on kill_anon_super() so the superblock is
  removed from the list of active supers before sb->s_fs_info is freed.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.6-vfs.super and have been sitting in
linux-next. No build failures or warnings were observed. All old and new
tests in selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit b97d64c722598ffed42ece814a2cb791336c6679:

  Merge tag '6.6-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6 (2023-08-30 21:01:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes.2

for you to fetch changes up to 5069ba84b5e67873a2dfa4bf73a24506950fa1bf:

  NFS: switch back to using kill_anon_super (2023-08-31 12:47:16 +0200)

Please consider pulling these changes from the signed v6.6-vfs.super.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.super.fixes.2

----------------------------------------------------------------
Christian Brauner (2):
      fs: export sget_dev()
      mtd: key superblock by device number

Christoph Hellwig (1):
      NFS: switch back to using kill_anon_super

 drivers/mtd/mtdsuper.c | 45 +++++++++--------------------------
 fs/nfs/super.c         |  4 +---
 fs/super.c             | 64 +++++++++++++++++++++++++++++++++++---------------
 include/linux/fs.h     |  1 +
 4 files changed, 58 insertions(+), 56 deletions(-)
