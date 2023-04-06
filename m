Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5226D9097
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjDFHkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjDFHkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:40:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8776A2;
        Thu,  6 Apr 2023 00:40:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A8BD66031BB;
        Thu,  6 Apr 2023 08:40:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680766829;
        bh=xNx+9IHlvk8t/2NOEspLFBuf3N8RXQcltUQ6ggMN/5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=SuLXPdtDWq4mfLEOJ5/xNEv3as6kHfJWaI8a6VRwIOlPoCtbr/tWSViRxZSclkSdI
         eeF16xGEmXNksaSpq3VqDMLu4yrJzdwAmHwykN2SKTEGXHPvfdzOfzLD8Wu0geeoxV
         M6NLvpNxTjJzdF2Zl2ckO9b68nfURUe7KdSo8nf4XsemEP/R5qKn+IOVx/xef2OtXx
         02g52fPKbLxGL15U4b+apWcP/OpbQ92zEWG+Tgsz+mdHBR+ZObnoavTmUDD2PSukKQ
         sytrlaf6VpYZmFKdtWJ2IfyNUJQXChfVPe/Q1b4UUMJ/mAuIBJW5d3sRdZTShBvagr
         YkhMUtU3rg35A==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v12 0/5] Implement IOCTL to get and optionally clear info about PTEs
Date:   Thu,  6 Apr 2023 12:40:00 +0500
Message-Id: <20230406074005.1784728-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

*Changes in v12*
- Update and other memory types to UFFD_FEATURE_WP_ASYNC
- Rebaase on top of next-20230406
- Review updates

*Changes in v11*
- Rebase on top of next-20230307
- Base patches on UFFD_FEATURE_WP_UNPOPULATED
- Do a lot of cosmetic changes and review updates
- Remove ENGAGE_WP + !GET operation as it can be performed with
  UFFDIO_WRITEPROTECT

*Changes in v10*
- Add specific condition to return error if hugetlb is used with wp
  async
- Move changes in tools/include/uapi/linux/fs.h to separate patch
- Add documentation

*Changes in v9:*
- Correct fault resolution for userfaultfd wp async
- Fix build warnings and errors which were happening on some configs
- Simplify pagemap ioctl's code

*Changes in v8:*
- Update uffd async wp implementation
- Improve PAGEMAP_IOCTL implementation

*Changes in v7:*
- Add uffd wp async
- Update the IOCTL to use uffd under the hood instead of soft-dirty
  flags

*Motivation*
The real motivation for adding PAGEMAP_SCAN IOCTL is to emulate Windows
GetWriteWatch() syscall [1]. The GetWriteWatch{} retrieves the addresses of
the pages that are written to in a region of virtual memory.

This syscall is used in Windows applications and games etc. This syscall is
being emulated in pretty slow manner in userspace. Our purpose is to
enhance the kernel such that we translate it efficiently in a better way.
Currently some out of tree hack patches are being used to efficiently
emulate it in some kernels. We intend to replace those with these patches.
So the whole gaming on Linux can effectively get benefit from this. It
means there would be tons of users of this code.

CRIU use case [2] was mentioned by Andrei and Danylo:
> Use cases for migrating sparse VMAs are binaries sanitized with ASAN,
> MSAN or TSAN [3]. All of these sanitizers produce sparse mappings of
> shadow memory [4]. Being able to migrate such binaries allows to highly
> reduce the amount of work needed to identify and fix post-migration
> crashes, which happen constantly.

Andrei's defines the following uses of this code:
* it is more granular and allows us to track changed pages more
  effectively. The current interface can clear dirty bits for the entire
  process only. In addition, reading info about pages is a separate
  operation. It means we must freeze the process to read information
  about all its pages, reset dirty bits, only then we can start dumping
  pages. The information about pages becomes more and more outdated,
  while we are processing pages. The new interface solves both these
  downsides. First, it allows us to read pte bits and clear the
  soft-dirty bit atomically. It means that CRIU will not need to freeze
  processes to pre-dump their memory. Second, it clears soft-dirty bits
  for a specified region of memory. It means CRIU will have actual info
  about pages to the moment of dumping them.
* The new interface has to be much faster because basic page filtering
  is happening in the kernel. With the old interface, we have to read
  pagemap for each page.

*Implementation Evolution (Short Summary)*
From the definition of GetWriteWatch(), we feel like kernel's soft-dirty
feature can be used under the hood with some additions like:
* reset soft-dirty flag for only a specific region of memory instead of
clearing the flag for the entire process
* get and clear soft-dirty flag for a specific region atomically

So we decided to use ioctl on pagemap file to read or/and reset soft-dirty
flag. But using soft-dirty flag, sometimes we get extra pages which weren't
even written. They had become soft-dirty because of VMA merging and
VM_SOFTDIRTY flag. This breaks the definition of GetWriteWatch(). We were
able to by-pass this short coming by ignoring VM_SOFTDIRTY until David
reported that mprotect etc messes up the soft-dirty flag while ignoring
VM_SOFTDIRTY [5]. This wasn't happening until [6] got introduced. We
discussed if we can revert these patches. But we could not reach to any
conclusion. So at this point, I made couple of tries to solve this whole
VM_SOFTDIRTY issue by correcting the soft-dirty implementation:
* [7] Correct the bug fixed wrongly back in 2014. It had potential to cause
regression. We left it behind.
* [8] Keep a list of soft-dirty part of a VMA across splits and merges. I
got the reply don't increase the size of the VMA by 8 bytes.

At this point, we left soft-dirty considering it is too much delicate and
userfaultfd [9] seemed like the only way forward. From there onward, we
have been basing soft-dirty emulation on userfaultfd wp feature where
kernel resolves the faults itself when WP_ASYNC feature is used. It was
straight forward to add WP_ASYNC feature in userfautlfd. Now we get only
those pages dirty or written-to which are really written in reality. (PS
There is another WP_UNPOPULATED userfautfd feature is required which is
needed to avoid pre-faulting memory before write-protecting [9].)

All the different masks were added on the request of CRIU devs to create
interface more generic and better.

[1] https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-getwritewatch
[2] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com
[3] https://github.com/google/sanitizers
[4] https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit
[5] https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com
[6] https://lore.kernel.org/all/20220725142048.30450-1-peterx@redhat.com/
[7] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
[8] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
[9] https://lore.kernel.org/all/20230306213925.617814-1-peterx@redhat.com
[10] https://lore.kernel.org/all/20230125144529.1630917-1-mdanylo@google.com

* Original Cover letter from v8*
Hello,

Note:
Soft-dirty pages and pages which have been written-to are synonyms. As
kernel already has soft-dirty feature inside which we have given up to
use, we are using written-to terminology while using UFFD async WP under
the hood.

This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
the info about page table entries. The following operations are
supported in this ioctl:
- Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
  file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
  (PAGE_IS_SWAPPED).
- Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
  pages have been written-to.
- Find pages which have been written-to and write protect the pages
  (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)

It is possible to find and clear soft-dirty pages entirely in userspace.
But it isn't efficient:
- The mprotect and SIGSEGV handler for bookkeeping
- The userfaultfd wp (synchronous) with the handler for bookkeeping

Some benchmarks can be seen here[1]. This series adds features that weren't
present earlier:
- There is no atomic get soft-dirty/Written-to status and clear present in
  the kernel.
- The pages which have been written-to can not be found in accurate way.
  (Kernel's soft-dirty PTE bit + sof_dirty VMA bit shows more soft-dirty
  pages than there actually are.)

Historically, soft-dirty PTE bit tracking has been used in the CRIU
project. The procfs interface is enough for finding the soft-dirty bit
status and clearing the soft-dirty bit of all the pages of a process.
We have the use case where we need to track the soft-dirty PTE bit for
only specific pages on-demand. We need this tracking and clear mechanism
of a region of memory while the process is running to emulate the
getWriteWatch() syscall of Windows.

*(Moved to using UFFD instead of soft-dirtyi feature to find pages which
have been written-to from v7 patch series)*:
Stop using the soft-dirty flags for finding which pages have been
written to. It is too delicate and wrong as it shows more soft-dirty
pages than the actual soft-dirty pages. There is no interest in
correcting it [2][3] as this is how the feature was written years ago.
It shouldn't be updated to changed behaviour. Peter Xu has suggested
using the async version of the UFFD WP [4] as it is based inherently
on the PTEs.

So in this patch series, I've added a new mode to the UFFD which is
asynchronous version of the write protect. When this variant of the
UFFD WP is used, the page faults are resolved automatically by the
kernel. The pages which have been written-to can be found by reading
pagemap file (!PM_UFFD_WP). This feature can be used successfully to
find which pages have been written to from the time the pages were
write protected. This works just like the soft-dirty flag without
showing any extra pages which aren't soft-dirty in reality.

The information related to pages if the page is file mapped, present and
swapped is required for the CRIU project [5][6]. The addition of the
required mask, any mask, excluded mask and return masks are also required
for the CRIU project [5].

The IOCTL returns the addresses of the pages which match the specific
masks. The page addresses are returned in struct page_region in a compact
form. The max_pages is needed to support a use case where user only wants
to get a specific number of pages. So there is no need to find all the
pages of interest in the range when max_pages is specified. The IOCTL
returns when the maximum number of the pages are found. The max_pages is
optional. If max_pages is specified, it must be equal or greater than the
vec_size. This restriction is needed to handle worse case when one
page_region only contains info of one page and it cannot be compacted.
This is needed to emulate the Windows getWriteWatch() syscall.

The patch series include the detailed selftest which can be used as an
example for the uffd async wp test and PAGEMAP_IOCTL. It shows the
interface usages as well.

[1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
[2] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
[3] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
[4] https://lore.kernel.org/all/Y6Hc2d+7eTKs7AiH@x1n
[5] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com/
[6] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com/

Regards,
Muhammad Usama Anjum

Muhammad Usama Anjum (4):
  fs/proc/task_mmu: Implement IOCTL to get and optionally clear info
    about PTEs
  tools headers UAPI: Update linux/fs.h with the kernel sources
  mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
  selftests: mm: add pagemap ioctl tests

Peter Xu (1):
  userfaultfd: UFFD_FEATURE_WP_ASYNC

 Documentation/admin-guide/mm/pagemap.rst     |   56 +
 Documentation/admin-guide/mm/userfaultfd.rst |   35 +
 fs/proc/task_mmu.c                           |  426 ++++++
 fs/userfaultfd.c                             |   26 +-
 include/linux/userfaultfd_k.h                |   29 +-
 include/uapi/linux/fs.h                      |   53 +
 include/uapi/linux/userfaultfd.h             |    9 +-
 mm/hugetlb.c                                 |   32 +-
 mm/memory.c                                  |   27 +-
 tools/include/uapi/linux/fs.h                |   53 +
 tools/testing/selftests/mm/.gitignore        |    1 +
 tools/testing/selftests/mm/Makefile          |    4 +-
 tools/testing/selftests/mm/config            |    1 +
 tools/testing/selftests/mm/pagemap_ioctl.c   | 1301 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh    |    4 +
 15 files changed, 2034 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pagemap_ioctl.c
 mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh

-- 
2.39.2

