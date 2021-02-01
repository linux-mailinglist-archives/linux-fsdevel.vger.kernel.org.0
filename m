Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49030A850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBANIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 08:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBANIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:08:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0FC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 05:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=51py4ue/uyvut4ghefoSnJTTzyjQ8OBkV1F56BiYdYc=; b=twS9A2oBHZ9wXiqTEfEMaOVjbt
        h0Isu5mVmIjb1ux5zuBFAEcmDWcCRMx+aKfVQwzAjPDMepjcNH94o2Yn4yvZ9m1DuhMVFMPXpGkHY
        6XeyfGLoiBp4XEs2LKFhMKAIwU3nEZtS9F0Q9SvS5HTorCeUVQiSV2RgeyMlIoRJBFuBZW9B5GYc8
        73zVaA/L8LNZSxO2A6U8kcJjXU9X7f+TAQHaRrLQ5XK8obSgx4Gkb8GsyS4y88RpqTiwctp12fckk
        8Y7ieCTJJnobVpOjLppEFWBJwZF5aY031YJAd//d71cpeZyhRU9lowd8N+Z1j+wJMBbrJHvKpgyE3
        /C1VxLpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6Yvw-00DnWV-Pe; Mon, 01 Feb 2021 13:08:06 +0000
Date:   Mon, 1 Feb 2021 13:08:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] implement orangefs_readahead
Message-ID: <20210201130800.GP308988@casper.infradead.org>
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 31, 2021 at 05:25:02PM -0500, Mike Marshall wrote:
> I wish I knew how to specify _nr_pages in the readahead_control
> structure so that all the extra pages I need could be obtained
> in readahead_page instead of part there and the rest in my
> open-coded stuff in orangefs_readpage. But it looks to me as
> if values in the readahead_control structure are set heuristically
> outside of my control over in ondemand_readahead?

That's right (for now).  I pointed you at some code from Dave Howells
that will allow orangefs to enlarge the readahead window beyond that
determined by the core code's algorithms.

> [root@vm3 linux]# git diff master..readahead
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 48f0547d4850..682a968cb82a 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -244,6 +244,25 @@ static int orangefs_writepages(struct
> address_space *mapping,
> 
>  static int orangefs_launder_page(struct page *);
> 
> +/*
> + * Prefill the page cache with some pages that we're probably
> + * about to need...
> + */
> +static void orangefs_readahead(struct readahead_control *rac)
> +{
> +       pgoff_t index = readahead_index(rac);
> +       struct page *page;
> +
> +       while ((page = readahead_page(rac))) {
> +               prefetchw(&page->flags);
> +               put_page(page);
> +               unlock_page(page);
> +               index++;
> +       }
> +
> +       return;
> +}

This is not the way to do it.  You need to actually kick off readahead in
this routine so that you get pipelining (ie the app is working on pages
0-15 at the same time the server is getting you pages 16-31).  I don't
see much support in orangefs for doing async operations; everything
seems to be modelled on "submit an I/O and wait for it to complete".

I'm happy to help out with pagecache interactions, but adding async
support to orangefs is a little bigger task than I'm willing to put
significant effort into right now.
