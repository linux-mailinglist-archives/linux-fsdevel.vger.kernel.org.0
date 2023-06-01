Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1071F374
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFAUM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFAUMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F920134
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685650323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH52BVikKcnaVU74ot3GHAVVa3YUi3Nj+bJLSNVnGpE=;
        b=BFzbfEf4Dgh3pzn11IEVGIS5h69yYH6KpZFrmMlrO93754o7375SGvAZtLUE2hy1+54y4b
        9dpP67z3iNuHptEgUckZZe58Gat8GTJSfKKYuXPJ/k3iefD8pxGZKU3SoE74fO2fg2tP9l
        SB9JD4LEQEOsg9KV0olzLN/d0zQ/FnQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Wh_6GUvOOySZZtmNlXROOg-1; Thu, 01 Jun 2023 16:12:02 -0400
X-MC-Unique: Wh_6GUvOOySZZtmNlXROOg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74faf5008bbso3890885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 13:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685650322; x=1688242322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH52BVikKcnaVU74ot3GHAVVa3YUi3Nj+bJLSNVnGpE=;
        b=NSUjpUS0c40jr/G5iQWRlo1LyA7UYAzE1XqH+EPZgeNbbd4MwW3FQScwscelDp8Kx7
         7DWH3IH0vJL7nATruzsMhMcy0qdM2uOc5+X/6kZ/9XAJkRrStgI6xpKa3ahx5Hzd3K9L
         C8q2M/I6ObfgAn3t7Tbxfw7Eu3PqjprTtzlS4H0FXTJbm3Y1eplUKISDwidJOn2SpN1k
         nIt4TbK6YgeoHom/1/lZVf0Z90olcZQv9kCYgxuC+unqCOJBG3seECLFs37RDs/XMZGi
         NswSjpW7N4oA1ODbVe2T2B/p0heUD1hUkHLdCk3e8ItO0n7O4pNxnFbcNfdEEUv8g93v
         v5gQ==
X-Gm-Message-State: AC+VfDy3CTfyX1w/Pql6N9JwVCjFphb5WV4WWt+a6QMOhec38/iqSsak
        Iy6DC4ScOAO0QTNKymiLzT1I8REdgdSvlZ0eSDgBUmEpOKBzt5eRZSuOoM6gJQNCkt2w5k/t4kV
        JwbFVu96uJBX5GBL3SVNLu961BA==
X-Received: by 2002:a05:622a:1a88:b0:3f7:f680:c922 with SMTP id s8-20020a05622a1a8800b003f7f680c922mr8739839qtc.6.1685650321872;
        Thu, 01 Jun 2023 13:12:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OfTVISeOqiiBH02lQgPBMM7D4JAZD66lhueZp/1aHJ1mThhbWTlF7toVIXysrHqgK2Sdawg==
X-Received: by 2002:a05:622a:1a88:b0:3f7:f680:c922 with SMTP id s8-20020a05622a1a8800b003f7f680c922mr8739796qtc.6.1685650321514;
        Thu, 01 Jun 2023 13:12:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85152000000b003f6b0562ad7sm8041197qtn.16.2023.06.01.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:12:00 -0700 (PDT)
Date:   Thu, 1 Jun 2023 16:11:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: Re: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZHj7jmJ5fKla1Rax@x1n>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com>
 <ZHfAOAKj1ZQJ+zSy@x1n>
 <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:16:14PM +0500, Muhammad Usama Anjum wrote:
> On 6/1/23 2:46 AM, Peter Xu wrote:
> > Muhammad,
> > 
> > Sorry, I probably can only review the non-interface part, and leave the
> > interface/buffer handling, etc. review for others and real potential users
> > of it..
> Thank you so much for the review. I think mostly we should be okay with
> interface as everybody has been making suggestions over the past revisions.
> 
> > 
> > On Thu, May 25, 2023 at 01:55:14PM +0500, Muhammad Usama Anjum wrote:
> >> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >> +					 unsigned long addr, pte_t *ptep,
> >> +					 pte_t ptent)
> >> +{
> >> +	pte_t old_pte;
> >> +
> >> +	if (!huge_pte_none(ptent)) {
> >> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
> >> +		ptent = huge_pte_mkuffd_wp(old_pte);
> >> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);
> > 
> > huge_ptep_modify_prot_start()?
> Sorry, I didn't realized that huge_ptep_modify_prot_start() is different
> from its pte version.

Here I meant huge_ptep_modify_prot_commit()..

> 
> > 
> > The other thing is what if it's a pte marker already?  What if a hugetlb
> > migration entry?  Please check hugetlb_change_protection().
> I've updated it in more better way. Please let me know what do you think
> about the following:
> 
> static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> 					 unsigned long addr, pte_t *ptep,
> 					 pte_t ptent)
> {
> 	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
> 		return;
> 
> 	if (is_hugetlb_entry_migration(ptent))
> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> 				pte_swp_mkuffd_wp(ptent));
> 	else if (!huge_pte_none(ptent))
> 		ptep_modify_prot_commit(vma, addr, ptep, ptent,
> 					huge_pte_mkuffd_wp(ptent));
> 	else
> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> 				make_pte_marker(PTE_MARKER_UFFD_WP));
> }

the is_pte_marker() check can be extended to double check
pte_marker_uffd_wp() bit, but shouldn't matter a lot since besides the
uffd-wp bit currently we only support swapin error which should sigbus when
accessed, so no point in tracking anyway.

> 
> As we always set UNPOPULATED, so markers are always set on none ptes
> initially. Is it possible that a none pte becomes present, then swapped and
> finally none again? So I'll do the following addition for make_uffd_wp_pte():
> 
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
> vm_area_struct *vma,
>  	} else if (is_swap_pte(ptent)) {
>  		ptent = pte_swp_mkuffd_wp(ptent);
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> +	} else {
> +		set_pte_at(vma->vm_mm, addr, pte,
> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
>  	}
>  }

Makes sense, you can leverage userfaultfd_wp_use_markers() here, and you
should probably keep the protocol (only set the marker when WP_UNPOPULATED
for anon).

> 
> 
> 
> 
> > 
> >> +	} else {
> >> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >> +				make_pte_marker(PTE_MARKER_UFFD_WP));
> >> +	}
> >> +}
> >> +#endif
> > 
> > [...]
> > 
> >> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >> +				  unsigned long end, struct mm_walk *walk)
> >> +{
> >> +	struct pagemap_scan_private *p = walk->private;
> >> +	struct vm_area_struct *vma = walk->vma;
> >> +	unsigned long addr = end;
> >> +	pte_t *pte, *orig_pte;
> >> +	spinlock_t *ptl;
> >> +	bool is_written;
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
> >> +		if (IS_PM_SCAN_GET(p->flags))
> >> +			ret = pagemap_scan_output(is_written, vma->vm_file,
> >> +						  pmd_present(*pmd),
> >> +						  is_swap_pmd(*pmd),
> >> +						  p, start, n_pages);
> >> +
> >> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
> >> +			make_uffd_wp_pmd(vma, addr, pmd);
> >> +
> >> +		if (IS_PM_SCAN_WP(p->flags))
> >> +			flush_tlb_range(vma, start, end);
> >> +
> >> +		spin_unlock(ptl);
> >> +
> >> +		arch_leave_lazy_mmu_mode();
> >> +		return ret;
> >> +	}
> >> +
> >> +process_smaller_pages:
> >> +	if (pmd_trans_unstable(pmd)) {
> >> +		arch_leave_lazy_mmu_mode();
> >> +		return 0;
> > 
> > I'm not sure whether this is right..  Shouldn't you return with -EAGAIN and
> > let the user retry?  Returning 0 means you'll move on with the next pmd
> > afaict and ignoring this one.
> This has come up before. We are just replicating pagemap_pmd_range() here
> as we are doing almost the same thing through IOCTL. It doesn't return any
> error in this case and just skips it. So we are doing the same.

Hmm, is it a bug for pagemap?  pagemapread.buffer should be linear to the
address range to be scanned to me.  If it skips some unstable pmd without
filling in anything it seems everything later will be shifted with
PMD_SIZE..  I had a feeling that it should set walk->action==ACTION_AGAIN
before return.

-- 
Peter Xu

