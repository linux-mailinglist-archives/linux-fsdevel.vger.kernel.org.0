Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D496E15078C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBCNkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 08:40:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40838 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCNkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:40:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so9724517lfi.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IepX5s8KFLsk6M2RacMY6MKMLoWf8Qm8TUZ7wknCHKI=;
        b=V+4u5+sRDRa4EXjyU6EXahB5/qcJ4orECk73ouG9low9d6PwUnRJjR9NJhHEjTQYSc
         Kui3JUb7FZskaS0to2XNB5M99d9ceo1Gi5bFsK18GYn0BH9bFlJUjtvPnfiIKpv3JjPG
         GN2O+dt4wtxSRQgVtfXBVB8anFatg0XNmKR3XbgBZDKcI4KWyRsggZdCxKAEP7fLCJnJ
         w+lL+mLBi8v46+BSbg8YNQm0rtBn8AvvKMx26WBH8gGzdgfGQpnmd9SEeyJL4Y7qD2NP
         UHIX453KVTaaxcLGS1d/BQFylt143bcU6bmZEiglXvs0oQ2BwBpYMi+F3sDDFSv4qlp9
         ++ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IepX5s8KFLsk6M2RacMY6MKMLoWf8Qm8TUZ7wknCHKI=;
        b=bmvMasePQvUrF4dCCLrSF6NA3cQ5MuaiUrd3GqKe3XuMlHesoB/sqT5MmlOa7hnqoc
         m8GhIVC78Q/9AJpnrfXNFfHwLMryf00bq4TQcvlPPaYuaGVJNCMKJo56WvAN3q+6W3RZ
         6Z1acAPElkIUJARvfdCNz4yaHoKidb+t98RSSF1BVGXTiCahXI90R9isL4Qpbdf4GH1p
         wpb/+6KTwjb3sXP+XVcE6nSe24Z6hZlyiNgd4H6M+g8tFIHrPl9+OfMi9WgTQT82VIkH
         r6bkhz5gToew5fh/2zXTRyVRPTOT3weRIVVjD7w0OeybBq1os24i+ca0vheJ73dfFoHM
         r94g==
X-Gm-Message-State: APjAAAXobZTmKl5xVluu6KIShzVUfY1LjPJZdJla4xr/iaFG2HyBPz5P
        DhrbKVefB5OaYgOdJ11gFXiA/g==
X-Google-Smtp-Source: APXvYqy1bsDNFhPqOt4MsuS/yl5Hsf7q101c7952EIchzIfLZ702j/lDwPX7Jz7ekEA66zEPoq/Ulg==
X-Received: by 2002:ac2:58cf:: with SMTP id u15mr12097728lfo.62.1580737212908;
        Mon, 03 Feb 2020 05:40:12 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m13sm9054940lfo.40.2020.02.03.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:40:11 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A03D9100DC8; Mon,  3 Feb 2020 16:40:24 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:40:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 07/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200203134024.htczuqghduajb3yx@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-8-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:24PM -0800, John Hubbard wrote:
> @@ -4405,7 +4392,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  same_page:
>  		if (pages) {
>  			pages[i] = mem_map_offset(page, pfn_offset);
> -			get_page(pages[i]);
> +			if (!try_grab_page(pages[i], flags)) {
> +				spin_unlock(ptl);
> +				remainder = 0;
> +				err = -ENOMEM;
> +				WARN_ON_ONCE(1);

The WARN_ON_ONCE deserve a comment. And I guess you can put it into 'if'
condition.

> +				break;
> +			}
>  		}
>  
>  		if (vmas)
> @@ -4965,6 +4958,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	struct page *page = NULL;
>  	spinlock_t *ptl;
>  	pte_t pte;
> +
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> +			 (FOLL_PIN | FOLL_GET)))
> +		return NULL;
> +
>  retry:
>  	ptl = pmd_lockptr(mm, pmd);
>  	spin_lock(ptl);
> @@ -4977,8 +4976,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	pte = huge_ptep_get((pte_t *)pmd);
>  	if (pte_present(pte)) {
>  		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
> -		if (flags & FOLL_GET)
> -			get_page(page);
> +		if (unlikely(!try_grab_page(page, flags))) {
> +			WARN_ON_ONCE(1);

Ditto.

> +			page = NULL;
> +			goto out;
> +		}
>  	} else {
>  		if (is_hugetlb_entry_migration(pte)) {
>  			spin_unlock(ptl);

-- 
 Kirill A. Shutemov
