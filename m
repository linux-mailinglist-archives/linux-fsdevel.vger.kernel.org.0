Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39A383D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 00:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfHFWXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 18:23:31 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45356 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfHFWXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:23:31 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C8B133611E5;
        Wed,  7 Aug 2019 08:23:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv7qW-0005QF-J6; Wed, 07 Aug 2019 08:22:20 +1000
Date:   Wed, 7 Aug 2019 08:22:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm: directed shrinker work deferral
Message-ID: <20190806222220.GL7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-2-david@fromorbit.com>
 <20190802152709.GA60893@bfoster>
 <20190804014930.GR7777@dread.disaster.area>
 <20190805174226.GB14760@bfoster>
 <20190805234318.GB7777@dread.disaster.area>
 <20190806122754.GA2979@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806122754.GA2979@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=Lk4mrrDYMWaqc0wFPJcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:27:54AM -0400, Brian Foster wrote:
> If you add a generic "defer work" knob to the shrinker mechanism, but
> only process it as an "allocation context" check, I expect it could be
> easily misused. For example, some shrinkers may decide to set the the
> flag dynamically based on in-core state.

Which is already the case. e.g. There are shrinkers that don't do
anything because a try-lock fails.  I haven't attempted to change
them, but they are a clear example of how even ->scan_object to
->scan_object the shrinker context can change. 

> This will work when called from
> some contexts but not from others (unrelated to allocation context),
> which is confusing. Therefore, what I'm saying is that if the only
> current use case is to defer work from shrinkers that currently skip
> work due to allocation context restraints, this might be better codified
> with something like the appended (untested) example patch. This may or
> may not be a preferable interface to the flag, but it's certainly not an
> overcomplication...

I don't think this is the right way to go.

I want the filesystem shrinkers to become entirely non-blocking so
that we can dynamically decide on an object-by-object basis whether
we can reclaim the object in GFP_NOFS context.

That is, a clean XFS inode that requires no special cleanup can be
reclaimed even in GFP_NOFS context. The problem we have is that
dentry reclaim can drop the last reference to an inode, causing
inactivation and hence modification. However, if it's only going to
move to the inode LRU and not evict the inode, we can reclaim that
dentry. Similarly for inodes - if evicting the inode is not going to
block or modify the inode, we can reclaim the inode even under
GFP_NOFS constraints. And the same for XFS indoes - it if's clean
we can reclaim it, GFP_NOFS context or not.

IMO, that's the direction we need to be heading in, and in those
cases the "deferred work" tends towards a count of objects we could
not reclaim during the scan because they require blocking work to be
done. i.e. deferred work is a boolean now because the GFP_NOFS
decision is boolean, but it's lays the ground work for deferred work
to be integrated at a much finer-grained level in the shrinker
scanning routines in future...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
