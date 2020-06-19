Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAC201DD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 00:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFSWLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 18:11:00 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:50638 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728906AbgFSWLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:11:00 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id C9D62D5C875;
        Sat, 20 Jun 2020 08:10:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jmPDg-0000mg-Il; Sat, 20 Jun 2020 08:10:44 +1000
Date:   Sat, 20 Jun 2020 08:10:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
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
Message-ID: <20200619221044.GO2005@dread.disaster.area>
References: <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204033.GB1564@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=eqXBFi9LVwU8ObKSOJUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:40:33PM -0400, J. Bruce Fields wrote:
> On Fri, Jun 19, 2020 at 12:44:55PM +1000, Dave Chinner wrote:
> > On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> > > My memory was that after Jeff Layton's i_version patches, there wasn't
> > > really a significant performance hit any more, so the ability to turn it
> > > off is no longer useful.
> > 
> > Yes, I completely agree with you here. However, with some
> > filesystems allowing it to be turned off, we can't just wave our
> > hands and force enable the option. Those filesystems - if the
> > maintainers chose to always enable iversion - will have to go
> > through a mount option deprecation period before permanently
> > enabling it.
> 
> I don't understand why.
> 
> The filesystem can continue to let people set iversion or noiversion as
> they like, while under the covers behaving as if iversion is always set.
> I can't see how that would break any application.  (Or even how an
> application would be able to detect that the filesystem was doing this.)

It doesn't break functionality, but it affects performance. IOWs, it
can make certain workloads go a lot slower in some circumstances.
And that can result in unexectedly breaking SLAs or slow down a
complex, finely tuned data center wide workload to the point it no
longer meets requirements.  Such changes in behaviour are considered
a regression, especially if they result from a change that just
ignores the mount option that turned off that specific feature.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
