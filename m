Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C7201F96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgFTB4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 21:56:34 -0400
Received: from fieldses.org ([173.255.197.46]:41234 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbgFTB4e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:56:34 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C14F191D8; Fri, 19 Jun 2020 21:56:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C14F191D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592618193;
        bh=px2fxrVRGaefarQd+BFyouZ0r8UsW3DJrqCLsAmy3qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9/sZJMpMOgd+/TkpaAoBFfhJJXx0Rt3kQv+PaHGiCUpVIwWIfRwp6CtiEPMpERoB
         apwrhYqnopPoBS5TNsHZUdB6O6Kj4KWRBuE43RfpCw5geLcE6VwwarEHXeY4pRTXrx
         3AErIh9dL/mYCpaZppI/hiDk67oG4cNXJLjt+f2E=
Date:   Fri, 19 Jun 2020 21:56:33 -0400
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
Message-ID: <20200620015633.GA1516@fieldses.org>
References: <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
 <20200619221044.GO2005@dread.disaster.area>
 <20200619222843.GB2650@fieldses.org>
 <20200620014957.GQ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620014957.GQ2005@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 11:49:57AM +1000, Dave Chinner wrote:
> On Fri, Jun 19, 2020 at 06:28:43PM -0400, J. Bruce Fields wrote:
> > On Sat, Jun 20, 2020 at 08:10:44AM +1000, Dave Chinner wrote:
> > > On Fri, Jun 19, 2020 at 04:40:33PM -0400, J. Bruce Fields wrote:
> > > > On Fri, Jun 19, 2020 at 12:44:55PM +1000, Dave Chinner wrote:
> > > > > On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> > > > > > My memory was that after Jeff Layton's i_version patches, there wasn't
> > > > > > really a significant performance hit any more, so the ability to turn it
> > > > > > off is no longer useful.
> > > > > 
> > > > > Yes, I completely agree with you here. However, with some
> > > > > filesystems allowing it to be turned off, we can't just wave our
> > > > > hands and force enable the option. Those filesystems - if the
> > > > > maintainers chose to always enable iversion - will have to go
> > > > > through a mount option deprecation period before permanently
> > > > > enabling it.
> > > > 
> > > > I don't understand why.
> > > > 
> > > > The filesystem can continue to let people set iversion or noiversion as
> > > > they like, while under the covers behaving as if iversion is always set.
> > > > I can't see how that would break any application.  (Or even how an
> > > > application would be able to detect that the filesystem was doing this.)
> > > 
> > > It doesn't break functionality, but it affects performance.
> > 
> > I thought you just agreed above that any performance hit was not
> > "significant".
> 
> Yes, but that's just /my opinion/.
> 
> However, other people have different opinions on this matter (and we
> know that from the people who considered XFS v4 -> v5 going slower
> because iversion a major regression), and so we must acknowledge
> those opinions even if we don't agree with them.

Do you have any of those reports handy?  Were there numbers?

--b.
