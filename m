Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13333387303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbhERHWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 03:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347038AbhERHWI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 03:22:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0CFB61285;
        Tue, 18 May 2021 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621322450;
        bh=l84iPZLMSWa+1gRiotGw3RYbPRxJwZEvVf7X02ydNHU=;
        h=From:To:Cc:Subject:Date:From;
        b=R0u2kHaJK3uBuAP+TZqN2fysJePYZTocRTDjzZd6q84tXaOycq4dnPZM2rGO1Ucyo
         aMvFCbRqzKqwfatLNRnm9diDklE1fBuzk+LU1fHq6eaZVLvEYSVNF7iZuOXoq7Kf5m
         RGxU+s5OBxudOXA6OBnR+FCrG1zfc00xRG5sbgMFsHAZBemf7HpdCADz+A0gniiP6J
         21GNA3nA7/puAuhswFkUUlQYz23f43Pp6zO3fChi0CbNhD9kqar3FnRv0RI0bUk0uS
         Xsqc1gkCp/bqye9PBrjmUf18wfrnNaRDPCWeFuOQlBIp7et73IEThLp6PV0ObHXveU
         z5zSlFDax5Srw==
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v20 0/7] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Tue, 18 May 2021 10:20:27 +0300
Message-Id: <20210518072034.31572-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

@Andrew, this is based on v5.13-rc1, I can rebase whatever way you prefer.

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

It's designed to provide the following protections:

* Enhanced protection (in conjunction with all the other in-kernel
attack prevention systems) against ROP attacks. Seceretmem makes "simple"
ROP insufficient to perform exfiltration, which increases the required
complexity of the attack. Along with other protections like the kernel
stack size limit and address space layout randomization which make finding
gadgets is really hard, absence of any in-kernel primitive for accessing
secret memory means the one gadget ROP attack can't work. Since the only
way to access secret memory is to reconstruct the missing mapping entry,
the attacker has to recover the physical page and insert a PTE pointing to
it in the kernel and then retrieve the contents.  That takes at least three
gadgets which is a level of difficulty beyond most standard attacks.

* Prevent cross-process secret userspace memory exposures. Once the secret
memory is allocated, the user can't accidentally pass it into the kernel to
be transmitted somewhere. The secreremem pages cannot be accessed via the
direct map and they are disallowed in GUP.

* Harden against exploited kernel flaws. In order to access secretmem, a
kernel-side attack would need to either walk the page tables and create new
ones, or spawn a new privileged uiserspace process to perform secrets
exfiltration using ptrace.

In the future the secret mappings may be used as a mean to protect guest memory
in a virtual machine host.

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

Hiding secret memory mappings behind an anonymous file allows usage of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs in the future.

Removing of the pages from the direct map may cause its fragmentation on
architectures that use large pages to map the physical memory which affects
the system performance. However, the original Kconfig text for
CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct map "... can
improve the kernel's performance a tiny bit ..." (commit 00d1c5e05736
("x86: add gbpages switches")) and the recent report [1] showed that "...
although 1G mappings are a good default choice, there is no compelling
evidence that it must be the only choice". Hence, it is sufficient to have
secretmem disabled by default with the ability of a system administrator to
enable it at boot time.

In addition, there is also a long term goal to improve management of the
direct map.

[1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

v20:
* Drop the patch that enable multi-page updates to the direct map, per David
* Drop the changes to /dev/mem, they anyway have no effect when CONFIG_STRICT_DEVMEM=y
* Add Acked-by and Reviewed-by tags

v19: https://lore.kernel.org/lkml/20210513184734.29317-1-rppt@kernel.org
* block /dev/mem mmap access, per David
* disallow mmap/mprotect with PROT_EXEC, per Kees
* simplify return in page_is_secretmem(), per Matthew
* use unsigned int for syscall falgs, per Yury

v18: https://lore.kernel.org/lkml/20210303162209.8609-1-rppt@kernel.org
* rebase on v5.12-rc1
* merge kfence fix into the original patch
* massage commit message of the patch introducing the memfd_secret syscall

v17: https://lore.kernel.org/lkml/20210208084920.2884-1-rppt@kernel.org
* Remove pool of large pages backing secretmem allocations, per Michal Hocko
* Add secretmem pages to unevictable LRU, per Michal Hocko
* Use GFP_HIGHUSER as secretmem mapping mask, per Michal Hocko
* Make secretmem an opt-in feature that is disabled by default
 
v16: https://lore.kernel.org/lkml/20210121122723.3446-1-rppt@kernel.org
* Fix memory leak intorduced in v15
* Clean the data left from previous page user before handing the page to
  the userspace

Older history:
v15: https://lore.kernel.org/lkml/20210120180612.1058-1-rppt@kernel.org
v14: https://lore.kernel.org/lkml/20201203062949.5484-1-rppt@kernel.org
v13: https://lore.kernel.org/lkml/20201201074559.27742-1-rppt@kernel.org
v12: https://lore.kernel.org/lkml/20201125092208.12544-1-rppt@kernel.org
v11: https://lore.kernel.org/lkml/20201124092556.12009-1-rppt@kernel.org
v10: https://lore.kernel.org/lkml/20201123095432.5860-1-rppt@kernel.org
v9: https://lore.kernel.org/lkml/20201117162932.13649-1-rppt@kernel.org
v8: https://lore.kernel.org/lkml/20201110151444.20662-1-rppt@kernel.org
v7: https://lore.kernel.org/lkml/20201026083752.13267-1-rppt@kernel.org
v6: https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org
v5: https://lore.kernel.org/lkml/20200916073539.3552-1-rppt@kernel.org
v4: https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
v3: https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
v2: https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org
rfc-v2: https://lore.kernel.org/lkml/20200706172051.19465-1-rppt@kernel.org/
rfc-v1: https://lore.kernel.org/lkml/20200130162340.GA14232@rapoport-lnx/
rfc-v0: https://lore.kernel.org/lkml/1572171452-7958-1-git-send-email-rppt@kernel.org/

Mike Rapoport (7):
  mmap: make mlock_future_check() global
  riscv/Kconfig: make direct map manipulation options depend on MMU
  set_memory: allow querying whether set_direct_map_*() is actually
    enabled
  mm: introduce memfd_secret system call to create "secret" memory areas
  PM: hibernate: disable when there are active secretmem users
  arch, mm: wire up memfd_secret system call where relevant
  secretmem: test: add basic selftest for memfd_secret(2)

 arch/arm64/include/asm/Kbuild             |   1 -
 arch/arm64/include/asm/cacheflush.h       |   6 -
 arch/arm64/include/asm/kfence.h           |   2 +-
 arch/arm64/include/asm/set_memory.h       |  17 ++
 arch/arm64/include/uapi/asm/unistd.h      |   1 +
 arch/arm64/kernel/machine_kexec.c         |   1 +
 arch/arm64/mm/mmu.c                       |   6 +-
 arch/arm64/mm/pageattr.c                  |  13 +-
 arch/riscv/Kconfig                        |   4 +-
 arch/riscv/include/asm/unistd.h           |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 include/linux/secretmem.h                 |  54 ++++
 include/linux/set_memory.h                |  12 +
 include/linux/syscalls.h                  |   1 +
 include/uapi/asm-generic/unistd.h         |   7 +-
 include/uapi/linux/magic.h                |   1 +
 kernel/power/hibernate.c                  |   5 +-
 kernel/sys_ni.c                           |   2 +
 mm/Kconfig                                |   5 +
 mm/Makefile                               |   1 +
 mm/gup.c                                  |  12 +
 mm/internal.h                             |   3 +
 mm/mlock.c                                |   3 +-
 mm/mmap.c                                 |   5 +-
 mm/secretmem.c                            | 254 +++++++++++++++++++
 scripts/checksyscalls.sh                  |   4 +
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   3 +-
 tools/testing/selftests/vm/memfd_secret.c | 296 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  17 ++
 31 files changed, 716 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/include/asm/set_memory.h
 create mode 100644 include/linux/secretmem.h
 create mode 100644 mm/secretmem.c
 create mode 100644 tools/testing/selftests/vm/memfd_secret.c


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.28.0

