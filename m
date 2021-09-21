Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8241326C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhIULT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:19:57 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:42117 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232229AbhIULT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:19:56 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 90E0025A0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:18:18 +0100 (IST)
Received: (qmail 30926 invoked from network); 21 Sep 2021 11:18:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 11:18:18 -0000
Date:   Tue, 21 Sep 2021 12:18:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210921111816.GS3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <YUhztA8TmplTluyQ@casper.infradead.org>
 <20210920125058.GI3959@techsingularity.net>
 <20210920141152.GM9286@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210920141152.GM9286@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:11:52PM +0200, David Sterba wrote:
> On Mon, Sep 20, 2021 at 01:50:58PM +0100, Mel Gorman wrote:
> > On Mon, Sep 20, 2021 at 12:42:44PM +0100, Matthew Wilcox wrote:
> > > On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> > > > This has been lightly tested only and the testing was useless as the
> > > > relevant code was not executed. The workload configurations I had that
> > > > used to trigger these corner cases no longer work (yey?) and I'll need
> > > > to implement a new synthetic workload. If someone is aware of a realistic
> > > > workload that forces reclaim activity to the point where reclaim stalls
> > > > then kindly share the details.
> > > 
> > > The stereeotypical "stalling on I/O" problem is to plug in one of the
> > > crap USB drives you were given at a trade show and simply
> > > 	dd if=/dev/zero of=/dev/sdb
> > > 	sync
> > > 
> > 
> > The test machines are 1500KM away so plugging in a USB stick but worst
> > comes to the worst, I could test it on a laptop.
> 
> There's a device mapper target dm-delay [1] that as it says delays the
> reads and writes, so you could try to emulate the slow USB that way.
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/delay.html

Ah, thanks for that tip. I wondered if something like this existed and
clearly did not search hard enough. I was able to reproduce the problem
without throttling but this could still be useful if examining cases
where there are 2 or more BDIs with variable speeds.

-- 
Mel Gorman
SUSE Labs
