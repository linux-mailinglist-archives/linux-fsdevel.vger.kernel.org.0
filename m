Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3178C299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjH2Kwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjH2KwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8721AD;
        Tue, 29 Aug 2023 03:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0CD653CD;
        Tue, 29 Aug 2023 10:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD5C433C7;
        Tue, 29 Aug 2023 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306332;
        bh=cWN6OqUxg3sI6B0IZM2l2D5QNkrb2wO7o9Fbj/YABEo=;
        h=From:To:Cc:Subject:Date:From;
        b=noT7nhS44s9LQXeWSK+H29ss6ZEVd4P6bSufVYei1Ma8NyNgwm+Ukw7PyRh+ehpnQ
         9p7cgpYH9AOqhCXlRv2VkI827LRi4/o8lYOTf08ZTVZqSJBdveGHNm3m5wyFx4j5t6
         WpblD3QENfG523118rB7zU+CsfOs7dufKYDIhEwn0iZ0YRcXmHt9GKB8YMKJNprM2p
         u7EKIzr3d0QFDxAo9glV/XBb0y3MxY8Dh7m0WOC5A2ZEZpWcjSm9zwwpPYh5XK6uBt
         7AnCT1cb2OzqoHzeeEcHLK8nk7ODkcKK/vmZk0X72Gz8yz3odkovXrR3B30HW/+kKv
         NFaej/Rf8vEOw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.6] super fixes
Date:   Tue, 29 Aug 2023 12:51:21 +0200
Message-Id: <20230829-kasten-bedeuten-b49c0dc7dbe0@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=brauner@kernel.org; h=from:subject:message-id; bh=cWN6OqUxg3sI6B0IZM2l2D5QNkrb2wO7o9Fbj/YABEo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8PdvFt1iR89yl74+V/0wrnfEkZf36mA3t9bZbropo+JYE aghXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE6wQjQ0PV91JFw6zCE1dXZj6YdK cv+OrDCKbdFZfqtYXuPzp5+wEjw9YF36uYEg/V8ezzf9Om16mX2KQjsOnS3lnJ69VMdXK6OQA=
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
This contains two follow-up fixes for the super work this cycle:

* Move a misplaced lockep assertion before we potentially free the
  object containing the lock.

* Ensure that filesystems which match superblocks in sget{_fc}() based
  on sb->s_fs_info are guaranteed to see a valid sb->s_fs_info as long
  as a superblock still appears on the filesystem type's superblock
  list.

  What we want as a proper solution for next cycle is to split
  sb->free_sb() out of sb->kill_sb() so that we can simply call
  kill_super_notify() after sb->kill_sb() but before sb->free_sb().
  Currently, this is lumped together in sb->kill_sb().

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

The following changes since commit cd4284cfd3e11c7a49e4808f76f53284d47d04dd:

  Merge tag 'vfs-6.6-merge-3' of ssh://gitolite.kernel.org/pub/scm/fs/xfs/xfs-linux (2023-08-23 13:09:22 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes

for you to fetch changes up to dc3216b1416056b04712e53431f6e9aefdc83177:

  super: ensure valid info (2023-08-29 10:13:04 +0200)

Please consider pulling these changes from the signed v6.6-vfs.super.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.super.fixes

----------------------------------------------------------------
Christian Brauner (2):
      super: move lockdep assert
      super: ensure valid info

 fs/super.c | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)
