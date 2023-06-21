Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018DB737BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFUGmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFUGmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:42:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123A10D5;
        Tue, 20 Jun 2023 23:42:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4053194b3a.1;
        Tue, 20 Jun 2023 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687329735; x=1689921735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0SgAVt72Ur5h2QP95AnBfDKazfxmykjLGcuc3EB4YvE=;
        b=BsXNg3pvzfhMJBKVR3Juub/q2H5g9q8Bcbb5jTcnsC/NR+2fKlNAo6SVOk+Rw00LAT
         v2h8venQv7HCoG/KdDZwit75NiNSU+gZJCl8YfvQX4dF+hTheJlFMx8fD7vSUISluysJ
         XIe7WVV7h0hpNK0FcnSVs+idxSJ7+/nChWLndZBBg8NegRsY8/cQeBf58ZZvQMwArTeu
         ghveb+VgI9fbQYj5MfNPmwh6GCA2qRYMdLMsDmlz6A4y8T3bp5SscFDESBoaKxR1bvsH
         BPiPBIB30AksHOJgPJ45swezwz6/LLAdKY5MeRNkLUIgSiON7R0EJjv7QRFipi258LPO
         XlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329735; x=1689921735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SgAVt72Ur5h2QP95AnBfDKazfxmykjLGcuc3EB4YvE=;
        b=RqdAWUrDzW1/fpAMG/IQ2lb1oPi8tQMNXV9vdAo5QxhtLXAOBOKlpx8bRNZO6zePo2
         9IWWYqy+J0gzcEt1Pi76bsxTN8kFI7fbW6OOTIYH05u77f7l2np94tHaW6tEEXA3WTMN
         L6+cToVZg88+Vjb7D6z6EOewSj53nGpO5nsIS2g2I+XDwnBTm/prWlzuoP2s2G2W7YUu
         nO3AI8GB3qcIzwg7hzpwKuzf1xgamPPgHFuvTaOAILUpzgtX9DxqG+7DRqiqPmTGZDUr
         v8vsy5VLDa/+whwsF70of3GiAq+l6ON4n4TFMLtYzOro8jROKi5s9Kn6kDk1zWcu4CW7
         BY/A==
X-Gm-Message-State: AC+VfDxfeTqEDqSCMln5ewll/TNjeKw7atXdM/uFXiYdPyWYjqvsp8+O
        ZLWwaP7mOsTbRW0atB3lw7E=
X-Google-Smtp-Source: ACHHUZ6iOD6pORtXD9uYFY2Qv+BS5pYLjD7sFmTrlQc1qpZDzj6UPqROGFMiscoB0xcByZw1IWsuZQ==
X-Received: by 2002:a05:6a20:430c:b0:11d:2b0c:7f32 with SMTP id h12-20020a056a20430c00b0011d2b0c7f32mr19539474pzk.13.1687329735115;
        Tue, 20 Jun 2023 23:42:15 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u21-20020a62ed15000000b0063f0068cf6csm2246128pfh.198.2023.06.20.23.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:42:14 -0700 (PDT)
Date:   Tue, 20 Jun 2023 23:42:12 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZJKbxKrJRy/L2JuA@gmail.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com>
 <ZI1VGsaOZ2a1HiKN@gmail.com>
 <212e331f-35b0-5ae7-6371-26caa577d637@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <212e331f-35b0-5ae7-6371-26caa577d637@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:06:36AM +0500, Muhammad Usama Anjum wrote:
> On 6/17/23 11:39 AM, Andrei Vagin wrote:
> > On Thu, Jun 15, 2023 at 07:11:41PM +0500, Muhammad Usama Anjum wrote:
> >> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >> +				  unsigned long end, struct mm_walk *walk)
> >> +{
> >> +	bool is_written, flush = false, is_interesting = true;
> >> +	struct pagemap_scan_private *p = walk->private;
> >> +	struct vm_area_struct *vma = walk->vma;
> >> +	unsigned long bitmap, addr = end;
> >> +	pte_t *pte, *orig_pte, ptent;
> >> +	spinlock_t *ptl;
> >> +	int ret = 0;
> >> +
> >> +	arch_enter_lazy_mmu_mode();
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +	ptl = pmd_trans_huge_lock(pmd, vma);
> >> +	if (ptl) {
> >> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
> >> +
> >> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> >> +			n_pages = p->max_pages - p->found_pages;
> >> +
> >> +		is_written = !is_pmd_uffd_wp(*pmd);
> >> +
> >> +		/*
> >> +		 * Break huge page into small pages if the WP operation need to
> >> +		 * be performed is on a portion of the huge page.
> >> +		 */
> >> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
> >> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> >> +			spin_unlock(ptl);
> >> +
> >> +			split_huge_pmd(vma, pmd, start);
> >> +			goto process_smaller_pages;
> >> +		}
> >> +
> >> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
> >> +				       pmd_present(*pmd), is_swap_pmd(*pmd));
> >> +
> >> +		if (IS_PM_SCAN_GET(p->flags)) {
> >> +			is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
> >> +			if (is_interesting)
> >> +				ret = pagemap_scan_output(bitmap, p, start, n_pages);
> >> +		}
> >> +
> >> +		if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
> >> +		    ret >= 0) {
> >> +			make_uffd_wp_pmd(vma, start, pmd);
> >> +			flush_tlb_range(vma, start, end);
> >> +		}
> >> +
> >> +		spin_unlock(ptl);
> >> +
> >> +		arch_leave_lazy_mmu_mode();
> >> +		return ret;
> >> +	}
> >> +
> >> +process_smaller_pages:
> >> +#endif
> >> +
> >> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> >> +	if (!pte) {
> > 
> > Do we need to unlock ptl here?
> > 
> > 		spin_unlock(ptl);
> No, please look at these recently merged patches:
> https://lore.kernel.org/all/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com
> 
> > 
> >> +		walk->action = ACTION_AGAIN;
> >> +		return 0;
> >> +	}
> >> +
> >> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
> >> +		ptent = ptep_get(pte);
> >> +		is_written = !is_pte_uffd_wp(ptent);
> >> +
> >> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
> >> +				       pte_present(ptent), is_swap_pte(ptent));
> > 
> > The vma->vm_file check isn't correct in this case. You can look when
> > pte_to_pagemap_entry sets PM_FILE. This flag is used to detect what
> > pages have a file backing store and what pages are anonymous.
> I'll update.
> 
> > 
> > I was trying to integrate this new interace into CRIU and I found
> > one more thing that is required. We need to detect zero pages.
> Should we name it ZERO_PFN_PRESENT_PAGE to be exact or what?

IMHO, ZERO_PFN_PRESENT_PAGE looks a bit monstrous.
It looks like zero page is a proper noun in the kernel, so PAGE_IS_ZERO
might be a good choice here, but it is up to you.

> 
> > 
> > It should look something like this:
> > 
> > #define PM_SCAN_FLAGS(wt, file, present, swap, zero)   \
> >        ((wt) | ((file) << 1) | ((present) << 2) | ((swap) << 3) | ((zero) << 4))
> > 
> > 
> > bitmap = PM_SCAN_FLAGS(is_written, page && !PageAnon(page),
> > 		      pte_present(ptent), is_swap_pte(ptent),
> > 		      pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
> Okay. Can you please confirm my assumptions:
> - A THP cannot be file backed. (PM_FILE isn't being set for THP case)

```
Currently THP only works for anonymous memory mappings and tmpfs/shmem.
But in the future it can expand to other filesystems. 
```
https://www.kernel.org/doc/html/next/admin-guide/mm/transhuge.html

so THP can be "file backed".

> - A hole is also not file backed.
> 
> A hole isn't present in memory. So its pfn would be zero. But as it isn't
> present, it shouldn't report zero page. Right? For hole::
> 
> PM_SCAN_FLAGS(false, false, false, false, false)

This looks correct to me.

