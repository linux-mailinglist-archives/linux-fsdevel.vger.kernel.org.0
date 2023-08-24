Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACC78722F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbjHXOtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbjHXOtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309391FC6;
        Thu, 24 Aug 2023 07:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101A360C28;
        Thu, 24 Aug 2023 14:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62062C433C8;
        Thu, 24 Aug 2023 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888519;
        bh=qzMMe8JvUYjhdGRJu99ZuKsOJgcOoj7UCPtFbDuCX5U=;
        h=From:To:Cc:Subject:Date:From;
        b=LNGxOiusqS65IdY+ncpXat8TmI/czOllHEVMvmEXkh0W8t6AnDzgzwJyj08YdD5uS
         d7bOne7nXN0NkXnYxmzH8yFBsiZIoHACPkiVPfAkDcdVuFMARKkymgj8eDjcyMRqDb
         4dr257agu07VNTO8RXlVKHahgCarj7Pe+2gublrfradP5qmQrzxHwETRYr8/efSO5w
         bEaO/bqgcn91+7XBjON3ARGNNA2nRjo9QM2Iv58LGaI/IvhvwgfDnL9rQVKZu5B3CN
         h2/8z8U/nDBENW1Vu32lInAgvvOzS4+B5UVJHQiJv0okov9uduLXFtdt26utwo3jv2
         IoIl7B1XhoELw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] procfs fixes
Date:   Thu, 24 Aug 2023 16:48:31 +0200
Message-Id: <20230824-inventar-wissen-d7801fbc9bf9@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=brauner@kernel.org; h=from:subject:message-id; bh=qzMMe8JvUYjhdGRJu99ZuKsOJgcOoj7UCPtFbDuCX5U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8z127WKDkvek/1R+5XIcNjAUjt0yLEd2fX/BwpX9s2I6E sKV/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSms3wV3L2sfnbem9vWXky7Z+q7u s1gmyypn28su3u7Gxec6oDGRkZuhnTSoQ8mXzL9SLlom3mmlefjrFtKFWrWCkhpMmxNZ8DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
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
Mode changes to files under /proc/<pid>/ aren't supported ever since
6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files").
Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
mode changes on /proc/thread-self/comm were accidently allowed.

Similar, mode changes for all files beneath /proc/<pid>/net/ are blocked
but mode changes on /proc/<pid>/net itself were accidently allowed.

Both issues come down to not using the generic proc_setattr() helper
which blocks all mode changes. This is rectified with this pull request.

This also removes a strange nolibc test that abused /proc/<pid>/net for
testing mode changes. Using procfs for this test never made a lot of
sense given procfs has special semantics for almost everything anway.

Both changes are minor user-visible changes. It is however very unlikely
that mode changes on proc/<pid>/net and /proc/thread-self/comm are
something that userspace relies on.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
(1) linux-next: manual merge of the nolibc tree with the vfs-brauner tree
    https://lore.kernel.org/lkml/20230824141008.27f7270b@canb.auug.org.au

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-fs.proc.uapi

for you to fetch changes up to ccf61486fe1e1a48e18c638d1813cda77b3c0737:

  procfs: block chmod on /proc/thread-self/comm (2023-07-13 16:30:52 +0200)

Please consider pulling these changes from the signed v6.6-fs.proc.uapi tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-fs.proc.uapi

----------------------------------------------------------------
Aleksa Sarai (1):
      procfs: block chmod on /proc/thread-self/comm

Thomas Weißschuh (2):
      selftests/nolibc: drop test chmod_net
      proc: use generic setattr() for /proc/$PID/net

 fs/proc/base.c                               | 3 ++-
 fs/proc/proc_net.c                           | 1 +
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)
