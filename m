Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02EDB1378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfILR03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:26:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387432AbfILR03 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:26:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61455B713;
        Thu, 12 Sep 2019 17:26:25 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 0/7] Disable compat cruft on ppc64le v8
Date:   Thu, 12 Sep 2019 19:26:02 +0200
Message-Id: <cover.1568306311.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Less code means less bugs so add a knob to skip the compat stuff.

This is tested on ppc64le top of

https://patchwork.ozlabs.org/patch/1153850/
https://patchwork.ozlabs.org/patch/1158412/

Changes in v2: saner CONFIG_COMPAT ifdefs
Changes in v3:
 - change llseek to 32bit instead of builing it unconditionally in fs
 - clanup the makefile conditionals
 - remove some ifdefs or convert to IS_DEFINED where possible
Changes in v4:
 - cleanup is_32bit_task and current_is_64bit
 - more makefile cleanup
Changes in v5:
 - more current_is_64bit cleanup
 - split off callchain.c 32bit and 64bit parts
Changes in v6:
 - cleanup makefile after split
 - consolidate read_user_stack_32
 - fix some checkpatch warnings
Changes in v7:
 - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
 - remove leftover hunk
 - add review tags
Changes in v8:
 - consolidate valid_user_sp to fix it in the split callchain.c
 - fix build errors/warnings with PPC64 !COMPAT and PPC32

Michal Suchanek (7):
  powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/perf: consolidate read_user_stack_32
  powerpc/perf: consolidate valid_user_sp
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.
  powerpc/perf: split callchain.c by bitness

 arch/powerpc/Kconfig                   |   5 +-
 arch/powerpc/include/asm/thread_info.h |   4 +-
 arch/powerpc/include/asm/unistd.h      |   1 +
 arch/powerpc/kernel/Makefile           |   7 +-
 arch/powerpc/kernel/entry_64.S         |   2 +
 arch/powerpc/kernel/signal.c           | 144 +++++++++-
 arch/powerpc/kernel/signal_32.c        | 140 ---------
 arch/powerpc/kernel/syscall_64.c       |   6 +-
 arch/powerpc/kernel/vdso.c             |   3 +-
 arch/powerpc/perf/Makefile             |   5 +-
 arch/powerpc/perf/callchain.c          | 377 +------------------------
 arch/powerpc/perf/callchain.h          |  25 ++
 arch/powerpc/perf/callchain_32.c       | 197 +++++++++++++
 arch/powerpc/perf/callchain_64.c       | 178 ++++++++++++
 fs/read_write.c                        |   3 +-
 15 files changed, 566 insertions(+), 531 deletions(-)
 create mode 100644 arch/powerpc/perf/callchain.h
 create mode 100644 arch/powerpc/perf/callchain_32.c
 create mode 100644 arch/powerpc/perf/callchain_64.c

-- 
2.23.0

