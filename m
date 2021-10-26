Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4B43AC91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhJZHF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:05:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43394 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJZHF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:05:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3CAA121957;
        Tue, 26 Oct 2021 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635231782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mq9APL2CfqMqjGpYMi+6mlPHzzLvKocGw0zALcVBOW0=;
        b=QsMNOfPPbHPZ6065oUYV7TFulmvKfp2P+adQeHhtlfwDxkqwJ7UZe5vLBzffqj4jjEYHoN
        IowE3CSDu+DCuODpoF1WfnuK66SAfBuao8H8OLTK94KcXEIJDxLoupoNMc+8vaevHmeHOt
        4sSMvc3b1l8i6shOwqSusLLYuR7nZrw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAB4BA3B8C;
        Tue, 26 Oct 2021 07:03:01 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:03:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXeoJbzICpNsEEBr@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <163520277623.16092.15759069160856953654@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163520277623.16092.15759069160856953654@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 09:59:36, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
[...]
> > @@ -3032,6 +3036,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >  		warn_alloc(gfp_mask, NULL,
> >  			"vmalloc error: size %lu, vm_struct allocation failed",
> >  			real_size);
> > +		if (gfp_mask & __GFP_NOFAIL) {
> > +			schedule_timeout_uninterruptible(1);
> > +			goto again;
> > +		}
> 
> Shouldn't the retry happen *before* the warning?

I've done it after to catch the "depleted or fragmented" vmalloc space.
This is not related to the memory available and therefore it won't be
handled by the oom killer. The error message shouldn't imply the vmalloc
allocation failure IMHO but I am open to suggestions.

-- 
Michal Hocko
SUSE Labs
