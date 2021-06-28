Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA683B592B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhF1GiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1Gh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:37:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E3C061574;
        Sun, 27 Jun 2021 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8O1gYnNGbTtfvr0xBpn9cMvKiMrqp+DD2LjyIwlVHU=; b=EZ2tqzN0BRMpZbbINUkrW8Sf7L
        9i9w/XLGD/NyUslJ3ytbhc1NX1MX95KJkhKFXXjiM4PKvM8MgqN6FTT0MAP8bGhxK/XPIHaeYhMHO
        WJwKsI+S8PG9nyo19SSxntu5Kdg9FNga8H/PAVlpxQak2OI2b0y87m8lVsLJDtSwF/1ta20O6V64h
        w8OVMs6oARgEdnsPSUD6imvql8jUynp7iS2z7szNU70zj69lh+8Eo2PRX2a3AEkHUGjrqAQhAhkSx
        lBem3AVl6AyL+KKqc9UkIYBaaQ5km+kZw9l/hKBrP45VWG6M3pPfBbUPyRVd2+CyJHuCv+KMqDkOV
        lGJeZdFg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkpQ-002f3T-Jn; Mon, 28 Jun 2021 06:33:20 +0000
Date:   Mon, 28 Jun 2021 07:33:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/46] mm/writeback: Add __folio_end_writeback()
Message-ID: <YNltJOhAGT1M2G8R@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-25-willy@infradead.org>
 <YNL7yxWFqlL7/Fd+@infradead.org>
 <YNTM3P/lem6P8ie/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTM3P/lem6P8ie/@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 07:20:12PM +0100, Matthew Wilcox wrote:
> > While this looks good, I think the whole abstraction is wrong.  I think
> > test_clear_page_writeback should just be merged into it's only caller.
> 
> I'm not opposed to doing that, but something else has to get
> un-static'ed in order to make that happen.
> 
> folio_end_writeback (exported, filemap.c)
>  -> folio_wake (static, filemap.c)
>      -> folio_wake_bit (static, filemap.c)
>  -> __folio_end_writeback (non-static, page-writeback.c)
>      -> __wb_writeout_add (static, page-writeback.c)
> 
> I'm not sure there's an obviously better split than where it is right
> now.

Ok, let's ignore that whole mess for now.  There is plenty bigger fish to
fry.
