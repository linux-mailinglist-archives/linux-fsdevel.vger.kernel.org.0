Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271EF492D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiARSZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 13:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347657AbiARSZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642530321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3MhpNbODvMKo6hEJEGqgokJYKmNiOJQtUtppd6rmbf4=;
        b=FPa9DLbTm9brOxECzmB6wzaia46oYbDO9uukd0nTnwhu8PId5J5vwUR4bOA1fc5owdeRar
        aNtXUj4e8rJkj8vAQQBYionUUYEj6X0S+3DR1SL+bdq7ev2LTOublx4+CRQCqHRf8F3iDK
        r79qf92UKYmzTnLW9XCrylh3V8hda+E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-nS1bYyJQPtOANjB_gPzmPw-1; Tue, 18 Jan 2022 13:25:19 -0500
X-MC-Unique: nS1bYyJQPtOANjB_gPzmPw-1
Received: by mail-qk1-f199.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso16578755qko.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 10:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MhpNbODvMKo6hEJEGqgokJYKmNiOJQtUtppd6rmbf4=;
        b=bA6RA7SK6nI7c4w8O2bro05iJ7hDkySTxBd0ywpGtDci2ejwJzvDo4MEuW5GuBpy4N
         xfQqGU+vD/xLKKaqX7kwVk14b0Gt6kgJwFTrHIG6Ui9Dfst5MZpL1RHtFVdz/OXsLATk
         /y3c7enw+5jI43lyraZ6K0IwP+49t1SZ/ukrq9WcbAwCBbvyQhixSYw8PueuIGN+dLhH
         m//55JbycbuLukc2DXmWqg4WVM6A4eCMMk9s9bzgXdwP2rHlRzNd99RCjxTS/PEO6/BS
         dR86cyixYXu3mZWhoP8pju2UMrVHoWDXW7YqXizivCOGSeFMOYDeqIz8AaeajqsGRCUp
         G1Sg==
X-Gm-Message-State: AOAM532MvALKunHGgyRTUORu0KknrkjYMTxeMWvQC27VbVpL6qwYKXQe
        HyjEfzOjHdNlIwdEzh5gjOfNIEcd42K2Q2x0aQPfx2BVCpPX0teIkB42g1g/jA8ZaQVZPomJUx0
        Z+WPcyZmYBaKv2znTDkCaNibhrQ==
X-Received: by 2002:a05:620a:4594:: with SMTP id bp20mr8982488qkb.556.1642530318566;
        Tue, 18 Jan 2022 10:25:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz91UOaUCACPM5lW3+SnvOJUJ/BJjaJLu9ntSYbEtlWK59wTvQ1gzG7iB444j0LBlkTzVEp/Q==
X-Received: by 2002:a05:620a:4594:: with SMTP id bp20mr8982468qkb.556.1642530318231;
        Tue, 18 Jan 2022 10:25:18 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f14sm195078qtf.81.2022.01.18.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:25:17 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:25:15 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YecGC06UrGrfonS0@bfoster>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
 <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
 <YebFCeLcbziyMjbA@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YebFCeLcbziyMjbA@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:47:53AM -0500, Brian Foster wrote:
> On Tue, Jan 18, 2022 at 01:32:23AM +0000, Al Viro wrote:
> > On Mon, Jan 17, 2022 at 07:48:49PM +0000, Al Viro wrote:
> > > > But that critically depends upon the contents not getting mangled.  If it
> > > > *can* be screwed by such unlink, we risk successful lookup leading to the
> > > > wrong place, with nothing to tell us that it's happening.  We could handle
> > > > that by adding a check to fs/namei.c:put_link(), and propagating the error
> > > > to callers.  It's not impossible, but it won't be pretty.
> > > > 
> > > > And that assumes we avoid oopsen on string changing under us in the first
> > > > place.  Which might or might not be true - I hadn't finished the audit yet.
> > > > Note that it's *NOT* just fs/namei.c + fs/dcache.c + some fs methods -
> > > > we need to make sure that e.g. everything called by ->d_hash() instances
> > > > is OK with strings changing right under them.  Including utf8_to_utf32(),
> > > > crc32_le(), utf8_casefold_hash(), etc.
> > > 
> > > And AFAICS, ext4, xfs and possibly ubifs (I'm unfamiliar with that one and
> > > the call chains there are deep enough for me to miss something) have the
> > > "bugger the contents of string returned by RCU ->get_link() if unlink()
> > > happens" problem.
> > > 
> > > I would very much prefer to have them deal with that crap, especially
> > > since I don't see why does ext4_evict_inode() need to do that memset() -
> > > can't we simply check ->i_op in ext4_can_truncate() and be done with
> > > that?
> > 
> > This reuse-without-delay has another fun side, AFAICS.  Suppose the new use
> > for inode comes with the same ->i_op (i.e. it's a symlink again) and it
> > happens right after ->get_link() has returned the pointer to body.
> > 
> 
> Yep, I had reproduced this explicitly when playing around with some
> instrumented delays and whatnot in the code. This and the similar
> variant of just returning internal/non-string data fork metadata via
> ->get_link() is why I asked to restore old behavior of returning -ECHILD
> for inline symlinks.
> 
> > We are already past whatever checks we might add in pick_link().  And the
> > pointer is still valid.  So we end up quietly traversing the body of
> > completely unrelated symlink that never had been anywhere near any directory
> > we might be looking at.  With no indication of anything going wrong - just
> > a successful resolution with bogus result.
> > 
> > Could XFS folks explain what exactly goes wrong if we make actual marking
> > inode as ready for reuse RCU-delayed, by shifting just that into
> > ->free_inode()?  Why would we need any extra synchronize_rcu() anywhere?
> > 
> 
> Dave already chimed in on why we probably don't want ->free_inode()
> across the board. I don't think there's a functional problem with a more
> selective injection of an rcu delay on the INACTIVE -> RECLAIMABLE
> transition, based on the reasoning specified earlier (i.e., the iget
> side already blocks on INACTIVE, so it's just a matter of a longer
> delay).
> 
> Most of that long thread I previously linked to was us discussing pretty
> much how to do something like that with minimal performance impact. The
> experiment I ran to measure performance was use of queue_rcu_work() for
> inactive inode processing. That resulted in a performance hit to single
> threaded sequential file removal, but could be mitigated by increasing
> the queue size (which may or may not have other side effects). Dave
> suggested a more async approach to track the current grace period in the
> inode and refer to it at lookup/alloc time, but that is notably more
> involved and isn't clear if/how much it mitigates rcu delays.
> 
> IIUC, your thought here is to introduce an rcu delay on the destroy
> side, but after the inactive processing rather than before it (as my
> previous experiment did). IOW, basically invoke
> xfs_inodegc_set_reclaimable() as an rcu callback via
> xfs_inodegc_worker(), yes? If so, that seems like a potentially
> reasonable option to me since it pulls the delay out of the inactivation
> processing pipeline. I suspect the tradeoff with that is it might be
> slightly less efficient than doing it earlier because we've lost any
> grace period transitions that have occurred since before the inode was
> queued and processed, but OTOH this might isolate the impact of that
> delay to the inode reuse path. Maybe there's room for a simple
> optimization there in cases where a gp may have expired already since
> the inode was first queued. Hmm.. maybe I'll give that a try to see
> if/how much impact there may be on an inode alloc/free workload..
> 

Here are results from a few quick tests running a tight inode alloc/free
loop against an XFS filesystem with some concurrent kernel source tree
recursive ls activity running on a separate (XFS) filesystem in the
background. The loop runs for 60s and reports how many create/unlink
cycles it was able to perform in that time:

Baseline (xfs for-next, v5.16.0-rc5):	~34k cycles
inactive -> reclaimable grace period:	~29k cycles
unconditional iget rcu sync:		~4400 cycles

Note that I did get a lockdep splat from _set_reclaimable() in rcu
context that I've ignored for now because the test completed. That
aside, that looks like about a ~15% or so hit from baseline. The last
test inserts an unconditional synchronize_rcu() in the iget recycle path
to provide a reference for the likely worst case implementation.

If I go back to the inactive -> reclaimable grace period variant and
also insert a start_poll_synchronize_rcu() and
poll_state_synchronize_rcu() pair across the inactive processing
sequence, I start seeing numbers closer to ~36k cycles. IOW, the
xfs_inodegc_inactivate() helper looks something like this:

        if (poll_state_synchronize_rcu(ip->i_destroy_gp))
                xfs_inodegc_set_reclaimable(ip);
        else
                call_rcu(&VFS_I(ip)->i_rcu, xfs_inodegc_set_reclaimable_callback);

... to skip the rcu grace period if one had already passed while the
inode sat on the inactivation queue and was processed.

However my box went haywire shortly after with rcu stall reports or
something if I let that continue to run longer, so I'll probably have to
look into that lockdep splat (complaining about &pag->pag_ici_lock in
rcu context, perhaps needs to become irq safe?) or see if something else
is busted..

Brian

> Brian

