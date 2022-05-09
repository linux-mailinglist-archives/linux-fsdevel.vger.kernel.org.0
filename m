Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432051FEA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiEINpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiEINps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:45:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F4266F3B;
        Mon,  9 May 2022 06:41:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9D931FA1C;
        Mon,  9 May 2022 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652103710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfOG4fwQgTRRj2kX8pkQg/MOpU6dqmaf9sAeliZmAQQ=;
        b=rtSSdHeaa1fgmjnNpGkiS8oo2HQvxGapIEmADJOx5w0txnOIuq1LLu9QFvQJeu4864KscP
        g+7AOUK/LBnuXNGTa6x7+TRvcymIy4jZC6iEaxHJ2hZErHC2WfgqyoLR6JOFxAkngSlkrR
        MtOGJPjSCT3R9ZZ/n+49wI0T4ibivTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652103710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfOG4fwQgTRRj2kX8pkQg/MOpU6dqmaf9sAeliZmAQQ=;
        b=4mqCcf8Hw84hqfRyIujWoHZvmZaUb8edP3V++8klyRswcFwFQaM55aTs3ZXM2y1NZDoYxn
        lEEAFOcwLEOyiNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C5F913AA5;
        Mon,  9 May 2022 13:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RyBdIR4aeWJ7ZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 13:41:50 +0000
Message-ID: <05e816e9-255c-7180-7335-09f09c24859e@suse.cz>
Date:   Mon, 9 May 2022 15:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 4/8] mm: thp: only regular file could be THP eligible
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-5-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-5-shy828301@gmail.com>
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
> Since commit a4aeaa06d45e ("mm: khugepaged: skip huge page collapse for
> special files"), khugepaged just collapses THP for regular file which is
> the intended usecase for readonly fs THP.  Only show regular file as THP
> eligible accordingly.
> 
> And make file_thp_enabled() available for khugepaged too in order to remove
> duplicate code.
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/huge_mm.h | 14 ++++++++++++++
>  mm/huge_memory.c        | 11 ++---------
>  mm/khugepaged.c         |  9 ++-------
>  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2999190adc22..62a6f667850d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -172,6 +172,20 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +static inline bool file_thp_enabled(struct vm_area_struct *vma)
> +{
> +	struct inode *inode;
> +
> +	if (!vma->vm_file)
> +		return false;
> +
> +	inode = vma->vm_file->f_inode;
> +
> +	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
> +	       (vma->vm_flags & VM_EXEC) &&
> +	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> +}
> +
>  bool transparent_hugepage_active(struct vm_area_struct *vma);
>  
>  #define transparent_hugepage_use_zero_page()				\
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2fe38212e07c..183b793fd28e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -68,13 +68,6 @@ static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  
> -static inline bool file_thp_enabled(struct vm_area_struct *vma)
> -{
> -	return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
> -	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
> -	       (vma->vm_flags & VM_EXEC);
> -}
> -
>  bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>  	/* The addr is used to check if the vma size fits */
> @@ -86,8 +79,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
>  		return __transparent_hugepage_enabled(vma);
>  	if (vma_is_shmem(vma))
>  		return shmem_huge_enabled(vma);
> -	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
> -		return file_thp_enabled(vma);
> +	if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
> +		return true;
>  
>  	return false;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 964a4d2c942a..609c1bc0a027 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -464,13 +464,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  		return false;
>  
>  	/* Only regular file is valid */
> -	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> -	    (vm_flags & VM_EXEC)) {
> -		struct inode *inode = vma->vm_file->f_inode;
> -
> -		return !inode_is_open_for_write(inode) &&
> -			S_ISREG(inode->i_mode);
> -	}
> +	if (file_thp_enabled(vma))
> +		return true;
>  
>  	if (!vma->anon_vma || vma->vm_ops)
>  		return false;

