Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA08766B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjG1LCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjG1LCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:02:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D630C2;
        Fri, 28 Jul 2023 04:02:14 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.217.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16BA6660716E;
        Fri, 28 Jul 2023 12:02:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690542132;
        bh=6BZbfBT2rZxODr52sYE923/xM4HAzw94tje6ZBW3PV4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=IfxQ/tf1G4WtTN3MV35H6oOCurp8K+LlYxNLdJ6HOP0lyC0yXIbH3QqCd3D7MnRTV
         l4l/Ylvbjh/LzkZbjAg4mD1IlwyXtBsJKJmkMs816aBXmG/0VW5T4xShBPIU5SiMaN
         OmN5Bomx1gykQInxCrEi7L1TZtDu4IBcPv38cGviLkrJQw3nkvrp0hfSbJT3gDMsPt
         3oBAeCfGzyqA/e4BbXU8pduWZ8i8EXcpJBk0jWN8BtTO6XJUqda6+AqTQuIIIMCRi4
         kjBq4ozmbBaQHG+GTpg5LResVu7N918B8xSiRNfmMY6ZN/KnGvvlp4xG12wJMaLnWv
         Nz2s7bvpjN/Gw==
Message-ID: <6b6a4e1c-a9e9-9592-d5b4-3c9210c8b650@collabora.com>
Date:   Fri, 28 Jul 2023 16:02:02 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: WIP: Performance improvements
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com>
 <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We are optimizing for more performance. Please find the change-set below
for easy review before next revision and post your comments:

- Replace memcpy() with direct copy as it proving to be very expensive
- Don't check if PAGE_IS_FILE if no mask needs it as it is very
  expensive to check per pte
- Add question in comment for discussion purpose
- Add fast path for exclusive WP for ptes
---
 fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7e92c33635cab..879baf896ed0b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1757,37 +1757,51 @@ static int pagemap_release(struct inode *inode,
struct file *file)
 				 PAGE_IS_HUGE)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)

+#define MASKS_OF_INTEREST(a)	(a.category_inverted | a.category_mask | \
+				 a.category_anyof_mask | a.return_mask)
+
 struct pagemap_scan_private {
 	struct pm_scan_arg arg;
+	unsigned long masks_of_interest;
 	unsigned long cur_vma_category;
 	struct page_region *vec_buf, cur_buf;
 	unsigned long vec_buf_len, vec_buf_index, found_pages, end_addr;
 	struct page_region __user *vec_out;
 };

-static unsigned long pagemap_page_category(struct vm_area_struct *vma,
+static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
+					   struct vm_area_struct *vma,
 					   unsigned long addr, pte_t pte)
 {
 	unsigned long categories = 0;

 	if (pte_present(pte)) {
-		struct page *page = vm_normal_page(vma, addr, pte);
+		struct page *page;

 		categories |= PAGE_IS_PRESENT;
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
-		if (page && !PageAnon(page))
-			categories |= PAGE_IS_FILE;
+
+		if (p->masks_of_interest & PAGE_IS_FILE) {
+			page = vm_normal_page(vma, addr, pte);
+			if (page && !PageAnon(page))
+				categories |= PAGE_IS_FILE;
+		}
+
 		if (is_zero_pfn(pte_pfn(pte)))
 			categories |= PAGE_IS_PFNZERO;
 	} else if (is_swap_pte(pte)) {
-		swp_entry_t swp = pte_to_swp_entry(pte);
+		swp_entry_t swp;

 		categories |= PAGE_IS_SWAPPED;
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
-		if (is_pfn_swap_entry(swp) && !PageAnon(pfn_swap_entry_to_page(swp)))
-			categories |= PAGE_IS_FILE;
+
+		if (p->masks_of_interest & PAGE_IS_FILE) {
+			swp = pte_to_swp_entry(pte);
+			if (is_pfn_swap_entry(swp) && !PageAnon(pfn_swap_entry_to_page(swp)))
+				categories |= PAGE_IS_FILE;
+		}
 	}

 	return categories;
@@ -1957,9 +1971,7 @@ static bool pagemap_scan_push_range(unsigned long
categories,
 		if (p->vec_buf_index >= p->vec_buf_len)
 			return false;

-		memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
-		       sizeof(*p->vec_buf));
-		++p->vec_buf_index;
+		p->vec_buf[p->vec_buf_index++] = *cur_buf;
 	}

 	cur_buf->start = addr;
@@ -2095,9 +2107,24 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
unsigned long start,
 		return 0;
 	}

+	if (!p->vec_buf) {
+		/* Fast path for performing exclusive WP */
+		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
+			if (pte_uffd_wp(ptep_get(pte)))
+				continue;
+			make_uffd_wp_pte(vma, addr, pte);
+			if (!flush) {
+				start = addr;
+				flush = true;
+			}
+		}
+		ret = 0;
+		goto flush_and_return;
+	}
+
 	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
 		unsigned long categories = p->cur_vma_category |
-					   pagemap_page_category(vma, addr, ptep_get(pte));
+					   pagemap_page_category(p, vma, addr, ptep_get(pte));
 		unsigned long next = addr + PAGE_SIZE;

 		ret = pagemap_scan_output(categories, p, addr, &next);
@@ -2119,6 +2146,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
unsigned long start,
 		}
 	}

+flush_and_return:
 	if (flush)
 		flush_tlb_range(vma, start, addr);

@@ -2284,6 +2312,9 @@ static int pagemap_scan_init_bounce_buffer(struct
pagemap_scan_private *p)
 	 * consecutive ranges that have the same categories returned across
 	 * walk_page_range() calls.
 	 */
+	// Question: Increasing the vec_buf_len increases the execution speed.
+	// But it'll increase the memory needed to run the IOCTL. Can we do
something here?
+	// Right now only have space for 512 entries of page_region
 	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
 			       p->arg.vec_len - 1);
 	p->vec_buf = kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
@@ -2329,6 +2360,7 @@ static long do_pagemap_scan(struct mm_struct *mm,
unsigned long uarg)
 	if (ret)
 		return ret;

+	p.masks_of_interest = MASKS_OF_INTEREST(p.arg);
 	ret = pagemap_scan_init_bounce_buffer(&p);
 	if (ret)
 		return ret;
-- 
2.39.2

