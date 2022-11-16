Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893AA62B8E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKPKfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiKPKdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941865AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1T+ot5qRtqPN1LpUOFfkK/yXOB9NMbn5pFr5NKSN84=;
        b=iPdHLcnOCHh1/LDSM/NhBrVYwdcef5EwnzddJGjYZSBC4HAb3h/babR3PRHYpWR1IyxvUB
        w+rwwpnY6Ws/Kk1/EgFbWSBWs1Ekps8qwBHJ4xis9078c973j8uqAyDVD58wYXHHKapjzA
        DUzjuPwTKIwxyruw+q2tQp8Z+wDrnR0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-r17LTSJHM5C5l1EBulZ-LQ-1; Wed, 16 Nov 2022 05:28:24 -0500
X-MC-Unique: r17LTSJHM5C5l1EBulZ-LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D71761C0A110;
        Wed, 16 Nov 2022 10:28:22 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E25A2024CCA;
        Wed, 16 Nov 2022 10:28:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 08/20] mm: extend FAULT_FLAG_UNSHARE support to anything in a COW mapping
Date:   Wed, 16 Nov 2022 11:26:47 +0100
Message-Id: <20221116102659.70287-9-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend FAULT_FLAG_UNSHARE to break COW on anything mapped into a
COW (i.e., private writable) mapping and adjust the documentation
accordingly.

FAULT_FLAG_UNSHARE will now also break COW when encountering the shared
zeropage, a pagecache page, a PFNMAP, ... inside a COW mapping, by
properly replacing the mapped page/pfn by a private copy (an exclusive
anonymous page).

Note that only do_wp_page() needs care: hugetlb_wp() already handles
FAULT_FLAG_UNSHARE correctly. wp_huge_pmd()/wp_huge_pud() also handles it
correctly, for example, splitting the huge zeropage on FAULT_FLAG_UNSHARE
such that we can handle FAULT_FLAG_UNSHARE on the PTE level.

This change is a requirement for reliable long-term R/O pinning in
COW mappings.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 8 ++++----
 mm/memory.c              | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e7f4fac1e78..5e9aaad8c7b2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1037,9 +1037,9 @@ typedef struct {
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
- *                      exclusive) a possibly shared anonymous page that is
- *                      mapped R/O.
+ * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to break COW in a
+ *                      COW mapping, making sure that an exclusive anon page is
+ *                      mapped after the fault.
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
  *
@@ -1064,7 +1064,7 @@ typedef struct {
  *
  * The combination FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE is illegal.
  * FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault when
- * no existing R/O-mapped anonymous page is encountered.
+ * applied to mappings that are not COW mappings.
  */
 enum fault_flag {
 	FAULT_FLAG_WRITE =		1 << 0,
diff --git a/mm/memory.c b/mm/memory.c
index d47ad33c6487..56b21ab1e4d2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3432,10 +3432,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		}
 		wp_page_reuse(vmf);
 		return 0;
-	} else if (unshare) {
-		/* No anonymous page -> nothing to do. */
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
 	}
 copy:
 	/*
-- 
2.38.1

