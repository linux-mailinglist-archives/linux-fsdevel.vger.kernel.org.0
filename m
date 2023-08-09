Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C597752C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 08:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHIGRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 02:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjHIGRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:17:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C21FD6;
        Tue,  8 Aug 2023 23:16:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56D1F66071AC;
        Wed,  9 Aug 2023 07:16:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691561806;
        bh=Mo1XH1UBRenLTz5BwK9wfXpLgt7ICRwepxhynxV74M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6Taw50lgoVGvlK3peNoytHwfr1OSKRL8n+NQXDiql0Hpr2eLngLQZ8FTwHTYLZxh
         rVN2y9n1p3sZnf2SlZJ8SwfLOvU10PR0a4maXtQNQnwEFQfFDdonnaRRmZaobDzo3j
         p6teanOBdwlQezTBrap9hxBXKGKetGLUSH0WbttWM2/HB2gRpfhY/GQWVU7eNrUzVA
         ssOMRxdp9K6ESacqejBh2poBtvZ2E3VejCyjvxz1X/rmDDVuIO7jzAt/fcLeo8Aqog
         f7Fgs3qHc7rwRsw6C6gps7SET13O3zbtu4szSpbFECehC541w9qDh6ckQKg/G33CaQ
         FlM4zC0k9dPTw==
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
Subject: [PATCH v28 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
Date:   Wed,  9 Aug 2023 11:16:02 +0500
Message-Id: <20230809061603.1969154-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809061603.1969154-1-usama.anjum@collabora.com>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
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
 Documentation/admin-guide/mm/pagemap.rst | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index c8f380271cad8..ea18e4575902a 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -227,3 +227,67 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
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
+- Get the information if the pages have Async Write-Protection enabled
+  (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), file mapped
+  (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped (``PAGE_IS_SWAPPED``)
+  or page has pfn zero (``PAGE_IS_PFNZERO``).
+- Find pages which have been written to and/or write protect
+  (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages atomically.
+  The (``PM_SCAN_WP_MATCHING``) is used to WP the matched pages. The
+  (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if non-Async-Write-Protected
+  pages are found.
+
+The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
+ 1. The size of the ``struct pm_scan_arg`` must be specified in the ``size``
+    field. This field will be helpful in recognizing the structure if extensions
+    are done later.
+ 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_WP_MATCHING``
+    and ``PM_SCAN_CHECK_WPASYNC`` are the only added flags at this time. The get
+    operation is optionally performed depending upon if the output buffer is
+    provided or not.
+ 3. The range is specified through ``start`` and ``end``.
+ 4. The output buffer of ``struct page_region`` array and size is specified in
+    ``vec`` and ``vec_len``.
+ 5. The optional maximum requested pages are specified in the ``max_pages``.
+ 6. The masks are specified in ``category_mask``, ``category_anyof_mask``,
+    ``category_inverted`` and ``return_mask``.
+    1.  To find if ``PAGE_IS_WRITTEN`` flag is set for pages which have
+        ``PAGE_IS_FILE`` set and ``PAGE_IS_SWAPPED`` unset, ``category_mask``
+        is set to ``PAGE_IS_FILE | PAGE_IS_SWAPPED``, ``category_inverted`` is
+        set to ``PAGE_IS_SWAPPED`` and ``return_mask`` is set to ``PAGE_IS_WRITTEN``.
+        The output buffer in ``vec`` and length must be specified in ``vec_len``.
+    2. To find pages which have either ``PAGE_IS_FILE`` or ``PAGE_IS_SWAPPED``
+       set, ``category_anyof_mask`` is set to  ``PAGE_IS_FILE | PAGE_IS_SWAPPED``.
+    3. To find written pages and engage write protect, ``PAGE_IS_WRITTEN`` is
+       specified in ``category_mask`` and ``return_mask``. In addition to
+       specifying the output buffer in ``vec`` and length in ``vec_len``, the
+       ``PM_SCAN_WP_MATCHING`` is specified in ``flags`` to perform write protect
+       on the range as well.
+
+The ``PAGE_IS_WRITTEN`` flag can be considered as the better and correct
+alternative of soft-dirty flag. It doesn't get affected by housekeeping chores
+(VMA merging) of the kernel and hence the user can find the true soft-dirty pages
+only. This IOCTL adds the atomic way to find which pages have been written and
+write protect those pages again. This kind of operation is needed to efficiently
+find out which pages have changed in the memory.
+
+To get information about which pages have been written to or optionally write
+protect the pages, following must be performed first in order:
+ 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
+ 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` features
+    are set by ``UFFDIO_API`` IOCTL.
+ 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
+    through ``UFFDIO_REGISTER`` IOCTL.
+ 4. Then any part of the registered memory or the whole memory region must
+    be write protected using ``PAGEMAP_SCAN`` IOCTL with flag ``PM_SCAN_OP_WP``
+    or the ``UFFDIO_WRITEPROTECT`` IOCTL can be used. Both of these perform the
+    same operation. The former is better in terms of performance.
+ 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages which
+    have been written to and/or optionally write protect the pages as well.
-- 
2.39.2

