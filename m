Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF240C51B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhIOMV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 08:21:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbhIOMV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:21:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84666221B9;
        Wed, 15 Sep 2021 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631708406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BELbqYoPfRGRUC/W1066HME9OxG26ve3fwD+CS+Tg5g=;
        b=Mp6P4l+u6p3E1NRsbRlaOwy/fg1oziSM+mwLmQoo1dQftP6pCFes9UJj1Uj7IsOYBobR3X
        x1cbqPDoY99Zja/8a9RVwfOGhlccJNSvsXNXb+rrTdFeBujhm1riMRaSrFZLyLT4eay4yu
        kcGGMChOtntx1vGFDLBP0y/D5hBZs2A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 548A0A3BA0;
        Wed, 15 Sep 2021 12:20:06 +0000 (UTC)
Date:   Wed, 15 Sep 2021 14:20:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <YUHk9d0jM6HATZ8+@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <20210914235535.GL2361455@dread.disaster.area>
 <20210915085904.GU3828@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915085904.GU3828@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 09:59:04, Mel Gorman wrote:
> On Wed, Sep 15, 2021 at 09:55:35AM +1000, Dave Chinner wrote:

> > That way "GFP_RETRY_FOREVER" allocation contexts don't have to jump
> > through an ever changing tangle of hoops to make basic "never-fail"
> > allocation semantics behave correctly.
> > 
> 
> True and I can see what that is desirable. What I'm saying is that right
> now, increasing the use of __GFP_NOFAIL may cause a different set of
> problems (unbounded retries combined with ATOMIC allocation failures) as
> they compete for similar resources.

I have commented on reasoning behind the above code in other reply. Let
me just comment on this particular concern. I completely do agree that
any use of __GFP_NOFAIL should be carefully evaluated. This is a very
strong recuirement and it should be used only as a last resort.
On the other hand converting an existing open coded nofail code that
_doesn't_ really do any clever tricks to allow a forward progress (e.g.
dropping locks, kicking some internal caching mechinisms etc.) should
just be turned into __GPF_NOFAIL. Not only it makes it easier to spot
that code but it also allows the page allocator to behave consistently
and predictably.

If the existing heuristic wrt. memory reserves to GFP_NOFAIL turns out
to be suboptimal we can fix it for all those users.

Dropping the rest of the email which talks about reclaim changes because
I will need much more time to digest that.
[...]
-- 
Michal Hocko
SUSE Labs
