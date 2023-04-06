Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2106D90A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjDFHla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjDFHlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:41:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F297EF1;
        Thu,  6 Apr 2023 00:41:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B3FE66031CB;
        Thu,  6 Apr 2023 08:40:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680766859;
        bh=VHJ3s/rDqou65z21qPz74d3WACjlrCHoe/eBuZI6JGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvBethjnSqLziHDGb5lsW7clVQOn8ym6wN8Ykia5gTWmyLYjUxnGEQsodqcFWL+nL
         LT/acVr12kRkaX71ZZ2vhqMX2beAZulOESNLUtvhn0CZzHjw1DkqW7p6n/t0+Bl2uf
         bezEYGX8mqyIlWZmmcaNWfSsJvIkuifCtL49PqGSt49Eh83d1uRgdXKa1rYLXt9uvG
         ZkvdolZMQmk6+8z74c7noGTFGgm8Ma/BGHU0u80QEm1DWav0PicHznNY3CFbtPq/nB
         vfCB9gwtk3JjcLNvOYSgG4bX1FQmzr+GP2o4cAk8Lobsk39kBT0Z0vIEWmgahGaxXP
         oiCE19+8VKvCg==
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
Subject: [PATCH v12 4/5] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
Date:   Thu,  6 Apr 2023 12:40:04 +0500
Message-Id: <20230406074005.1784728-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406074005.1784728-1-usama.anjum@collabora.com>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some explanation and method to use write-protection and written-to
on memory range.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v11:
- Add more documentation
---
 Documentation/admin-guide/mm/pagemap.rst | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index c8f380271cad..a3e08f15b433 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -227,3 +227,59 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
 always 12 at most architectures). Since Linux 3.11 their meaning changes
 after first clear of soft-dirty bits. Since Linux 4.2 they are used for
 flags unconditionally.
+
+Pagemap Scan IOCTL
+==================
+
+The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get or optionally
+clear the info about page table entries. The following operations are supported
+in this IOCTL:
+- Get the information if the pages have been written-to (``PAGE_IS_WRITTEN``),
+  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``) or swapped
+  (``PAGE_IS_SWAPPED``).
+- Find pages which have been written-to and write protect the pages atomically
+  (atomic ``PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE``)
+
+The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
+ 1. The size of the ``struct pm_scan_arg`` must be specified in the ``size``
+    field. This field will be helpful in recognizing the structure if extensions
+    are done later.
+ 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_OP_GET``
+    and ``PM_SCAN_OP_WP`` are the only added flag at this time.
+ 3. The range is specified through ``start`` and ``len``.
+ 4. The output buffer of ``struct page_region`` array and size is specified in
+    ``vec`` and ``vec_len``.
+ 5. The optional maximum requested pages are specified in the ``max_pages``.
+ 6. The masks are specified in ``required_mask``, ``anyof_mask``,
+    ``excluded_ mask`` and ``return_mask``.
+    1.  To find if ``PAGE_IS_WRITTEN`` flag is set for pages which have
+        ``PAGE_IS_FILE`` set and ``PAGE_IS_SWAPPED`` un-set, ``required_mask``
+        is set to ``PAGE_IS_FILE``, ``exclude_mask`` is set to
+        ``PAGE_IS_SWAPPED`` and ``return_mask`` is set to ``PAGE_IS_WRITTEN``.
+        The output buffer in ``vec`` and length must be specified in ``vec_len``.
+    2. To find pages which have either ``PAGE_IS_FILE`` or ``PAGE_IS_SWAPPED``
+       set, ``anyof_masks`` is set to  ``PAGE_IS_FILE | PAGE_IS_SWAPPED``.
+    3. To find written pages and engage write protect, ``PAGE_IS_WRITTEN`` is
+       specified in ``required_mask`` and ``return_mask``. In addition to
+       specifying the output buffer in ``vec`` and length in ``vec_len``, the
+       ``PAGEMAP_WP_ENGAGE`` is specified in ``flags`` to perform write protect
+       on the range as well.
+
+The ``PAGE_IS_WRITTEN`` flag can be considered as the better and correct
+alternative of soft-dirty flag. It doesn't get affected by household chores (VMA
+merging) of the kernel and hence the user can find the true soft-dirty pages
+only. This IOCTL adds the atomic way to find which pages have been written and
+write protect those pages again. This kind of operation is needed to efficiently
+find out which pages have changed in the memory.
+
+To get information about which pages have been written-to or optionally write
+protect the pages, following must be performed first in order:
+ 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
+ 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` features
+    are set by ``UFFDIO_API`` IOCTL.
+ 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
+    through ``UFFDIO_REGISTER`` IOCTL.
+ 4. Then the any part of the registered memory or the whole memory region must
+    be write protected using the ``UFFDIO_WRITEPROTECT`` IOCTL.
+ 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages which
+    have been written-to or optionally write protect the pages as well.
-- 
2.39.2

