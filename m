Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3751C7EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgEGAn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:43:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgEGAn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:43:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bebL064511;
        Thu, 7 May 2020 00:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=OqOasKZhWNUGzHjFt756OOV8Lh4Rb+axACJQMwPahRQ=;
 b=Y8/5Do/EyE7CnDd9nxZ8izcE3LvQGqQrXyszNQqUFmhCtJhg9/LBr2kvtbBcE855y9V+
 +TjIWOEZfpceOfDXlz0QvCTUDpZ+Uw8N38wnxMkuGEr5cSMtyfUVdqgvHq1xDP3esaa1
 86X8DBla7GVbCGkfHt34eFFw7kmq//G5NUs4FZMEiBjugqAo3ApKVLJ6+eY01F9kK26/
 nORstbvdCg3fhZnH7fIlIkxxE4TtRPf61mAzSyoOoq4zHZhUdoW4dQN9QTySecx+6eMU
 fahTeSTWWcAabQo56Pn3y+O9Yx3rd6s5dK69F0TNQhltF63Ix6NUWyU3CwbGxyq+wbwX Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09rdf5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470b2Ou171067;
        Thu, 7 May 2020 00:42:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7p2khg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470gKR2019606;
        Thu, 7 May 2020 00:42:20 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:19 -0700
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [RFC 00/43] PKRAM: Preserved-over-Kexec RAM
Date:   Wed,  6 May 2020 17:41:26 -0700
Message-Id: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset implements preserved-over-kexec memory storage or PKRAM as a
method for saving memory pages of the currently executing kernel so that
they may be restored after kexec into a new kernel. The patches are adapted
from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
introduce the PKRAM kernel API and implement its use within tmpfs, allowing
tmpfs files to be preserved across kexec.

One use case for PKRAM is preserving guest memory across kexec boot in
support of VMM Fast Restart[2]. VMM Fast Restart currently uses DRAM-as-PMEM
DAX memory for storing guest memory, but PKRAM provides a more flexible way
of storing guest memory in that the amount of memory used does not have to
be a fixed size created a priori. Another use case is for databases to
preserve their block caches in shared memory across reboot.

-- Usage --

 1) Mount tmpfs with 'pkram=NAME' option.

    NAME is an arbitrary string specifying a preserved memory node.
    Different tmpfs trees may be saved to PKRAM if different names are
    passed.

    # mkdir -p /mnt
    # mount -t tmpfs -o pkram=mytmpfs none /mnt

 2) Populate a file under /mnt

    # head -c 2G /dev/urandom > /mnt/testfile
    # md5sum /mnt/testfile
    e281e2f019ac3bfa3bdb28aa08c4beb3  /mnt/testfile

 3) Remount tmpfs to preserve files.

    # mount -o remount,preserve,ro /mnt

 4) Load the new kernel image.

    Pass the PKRAM super block pfn via 'pkram' boot option. The pfn is
    exported via the sysfs file /sys/kernel/pkram.

    # kexec -s -l /boot/vmlinuz-$kernel --initrd=/boot/initramfs-$kernel.img \
            --append="$(cat /proc/cmdline|sed -e 's/pkram=[^ ]*//g') pkram=$(cat /sys/kernel/pkram)"

 5) Boot to the new kernel.

    # systemctl kexec

 6) Mount tmpfs with 'pkram=NAME' option.

    It should find the PKRAM node with the tmpfs tree saved on previous
    unmount and restore it.

    # mount -t tmpfs -o pkram=mytmpfs none /mnt

 7) Use the restored file under /mnt

    # md5sum /mnt/testfile
    e281e2f019ac3bfa3bdb28aa08c4beb3  /mnt/testfile


 -- Implementation details --

 * When a tmpfs filesystem is mounted the first time with the 'pkram=NAME'
   option, a shmem_pkram_info is allocated to record NAME. The shmem_pkram_info
   and whether the filesystem is in the preserved state are tracked by
   shmem_sb_info.

 * A PKRAM-enabled tmpfs filesystem is saved to PKRAM on remount when the
  'preserve' mount option is specified and the filesystem is read-only.

 * Saving a file to PKRAM is done by walking the pages of the file and
   building a list of the pages and attributes needed to restore them later.
   The pages containing this metadata as well as the target file pages have
   their refcount incremented to prevent them from being freed even after
   the last user puts the pages (i.e. the filesystem is unmounted).

 * To aid in quickly finding contiguous ranges of memory containing all
   or no preserved pages a simplified physical mapping pagetable is populated
   with pages as they are preserved.

 * If a page to be preserved is found to be in range of memory that was
   previously reserved during early boot or in range of memory where the
   kernel will be loaded to on kexec, the page will be copied to a page
   outside of those ranges and the new page will be preserved. A compound
   page will be copied to and preserved as individual base pages.

 * A single page is allocated for the PKRAM super block. For the next kernel
   kexec boot to find preserved memory metadata, the pfn of the PKRAM super
   block, which is exported via /sys/kernel/pkram, is passed in the 'pkram'
   boot option.

 * In the newly booted kernel, PKRAM adds all preserved pages to the memblock
   reserve list during early boot so that they will not be recycled.

 * Since kexec may load the new kernel code to any memory region, it could
   destroy preserved memory. When the kernel selects the memory region
   (kexec_file_load syscall), kexec will avoid preserved pages.  When the
   user selects the kexec memory region to use (kexec_load syscall) , kexec
   load will fail if there is conflict with preserved pages. Pages preserved
   after a kexec kernel is loaded will be relocated if they conflict with
   the selected memory region.

The current implementation has some restrictions:

 * Only regular tmpfs files without multiple hard links can be preserved.
   Save to PKRAM will abort and log an error if a directory or other file
   type is encountered.

 * Pages for PKRAM-enabled files are prevented from swapping out to avoid
   the performance penalty of swapping in and the possibility of insufficient
   memory.


-- Patches --

The patches are broken down into the following groups:

Patches 1-21 implement the API and supporting functionality.

Patches 22-26 implement the use of PKRAM within tmpfs

The remaining patches implement optimizations to the initialization of
preserved pages and to the preservation and restoration of shmem pages.

Here is a comparison of performance with and without these patches when
saving and loading a 100G file:

  Save a 100G file:

              | No optimizations | Optimized (16 cpus) |
  ------------------------------------------------------
  huge=none   |     2529ms       |       311ms         |
  ------------------------------------------------------
  huge=always |       44ms       |        13ms         |


  Load a 100G file:

              | No optimizations | Optimized (16 cpus) |
  ------------------------------------------------------
  huge=none   |     9242ms       |       518ms         |
  ------------------------------------------------------
  huge=always |      811ms       |       101ms         |


Patches 27-31 Defer initialization of page structs for preserved pages

Patches 32-34 Implement multi-threading of shmem page preservation and
restoration.

Patches 35-37 Implement an API for inserting shmem pages in bulk

Patches 38-39: Reduce contention on the LRU lock by staging and adding pages
in bulk to the LRU

Patches 40-43: Reduce contention on the pagecache xarray lock by inserting
pages in bulk in certain cases

[1] https://lkml.org/lkml/2013/7/1/211

[2] https://www.youtube.com/watch?v=pBsHnf93tcQ
    https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf

Anthony Yznaga (43):
  mm: add PKRAM API stubs and Kconfig
  mm: PKRAM: implement node load and save functions
  mm: PKRAM: implement object load and save functions
  mm: PKRAM: implement page stream operations
  mm: PKRAM: support preserving transparent hugepages
  mm: PKRAM: implement byte stream operations
  mm: PKRAM: link nodes by pfn before reboot
  mm: PKRAM: introduce super block
  PKRAM: build a physical mapping pagetable of pages to be preserved
  PKRAM: add code for walking the preserved pages pagetable
  PKRAM: pass the preserved pages pagetable to the next kernel
  mm: PKRAM: reserve preserved memory at boot
  mm: PKRAM: free preserved pages pagetable
  mm: memblock: PKRAM: prevent memblock resize from clobbering preserved
    pages
  PKRAM: provide a way to ban pages from use by PKRAM
  kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
  PKRAM: provide a way to check if a memory range has preserved pages
  kexec: PKRAM: avoid clobbering already preserved pages
  mm: PKRAM: allow preserved memory to be freed from userspace
  PKRAM: disable feature when running the kdump kernel
  x86/KASLR: PKRAM: support physical kaslr
  mm: shmem: introduce shmem_insert_page
  mm: shmem: enable saving to PKRAM
  mm: shmem: prevent swapping of PKRAM-enabled tmpfs pages
  mm: shmem: specify the mm to use when inserting pages
  mm: shmem: when inserting, handle pages already charged to a memcg
  x86/mm/numa: add numa_isolate_memblocks()
  PKRAM: ensure memblocks with preserved pages init'd for numa
  memblock: PKRAM: mark memblocks that contain preserved pages
  memblock: add for_each_reserved_mem_range()
  memblock, mm: defer initialization of preserved pages
  shmem: PKRAM: preserve shmem files a chunk at a time
  PKRAM: atomically add and remove link pages
  shmem: PKRAM: multithread preserving and restoring shmem pages
  shmem: introduce shmem_insert_pages()
  PKRAM: add support for loading pages in bulk
  shmem: PKRAM: enable bulk loading of preserved pages into shmem
  mm: implement splicing a list of pages to the LRU
  shmem: optimize adding pages to the LRU in shmem_insert_pages()
  shmem: initial support for adding multiple pages to pagecache
  XArray: add xas_export_node() and xas_import_node()
  shmem: reduce time holding xa_lock when inserting pages
  PKRAM: improve index alignment of pkram_link entries

 Documentation/core-api/xarray.rst |    8 +
 arch/x86/boot/compressed/Makefile |    3 +
 arch/x86/boot/compressed/kaslr.c  |   67 +-
 arch/x86/boot/compressed/misc.h   |   19 +
 arch/x86/boot/compressed/pkram.c  |  252 ++++++
 arch/x86/include/asm/numa.h       |    4 +
 arch/x86/kernel/setup.c           |    3 +
 arch/x86/mm/init_64.c             |    2 +
 arch/x86/mm/numa.c                |   32 +-
 include/linux/memblock.h          |   17 +
 include/linux/mm.h                |    2 +-
 include/linux/pkram.h             |   98 +++
 include/linux/shmem_fs.h          |   28 +
 include/linux/swap.h              |   11 +
 include/linux/xarray.h            |    2 +
 kernel/kexec.c                    |    9 +
 kernel/kexec_core.c               |    3 +
 kernel/kexec_file.c               |   15 +
 lib/test_xarray.c                 |   45 +
 lib/xarray.c                      |  100 +++
 mm/Kconfig                        |    9 +
 mm/Makefile                       |    1 +
 mm/memblock.c                     |   84 +-
 mm/page_alloc.c                   |   52 +-
 mm/pkram.c                        | 1729 +++++++++++++++++++++++++++++++++++++
 mm/pkram_pagetable.c              |  251 ++++++
 mm/shmem.c                        |  492 +++++++++++
 mm/shmem_pkram.c                  |  512 +++++++++++
 mm/swap.c                         |  101 +++
 29 files changed, 3903 insertions(+), 48 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c
 create mode 100644 mm/pkram_pagetable.c
 create mode 100644 mm/shmem_pkram.c

-- 
2.13.3

