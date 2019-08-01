Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822AB7D86A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfHAJWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 05:22:44 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36584 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729449AbfHAJWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:22:44 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0B0DB43DDF1;
        Thu,  1 Aug 2019 19:22:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht7HB-0006Bx-HP; Thu, 01 Aug 2019 19:21:33 +1000
Date:   Thu, 1 Aug 2019 19:21:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/24] xfs:: account for memory freed from metadata
 buffers
Message-ID: <20190801092133.GK7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-12-david@fromorbit.com>
 <20190801081603.GA10600@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801081603.GA10600@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=D-H-fAKCpb68onX5N_cA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:16:03AM -0700, Christoph Hellwig wrote:
> > +
> > +		/*
> > +		 * Account for the buffer memory freed here so memory reclaim
> > +		 * sees this and not just the xfs_buf slab entry being freed.
> > +		 */
> > +		if (current->reclaim_state)
> > +			current->reclaim_state->reclaimed_pages += bp->b_page_count;
> > +
> 
> I think this wants a mm-layer helper ala:
> 
> static inline void shrinker_mark_pages_reclaimed(unsigned long nr_pages)
> {
> 	if (current->reclaim_state)
> 		current->reclaim_state->reclaimed_pages += nr_pages;
> }
> 
> plus good documentation on when to use it.

Sure, but that's something for patch 6, not this one :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
