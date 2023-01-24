Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1367935F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjAXIo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 03:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjAXIot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5432536;
        Tue, 24 Jan 2023 00:44:47 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B4876602E2C;
        Tue, 24 Jan 2023 08:44:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674549886;
        bh=RhznnELLur/OFCYFz9nqeAiw2g/ULL6wGU1+TD5rlvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUm+6PNenlG1HTsei/j6rwysWnI8TegYAR6iAvi9zzJwK6VPMMr+FplOGi/L1HfUa
         r3Ll8oFgrop7lH0ZC3hz82Yt7dgmbpgU3SHB6LbQ6Nn13bC5vOs/tYeQ3eJjSxy/UL
         2Lk/jmcy1sxNNMrKJbiUjDSGXaLeIQHCZuieQZwZpXivOBPp4FL/YB69rofnMAB0F8
         opwMmSz2c6XWhw9SkuJD+GJoN9zUdGWBBlbDpz2dxAExQrB1XT16iZudardQesIqQV
         ltsLSpi+vDXhWc+g7NihNtxOqQn7gp6UoaljbWkIzyLMuotx5aXbAnXXBQNyxQOGaY
         SaDJV/V9WQkHw==
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
Subject: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Date:   Tue, 24 Jan 2023 13:43:21 +0500
Message-Id: <20230124084323.1363825-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230124084323.1363825-1-usama.anjum@collabora.com>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
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

Split mwriteprotect_range() to create a unlocked version. This
will be used in the next patch to write protect a memory area.
Add a helper function, wp_range_async() as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v7:
- Remove async being set in the PAGEMAP_IOCTL
---
 fs/userfaultfd.c              | 10 +++++++++
 include/linux/userfaultfd_k.h | 10 +++++++++
 mm/userfaultfd.c              | 40 ++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index b82af02092ce..cd52c9ee8db9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1961,6 +1961,16 @@ int userfaultfd_wp_async(struct vm_area_struct *vma)
 	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
 }
 
+int wp_range_async(struct vm_area_struct *vma, unsigned long start, unsigned long len)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	if (!ctx)
+		return -1;
+
+	return __mwriteprotect_range(ctx->mm, start, len, true, &ctx->mmap_changing);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 5db51fccae1d..40d1d9e8f34d 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -73,6 +73,9 @@ extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
+extern int __mwriteprotect_range(struct mm_struct *dst_mm,
+				 unsigned long start, unsigned long len,
+				 bool enable_wp, atomic_t *mmap_changing);
 extern void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
@@ -180,6 +183,8 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern int userfaultfd_wp_async(struct vm_area_struct *vma);
+extern int wp_range_async(struct vm_area_struct *vma, unsigned long start,
+			  unsigned long len);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -280,6 +285,11 @@ int userfaultfd_wp_async(struct vm_area_struct *vma)
 	return false;
 }
 
+int wp_range_async(struct vm_area_struct *vma, unsigned long start, unsigned long len)
+{
+	return -1;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 65ad172add27..9d8a43faf764 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -734,25 +734,13 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	tlb_finish_mmu(&tlb);
 }
 
-int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
-			unsigned long len, bool enable_wp,
-			atomic_t *mmap_changing)
+int __mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
+			  unsigned long len, bool enable_wp,
+			  atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
 	int err;
-
-	/*
-	 * Sanitize the command parameters:
-	 */
-	BUG_ON(start & ~PAGE_MASK);
-	BUG_ON(len & ~PAGE_MASK);
-
-	/* Does the address range wrap, or is the span zero-sized? */
-	BUG_ON(start + len <= start);
-
-	mmap_read_lock(dst_mm);
-
 	/*
 	 * If memory mappings are changing because of non-cooperative
 	 * operation (e.g. mremap) running in parallel, bail out and
@@ -783,6 +771,28 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 	err = 0;
 out_unlock:
+	return err;
+}
+
+int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
+			unsigned long len, bool enable_wp,
+			atomic_t *mmap_changing)
+{
+	int err;
+
+	/*
+	 * Sanitize the command parameters:
+	 */
+	BUG_ON(start & ~PAGE_MASK);
+	BUG_ON(len & ~PAGE_MASK);
+
+	/* Does the address range wrap, or is the span zero-sized? */
+	BUG_ON(start + len <= start);
+
+	mmap_read_lock(dst_mm);
+
+	err = __mwriteprotect_range(dst_mm, start, len, enable_wp, mmap_changing);
+
 	mmap_read_unlock(dst_mm);
 	return err;
 }
-- 
2.30.2

