Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F13B1531
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFWH7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 03:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhFWH7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC2C061574;
        Wed, 23 Jun 2021 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+OQaTCtEgpBJhCqlBrl3HbRrw7HuZwYB4kM2GJKONbs=; b=nMa818gtVWtDVsd/dXVU++T/gl
        jEUbEmhJbYtMDObHDkCHRIwSwMp+Voj62CrPKj5L4FbC48XuzJu+oHQpzJ60khhhZuWpbfPLH7mIE
        pjHQtCaKlMAIk1A+o/sFBxDdYZLYJSVOOd19wsb8VxZH8LZTlwSwWRgEgMBJOpHU+gEKQQpTLrPKg
        D9UcTlqJn/Hr5M06OgQA2AVj/+XVvsz04X9cOH6yPh/6I9XTyEYjCQaqolsrz/PhaN2bB5QTk6ClP
        nG3ezdUPC5uLnvixhH03ehA6XAgvJhGo7ewlwtjj+L3yPLj74ZGAyjrkwxV75TN5Mz8gDnJAlRnyO
        txYemL4Q==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxkp-00FBKv-H8; Wed, 23 Jun 2021 07:57:03 +0000
Date:   Wed, 23 Jun 2021 09:56:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/46] mm: Add folio_rmapping()
Message-ID: <YNLpStcUTkcHG0R9@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline void *folio_rmapping(struct folio *folio)

This name, just like the old one is not exaclty descriptive.  I guess the
r stands for raw somehow?  As a casual contributor to the fringes of the
MM I would have no idea when to use it.

All this of course also applies to the existing (__)page_rmapping, but
maybe this is a good time to sort it out.

>  
>  struct anon_vma *page_anon_vma(struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
> +	unsigned long mapping = (unsigned long)folio->mapping;
>  
>  	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>  		return NULL;
> +	return folio_rmapping(folio);

It feelds kinda silly to not just open code folio_rmapping here
given that we alredy went half the way. 
