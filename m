Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E33CB0E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhGPC7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 22:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhGPC7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:59:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916BAC06175F;
        Thu, 15 Jul 2021 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mq3wTgxZEH4QjjVWOJ11+pesVGFg8c21USpyyqDfH2c=; b=US/J81dKvyj3XraQz7j/+lGQ4Z
        cTeopUgtkoIGZ2vozywVhGZjGkmPudXnlTVoT5F/+KDreUWuz0vTUa30IPEpKlPCLBy4n+qh3Qlzk
        jmDWlcYNDNpsytiPJahTck5WFxpluOYgE8N8TNMBq0nIPyki3s/GD2pCY4rAAqlBQBoMmExKUGeno
        oU2dJtqFJsod9rHDEMbNBWMV9CC8MqLWd21ONFlMki2uWn+Cb0N2NuWeP6PJRzLThxRKzAoJXeijZ
        Ny1rZx+F07h/ZHRIUxaOkh+5zYAnNvSnIJoaoZ9qHQ1Uc1+q0sW55SR5IN8yRG0WKW9QCptCAoFTo
        XX1kZukA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4E0y-0045Gl-CZ; Fri, 16 Jul 2021 02:55:57 +0000
Date:   Fri, 16 Jul 2021 03:55:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 105/138] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <YPD1NLkRo0dneNii@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-106-willy@infradead.org>
 <20210715220120.GP22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715220120.GP22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:01:20PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:31AM +0100, Matthew Wilcox (Oracle) wrote:
> >  
> > -	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
> > -			&same_page);
> >  	if (iop)
> >  		atomic_add(len, &iop->write_bytes_pending);
> > -
> > -	if (!merged) {
> > -		if (bio_full(wpc->ioend->io_bio, len)) {
> > -			wpc->ioend->io_bio =
> > -				iomap_chain_bio(wpc->ioend->io_bio);
> > -		}
> > -		bio_add_page(wpc->ioend->io_bio, page, len, poff);
> > +	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
> > +		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> > +		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
> 
> The paranoiac in me wonders if we ought to have some sort of error
> checking here just in case we encounter double failures?

Maybe?  We didn't have it before, and it's just been allocated.
I'd defer to Christoph here.

> > -	for (i = 0, file_offset = page_offset(page);
> > -	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
> > -	     i++, file_offset += len) {
> > +	for (i = 0; i < nblocks; i++, pos += len) {
> > +		if (pos >= end_offset)
> > +			break;
> 
> Any particular reason this isn't:
> 
> 	for (i = 0; i < nblocks && pos < end_offset; i++, pos += len) {
> 
> ?

Just mild personal preference ... I don't even like having the pos +=
len in there.  But you're maintainer, I'll shuffle that in.

> Everything from here on out looks decent to me.

Thanks!
