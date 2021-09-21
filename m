Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F727413268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhIULSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:18:04 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:40145 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232403AbhIULSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:18:02 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 7FF46CCDA4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:16:32 +0100 (IST)
Received: (qmail 24510 invoked from network); 21 Sep 2021 11:16:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 11:16:32 -0000
Date:   Tue, 21 Sep 2021 12:16:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm/vmscan: Throttle reclaim when no progress is
 being made
Message-ID: <20210921111630.GR3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-4-mgorman@techsingularity.net>
 <163218069080.3992.14261132300912173043@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163218069080.3992.14261132300912173043@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:31:30AM +1000, NeilBrown wrote:
> On Mon, 20 Sep 2021, Mel Gorman wrote:
> > +
> > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
> 
> We always seem to pass "HZ/10" to reclaim_throttle().  Should we just
> hard-code that in the one place inside reclaim_throttle() itself?
> 

do_writepages passes in HZ/50. I'm not sure if these values even have
any special meaning, I think it's more likely they were pulled out of
the air based on the speed of some disk in the past and then copied.
It's another reason why I want the wakeups to be based on events within
the mm as much as possible.

-- 
Mel Gorman
SUSE Labs
