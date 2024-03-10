Return-Path: <linux-fsdevel+bounces-14084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B228778A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 22:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414051C20FD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8293B2A6;
	Sun, 10 Mar 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEPG2W2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F91EB22;
	Sun, 10 Mar 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710107860; cv=none; b=kq0XIYxZ5bpwWncuNuH+hVcAgZ+4H1CbQ0wK9/eBL94lMWai9ooEaldXWGffTo3v1YV14ssLwa9tltHEFu6HwbnPmdEv0BHICURlpwVBhrprGfkGsDbSJ8DKCltbS2s0W9oHr5D3pV0yB0AcNFcOLsmEQvOVBwZQMnJ3aW2dsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710107860; c=relaxed/simple;
	bh=UuKAE3fq6r+4LIXCVTaVa7ghgZrfPk/16dMZRzjVRs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEbPBaBAsjDI8Nz/PjhZbadnx9m+vOy+pkXjLppolEIg9jn2RhgUi8b4b2gh7EiT3bDDDKVBEcESB7U1dmV0ezppbPCsVFTWq+2Imrlm3gb4ktgLjFbpEkvuuae1aCSFkSp6gU/SzQV6tZvyd7IAbT5h/ROF1irb4mYMGvuYtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEPG2W2b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132a436086so1836545e9.2;
        Sun, 10 Mar 2024 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710107857; x=1710712657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/sYS0NJb4DqNjgdYB+tGj5LpDFuv9Mhfne0wLLGGD4=;
        b=jEPG2W2bP/tw0ls2QJ3IRMp9LBVejV3wwmF092bv1I03g35nqHy0zk5IeSCYvf2WUu
         3f4JvW78wIGd/p4iNrLPJVxy3VElYfD37ds0sr1VL8+GJySTiuT5zOuniyEFbMbbSiDt
         QTG2/JM1k+Sqh10+G6vD51Md451iWq69G4oQwW5DNQ0QwHqlfFCceiTeMrSkZMuiEytv
         qX56nf6gk1m5RbY+MsYZbMyN5ZVFxf6nN6G94APBHTeXSmPXHnh4h4qQ0F7b9vMYsqRw
         lLX3EwORgtfkIrCKUioChflcF8EzH2v68TW2QlDYocgo3Mg8X5Rd3AmvsCeEf5io2hyR
         vfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710107857; x=1710712657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/sYS0NJb4DqNjgdYB+tGj5LpDFuv9Mhfne0wLLGGD4=;
        b=FITyaDrh2nb2zped9HgupaIq+T3E/PGDnxgd59yodnKyv7k36QpTc76uP5rapUL9F4
         4/K3XgT80OjOcimZqvOLxK6ZykHbrtisHNBs/6kl4JSvCrZzEtSpU3ETsz5ofli2UGek
         Tgs00W2ZR/QQLGEtr9/OwS54YNAMGgPfiPRoyCUBZzjwb3rCto5JVw1ITwsLBuCltpE4
         mZ6kyIrcq0suS6lus2di70xyHjohBZO79zz3N6lFx29wRiHqOBmuxBK9bGsFd8yIWGl2
         3fVmtY74QtaP3DsBoQg71xPNCLEFYt/a+bOt/yjawoRJwqAsk9/ZmAjVHqrkK2aklaf+
         +OdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNxitez14uS1sYLLc+9gGx+deSwspNBet5NlG7hTl3g6JQfg9ilhXxRuDPrPKhlFyTKM4KxEhENwjpx7higWBHfBNAsHIJ8s/Fz/dDxoREf06Ijjnuedy1mqq9Mm5sbd5yl49Q+5ga9vwa7SXFM5rswndn1WXjjzUbEgh17Jw/UWMTLqw4tg==
X-Gm-Message-State: AOJu0YxzoqDefXFTG/RcxuORFNZSCzflWXOYUB0nStOYqTMluGZ8bwzM
	4/ScdCg1RzzOsuxGYL3h5Hy+gc0/TpYazM1IciYhn13OwC3Ilb77
X-Google-Smtp-Source: AGHT+IGLPOT973/rTUf1pEj4J67Zt68S7FpNg8KHeXcNkLm8rUad4WXpY2RIHz/ES7oT49cPkJeawQ==
X-Received: by 2002:a05:600c:1987:b0:412:eff3:8497 with SMTP id t7-20020a05600c198700b00412eff38497mr4518127wmq.1.1710107856392;
        Sun, 10 Mar 2024 14:57:36 -0700 (PDT)
Received: from localhost (host86-164-143-89.range86-164.btcentralplus.com. [86.164.143.89])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b00413294ddb72sm1820037wmb.20.2024.03.10.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 14:57:35 -0700 (PDT)
Date: Sun, 10 Mar 2024 21:55:21 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	upstream+pagemap@sigma-star.at, adobriyan@gmail.com,
	wangkefeng.wang@huawei.com, ryan.roberts@arm.com, hughd@google.com,
	peterx@redhat.com, david@redhat.com, avagin@google.com,
	vbabka@suse.cz, akpm@linux-foundation.org,
	usama.anjum@collabora.com, corbet@lwn.net
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Message-ID: <Ze4sSR0DJaR2Hy6v@devil>
References: <20240306232339.29659-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306232339.29659-1-richard@nod.at>

On Thu, Mar 07, 2024 at 12:23:38AM +0100, Richard Weinberger wrote:
> Is a PTE present and writable, bit 58 will be set.
> This allows detecting CoW memory mappings and other mappings
> where a write access will cause a page fault.

I think David has highlighted it elsewhere in the thread, but this
explanation definitely needs bulking up.

Need to emphsaise that we detect cases where a fault will occur (_possibly_
CoW, _possibly_ write notify clean file-backed page, _possibly_ other cases
where we need write fault tracking).

Very important to differentiate between a _page table_ read/write flag
being set and the mapping being read-only, it's a concern that being loose
on this might confuse people somewhat.

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/proc/task_mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..7c7e0e954c02 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1341,6 +1341,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>  #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_WRITE		BIT_ULL(58)

As an extension of the above comment re: confusion, I really dislike
PM_WRITE. Something like PM_PTE_WRITABLE might be better?

>  #define PM_FILE			BIT_ULL(61)
>  #define PM_SWAP			BIT_ULL(62)
>  #define PM_PRESENT		BIT_ULL(63)
> @@ -1417,6 +1418,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pte_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
> +		if (pte_write(pte))
> +			flags |= PM_WRITE;
>  	} else if (is_swap_pte(pte)) {
>  		swp_entry_t entry;
>  		if (pte_swp_soft_dirty(pte))
> @@ -1483,6 +1486,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  				flags |= PM_SOFT_DIRTY;
>  			if (pmd_uffd_wp(pmd))
>  				flags |= PM_UFFD_WP;
> +			if (pmd_write(pmd))
> +				flags |= PM_WRITE;
>  			if (pm->show_pfn)
>  				frame = pmd_pfn(pmd) +
>  					((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -1586,6 +1591,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  		if (huge_pte_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
>
> +		if (pte_write(pte))

This should be huge_pte_write(). It amounts to the same thing, but for
consistency :)

> +			flags |= PM_WRITE;
> +
>  		flags |= PM_PRESENT;
>  		if (pm->show_pfn)
>  			frame = pte_pfn(pte) +
> --
> 2.35.3
>

Overall I _really_ like the idea of exposing this. Not long ago I wanted to
be able to assess whether private mappings were CoW'd or not 'at a glance'
and couldn't find any means of doing this (of course I might have missed
something but I don't think there is anything).

So I think a single bit in /proc/$pid/pagemap is absolutely worthwhile to
get this information.

I'd like to see a non-RFC version submitted :) as discussed on irc,
probably best after merge window!

