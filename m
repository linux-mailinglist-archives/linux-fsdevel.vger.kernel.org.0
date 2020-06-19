Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465ED201C8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgFSUkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:40:35 -0400
Received: from fieldses.org ([173.255.197.46]:44106 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390600AbgFSUke (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:40:34 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E69319240; Fri, 19 Jun 2020 16:40:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E69319240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592599233;
        bh=Nwr2TjWR0twmyJl4g+UHE0HD65IQmQxNQBQDjG7MlL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPPgIJGrSMzEicjrkX4pBRymXvBe6MpVKIEAB1esLdlGr3BBvEWp1y/aSguGD7R/g
         Kz2J1O0yxRcYsQiQL6J0nIbYiM79juBpk4yV+FyHfvnk4yoUPdy2+olfelnoz3pWCl
         4ilaucsIZStRcjFQ/vPmuMILvKZ0MlxEkgcUvy2U=
Date:   Fri, 19 Jun 2020 16:40:33 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200619204033.GB1564@fieldses.org>
References: <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619024455.GN2005@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:44:55PM +1000, Dave Chinner wrote:
> On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> > My memory was that after Jeff Layton's i_version patches, there wasn't
> > really a significant performance hit any more, so the ability to turn it
> > off is no longer useful.
> 
> Yes, I completely agree with you here. However, with some
> filesystems allowing it to be turned off, we can't just wave our
> hands and force enable the option. Those filesystems - if the
> maintainers chose to always enable iversion - will have to go
> through a mount option deprecation period before permanently
> enabling it.

I don't understand why.

The filesystem can continue to let people set iversion or noiversion as
they like, while under the covers behaving as if iversion is always set.
I can't see how that would break any application.  (Or even how an
application would be able to detect that the filesystem was doing this.)

--b.

> 
> > But looking back through Jeff's postings, I don't see him claiming that;
> > e.g. in:
> > 
> > 	https://lore.kernel.org/lkml/20171222120556.7435-1-jlayton@kernel.org/
> > 	https://lore.kernel.org/linux-nfs/20180109141059.25929-1-jlayton@kernel.org/
> > 	https://lore.kernel.org/linux-nfs/1517228795.5965.24.camel@redhat.com/
> > 
> > he reports comparing old iversion behavior to new iversion behavior, but
> > not new iversion behavior to new noiversion behavior.
> 
> Yeah, it's had to compare noiversion behaviour on filesystems where
> it was understood that it couldn't actually be turned off. And,
> realistically, the comaprison to noiversion wasn't really relevant
> to the problem Jeff's patchset was addressing...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
