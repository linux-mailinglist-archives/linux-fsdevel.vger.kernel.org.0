Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5103CF8B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhGTKhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGTKg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:36:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5CC061574;
        Tue, 20 Jul 2021 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4FkZvqXeAIk4BuCEW9n8PvCXADxw3t7wT89TribEmJ4=; b=dGlxFd7VdA60iqtsgKTmLNv6gL
        zuMCMdEGLQhXpslEtymGFCdaZSQ+RefhzQqO+vUjOMjCU+EhnKhnxiQdm8sCEMIK9YfIe80VY89eQ
        mk4wGqYpWRryKk9cIT46Jld57JGhixwB1Q4yeSzwgzt7eQdChsS80zxItJTM4LCtJBHtMQIJxbC6g
        GwNR7KGWmNytX6w85Gokb7aq1KbwHrcDdxkX1JZljXMuLomALqJZtOkyPy1+o4hVCnpgdL+MwbTyb
        DiOZzif46Sd1RS2ObzKCdaBp9XEIN4eS+DqLdrs81vTXrZJ4y5MxyObgnL1XuVmqfVfP8F6RLPs7H
        egrYC1zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5nk5-0082bU-1k; Tue, 20 Jul 2021 11:17:03 +0000
Date:   Tue, 20 Jul 2021 12:16:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <YPawpW8LgXDJZ5Gd@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
 <YPZwODMq1ilIeS4t@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZwODMq1ilIeS4t@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 07:42:00AM +0100, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 07:39:45PM +0100, Matthew Wilcox (Oracle) wrote:
> > +/**
> > + * bio_add_folio - Attempt to add part of a folio to a bio.
> > + * @bio: Bio to add to.
> > + * @folio: Folio to add.
> > + * @len: How many bytes from the folio to add.
> > + * @off: First byte in this folio to add.
> > + *
> > + * Always uses the head page of the folio in the bio.  If a submitter only
> > + * uses bio_add_folio(), it can count on never seeing tail pages in the
> > + * completion routine.  BIOs do not support folios that are 4GiB or larger.
> > + *
> > + * Return: The number of bytes from this folio added to the bio.
> > + */
> > +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> > +		size_t off)
> > +{
> > +	if (len > UINT_MAX || off > UINT_MAX)
> > +		return 0;
> > +	return bio_add_page(bio, &folio->page, len, off);
> > +}
> 
> I'd use the opportunity to switch to a true/false return instead of
> the length.  This has been on my todo list for bio_add_page for a while,
> so it might make sense to start out the new API the right way.

ok.
