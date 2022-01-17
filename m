Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE82C490C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiAQQF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiAQQF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:05:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1050C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 08:05:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu18so36395588lfb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/8mQ26icbv/X+xjUK5EuBssp15+UZVQvU7z9wm1s+VU=;
        b=y4LkLPToOBlnbqiNxg1SV3Wm0LkYQ8dPL0Om/Ts1G+wBefAKhwPikq/43UY0lvLLNL
         rIdV9JOcimmlKBcILN79asMQZi/OiRzQMtJoObAK7oHSxobLDIo54TibCvHxFhYSF/Iw
         /qPaLSlaA1bYt6dPXmXeTjOS1mMf9WWMRnu0gR/8f4t+Ljohx+TY1slEyXgQen02xjBn
         oSAVwIbPKXQyfEI7rgsxzEl4bETkrAonlGn2vXAE7FQBVj1Fce35F6ZYJ2rK0eNjrobr
         4LpDVGWgoSO5yeWGPf1r3PrmcnZJJTpZdvrKQRZbRoEvWAJBbiD1odsV1cRn6NBDJZjb
         GHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8mQ26icbv/X+xjUK5EuBssp15+UZVQvU7z9wm1s+VU=;
        b=LPzSI9MBP7cxrVDhopW+wwBKKtAF9q9NGYOwSvPL+5J6Lbgdj5HdHp2Msq9CjHjFO3
         Op0sy3I7SAhREVad+DXJACWifCI0FJrsAru6rsLQNolEXgaAZCFTq+IhL02+mNDwKQfa
         /iBhSzXkPgYacEv/8rC8pg/0YA26tMt+QmoNMJ1L6prb8k9QGBRFKK/1qlxttR2CFRML
         k2ryQVZgmKm8wd41ddvpicoChvucUYxDZjp86NOseR1ojNX1ZF3jCLQ6a0UAfaydDCOY
         azP3V9E/Oyzhl8UAIXsAYY7eEzAA4xB4LMI9fyQlixw59zOatrSYpzarpdTXv9CoR4Hn
         qUcg==
X-Gm-Message-State: AOAM532czEYr32EgBuEAyhyjxnXvIUr5G3w0YviHoVksuIE565PIHJSa
        H4mv24QTBJywVP73MMz7rCW+RfFXoBq33Q==
X-Google-Smtp-Source: ABdhPJyzoqLDfFVobgvsBI+4cTEP0RjqyjuLETC90ErunX0xTAUNCEvDAu4Yeu5iaQ3hp2lqQtJ0FQ==
X-Received: by 2002:a05:6512:3a96:: with SMTP id q22mr12143245lfu.14.1642435557024;
        Mon, 17 Jan 2022 08:05:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q9sm1154818lfd.266.2022.01.17.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:05:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1C34D10387E; Mon, 17 Jan 2022 19:06:25 +0300 (+03)
Date:   Mon, 17 Jan 2022 19:06:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm/vmscan: Free non-shmem folios without splitting
 them
Message-ID: <20220117160625.oofpzl7tqm5udwaj@box.shutemov.name>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116121822.1727633-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 16, 2022 at 12:18:14PM +0000, Matthew Wilcox (Oracle) wrote:
> We have to allocate memory in order to split a file-backed folio, so
> it's not a good idea to split them in the memory freeing path.

Could elaborate on why split a file-backed folio requires memory
allocation?

> It also
> doesn't work for XFS because pages have an extra reference count from
> page_has_private() and split_huge_page() expects that reference to have
> already been removed.

Need to adjust can_split_huge_page()?

> Unfortunately, we still have to split shmem THPs
> because we can't handle swapping out an entire THP yet.

... especially if the system doesn't have swap :P

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 700434db5735..45665874082d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1728,8 +1728,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  				/* Adding to swap updated mapping */
>  				mapping = page_mapping(page);
>  			}
> -		} else if (unlikely(PageTransHuge(page))) {
> -			/* Split file THP */
> +		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
> +			/* Split shmem THP */
>  			if (split_huge_page_to_list(page, page_list))
>  				goto keep_locked;
>  		}
> -- 
> 2.34.1
> 

-- 
 Kirill A. Shutemov
