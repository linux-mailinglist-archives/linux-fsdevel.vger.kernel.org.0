Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255526CA9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgIPUKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgIPRdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:33:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE31C0698D9;
        Wed, 16 Sep 2020 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hjBH8eVL+KDdz8o5+TTH4XgmzDXF3Ypdoh1lK++brXA=; b=c6d1Pe73asPhsa8UwmMbFCMHuc
        30c0hUpFGmdZ3T+2maRv/Aphr+ijWpB6twr3lqPXo3SqRcE3m1fLfQHupLkwInCNBhg4EbNliywyp
        5tn7MJ6HuZr1OyIOc1gZ6+tuezc1NNz6SnMqtbCc1g4R8I4h6PCPeLsLGwopt927alBBTvq2fJCBx
        yr9h4lzYKBVGV0lx5e8QpHoBDPBURlS8Y64isfcdaej5vhJdW+46SDYfJNHdv1OFxRBW4V7kIE0iP
        xNp2P2Bl0MwFONf+QJ3w3fKDjvhk+faEKwV+Qqwd/jYxU7uu6VwJmWjdk2v3nCspmSLdN4ZSQcQFv
        rc2+HYxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIVth-0002Mx-Lo; Wed, 16 Sep 2020 11:46:49 +0000
Date:   Wed, 16 Sep 2020 12:46:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 2/2] fs: Do not update nr_thps for mappings which support
 THPs
Message-ID: <20200916114649.GM5449@casper.infradead.org>
References: <20200916032717.22917-1-willy@infradead.org>
 <20200916032717.22917-2-willy@infradead.org>
 <20200916052126.GA12923@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916052126.GA12923@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:21:26AM +0100, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 04:27:17AM +0100, Matthew Wilcox (Oracle) wrote:
> > The nr_thps counter is to support THPs in the page cache when the
> > filesystem doesn't understand THPs.  Eventually it will be removed, but
> > we should still support filesystems which do not understand THPs yet.
> > Move the nr_thp manipulation functions to filemap.h since they're
> > page-cache specific.
> 
> Honestly I don't think we should support the read-only THP crap.  We
> should in fact never have merged that bandaid to start with given that
> you did good progress on the real thing.

I'd like to see the feature ripped out again, yes.  Once we have a few more
filesystems converted, I think that'll be a reasonable thing to do.

It was a good step along the way; Song fixed a number of problems,
and worked on other things that I never had to learn anything about
(like uprobes and khugepaged).  I wouldn't go so far as to say we should
never have merged it, but I think we can remove it in about six months.
