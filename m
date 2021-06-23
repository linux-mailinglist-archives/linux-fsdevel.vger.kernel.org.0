Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30FC3B15ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWIev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFWIes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:34:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C4C061574;
        Wed, 23 Jun 2021 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uFTLW672bofdyyCUC+kpReSvJ9Bf3gAmm8nrB57bytM=; b=fqSQD0S3B5vfbzsMCcNPEfzIiX
        gzynJBMHZaU6xIuYlUYrLbAOM1+5Sj8QpPm8jpzTRFnG/P4+gSEpsnVNf9u6Lbynex0f/phw0W95D
        7P3kiiCIJmggNmJcqkMcc91G4b0qrPHpH1NX95dbHk37eCOX+MmVQrq7LWl2d56n01Rpf87vy3VUy
        8MkKahVrwbZC2V7bbxWBVXFU5MO9vJ2J0WkPw+s2sVSuQ24/nW9U5lg5x8bRZeWlseHrmetvhpteO
        YzprYTZvN4YG5sws09gMuZVoG9daafKLOQj0AYnkXrt1Dti0TLqJPV7OOwC/BaieA+tZ6tCcQpqL5
        NV1Y7KnQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyHm-00FDIG-S6; Wed, 23 Jun 2021 08:31:27 +0000
Date:   Wed, 23 Jun 2021 10:28:52 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/46] mm/migrate: Add folio_migrate_flags()
Message-ID: <YNLwxF1T+wAQ+1em@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	/*
>  	 * Please do not reorder this without considering how mm/ksm.c's
>  	 * get_ksm_page() depends upon ksm_migrate_page() and PageSwapCache().
>  	 */
> -	if (PageSwapCache(page))
> -		ClearPageSwapCache(page);
> -	ClearPagePrivate(page);
> -	set_page_private(page, 0);
> +	if (folio_swapcache(folio))
> +		folio_clear_swapcache_flag(folio);
> +	folio_clear_private_flag(folio);
> +
> +	/* page->private contains hugetlb specific flags */
> +	if (!folio_hugetlb(folio))
> +		folio->private = NULL;

Ymmm. Dosn't the ->private handling change now?  Given that you
added a comment it seems intentional, but I do not understand why
it changes as part of the conversion.
