Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C891A51FD4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiEIMuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiEIMue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:50:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD11B1775;
        Mon,  9 May 2022 05:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F6831FA1C;
        Mon,  9 May 2022 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652100399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0x8wgLQBpHFv3s+9yud4n2cWzmxWahhDvg3SnX6oVQ=;
        b=VUdQhHq0S8501BxOZWbgEQRfPEYgTHbDOdnXBPSGMPecsLfgaP4flIxKRgwcmGHEqi8tsj
        TWhCrTMFeYjv8GWp8aOIayQ35bDcenQxB0RLRjK5h4k1frgEGQHjtzYUNYSwaP6ziKTYar
        qflbp9wDp3J0Ayp1zD5KxjeDklXyCQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652100399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0x8wgLQBpHFv3s+9yud4n2cWzmxWahhDvg3SnX6oVQ=;
        b=Ina+0o4qL1Cou1dyWm6TaBm/oS07IJYJ6GVkGtSJLujUj9tz9ZlhfsMtVP9C/kzY09lkNh
        +lmDQPlxWia66VDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52584132C0;
        Mon,  9 May 2022 12:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SpnYEi8NeWLxSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 12:46:39 +0000
Message-ID: <6cea8763-1033-0082-7b9a-a63353efa041@suse.cz>
Date:   Mon, 9 May 2022 14:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 3/8] mm: khugepaged: skip DAX vma
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-4-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-4-shy828301@gmail.com>
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
> The DAX vma may be seen by khugepaged when the mm has other khugepaged
> suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
> it will fail due to page sanity check, for example, page is not
> on LRU.
> 
> So it is not harmful, but it is definitely pointless to run khugepaged
> against DAX vma, so skip it in early check.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/khugepaged.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7d197d9e3258..964a4d2c942a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -447,6 +447,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (vm_flags & VM_NO_KHUGEPAGED)
>  		return false;
>  
> +	/* Don't run khugepaged against DAX vma */
> +	if (vma_is_dax(vma))
> +		return false;
> +
>  	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>  				vma->vm_pgoff, HPAGE_PMD_NR))
>  		return false;

