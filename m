Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384B1B951E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 04:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgD0C1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 22:27:16 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44773 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgD0C1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:27:16 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B80CF82167F;
        Mon, 27 Apr 2020 12:27:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jStUD-0001QJ-Af; Mon, 27 Apr 2020 12:27:09 +1000
Date:   Mon, 27 Apr 2020 12:27:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Message-ID: <20200427022709.GC2005@dread.disaster.area>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
 <20200427001234.GB29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427001234.GB29705@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=_ZLPnNw1jSjQLjkGmAoA:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:12:34PM -0700, Matthew Wilcox wrote:
> On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
> > > @@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
> > >  
> > >  	if (offset == 0 && length == PAGE_SIZE) {
> > >  		kfree((struct orangefs_write_range *)page_private(page));
> > > -		set_page_private(page, 0);
> > > -		ClearPagePrivate(page);
> > > -		put_page(page);
> > > +		clear_fs_page_private(page);
> > 
> > Ditto:
> > 		wr = clear_fs_page_private(page);
> > 		kfree(wr);
> 
> You don't want to be as succinct as the btrfs change you suggested?
> 
> 		kfree(clear_fs_page_private(page));

That could be done, yes. I was really just trying to point out the
use after free that was occurring here rather than write compact
code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
