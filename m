Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5C3B358A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhFXSXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhFXSXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:23:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522BC061574;
        Thu, 24 Jun 2021 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FH58xbrAwnxp9hbQL1JpxcH4bv5YM22KZsRyy+S8dEs=; b=YXqz0TXHOCWa6ql73OknL7qcpu
        T/RTjbrYcp1ojPjkshOCBVrzKQgVb5jW8R+PMHj556bZ0hjNXhLN9MoTT+xXLRrE95rePCVRwL2Xc
        kcfA82jkjqVOoZtwkASo5sLPdjuLMowOJRlGT25vBlHqhd2BDs5V760Nkceh+KKij/SDNUEQ5XHb/
        3TAUBHPgMKcFLzRMt4I9ciyUCVvQc3NewukF3/Ks9EiWIeC/Bp1YCgS1QxAH6kORlg2NMhJFnbL4W
        mstIH0MKdVfvqaZhzQdeCANysHUP0IaxoltuzpYc8AquxLGP/wYWMIV11GhiDSj2S40nBONt8ClvA
        d2AAfOzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwTxU-00GryO-PM; Thu, 24 Jun 2021 18:20:25 +0000
Date:   Thu, 24 Jun 2021 19:20:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/46] mm/writeback: Add __folio_end_writeback()
Message-ID: <YNTM3P/lem6P8ie/@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-25-willy@infradead.org>
 <YNL7yxWFqlL7/Fd+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNL7yxWFqlL7/Fd+@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:15:55AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:29PM +0100, Matthew Wilcox (Oracle) wrote:
> > test_clear_page_writeback() is actually an mm-internal function, although
> > it's named as if it's a pagecache function.  Move it to mm/internal.h,
> > rename it to __folio_end_writeback() and change the return type to bool.
> > 
> > The conversion from page to folio is mostly about accounting the number
> > of pages being written back, although it does eliminate a couple of
> > calls to compound_head().
> 
> While this looks good, I think the whole abstraction is wrong.  I think
> test_clear_page_writeback should just be merged into it's only caller.

I'm not opposed to doing that, but something else has to get
un-static'ed in order to make that happen.

folio_end_writeback (exported, filemap.c)
 -> folio_wake (static, filemap.c)
     -> folio_wake_bit (static, filemap.c)
 -> __folio_end_writeback (non-static, page-writeback.c)
     -> __wb_writeout_add (static, page-writeback.c)

I'm not sure there's an obviously better split than where it is right
now.

> But if that is somehow not on the table this change looks ok:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
