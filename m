Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2135FDC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 00:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDNW0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhDNW0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:26:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEEC061574;
        Wed, 14 Apr 2021 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YiOL9jltx8hWLyf7dWkxtJsgoWejWnWYchqK0vvrqoA=; b=niVPtyphxeL57ZxgfJ39HRyuGs
        XYPIvhHywyY4rAtyEoilkvq7Pd+GLrL4IW4dnRBGc2kXYze+UIO4qbzdzjCotxaNVzDFBIvZT0mNR
        pHNtYlwFzzj9ZDwKsVTj+Mpcr1YFyNJLPkzCTvFF67KAAY/Ko4XwbzKIz6IB7H/w+ruCnj/iOWjd0
        cDi5t3yf1R6NuHJBD7ikRSh03hwO37o8io4IX2z0uVics/W2Q6qkohvSKqDnpl0eCJfmveRhWNA8s
        biN+Lg5I+jLkq7WOtCHYTNhf6pP9zjZUDnWGpJrXpvOUWBniEcwEj+SFB33qHfTnXXSWiK9nwgdnF
        QugXG4pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWnwx-007i93-2r; Wed, 14 Apr 2021 22:25:37 +0000
Date:   Wed, 14 Apr 2021 23:25:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210414222531.GZ2531743@casper.infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210414000113.GG63242@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414000113.GG63242@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:01:13AM +1000, Dave Chinner wrote:
> > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > +		if (!down_read_trylock(&mapping->host->i_mapping_sem))
> > +			return -EAGAIN;
> > +	} else {
> > +		down_read(&mapping->host->i_mapping_sem);
> > +	}
> 
> We really need a lock primitive for this. The number of times this
> exact lock pattern is being replicated all through the IO path is
> getting out of hand.
> 
> static inline bool
> down_read_try_or_lock(struct rwsem *sem, bool try)
> {
> 	if (try) {
> 		if (!down_read_trylock(sem))
> 			return false;
> 	} else {
> 		down_read(&mapping->host->i_mapping_sem);
> 	}
> 	return true;
> }
> 
> and the callers become:
> 
> 	if (!down_read_try_or_lock(sem, (iocb->ki_flags & IOCB_NOWAIT)))
> 		return -EAGAIN;

I think that should be written:

	if (!iocb_read_lock(iocb, &rwsem))
		return -EAGAIN;

and implemented as:

static inline int iocb_read_lock(struct kiocb *iocb, struct rwsem *sem)
{
	if (iocb->ki_flags & IOCB_NOWAIT)
		return down_read_trylock(sem) ? 0 : -EAGAIN;
	return down_read_killable(sem);
}

