Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0047796DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjHKSKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjHKSJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:09:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986C3599;
        Fri, 11 Aug 2023 11:09:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFD326607247;
        Fri, 11 Aug 2023 19:09:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691777368;
        bh=0a9Qetmbdu8vTo4HrABv1kj4hJIotAEkHC4f+K2lkgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxV46+H2eWNz06OU6ePXv2VPsjQadG5+BzyZnBaFQMJo8N35Ja6LW7AxlbOrbUeCJ
         lSGbiDh8Q3y1RGd9YfvkEWaKJnrS6hSa31jCHYsQ6uT/irfp7/INxpUspycQX6H2nv
         9ED+FBBSXGwY9Io0VHG3Diw998eTWqE/AgBxyp/NQ57oALcEJM1K0ewu7YWLIHeB6T
         pbdQ1Mce7WY3U/Ag0juiQzOuTJ7ZKBch0leAQMTtl9AvMS3cvSbk8Q3zgEenGKN8W6
         9mwrsfMe8q76qBe2558lYF4FgmcJRPIlg3+K2lmMf+xtpQOfVlmMa0ALyXeTrkPKJd
         64JsquZEC+Hcg==
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
Subject: [PATCH v29 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
Date:   Fri, 11 Aug 2023 23:08:41 +0500
Message-Id: <20230811180842.3141781-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811180842.3141781-1-usama.anjum@collabora.com>
References: <20230811180842.3141781-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some explanation and method to use write-protection and written-to
on memory range.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v29:
- Revamp the documentation and make it better

Changes in v26:
- Update documentation according to latest revision

Changes in v21:
- Update according to changed interface

Changes in v20:
- Add new flag in documentation

Changes in v19:
- Improved documentatiom with punctuation marks

Changes in v16:
- Update the documentation

Changes in v11:
- Add more documentation
---
 Documentation/admin-guide/mm/pagemap.rst | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index c8f380271cad8..b5ccdad6103ed 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -227,3 +227,92 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
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
+
+- Scan the address range and get the memory ranges matching the provided criteria.
+  This is performed by default when the output buffer is specified.
+- Write-protect the pages. The ``PM_SCAN_WP_MATCHING`` is used to write-protect
+  the pages of interest. The ``PM_SCAN_CHECK_WPASYNC`` aborts the operation if
+  non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING`` can be
+  used with or without ``PM_SCAN_CHECK_WPASYNC``.
+- Both of those operations can be combined into one atomic operation where we can
+  get and write protect the pages as well.
+
+Following flags about pages are currently supported:
+
+- ``PAGE_IS_WPALLOWED`` - Page has async-write-protection enabled
+- ``PAGE_IS_WRITTEN`` - Page has been written to from the time it was write protected
+- ``PAGE_IS_FILE`` - Page is file backed
+- ``PAGE_IS_PRESENT`` - Page is present in the memory
+- ``PAGE_IS_SWAPPED`` - Page is in swapped
+- ``PAGE_IS_PFNZERO`` - Page has zero PFN
+- ``PAGE_IS_HUGE`` - Page is THP or Hugetlb backed
+
+The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
+
+ 1. The size of the ``struct pm_scan_arg`` must be specified in the ``size``
+    field. This field will be helpful in recognizing the structure if extensions
+    are done later.
+ 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_WP_MATCHING``
+    and ``PM_SCAN_CHECK_WPASYNC`` are the only added flags at this time. The get
+    operation is optionally performed depending upon if the output buffer is
+    provided or not.
+ 3. The range is specified through ``start`` and ``end``.
+ 4. The walk can abort before visiting the complete range such as the user buffer
+    can get full etc. The walk ending address is specified in``end_walk``.
+ 5. The output buffer of ``struct page_region`` array and size is specified in
+    ``vec`` and ``vec_len``.
+ 6. The optional maximum requested pages are specified in the ``max_pages``.
+ 7. The masks are specified in ``category_mask``, ``category_anyof_mask``,
+    ``category_inverted`` and ``return_mask``.
+
+Find pages which have been written and WP them as well::
+
+   struct pm_scan_arg arg = {
+   .size = sizeof(arg),
+   .flags = PM_SCAN_CHECK_WPASYNC | PM_SCAN_CHECK_WPASYNC,
+   ..
+   .category_mask = PAGE_IS_WRITTEN,
+   .return_mask = PAGE_IS_WRITTEN,
+   };
+
+Find pages which have been written, are file backed, not swapped and either
+present or huge::
+
+   struct pm_scan_arg arg = {
+   .size = sizeof(arg),
+   .flags = 0,
+   ..
+   .category_mask = PAGE_IS_WRITTEN | PAGE_IS_SWAPPED,
+   .category_inverted = PAGE_IS_SWAPPED,
+   .category_anyof_mask = PAGE_IS_PRESENT | PAGE_IS_HUGE,
+   .return_mask = PAGE_IS_WRITTEN | PAGE_IS_SWAPPED |
+                  PAGE_IS_PRESENT | PAGE_IS_HUGE,
+   };
+
+The ``PAGE_IS_WRITTEN`` flag can be considered as a better-performing alternative
+of soft-dirty flag. It doesn't get affected by VMA merging of the kernel and hence
+the user can find the true soft-dirty pages in case of normal pages. (There may
+still be extra dirty pages reported for THP or Hugetlb pages.)
+
+"PAGE_IS_WRITTEN" category is used with uffd write protect-enabled ranges to
+implement memory dirty tracking in userspace:
+
+ 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
+ 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` features
+    are set by ``UFFDIO_API`` IOCTL.
+ 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
+    through ``UFFDIO_REGISTER`` IOCTL.
+ 4. Then any part of the registered memory or the whole memory region must
+    be write protected using ``PAGEMAP_SCAN`` IOCTL with flag ``PM_SCAN_WP_MATCHING``
+    or the ``UFFDIO_WRITEPROTECT`` IOCTL can be used. Both of these perform the
+    same operation. The former is better in terms of performance.
+ 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages which
+    have been written to since they were last marked and/or optionally write protect
+    the pages as well.
-- 
2.40.1

