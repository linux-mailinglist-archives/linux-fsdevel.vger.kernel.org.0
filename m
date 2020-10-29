Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E529F734
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 22:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ2Vym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Vym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:54:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bv8hnTa54VlkYDZjalLAhF4ZVRuvo5SR7h8bMctCOls=; b=XPhU5PrJG7WY0XuucbwD8TVC+n
        mI5h6nxWWCsXPz4MdpP5l2WZdYAKeNArmwMIU94/5zCrq3pRkGEMn1afIm1nUkg8XmzYsG41agOAY
        ylLvV4/j7ZVBtA8orn2sSXN1a/jPWmJjF0LnIkS3KfVtuGaDAuUhCZtAaT14RSKUO57s851SVGjM5
        8Su2L82N5tMeEdjRa6i/FMks4QuZNY63hxSZ266LrSRzrbX+XQozDHgP6mG3oDFglongZB0pWa91H
        WKw58zTaD4mBnJpEWJJ0RHOTeqNJY6UuPKkbSF1Miq4+qkZ3feZlLTrW8g9j2dFdhdIT7QcJwUKxa
        nrze2CbA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYFsU-0000hO-Nw; Thu, 29 Oct 2020 21:54:38 +0000
Date:   Thu, 29 Oct 2020 21:54:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] mm: Use multi-index entries in the page cache
Message-ID: <20201029215438.GE27442@casper.infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-3-willy@infradead.org>
 <4D931CDD-2CB1-4129-974C-12255156154E@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D931CDD-2CB1-4129-974C-12255156154E@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:49:39PM -0400, Zi Yan wrote:
> On 29 Oct 2020, at 15:33, Matthew Wilcox (Oracle) wrote:
> 
> > We currently store order-N THPs as 2^N consecutive entries.  While this
> > consumes rather more memory than necessary, it also turns out to be buggy.
> > A writeback operation which starts in the middle of a dirty THP will not
> > notice as the dirty bit is only set on the head index.  With multi-index
> > entries, the dirty bit will be found no matter where in the THP the
> > iteration starts.
> 
> A multi-index entry can point to a THP with any size and the code relies
> on thp_last_tail() to check whether it has finished processing the page
> pointed by the entry. Is it how this change works?

Maybe I need to do a better explanation here.  Let me try again ...

Consider an order-2 page (at address p) at index 4.  Before this change,
the node in the XArray contains:

4: p
5: p
6: p
7: p

After this change, it contains:

4: p
5: sibling(4)
6: sibling(4)
7: sibling(4)

When we mark page p as dirty, we set a bit on entry 4, since that's the
head page.  Now we try to fsync pages 5-19, we start the lookup at index 5.
Before this patch, the pagecache knows that p is a head page, but the
XArray doesn't.  So when it looks at entry 5, it sees a normal pointer
and no mark on it -- the XArray doesn't get to interpret the contents
of the pointers stored in it.  After this patch, we tell the XArray that
indices 4-7 are a single entry, so the marked iteration actually loads
the entry at 5, sees it's a sibling of 4, sees that 4 is marked dirty
and returns p.

