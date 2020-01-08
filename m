Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08F134564
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgAHOxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:53:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:51934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgAHOxv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:53:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2081AC44;
        Wed,  8 Jan 2020 14:53:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD5D0DA791; Wed,  8 Jan 2020 15:53:37 +0100 (CET)
Date:   Wed, 8 Jan 2020 15:53:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] Btrfs: make deduplication with range including the
 last block work
Message-ID: <20200108145336.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@suse.com>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-3-fdmanana@kernel.org>
 <20191229052240.GG13306@hungrycats.org>
 <CAL3q7H5FcdsA3NEcRae4iE5k8j8tHe-3KjKo_tTg6=fu0c_0gw@mail.gmail.com>
 <20200107181630.GB24056@hungrycats.org>
 <CAL3q7H58avTiOiTOuzTt-q3L0i5d9G10e+4j9f0RTps+bOH+1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H58avTiOiTOuzTt-q3L0i5d9G10e+4j9f0RTps+bOH+1w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:42:05AM +0000, Filipe Manana wrote:
> > > > Should these patches be marked for stable (5.0+, but see below for
> > > > caveats about 5.0)?  The bug affects 5.3 and 5.4 which are still active,
> > > > and dedupe is an important feature for some users.
> > >
> > > Usually I only mark things for stable that are critical: corruptions,
> > > crashes and memory leaks for example.
> > > I don't think this is a critical issue, since none of those things
> > > happen. It's certainly inconvenient to not have
> > > an extent fully deduplicated, but it's just that.
> >
> > In btrfs the reference counting is done by extent and extents are
> > immutable, so extents are either fully deduplicated, or not deduplicated
> > at all.  We have to dedupe every part of an extent, and if we fail to
> > do so, no data space is saved while metadata usage increases for the
> > new partial extent reference.
> 
> Yes, I know. That was explained in the cover letter, why allowing
> deduplication of the eof block is more important for btrfs than it is
> for xfs for example.
> 
> >
> > This bug means the dedupe feature is not usable _at all_ for single-extent
> > files with non-aligned EOF, and that is a significant problem for users
> > that rely on dedupe to manage space usage on btrfs (e.g. for build
> > servers where there are millions of duplicate odd-sized small files, and
> > the space savings from working dedupe can be 90% or more).  Doubling or
> > tripling space usage for the same data is beyond inconvenience.
> 
> Sure, I understand that, I know how btrfs manages extents and I'm well
> familiar with its cloning/deduplication implementation.
> 
> Still, it's not something I consider critical enough to get to stable,
> as there's no corruption, data loss or a crash.
> That doesn't mean the patches aren't going to stable branches, that
> depends on the maintainers of each subsystem (vfs, btrfs).

To me this looks like a usability bug and regression so I'm all for
adding it to stable. Less serious fixes than corruption, data loss and
crash land in stable kernels anyway, so if this fixes behaviour and
usecases then it qualifies.

I evaluate each patch for stable inclusion so the CC: stable is not
required to be in the patch itself when posted, and late requests
for inclusion to stable have been working well so we have the process in
place.
