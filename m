Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249BB1F1EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgFHSBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 14:01:35 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:40245 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729550AbgFHSBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:01:34 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id EF700C4AC4
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 19:01:31 +0100 (IST)
Received: (qmail 19019 invoked from network); 8 Jun 2020 18:01:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jun 2020 18:01:31 -0000
Date:   Mon, 8 Jun 2020 19:01:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200608180130.GJ3127@techsingularity.net>
References: <20200608140557.GG3127@techsingularity.net>
 <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net>
 <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 07:26:10PM +0300, Amir Goldstein wrote:
> > > What this work does essentially is two things:
> > > 1. Call backend once instead of twice when both inode and parent are
> > >     watching.
> > > 2. Snapshot name and parent inode to pass to backend not only when
> > >     parent is watching, but also when an sb/mnt mark exists which
> > >     requests to get file names with events.
> > >
> > > Compared to the existing implementation of fsnotify_parent(),
> > > my code needs to also test bits in inode->i_fsnotify_mask,
> > > inode->i_sb->s_fsnotify_mask and mnt->mnt_fsnotify_mask
> > > before the fast path can be taken.
> > > So its back to square one w.r.t your optimizations.
> > >
> >
> > Seems fair but it may be worth noting that the changes appear to be
> > optimising the case where there are watchers. The case where there are
> > no watchers at all is also interesting and probably a lot more common. I
> 
> My changes are not optimizations. They are for adding functionality.
> Surely, that shouldn't come at a cost for the common case.
> 

My bad. I interpreted the folding of fsnotify_parent calling fsnotify to
be a potential optimisation particularly if it bailed earlier (which it
doesn't do but maybe it could).

> > didn't look too closely at your series as I'm not familiar with fsnotify
> > in general. However, at a glance it looks like fsnotify_parent() executes
> > a substantial amount of code even if there are no watchers but I could
> > be wrong.
> >
> 
> I don't about substantial, I would say it is on par with the amount of
> code that you tries to optimize out of fsnotify().
> 
> Before bailing out with DCACHE_FSNOTIFY_PARENT_WATCHED
> test, it also references d_inode->i_sb,  real_mount(path->mnt)
> and fetches all their ->x_fsnotify_mask fields.
> 
> I changed the call pattern from open/modify/... hooks from:
> fsnotify_parent(...);
> fsnotify(...);
> 
> to:
> fsnotify_parent(...); /* which calls fsnotify() */
> 
> So the NULL marks optimization could be done in beginning of
> fsnotify_parent() and it will be just as effective as it is in fsnotify().
> 

Something like that may be required because

                              5.7.0                  5.7.0                  5.7.0                  5.7.0
                            vanilla      fastfsnotify-v1r1      fastfsnotify-v2r1          amir-20200608
Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*      0.4597 *   4.96%*      0.4967 *  -2.69%*
Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)      1.5310 (   0.88%)      1.6587 *  -7.38%*
Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)      2.4237 (   6.91%)      2.6400 (  -1.40%)
Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)      3.6543 (  -1.55%)      3.9040 *  -8.48%*
Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)      5.5903 (   4.06%)      6.2593 (  -7.43%)
Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)      7.7150 *   8.59%*      8.9940 (  -6.56%)
Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*      9.8977 *  10.17%*     11.7247 *  -6.41%*
Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)     12.2087 *   6.81%*     14.0290 *  -7.08%*
Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)     13.2900 (   4.52%)     14.7140 *  -5.71%*

vanilla and fastnotify-v1r1 are the same. fastfsnotify-v2r1 is just the
fsnotify_parent() change which is mostly worse and may indicate that the
first patch was reasonable. amir-20200608 is your branch as of today and
it appears to introduce a substantial regression albeit in an extreme case
where fsnotify overhead is visible. The regressions are mostly larger
than noise with the caveat it may be machine specific given that the
machine is overloaded. I accept that adding extra functional to fsnotify
may be desirable but ideally it would not hurt the case where there are
no watchers at all.

So what's the right way forward? The patch as-is even though the fsnotify()
change itself may be marginal, a patch that just inlines the fast path
of fsnotify_parent or wait for the additional functionality and try and
address the overhead on top?

-- 
Mel Gorman
SUSE Labs
