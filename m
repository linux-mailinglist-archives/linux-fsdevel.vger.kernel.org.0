Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A54C4224AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhJELLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 07:11:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhJELLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:11:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AED1322312;
        Tue,  5 Oct 2021 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633432200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSQVXrxwytTOvVX5IUNIPqRozXx0ZQPzC5QYUn5uXWU=;
        b=pKrrhANTXeIml7kLM167UDYZbKQyQXPNx3t/wOQIs1bfleWEq3LCE9k4OBQTOerJBWWswL
        edtifxt35dK99ea2K/VGTfMZkCE+nWuLDDSSwDUhdTSrdw+ZZZwtkVbcrPmQAoVsnjeUiw
        4MB2uWI2IDResdUN+s8kZrM8jqeP3DU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A9C7A3B84;
        Tue,  5 Oct 2021 11:10:00 +0000 (UTC)
Date:   Tue, 5 Oct 2021 13:09:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
[...]
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -209,7 +209,11 @@ struct vm_area_struct;
> >   * used only when there is no reasonable failure policy) but it is
> >   * definitely preferable to use the flag rather than opencode endless
> >   * loop around allocator.
> > - * Using this flag for costly allocations is _highly_ discouraged.
> > + * Use of this flag may lead to deadlocks if locks are held which would
> > + * be needed for memory reclaim, write-back, or the timely exit of a
> > + * process killed by the OOM-killer.  Dropping any locks not absolutely
> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> > + * Using this flag for costly allocations (order>1) is _highly_ discouraged.
> 
> We define costly as 3, not 1. But sure it's best to avoid even order>0 for
> __GFP_NOFAIL. Advising order>1 seems arbitrary though?

This is not completely arbitrary. We have a warning for any higher order
allocation.
rmqueue:
	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

I do agree that "Using this flag for higher order allocations is
_highly_ discouraged.


> >   */
> >  #define __GFP_IO	((__force gfp_t)___GFP_IO)
> >  #define __GFP_FS	((__force gfp_t)___GFP_FS)
> > 
> > 
> > 

-- 
Michal Hocko
SUSE Labs
