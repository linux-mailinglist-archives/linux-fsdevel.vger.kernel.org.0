Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7D6B2624
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjCIOBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCIOAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F03F54CBF;
        Thu,  9 Mar 2023 05:58:19 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 548EC660304D;
        Thu,  9 Mar 2023 13:58:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370298;
        bh=7EyxuoXkxo+wN4f6n92h0Y3XCUTS8ggXPc5h+SWXj0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K54h775xda7qpZGbzNfU2dZdMjuif46vM8oNmxdowyjhbWWPbFACTwGJ1dxQPX950
         QJ1/t91wnTBLlf4qMFoXK7HErb8vrQ3e20oghvzHUyZXeksQgp61xi4W1e+RvXehma
         cGAesjhDySMWRPeRNMBI4DzNt2oRHHnuEIWSij8sddN++4J3rO+CId4RHFfsP4h5Ei
         A/EiS4ZbkKmqa801VhQmA/ub+YJeK5EF7g0L3DuqQjcXNHP2gUJff+b8udtYvxA/ki
         8UI4YBkl2m1qaYiFdJuUheFmkf/kf7FHP08jcO5rUJ4qubMtwm0YshRUJc/76b5CFz
         sb+TcT2VjZ7Ug==
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
Subject: [PATCH v11 6/7] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
Date:   Thu,  9 Mar 2023 18:57:17 +0500
Message-Id: <20230309135718.1490461-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
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
index b5f970dc91e7..41815511011c 100644
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

