Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21285CF581
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfJHJCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 05:02:03 -0400
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:55923 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730211AbfJHJCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:02:02 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 05:02:01 EDT
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 684E46B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2019 09:52:21 +0100 (IST)
Received: (qmail 4145 invoked from network); 8 Oct 2019 08:52:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Oct 2019 08:52:21 -0000
Date:   Tue, 8 Oct 2019 09:52:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [bug, 5.2.16] kswapd/compaction null pointer crash [was Re:
 xfs_inode not reclaimed/memory leak on 5.2.16]
Message-ID: <20191008085219.GC3321@techsingularity.net>
References: <87pnji8cpw.fsf@mid.deneb.enyo.de>
 <20190930085406.GP16973@dread.disaster.area>
 <87o8z1fvqu.fsf@mid.deneb.enyo.de>
 <20190930211727.GQ16973@dread.disaster.area>
 <96023250-6168-3806-320a-a3468f1cd8c9@suse.cz>
 <87lfu4i79z.fsf@mid.deneb.enyo.de>
 <2af04718-d5cb-1bb1-a789-be017f2e2df0@suse.cz>
 <1f0f2849-d90e-6563-0034-07ba80f8ba2f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1f0f2849-d90e-6563-0034-07ba80f8ba2f@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 03:56:41PM +0200, Vlastimil Babka wrote:
> On 10/7/19 3:28 PM, Vlastimil Babka wrote:
> > On 10/1/19 9:40 PM, Florian Weimer wrote:
> >> * Vlastimil Babka:
> >>
> >>
> >> See below.  I don't have debuginfo for this build, and the binary does
> >> not reproduce for some reason.  Due to the heavy inlining, it might be
> >> quite hard to figure out what's going on.
> > 
> > Thanks, but I'm still not able to "decompile" that in my head.
> 
> While staring at the code, I think I found two probably unrelated bugs.
> One is that pfn and page might be desynced when zone starts in the middle
> of pageblock, as the max() is only applied to page and not pfn. But that
> only effectively affects the later pfn_valid_within() checks, which should
> be always true on x86.
> 
> The second is that "end of pageblock online and valid" should refer to
> the last pfn of pageblock, not first pfn of next pageblocks. Otherwise we
> might return false needlessly. Mel, what do you think?
> 

I think you are correct in both cases. It's perfectly possible I would
not have observed a problem in testing if zones were aligned which I
think is generally the case on my test machines.

-- 
Mel Gorman
SUSE Labs
