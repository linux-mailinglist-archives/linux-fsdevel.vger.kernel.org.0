Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13B37FDE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEMTLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 15:11:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230394AbhEMTLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 15:11:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DJ4jxX080582;
        Thu, 13 May 2021 15:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=9KGxdVfKAFm1I53SUvn34ujA5n44tgSgVk4imYX1XGI=;
 b=hzaalpiCUueoLXUUbKI9QLpVLcQPnGEkI7yS+gd0GTOXDR4ahuZ2bGcVBQ2tX9ZNX7dt
 TUQeLd27KOkU1s8VW9omCbwXl1NCq9yql2TZSh67MdgONAPmTZSgZjN2idUhENuetP6X
 EVo2kKyTbOKbuaY8TKsP9GannMu7y6uXZEYTjXykc0CLbzRtAz35gAS5AMY7+zyzKchs
 3zAJK5oJRgR5Uuvy+YOUJeyjhYJyIYS64tjtFmc7v9HY2tbauqdD4pxuwdWNZ27PCnQ4
 kj5Ll0zBudokMs9v3yHQEVsm/fsHS2a7rb+ADiNTjcFVdiXfWMwJy/cFqa+bvkAt6QRh Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38h8kpaaag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 15:08:37 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14DJ67os087378;
        Thu, 13 May 2021 15:08:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38h8kpaa9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 15:08:35 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14DJ8TOH029614;
        Thu, 13 May 2021 19:08:34 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 38fu1y91jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 19:08:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14DJ8XvI31457738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 19:08:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433CB7805C;
        Thu, 13 May 2021 19:08:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01C2D7805E;
        Thu, 13 May 2021 19:08:25 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 19:08:25 +0000 (GMT)
Message-ID: <821fa66abf8b05f78eb4d25d4b260e3ded887536.camel@linux.ibm.com>
Subject: Re: [PATCH v19 0/8] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
Date:   Thu, 13 May 2021 12:08:24 -0700
In-Reply-To: <20210513184734.29317-1-rppt@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ap-yiBU9BTIbIPC0ZJGSsyE3t6-UbeR
X-Proofpoint-ORIG-GUID: c38dzU9azelNW-MAXavtk9uxz-7I1msz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_12:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-13 at 21:47 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> @Andrew, this is based on v5.13-rc1, I can rebase whatever way you
> prefer.
> 
> This is an implementation of "secret" mappings backed by a file
> descriptor.
> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for
> the
> memory is configured using flags parameter of the system call. The
> mmap()
> of the file descriptor created with memfd_secret() will create a
> "secret"
> memory mapping. The pages in that mapping will be marked as not
> present in
> the direct map and will be present only in the page table of the
> owning mm.
> 
> Although normally Linux userspace mappings are protected from other
> users,
> such secret mappings are useful for environments where a hostile
> tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.
> 
> It's designed to provide the following protections:
> 
> * Enhanced protection (in conjunction with all the other in-kernel
> attack prevention systems) against ROP attacks. Seceretmem makes
> "simple"
> ROP insufficient to perform exfiltration, which increases the
> required
> complexity of the attack. Along with other protections like the
> kernel
> stack size limit and address space layout randomization which make
> finding
> gadgets is really hard, absence of any in-kernel primitive for
> accessing
> secret memory means the one gadget ROP attack can't work. Since the
> only
> way to access secret memory is to reconstruct the missing mapping
> entry,
> the attacker has to recover the physical page and insert a PTE
> pointing to
> it in the kernel and then retrieve the contents.  That takes at least
> three
> gadgets which is a level of difficulty beyond most standard attacks.
> 
> * Prevent cross-process secret userspace memory exposures. Once the
> secret
> memory is allocated, the user can't accidentally pass it into the
> kernel to
> be transmitted somewhere. The secreremem pages cannot be accessed via
> the
> direct map and they are disallowed in GUP.
> 
> * Harden against exploited kernel flaws. In order to access
> secretmem, a
> kernel-side attack would need to either walk the page tables and
> create new
> ones, or spawn a new privileged uiserspace process to perform secrets
> exfiltration using ptrace.
> 
> In the future the secret mappings may be used as a mean to protect
> guest memory
> in a virtual machine host.
> 
> For demonstration of secret memory usage we've created a userspace
> library
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git
> 
> that does two things: the first is act as a preloader for openssl to
> redirect all the OPENSSL_malloc calls to secret memory meaning any
> secret
> keys get automatically protected this way and the other thing it does
> is
> expose the API to the user who needs it. We anticipate that a lot of
> the
> use cases would be like the openssl one: many toolkits that deal with
> secret keys already have special handling for the memory to try to
> give
> them greater protection, so this would simply be pluggable into the
> toolkits without any need for user application modification.
> 
> Hiding secret memory mappings behind an anonymous file allows usage
> of
> the page cache for tracking pages allocated for the "secret" mappings
> as
> well as using address_space_operations for e.g. page migration
> callbacks.
> 
> The anonymous file may be also used implicitly, like hugetlb files,
> to
> implement mmap(MAP_SECRET) and use the secret memory areas with
> "native" mm
> ABIs in the future.
> 
> Removing of the pages from the direct map may cause its fragmentation
> on
> architectures that use large pages to map the physical memory which
> affects
> the system performance. However, the original Kconfig text for
> CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct map "...
> can
> improve the kernel's performance a tiny bit ..." (commit 00d1c5e05736
> ("x86: add gbpages switches")) and the recent report [1] showed that
> "...
> although 1G mappings are a good default choice, there is no
> compelling
> evidence that it must be the only choice". Hence, it is sufficient to
> have
> secretmem disabled by default with the ability of a system
> administrator to
> enable it at boot time.
> 
> In addition, there is also a long term goal to improve management of
> the
> direct map.
> 
> [1] 
> https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
> 
> v19:
> * block /dev/mem mmap access, per David
> * disallow mmap/mprotect with PROT_EXEC, per Kees
> * simplify return in page_is_secretmem(), per Matthew
> * use unsigned int for syscall falgs, per Yury
> 
> v18: 
> https://lore.kernel.org/lkml/20210303162209.8609-1-rppt@kernel.org
> * rebase on v5.12-rc1
> * merge kfence fix into the original patch
> * massage commit message of the patch introducing the memfd_secret
> syscall
> 
> v17: 
> https://lore.kernel.org/lkml/20210208084920.2884-1-rppt@kernel.org
> * Remove pool of large pages backing secretmem allocations, per
> Michal Hocko
> * Add secretmem pages to unevictable LRU, per Michal Hocko
> * Use GFP_HIGHUSER as secretmem mapping mask, per Michal Hocko
> * Make secretmem an opt-in feature that is disabled by default
>  
> v16: 
> https://lore.kernel.org/lkml/20210121122723.3446-1-rppt@kernel.org
> * Fix memory leak intorduced in v15
> * Clean the data left from previous page user before handing the page
> to
>   the userspace
> 
> v15: 
> https://lore.kernel.org/lkml/20210120180612.1058-1-rppt@kernel.org
> * Add riscv/Kconfig update to disable set_memory operations for nommu
>   builds (patch 3)
> * Update the code around add_to_page_cache() per Matthew's comments
>   (patches 6,7)
> * Add fixups for build/checkpatch errors discovered by CI systems
> 
> Older history:
> v14: 
> https://lore.kernel.org/lkml/20201203062949.5484-1-rppt@kernel.org
> v13: 
> https://lore.kernel.org/lkml/20201201074559.27742-1-rppt@kernel.org
> v12: 
> https://lore.kernel.org/lkml/20201125092208.12544-1-rppt@kernel.org
> v11: 
> https://lore.kernel.org/lkml/20201124092556.12009-1-rppt@kernel.org
> v10: 
> https://lore.kernel.org/lkml/20201123095432.5860-1-rppt@kernel.org
> v9: 
> https://lore.kernel.org/lkml/20201117162932.13649-1-rppt@kernel.org
> v8: 
> https://lore.kernel.org/lkml/20201110151444.20662-1-rppt@kernel.org
> v7: 
> https://lore.kernel.org/lkml/20201026083752.13267-1-rppt@kernel.org
> v6: 
> https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org
> v5: 
> https://lore.kernel.org/lkml/20200916073539.3552-1-rppt@kernel.org
> v4: 
> https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
> v3: 
> https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
> v2: 
> https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
> v1: 
> https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org
> rfc-v2: 
> https://lore.kernel.org/lkml/20200706172051.19465-1-rppt@kernel.org/
> rfc-v1: 
> https://lore.kernel.org/lkml/20200130162340.GA14232@rapoport-lnx/
> rfc-v0: 
> https://lore.kernel.org/lkml/1572171452-7958-1-git-send-email-rppt@kernel.org/
> 
> Mike Rapoport (8):
>   mmap: make mlock_future_check() global
>   riscv/Kconfig: make direct map manipulation options depend on MMU
>   set_memory: allow set_direct_map_*_noflush() for multiple pages
>   set_memory: allow querying whether set_direct_map_*() is actually
> enabled
>   mm: introduce memfd_secret system call to create "secret" memory
> areas
>   PM: hibernate: disable when there are active secretmem users
>   arch, mm: wire up memfd_secret system call where relevant
>   secretmem: test: add basic selftest for memfd_secret(2)
> 
>  arch/arm64/include/asm/Kbuild             |   1 -
>  arch/arm64/include/asm/cacheflush.h       |   6 -
>  arch/arm64/include/asm/kfence.h           |   2 +-
>  arch/arm64/include/asm/set_memory.h       |  17 ++
>  arch/arm64/include/uapi/asm/unistd.h      |   1 +
>  arch/arm64/kernel/machine_kexec.c         |   1 +
>  arch/arm64/mm/mmu.c                       |   6 +-
>  arch/arm64/mm/pageattr.c                  |  23 +-
>  arch/riscv/Kconfig                        |   4 +-
>  arch/riscv/include/asm/set_memory.h       |   4 +-
>  arch/riscv/include/asm/unistd.h           |   1 +
>  arch/riscv/mm/pageattr.c                  |   8 +-
>  arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
>  arch/x86/include/asm/set_memory.h         |   4 +-
>  arch/x86/mm/pat/set_memory.c              |   8 +-
>  drivers/char/mem.c                        |   4 +
>  include/linux/secretmem.h                 |  54 ++++
>  include/linux/set_memory.h                |  16 +-
>  include/linux/syscalls.h                  |   1 +
>  include/uapi/asm-generic/unistd.h         |   7 +-
>  include/uapi/linux/magic.h                |   1 +
>  kernel/power/hibernate.c                  |   5 +-
>  kernel/power/snapshot.c                   |   4 +-
>  kernel/sys_ni.c                           |   2 +
>  mm/Kconfig                                |   4 +
>  mm/Makefile                               |   1 +
>  mm/gup.c                                  |  12 +
>  mm/internal.h                             |   3 +
>  mm/mlock.c                                |   3 +-
>  mm/mmap.c                                 |   5 +-
>  mm/secretmem.c                            | 254 +++++++++++++++++++
>  mm/vmalloc.c                              |   5 +-
>  scripts/checksyscalls.sh                  |   4 +
>  tools/testing/selftests/vm/.gitignore     |   1 +
>  tools/testing/selftests/vm/Makefile       |   3 +-
>  tools/testing/selftests/vm/memfd_secret.c | 296
> ++++++++++++++++++++++
>  tools/testing/selftests/vm/run_vmtests.sh |  17 ++
>  38 files changed, 744 insertions(+), 46 deletions(-)
>  create mode 100644 arch/arm64/include/asm/set_memory.h
>  create mode 100644 include/linux/secretmem.h
>  create mode 100644 mm/secretmem.c
>  create mode 100644 tools/testing/selftests/vm/memfd_secret.c
> 
> 
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5

For the series:

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James



