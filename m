Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF86B65F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Mar 2023 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCLMTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCLMTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FB4B813;
        Sun, 12 Mar 2023 05:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 306ECB80C6D;
        Sun, 12 Mar 2023 12:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749B8C433D2;
        Sun, 12 Mar 2023 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678623536;
        bh=YIm6BrJxkKkNeNguAXKLPjoFpf5zhhV6aNe4aQAKWb4=;
        h=From:To:Cc:Subject:Date:From;
        b=QluP+5+E01SPrA4KYmuaGZMkY6Uf+XQCqMMcjVgTF2PqxTrQJ9VuJ4o+pLt0yL5tR
         YwlVQ71/VadM6vth50GoPAq2fTVZ5s/0eWfp+XSOwka3fmNfMy1zsoZq3RE1M0NYAW
         ReDxCRi/MEl6SWBmpuR5TXMJuFDDxPI4KtGKpTPWv4T1PR+etBhnBpkSE7jrHbiy8H
         JsZEwWZCB9Lza/P3WDA7VbY44n9XxhVsW90r8eKxHW1Hy6Wct0N4LgezuBAgx/7kTM
         FuXNU3txrhXRgD4ldSCjusyd/vGDv1XW1kJOi3r5z4ofzH+t3eXRzRoi7pvvNhI+Bu
         li0B7r2IZ8goQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Sun, 12 Mar 2023 13:18:21 +0100
Message-Id: <20230312121821.919841-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=brauner@kernel.org; h=from:subject; bh=YIm6BrJxkKkNeNguAXKLPjoFpf5zhhV6aNe4aQAKWb4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTwHmbyOsemcPjMAfHEb8Vvyl21+JoNaiTk1+nlGXUYHzjN e7W4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK3HBkZum/s/aK7U32G0f/Fs8sPL9 uicEFQtvbUVa0pwkXXG2RX1jAyfJf3luR9//38y4SjMxPuBdnFK2xwMw/a/9H1wayfDWZTWQE=
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
This contains a few simple vfs fixes for v6.3. There should be nothing
exciting in here:

* When allocating pages for a watch queue failed, we didn't return an
  error causing userspace to proceed even though all subsequent
  notifcations would be lost. Make sure to return an error.
* Fix a misformed tree entry for the idmapping maintainers entry.
* When setting file leases from an idmapped mount via generic_setlease()
  we need to take the idmapping into account otherwise taking a lease
  would fail from an idmapped mount.
* Remove two redundant assignments, one in splice code and the other in
  locks code, that static checkers complained about.

The watch queue and file lease fix should be backported.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.3-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.v6.3-rc2

for you to fetch changes up to 42d0c4bdf753063b6eec55415003184d3ca24f6e:

  filelocks: use mount idmapping for setlease permission check (2023-03-09 22:36:12 +0100)

Please consider pulling these changes from the signed vfs.misc.v6.3-rc2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs.misc.v6.3-rc2

----------------------------------------------------------------
David Disseldorp (1):
      watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths

Jiapeng Chong (2):
      splice: Remove redundant assignment to ret
      fs/locks: Remove redundant assignment to cmd

Lukas Bulwahn (1):
      MAINTAINERS: repair a malformed T: entry in IDMAPPED MOUNTS

Seth Forshee (1):
      filelocks: use mount idmapping for setlease permission check

 MAINTAINERS          | 4 ++--
 fs/locks.c           | 4 ++--
 fs/splice.c          | 1 -
 kernel/watch_queue.c | 1 +
 4 files changed, 5 insertions(+), 5 deletions(-)
