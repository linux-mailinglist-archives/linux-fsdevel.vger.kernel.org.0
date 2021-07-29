Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27103DA476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhG2Njy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhG2Njx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:39:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD06C061765;
        Thu, 29 Jul 2021 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMa0YczQh56TUFbbWyxfwHlTTQoGvHMpB6e+MNq/9K8=; b=h8kgfYDQp0cFRzhl/YiMK30XSA
        lVZ+YcItMsqqARcnt2J+RhnPymwOokLRVAoDXRA0M9jE8EDxAdanXojxuRYWNQOfhE0r7Bo8IQsnb
        AO10KyccKR6Rg+SS3J1I5tMCmWGG+rndlxRvMEmYL+nv5K/GckQRl7/QMgy3PFZoykbA25Kv1TP1Z
        zubzdQj3sKFAU/4EK3HYkeNxXivYGSP2kIbz0LFp9Vd/es6yxNAIvE+aF43C4Orp4RazGboKjbux7
        sjCKJcsCAPrEsbAiQRY9aYOBv2KzpHkObKUN2SwYkwwjPNC2Zx+iuqGRrU4xh5tkuvvNPM/DSarnr
        pCXwDj6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m96Fa-00H7Ct-5C; Thu, 29 Jul 2021 13:39:16 +0000
Date:   Thu, 29 Jul 2021 14:39:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 049/138] mm/memcg: Add folio_lruvec_relock_irq() and
 folio_lruvec_relock_irqsave()
Message-ID: <YQKvdvzBhuCg2O52@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-50-willy@infradead.org>
 <20210729083644.GD3809@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729083644.GD3809@techsingularity.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 09:36:44AM +0100, Mel Gorman wrote:
> On Thu, Jul 15, 2021 at 04:35:35AM +0100, Matthew Wilcox (Oracle) wrote:
> > These are the folio equivalents of relock_page_lruvec_irq() and
> > folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
> > to folio_matches_lruvec().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> When build testing what you had in your for-next branch, I got a new
> warning for powerpc defconfig
> 
>  In file included from ./include/linux/mmzone.h:8,
>                   from ./include/linux/gfp.h:6,
>                   from ./include/linux/mm.h:10,
>                   from mm/swap.c:17:
>  mm/swap.c: In function 'release_pages':
>  ./include/linux/spinlock.h:290:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    290 |   _raw_spin_unlock_irqrestore(lock, flags); \
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>  mm/swap.c:906:16: note: 'flags' was declared here
>    906 |  unsigned long flags;
>        |                ^~~~~
> 
> I'm fairly sure it's a false positive and the compiler just cannot figure
> out that flags are only accessed when lruvec is !NULL and once lruvec is
> !NULL, flags are valid

Yes, I read it over carefully and I can't see a way in which this
can happen.  Weird that this change made the compiler unable to figure
that out.  Pushed out a new for-next with your patch included.  Thanks!

