Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9446D42E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjDCLFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCLFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510CF6182;
        Mon,  3 Apr 2023 04:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC1E61919;
        Mon,  3 Apr 2023 11:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCB4C433EF;
        Mon,  3 Apr 2023 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680519928;
        bh=xI3/YfoFxE8WIdxxEZQWKtxqgyl7qkson5uhA1hbjG8=;
        h=From:To:Cc:Subject:Date:From;
        b=cEijF6+YBLYWt/QLBG5Q6UmfPIwI40uMmM6kNhLJdgtdh37xNu55gDESh5y1WeBDg
         dCjaFpziENu9/JqReXQvz+mwRWNwBoUq7lz9P4yiTZMlK54jfOnq2EzPKneBUdsD11
         qCOxBVDtI5ghPohtxG+eLQ426flxwR6p6amgpDF3/ee0cxE++CoVIrZp1Qz9ZkqE14
         FJuuzZnJacCaVkflHlhrWtOp1VxiT130EKpESq57XoPnbF02dvBfJszBDYsaWSl6Ab
         RjsrG4eIP9h4WnVNtL+Dhv+7nNgxnNn4P/C5HkLrRIxBIH6v289Dfq+R8odTlT4s9Q
         dQg6F2DfPiYrw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Mon,  3 Apr 2023 13:04:58 +0200
Message-Id: <20230403-hardener-elevate-44493c0e466b@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=brauner@kernel.org; h=from:subject:message-id; bh=xI3/YfoFxE8WIdxxEZQWKtxqgyl7qkson5uhA1hbjG8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRobTrvMf3nwt86oXuXRXA9unSlOXv5pl/O3zxcpKPrwuft qzcT6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1euMDB8szfbVfGu4/eHp8V6xjX La991XcW/Uywm7aeB9t2fz+nUM/1MtDLeq7Tg1P/a1VPTHvdMbdkfY7JTctYe5vdi5foJKBgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
When a mount or mount tree is made shared the vfs allocates new peer
group ids for all mounts that have no peer group id set. Only mounts
that aren't marked with MNT_SHARED are relevant here as MNT_SHARED
indicates that the mount has fully transitioned to a shared mount. The
peer group id handling is done with namespace lock held.

On failure, the peer group id settings of mounts for which a new peer
group id was allocated need to be reverted and the allocated peer group
id freed. The cleanup_group_ids() helper can identify the mounts to
cleanup by checking whether a given mount has a peer group id set but
isn't marked MNT_SHARED. The deallocation always needs to happen with
namespace lock held to protect against concurrent modifications of the
propagation settings.

This pull request contains a fix for the one place where the namespace
lock was dropped before calling cleanup_group_ids().

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.3-rc4 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.fixes.v6.3-rc6

for you to fetch changes up to cb2239c198ad9fbd5aced22cf93e45562da781eb:

  fs: drop peer group ids under namespace lock (2023-03-31 12:13:37 +0200)

Please consider pulling these changes from the signed vfs.misc.fixes.v6.3-rc6 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs.misc.fixes.v6.3-rc6

----------------------------------------------------------------
Christian Brauner (1):
      fs: drop peer group ids under namespace lock

 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
