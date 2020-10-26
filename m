Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA27F298865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 09:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770996AbgJZIiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 04:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770139AbgJZIiK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:38:10 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45392223B0;
        Mon, 26 Oct 2020 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603701489;
        bh=OUb5d3QtiZpYTjK7sEHmPoLojCJLpplUoBwVFg6u6zs=;
        h=From:To:Cc:Subject:Date:From;
        b=nF4ru/gKWJs1mrs4YQv7QK/DWqPZRmtCXGkf1YbCkJFDVn9pD0ddIbYgxaPWgVYfI
         TmhiE2vvv4IJ2bSJc+7QV2RSuGHHqoJ2umZ4lVZJvVac9sP+Gg//L7MNCJ1pAyogFj
         80yoX41QIhmwbypTjkQbfU/N4qzVBJY5rfYdpLLY=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v7 0/7] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Mon, 26 Oct 2020 10:37:45 +0200
Message-Id: <20201026083752.13267-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is an implementation of "secret" mappings backed by a file descriptor.

The file descriptor backing secret memory mappings is created using a
dedicated memfd_secret system call The desired protection mode for the
memory is configured using flags parameter of the system call. The mmap()
of the file descriptor created with memfd_secret() will create a "secret"
memory mapping. The pages in that mapping will be marked as not present in
the direct map and will have desired protection bits set in the user page
table. For instance, current implementation allows uncached mappings.

Although normally Linux userspace mappings are protected from other users,
such secret mappings are useful for environments where a hostile tenant is
trying to trick the kernel into giving them access to other tenants
mappings.

Additionally, in the future the secret mappings may be used as a mean to
protect guest memory in a virtual machine host.

For demonstration of secret memory usage we've created a userspace library

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git

that does two things: the first is act as a preloader for openssl to
redirect all the OPENSSL_malloc calls to secret memory meaning any secret
keys get automatically protected this way and the other thing it does is
expose the API to the user who needs it. We anticipate that a lot of the
use cases would be like the openssl one: many toolkits that deal with
secret keys already have special handling for the memory to try to give
them greater protection, so this would simply be pluggable into the
toolkits without any need for user application modification.

Hiding secret memory mappings behind an anonymous file allows (ab)use of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs in the future.

To limit fragmentation of the direct map to splitting only PUD-size pages,
I've added an amortizing cache of PMD-size pages to each file descriptor
that is used as an allocation pool for the secret memory areas.

It is easy to add boot time reservation of the memory for secretmem
needs. There was an implementation in earlier version of this set, but I've
dropped it for now as there is no consensus whether the boot time
reservation should be done from memblock or from CMA. I beleive we can have
this discussion after straightening out the basic implementation.

v7:
* Use set_direct_map() instead of __kernel_map_pages() to ensure error
  handling in case the direct map update fails
* Add accounting of large pages used to reduce the direct map fragmentation
* Teach get_user_pages() and frieds to refuse get/pin secretmem pages

v6: https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org
* Silence the warning about missing syscall, thanks to Qian Cai
* Replace spaces with tabs in Kconfig additions, per Randy
* Add a selftest.

v5: https://lore.kernel.org/lkml/20200916073539.3552-1-rppt@kernel.org
* rebase on v5.9-rc5
* drop boot time memory reservation patch

v4: https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
* rebase on v5.9-rc1
* Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
* Make secret mappings exclusive by default and only require flags to
  memfd_secret() system call for uncached mappings, thanks again Kirill :)

v3: https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
* Squash kernel-parameters.txt update into the commit that added the
  command line option.
* Make uncached mode explicitly selectable by architectures. For now enable
  it only on x86.

v2: https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
* Follow Michael's suggestion and name the new system call 'memfd_secret'
* Add kernel-parameters documentation about the boot option
* Fix i386-tinyconfig regression reported by the kbuild bot.
  CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
  from one side and still make it available unconditionally on
  architectures that support SET_DIRECT_MAP.

v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org

Mike Rapoport (8):
  mm: add definition of PMD_PAGE_ORDER
  mmap: make mlock_future_check() global
  set_memory: allow set_direct_map_*_noflush() for multiple pages
  mm: introduce memfd_secret system call to create "secret" memory areas
  arch, mm: wire up memfd_secret system call were relevant
  mm: secretmem: use PMD-size pages to amortize direct map fragmentation
  secretmem: test: add basic selftest for memfd_secret(2)
  mm: secretmem: add ability to reserve memory at boot

 arch/Kconfig                              |   7 +
 arch/arm64/include/asm/cacheflush.h       |   4 +-
 arch/arm64/include/asm/unistd.h           |   2 +-
 arch/arm64/include/asm/unistd32.h         |   2 +
 arch/arm64/include/uapi/asm/unistd.h      |   1 +
 arch/arm64/mm/pageattr.c                  |  10 +-
 arch/riscv/include/asm/set_memory.h       |   4 +-
 arch/riscv/include/asm/unistd.h           |   1 +
 arch/riscv/mm/pageattr.c                  |   8 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 arch/x86/include/asm/set_memory.h         |   4 +-
 arch/x86/mm/pat/set_memory.c              |   8 +-
 fs/dax.c                                  |  11 +-
 include/linux/pgtable.h                   |   3 +
 include/linux/set_memory.h                |   4 +-
 include/linux/syscalls.h                  |   1 +
 include/uapi/asm-generic/unistd.h         |   7 +-
 include/uapi/linux/magic.h                |   1 +
 include/uapi/linux/secretmem.h            |   8 +
 kernel/sys_ni.c                           |   2 +
 mm/Kconfig                                |   4 +
 mm/Makefile                               |   1 +
 mm/gup.c                                  |  10 +
 mm/internal.h                             |   3 +
 mm/mmap.c                                 |   5 +-
 mm/secretmem.c                            | 487 ++++++++++++++++++++++
 mm/vmalloc.c                              |   5 +-
 scripts/checksyscalls.sh                  |   4 +
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   3 +-
 tools/testing/selftests/vm/memfd_secret.c | 296 +++++++++++++
 tools/testing/selftests/vm/run_vmtests    |  17 +
 34 files changed, 892 insertions(+), 35 deletions(-)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c
 create mode 100644 tools/testing/selftests/vm/memfd_secret.c

--
2.28.0
