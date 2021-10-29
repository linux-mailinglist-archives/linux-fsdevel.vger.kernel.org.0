Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF8243FEA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhJ2Ore (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:47:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57864 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhJ2Ord (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:47:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 838231FD51;
        Fri, 29 Oct 2021 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635518704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1/0tWG/oKUZOJcGNfnoYQFpXXezjJ1VuVMjD4tPxqM=;
        b=rkUaNJDo7doW7mmhhiDH23/fksZk9/bMewZMBKvw02s5xGKVCoudDBJeVnactwhApDzRwr
        OI0C5as/v7+QVSF+ha+hHzbuqZxPwcjsgaLG4Qe8DlVjFknnk/wGBfoq5ay8+iOEOI5xp9
        zC7B3XezoovoCrndutFf6IWjryp3H2g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 549CAA3B84;
        Fri, 29 Oct 2021 14:45:04 +0000 (UTC)
Date:   Fri, 29 Oct 2021 16:45:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXwI7+1bQNECvBz4@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
 <20211026193315.GA1860@pc638.lan>
 <20211027175550.GA1776@pc638.lan>
 <YXupZjQgLAi6ClRi@dhcp22.suse.cz>
 <CA+KHdyX_0B-hM8m0eZBetcdBC9X3ddnA4dMyZvA2_xCjJJeJCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyX_0B-hM8m0eZBetcdBC9X3ddnA4dMyZvA2_xCjJJeJCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-10-21 16:05:32, Uladzislau Rezki wrote:
[...]
> > OK, this looks easier from the code reading but isn't it quite wasteful
> > to throw all the pages backing the area (all of them allocated as
> > __GFP_NOFAIL) just to then fail to allocate few page tables pages and
> > drop all of that on the floor (this will happen in __vunmap AFAICS).
> >
> > I mean I do not care all that strongly but it seems to me that more
> > changes would need to be done here and optimizations can be done on top.
> >
> > Is this something you feel strongly about?
> >
> Will try to provide some motivations :)
> 
> It depends on how to look at it. My view is as follows a more simple code
> is preferred. It is not considered as a hot path and it is rather a corner
> case to me.

Yes, we are definitely talking about corner cases here. Even GFP_KERNEL
allocations usually do not fail.

> I think "unwinding" has some advantage. At least one motivation
> is to release a memory(on failure) before a delay that will prevent holding
> of extra memory in case of __GFP_NOFAIL infinitelly does not succeed, i.e.
> if a process stuck due to __GFP_NOFAIL it does not "hold" an extra memory
> forever.

Well, I suspect this is something that we can disagree on and both of us
would be kinda right. I would see it as throwing baby out with the
bathwater. The vast majority of the memory will be in the area pages and
sacrificing that just to allocate few page tables or whatever that might
fail in that code path is just a lot of cycles wasted.

So unless you really feel strongly about this then I would stick with
this approach.
-- 
Michal Hocko
SUSE Labs
