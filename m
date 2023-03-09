Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A036B260C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCIOA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCIN76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:59:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB78DD369;
        Thu,  9 Mar 2023 05:57:38 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 315DB660302F;
        Thu,  9 Mar 2023 13:57:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370256;
        bh=UaUIMl6MjswHfwBbA5lFzdwWz//seTzFcyEUoT9+TRI=;
        h=From:To:Cc:Subject:Date:From;
        b=YsCI1ry3x1PRroOtS4+zcq353ETgtVQJ6lRBij0S6jyvS+SiEKQk+oRF8OPNvbChN
         PQg8zVJLaAcD01quMKibipn7OcPbRk3NX/CzRVhJD8I3EufhOmJ9WDPYhS0A+ddVQK
         VVxlDDaPJQPisl646RMtMDwS3MRcXDqV9YGue8I1RTCzIj3KHkGHhcsB1DKoXaubra
         PSM3Kyh9cD65rx9nBWftM6hIIHmc+/IDA8soeUsEdrsxVqWj5tuNPYSOP+uWA+RDBM
         SJ7l3UT7Fe4u8gZFwhPm5tX7tmokU5GzFRf00UrWW729EWJQ0MYnV7drctiohBuxfe
         FAOQK2OJxmoPQ==
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
Subject: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info about PTEs
Date:   Thu,  9 Mar 2023 18:57:11 +0500
Message-Id: <20230309135718.1490461-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are based on next-20230307 and UFFD_FEATURE_WP_UNPOPULATED
patches from Peter.

*Changes in v11*
- Rebase on top of next-20230307
- Base patches on UFFD_FEATURE_WP_UNPOPULATED (https://lore.kernel.org/all/20230306213925.617814-1-peterx@redhat.com)
- Do a lot of cosmetic changes and review updates
- Remove ENGAGE_WP + ! GET operation as it can be performed with UFFDIO_WRITEPROTECT

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

Muhammad Usama Anjum (7):
  userfaultfd: Add UFFD WP Async support
  userfaultfd: Define dummy uffd_wp_range()
  userfaultfd: update documentation to describe UFFD_FEATURE_WP_ASYNC
  fs/proc/task_mmu: Implement IOCTL to get and optionally clear info
    about PTEs
  tools headers UAPI: Update linux/fs.h with the kernel sources
  mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
  selftests: mm: add pagemap ioctl tests

 Documentation/admin-guide/mm/pagemap.rst     |  56 ++
 Documentation/admin-guide/mm/userfaultfd.rst |  21 +
 fs/proc/task_mmu.c                           | 366 ++++++++
 fs/userfaultfd.c                             |  25 +-
 include/linux/userfaultfd_k.h                |  14 +
 include/uapi/linux/fs.h                      |  53 ++
 include/uapi/linux/userfaultfd.h             |  11 +-
 mm/memory.c                                  |  27 +-
 tools/include/uapi/linux/fs.h                |  53 ++
 tools/testing/selftests/mm/.gitignore        |   1 +
 tools/testing/selftests/mm/Makefile          |   4 +-
 tools/testing/selftests/mm/config            |   1 +
 tools/testing/selftests/mm/pagemap_ioctl.c   | 920 +++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh    |   4 +
 14 files changed, 1549 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pagemap_ioctl.c
 mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh

-- 
2.39.2

