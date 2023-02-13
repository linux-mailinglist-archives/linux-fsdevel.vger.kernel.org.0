Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DD695350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 22:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjBMVnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 16:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBMVnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3C2108
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676324532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAOGrIHROVWBHfLS+YnDTuX5cvviqED0/XTEnbV1xpM=;
        b=Vmv7aEzNdB3sQi8WiLqLcWYPsLH2+YfDmD4rQk6QYBfhLapFgAN+KlF0cFBLj2IeArw/CM
        oADzrjgRIfrlxC77MZdPdpOYUcvgmOb2oWt29kguOkbNXCXoLiveb1Mg5SzK88Xq251TFy
        apmrBIzWsfeyH0PGClScvr4V7Eho0Y0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-sSsLOavTN8yOh6gObXF2BA-1; Mon, 13 Feb 2023 16:42:11 -0500
X-MC-Unique: sSsLOavTN8yOh6gObXF2BA-1
Received: by mail-qt1-f198.google.com with SMTP id j26-20020ac84c9a000000b003b9b7c60108so8229902qtv.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 13:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAOGrIHROVWBHfLS+YnDTuX5cvviqED0/XTEnbV1xpM=;
        b=Ds2qILF6+6HEHr5DG/BIvUkFJKrr3DcvhH9/c0vcfDb6mrjyKYPG6oKPRBf9wByWnV
         X9r0sLucjSvIExQVS5RLzICHSYTzIasUKW+tAtkmmXK7sbNnmskINrqVPwxRfnKLtWH6
         WjqyWOwccwy50GRJjMrsX0ilmEZ9KjQQYklIZHuNVp1SwMIWxjxHpXZuhwYa7AH3trB7
         GPTyCRudnr+CIJ0diLyzlY+6hTTxQIhZZg1kQWBd7F23eRtgCT2/g4HihhIF7S+K7jrb
         UDcEQYf/rSUAxdaGg0owpxho56TnnBIe0ATHeWlYv/hQvH+Sm5h/6RkUjyrLowKyqj4l
         S4Kg==
X-Gm-Message-State: AO0yUKWWWSx97njOpuLCtj0KeSX3VHJOhd7scQoZUVG3sgnBvlfuC9tL
        NOaRY5m+hy90ORaxbdn9j0rmJ1qQFEQJJMbPFZELAA9qbETtYg37LEPMqOyMJAYUl4GLemI9dCp
        YE86QTRFm1Dlb8adhlDlh9QRYkg==
X-Received: by 2002:a05:622a:1981:b0:3b8:695b:aad1 with SMTP id u1-20020a05622a198100b003b8695baad1mr50949958qtc.1.1676324530534;
        Mon, 13 Feb 2023 13:42:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9ssAPziIyB06p9/jd1fNqwXmEFiJFS1F+WtS7txqSELl2uM/hTDGmdTMxbgS3uqtH//pGScQ==
X-Received: by 2002:a05:622a:1981:b0:3b8:695b:aad1 with SMTP id u1-20020a05622a198100b003b8695baad1mr50949888qtc.1.1676324530159;
        Mon, 13 Feb 2023 13:42:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id p6-20020ac84086000000b003b9a573aec6sm10026617qtl.70.2023.02.13.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:42:09 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:42:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y+qur8iIUQTLyE8f@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <Y+QfDN4Y5Q10x8GQ@x1n>
 <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:55:19PM +0500, Muhammad Usama Anjum wrote:
> On 2/9/23 3:15 AM, Peter Xu wrote:
> > On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
> >> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> >> the info about page table entries. The following operations are supported
> >> in this ioctl:
> >> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
> >>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
> >>   (PAGE_IS_SWAPPED).
> >> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
> >>   pages have been written-to.
> >> - Find pages which have been written-to and write protect the pages
> >>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
> >>
> >> To get information about which pages have been written-to and/or write
> >> protect the pages, following must be performed first in order:
> >> - The userfaultfd file descriptor is created with userfaultfd syscall.
> >> - The UFFD_FEATURE_WP_ASYNC feature is set by UFFDIO_API IOCTL.
> >> - The memory range is registered with UFFDIO_REGISTER_MODE_WP mode
> >>   through UFFDIO_REGISTER IOCTL.
> >> Then the any part of the registered memory or the whole memory region
> >> can be write protected using the UFFDIO_WRITEPROTECT IOCTL or
> >> PAGEMAP_SCAN IOCTL.
> >>
> >> struct pagemap_scan_args is used as the argument of the IOCTL. In this
> >> struct:
> >> - The range is specified through start and len.
> >> - The output buffer of struct page_region array and size is specified as
> >>   vec and vec_len.
> >> - The optional maximum requested pages are specified in the max_pages.
> >> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
> >>   is the only added flag at this time.
> >> - The masks are specified in required_mask, anyof_mask, excluded_ mask
> >>   and return_mask.
> >>
> >> This IOCTL can be extended to get information about more PTE bits. This
> >> IOCTL doesn't support hugetlbs at the moment. No information about
> >> hugetlb can be obtained. This patch has evolved from a basic patch from
> >> Gabriel Krisman Bertazi.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Changes in v10:
> >> - move changes in tools/include/uapi/linux/fs.h to separate patch
> >> - update commit message
> >>
> >> Change in v8:
> >> - Correct is_pte_uffd_wp()
> >> - Improve readability and error checks
> >> - Remove some un-needed code
> >>
> >> Changes in v7:
> >> - Rebase on top of latest next
> >> - Fix some corner cases
> >> - Base soft-dirty on the uffd wp async
> >> - Update the terminologies
> >> - Optimize the memory usage inside the ioctl
> >>
> >> Changes in v6:
> >> - Rename variables and update comments
> >> - Make IOCTL independent of soft_dirty config
> >> - Change masks and bitmap type to _u64
> >> - Improve code quality
> >>
> >> Changes in v5:
> >> - Remove tlb flushing even for clear operation
> >>
> >> Changes in v4:
> >> - Update the interface and implementation
> >>
> >> Changes in v3:
> >> - Tighten the user-kernel interface by using explicit types and add more
> >>   error checking
> >>
> >> Changes in v2:
> >> - Convert the interface from syscall to ioctl
> >> - Remove pidfd support as it doesn't make sense in ioctl
> >> ---
> >>  fs/proc/task_mmu.c      | 290 ++++++++++++++++++++++++++++++++++++++++
> >>  include/uapi/linux/fs.h |  50 +++++++
> >>  2 files changed, 340 insertions(+)
> >>
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index e35a0398db63..c6bde19d63d9 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -19,6 +19,7 @@
> >>  #include <linux/shmem_fs.h>
> >>  #include <linux/uaccess.h>
> >>  #include <linux/pkeys.h>
> >> +#include <linux/minmax.h>
> >>  
> >>  #include <asm/elf.h>
> >>  #include <asm/tlb.h>
> >> @@ -1135,6 +1136,22 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >>  }
> >>  #endif
> >>  
> >> +static inline bool is_pte_uffd_wp(pte_t pte)
> >> +{
> >> +	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
> >> +	    (pte_swp_uffd_wp_any(pte)))
> >> +		return true;
> >> +	return false;
> > 
> > Sorry I should have mentioned this earlier: you can directly return here.
> No problem at all. I'm replacing these two helper functions with following
> in next version so that !present pages don't show as dirty:
> 
> static inline bool is_pte_written(pte_t pte)
> {
> 	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
> 	    (pte_swp_uffd_wp_any(pte)))
> 		return false;
> 	return (pte_present(pte) || is_swap_pte(pte));
> }

Could you explain why you don't want to return dirty for !present?  A page
can be written then swapped out.  Don't you want to know that happened
(from dirty tracking POV)?

The code looks weird to me too..  We only have three types of ptes: (1)
present, (2) swap, (3) none.

Then, "(pte_present() || is_swap_pte())" is the same as !pte_none().  Is
that what you're really looking for?

> 
> static inline bool is_pmd_written(pmd_t pmd)
> {
> 	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
> 	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
> 		return false;
> 	return (pmd_present(pmd) || is_swap_pmd(pmd));
> }

[...]

> >> +	bitmap = cur & p->return_mask;
> >> +	if (cpy && bitmap) {
> >> +		if ((prev->len) && (prev->bitmap == bitmap) &&
> >> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
> >> +			prev->len += len;
> >> +			p->found_pages += len;
> >> +		} else if (p->vec_index < p->vec_len) {
> >> +			if (prev->len) {
> >> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
> >> +				p->vec_index++;
> >> +			}
> > 
> > IIUC you can have:
> > 
> >   int pagemap_scan_deposit(p)
> >   {
> >         if (p->vec_index >= p->vec_len)
> >                 return -ENOSPC;
> > 
> >         if (p->prev->len) {
> >                 memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
> >                 p->vec_index++;
> >         }
> > 
> >         return 0;
> >   }
> > 
> > Then call it here.  I think it can also be called below to replace
> > export_prev_to_out().
> No this isn't possible. We fill up prev until the next range doesn't merge
> with it. At that point, we put prev into the output buffer and new range is
> put into prev. Now that we have shifted to smaller page walks of <= 512
> entries. We want to visit all ranges before finally putting the prev to
> output. Sorry to have this some what complex method. The problem is that we
> want to merge the consective matching regions into one entry in the output.
> So to achieve this among multiple different page walks, the prev is being used.
> 
> Lets suppose we want to visit memory from 0x7FFF00000000 to 7FFF00400000
> having length of 1024 pages and all of the memory has been written.
> walk_page_range() will be called 2 times. In the first call, prev will be
> set having length of 512. In second call, prev will be updated to 1024 as
> the previous range stored in prev could be extended. After this, the prev
> will be stored to the user output buffer consuming only 1 struct of page_range.
> 
> If we store prev back to output memory in every walk_page_range() call, we
> wouldn't get 1 struct of page_range with length 1024. Instead we would get
> 2 elements of page_range structs with half the length.

I didn't mean to merge PREV for each pgtable walk.  What I meant is I think
with such a pagemap_scan_deposit() you can rewrite it as:

if (cpy && bitmap) {
        if ((prev->len) && (prev->bitmap == bitmap) &&
            (prev->start + prev->len * PAGE_SIZE == addr)) {
                prev->len += len;
                p->found_pages += len;
        } else {
                if (pagemap_scan_deposit(p))
                        return -ENOSPC;
                prev->start = addr;
                prev->len = len;
                prev->bitmap = bitmap;
                p->found_pages += len;
        }
}

Then you can reuse pagemap_scan_deposit() when before returning to
userspace, just to flush PREV to p->vec properly in a single helper.
It also makes the code slightly easier to read.

-- 
Peter Xu

