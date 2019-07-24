Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A6727A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGXF7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 01:59:04 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49991 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXF7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:59:03 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8CC8220004;
        Wed, 24 Jul 2019 05:58:54 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH REBASE v4 00/14] Provide generic top-down mmap layout functions
Date:   Wed, 24 Jul 2019 01:58:36 -0400
Message-Id: <20190724055850.6232-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

This is simply a rebase on top of next-20190719, where I added various
Acked/Reviewed-by from Kees and Catalin and a note on commit 08/14 suggested
by Kees regarding the removal of STACK_RND_MASK that is safe doing.

I would have appreciated a feedback from a mips maintainer but failed to get
it: can you consider this series for inclusion anyway ? Mips parts have been
reviewed-by Kees.

Thanks,



This series introduces generic functions to make top-down mmap layout
easily accessible to architectures, in particular riscv which was
the initial goal of this series.
The generic implementation was taken from arm64 and used successively
by arm, mips and finally riscv.

Note that in addition the series fixes 2 issues:
- stack randomization was taken into account even if not necessary.
- [1] fixed an issue with mmap base which did not take into account
  randomization but did not report it to arm and mips, so by moving
  arm64 into a generic library, this problem is now fixed for both
  architectures.

This work is an effort to factorize architecture functions to avoid
code duplication and oversights as in [1].

[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html

Changes in v4:
  - Make ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT select ARCH_HAS_ELF_RANDOMIZE
    by default as suggested by Kees,
  - ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT depends on MMU and defines the
    functions needed by ARCH_HAS_ELF_RANDOMIZE => architectures that use
    the generic mmap topdown functions cannot have ARCH_HAS_ELF_RANDOMIZE
    selected without MMU, but I think it's ok since randomization without
    MMU does not add much security anyway.
  - There is no common API to determine if a process is 32b, so I came up with
    !IS_ENABLED(CONFIG_64BIT) || is_compat_task() in [PATCH v4 12/14].
  - Mention in the change log that x86 already takes care of not offseting mmap
    base address if the task does not want randomization.
  - Re-introduce a comment that should not have been removed.
  - Add Reviewed/Acked-By from Paul, Christoph and Kees, thank you for that.
  - I tried to minimize the changes from the commits in v3 in order to make
    easier the review of the v4, the commits changed or added are:
    - [PATCH v4 5/14]
    - [PATCH v4 8/14]
    - [PATCH v4 11/14]
    - [PATCH v4 12/14]
    - [PATCH v4 13/14]

Changes in v3:
  - Split into small patches to ease review as suggested by Christoph
    Hellwig and Kees Cook
  - Move help text of new config as a comment, as suggested by Christoph
  - Make new config depend on MMU, as suggested by Christoph

Changes in v2 as suggested by Christoph Hellwig:
  - Preparatory patch that moves randomize_stack_top
  - Fix duplicate config in riscv
  - Align #if defined on next line => this gives rise to a checkpatch
    warning. I found this pattern all around the tree, in the same proportion
    as the previous pattern which was less pretty:
    git grep -C 1 -n -P "^#if defined.+\|\|.*\\\\$"

Alexandre Ghiti (14):
  mm, fs: Move randomize_stack_top from fs to mm
  arm64: Make use of is_compat_task instead of hardcoding this test
  arm64: Consider stack randomization for mmap base only when necessary
  arm64, mm: Move generic mmap layout functions to mm
  arm64, mm: Make randomization selected by generic topdown mmap layout
  arm: Properly account for stack randomization and stack guard gap
  arm: Use STACK_TOP when computing mmap base address
  arm: Use generic mmap top-down layout and brk randomization
  mips: Properly account for stack randomization and stack guard gap
  mips: Use STACK_TOP when computing mmap base address
  mips: Adjust brk randomization offset to fit generic version
  mips: Replace arch specific way to determine 32bit task with generic
    version
  mips: Use generic mmap top-down layout and brk randomization
  riscv: Make mmap allocation top-down by default

 arch/Kconfig                       |  11 +++
 arch/arm/Kconfig                   |   2 +-
 arch/arm/include/asm/processor.h   |   2 -
 arch/arm/kernel/process.c          |   5 --
 arch/arm/mm/mmap.c                 |  52 --------------
 arch/arm64/Kconfig                 |   2 +-
 arch/arm64/include/asm/processor.h |   2 -
 arch/arm64/kernel/process.c        |   8 ---
 arch/arm64/mm/mmap.c               |  72 -------------------
 arch/mips/Kconfig                  |   2 +-
 arch/mips/include/asm/processor.h  |   5 --
 arch/mips/mm/mmap.c                |  84 ----------------------
 arch/riscv/Kconfig                 |  11 +++
 fs/binfmt_elf.c                    |  20 ------
 include/linux/mm.h                 |   2 +
 kernel/sysctl.c                    |   6 +-
 mm/util.c                          | 107 ++++++++++++++++++++++++++++-
 17 files changed, 137 insertions(+), 256 deletions(-)

-- 
2.20.1

