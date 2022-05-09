Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62802520157
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiEIPrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 11:47:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963241B5F97;
        Mon,  9 May 2022 08:43:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5125D21C54;
        Mon,  9 May 2022 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652111008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8T6pl1iznxs13Ey9cez14qQxbbfQ6jd4EKhTAHfONQ=;
        b=OIX4wvitWGHcNBQ8JmpcU3rPsZU1gR6+LHcNOwZdDXt/ctTFk3ovA/alCFpxrJgZHkU0jO
        j8H8ca2us26w1OtLpELOr66VCMVrsGfD9mSVAmr9PH2eHNxXsyMiymy4TEEYmN0veUZ4rO
        jmPneqJd3q3wmPSpiG3aBLWFqPbxo1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652111008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8T6pl1iznxs13Ey9cez14qQxbbfQ6jd4EKhTAHfONQ=;
        b=jK3ZXCl1D7XaTIz1+9uo9WVUNqIOJAFF6WB0oqleV2JaHMus92O7168s829hFh2XwbYV9M
        8GbAzUyq/BtpAbBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 245CD13AA5;
        Mon,  9 May 2022 15:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b11GCKA2eWJIIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 15:43:28 +0000
Message-ID: <0d8f368a-54bb-b4e7-931f-9bf3ae24af4c@suse.cz>
Date:   Mon, 9 May 2022 17:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 8/8] mm: mmap: register suitable readonly file vmas for
 khugepaged
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-9-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-9-shy828301@gmail.com>
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
> The readonly FS THP relies on khugepaged to collapse THP for suitable
> vmas.  But it is kind of "random luck" for khugepaged to see the
> readonly FS vmas (https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
> since currently the vmas are registered to khugepaged when:
>   - Anon huge pmd page fault
>   - VMA merge
>   - MADV_HUGEPAGE
>   - Shmem mmap
> 
> If the above conditions are not met, even though khugepaged is enabled
> it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> explicitly to tell khugepaged to collapse this area, but when khugepaged
> mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> is not set.
> 
> So make sure readonly FS vmas are registered to khugepaged to make the
> behavior more consistent.
> 
> Registering suitable vmas in common mmap path, that could cover both
> readonly FS vmas and shmem vmas, so removed the khugepaged calls in
> shmem.c.
> 
> Still need to keep the khugepaged call in vma_merge() since vma_merge()
> is called in a lot of places, for example, madvise, mprotect, etc.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c  | 6 ++++++
>  mm/shmem.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 604c8dece5dd..616ebbc2d052 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1842,6 +1842,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>  
>  	vma_link(mm, vma, prev, rb_link, rb_parent);
> +
> +	/*
> +	 * vma_merge() calls khugepaged_enter_vma() either, the below
> +	 * call covers the non-merge case.
> +	 */
> +	khugepaged_enter_vma(vma, vma->vm_flags);
>  	/* Once vma denies write, undo our temporary denial count */
>  unmap_writable:
>  	if (file && vm_flags & VM_SHARED)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 92eca974771d..0c448080d210 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -34,7 +34,6 @@
>  #include <linux/export.h>
>  #include <linux/swap.h>
>  #include <linux/uio.h>
> -#include <linux/khugepaged.h>
>  #include <linux/hugetlb.h>
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
> @@ -2239,7 +2238,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  	file_accessed(file);
>  	vma->vm_ops = &shmem_vm_ops;
> -	khugepaged_enter_vma(vma, vma->vm_flags);
>  	return 0;
>  }
>  
> @@ -4132,8 +4130,6 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>  	vma->vm_file = file;
>  	vma->vm_ops = &shmem_vm_ops;
>  
> -	khugepaged_enter_vma(vma, vma->vm_flags);
> -
>  	return 0;
>  }
>  

