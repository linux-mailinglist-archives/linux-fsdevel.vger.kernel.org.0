Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AF4377D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJVNTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 09:19:55 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:45521 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231852AbhJVNTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:19:54 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 46004FB39F
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 14:17:34 +0100 (IST)
Received: (qmail 6329 invoked from network); 22 Oct 2021 13:17:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 13:17:34 -0000
Date:   Fri, 22 Oct 2021 14:17:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-ID: <20211022131732.GK3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>
 <20211022083927.GI3959@techsingularity.net>
 <163490199006.17149.17259708448207042563@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163490199006.17149.17259708448207042563@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:26:30PM +1100, NeilBrown wrote:
> On Fri, 22 Oct 2021, Mel Gorman wrote:
> > On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> > 
> > > In general, I still don't like the use of wake_up_all(), though it won't
> > > cause incorrect behaviour.
> > > 
> > 
> > Removing wake_up_all would be tricky.
> 
> I think there is a misunderstanding.  Removing wake_up_all() is as
> simple as
>    s/wake_up_all/wake_up/
> 
> If you used prepare_to_wait_exclusive(), then wake_up() would only wake
> one waiter, while wake_up_all() would wake all of them.
> As you use prepare_to_wait(), wake_up() will wake all waiters - as will
> wake_up_all(). 
> 

Ok, yes, there was a misunderstanding. I thought you were suggesting a
move to exclusive wakeups. I felt that the wake_up_all was explicit in
terms of intent and that I really meant for all tasks to wake instead of
one at a time.

-- 
Mel Gorman
SUSE Labs
