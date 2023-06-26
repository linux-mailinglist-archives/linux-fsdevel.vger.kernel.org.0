Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8873DAB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFZJC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFZJCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:02:02 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A949D8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 01:56:53 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QqM2M0mHtzMpqsT;
        Mon, 26 Jun 2023 08:48:43 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QqM2L1jyXzMpvVT;
        Mon, 26 Jun 2023 10:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687769323;
        bh=aEhUEFjlWBzIziOJJuCpxbJR2jQcCyx7meGNZnSvhvk=;
        h=From:To:Cc:Subject:Date:From;
        b=MZ7Nlj8eZb95HPTOedrkSDfhjlo2sRy4yuyIQMydvoqcfNvedTf3b8bIzBMun4lJ1
         VtzLHyotWl8rHCLzSE9oT2lbpGtyjenJjAWryvZQttYBXTRLb4HfLl836g8K0x4cVH
         LFdChgyxRi3Zi+H5y11/TQQRLq5/N2C+qhfgJqf8=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-um@lists.infradead.org
Subject: [GIT PULL] Landlock updates for v6.5
Date:   Mon, 26 Jun 2023 10:48:30 +0200
Message-ID: <20230626084830.717289-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This PR adds support for Landlock to UML.  In fact, this fixes the way
hostfs manages inodes according to the underlying filesystem [1].  They
are now properly handled as for other filesystems, which enables to
support Landlock (and probably other features).  This PR also extends
Landlock's tests with 6 pseudo filesystems, including hostfs.

This PR can lead to a trivial merge conflict with tip [2] where one of
Thomas's commit adds ARCH_HAS_CPU_FINALIZE_INIT and one of mine removes
ARCH_EPHEMERAL_INODES in arch/um/Kconfig.

Please pull these changes for v6.5-rc1 .  These commits merged cleanly
with v6.4, and have been successfully tested in the latest linux-next
releases for a few weeks.

[1] https://lore.kernel.org/all/20230612191430.339153-1-mic@digikod.net/
[2] https://lore.kernel.org/all/b57481af-5824-72f7-d20f-cfd78fcde519@digikod.net/

Regards,
 Mickaël

--
The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.5-rc1

for you to fetch changes up to 35ca4239929737bdc021ee923f97ebe7aff8fcc4:

  selftests/landlock: Add hostfs tests (2023-06-12 21:26:23 +0200)

----------------------------------------------------------------
Landlock updates for v6.5-rc1

----------------------------------------------------------------
Mickaël Salaün (6):
      hostfs: Fix ephemeral inodes
      selftests/landlock: Don't create useless file layouts
      selftests/landlock: Add supports_filesystem() helper
      selftests/landlock: Make mounts configurable
      selftests/landlock: Add tests for pseudo filesystems
      selftests/landlock: Add hostfs tests

 arch/Kconfig                               |   7 -
 arch/um/Kconfig                            |   1 -
 fs/hostfs/hostfs.h                         |   1 +
 fs/hostfs/hostfs_kern.c                    | 213 ++++++++--------
 fs/hostfs/hostfs_user.c                    |   1 +
 security/landlock/Kconfig                  |   2 +-
 tools/testing/selftests/landlock/config    |   9 +-
 tools/testing/selftests/landlock/config.um |   1 +
 tools/testing/selftests/landlock/fs_test.c | 387 +++++++++++++++++++++++++++--
 9 files changed, 478 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/config.um
