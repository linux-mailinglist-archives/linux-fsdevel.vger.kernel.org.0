Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39A286FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJHHxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgJHHxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:53:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A4C061755;
        Thu,  8 Oct 2020 00:53:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so3336716pfj.1;
        Thu, 08 Oct 2020 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d9Dv0Tfy43cFJ7TEtUwhF40y5j76mtwOI58O0wIQ3mY=;
        b=j9FgA9ntpuGiH/AkBGwjno0+hkJGwYclgWL2xqXIf9cCf1ZIX8U+L5OM8H1k8djh2Z
         6BRQerPZRYLlGc7b50ja1yAb7+V+4Wg9SRort63PeQCqO5ALwvWHdRa0iDpZDk5dFR4Q
         PjRp47X3uW1J+5lniQYPhCl71chfxNwqgd8pe0FFoAF013HuFekkHC1ZhU3zk7WnPe/P
         Zbu61jFKESMLMy6BFAb4MDVTLQzH8yaSi8I6NzhGJOeXuzRJ8qwE3ITQsGluiZ/N7r4R
         WtfrGmkNA0ZFJ/FA5fbMMy/EGyDZVUlLaeM1dmev0rYd/HH8WFYdSbc4S5dstoEb9C75
         E4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d9Dv0Tfy43cFJ7TEtUwhF40y5j76mtwOI58O0wIQ3mY=;
        b=FPzXWwaXvvR3GaD6vSVdsZ3rY0xofHFUdp8wu6XyXMg5kDtvvlM4+/CTqW1KykaY1K
         zdRTvjQxOegB8u/xkosbhOX6XLxG0FKvVCwsO93ZS5ufp2CQyJExI6v9nbVQlT8EWQfp
         3GjVK7TBs/oE5jE9xMMJSpr8d7XU/IB1ht5UFq9KoiXLsN93Twe0w9zxCqzcckOXJYdC
         juqE6aDG68om+MxO+aXww5iNbli5048bs6kmZ+tONyMAOKppfxeX+GEb/XB5DgiyEiRw
         3qDJ0x93a0AKQaz46FHfnFHE92B67SszTjy4BA1qc5XSkkbGYNjFwl8fkyzLM8pf8ZBk
         i8BQ==
X-Gm-Message-State: AOAM533UQTTbiYW+9WLNYJhJVMePmhR11tsStx8liATwn1eShJNUNtuZ
        oSg+eW0saOZntXmHHtlKxq0GGN7NEkTdUw==
X-Google-Smtp-Source: ABdhPJxzy7Nu+wYP7Q9/hg8EJQIq/pBZpxrRm0c+gpQS36erHTH6XjhwjrPcCRjq6JMsYcj9fOP8CA==
X-Received: by 2002:aa7:9e4a:0:b029:152:54d1:bffa with SMTP id z10-20020aa79e4a0000b029015254d1bffamr6282707pfq.6.1602143597294;
        Thu, 08 Oct 2020 00:53:17 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:53:16 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [PATCH 00/35] Enhance memory utilization with DMEMFS
Date:   Thu,  8 Oct 2020 15:53:50 +0800
Message-Id: <cover.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

In current system each physical memory page is assocaited with
a page structure which is used to track the usage of this page.
But due to the memory usage rapidly growing in cloud environment,
we find the resource consuming for page structure storage becomes
highly remarkable. So is it an expense that we could spare?

This patchset introduces an idea about how to save the extra
memory through a new virtual filesystem -- dmemfs.

Dmemfs (Direct Memory filesystem) is device memory or reserved
memory based filesystem. This kind of memory is special as it
is not managed by kernel and most important it is without 'struct page'.
Therefore we can leverage the extra memory from the host system
to support more tenants in our cloud service.

We uses a kernel boot parameter 'dmem=' to reserve the system
memory when the host system boots up, the details can be checked
in /Documentation/admin-guide/kernel-parameters.txt. 

Theoretically for each 4k physical page it can save 64 bytes if
we drop the 'struct page', so for guest memory with 320G it can
save about 5G physical memory totally. 

Detailed usage of dmemfs is included in
/Documentation/filesystem/dmemfs.rst.

TODO:
1. we temporary disable the record_steal_time() before entering
guest, will enable that after solve the conflict.
2. working on systemcall such as mincore, will update the status
and patches soon. 

Yulei Zhang (35):
  fs: introduce dmemfs module
  mm: support direct memory reservation
  dmem: implement dmem memory management
  dmem: let pat recognize dmem
  dmemfs: support mmap
  dmemfs: support truncating inode down
  dmem: trace core functions
  dmem: show some statistic in debugfs
  dmemfs: support remote access
  dmemfs: introduce max_alloc_try_dpages parameter
  mm: export mempolicy interfaces to serve dmem allocator
  dmem: introduce mempolicy support
  mm, dmem: introduce PFN_DMEM and pfn_t_dmem
  mm, dmem: dmem-pmd vs thp-pmd
  mm: add pmd_special() check for pmd_trans_huge_lock()
  dmemfs: introduce ->split() to dmemfs_vm_ops
  mm, dmemfs: support unmap_page_range() for dmemfs pmd
  mm: follow_pmd_mask() for dmem huge pmd
  mm: gup_huge_pmd() for dmem huge pmd
  mm: support dmem huge pmd for vmf_insert_pfn_pmd()
  mm: support dmem huge pmd for follow_pfn()
  kvm, x86: Distinguish dmemfs page from mmio page
  kvm, x86: introduce VM_DMEM
  dmemfs: support hugepage for dmemfs
  mm, x86, dmem: fix estimation of reserved page for vaddr_get_pfn()
  mm, dmem: introduce pud_special()
  mm: add pud_special() to support dmem huge pud
  mm, dmemfs: support huge_fault() for dmemfs
  mm: add follow_pte_pud()
  dmem: introduce dmem_bitmap_alloc() and dmem_bitmap_free()
  dmem: introduce mce handler
  mm, dmemfs: register and handle the dmem mce
  kvm, x86: temporary disable record_steal_time for dmem
  dmem: add dmem unit tests
  Add documentation for dmemfs

 .../admin-guide/kernel-parameters.txt         |   38 +
 Documentation/filesystems/dmemfs.rst          |   59 +
 arch/x86/Kconfig                              |    1 +
 arch/x86/include/asm/pgtable.h                |   32 +-
 arch/x86/include/asm/pgtable_types.h          |   13 +-
 arch/x86/kernel/setup.c                       |    3 +
 arch/x86/kvm/mmu/mmu.c                        |    5 +-
 arch/x86/kvm/x86.c                            |    2 +
 arch/x86/mm/pat/memtype.c                     |   21 +
 drivers/vfio/vfio_iommu_type1.c               |    4 +
 fs/Kconfig                                    |    1 +
 fs/Makefile                                   |    1 +
 fs/dmemfs/Kconfig                             |   16 +
 fs/dmemfs/Makefile                            |    8 +
 fs/dmemfs/inode.c                             | 1063 ++++++++++++++++
 fs/dmemfs/trace.h                             |   54 +
 fs/inode.c                                    |    6 +
 include/linux/dmem.h                          |   49 +
 include/linux/fs.h                            |    1 +
 include/linux/huge_mm.h                       |    5 +-
 include/linux/mempolicy.h                     |    3 +
 include/linux/mm.h                            |    9 +
 include/linux/pfn_t.h                         |   17 +-
 include/linux/pgtable.h                       |   22 +
 include/trace/events/dmem.h                   |   85 ++
 include/uapi/linux/magic.h                    |    1 +
 mm/Kconfig                                    |   21 +
 mm/Makefile                                   |    1 +
 mm/dmem.c                                     | 1075 +++++++++++++++++
 mm/dmem_reserve.c                             |  303 +++++
 mm/gup.c                                      |   94 +-
 mm/huge_memory.c                              |   19 +-
 mm/memory-failure.c                           |   69 +-
 mm/memory.c                                   |   74 +-
 mm/mempolicy.c                                |    4 +-
 mm/mprotect.c                                 |    7 +-
 mm/mremap.c                                   |    3 +
 tools/testing/dmem/Kbuild                     |    1 +
 tools/testing/dmem/Makefile                   |   10 +
 tools/testing/dmem/dmem-test.c                |  184 +++
 40 files changed, 3336 insertions(+), 48 deletions(-)
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
2.28.0

