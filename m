Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC21DEDFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgEVRPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 13:15:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D10C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:15:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so13504428ljm.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LeM7Gq/64MBHuEtg64n+BDtuTe/p5r/j1B2qVESr88E=;
        b=mzImS0TXTReSbMWpKcN1vkGpQ8SxUQVlDXsSh5HVc1hcwKMdu0GyRSaaa1fjOZZg5w
         TYmnJWbzYA+tDj+BcEsstIh66E6fqB5G5HryQJ6z7d59+nQB0xJzryWAH6LOaYNns8PO
         apeKxryZKUtVIEan1sWKPlWKzpGsi2AUtgEog6KIyVcKIbaWzM5sPuRtlxSHRpNtX+Na
         yLLkSuXv2v+pjLciZ5I5sWVkK9soA7BPwe1PhsmkeVxUIki42sCR6lb/hFeSSv+90ADg
         rA6cSV/csy7SBjFRwRHZ0OhpPNoFjWgUxDASmpLSFSiXtbxfQcPp7ghcLQIU8tzKWtW3
         OlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LeM7Gq/64MBHuEtg64n+BDtuTe/p5r/j1B2qVESr88E=;
        b=WU53wWnJZgAW2DdGX/26dVliZoSSD25exeqsXhu07jNeJBFExaGjilTREtQon+s39l
         r+R+IEK3jiBgyRe4G/T4nnJiEv5Hy9b++1tHhWh172TkQeirRWexNFeZY5wQrGBFsKHJ
         WFNYerUg2CZvKoWfZaJqP+Ls9DRs8ezwAAk6EOAcCByB75omiCPC+ZtFCznC0oUP5j9z
         QElDRfqgqSJ8AT+WK1GHnFPYOV8Hl5FclQ1EuOKMf3/rAsqTlY3Ma/XipVsYYJvRpfok
         onhs7F21w9TBfpntv+Keo9NxY68PUH86lPIjxyxFPrGp6CJN8maHZXwe/8wT0X5ImbVi
         Yw2g==
X-Gm-Message-State: AOAM530oOelkL3xAuzlLGzsX5mht7t5jYMu4eQsbaC3I08OV6VwmaMX9
        nK/vxnRNI+Xo4QUTtVP7ImPWgg==
X-Google-Smtp-Source: ABdhPJxXaqF0fu43lDvtFcjLrw4+SKMwMnQWIDz3RTTU/jBzSj7pSYbO0YuYEhqLNbO542TDkT2n6w==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr6187412ljp.347.1590167716344;
        Fri, 22 May 2020 10:15:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z13sm2539557lfd.7.2020.05.22.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:15:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DA192102046; Fri, 22 May 2020 20:15:17 +0300 (+03)
Date:   Fri, 22 May 2020 20:15:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/36] mm: Introduce offset_in_thp
Message-ID: <20200522171517.dltsre7vfdvcrd2m@box>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-7-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:26AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Mirroring offset_in_page(), this gives you the offset within this
> particular page, no matter what size page it is.  It optimises down
> to offset_in_page() if CONFIG_TRANSPARENT_HUGEPAGE is not set.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 088acbda722d..9a55dce6a535 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1577,6 +1577,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
>  extern void pagefault_out_of_memory(void);
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> +#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))

Looks like thp_mask() would be handy here.

-- 
 Kirill A. Shutemov
