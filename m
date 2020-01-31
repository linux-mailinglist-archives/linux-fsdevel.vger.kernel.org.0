Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7B14E707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 03:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgAaCTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 21:19:12 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52634 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727749AbgAaCTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:19:12 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 78756820118;
        Fri, 31 Jan 2020 13:19:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ixLtl-0006PJ-WF; Fri, 31 Jan 2020 13:19:10 +1100
Date:   Fri, 31 Jan 2020 13:19:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
Message-ID: <20200131021909.GC18575@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-12-willy@infradead.org>
 <20200129010829.GK18610@dread.disaster.area>
 <20200130213533.GN6615@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130213533.GN6615@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=6Pvhz1k-dUzALmsgqCgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:35:33PM -0800, Matthew Wilcox wrote:
> On Wed, Jan 29, 2020 at 12:08:29PM +1100, Dave Chinner wrote:
> > On Fri, Jan 24, 2020 at 05:35:52PM -0800, Matthew Wilcox wrote:
> > > +	while (nr_pages--) {
> > > +		struct page *page = readahead_page(mapping, start++);
> > > +		int err = fuse_readpages_fill(&data, page);
> > > +
> > > +		if (!err)
> > > +			continue;
> > > +		nr_pages++;
> > > +		goto out;
> > >  	}
> > 
> > That's some pretty convoluted logic. Perhaps:
> > 
> > 	for (; nr_pages > 0 ; nr_pages--) {
> > 		struct page *page = readahead_page(mapping, start++);
> > 
> > 		if (fuse_readpages_fill(&data, page))
> > 			goto out;
> > 	}
> 
> I have a bit of an aversion to that style of for loop ... I like this
> instead:
> 
>         while (nr_pages) {
>                 struct page *page = readahead_page(mapping, start++);
> 
>                 if (fuse_readpages_fill(&data, page) != 0)
>                         goto out;
>                 nr_pages--;
>         }

yup, that's also fine.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
