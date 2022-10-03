Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208EA5F2F81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJCLVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJCLVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:21:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7F4AD77;
        Mon,  3 Oct 2022 04:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42E7CB80E6B;
        Mon,  3 Oct 2022 11:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C38CC433C1;
        Mon,  3 Oct 2022 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796076;
        bh=gQ/IoWVnFjhYfdmCEfjDAvI5umV5t802LUyaGs8FJsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCzU1vge1Qb7B4nLsGqocrjIYdMacGnbBPy+nhl66m/5IioK973MUUS6a9UhaGYfb
         ye2USsxw3yc+3nnL8pXTCOx10C3a1HUojxPYm28Of6WGw2smpXO3fle21mj0leuB0J
         6cYG7uYMMhhZqzsZ0/2xCow9TKlTY3cs5aPUBa0/3nnfaoR72ieL0gnt9SomYc3zQ9
         MWWHVJxuKDTtRgDR+egysyBbPNjXj6rqUYb2W15k7WPXNgktngunHpmkuSp25a5U6A
         WvmqOpphzczGnmM3jOEQLaLJJxdKZsVys8VVIOZVufB7bcS1DqGFTFefY+n1q9VA9P
         +41b5IXd2jldw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfsuid updates for v6.1
Date:   Mon,  3 Oct 2022 13:19:43 +0200
Message-Id: <20221003111943.743391-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003111943.743391-1-brauner@kernel.org>
References: <20221003111943.743391-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075; i=brauner@kernel.org; h=from:subject; bh=gQ/IoWVnFjhYfdmCEfjDAvI5umV5t802LUyaGs8FJsI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRbHdX9PU/VeuvVaoF3FjYm83g2XV8jYMVoYPrP8kSMw0+7 C5VJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxNmb4K9zOojs74fUOr1/XdX5U9L zOcOP9rJm1S337hZyjelsFzjMytN38O9XPrd93SdifCL/6cN+Hwefciz9a8WrxLVjwVrKOFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Last cycle we introduced the new vfs{g,u}id_t types that we had agreed on. The
most important parts of the vfs have been converted but there are a few more
places we need to switch before we can remove the old helpers completely.

This cycle we converted all filesystems that called idmapped mount helpers
directly. The affected filesystems are f2fs, fat, fuse, ksmbd, overlayfs, and
xfs. We've sent patches for all of them. Looking at -next f2fs, ksmbd,
overlayfs, and xfs have all picked up these patches and they should land in
mainline during the v6.1 merge window.

So all filesystems that have a separate tree should send the vfsuid
conversion themselves. Onle the fat conversion is going through one of the
generic fs trees because there is no fat tree.

In order to change time settings on an inode fat checks that the caller either is
the owner of the inode or the inode's group is in the caller's group list. If
fat is on an idmapped mount we compare whether the inode mapped into the mount
is equivalent to the caller's fsuid. If it isn't we compare whether the inode's
group mapped into the mount is in the caller's group list. We now use the new
vfsuid based helpers for that.

(Note that I didn't see the fuse conversion patch being picked up in -next.
 This is probably just an oversight. It is a very simple patch so if it doesn't
 show up by the end of the merge window feel free to just pick it up directly
 https://lore.kernel.org/all/20220909094021.940110-1-brauner@kernel.org or let
 use know and we can send it. We can probably also just send it during -rc2.)

/* Testing */
clang: Ubuntu clang version 14.0.0-1ubuntu1
gcc:   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0

All patches are based on v6.0-rc3 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions. (Note, the fat patch got dropped
from -next on accident as I realized while writing the commit message.)

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.fat.v6.1

for you to fetch changes up to 41d27f518b955ef4b75b02cc67392aef0809a78d:

  fat: port to vfs{g,u}id_t and associated helpers (2022-09-20 11:09:31 +0200)

Please consider pulling these changes from the signed fs.vfsuid.fat.v6.1 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.vfsuid.fat.v6.1

----------------------------------------------------------------
Christian Brauner (1):
      fat: port to vfs{g,u}id_t and associated helpers

 fs/fat/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
