Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5651FD5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiEIMte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiEIMtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:49:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E66470;
        Mon,  9 May 2022 05:45:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAE8721C65;
        Mon,  9 May 2022 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652100336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxdYBcICunTkdG1/SZy4Mj77Rlogz32NSC76mGFVEuo=;
        b=iMTlcR04lrEe/o6Q6GDqButIw/r/mlL+DMSlNj5I9j6b+FcSPexC4ruBKvBIjvxKwVcu7S
        ijowgiRz4Gc01ky8uLa++hu1nSKJSAMb3UGqcUXUUaHF4jziLT7gE/2rQ11PVoZyVEvhrR
        uP+cL+/wtRcez0uK+7liJZeajl7Ztx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652100336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxdYBcICunTkdG1/SZy4Mj77Rlogz32NSC76mGFVEuo=;
        b=6hO/yfUcvh0nQ/dTGt+CWenpMLD7fCl43zeVFALAfN+lai6gjRMhNr6v7EV6mIepa6+c00
        aiF+MgOuPDRgD2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83176132C0;
        Mon,  9 May 2022 12:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ujZhH/AMeWJuSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 12:45:36 +0000
Message-ID: <389399bd-cf9f-4d6a-76fb-1fea1c05171e@suse.cz>
Date:   Mon, 9 May 2022 14:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 2/8] mm: khugepaged: remove redundant check for
 VM_NO_KHUGEPAGED
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-3-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-3-shy828301@gmail.com>
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
> The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
> check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
> in hugepage_vma_check() up.
> 
> More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
> definitely not a hot path, so cleaner code does outweigh.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/khugepaged.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a4e5eaf3eb01..7d197d9e3258 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -365,8 +365,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
>  		 * register it here without waiting a page fault that
>  		 * may not happen any time soon.
>  		 */
> -		if (!(*vm_flags & VM_NO_KHUGEPAGED) &&
> -				khugepaged_enter_vma_merge(vma, *vm_flags))
> +		if (khugepaged_enter_vma_merge(vma, *vm_flags))
>  			return -ENOMEM;
>  		break;
>  	case MADV_NOHUGEPAGE:
> @@ -445,6 +444,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (!transhuge_vma_enabled(vma, vm_flags))
>  		return false;
>  
> +	if (vm_flags & VM_NO_KHUGEPAGED)
> +		return false;
> +
>  	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>  				vma->vm_pgoff, HPAGE_PMD_NR))
>  		return false;
> @@ -470,7 +472,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  		return false;
>  	if (vma_is_temporary_stack(vma))
>  		return false;
> -	return !(vm_flags & VM_NO_KHUGEPAGED);
> +
> +	return true;
>  }
>  
>  int __khugepaged_enter(struct mm_struct *mm)

