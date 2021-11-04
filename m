Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95394444DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 04:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDDiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 23:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhKDDiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB804C061714;
        Wed,  3 Nov 2021 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0O/VdyfANdJRg4X3F77zWL20vmq21Xlj10FoIbPmDkE=; b=jXZGpKzaK03F2BR+7PinT0OlJM
        ZNizT4HqpvIaU/hRL/n+3hKgQMBVNEyXMcqV1WTcWASGCcrLdsqUoJIWpfdJO+9L5ujPVRT/jUg1p
        Gri+yTKxVjmkfg7SOmKbdctrPULlzYmpxE3gBJ5x8LoN2NQn+j1a4y6spJX7ZNurwOsczJ6hWclXj
        xReNyIJkXWCRsqxcdE8bEpOeAVaWoHqaEJ4xMn4IZLpt6IcgbPseaC//ZTTvFY7We1p50jWd8hO40
        24KTepIf6d0j2PheqbZBHyrcg4Z/KGlRcMQfCGzQqe4XHPB85NYE+SOdcqaYPb6XRI2Z4pzZmeGKR
        N4q4L1PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miTVg-005dkV-Bf; Thu, 04 Nov 2021 03:34:07 +0000
Date:   Thu, 4 Nov 2021 03:33:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYNUoONKjuo6Izfz@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
 <YYKwyudsHOmPthUP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYKwyudsHOmPthUP@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 08:54:50AM -0700, Christoph Hellwig wrote:
> > -	 * Walk through the page to find areas to write back. If we run off the
> > -	 * end of the current map or find the current map invalid, grab a new
> > -	 * one.
> > +	 * Walk through the folio to find areas to write back. If we
> > +	 * run off the end of the current map or find the current map
> > +	 * invalid, grab a new one.
> 
> No real need for reflowing the comment, it still fits just fine even
> with the folio change.

Sure, but I don't like using column 79, unless it's better to.  We're on
three lines anyway; may as well make better use of that third line.

> > +	isize = i_size_read(inode);
> > +	end_pos = page_offset(page) + PAGE_SIZE;
> > +	if (end_pos - 1 >= isize) {
> 
> Wouldn't this check be more obvious as:
> 
> 	if (end_pos > i_size) {

I _think_ we restrict the maximum file size to 2^63 - 1 to avoid i_size
ever being negative.  But that means that end_pos might be 2^63 (ie
LONG_MIN), so we need to subtract one from it to get the right answer.
Maybe worth a comment?
