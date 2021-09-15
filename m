Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67D140C486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhIOLrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhIOLrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:47:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D72C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 04:46:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s12so643012ljg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4uYqvhZeHXv+ssAcqC18NkCUO7S23+uQI3/MrtalBV0=;
        b=jyiV1pAooDObXMWnm3SrBe9VySDlVMgGIdz0ZOAqYFqHTDbGSqfGlclgEpgSJnLk9Q
         DFka1G8+6sSoD3HNSqa0AppZDm2J1kkZRyV+Ekj0m8uHjXRySHiMBmH7WY9nhKnUr/VT
         35oCwlYebNGuHog/4c3gCuRkJXVh/bIk6Tdk5zhvhNarQQSivcYCtFgJSW/Rz12DW7GL
         jUh7hMukNOAQHN5HvXwrMx8rRg97dA6+kwG/LTGpn5AomPepMFIPfwm6cWNOVFkW6QI6
         7bHQrFQgbUXL52514a9fKrhGs8YBnPNc3rmHQ/wM43OJGLye+GKaW5qLT1AkYcVARpnv
         qFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uYqvhZeHXv+ssAcqC18NkCUO7S23+uQI3/MrtalBV0=;
        b=xRrupWmhWL5sdYOYy+0SBbegKrp8Hhs+8ipho+HLM1ZVHKylhDohRBBDifHwdpV3SG
         t9RAOafgTjbIVMqx5yBEqvIMXj+aDiEoHfMGjips4xvYzohD0luFeBGiXIYGBSkmyUCY
         GwJIWCLECQI1XUy/8t3rO99s3PBohYfmyN6AMOdar5bR9dBSP+0O+i7VoZLAXlYW7KS6
         C8Wec5y5N2xQn7La+Z88OzchwQgnQhv7/OIbFYsl7P3+NZ4mchDVrsam61Dz6HCV2Dxq
         SN92V9Djfv+OCulx5cdDW8vLpfaAKfcWzmZ/t3tl1PZYBskd/WvUUF7bVTryKaG7/g/u
         w7aQ==
X-Gm-Message-State: AOAM5329DNjCIphO3SWECnLsjLTuErl0gL7qK0g1d2UyYVoiM/tNOUZb
        Agc1ewaZxhd+0V4Fd1Ki97J+iA==
X-Google-Smtp-Source: ABdhPJwCBpDqQI2MR/6gQuQDuaPc18SeGMEV9d5/MeeH65Opge+QdGLHvzx00+xc1e2k20cqP9RBww==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr20030432ljn.117.1631706370471;
        Wed, 15 Sep 2021 04:46:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y14sm107725lfk.237.2021.09.15.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:46:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 310A7102F4D; Wed, 15 Sep 2021 14:46:13 +0300 (+03)
Date:   Wed, 15 Sep 2021 14:46:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: filemap: check if any subpage is hwpoisoned for
 PMD page fault
Message-ID: <20210915114613.lo26l64iqjz2qo6a@box.shutemov.name>
References: <20210914183718.4236-1-shy828301@gmail.com>
 <20210914183718.4236-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914183718.4236-2-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:15AM -0700, Yang Shi wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index 25fc46e87214..1765bf72ed16 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3920,8 +3920,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (unlikely(!pmd_none(*vmf->pmd)))
>  		goto out;
>  
> -	for (i = 0; i < HPAGE_PMD_NR; i++)
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +		/*
> +		 * Just backoff if any subpage of a THP is corrupted otherwise
> +		 * the corrupted page may mapped by PMD silently to escape the
> +		 * check.  This kind of THP just can be PTE mapped.  Access to
> +		 * the corrupted subpage should trigger SIGBUS as expected.
> +		 */
> +		if (PageHWPoison(page + i))
> +			goto out;
>  		flush_icache_page(vma, page + i);
> +	}

This is somewhat costly.

flush_icache_page() is empty on most archs so compiler makes the loop go
away before the change. Also page->flags for most of the pages will not
necessary be hot.

I wounder if we should consider making PG_hwpoison to cover full compound
page. On marking page hwpoison we try to split it and mark relevant base
page, if split fails -- mark full compound page.

As alternative we can have one more flag that indicates that the compound
page contains at least one hwpoisoned base page. We should have enough
space in the first tail page.

-- 
 Kirill A. Shutemov
