Return-Path: <linux-fsdevel+bounces-49025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87567AB7986
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F787A459D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B65226D00;
	Wed, 14 May 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYdTzitm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264F1EB1B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266179; cv=none; b=hZIbApDyrbFulduiGWJtH949fJbamq8hQOz5wifY+Ix0/YjHTw9YUJwX1Ey5eLT4hBsF2yf3oFN2oMW0e8UtijYPJOdJ9247xtTSiATUr1BdhvMn3jjGDMPYS50ajRYwPX+leznvDQbwd4kf8mgSTgd0hylYnqGH6dPDDBtH54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266179; c=relaxed/simple;
	bh=kG7HoMTrfHXv8bqvsDGKYcmezmpctmHwllOqn9qt2cs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B+GEIxBonpgwpAeR4b65DLevrgCkCW0C2tMummduG7FRsgmtHEautrVIMxXvw3jzyzrkkAKb+bFYl0qzkG+3Yb8IIny2mS3XH/K3MGfWTNpEvvnU4MSlMs38I5zx0lHzbD2/N2jRXpQOkvh0LYP9ViDvs1RNdRMCnVN78gu/Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYdTzitm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e48854445so266052a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266177; x=1747870977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwqGrUiOjHvJJnxbyG+X+anw8ewdbXKmpYSNoes50/Y=;
        b=dYdTzitmVv6y+TD329LfdTqV5s6eDzgDWz90QFEFBQsDg4O2kdW4tO+g+iPLI8CH0X
         Ow/NdMeGhUHeFb0Fwl02SwSFCVHDJsm5Lfnjma2D5dwMYAXbAy0Fb/qX+jenfcdD6EgU
         VxDmROMNSjIb3M1xgEay34k3hP+YB+OIypxh8deDHk3DHCx5HCMBHhTLISMEN5mpRAQB
         e6C0NCGVGebl2DcgdyqLGo6B/z4xuPZYU25wWLaf8FW3O4TXT7M3kh/IqwOdZc0wtR1D
         MVTzoGUVUVJY12hzAOKi5FDJM1wUN49xDWqSBLpnLvfWoF6iXjQWyvOY3bX8xTTon/E5
         Oodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266177; x=1747870977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwqGrUiOjHvJJnxbyG+X+anw8ewdbXKmpYSNoes50/Y=;
        b=RC1vk3KsXyOHjtn10JLS0UwdD32pwgBbOERecK+uFJLimHl1EK+MKOJAPvetb41QQm
         Z7FolKkkRo7N1keBiLLVD9D3/GZsjarFodguEGfTFz8+uFmwxHTzi4OpIV+BH4bjhaFF
         CUt+PJgvILXF2i2IhpA+aywvU8DHa+I3fXjXxks4CYPR4hzE7SgWueS8cO4IoeXg7f1C
         9TjCWOl3HarvSRaW/77EM5ykwxHH8ExxSU4Ukc+sDqa5o9oWwBqPq04jzph9PwI25LHJ
         RmzQyi9TAxG2i/6kRG5oVLuAS06Pj4Y3X5qS3OHzPhB9+hRNYlSCr60dRDy8b/p/mO77
         wYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjZyGcWXuNV1OiQK7dOzaNgvScv55oY75YJvhEETqISsmSRQncCso8Uwz0t00senOlRmjIXggX4CfLS2IC@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzTC1/e0mC/ksZ1VOUHlXNOoECn08FpJI6/kgN/hvlBs12K9q
	YqSmyfhyIaySNwkN1uZ7SvfXqfONwNha/eN5T18lCNBC/Ot7Yjg8ES9Aa+GWgqZnRo0bsA64i8q
	FVkUtFC2j8gztdyAkXOaIbQ==
X-Google-Smtp-Source: AGHT+IERrB6TWSBQZL8LGOX6EETFEN6+F+QJfjTnuW65iRmylkCaeR55nU6SQCFovka0Yb5n9ELAV7ZNQnoM1ohNmw==
X-Received: from pjf3.prod.google.com ([2002:a17:90b:3f03:b0:2fb:fa85:1678])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5403:b0:301:1d9f:4ba2 with SMTP id 98e67ed59e1d1-30e51914ea8mr650385a91.28.1747266176876;
 Wed, 14 May 2025 16:42:56 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <cover.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This patchset builds upon discussion at LPC 2024 and many guest_memfd
upstream calls to provide 1G page support for guest_memfd by taking
pages from HugeTLB.

This patchset is based on Linux v6.15-rc6, and requires the mmap support
for guest_memfd patchset (Thanks Fuad!) [1].

For ease of testing, this series is also available, stitched together,
at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2

This patchset can be divided into two sections:

(a) Patches from the beginning up to and including "KVM: selftests:
    Update script to map shared memory from guest_memfd" are a modified
    version of "conversion support for guest_memfd", which Fuad is
    managing [2].

(b) Patches after "KVM: selftests: Update script to map shared memory
    from guest_memfd" till the end are patches that actually bring in 1G
    page support for guest_memfd.

These are the significant differences between (a) and [2]:

+ [2] uses an xarray to track sharability, but I used a maple tree
  because for 1G pages, iterating pagewise to update shareability was
  prohibitively slow even for testing. I was choosing from among
  multi-index xarrays, interval trees and maple trees [3], and picked
  maple trees because
    + Maple trees were easier to figure out since I didn't have to
      compute the correct multi-index order and handle edge cases if the
      converted range wasn't a neat power of 2.
    + Maple trees were easier to figure out as compared to updating
      parts of a multi-index xarray.
    + Maple trees had an easier API to use than interval trees.
+ [2] doesn't yet have a conversion ioctl, but I needed it to test 1G
  support end-to-end.
+ (a) Removes guest_memfd from participating in LRU, which I needed, to
  get conversion selftests to work as expected, since participation in
  LRU was causing some unexpected refcounts on folios which was blocking
  conversions.

I am sending (a) in emails as well, as opposed to just leaving it on
GitHub, so that we can discuss by commenting inline on emails. If you'd
like to just look at 1G page support, here are some key takeaways from
the first section (a):

+ If GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested during guest_memfd
  creation, guest_memfd will
    + Track shareability (whether an index in the inode is guest-only or
      if the host is allowed to fault memory at a given index).
    + Always be used for guest faults - specifically, kvm_gmem_get_pfn()
      will be used to provide pages for the guest.
    + Always be used by KVM to check private/shared status of a gfn.
+ guest_memfd now has conversion ioctls, allowing conversion to
  private/shared
    + Conversion can fail if there are unexpected refcounts on any
      folios in the range.

Focusing on (b) 1G page support, here's an overview:

1. A bunch of refactoring patches for HugeTLB that isolates the
   allocation of a HugeTLB folio from other HugeTLB concepts such as
   VMA-level reservations, and HugeTLBfs-specific concepts, such as
   where memory policy is stored in the VMA, or where the subpool is
   stored on the inode.
2. A few patches that add a guestmem_hugetlb allocator within mm/. The
   guestmem_hugetlb allocator is a wrapper around HugeTLB to modularize
   the memory management functions, and to cleanly handle cleanup, so
   that folio cleanup can happen after the guest_memfd inode (and even
   KVM) goes away.
3. Some updates to guest_memfd to use the guestmem_hugetlb allocator.
4. Selftests for 1G page support.

Here are some remaining issues/TODOs:

1. Memory error handling such as machine check errors have not been
   implemented.
2. I've not looked into preparedness of pages, only zeroing has been
   considered.
3. When allocating HugeTLB pages, if two threads allocate indices
   mapping to the same huge page, the utilization in guest_memfd inode's
   subpool may momentarily go over the subpool limit (the requested size
   of the inode at guest_memfd creation time), causing one of the two
   threads to get -ENOMEM. Suggestions to solve this are appreciated!
4. max_usage_in_bytes statistic (cgroups v1) for guest_memfd HugeTLB
   pages should be correct but needs testing and could be wrong.
5. memcg charging (charge_memcg()) for cgroups v2 for guest_memfd
   HugeTLB pages after splitting should be correct but needs testing and
   could be wrong.
6. Page cache accounting: When a hugetlb page is split, guest_memfd will
   incur page count in both NR_HUGETLB (counted at hugetlb allocation
   time) and NR_FILE_PAGES stats (counted when split pages are added to
   the filemap). Is this aligned with what people expect?

Here are some optimizations that could be explored in future series:

1. Pages could be split from 1G to 2M first and only split to 4K if
   necessary.
2. Zeroing could be skipped for Coco VMs if hardware already zeroes the
   pages.

Here's RFC v1 [4] if you're interested in the motivation behind choosing
HugeTLB, or the history of this patch series.

[1] https://lore.kernel.org/all/20250513163438.3942405-11-tabba@google.com/T/
[2] https://lore.kernel.org/all/20250328153133.3504118-1-tabba@google.com/T/
[3] https://lore.kernel.org/all/diqzzfih8q7r.fsf@ackerleytng-ctop.c.googlers.com/
[4] https://lore.kernel.org/all/cover.1726009989.git.ackerleytng@google.com/T/

---

Ackerley Tng (49):
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of
    anonymous inodes
  KVM: guest_memfd: Introduce and use shareability to guard faulting
  KVM: selftests: Update guest_memfd_test for INIT_PRIVATE flag
  KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
  KVM: guest_memfd: Skip LRU for guest_memfd folios
  KVM: Query guest_memfd for private/shared status
  KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
  KVM: selftests: Test flag validity after guest_memfd supports
    conversions
  KVM: selftests: Test faulting with respect to
    GUEST_MEMFD_FLAG_INIT_PRIVATE
  KVM: selftests: Refactor vm_mem_add to be more flexible
  KVM: selftests: Allow cleanup of ucall_pool from host
  KVM: selftests: Test conversion flows for guest_memfd
  KVM: selftests: Add script to exercise private_mem_conversions_test
  KVM: selftests: Update private_mem_conversions_test to mmap
    guest_memfd
  KVM: selftests: Update script to map shared memory from guest_memfd
  mm: hugetlb: Consolidate interpretation of gbl_chg within
    alloc_hugetlb_folio()
  mm: hugetlb: Cleanup interpretation of gbl_chg in
    alloc_hugetlb_folio()
  mm: hugetlb: Cleanup interpretation of map_chg_state within
    alloc_hugetlb_folio()
  mm: hugetlb: Rename alloc_surplus_hugetlb_folio
  mm: mempolicy: Refactor out policy_node_nodemask()
  mm: hugetlb: Inline huge_node() into callers
  mm: hugetlb: Refactor hugetlb allocation functions
  mm: hugetlb: Refactor out hugetlb_alloc_folio()
  mm: hugetlb: Add option to create new subpool without using surplus
  mm: truncate: Expose preparation steps for truncate_inode_pages_final
  mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
  mm: Introduce guestmem_hugetlb to support folio_put() handling of
    guestmem pages
  mm: guestmem_hugetlb: Wrap HugeTLB as an allocator for guest_memfd
  mm: truncate: Expose truncate_inode_folio()
  KVM: x86: Set disallow_lpage on base_gfn and guest_memfd pgoff
    misalignment
  KVM: guest_memfd: Support guestmem_hugetlb as custom allocator
  KVM: guest_memfd: Allocate and truncate from custom allocator
  mm: hugetlb: Add functions to add/delete folio from hugetlb lists
  mm: guestmem_hugetlb: Add support for splitting and merging pages
  mm: Convert split_folio() macro to function
  KVM: guest_memfd: Split allocator pages for guest_memfd use
  KVM: guest_memfd: Merge and truncate on fallocate(PUNCH_HOLE)
  KVM: guest_memfd: Update kvm_gmem_mapping_order to account for page
    status
  KVM: Add CAP to indicate support for HugeTLB as custom allocator
  KVM: selftests: Add basic selftests for hugetlb-backed guest_memfd
  KVM: selftests: Update conversion flows test for HugeTLB
  KVM: selftests: Test truncation paths of guest_memfd
  KVM: selftests: Test allocation and conversion of subfolios
  KVM: selftests: Test that guest_memfd usage is reported via hugetlb
  KVM: selftests: Support various types of backing sources for private
    memory
  KVM: selftests: Update test for various private memory backing source
    types
  KVM: selftests: Update private_mem_conversions_test.sh to test with
    HugeTLB pages
  KVM: selftests: Add script to test HugeTLB statistics
  KVM: selftests: Test guest_memfd for accuracy of st_blocks

Elliot Berman (1):
  filemap: Pass address_space mapping to ->free_folio()

Fuad Tabba (1):
  mm: Consolidate freeing of typed folios on final folio_put()

 Documentation/filesystems/locking.rst         |    2 +-
 Documentation/filesystems/vfs.rst             |   15 +-
 Documentation/virt/kvm/api.rst                |    5 +
 arch/arm64/include/asm/kvm_host.h             |    5 -
 arch/x86/include/asm/kvm_host.h               |   10 -
 arch/x86/kvm/x86.c                            |   53 +-
 fs/hugetlbfs/inode.c                          |    2 +-
 fs/nfs/dir.c                                  |    9 +-
 fs/orangefs/inode.c                           |    3 +-
 include/linux/fs.h                            |    2 +-
 include/linux/guestmem.h                      |   23 +
 include/linux/huge_mm.h                       |    6 +-
 include/linux/hugetlb.h                       |   19 +-
 include/linux/kvm_host.h                      |   32 +-
 include/linux/mempolicy.h                     |   11 +-
 include/linux/mm.h                            |    2 +
 include/linux/page-flags.h                    |   32 +
 include/uapi/linux/guestmem.h                 |   29 +
 include/uapi/linux/kvm.h                      |   16 +
 include/uapi/linux/magic.h                    |    1 +
 mm/Kconfig                                    |   13 +
 mm/Makefile                                   |    1 +
 mm/debug.c                                    |    1 +
 mm/filemap.c                                  |   12 +-
 mm/guestmem_hugetlb.c                         |  512 +++++
 mm/guestmem_hugetlb.h                         |    9 +
 mm/hugetlb.c                                  |  488 ++---
 mm/internal.h                                 |    1 -
 mm/memcontrol.c                               |    2 +
 mm/memory.c                                   |    1 +
 mm/mempolicy.c                                |   44 +-
 mm/secretmem.c                                |    3 +-
 mm/swap.c                                     |   32 +-
 mm/truncate.c                                 |   27 +-
 mm/vmscan.c                                   |    4 +-
 tools/testing/selftests/kvm/Makefile.kvm      |    2 +
 .../kvm/guest_memfd_conversions_test.c        |  797 ++++++++
 .../kvm/guest_memfd_hugetlb_reporting_test.c  |  384 ++++
 ...uest_memfd_provide_hugetlb_cgroup_mount.sh |   36 +
 .../testing/selftests/kvm/guest_memfd_test.c  |  293 ++-
 ...memfd_wrap_test_check_hugetlb_reporting.sh |   95 +
 .../testing/selftests/kvm/include/kvm_util.h  |  104 +-
 .../testing/selftests/kvm/include/test_util.h |   20 +-
 .../selftests/kvm/include/ucall_common.h      |    1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  465 +++--
 tools/testing/selftests/kvm/lib/test_util.c   |  102 +
 .../testing/selftests/kvm/lib/ucall_common.c  |   16 +-
 .../kvm/x86/private_mem_conversions_test.c    |  195 +-
 .../kvm/x86/private_mem_conversions_test.sh   |  100 +
 virt/kvm/Kconfig                              |    5 +
 virt/kvm/guest_memfd.c                        | 1655 ++++++++++++++++-
 virt/kvm/kvm_main.c                           |   14 +-
 virt/kvm/kvm_mm.h                             |    9 +-
 53 files changed, 5080 insertions(+), 640 deletions(-)
 create mode 100644 include/linux/guestmem.h
 create mode 100644 include/uapi/linux/guestmem.h
 create mode 100644 mm/guestmem_hugetlb.c
 create mode 100644 mm/guestmem_hugetlb.h
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_conversions_test.c
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
 create mode 100755 tools/testing/selftests/kvm/guest_memfd_provide_hugetlb_cgroup_mount.sh
 create mode 100755 tools/testing/selftests/kvm/guest_memfd_wrap_test_check_hugetlb_reporting.sh
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh

--
2.49.0.1045.g170613ef41-goog

