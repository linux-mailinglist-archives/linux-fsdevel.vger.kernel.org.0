Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4573905B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFUTpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUTpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:45:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39011733;
        Wed, 21 Jun 2023 12:45:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso3643400a12.1;
        Wed, 21 Jun 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376732; x=1689968732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUdxh/Qz7xLS5+5DunSJXn1dUp+IwyXnxa9FBoPuZPE=;
        b=iYOI3bug8QkhcWWGXW7r5F+tSbR5kLbhYht1GL4LIIT+K1xU4IITZirbBERHDydm3L
         7lSSHmxURFybImkLLYHj1miTxFiEks9aKPGLPxwcNGhuV06pSCnJp3liEhcwBWbu+evu
         7MGMPG93/ZElAWgQPx+bj5xLBIEliOdEcCMH1NPyLAA6n6aFX8zdWSa26biYynjD5ve8
         RGcEaV/Lljh01/1jyEVz6m3dAgUebPvYflisVRcRdao4DuC1X1mUHhYDKOlP/dyeVBMk
         4A2Uwi0wtX2UJ3UMULq80FfWekZs3kmr6MCO//DI7Kdk16pR9R472yTynZLZHXS8HAoa
         A68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376732; x=1689968732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUdxh/Qz7xLS5+5DunSJXn1dUp+IwyXnxa9FBoPuZPE=;
        b=YuCf9zGD27Mqlk8MqUcuBdHDn7mF9Yb2JZfZnH/YKl+bgbuRkmgDeH0JFMZd++2hW/
         65aKKeNeFTx3a6hrDIri3BFLSgsRPVNRKs1t9ThfGlgYcNb4VmaFRbqMJo67WlsR21xp
         CHYcSCaU/1EeAhjSI8FPJCt6wQZjZgTNnAFEtXd2mIX+KvGIDjCgN6zd0sPzj9yn81W0
         oKeIAq7P+8YL9K/QZCoPEY6VRXed+m8M2Pz/JF4l0es04XEHLwFoQ/1fCPbBthAVVC+D
         SHADW3otY6tTG1OKTzbDMqsNwsPPEIQA8irK8/ReG37bWjC5MakUpmiE208qpcFd/7Sh
         s1nQ==
X-Gm-Message-State: AC+VfDyKhmotqeT0eF+vNADAId+O08N7yGRJhpPithzqPuKtIizLBhAO
        H8Z+yiqvTkWysbT42/ZRaOg=
X-Google-Smtp-Source: ACHHUZ7eCTls6IK/3LemP0hC6LfDXkX4MJeTOYNyvfA3evZ+hZVItNLy/fdRCnhcOlDkbpBwhwM1uQ==
X-Received: by 2002:a17:90a:e398:b0:260:ff26:6dfa with SMTP id b24-20020a17090ae39800b00260ff266dfamr2295733pjz.38.1687376731923;
        Wed, 21 Jun 2023 12:45:31 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b00246cc751c6bsm9897612pjc.46.2023.06.21.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:45:31 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:45:29 -0700
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
Message-ID: <ZJNTWV+JZ+tTMdcp@gmail.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com>
 <ZJHp6hSeS6lMo7qx@gmail.com>
 <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:34:54AM +0500, Muhammad Usama Anjum wrote:
> Hi,
> 
> Thank you for your review.
> 
> On 6/20/23 11:03 PM, Andrei Vagin wrote:
> ...
> >> +struct pagemap_scan_private {
> >> +	struct page_region *vec_buf, cur_buf;
> >> +	unsigned long long vec_buf_len, vec_buf_index, max_pages, found_pages, flags;
> > 
> > should it be just unsigned long?
> These internal values are storing data coming from user in struct
> pm_scan_arg in which all variables are 64 bit(__u64) explicitly. This is
> why we have unsigned long long here. It is absolutely necessary.

It isn't necessary, because "unsigned long" is enough for  all valid values
> 
> > 
> >> +	unsigned long long required_mask, anyof_mask, excluded_mask, return_mask;
> >> +};
> >> +
> >> +static inline bool is_pte_uffd_wp(pte_t pte)
> >> +{
> >> +	return (pte_present(pte) && pte_uffd_wp(pte)) ||
> >> +	       pte_swp_uffd_wp_any(pte);
> >> +}
> >> +
> >> +static inline void make_uffd_wp_pte(struct vm_area_struct *vma,
> >> +				    unsigned long addr, pte_t *pte)
> >> +{
> >> +	pte_t ptent = ptep_get(pte);
> >> +
> >> +	if (pte_present(ptent)) {
> >> +		pte_t old_pte;
> >> +
> >> +		old_pte = ptep_modify_prot_start(vma, addr, pte);
> >> +		ptent = pte_mkuffd_wp(ptent);
> >> +		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> >> +	} else if (is_swap_pte(ptent)) {
> >> +		ptent = pte_swp_mkuffd_wp(ptent);
> >> +		set_pte_at(vma->vm_mm, addr, pte, ptent);
> >> +	} else {
> >> +		set_pte_at(vma->vm_mm, addr, pte,
> >> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
> >> +	}
> >> +}
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
> >> +{
> >> +	return (pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
> >> +	       (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd));
> >> +}
> >> +
> >> +static inline void make_uffd_wp_pmd(struct vm_area_struct *vma,
> >> +				    unsigned long addr, pmd_t *pmdp)
> >> +{
> >> +	pmd_t old, pmd = *pmdp;
> >> +
> >> +	if (pmd_present(pmd)) {
> >> +		old = pmdp_invalidate_ad(vma, addr, pmdp);
> >> +		pmd = pmd_mkuffd_wp(old);
> >> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> >> +	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
> >> +		pmd = pmd_swp_mkuffd_wp(pmd);
> >> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> >> +	}
> >> +}
> >> +#endif
> >> +
> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static inline bool is_huge_pte_uffd_wp(pte_t pte)
> >> +{
> >> +	return (pte_present(pte) && huge_pte_uffd_wp(pte)) ||
> >> +	       pte_swp_uffd_wp_any(pte);
> >> +}
> >> +
> >> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >> +					 unsigned long addr, pte_t *ptep,
> >> +					 pte_t ptent)
> >> +{
> >> +	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
> >> +		return;
> >> +
> >> +	if (is_hugetlb_entry_migration(ptent))
> >> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >> +				pte_swp_mkuffd_wp(ptent));
> >> +	else if (!huge_pte_none(ptent))
> >> +		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
> >> +					     huge_pte_mkuffd_wp(ptent));
> >> +	else
> >> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >> +				make_pte_marker(PTE_MARKER_UFFD_WP));
> >> +}
> >> +#endif
> >> +
> >> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
> >> +				  struct mm_walk *walk)
> >> +{
> >> +	struct pagemap_scan_private *p = walk->private;
> >> +	struct vm_area_struct *vma = walk->vma;
> >> +
> >> +	if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(vma) ||
> >> +	    !userfaultfd_wp_use_markers(vma)))
> >> +		return -EPERM;
> >> +
> >> +	if (vma->vm_flags & VM_PFNMAP)
> >> +		return 1;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int pagemap_scan_output(unsigned long bitmap,
> >> +			       struct pagemap_scan_private *p,
> >> +			       unsigned long addr, unsigned int n_pages)
> >> +{
> >> +	struct page_region *cur_buf = &p->cur_buf;
> >> +
> >> +	if (!n_pages)
> >> +		return -EINVAL;
> >> +
> >> +	bitmap &= p->return_mask;
> >> +
> >> +	if (cur_buf->flags == bitmap &&
> >> +	    cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
> >> +		cur_buf->len += n_pages;
> >> +		p->found_pages += n_pages;
> >> +	} else {
> >> +		if (cur_buf->len) {
> > 
> > I would add a comment that vec_buf_len has been decremented by one for
> > cur_buf.
> > 
> >> +			if (p->vec_buf_index >= p->vec_buf_len)
> >> +				return PM_SCAN_BUFFER_FULL;
> >> +
> >> +			memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
> >> +			       sizeof(*p->vec_buf));
> >> +			p->vec_buf_index++;
> >> +		}
> >> +
> >> +		cur_buf->start = addr;
> >> +		cur_buf->len = n_pages;
> >> +		cur_buf->flags = bitmap;
> >> +		p->found_pages += n_pages;
> >> +	}
> >> +
> >> +	if (p->found_pages == p->max_pages)
> >> +		return PM_SCAN_FOUND_MAX_PAGES;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static bool pagemap_scan_is_interesting_page(unsigned long bitmap,
> >> +					     struct pagemap_scan_private *p)
> >> +{
> >> +	if ((p->required_mask & bitmap) != p->required_mask)
> >> +		return false;
> >> +	if (p->anyof_mask && !(p->anyof_mask & bitmap))
> >> +		return false;
> >> +	if (p->excluded_mask & bitmap)
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +
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
> > 
> > It might be worth stopping rather than splitting the huge page.
> Sometimes normal pages can be grouped to become THP by the kernel depending
> upon the configurations. We don't want to reject ioctl just because this
> folding operation happened. We don't want to stop rather spliting is the
> best option and it does work fine.
> 
> > 
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
> >> +
> >> +		if (IS_PM_SCAN_GET(p->flags)) {
> >> +			is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
> >> +			if (is_interesting)
> >> +				ret = pagemap_scan_output(bitmap, p, addr, 1);
> >> +		}
> >> +
> >> +		if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
> >> +		    ret >= 0) {
> >> +			make_uffd_wp_pte(vma, addr, pte);
> >> +			flush = true;
> >> +		}
> >> +	}
> >> +
> >> +	if (flush)
> >> +		flush_tlb_range(vma, start, addr);
> >> +
> >> +	pte_unmap_unlock(orig_pte, ptl);
> >> +	arch_leave_lazy_mmu_mode();
> >> +
> >> +	cond_resched();
> >> +	return ret;
> >> +}
> >> +
> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> >> +				      unsigned long start, unsigned long end,
> >> +				      struct mm_walk *walk)
> >> +{
> >> +	unsigned long n_pages = (end - start)/PAGE_SIZE;
> >> +	struct pagemap_scan_private *p = walk->private;
> >> +	struct vm_area_struct *vma = walk->vma;
> >> +	bool is_written, is_interesting = true;
> >> +	struct hstate *h = hstate_vma(vma);
> >> +	unsigned long bitmap;
> >> +	spinlock_t *ptl;
> >> +	int ret = 0;
> >> +	pte_t ptent;
> >> +
> >> +	if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE)
> >> +		return -EINVAL;
> >> +
> >> +	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> >> +		n_pages = p->max_pages - p->found_pages;
> >> +
> >> +	if (IS_PM_SCAN_WP(p->flags)) {
> >> +		i_mmap_lock_write(vma->vm_file->f_mapping);
> >> +		ptl = huge_pte_lock(h, vma->vm_mm, ptep);
> >> +	}
> >> +
> >> +	ptent = huge_ptep_get(ptep);
> >> +	is_written = !is_huge_pte_uffd_wp(ptent);
> >> +
> >> +	/*
> >> +	 * Partial hugetlb page clear isn't supported
> >> +	 */
> >> +	if (is_written && IS_PM_SCAN_WP(p->flags) &&
> >> +	    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> > 
> > n_pages depends on found_pages that is incremented in
> > pagemap_scan_output. Should we do this check right before calling
> > pagemap_scan_output?
> This condition is acting like a check before pagemap_scan_output() already.
> n_pages is telling us that how many empty pages are left to find out. But
> if by making n_pages less, we cannot cover the whole hugetlb, we should
> just return error as we don't split the hugetlb.

I understand that, but here you don't know whether pagemap_scan_output
will be called for this page or not. It means that an error can be
reported due to unrelated page and this doesn't look right.

> 
> > 
> >> +		ret = -ENOSPC;
> > 
> > should it be PM_SCAN_FOUND_MAX_PAGES? Otherwise, it fails the ioctl even
> > if it has handled some pages already.
> It is a double edge sword. If we don't return error, user will never know
> that he needs to specify more max_pages or his output buffer is small and
> not coverig the entire range. The real purpose here that user gets aware
> that he needs to specify full hugetlb range and found pages should cover
> the entire range as well.

but if PM_SCAN_OP_WP is set, this error will be fatal, because some
pages can be marked write-protected, but they are not be reported to
user-space. 

I think the ioctl has to report back the end address of the handled
region. It is like read and write syscalls that can return less data
than requested.

> 
> > 
> >> +		goto unlock_and_return;
> >> +	}
> >> +
> >> +	bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
> >> +			       pte_present(ptent), is_swap_pte(ptent));
> >> +
> >> +	if (IS_PM_SCAN_GET(p->flags)) {
> >> +		is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
> >> +		if (is_interesting)
> >> +			ret = pagemap_scan_output(bitmap, p, start, n_pages);
> >> +	}
> >> +
> >> +	if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
> >> +	    ret >= 0) {
> >> +		make_uffd_wp_huge_pte(vma, start, ptep, ptent);
> >> +		flush_hugetlb_tlb_range(vma, start, end);
> >> +	}
> >> +
> >> +unlock_and_return:
> >> +	if (IS_PM_SCAN_WP(p->flags)) {
> >> +		spin_unlock(ptl);
> >> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +#else
> >> +#define pagemap_scan_hugetlb_entry NULL
> >> +#endif
> >> +
> >> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
> >> +				 int depth, struct mm_walk *walk)
> >> +{
> >> +	unsigned long n_pages = (end - addr)/PAGE_SIZE;
> >> +	struct pagemap_scan_private *p = walk->private;
> >> +	struct vm_area_struct *vma = walk->vma;
> >> +	int ret = 0;
> >> +
> >> +	if (!vma || !IS_PM_SCAN_GET(p->flags))
> >> +		return 0;
> >> +
> >> +	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> >> +		n_pages = p->max_pages - p->found_pages;
> >> +
> >> +	ret = pagemap_scan_output(PM_SCAN_FLAGS(false, (bool)vma->vm_file,
> >> +				  false, false), p, addr, n_pages);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static const struct mm_walk_ops pagemap_scan_ops = {
> >> +	.test_walk = pagemap_scan_test_walk,
> >> +	.pmd_entry = pagemap_scan_pmd_entry,
> >> +	.pte_hole = pagemap_scan_pte_hole,
> >> +	.hugetlb_entry = pagemap_scan_hugetlb_entry,
> >> +};
> >> +
> >> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
> >> +				   struct page_region __user *vec)
> >> +{
> >> +	/* Detect illegal size, flags, len and masks */
> >> +	if (arg->size != sizeof(struct pm_scan_arg))
> >> +		return -EINVAL;
> >> +	if (!arg->flags)
> >> +		return -EINVAL;
> >> +	if (arg->flags & ~PM_SCAN_OPS)
> >> +		return -EINVAL;
> >> +	if (!arg->len)
> >> +		return -EINVAL;
> >> +	if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
> >> +	     arg->return_mask) & ~PM_SCAN_BITS_ALL)
> >> +		return -EINVAL;
> >> +	if (!arg->required_mask && !arg->anyof_mask &&
> >> +	    !arg->excluded_mask)
> >> +		return -EINVAL;
> >> +	if (!arg->return_mask)
> >> +		return -EINVAL;
> >> +
> >> +	/* Validate memory range */
> >> +	if (!IS_ALIGNED(start, PAGE_SIZE))
> >> +		return -EINVAL;
> >> +	if (!access_ok((void __user *)start, arg->len))
> >> +		return -EFAULT;
> >> +
> >> +	if (IS_PM_SCAN_GET(arg->flags)) {
> >> +		if (!arg->vec)
> >> +			return -EINVAL;
> >> +		if (arg->vec_len == 0)
> >> +			return -EINVAL;
> >> +		if (!access_ok((void __user *)arg->vec,
> >> +			       arg->vec_len * sizeof(struct page_region)))
> >> +			return -EFAULT;
> >> +	}
> >> +
> >> +	if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
> >> +	    arg->max_pages)
> >> +		return -EINVAL;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
> >> +{
> >> +	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
> >> +	unsigned long long start, end, walk_start, walk_end;
> >> +	unsigned long long empty_slots, vec_index = 0;
> >> +	struct mmu_notifier_range range;
> >> +	struct page_region __user *vec;
> >> +	struct pagemap_scan_private p;
> >> +	struct pm_scan_arg arg;
> >> +	int ret = 0;
> >> +
> >> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
> >> +		return -EFAULT;
> >> +
> >> +	start = untagged_addr((unsigned long)arg.start);
> >> +	vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
> >> +
> >> +	ret = pagemap_scan_args_valid(&arg, start, vec);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	end = start + arg.len;
> >> +	p.max_pages = arg.max_pages;
> >> +	p.found_pages = 0;
> >> +	p.required_mask = arg.required_mask;
> >> +	p.anyof_mask = arg.anyof_mask;
> >> +	p.excluded_mask = arg.excluded_mask;
> >> +	p.return_mask = arg.return_mask;
> >> +	p.flags = arg.flags;
> >> +	p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
> >> +		    PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
> >> +	p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
> >> +	p.vec_buf = NULL;
> >> +	p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> >> +
> >> +	/*
> >> +	 * Allocate smaller buffer to get output from inside the page walk
> >> +	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
> >> +	 * we want to return output to user in compact form where no two
> >> +	 * consecutive regions should be continuous and have the same flags.
> >> +	 * So store the latest element in p.cur_buf between different walks and
> >> +	 * store the p.cur_buf at the end of the walk to the user buffer.
> >> +	 */
> >> +	if (IS_PM_SCAN_GET(p.flags)) {
> >> +		p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
> >> +					  GFP_KERNEL);
> >> +		if (!p.vec_buf)
> >> +			return -ENOMEM;
> >> +	}
> >> +
> >> +	if (IS_PM_SCAN_WP(p.flags)) {
> >> +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> >> +					mm, start, end);
> >> +		mmu_notifier_invalidate_range_start(&range);
> >> +	}
> >> +
> >> +	walk_start = walk_end = start;
> >> +	while (walk_end < end && !ret) {
> > 
> > How long can it take to run this loop? Should we interrupt it if a
> > signal has been queued?
> I'm following mincore and pagemap_read here. There is no such thing there.
> IOCTL is performing what user has requested.

In case of pagemap, its buffer is limited by MAX_RW_COUNT (0x7ffff000),
so it can handle maximum 0xffffe00 pages in one iteration.  Do you have any
limits for input parameters?

> If the execution time is a
> concern, user should have called the IOCTL on shorter address range.

It doesn't work this way. There can be many users and signals has to be
delivered in a reasonable time. One of the obvious examples when a signal
has to be delivered asap is OOM.

> 
> > 
> >> +		if (IS_PM_SCAN_GET(p.flags)) {
> >> +			p.vec_buf_index = 0;
> >> +
> >> +			/*
> >> +			 * All data is copied to cur_buf first. When more data
> >> +			 * is found, we push cur_buf to vec_buf and copy new
> >> +			 * data to cur_buf. Subtract 1 from length as the
> >> +			 * index of cur_buf isn't counted in length.
> >> +			 */
> >> +			empty_slots = arg.vec_len - vec_index;
> >> +			p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
> >> +		}
> >> +
> >> +		walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
> >> +		if (walk_end > end)
> >> +			walk_end = end;
> >> +
> >> +		ret = mmap_read_lock_killable(mm);
> >> +		if (ret)
> >> +			goto free_data;
> > 
> > This will fail the ioctl, but it isn't acceptable if any pages has been
> > handled.
> I'm following pagemap_read() here.


pagemap_read() doesn't change states of pages, so it is safe to return
errors from it. In this case, such errors will be fatal, because you
mark some pages as write-protected but don't report them to the user.

> 
> > 
> > 
> >> +		ret = walk_page_range(mm, walk_start, walk_end,
> >> +				      &pagemap_scan_ops, &p);
> >> +		mmap_read_unlock(mm);
> >> +
> > 
> > ret can be ENOSPC returned from pagemap_scan_pmd_entry, but we should
> > not return this error if any pages has been handled.
> ENOSPC isn't being returned from pagemap_scan_pmd_entry now.

I mean pagemap_scan_hugetlb_entry.

> 
> > 
> >> +		if (ret && ret != PM_SCAN_BUFFER_FULL &&
> >> +		    ret != PM_SCAN_FOUND_MAX_PAGES)
> >> +			goto free_data;
> >> +
> >> +		walk_start = walk_end;
> >> +		if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
> >> +			if (copy_to_user(&vec[vec_index], p.vec_buf,
> >> +					 p.vec_buf_index * sizeof(*p.vec_buf))) {
> >> +				/*
> >> +				 * Return error even though the OP succeeded
> >> +				 */
> >> +				ret = -EFAULT;
> >> +				goto free_data;
> >> +			}
> >> +			vec_index += p.vec_buf_index;
> >> +		}
> >> +	}
> >> +
> >> +	if (p.cur_buf.len) {
> >> +		if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
> >> +			ret = -EFAULT;
> >> +			goto free_data;
> >> +		}
> >> +		vec_index++;
> >> +	}
> >> +
> >> +	ret = vec_index;
> >> +
> >> +free_data:
> >> +	if (IS_PM_SCAN_WP(p.flags))
> >> +		mmu_notifier_invalidate_range_end(&range);
> >> +
> >> +	kfree(p.vec_buf);
> >> +	return ret;
> >> +}
> >> +
> >> +static long do_pagemap_cmd(struct file *file, unsigned int cmd,
> >> +			   unsigned long arg)
> >> +{
> >> +	struct mm_struct *mm = file->private_data;
> >> +
> >> +	switch (cmd) {
> >> +	case PAGEMAP_SCAN:
> >> +		return do_pagemap_scan(mm, arg);
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >>  const struct file_operations proc_pagemap_operations = {
> >>  	.llseek		= mem_lseek, /* borrow this */
> >>  	.read		= pagemap_read,
> >>  	.open		= pagemap_open,
> >>  	.release	= pagemap_release,
> >> +	.unlocked_ioctl = do_pagemap_cmd,
> >> +	.compat_ioctl	= do_pagemap_cmd,
> >>  };
> >>  #endif /* CONFIG_PROC_PAGE_MONITOR */
> >>  
> >> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >> index beb7c63d2871..a6e773c3e2b4 100644
> >> --- a/include/linux/hugetlb.h
> >> +++ b/include/linux/hugetlb.h
> >> @@ -261,6 +261,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
> >>  		unsigned long cp_flags);
> >>  
> >>  bool is_hugetlb_entry_migration(pte_t pte);
> >> +bool is_hugetlb_entry_hwpoisoned(pte_t pte);
> >>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> >>  
> >>  #else /* !CONFIG_HUGETLB_PAGE */
> >> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> >> index b7b56871029c..a9fb44db84a3 100644
> >> --- a/include/uapi/linux/fs.h
> >> +++ b/include/uapi/linux/fs.h
> >> @@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
> >>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> >>  			 RWF_APPEND)
> >>  
> >> +/* Pagemap ioctl */
> >> +#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> >> +
> >> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
> >> +#define PAGE_IS_WRITTEN		(1 << 0)
> >> +#define PAGE_IS_FILE		(1 << 1)
> >> +#define PAGE_IS_PRESENT		(1 << 2)
> >> +#define PAGE_IS_SWAPPED		(1 << 3)
> >> +
> >> +/*
> >> + * struct page_region - Page region with flags
> >> + * @start:	Start of the region
> >> + * @len:	Length of the region in pages
> >> + * @bitmap:	Bits sets for the region
> >> + */
> >> +struct page_region {
> >> +	__u64 start;
> >> +	__u64 len;
> >> +	__u64 flags;
> >> +};
> >> +
> >> +/*
> >> + * struct pm_scan_arg - Pagemap ioctl argument
> >> + * @size:		Size of the structure
> >> + * @flags:		Flags for the IOCTL
> >> + * @start:		Starting address of the region
> >> + * @len:		Length of the region (All the pages in this length are included)
> >> + * @vec:		Address of page_region struct array for output
> >> + * @vec_len:		Length of the page_region struct array
> >> + * @max_pages:		Optional max return pages
> >> + * @required_mask:	Required mask - All of these bits have to be set in the PTE
> >> + * @anyof_mask:		Any mask - Any of these bits are set in the PTE
> >> + * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
> >> + * @return_mask:	Bits that are to be reported in page_region
> >> + */
> >> +struct pm_scan_arg {
> >> +	__u64 size;
> >> +	__u64 flags;
> >> +	__u64 start;
> >> +	__u64 len;
> >> +	__u64 vec;
> >> +	__u64 vec_len;
> >> +	__u64 max_pages;
> >> +	__u64 required_mask;
> >> +	__u64 anyof_mask;
> >> +	__u64 excluded_mask;
> >> +	__u64 return_mask;
> >> +};
> >> +
> >> +/* Supported flags */
> >> +#define PM_SCAN_OP_GET	(1 << 0)
> >> +#define PM_SCAN_OP_WP	(1 << 1)
> >> +
> >>  #endif /* _UAPI_LINUX_FS_H */
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 0db13167b1ee..7e60f0f3fd03 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -4980,7 +4980,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
> >>  		return false;
> >>  }
> >>  
> >> -static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
> >> +bool is_hugetlb_entry_hwpoisoned(pte_t pte)
> >>  {
> >>  	swp_entry_t swp;
> >>  
> >> -- 
> >> 2.39.2
> >>
> 
> -- 
> BR,
> Muhammad Usama Anjum
