Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFD422358D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGQHVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:38280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgGQHVD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:03 -0400
IronPort-SDR: fhww83RE7/gG1RtCyURKCWCZHHtrGg/0gok/v6detj439xtsZ762DxgwCz/fQgboV6fNgQPwat
 hEwqyhz6uigA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137665999"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="137665999"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:00 -0700
IronPort-SDR: I2kPLSZY3sAJB+AtMjz54IDv5wzrL5svBf5Z2YmpNMJTlVEZtD0KsDT1urlyovYN6eDZ/bnV7t
 EEcE83OL6BIw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="325362807"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:00 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 00/17] PKS: Add Protection Keys Supervisor (PKS) support
Date:   Fri, 17 Jul 2020 00:20:39 -0700
Message-Id: <20200717072056.73134-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This RFC series has been reviewed by Dave Hansen.

Changes from RFC:
	Clean up commit messages based on Peter Zijlstra's and Dave Hansen's
		feedback
	Fix static branch anti-pattern
	New patch:
	(memremap: Convert devmap static branch to {inc,dec})
		This was the code I used as a model for my static branch which
		I believe is wrong now.
	New Patch:
	(x86/entry: Preserve PKRS MSR through exceptions)
		This attempts to preserve the per-logical-processor MSR, and
		reference counting during exceptions.  I'd really like feed
		back on this because I _think_ it should work but I'm afraid
		I'm missing something as my testing has shown a lot of spotty
		crashes which don't make sense to me.

This patch set introduces a new page protection mechanism for supervisor pages,
Protection Key Supervisor (PKS) and an initial user of them, persistent memory,
PMEM.

PKS enables protections on 'domains' of supervisor pages to limit supervisor
mode access to those pages beyond the normal paging protections.  They work in
a similar fashion to user space pkeys.  Like User page pkeys (PKU), supervisor
pkeys are checked in addition to normal paging protections and Access or Writes
can be disabled via a MSR update without TLB flushes when permissions change.
A page mapping is assigned to a domain by setting a pkey in the page table
entry.

Unlike User pkeys no new instructions are added; rather WRMSR/RDMSR are used to
update the PKRS register.

XSAVE is not supported for the PKRS MSR.  To reduce software complexity the
implementation saves/restores the MSR across context switches but not during
irqs.  This is a compromise which results is a hardening of unwanted access
without absolute restriction.

For consistent behavior with current paging protections, pkey 0 is reserved and
configured to allow full access via the pkey mechanism, thus preserving the
default paging protections on mappings with the default pkey value of 0.

Other keys, (1-15) are allocated by an allocator which prepares us for key
contention from day one.  Kernel users should be prepared for the allocator to
fail either because of key exhaustion or due to PKS not being supported on the
arch and/or CPU instance.

Protecting against stray writes is particularly important for PMEM because,
unlike writes to anonymous memory, writes to PMEM persists across a reboot.
Thus data corruption could result in permanent loss of data.

The following attributes of PKS makes it perfect as a mechanism to protect PMEM
from stray access within the kernel:

   1) Fast switching of permissions
   2) Prevents access without page table manipulations
   3) Works on a per thread basis
   4) No TLB flushes required

The second half of this series thus uses the PKS mechanism to protect PMEM from
stray access.

PKS is available with 4 and 5 level paging.  Like PKRU is takes 4 bits from the
PTE to store the pkey within the entry.


Implementation details
----------------------

Modifications of task struct in patches:
	(x86/pks: Preserve the PKRS MSR on context switch)
	(memremap: Add zone device access protection)

Because pkey access is per-thread 2 modifications are made to the task struct.
The first is a saved copy of the MSR during context switches.  The second
reference counts access to the device domain to correctly handle kmap nesting
properly.


Maintain PKS setting in a re-entrant manner in patch:
	(memremap: Add zone device access protection)
	(x86/entry: Preserve PKRS MSR through exceptions)

Using local_irq_save() seems to be the safest and fastest way to maintain kmap
as re-entrant.  But there may be a better way.  spin_lock_irq() and atomic
counters were considered.  But atomic counters do not properly protect the pkey
update and spin_lock_irq() would deadlock.  Suggestions are welcome.

Also preserving the pks state requires the exception handling code to store the
ref count during exception processing.  This seems like a layering violation
but it works.


The use of kmap in patch:
	(kmap: Add stray write protection for device pages)

To keep general access to PMEM pages general, we piggy back on the kmap()
interface as there are many places in the kernel who do not have, nor should be
required to have, a priori knowledge that a page is PMEM.  The modifications to
the kmap code is careful to quickly determine which pages don't require special
handling to reduce overhead for non PMEM pages.



Breakdown of patches
--------------------

Implement PKS within x86 arch:

	x86/pkeys: Create pkeys_internal.h
	x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
	x86/pks: Enable Protection Keys Supervisor (PKS)
	x86/pks: Preserve the PKRS MSR on context switch
	x86/pks: Add PKS kernel API
	x86/pks: Add a debugfs file for allocated PKS keys
	Documentation/pkeys: Update documentation for kernel pkeys
	x86/pks: Add PKS Test code

pre-req bug fixes for dax:

	fs/dax: Remove unused size parameter
	drivers/dax: Expand lock scope to cover the use of addresses

Add stray write protection to PMEM:

	memremap: Add zone device access protection
	kmap: Add stray write protection for device pages
	dax: Stray write protection for dax_direct_access()
	nvdimm/pmem: Stray write protection for pmem->virt_addr
	[dax|pmem]: Enable stray write protection


Fenghua Yu (4):
  x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
  x86/pks: Enable Protection Keys Supervisor (PKS)
  x86/pks: Add PKS kernel API
  x86/pks: Add a debugfs file for allocated PKS keys

Ira Weiny (13):
  x86/pkeys: Create pkeys_internal.h
  x86/pks: Preserve the PKRS MSR on context switch
  Documentation/pkeys: Update documentation for kernel pkeys
  x86/pks: Add PKS Test code
  memremap: Convert devmap static branch to {inc,dec}
  fs/dax: Remove unused size parameter
  drivers/dax: Expand lock scope to cover the use of addresses
  memremap: Add zone device access protection
  kmap: Add stray write protection for device pages
  dax: Stray write protection for dax_direct_access()
  nvdimm/pmem: Stray write protection for pmem->virt_addr
  [dax|pmem]: Enable stray write protection
  x86/entry: Preserve PKRS MSR across exceptions

 Documentation/core-api/protection-keys.rst  |  81 +++-
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/common.c                     |  78 +++-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/idtentry.h             |   2 +
 arch/x86/include/asm/msr-index.h            |   1 +
 arch/x86/include/asm/pgtable.h              |  13 +-
 arch/x86/include/asm/pgtable_types.h        |   4 +
 arch/x86/include/asm/pkeys.h                |  43 ++
 arch/x86/include/asm/pkeys_internal.h       |  36 ++
 arch/x86/include/asm/processor.h            |  13 +
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/cpu/common.c                |  17 +
 arch/x86/kernel/fpu/xstate.c                |  17 +-
 arch/x86/kernel/process.c                   |  34 ++
 arch/x86/mm/fault.c                         |  16 +-
 arch/x86/mm/pkeys.c                         | 174 +++++++-
 drivers/dax/device.c                        |   2 +
 drivers/dax/super.c                         |   5 +-
 drivers/nvdimm/pmem.c                       |   6 +
 fs/dax.c                                    |  13 +-
 include/linux/highmem.h                     |  32 +-
 include/linux/memremap.h                    |   1 +
 include/linux/mm.h                          |  33 ++
 include/linux/pkeys.h                       |  18 +
 include/linux/sched.h                       |   3 +
 init/init_task.c                            |   3 +
 kernel/fork.c                               |   3 +
 lib/Kconfig.debug                           |  12 +
 lib/Makefile                                |   3 +
 lib/pks/Makefile                            |   3 +
 lib/pks/pks_test.c                          | 452 ++++++++++++++++++++
 mm/Kconfig                                  |  15 +
 mm/memremap.c                               | 105 ++++-
 tools/testing/selftests/x86/Makefile        |   3 +-
 tools/testing/selftests/x86/test_pks.c      |  65 +++
 36 files changed, 1243 insertions(+), 67 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_internal.h
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

-- 
2.28.0.rc0.12.gb6a658bd00c9

