Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45F687C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjBBLbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 06:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjBBLaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:30:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00658C1C9;
        Thu,  2 Feb 2023 03:30:52 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26B706602EEF;
        Thu,  2 Feb 2023 11:30:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675337451;
        bh=rLlyIO3l9/ftTkxvT1S8wXZ6q3zRzsa4+kS1JjkCdaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNzRn2uOBHFIIGjgY3mrnWpFZOvFEVEPpbuLkKnjX3xG+zLn36zT+MY+fYEtsxhEN
         qJ7Jz5qYFS23tEuBe06m4B1Y38T9WnmPUCdseCE2nUs9oorRNPYM/xhi1STGdQBWqR
         SIiqjkQzIPqKM9vyWQpi8NmK84J6iEIEx2Fz7y54dB2Bl72OiHTdj8IU1e2TO0Lgwx
         +bgWdPv7XQ8eWYuBePaowISY3eROPepkYhtTMWJh62VZR1ZoWc6G0NkAoI8pROUHEj
         pAYLdaMZZc/tfvCrKq8mLjxVm1PlHLtInA951+Q+CuG9X4R5Yqmky7cSrsr875cHy9
         6zOz9vQak55nQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v10 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
Date:   Thu,  2 Feb 2023 16:29:14 +0500
Message-Id: <20230202112915.867409-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230202112915.867409-1-usama.anjum@collabora.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
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
 Documentation/admin-guide/mm/pagemap.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 6e2e416af783..1cb2189e9a0d 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -230,3 +230,27 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
 always 12 at most architectures). Since Linux 3.11 their meaning changes
 after first clear of soft-dirty bits. Since Linux 4.2 they are used for
 flags unconditionally.
+
+Pagemap Scan IOCTL
+==================
+
+The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get and/or clear
+the info about page table entries. The following operations are supported in
+this IOCTL:
+- Get the information if the pages have been written-to (``PAGE_IS_WRITTEN``),
+  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``) or swapped
+  (``PAGE_IS_SWAPPED``).
+- Write-protect the pages (``PAGEMAP_WP_ENGAGE``) to start finding which
+  pages have been written-to.
+- Find pages which have been written-to and write protect the pages
+  (atomic ``PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE``)
+
+To get information about which pages have been written-to and/or write protect
+the pages, following must be performed first in order:
+ 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
+ 2. The ``UFFD_FEATURE_WP_ASYNC`` feature is set by ``UFFDIO_API`` IOCTL.
+ 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
+    through ``UFFDIO_REGISTER`` IOCTL.
+Then the any part of the registered memory or the whole memory region can be
+write protected using the ``UFFDIO_WRITEPROTECT`` IOCTL or ``PAGEMAP_SCAN``
+IOCTL.
-- 
2.30.2

