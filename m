Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14E9733EBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjFQGj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjFQGj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0F2721;
        Fri, 16 Jun 2023 23:39:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b51780bed0so12601325ad.3;
        Fri, 16 Jun 2023 23:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686983966; x=1689575966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crj4AOYfyqhNznIGfJkLyC4r78ZNyHEK1sC4/e8zC8Q=;
        b=fklUhfQKPt3Iry+A81Ec6X7AIUzJQZpIBbAmaM/YPmosETutG7a+zNYvNhcR28P6j2
         XciQcchKtNnSc7bI+cSL8fp94+Kk4sUWdSOfZwzownoKuiXuujRmd5bCJ7IXerO51mgF
         PRlYSlBIPJWcDnU3DLNmrjxmg7D+1lw5okkBNVTrDK/e4xPFZeWFGBkdoo5Cg9vi2/ex
         HDEHDElQa3co2pRoY5jPEFfXJVJd1yXhH/mms7macwkv53PJy6lrV9uWWySCBOt/1S3y
         aDh5ov9YjW7hi+WOKOpjJ0KIjhfToJR2hVCq0yzV9Aq2RSbv7XOonbWfRGBpwA0ZWhfx
         5Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686983966; x=1689575966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crj4AOYfyqhNznIGfJkLyC4r78ZNyHEK1sC4/e8zC8Q=;
        b=hvsxYd2lb0xp4ruR2YZo5wEknOv/kpwgNvjF9Q7VHHUH6nReIXiVQ1h6oDNIJTcUW5
         9vAHDUkqe0oL3dMIKDqf0b5uIuOtMT6wafU+Ssc5cUSuAj8Gch6j7FdRYW3kX3chOhY+
         tt488QgsEi85pPqbMYDugvZTQ5q9QPVXulebU7ZqE4BIbBTZUStnC57lclt2zbfbBDmd
         wd7ATnFJ355Uey3glJyf1TYKuos8fAhk3hiPiOzxyAoOCMDH5TGyuLmlnWbdZpQ9Vvyd
         uxMFdt9cMeDbBnnhdzwU8KBFTc+vkQ+TADXIgXoBHZbsBrQQwXdtVSS+9ekWkZztP2dA
         pXJQ==
X-Gm-Message-State: AC+VfDy9dL81ybGU4pNo672+1Xa/l28E0m7FmBLyAiptwj2ZtoSlAM5E
        3IXyVseDcPuoPpkXtip7Rmg=
X-Google-Smtp-Source: ACHHUZ7iPZK2HsJkSI4IWkzZnY3DPWpM+K+RU282vWFFZeHOF7C1AUyrCKJKtjGNaYpYwevP69tdcw==
X-Received: by 2002:a17:903:22c4:b0:1b0:5c0a:3f80 with SMTP id y4-20020a17090322c400b001b05c0a3f80mr5552777plg.44.1686983965905;
        Fri, 16 Jun 2023 23:39:25 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709029a9400b001b536aaf7c2sm1898337plp.189.2023.06.16.23.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 23:39:25 -0700 (PDT)
Date:   Fri, 16 Jun 2023 23:39:22 -0700
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
Message-ID: <ZI1VGsaOZ2a1HiKN@gmail.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230615141144.665148-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:11:41PM +0500, Muhammad Usama Anjum wrote:
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	bool is_written, flush = false, is_interesting = true;
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long bitmap, addr = end;
> +	pte_t *pte, *orig_pte, ptent;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +
> +	arch_enter_lazy_mmu_mode();
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
> +
> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +			n_pages = p->max_pages - p->found_pages;
> +
> +		is_written = !is_pmd_uffd_wp(*pmd);
> +
> +		/*
> +		 * Break huge page into small pages if the WP operation need to
> +		 * be performed is on a portion of the huge page.
> +		 */
> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +			spin_unlock(ptl);
> +
> +			split_huge_pmd(vma, pmd, start);
> +			goto process_smaller_pages;
> +		}
> +
> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
> +				       pmd_present(*pmd), is_swap_pmd(*pmd));
> +
> +		if (IS_PM_SCAN_GET(p->flags)) {
> +			is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
> +			if (is_interesting)
> +				ret = pagemap_scan_output(bitmap, p, start, n_pages);
> +		}
> +
> +		if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
> +		    ret >= 0) {
> +			make_uffd_wp_pmd(vma, start, pmd);
> +			flush_tlb_range(vma, start, end);
> +		}
> +
> +		spin_unlock(ptl);
> +
> +		arch_leave_lazy_mmu_mode();
> +		return ret;
> +	}
> +
> +process_smaller_pages:
> +#endif
> +
> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> +	if (!pte) {

Do we need to unlock ptl here?

		spin_unlock(ptl);

> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
> +		ptent = ptep_get(pte);
> +		is_written = !is_pte_uffd_wp(ptent);
> +
> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
> +				       pte_present(ptent), is_swap_pte(ptent));

The vma->vm_file check isn't correct in this case. You can look when
pte_to_pagemap_entry sets PM_FILE. This flag is used to detect what
pages have a file backing store and what pages are anonymous.

I was trying to integrate this new interace into CRIU and I found
one more thing that is required. We need to detect zero pages.

It should look something like this:

#define PM_SCAN_FLAGS(wt, file, present, swap, zero)   \
       ((wt) | ((file) << 1) | ((present) << 2) | ((swap) << 3) | ((zero) << 4))


bitmap = PM_SCAN_FLAGS(is_written, page && !PageAnon(page),
		      pte_present(ptent), is_swap_pte(ptent),
		      pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));

Thanks,
Andrei
