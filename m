Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC93B16AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFWJTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFWJTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:19:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F73C061574;
        Wed, 23 Jun 2021 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CL8XQmsLz8MJp1hdhyIHxSeG4lqcBDV8J2aWoqxO7kM=; b=oUU0MJd19YgEIwWB21YP+sbRKv
        fka7CIUJ+qIA/GRKsOA263HiOQMZ+2OA7l0jC/g0UtqzrdzG5geGoIo2tK+QTwwdnU5QlfD/NqDSv
        v8JcUU0g8tAmj/FOQO47v6ihpxybQnJaokSBJPuPL4oHhLAgHXrl5VkLL+/MiuapGu0wfyTGqUz+u
        vBFbaYYGXTbHL2MFJwKTZpKXX0s/rKiuWRZnkag893AMHaCW5ZDm4FkZ5Wh4+GXaG/L4nWiD1Y26s
        IyBM5Uq6OIzSKl1bJrIxnEGxBv+VVhJspYO9UL9Hb0/zC0BsTIKY2YM3YIkQjgtbSEx/niNM9ppAW
        k+lrBWPA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyzE-00FFcA-82; Wed, 23 Jun 2021 09:16:12 +0000
Date:   Wed, 23 Jun 2021 11:15:55 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/46] mm/writeback: Add __folio_end_writeback()
Message-ID: <YNL7yxWFqlL7/Fd+@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:29PM +0100, Matthew Wilcox (Oracle) wrote:
> test_clear_page_writeback() is actually an mm-internal function, although
> it's named as if it's a pagecache function.  Move it to mm/internal.h,
> rename it to __folio_end_writeback() and change the return type to bool.
> 
> The conversion from page to folio is mostly about accounting the number
> of pages being written back, although it does eliminate a couple of
> calls to compound_head().

While this looks good, I think the whole abstraction is wrong.  I think
test_clear_page_writeback should just be merged into it's only caller.

But if that is somehow not on the table this change looks ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
