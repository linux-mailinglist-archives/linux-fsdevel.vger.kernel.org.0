Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96A4610AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 09:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbhK2JBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 04:01:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51650 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbhK2I7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:59:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E335F1FCA1;
        Mon, 29 Nov 2021 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638176164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46Ewntptqey7Nb8utRTMlE0lWeg1WoxNDUViibdnCTQ=;
        b=mQjNkj4jddg4aAzRNLHJfaGwJ9uhFcRto/6bZ/e/rW57sitgY4Nz87XFj54rTjwqRQxf4f
        3K4eXNUCQR6sNb29av8NWaWHsPdTdNpYpo02lPBRoLQcxUYq6Jj6xtJug58QthhbfDt1T2
        0DSHofD1aQaGV/q7sDV+E7i4aSoNOaQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0D28A3B81;
        Mon, 29 Nov 2021 08:56:04 +0000 (UTC)
Date:   Mon, 29 Nov 2021 09:56:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YaSVpL+Rx0q2rGbh@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YaC7jij1hHtdOJdE@dhcp22.suse.cz>
 <20211127160043.1512b4063f30b4d043b37420@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127160043.1512b4063f30b4d043b37420@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 27-11-21 16:00:43, Andrew Morton wrote:
> On Fri, 26 Nov 2021 11:48:46 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Mon 22-11-21 16:32:31, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > cannot fail and they do not fit into a single page.
> > > 
> > > The large part of the vmalloc implementation already complies with the
> > > given gfp flags so there is no work for those to be done. The area
> > > and page table allocations are an exception to that. Implement a retry
> > > loop for those.
> > > 
> > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > a change to the vmalloc space change if the failure was caused by
> > > the space fragmentation or depletion. But there are multiple different
> > > reasons to retry and this could become much more complex. Keep the retry
> > > simple for now and just sleep to prevent from hogging CPUs.
> > > 
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > Are there still any concerns around this patch or the approach in
> > general?
> 
> Well.  Like GFP_NOFAIL, every use is a sin.  But I don't think I've
> ever seen a real-world report of anyone hitting GFP_NOFAIL's
> theoretical issues.

I am not sure what you mean here. If you are missing real GFP_NOFAIL use
cases then some have been mentioned in the discussion

> I assume there will be a v3?

Currently I do not have any follow up changes on top of neither of the
patch except for acks and review tags. I can repost with those if you
prefer.

-- 
Michal Hocko
SUSE Labs
