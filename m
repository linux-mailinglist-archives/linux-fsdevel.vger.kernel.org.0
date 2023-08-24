Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB47787209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbjHXOo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjHXOoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFD51BE;
        Thu, 24 Aug 2023 07:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D15B667C9;
        Thu, 24 Aug 2023 14:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011E2C433C7;
        Thu, 24 Aug 2023 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888269;
        bh=R509wO4EC4vCR4YzHRmbZ6iJLbR577/Be6Mspmq1ypw=;
        h=From:To:Cc:Subject:Date:From;
        b=jvQqKo5/SRXYqpzIFi0FneCfpfaWBcCBjaiQrdPHz3CizMxEioPq97nHaumm/eI64
         CdZm7L1RTXjbD5ZsWRW77jVscLKxBUQ1DDm2dnsjBnKEJgd4CGcXLop0Kfk0+yjCbU
         KEzELR45FbwBmu6Kp4Np6TtuQCMoacIZHvIpvBFYJhi5JXHtDpxVQqpIJUoYmrbfBA
         C4noCK8sJQe3r5wbAg7hiqaegRslQ0qBu0xRcPZof6JLKxmO05n0//2J9r/B8vL98b
         hf4V11/846j1YBFI7N6Ctb3Y3UlJT8qQmkZelNSPUXtgi1OXWyX/kcMzvE+lzPkWuP
         KNS9GDJMf4wPw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fchmodat2
Date:   Thu, 24 Aug 2023 16:44:15 +0200
Message-Id: <20230824-frohlocken-vorabend-725f6fdaad50@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344; i=brauner@kernel.org; h=from:subject:message-id; bh=R509wO4EC4vCR4YzHRmbZ6iJLbR577/Be6Mspmq1ypw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8zymttrh11216z277O7kV97Tm7GNk5fAJLWSZcIiNacmr iacudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk121Ghotzn/LuePe642HBox2XLr W0ejybdKb9XIrdpu02bR4Bl7wZ/mmf/qG2QnXnXnu5sssms2+uc5+R6fhlqgJDaPBRGd7NR9gB
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
This adds the fchmodat2() system call. It is a revised version of the
fchmodat() system call, adding a missing flag argument. Support for both
AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH are included.

Adding this system call revision has been a longstanding request but so
far has always fallen through the cracks. While the kernel
implementation of fchmodat() does not have a flag argument the libc
provided POSIX-compliant fchmodat(3) version does. Both libcs have to
implement a workaround in order to support AT_SYMLINK_NOFOLLOW (see [1]
and [2]).

The workaround is brittle because it relies not just on O_PATH and
O_NOFOLLOW semantics and procfs magic links but also on our rather
inconsistent symlink semantics.

This pull request gives userspace a proper fchmodat2() system call that
libcs can use to properly implement fchmodat(3) and allows them to get
rid of their hacks. In this case it will immediately benefit them as the
current workaround is already defunct because of aformentioned
inconsistencies.

In addition to AT_SYMLINK_NOFOLLOW, give userspace the ability to use
AT_EMPTY_PATH with fchmodat2(). This is already possible with fchownat()
so there's no reason to not also support it for fchmodat2().

The implementation is simple and comes with selftests. Implementation of
the system call and wiring up the system call are done as separate
patches even though they could arguably be one patch. But in case there
are merge conflicts from other system call additions it can be
beneficial to have separate patches.

Link: [1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
Link: [2] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
(1) linux-next: manual merge of the tip tree with the vfs-brauner tree
    https://lore.kernel.org/lkml/20230815142437.01441969@canb.auug.org.au

    This is a simple conflict in system call numbering with the
    map_shadow_stack() system call in case that gets sent.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fchmodat2

for you to fetch changes up to 71214379532794b5a05ea760524cdfb1c4ddbfcb:

  selftests: fchmodat2: remove duplicate unneeded defines (2023-08-05 12:40:44 +0200)

Please consider pulling these changes from the signed v6.6-vfs.fchmodat2 tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.fchmodat2

----------------------------------------------------------------
Aleksa Sarai (1):
      fchmodat2: add support for AT_EMPTY_PATH

Alexey Gladkov (2):
      fs: Add fchmodat2()
      selftests: Add fchmodat2 selftest

Muhammad Usama Anjum (1):
      selftests: fchmodat2: remove duplicate unneeded defines

Palmer Dabbelt (2):
      Non-functional cleanup of a "__user * filename"
      arch: Register fchmodat2, usually as syscall 452

 arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
 arch/arm/tools/syscall.tbl                         |   1 +
 arch/arm64/include/asm/unistd.h                    |   2 +-
 arch/arm64/include/asm/unistd32.h                  |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl              |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/sh/kernel/syscalls/syscall.tbl                |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
 fs/open.c                                          |  23 +++-
 include/linux/syscalls.h                           |   4 +-
 include/uapi/asm-generic/unistd.h                  |   5 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/fchmodat2/.gitignore       |   2 +
 tools/testing/selftests/fchmodat2/Makefile         |   6 +
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 142 +++++++++++++++++++++
 25 files changed, 196 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/fchmodat2/.gitignore
 create mode 100644 tools/testing/selftests/fchmodat2/Makefile
 create mode 100644 tools/testing/selftests/fchmodat2/fchmodat2_test.c
