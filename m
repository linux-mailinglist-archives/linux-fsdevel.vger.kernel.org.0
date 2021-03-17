Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2833F6BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCQR0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCQR01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:26:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F3C06174A;
        Wed, 17 Mar 2021 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NkSmKyFybGGzBQdftefvTyk7NOmR2MT0T3BIdH4UDpI=; b=eBVh1/xeK05SwdJk3+2gDrxqy8
        XSOIv2sdLpv+73MDj4McoTRij3ie+opRU/PmaYdY1xhICqTjEcxFOD+M5BWIh4I9ja1M+HOatORJx
        uXBuhgp8pSXEJ66Ajq8nBcvZIiA92XLion+5AIdVVO3KA7iO6pm3FltJQzPu1Ew/aj8Dg6RvbMD2y
        2YHxOIsCzcg5nJ0Di0t9g/J51pJSL0ZJUtVW50RIdYzSNWKDW20KKXGq7i6D8ZwLCKzyGNKRxqqEB
        8qbhUNHIqUN4ynv+DusmpwZPdhU6PupJPSLh23GCp9lp4zOWHXMFIgc+eC3mRiSAlaBSiDfwwe1Ch
        kK4CMZPQ==;
Received: from [2001:4bb8:18c:bb3:e3eb:4a4b:ba2f:224b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZvr-001uZ9-TX; Wed, 17 Mar 2021 17:26:10 +0000
Date:   Wed, 17 Mar 2021 18:26:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 10/25] mm/util: Add folio_mapping and
 folio_file_mapping
Message-ID: <YFI7r+YdgdALlewB@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +struct address_space *page_mapping(struct page *);
> +struct address_space *folio_mapping(struct folio *);
> +struct address_space *__folio_file_mapping(struct folio *);
> +
> +static inline struct address_space *folio_file_mapping(struct folio *folio)
> +{
> +	if (unlikely(FolioSwapCache(folio)))
> +		return __folio_file_mapping(folio);

I think __folio_file_mapping is badly misnamed as it only deals with
swapcache folios.  Maybe that should be reflected in the name?

Also for all these funtions documentation would be very helpful, even if
the existing struct page based helpers don't have that either.
