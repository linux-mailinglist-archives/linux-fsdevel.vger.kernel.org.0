Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD97490083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiAQDSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 22:18:00 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45337 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbiAQDR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:17:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V1zqFQx_1642389476;
Received: from 30.240.98.42(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0V1zqFQx_1642389476)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 11:17:57 +0800
Message-ID: <d4ac99a0-6c45-e81b-c08a-56083c4cdd6e@linux.alibaba.com>
Date:   Mon, 17 Jan 2022 11:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:96.0)
 Gecko/20100101 Thunderbird/96.0
Subject: Re: [PATCH 09/12] mm/readahead: Align file mappings for non-DAX
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-10-willy@infradead.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20220116121822.1727633-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/16/22 8:18 PM, Matthew Wilcox (Oracle) wrote:
> From: William Kucharski <william.kucharski@oracle.com>
> 
> When we have the opportunity to use PMDs to map a file, we want to follow
> the same rules as DAX.
> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/huge_memory.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f58524394dc1..28c29a0d854b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -582,13 +582,10 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>   	unsigned long ret;
>   	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>   
> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> -		goto out;
> -
>   	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
>   	if (ret)
>   		return ret;
> -out:
> +
>   	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
Hi, Matthew

It seems this patch will make all file mappings align with PMD_SIZE? And 
support realize all file THP, not only executable file THP?

Actually, what I want to say is we had merged a similar patch to only 
align DSO mapping in glibc:

"718fdd8 elf: Properly align PT_LOAD segments [BZ #28676]"


>   }
>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
