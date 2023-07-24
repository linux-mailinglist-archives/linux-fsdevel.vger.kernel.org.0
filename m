Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF36375F938
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGXOEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGXOEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:04:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B048E53;
        Mon, 24 Jul 2023 07:04:43 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.185.74])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3114F66070F8;
        Mon, 24 Jul 2023 15:04:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690207481;
        bh=84gFfgvNjZLck9HjxQtgKLO7+C4nQjP+/K4qR/vw5mg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Zjt5nB2ho8foqo6yjSkDNZN7u5PDqCqUSX3rvsRIIXNCXYI5xlcdEVtNxeMKRVjX2
         SkaX/s0DDu5RAV/j6Zz64gV5tOj3h1kPa+EjHv268IHMTLV3MxRrbIL+5F4T5LsG2C
         iyBVLkVBlTlOgYLSWLlFd/BkYgHMSF39imCFxIaNg3hUroLyq0CCXJhkzdYSDcX+j7
         mcRLHANqG4IEsRudMPKje83H8gWzfbhl+RKOn9EVn3cOFbgzbX0QQn3oGphiOZG+4O
         jTACvSJ/3agvfTMsnyWJIz6TPB9weHU6nJG98gU3IqPzGyp9C3De+nfbbvLk1u5oCH
         vPPEqd7JUp96A==
Message-ID: <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
Date:   Mon, 24 Jul 2023 19:04:27 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
 <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixed found bugs. Testing it further.

- Split and backoff in case buffer full case as well
- Fix the wrong breaking of loop if page isn't interesting, skip intead
- Untag the address and save them into struct
- Round off the end address to next page

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index add21fdf3c9a..64b326d0ec6d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1764,7 +1764,8 @@ struct pagemap_scan_private {
 	struct page_region __user* vec_out;
 };

-static unsigned long pagemap_page_category(struct vm_area_struct *vma,
unsigned long addr, pte_t pte)
+static unsigned long pagemap_page_category(struct vm_area_struct *vma,
+					   unsigned long addr, pte_t pte)
 {
 	unsigned long categories = 0;

@@ -1908,6 +1909,7 @@ static bool pagemap_scan_is_interesting_vma(unsigned
long categories,
 	categories ^= p->arg.category_inverted;
 	if ((categories & required) != required)
 		return false;
+
 	return true;
 }

@@ -1930,6 +1932,7 @@ static int pagemap_scan_test_walk(unsigned long
start, unsigned long end,
 		return 1;

 	p->cur_vma_category = vma_category;
+
 	return 0;
 }

@@ -1961,6 +1964,7 @@ static bool pagemap_scan_push_range(unsigned long
categories,
 	cur_buf->start = addr;
 	cur_buf->end = end;
 	cur_buf->categories = categories;
+
 	return true;
 }

@@ -1985,18 +1989,19 @@ static int pagemap_scan_output(unsigned long
categories,
 	unsigned long n_pages, total_pages;
 	int ret = 0;

+	if (!p->vec_buf)
+		return 0;
+
 	if (!pagemap_scan_is_interesting_page(categories, p)) {
 		*end = addr;
 		return 0;
 	}

-	if (!p->vec_buf)
-		return 0;
-
 	categories &= p->arg.return_mask;

 	n_pages = (*end - addr) / PAGE_SIZE;
-	if (check_add_overflow(p->found_pages, n_pages, &total_pages) ||
total_pages > p->arg.max_pages) {
+	if (check_add_overflow(p->found_pages, n_pages, &total_pages) ||
+	    total_pages > p->arg.max_pages) {
 		size_t n_too_much = total_pages - p->arg.max_pages;
 		*end -= n_too_much * PAGE_SIZE;
 		n_pages -= n_too_much;
@@ -2012,6 +2017,7 @@ static int pagemap_scan_output(unsigned long categories,
 	p->found_pages += n_pages;
 	if (ret)
 		p->end_addr = *end;
+
 	return ret;
 }

@@ -2044,7 +2050,7 @@ static int pagemap_scan_thp_entry(pmd_t *pmd,
unsigned long start,
 	 * Break huge page into small pages if the WP operation
 	 * need to be performed is on a portion of the huge page.
 	 */
-	if (end != start + HPAGE_SIZE) {
+	if (end != start + HPAGE_SIZE || ret == -ENOSPC) {
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, start);
 		pagemap_scan_backout_range(p, start, end);
@@ -2066,8 +2072,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
unsigned long start,
 {
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	unsigned long addr, categories, next;
 	pte_t *pte, *start_pte;
-	unsigned long addr;
 	bool flush = false;
 	spinlock_t *ptl;
 	int ret;
@@ -2088,12 +2094,14 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
unsigned long start,
 	}

 	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
-		unsigned long categories = p->cur_vma_category |
-			pagemap_page_category(vma, addr, ptep_get(pte));
-		unsigned long next = addr + PAGE_SIZE;
+		categories = p->cur_vma_category |
+			     pagemap_page_category(vma, addr, ptep_get(pte));
+		next = addr + PAGE_SIZE;

 		ret = pagemap_scan_output(categories, p, addr, &next);
-		if (next == addr)
+		if (ret == 0 && next == addr)
+			continue;
+		else if (next == addr)
 			break;

 		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
@@ -2175,7 +2183,7 @@ static int pagemap_scan_pte_hole(unsigned long addr,
unsigned long end,
 {
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	int ret;
+	int ret, err;

 	if (!vma)
 		return 0;
@@ -2187,7 +2195,7 @@ static int pagemap_scan_pte_hole(unsigned long addr,
unsigned long end,
 	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
 		return ret;

-	int err = uffd_wp_range(vma, addr, end - addr, true);
+	err = uffd_wp_range(vma, addr, end - addr, true);
 	if (err < 0)
 		ret = err;

@@ -2204,8 +2212,6 @@ static const struct mm_walk_ops pagemap_scan_ops = {
 static int pagemap_scan_get_args(struct pm_scan_arg *arg,
 				 unsigned long uarg)
 {
-	unsigned long start, end, vec;
-
 	if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
 		return -EFAULT;

@@ -2219,22 +2225,24 @@ static int pagemap_scan_get_args(struct pm_scan_arg
*arg,
 	     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
 		return -EINVAL;

-	start = untagged_addr((unsigned long)arg->start);
-	end = untagged_addr((unsigned long)arg->end);
-	vec = untagged_addr((unsigned long)arg->vec);
+	arg->start = untagged_addr((unsigned long)arg->start);
+	arg->end = untagged_addr((unsigned long)arg->end);
+	arg->vec = untagged_addr((unsigned long)arg->vec);

 	/* Validate memory pointers */
-	if (!IS_ALIGNED(start, PAGE_SIZE))
+	if (!IS_ALIGNED(arg->start, PAGE_SIZE))
 		return -EINVAL;
-	if (!access_ok((void __user *)start, end - start))
+	if (!access_ok((void __user *)arg->start, arg->end - arg->start))
 		return -EFAULT;
-	if (!vec && arg->vec_len)
+	if (!arg->vec && arg->vec_len)
 		return -EFAULT;
-	if (vec && !access_ok((void __user *)vec,
+	if (arg->vec && !access_ok((void __user *)arg->vec,
 			      arg->vec_len * sizeof(struct page_region)))
 		return -EFAULT;

 	/* Fixup default values */
+	arg->end = (arg->end & ~PAGE_MASK) ?
+		   ((arg->end & PAGE_MASK) + PAGE_SIZE) : (arg->end);
 	if (!arg->max_pages)
 		arg->max_pages = ULONG_MAX;

@@ -2279,7 +2287,7 @@ static int pagemap_scan_init_bounce_buffer(struct
pagemap_scan_private *p)
 	if (!p->vec_buf)
 		return -ENOMEM;

-	p->vec_out = (void __user *)p->arg.vec;
+	p->vec_out = (struct page_region __user *)p->arg.vec;

 	return 0;
 }
-- 
2.39.2

