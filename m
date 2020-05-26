Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD061E1904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 03:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgEZBVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 21:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgEZBVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 21:21:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CBC061A0E;
        Mon, 25 May 2020 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9F2IX9GgTvEb6k7D/DzwUrK1uYLCIrUvEsxYTJKhsdk=; b=t6eOMl0JNnb+SIm8E94AZBTWQd
        jcW4Cdyz24EI7ciD73XHeRqeGM8RuaJDmagR+eEsvcRyjNQmcyBvAJUi8W7yCp7B7/Swo0yphGycA
        eD8BptiQw4yrEBSz0ur4KB3AfWNZa+/eYWIpLjK8AfEYQWHcyZvxzZyH4Y6OpLtZ3jn42DDA7a2YR
        XYGh4pPCev3XJdaCb2FXmBcyEcVQY0mJgkTm5alCRaL5aa4em3vSMwMalRxbM9hcDgP3sfJsNbx7y
        yYA//d5YfzQ1J4uGZwY5WMJfNtdlHcA7Bbw2ZArY4KfS1x7dmS9KAb3GcifCKkAGbPIBq84OMyfKy
        19OS0MQQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdOHm-0002Jw-0N; Tue, 26 May 2020 01:21:42 +0000
Date:   Mon, 25 May 2020 18:21:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200526012141.GE17206@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200521224906.GU2005@dread.disaster.area>
 <20200522000411.GI28818@bombadil.infradead.org>
 <20200522025751.GX2005@dread.disaster.area>
 <20200522030553.GK28818@bombadil.infradead.org>
 <20200525230751.GZ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525230751.GZ2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 09:07:51AM +1000, Dave Chinner wrote:
> On Thu, May 21, 2020 at 08:05:53PM -0700, Matthew Wilcox wrote:
> > On Fri, May 22, 2020 at 12:57:51PM +1000, Dave Chinner wrote:
> > > Again, why is this dependent on THP? We can allocate compound pages
> > > without using THP, so why only allow the page cache to use larger
> > > pages when THP is configured?
> > 
> > We have too many CONFIG options.  My brain can't cope with adding
> > CONFIG_LARGE_PAGES because then we might have neither THP nor LP, LP and
> > not THP, THP and not LP or both THP and LP.  And of course HUGETLBFS,
> > which has its own special set of issues that one has to think about when
> > dealing with the page cache.
> 
> That sounds like something that should be fixed. :/

If I have to fix hugetlbfs before doing large pages in the page cache,
we'll be five years away and at least two mental breakdowns.  Honestly,
I'd rather work on almost anything else.  Some of the work I'm doing
will help make hugetlbfs more similar to everything else, eventually,
but ... no, not going to put all this on hold to fix hugetlbfs.  Sorry.

> Really, I don't care about the historical mechanisms that people can
> configure large pages with. If the mm subsystem does not have a
> unified abstraction and API for working with large pages, then that
> is the first problem that needs to be addressed before other
> subsystems start trying to use large pages. 

I think you're reading too quickly.  Let me try again.

Historically, Transparent Huge Pages have been PMD sized.  They have also
had a complicated interface to use.  I am changing both those things;
THPs may now be arbitrary order, and I'm adding interfaces to make THPs
easier to work with.

Now, if you want to contend that THPs are inextricably linked with
PMD sizes and I need to choose a different name, I've been thinking
about other options a bit.  One would be 'lpage' for 'large page'.
Another would be 'mop' for 'multi-order page'.

We should not be seeing 'compound_order' in any filesystem code.
Compound pages are an mm concept.  They happen to be how THPs are
implemented, but it'd be a layering violation to use them directly.
