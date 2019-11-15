Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B598FD9F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOJxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 04:53:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfKOJxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AD6BB18D;
        Fri, 15 Nov 2019 09:53:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62F3C1E3BEA; Fri, 15 Nov 2019 10:53:00 +0100 (CET)
Date:   Fri, 15 Nov 2019 10:53:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm <linux-mm@kvack.org>,
        fsdev <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v2] writeback: add elastic bdi in cgwb bdp
Message-ID: <20191115095300.GB9043@quack2.suse.cz>
References: <20191026104656.15176-1-hdanton@sina.com>
 <20191115033240.11236-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115033240.11236-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-11-19 11:32:40, Hillf Danton wrote:
> 
> On Thu, 14 Nov 2019 13:17:46 +0100 Jan Kara wrote:
> > 
> > On Sat 26-10-19 18:46:56, Hillf Danton wrote:
> > > 
> > > The elastic bdi is the mirror bdi of spinning disks, SSD, USB and
> > > other storage devices/instruments on market. The performance of
> > > ebdi goes up and down as the pattern of IO dispatched changes, as
> > > approximately estimated as below.
> > > 
> > > 	P = j(..., IO pattern);
> > > 
> > > In ebdi's view, the bandwidth currently measured in balancing dirty
> > > pages has close relation to its performance because the former is a
> > > part of the latter.
> > > 
> > > 	B = y(P);
> > > 
> > > The functions above suggest there may be a layer violation if it
> > > could be better measured somewhere below fs.
> > > 
> > > It is measured however to the extent that makes every judge happy,
> > > and is playing a role in dispatching IO with the IO pattern entirely
> > > ignored that is volatile in nature.
> > > 
> > > And it helps to throttle the dirty speed, with the figure ignored
> > > that DRAM in general is x10 faster than ebdi. If B is half of P for
> > > instance, then it is near 5% of dirty speed, just 2 points from the
> > > figure in the snippet below.
> > > 
> > > /*
> > >  * If ratelimit_pages is too high then we can get into dirty-data overload
> > >  * if a large number of processes all perform writes at the same time.
> > >  * If it is too low then SMP machines will call the (expensive)
> > >  * get_writeback_state too often.
> > >  *
> > >  * Here we set ratelimit_pages to a level which ensures that when all CPUs are
> > >  * dirtying in parallel, we cannot go more than 3% (1/32) over the dirty memory
> > >  * thresholds.
> > >  */
> > > 
> > > To prevent dirty speed from running away from laundry speed, ebdi
> > > suggests the walk-dog method to put in bdp as a leash seems to
> > > churn less in IO pattern.
> > > 
> > > V2 is based on next-20191025.
> > 
> > Honestly, the changelog is still pretty incomprehensible as Andrew already
> > mentioned. Also I completely miss there, what are the benefits of this work
> > compared to what we currently have.
> > 
> Hey Jan
> 
> In the room which has been somewhere between 3% and 5% for bdp since
> 143dfe8611a6 ("writeback: IO-less balance_dirty_pages()") a bdp is
> proposed with target of surviving tests like LTP without regressions
> introduced, so overall the concerned benefit is that bdp is becoming
> more diverse if the diversity under linux/fs is good for the 99%.

What do you mean by "balance_dirty_pages() is becoming more diverse"?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
