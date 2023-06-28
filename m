Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C97417FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjF1SYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjF1SYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:24:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF491BE8;
        Wed, 28 Jun 2023 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rZ7tW+lP5VbpS09o8l8H9B+pWyICkkk7HcLmzLLVSYE=; b=jLIna+47HDapmlKg2krsqqOn5u
        LaxSJ37gnbaRB7oSlZEOHwBRws4MDZKwLLN+LcRVt8hOBi7MkzgUi+C9O2raUKUlMilwnio8IY1cn
        kJgPP+F+IgqgQ0vfi9aHP5q2042JXQSvTgXFkDZOBYoMXiLgcYpB+Y1vNth5ec8nd6wnZ3+1A4AFO
        j3ACuczFst0UWGk/5CbnMDu3uKXO318BI1YSfe/S2/G2KiO9mnV0WAKbXZt/cqJy17UK4meO+14XZ
        7z9+2P7+fkF59UClddYhILm8VYpfQkh/TQKjNpH8Bg1w8Hu5rh5D8R2UYWLqKsbytogEkvJqvP/w8
        Tzp8N4ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEZq5-00GO51-0t;
        Wed, 28 Jun 2023 18:24:25 +0000
Date:   Wed, 28 Jun 2023 11:24:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v6.5-rc1
Message-ID: <ZJx62RvS9TwjUUCi@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/v6.5-rc1-sysctl-next

for you to fetch changes up to 2f2665c13af4895b26761107c2f637c2f112d8e9:

  sysctl: replace child with an enumeration (2023-06-18 02:32:54 -0700)

----------------------------------------------------------------
v6.5-rc1-sysctl-next

The changes queued up for v6.5-rc1 for sysctl are in line with
prior efforts to stop usage of deprecated routines which incur
recursion and also make it hard to remove the empty array element
in each sysctl array declaration. The most difficult user to modify
was parport which required a bit of re-thinking of how to declare shared
sysctls there, Joel Granados has stepped up to the plate to do most of
this work and eventual removal of register_sysctl_table(). That work
ended up saving us about 1465 bytes according to bloat-o-meter. Since
we gained a few bloat-o-meter karma points I moved two rather small
sysctl arrays from kernel/sysctl.c leaving us only two more sysctl
arrays to move left.

Most changes have been tested on linux-next for about a month. The last
straggler patches are a minor parport fix, changes to the sysctl
kernel selftest so to verify correctness and prevent regressions for
the future change he made to provide an alternative solution for the
special sysctl mount point target which was using the now deprecated
sysctl child element.

This is all prep work to now finally be able to remove the empty
array element in all sysctl declarations / registrations which is
expected to save us a bit of bytes all over the kernel. That work
will be tested early after v6.5-rc1 is out.

----------------------------------------------------------------
Joel Granados (16):
      parport: Move magic number "15" to a define
      parport: Remove register_sysctl_table from parport_proc_register
      parport: Remove register_sysctl_table from parport_device_proc_register
      parport: Remove register_sysctl_table from parport_default_proc_register
      parport: Removed sysctl related defines
      sysctl: stop exporting register_sysctl_table
      sysctl: Refactor base paths registrations
      sysctl: Remove register_sysctl_table
      parport: plug a sysctl register leak
      test_sysctl: Fix test metadata getters
      test_sysctl: Group node sysctl test under one func
      test_sysctl: Add an unregister sysctl test
      test_sysctl: Add an option to prevent test skip
      test_sysclt: Test for registering a mount point
      sysctl: Remove debugging dump_stack
      sysctl: replace child with an enumeration

Luis Chamberlain (4):
      sysctl: remove empty dev table
      signal: move show_unhandled_signals sysctl to its own file
      sysctl: move umh sysctl registration to its own file
      sysctl: move security keys sysctl registration to its own file

 drivers/parport/procfs.c                 | 185 ++++++++++++-----------
 drivers/parport/share.c                  |   2 +-
 fs/proc/proc_sysctl.c                    | 244 +++----------------------------
 fs/sysctls.c                             |   5 +-
 include/linux/key.h                      |   3 -
 include/linux/parport.h                  |   2 +
 include/linux/sysctl.h                   |  45 ++----
 include/linux/umh.h                      |   2 -
 kernel/signal.c                          |  23 +++
 kernel/sysctl.c                          |  40 +----
 kernel/umh.c                             |  11 +-
 lib/test_sysctl.c                        |  91 +++++++++++-
 scripts/check-sysctl-docs                |  10 --
 security/keys/sysctl.c                   |   7 +
 tools/testing/selftests/sysctl/sysctl.sh | 115 +++++++++++----
 15 files changed, 351 insertions(+), 434 deletions(-)
