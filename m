Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA184964BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381782AbiAUSGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 13:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbiAUSGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:06:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE7C06173B;
        Fri, 21 Jan 2022 10:06:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id h7so2243952ejf.1;
        Fri, 21 Jan 2022 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HB00Dk4BxVgWeQmFduo2LILaD1FFGYAEdZ3PebPBEBw=;
        b=btFmWrH/V9v5abyka+eab1Rs3zrpPn0nci4AUiouqLNDpjw/NkYUFUhvw773WCVIAk
         xVmqjmn/xkl65jW4CpvfWhM1dxlKUEOH+mZCaCYyhd3lampu7yFeaohMhgJxOLABmYK2
         0sgxwzihFGSQPijTrND8NtNoGE8QvLZsgDbb2u0jCFaiMSvU8eaXk992+0Fs/m8gK2i+
         dW9hP3ZqPsSXfA2BbKSsAN3XxXk1xRi2PsGpzdmTfbm/tAAg4TFXNNL6U3UECgd/ag2J
         5N6t40/gB1LtQRaV0K3wOggY/uAWuhlL/2gu3bKqYOK3tbn4edp4axjVfBashkqM4zQI
         xYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB00Dk4BxVgWeQmFduo2LILaD1FFGYAEdZ3PebPBEBw=;
        b=aJwjgfhuIcKYYqsAE2Hg+KPN4ocLmK4hyijj0FRxSsEcSS9g3bdLTEqec9Y5/NC+5I
         PfR5zwrrvjhCQADjeg0f32mVABF/br5Vk7SFkBU5t6kDVpp5F6kccMQs8D0xtjbeyYA1
         aFOfkk9/ZJiZjp9Set2lyFV6nPs4cnuCgj8SMX+8I2xBxy3k6Xc5In4nUQOUGDYtF0t/
         zuciEhwR1HT+bh4/dDsbp/zRt9bu3FzpUZdCg74I/G6y+iXfjuoZNqTRFDGkjR96oBtv
         RqFqizlRhripbWsTMy1U6J8PuZpJFs6a7Zgk+Hh3xSRdkbsyxpneZ2mdnuNcUt3oQcqP
         /xIA==
X-Gm-Message-State: AOAM532MNSiq9gaeMlvD1wDJwv9vUVuNMktOzvhjAHjWXBNNKGqTwkv/
        hJfAY2CGMMbtvU5CjISk2zwaGR3JJQsHzQYb48o=
X-Google-Smtp-Source: ABdhPJx/A/eFYcqDd4G5OcIvASWaZyYXtR3rIaew10BEAtQbSwm0/TspzVHpdvckLjatHTglZw4oLp9D9/+CH3DiukM=
X-Received: by 2002:a17:907:94c9:: with SMTP id dn9mr4119453ejc.270.1642788363547;
 Fri, 21 Jan 2022 10:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20220121075515.79311-1-songmuchun@bytedance.com>
In-Reply-To: <20220121075515.79311-1-songmuchun@bytedance.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Jan 2022 10:05:51 -0800
Message-ID: <CAHbLzkqzu+20TJc8RGDDCyDaFmG+Q7xjkVgpJF5-uPqubMN2HA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: rmap: fix cache flush on THP pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zwisler@kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:56 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> However, it does not cover the full pages in a THP except a head page.
> Replace it with flush_cache_range() to fix this issue. At least, no
> problems were found due to this. Maybe because the architectures that
> have virtual indexed caches is less.

Yeah, actually flush_cache_page()/flush_cache_range() are no-op for
the most architectures which have THP supported, i.e. x86, aarch64,
powerpc, etc.

And currently just tmpfs and read-only files support PMD-mapped THP,
but both don't have to do writeback. And it seems DAX doesn't have
writeback either, which uses __set_page_dirty_no_writeback() for
set_page_dirty. So this code should never be called IIUC.

But anyway your fix looks correct to me. Reviewed-by: Yang Shi
<shy828301@gmail.com>

>
> Fixes: f27176cfc363 ("mm: convert page_mkclean_one() to use page_vma_mapped_walk()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b0fd9dc19eba..65670cb805d6 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -974,7 +974,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>                         if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
>                                 continue;
>
> -                       flush_cache_page(vma, address, page_to_pfn(page));
> +                       flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>                         entry = pmdp_invalidate(vma, address, pmd);
>                         entry = pmd_wrprotect(entry);
>                         entry = pmd_mkclean(entry);
> --
> 2.11.0
>
