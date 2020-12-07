Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563042D0F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgLGLcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLGLcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:32:17 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457CC0613D1;
        Mon,  7 Dec 2020 03:31:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so9599419pfh.7;
        Mon, 07 Dec 2020 03:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILnSBWwyABm/ViEoQp4lFyaqVJLrOFveysOKfZkRhag=;
        b=rOqpLC970kODnReOtTNxrnnMNPzauP6Lc115KldbryjjQRCZwd2tgMSQz36C/kXt9Z
         56dN0/oxHJyldy4W9HdAVs4m9hHTgiYq6XORi2+17t9QxzLq9CSyGMoY6sU9WsUCUJmq
         hFSae+7CYWJuWnmH/utLWNjoeEGfdF6L92cc0b3mNBllb5TrS0zuwZQIrwEPB3RlN99I
         AL9gnTSq4awwyxv0ReEbuh0yGvL6GN3JwGQN39IHk9PEYfw2jBETrr4s+uq3N4+1Qm17
         takM/sOTbb34RuK6uOEAKMGSZYeKzXJt0NLJiHOg0sAG9T948DCs8tOXnElF9Bk+1YeY
         e2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILnSBWwyABm/ViEoQp4lFyaqVJLrOFveysOKfZkRhag=;
        b=LbQvAnkdfmEtyjwSlUnaagEcJqxyK9SE81MFzarHXAC1bS1KWovtx5uZH7vUR9GMWd
         tlWubRY1Xz7q4RHjbGAOFn8ejLqR1nh2bKf6JYDM1f3rRM2vGRGD1O6siPLpKDBZNzb2
         XY36QModpMXV+qKCon8nSV/UwPCHPT3LPDA/714rP/XBo5lGXb7NZSZoGLtZKOqR5mOI
         HeiBMIpFp+tLUpOAd/NpUCE/uuQcWL7aB5669BiPKCZ5RBvtzTGcv8tFl15AojGxrjlZ
         Yjowa+IQBWVb6eJ00Um0JbrlDT/Rod6TwfSATD0gYfN97T9Xhr2qNu3+F/C598Z3btiL
         8pnw==
X-Gm-Message-State: AOAM530H0I8Wov6OWI8XUq7/k5ntpITAThEalqB/lKnHhcQ5ssIXWCY2
        nwJfNvcxVK03d4zYwO5Uc/4=
X-Google-Smtp-Source: ABdhPJymSUXlaRjzXEzU2ngDriybhzR1Pzab6/cvJ6uKqjlNaxk3d/92EIH+NhH+um1mO4rml2NgOw==
X-Received: by 2002:a17:902:6103:b029:da:c46c:b3d6 with SMTP id t3-20020a1709026103b02900dac46cb3d6mr15400411plj.46.1607340696714;
        Mon, 07 Dec 2020 03:31:36 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:31:36 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC V2 00/37] Enhance memory utilization with DMEMFS
Date:   Mon,  7 Dec 2020 19:30:53 +0800
Message-Id: <cover.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

In current system each physical memory page is assocaited with
a page structure which is used to track the usage of this page.
But due to the memory usage rapidly growing in cloud environment,
we find the resource consuming for page structure storage becomes
more and more remarkable. So is it possible that we could reclaim
such memory and make it reusable?

This patchset introduces an idea about how to save the extra
memory through a new virtual filesystem -- dmemfs.

Dmemfs (Direct Memory filesystem) is device memory or reserved
memory based filesystem. This kind of memory is special as it
is not managed by kernel and most important it is without 'struct page'.
Therefore we can leverage the extra memory from the host system
to support more tenants in our cloud service.

As the belowing figure shows, we uses a kernel boot parameter 'dmem='
to reserve the system memory when the host system boots up, the
remaining system memory is still managed by system memory management
which is associated with "struct page", the reserved memory
will be managed by dmem and assigned to guest system, the details
can be checked in /Documentation/admin-guide/kernel-parameters.txt.

   +------------------+--------------------------------------+
   |  system memory   |     memory for guest system          | 
   +------------------+--------------------------------------+
    |                                   |
    v                                   |
struct page                             |
    |                                   |
    v                                   v
    system mem management             dmem  

And during the usage, the dmemfs will handle the memory request to
allocate and free the reserved memory on each NUMA node, the user 
space application could leverage the mmap interface to access the 
memory, and kernel module such as kvm and vfio would be able to pin
the memory thongh follow_pfn() and get_user_page() in different given
page size granularities.

          +-----------+  +-----------+
          |   QEMU    |  |  dpdk etc.|      user
          +-----+-----+  +-----------+
  +-----------|------\------------------------------+
  |           |       v                    kernel   |
  |           |     +-------+  +-------+            |
  |           |     |  KVM  |  | vfio  |            |
  |           |     +-------+  +-------+            |
  |           |         |          |                |
  |      +----v---------v----------v------+         |
  |      |                                |         |
  |      |             Dmemfs             |         |
  |      |                                |         |
  |      +--------------------------------+         |
  +-----------/-----------------------\-------------+
             /                         \
     +------v-----+                +----v-------+
     |   node 0   |                |   node 1   |
     +------------+                +------------+

Theoretically for each 4k physical page it can save 64 bytes if
we drop the 'struct page', so for guest memory with 320G it can
save about 5G physical memory totally.

Detailed usage of dmemfs is included in
/Documentation/filesystem/dmemfs.rst.

V1->V2:
* Rebase the code the kernel version 5.10.0-rc3.
* Introudce dregion->memmap for dmem to add _refcount for each
  dmem page.
* Enable record_steal_time for dmem before entering guest system.
* Adjust page walking for dmem.

Yulei Zhang (37):
  fs: introduce dmemfs module
  mm: support direct memory reservation
  dmem: implement dmem memory management
  dmem: let pat recognize dmem
  dmemfs: support mmap for dmemfs
  dmemfs: support truncating inode down
  dmem: trace core functions
  dmem: show some statistic in debugfs
  dmemfs: support remote access
  dmemfs: introduce max_alloc_try_dpages parameter
  mm: export mempolicy interfaces to serve dmem allocator
  dmem: introduce mempolicy support
  mm, dmem: introduce PFN_DMEM and pfn_t_dmem
  mm, dmem: differentiate dmem-pmd and thp-pmd
  mm: add pmd_special() check for pmd_trans_huge_lock()
  dmemfs: introduce ->split() to dmemfs_vm_ops
  mm, dmemfs: support unmap_page_range() for dmemfs pmd
  mm: follow_pmd_mask() for dmem huge pmd
  mm: gup_huge_pmd() for dmem huge pmd
  mm: support dmem huge pmd for vmf_insert_pfn_pmd()
  mm: support dmem huge pmd for follow_pfn()
  kvm, x86: Distinguish dmemfs page from mmio page
  kvm, x86: introduce VM_DMEM for syscall support usage
  dmemfs: support hugepage for dmemfs
  mm, x86, dmem: fix estimation of reserved page for vaddr_get_pfn()
  mm, dmem: introduce pud_special() for dmem huge pud support
  mm: add pud_special() check to support dmem huge pud
  mm, dmemfs: support huge_fault() for dmemfs
  mm: add follow_pte_pud() to support huge pud look up
  dmem: introduce dmem_bitmap_alloc() and dmem_bitmap_free()
  dmem: introduce mce handler
  mm, dmemfs: register and handle the dmem mce
  kvm, x86: enable record_steal_time for dmem
  dmem: add dmem unit tests
  mm, dmem: introduce dregion->memmap for dmem
  vfio: support dmempage refcount for vfio
  Add documentation for dmemfs

 Documentation/admin-guide/kernel-parameters.txt |   38 +
 Documentation/filesystems/dmemfs.rst            |   58 ++
 Documentation/filesystems/index.rst             |    1 +
 arch/x86/Kconfig                                |    1 +
 arch/x86/include/asm/pgtable.h                  |   32 +-
 arch/x86/include/asm/pgtable_types.h            |   13 +-
 arch/x86/kernel/setup.c                         |    3 +
 arch/x86/kvm/mmu/mmu.c                          |    1 +
 arch/x86/mm/pat/memtype.c                       |   21 +
 drivers/vfio/vfio_iommu_type1.c                 |   13 +-
 fs/Kconfig                                      |    1 +
 fs/Makefile                                     |    1 +
 fs/dmemfs/Kconfig                               |   16 +
 fs/dmemfs/Makefile                              |    8 +
 fs/dmemfs/inode.c                               | 1060 ++++++++++++++++++++
 fs/dmemfs/trace.h                               |   54 +
 fs/inode.c                                      |    6 +
 include/linux/dmem.h                            |   54 +
 include/linux/fs.h                              |    1 +
 include/linux/huge_mm.h                         |    5 +-
 include/linux/mempolicy.h                       |    3 +
 include/linux/mm.h                              |    9 +
 include/linux/pfn_t.h                           |   17 +-
 include/linux/pgtable.h                         |   22 +
 include/trace/events/dmem.h                     |   85 ++
 include/uapi/linux/magic.h                      |    1 +
 mm/Kconfig                                      |   19 +
 mm/Makefile                                     |    1 +
 mm/dmem.c                                       | 1196 +++++++++++++++++++++++
 mm/dmem_reserve.c                               |  303 ++++++
 mm/gup.c                                        |  101 +-
 mm/huge_memory.c                                |   19 +-
 mm/memory-failure.c                             |   70 +-
 mm/memory.c                                     |   74 +-
 mm/mempolicy.c                                  |    4 +-
 mm/mincore.c                                    |    8 +-
 mm/mprotect.c                                   |    7 +-
 mm/mremap.c                                     |    3 +
 mm/pagewalk.c                                   |    4 +-
 tools/testing/dmem/Kbuild                       |    1 +
 tools/testing/dmem/Makefile                     |   10 +
 tools/testing/dmem/dmem-test.c                  |  184 ++++
 virt/kvm/kvm_main.c                             |   13 +-
 43 files changed, 3483 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/filesystems/dmemfs.rst
 create mode 100644 fs/dmemfs/Kconfig
 create mode 100644 fs/dmemfs/Makefile
 create mode 100644 fs/dmemfs/inode.c
 create mode 100644 fs/dmemfs/trace.h
 create mode 100644 include/linux/dmem.h
 create mode 100644 include/trace/events/dmem.h
 create mode 100644 mm/dmem.c
 create mode 100644 mm/dmem_reserve.c
 create mode 100644 tools/testing/dmem/Kbuild
 create mode 100644 tools/testing/dmem/Makefile
 create mode 100644 tools/testing/dmem/dmem-test.c

-- 
1.8.3.1

