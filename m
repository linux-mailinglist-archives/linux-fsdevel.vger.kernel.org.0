Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6BD2C2124
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 10:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgKXJ0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbgKXJ0N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:26:13 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4272073C;
        Tue, 24 Nov 2020 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606209971;
        bh=Vu/loiJSNRrO77MACnjmjt+n1JsAIxW9sPzEI8Ph9s4=;
        h=From:To:Cc:Subject:Date:From;
        b=yArC+oqs8UwMhkE4s7VBNMygmdJaXflqzzY4kzd8LiaNHcOU3eoinTB5Cfatt1YGu
         ku7ryee1J1HtCFoVbBOueT+EtRc9zRXgf5egSMTHgM+vu/gHMH5yEhWHxoumvG0ktT
         xirR2t8mG+6ImIcI4MrCjuAeIRpTEQ29ujzMRs68=
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
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v11 0/9] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Tue, 24 Nov 2020 11:25:47 +0200
Message-Id: <20201124092556.12009-1-rppt@kernel.org>
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
the direct map and will be present only in the page table of the owning mm.

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

As the memory allocated by secretmem becomes unmovable, we use CMA to back
large page caches so that page allocator won't be surprised by failing attempt
to migrate these pages.

v11:
* Drop support for uncached mappings

v10: https://lore.kernel.org/lkml/20201123095432.5860-1-rppt@kernel.org
* Drop changes to arm64 compatibility layer
* Add Roman's Ack for memcg accounting

v9: https://lore.kernel.org/lkml/20201117162932.13649-1-rppt@kernel.org
* Fix build with and without CONFIG_MEMCG
* Update memcg accounting to avoid copying memcg_data, per Roman comments
* Fix issues in secretmem_fault(), thanks Matthew
* Do not wire up syscall in arm64 compatibility layer

v8: https://lore.kernel.org/lkml/20201110151444.20662-1-rppt@kernel.org
* Use CMA for all secretmem allocations as David suggested
* Update memcg accounting after transtion to CMA
* Prevent hibernation when there are active secretmem users
* Add zeroing of the memory before releasing it back to cma/page allocator
* Rebase on v5.10-rc2-mmotm-2020-11-07-21-40

v7: https://lore.kernel.org/lkml/20201026083752.13267-1-rppt@kernel.org
* Use set_direct_map() instead of __kernel_map_pages() to ensure error
  handling in case the direct map update fails
* Add accounting of large pages used to reduce the direct map fragmentation
* Teach get_user_pages() and frieds to refuse get/pin secretmem pages

v6: https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org
* Silence the warning about missing syscall, thanks to Qian Cai
* Replace spaces with tabs in Kconfig additions, per Randy
* Add a selftest.

Older history:
v5: https://lore.kernel.org/lkml/20200916073539.3552-1-rppt@kernel.org
v4: https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
v3: https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
v2: https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org

Mike Rapoport (9):
  mm: add definition of PMD_PAGE_ORDER
  mmap: make mlock_future_check() global
  set_memory: allow set_direct_map_*_noflush() for multiple pages
  mm: introduce memfd_secret system call to create "secret" memory areas
  secretmem: use PMD-size pages to amortize direct map fragmentation
  secretmem: add memcg accounting
  PM: hibernate: disable when there are active secretmem users
  arch, mm: wire up memfd_secret system call were relevant
  secretmem: test: add basic selftest for memfd_secret(2)

 arch/arm64/include/asm/cacheflush.h       |   4 +-
 arch/arm64/include/uapi/asm/unistd.h      |   1 +
 arch/arm64/mm/pageattr.c                  |  10 +-
 arch/riscv/include/asm/set_memory.h       |   4 +-
 arch/riscv/include/asm/unistd.h           |   1 +
 arch/riscv/mm/pageattr.c                  |   8 +-
 arch/x86/Kconfig                          |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 arch/x86/include/asm/set_memory.h         |   4 +-
 arch/x86/mm/pat/set_memory.c              |   8 +-
 fs/dax.c                                  |  11 +-
 include/linux/pgtable.h                   |   3 +
 include/linux/secretmem.h                 |  30 ++
 include/linux/set_memory.h                |   4 +-
 include/linux/syscalls.h                  |   1 +
 include/uapi/asm-generic/unistd.h         |   6 +-
 include/uapi/linux/magic.h                |   1 +
 kernel/power/hibernate.c                  |   5 +-
 kernel/power/snapshot.c                   |   4 +-
 kernel/sys_ni.c                           |   2 +
 mm/Kconfig                                |   5 +
 mm/Makefile                               |   1 +
 mm/filemap.c                              |   3 +-
 mm/gup.c                                  |  10 +
 mm/internal.h                             |   3 +
 mm/mmap.c                                 |   5 +-
 mm/secretmem.c                            | 436 ++++++++++++++++++++++
 mm/vmalloc.c                              |   5 +-
 scripts/checksyscalls.sh                  |   4 +
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   3 +-
 tools/testing/selftests/vm/memfd_secret.c | 298 +++++++++++++++
 tools/testing/selftests/vm/run_vmtests    |  17 +
 34 files changed, 863 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/secretmem.h
 create mode 100644 mm/secretmem.c
 create mode 100644 tools/testing/selftests/vm/memfd_secret.c


base-commit: 9f8ce377d420db12b19d6a4f636fecbd88a725a5
-- 
2.28.0

