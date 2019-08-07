Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531AA84A68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfHGLNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 07:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfHGLNx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 170ED69066;
        Wed,  7 Aug 2019 11:13:53 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C3031E4;
        Wed,  7 Aug 2019 11:13:52 +0000 (UTC)
Date:   Wed, 7 Aug 2019 07:13:50 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm: directed shrinker work deferral
Message-ID: <20190807111350.GA19707@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-2-david@fromorbit.com>
 <20190802152709.GA60893@bfoster>
 <20190804014930.GR7777@dread.disaster.area>
 <20190805174226.GB14760@bfoster>
 <20190805234318.GB7777@dread.disaster.area>
 <20190806122754.GA2979@bfoster>
 <20190806222220.GL7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806222220.GL7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 07 Aug 2019 11:13:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 08:22:20AM +1000, Dave Chinner wrote:
> On Tue, Aug 06, 2019 at 08:27:54AM -0400, Brian Foster wrote:
> > If you add a generic "defer work" knob to the shrinker mechanism, but
> > only process it as an "allocation context" check, I expect it could be
> > easily misused. For example, some shrinkers may decide to set the the
> > flag dynamically based on in-core state.
> 
> Which is already the case. e.g. There are shrinkers that don't do
> anything because a try-lock fails.  I haven't attempted to change
> them, but they are a clear example of how even ->scan_object to
> ->scan_object the shrinker context can change. 
> 

That's a similar point to what I'm trying to make wrt to
->count_objects() and the new defer state..

> > This will work when called from
> > some contexts but not from others (unrelated to allocation context),
> > which is confusing. Therefore, what I'm saying is that if the only
> > current use case is to defer work from shrinkers that currently skip
> > work due to allocation context restraints, this might be better codified
> > with something like the appended (untested) example patch. This may or
> > may not be a preferable interface to the flag, but it's certainly not an
> > overcomplication...
> 
> I don't think this is the right way to go.
> 
> I want the filesystem shrinkers to become entirely non-blocking so
> that we can dynamically decide on an object-by-object basis whether
> we can reclaim the object in GFP_NOFS context.
> 

This is why I was asking about whether/how you envisioned the defer flag
looking in the future. Though I think this is somewhat orthogonal to the
discussion between having a bool or internal alloc mask set, because
both are of the same granularity and would need to change to operate on
a per objects basis.

> That is, a clean XFS inode that requires no special cleanup can be
> reclaimed even in GFP_NOFS context. The problem we have is that
> dentry reclaim can drop the last reference to an inode, causing
> inactivation and hence modification. However, if it's only going to
> move to the inode LRU and not evict the inode, we can reclaim that
> dentry. Similarly for inodes - if evicting the inode is not going to
> block or modify the inode, we can reclaim the inode even under
> GFP_NOFS constraints. And the same for XFS indoes - it if's clean
> we can reclaim it, GFP_NOFS context or not.
> 
> IMO, that's the direction we need to be heading in, and in those
> cases the "deferred work" tends towards a count of objects we could
> not reclaim during the scan because they require blocking work to be
> done. i.e. deferred work is a boolean now because the GFP_NOFS
> decision is boolean, but it's lays the ground work for deferred work
> to be integrated at a much finer-grained level in the shrinker
> scanning routines in future...
> 

Yeah, this sounds more like it warrants a ->nr_deferred field or some
such, which could ultimately replace either of the previously discussed
options for deferring the entire instance. BTW, ISTM we could use that
kind of interface now for exactly what this patch is trying to
accomplish by changing those shrinkers with allocation context
restrictions to just transfer the entire scan count to the deferred
count in ->scan_objects() instead of setting the flag. That's somewhat
less churn in the long run because we aren't shifting the defer logic
back and forth between the count and scan callbacks unnecessarily. IMO,
it's also a cleaner interface than both options above.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
