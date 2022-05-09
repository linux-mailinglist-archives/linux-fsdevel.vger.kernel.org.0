Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E55520138
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiEIPfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiEIPfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 11:35:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97AB1BA8DD;
        Mon,  9 May 2022 08:31:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4D501F8BF;
        Mon,  9 May 2022 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652110268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igEnia1tol6glVUoyn10KI3rw75C75d7JZ9YLtfjPjQ=;
        b=QHi7ODxi6sV1GnUBYfFXpN2LvnelDKO8MGmi0P2SP2UFND2Q4G97+JRiqAebDgCb4+aqSG
        EWJSGCuJCIMLtHmTx64+lwvi9vT0XlsqQ0eIhMq/cRCjEn1kj5MEktxbt1RjshrgFWViZr
        yJaMVoje7iD7w5OJ/kDRGbmPDVu3UE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652110268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igEnia1tol6glVUoyn10KI3rw75C75d7JZ9YLtfjPjQ=;
        b=9pGE77TIQOxARadLqLQXaLJUtFIWzEX+aLRKug6Hh28AJdm02uCApsyISgCTm9HTepwYbS
        DExFi3yQkApP2kCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 637EA132C0;
        Mon,  9 May 2022 15:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hJaRF7wzeWIsHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 15:31:08 +0000
Message-ID: <f304299d-e533-ed18-e247-6dec928ce3b0@suse.cz>
Date:   Mon, 9 May 2022 17:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-7-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [v3 PATCH 6/8] mm: khugepaged: move some khugepaged_* functions
 to khugepaged.c
In-Reply-To: <20220404200250.321455-7-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/22 22:02, Yang Shi wrote:
> To reuse hugepage_vma_check() for khugepaged_enter() so that we could
> remove some duplicate code.  But moving hugepage_vma_check() to
> khugepaged.h needs to include huge_mm.h in it, it seems not optimal to
> bloat khugepaged.h.
> 
> And the khugepaged_* functions actually are wrappers for some non-inline
> functions, so it seems the benefits are not too much to keep them inline.
> 
> So move the khugepaged_* functions to khugepaged.c, any callers just
> need to include khugepaged.h which is quite small.  For example, the
> following patches will call khugepaged_enter() in filemap page fault path
> for regular filesystems to make readonly FS THP collapse more consistent.
> The  filemap.c just needs to include khugepaged.h.

This last part is inaccurate in v3?

> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

I think moving the tiny wrappers is unnecessary.

How about just making hugepage_vma_check() not static and declare it in
khugepaged.h, then it can be used from khugepaged_enter() in the same file
and AFAICS no need to include huge_mm.h there?

> ---
>  include/linux/khugepaged.h | 37 ++++++-------------------------------
>  mm/khugepaged.c            | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 0423d3619f26..6acf9701151e 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -2,10 +2,6 @@
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
>  
> -#include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
> -#include <linux/shmem_fs.h>
> -
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern struct attribute_group khugepaged_attr_group;
>  
> @@ -16,6 +12,12 @@ extern void __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  				       unsigned long vm_flags);
> +extern void khugepaged_fork(struct mm_struct *mm,
> +			    struct mm_struct *oldmm);
> +extern void khugepaged_exit(struct mm_struct *mm);
> +extern void khugepaged_enter(struct vm_area_struct *vma,
> +			     unsigned long vm_flags);
> +
>  extern void khugepaged_min_free_kbytes_update(void);
>  #ifdef CONFIG_SHMEM
>  extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
> @@ -33,36 +35,9 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>  #define khugepaged_always()				\
>  	(transparent_hugepage_flags &			\
>  	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
> -#define khugepaged_req_madv()					\
> -	(transparent_hugepage_flags &				\
> -	 (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
>  #define khugepaged_defrag()					\
>  	(transparent_hugepage_flags &				\
>  	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
> -
> -static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> -{
> -	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> -		__khugepaged_enter(mm);
> -}
> -
> -static inline void khugepaged_exit(struct mm_struct *mm)
> -{
> -	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> -		__khugepaged_exit(mm);
> -}
> -
> -static inline void khugepaged_enter(struct vm_area_struct *vma,
> -				   unsigned long vm_flags)
> -{
> -	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
> -		if ((khugepaged_always() ||
> -		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
> -		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
> -		    !(vm_flags & VM_NOHUGEPAGE) &&
> -		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -			__khugepaged_enter(vma->vm_mm);
> -}
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b69eda934d70..ec5b0a691d87 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -556,6 +556,26 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	}
>  }
>  
> +void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> +		__khugepaged_enter(mm);
> +}
> +
> +void khugepaged_exit(struct mm_struct *mm)
> +{
> +	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> +		__khugepaged_exit(mm);
> +}
> +
> +void khugepaged_enter(struct vm_area_struct *vma, unsigned long vm_flags)
> +{
> +	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> +	    khugepaged_enabled())
> +		if (hugepage_vma_check(vma, vm_flags))
> +			__khugepaged_enter(vma->vm_mm);
> +}
> +
>  static void release_pte_page(struct page *page)
>  {
>  	mod_node_page_state(page_pgdat(page),

