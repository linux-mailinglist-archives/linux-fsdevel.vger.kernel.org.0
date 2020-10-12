Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312DB28AC5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 05:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgJLDPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 23:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJLDPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:15:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C8C0613CE;
        Sun, 11 Oct 2020 20:15:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRoIZ-00FkUi-BI; Mon, 12 Oct 2020 03:14:55 +0000
Date:   Mon, 12 Oct 2020 04:14:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Miller <davem@davemloft.net>
Subject: [git pull] vfs.git csum_and_copy stuff
Message-ID: <20201012031455.GE3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Saner calling conventions for csum_and_copy_..._user() and friends.
Sat in -next for two cycles now...

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum_and_copy

for you to fetch changes up to 70d65cd555c5e43c613700f604a47f7ebcf7b6f1:

  ppc: propagate the calling conventions change down to csum_partial_copy_generic() (2020-08-20 15:45:22 -0400)

----------------------------------------------------------------
Al Viro (19):
      skb_copy_and_csum_bits(): don't bother with the last argument
      icmp_push_reply(): reorder adding the checksum up
      unify generic instances of csum_partial_copy_nocheck()
      csum_partial_copy_nocheck(): drop the last argument
      csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
      saner calling conventions for csum_and_copy_..._user()
      alpha: propagate the calling convention changes down to csum_partial_copy.c helpers
      arm: propagate the calling convention changes down to csum_partial_copy_from_user()
      m68k: get rid of zeroing destination on error in csum_and_copy_from_user()
      sh: propage the calling conventions change down to csum_partial_copy_generic()
      i386: propagate the calling conventions change down to csum_partial_copy_generic()
      sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()
      mips: csum_and_copy_{to,from}_user() are never called under KERNEL_DS
      mips: __csum_partial_copy_kernel() has no users left
      mips: propagate the calling convention change down into __csum_partial_copy_..._user()
      xtensa: propagate the calling conventions change down into csum_partial_copy_generic()
      sparc64: propagate the calling convention changes down to __csum_partial_copy_...()
      amd64: switch csum_partial_copy_generic() to new calling conventions
      ppc: propagate the calling conventions change down to csum_partial_copy_generic()

 arch/alpha/include/asm/checksum.h         |   5 +-
 arch/alpha/lib/csum_partial_copy.c        | 164 ++++++++-----------
 arch/arm/include/asm/checksum.h           |  17 +-
 arch/arm/lib/csumpartialcopy.S            |   4 +-
 arch/arm/lib/csumpartialcopygeneric.S     |   1 +
 arch/arm/lib/csumpartialcopyuser.S        |  26 +--
 arch/c6x/include/asm/checksum.h           |   3 +
 arch/c6x/lib/csum_64plus.S                |   4 +-
 arch/hexagon/include/asm/checksum.h       |  11 --
 arch/hexagon/lib/checksum.c               |  11 --
 arch/ia64/include/asm/checksum.h          |   3 -
 arch/ia64/lib/csum_partial_copy.c         |  15 --
 arch/m68k/include/asm/checksum.h          |   7 +-
 arch/m68k/lib/checksum.c                  |  88 +++-------
 arch/mips/include/asm/checksum.h          |  68 ++------
 arch/mips/lib/csum_partial.S              | 261 ++++++++++--------------------
 arch/nios2/include/asm/checksum.h         |   4 -
 arch/parisc/include/asm/checksum.h        |  28 ----
 arch/parisc/lib/checksum.c                |  17 --
 arch/powerpc/include/asm/checksum.h       |  13 +-
 arch/powerpc/lib/checksum_32.S            |  74 ++++-----
 arch/powerpc/lib/checksum_64.S            |  37 ++---
 arch/powerpc/lib/checksum_wrappers.c      |  74 ++-------
 arch/s390/include/asm/checksum.h          |   7 -
 arch/sh/include/asm/checksum_32.h         |  36 ++---
 arch/sh/lib/checksum.S                    | 119 ++++----------
 arch/sparc/include/asm/checksum.h         |   2 +
 arch/sparc/include/asm/checksum_32.h      |  70 ++------
 arch/sparc/include/asm/checksum_64.h      |  39 +----
 arch/sparc/lib/checksum_32.S              | 202 +++++------------------
 arch/sparc/lib/csum_copy.S                |   3 +-
 arch/sparc/lib/csum_copy_from_user.S      |   4 +-
 arch/sparc/lib/csum_copy_to_user.S        |   4 +-
 arch/sparc/mm/fault_32.c                  |   6 +-
 arch/x86/include/asm/checksum.h           |   1 +
 arch/x86/include/asm/checksum_32.h        |  40 ++---
 arch/x86/include/asm/checksum_64.h        |  14 +-
 arch/x86/lib/checksum_32.S                | 117 +++++---------
 arch/x86/lib/csum-copy_64.S               | 140 +++++++++-------
 arch/x86/lib/csum-wrappers_64.c           |  86 ++--------
 arch/x86/um/asm/checksum.h                |  16 --
 arch/x86/um/asm/checksum_32.h             |  23 ---
 arch/xtensa/include/asm/checksum.h        |  34 ++--
 arch/xtensa/lib/checksum.S                |  67 ++------
 drivers/net/ethernet/3com/typhoon.c       |   3 +-
 drivers/net/ethernet/sun/sunvnet_common.c |   2 +-
 include/asm-generic/checksum.h            |  12 --
 include/linux/skbuff.h                    |   2 +-
 include/net/checksum.h                    |  22 ++-
 lib/checksum.c                            |  11 --
 lib/iov_iter.c                            |  21 ++-
 net/core/skbuff.c                         |  13 +-
 net/ipv4/icmp.c                           |  10 +-
 net/ipv4/ip_output.c                      |   6 +-
 net/ipv4/raw.c                            |   2 +-
 net/ipv6/icmp.c                           |   4 +-
 net/ipv6/ip6_output.c                     |   2 +-
 net/ipv6/raw.c                            |   2 +-
 net/sunrpc/socklib.c                      |   2 +-
 59 files changed, 613 insertions(+), 1466 deletions(-)
