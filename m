Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4684EC319E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJAKjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 06:39:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42986 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfJAKjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:39:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so11399709ede.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zf2gaKJ/eDzPQzImElJSNiNa4nWg1/5YZ90uH/NU1NQ=;
        b=v/xy58ndNDY5VCkPAXKs2/P4zolClIIif+c8A3NnFM74/7ovBrnAMaUtpO7Wln9Wcq
         ny6QHj81q70g43LJBlyxGHqpnQ+V0BNbijiFXPrMEJqHJQVXNyvOaqcw925Bf0Fc//Hc
         QpsnPQgZhtLqztAvrLQTotgoVrX3r8QHXm3j9PYOprZpEDq1iLNLCvJf5CGj6WSkCXSS
         WVEB3UdrCMQTkfM8/OTyEg8G6KqzlSxOVMa2G7X4yLPRQfAiV5NounZGcMJcjgbClgde
         zeem/9i2rgBW2PjrqmK7/N70sOZH4LGFdvSkJwoueMn8CkIPberk8jw7O7S4ez2Mctac
         tGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zf2gaKJ/eDzPQzImElJSNiNa4nWg1/5YZ90uH/NU1NQ=;
        b=DRywi598SzS3hyfusq7kH70RvqiJDnqXVDyVkmDDIYeooNvysv6YT4+VyKWKJJX9nV
         b2QAAb/eGcEn6w0IaHcqTWhhRV0ZFM7ubrE0zdemTInU04+ZImHSBW3Up61F3pwUqBbW
         F7uOLdxiKrYCry51voQOT86wLnOrMcM0+oCQ9lRrIg0FrxCZbhFChT33ghKVp1njh/jr
         rUDmxkxlMmHDQPDDB79EE75o/VSgcsP9XajCG/8znZgTVg0lz8lDdTT2h9RwJxn704nF
         o4bstIosM0pv9mRt83iiLPfQJCJD4dnORkMh1BLBz0krQPqhG5BlybtCwP2Ra95FfGVE
         lT3w==
X-Gm-Message-State: APjAAAVktalsKIGnMft9l80st5GDq5Xwss/0A7YrAtxv6b5GQkiui0Fj
        K9uGO0HkMYcNVCqeWA8l+T+M5mt4ugw=
X-Google-Smtp-Source: APXvYqy2QolsgNzGnwwkDTLzzKTYfeuu0xP8JusSUnA1oUajUjhhsEMDK7MHjuhIdfj3+Q8Sbo1KeQ==
X-Received: by 2002:aa7:c34b:: with SMTP id j11mr24782763edr.245.1569926379081;
        Tue, 01 Oct 2019 03:39:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v8sm3058924edi.49.2019.10.01.03.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:39:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0E58E102FB8; Tue,  1 Oct 2019 13:39:39 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:39:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 12/15] mm: Support removing arbitrary sized pages from
 mapping
Message-ID: <20191001103939.gglcqk2gzezkrpnc@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-13-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:11PM -0700, Matthew Wilcox wrote:
> From: William Kucharski <william.kucharski@oracle.com>
> 
> __remove_mapping() assumes that pages can only be either base pages
> or HPAGE_PMD_SIZE.  Ask the page what size it is.

You also fixes the issue CONFIG_READ_ONLY_THP_FOR_FS=y with this patch.
The new feature makes the refcount calculation relevant not only for
PageSwapCache(). It should go to v5.4.

> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> ---
>  mm/vmscan.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a7f9f379e523..9f44868e640b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  	 * Note that if SetPageDirty is always performed via set_page_dirty,
>  	 * and thus under the i_pages lock, then this ordering is not required.
>  	 */
> -	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
> -		refcount = 1 + HPAGE_PMD_NR;
> -	else
> -		refcount = 2;
> +	refcount = 1 + compound_nr(page);
>  	if (!page_ref_freeze(page, refcount))
>  		goto cannot_free;
>  	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
> -- 
> 2.23.0
> 
> 

-- 
 Kirill A. Shutemov
