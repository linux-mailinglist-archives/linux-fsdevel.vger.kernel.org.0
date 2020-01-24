Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC70148FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAXVQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 16:16:50 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55401 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgAXVQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:16:50 -0500
Received: from dread.disaster.area (pa49-195-162-125.pa.nsw.optusnet.com.au [49.195.162.125])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 991D1820C75;
        Sat, 25 Jan 2020 08:16:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iv6Jm-00079w-Ii; Sat, 25 Jan 2020 08:16:42 +1100
Date:   Sat, 25 Jan 2020 08:16:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, idryomov@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com, Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V4
Message-ID: <20200124211642.GB7216@dread.disaster.area>
References: <20191112001900.9206-1-mchristi@redhat.com>
 <CALvZod47XyD2x8TuZcb9PgeVY14JBwNhsUpN3RAeAt+RJJC=hg@mail.gmail.com>
 <5E2B19C9.6080907@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E2B19C9.6080907@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=eqEhQ2W7mF93FbYHClaXRw==:117 a=eqEhQ2W7mF93FbYHClaXRw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=3XgbrJ93Oiw9jx1WlK8A:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=xVlTc564ipvMDusKsbsT:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:22:33AM -0600, Mike Christie wrote:
> On 12/05/2019 04:43 PM, Shakeel Butt wrote:
> > On Mon, Nov 11, 2019 at 4:19 PM Mike Christie <mchristi@redhat.com> wrote:
> >> This patch adds a new prctl command that daemons can use after they have
> >> done their initial setup, and before they start to do allocations that
> >> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
> >> flags so both userspace block and FS threads can use it to avoid the
> >> allocation recursion and try to prevent from being throttled while
> >> writing out data to free up memory.
> >>
> >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
> >> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> > 
> > I suppose this patch should be routed through MM tree, so, CCing Andrew.
> >
> 
> Andrew and other mm/storage developers,
> 
> Do I need to handle anything else for this patch, or are there any other
> concerns? Is this maybe something we want to talk about at a quick LSF
> session?
> 
> I have retested it with Linus's current tree. It still applies cleanly
> (just some offsets), and fixes the problem described above we have been
> hitting.

I must have missed this version being posted (just looked it up on
lore.kernel.org). As far as I'm concerned this is good to go and it
is absolutely necessary for userspace IO stacks to function
correctly.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

If no manintainer picks it up before the next merge window, then I
recommend resending the latest version to Linus asking him to merge
it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
