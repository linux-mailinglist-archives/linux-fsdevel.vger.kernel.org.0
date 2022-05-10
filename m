Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0390522616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEJVFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiEJVFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 17:05:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96AD193CE;
        Tue, 10 May 2022 14:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88466B81D0E;
        Tue, 10 May 2022 21:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9051EC385C8;
        Tue, 10 May 2022 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652216747;
        bh=HK/U9ZnYCVJJhfgJnWA8+Meia8HhzwzQcw7dOhhRSYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BrzDyZjB5HvQ/Lev6VHmoi8QLWXi1sqqO2eCbz1H5Kb/qtiFlZDGpbFcNkpBziSTz
         7vVlUcChs1pklgTI5UQYb7AYjsQHAMwYL2sB+rbc7eWN8ewEIN+i3NnQYGyG322tXw
         ESstyyt9vP8bP9xx1HH3klVgQidq1/dDTNdIilH4=
Date:   Tue, 10 May 2022 14:05:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 6/8] mm: khugepaged: make hugepage_vma_check()
 non-static
Message-Id: <20220510140545.5dd9d3145b53cb7e226c236a@linux-foundation.org>
In-Reply-To: <20220510203222.24246-7-shy828301@gmail.com>
References: <20220510203222.24246-1-shy828301@gmail.com>
        <20220510203222.24246-7-shy828301@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 13:32:20 -0700 Yang Shi <shy828301@gmail.com> wrote:

> The hugepage_vma_check() could be reused by khugepaged_enter() and
> khugepaged_enter_vma_merge(), but it is static in khugepaged.c.
> Make it non-static and declare it in khugepaged.h.
> 
> ..
>
> @@ -508,20 +508,13 @@ void __khugepaged_enter(struct mm_struct *mm)
>  void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  			       unsigned long vm_flags)
>  {
> -	unsigned long hstart, hend;
> -
> -	/*
> -	 * khugepaged only supports read-only files for non-shmem files.
> -	 * khugepaged does not yet work on special mappings. And
> -	 * file-private shmem THP is not supported.
> -	 */
> -	if (!hugepage_vma_check(vma, vm_flags))
> -		return;
> -
> -	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -	hend = vma->vm_end & HPAGE_PMD_MASK;
> -	if (hstart < hend)
> -		khugepaged_enter(vma, vm_flags);
> +	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> +	    khugepaged_enabled() &&
> +	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> +	     (vma->vm_end & HPAGE_PMD_MASK))) {

Reviewing these bounds-checking tests is so hard :(  Can we simplify?

> +		if (hugepage_vma_check(vma, vm_flags))
> +			__khugepaged_enter(vma->vm_mm);
> +	}
>  }

void khugepaged_enter_vma(struct vm_area_struct *vma,
			  unsigned long vm_flags)
{
	if (test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
		return;
	if (!khugepaged_enabled())
		return;
	if (round_up(vma->vm_start, HPAGE_PMD_SIZE) >=
			(vma->vm_end & HPAGE_PMD_MASK))
		return;		/* vma is too small */
	if (!hugepage_vma_check(vma, vm_flags))
		return;
	__khugepaged_enter(vma->vm_mm);
}


Also, it might be slightly faster to have checked MMF_VM_HUGEPAGE
before khugepaged_enabled(), but it looks odd.  And it might be slower,
too - more pointer chasing.

I wish someone would document hugepage_vma_check().
