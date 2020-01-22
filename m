Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CED144D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 09:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVIWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 03:22:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51989 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgAVIWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:22:00 -0500
Received: from dread.disaster.area (pa49-181-218-253.pa.nsw.optusnet.com.au [49.181.218.253])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4087E82054C;
        Wed, 22 Jan 2020 19:21:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iuBGt-0002mm-AC; Wed, 22 Jan 2020 19:21:55 +1100
Date:   Wed, 22 Jan 2020 19:21:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        xfs <xfs@e29208.dscx.akamaiedge.net>,
        Steve French <smfrench@gmail.com>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LFS/MM TOPIC] fs reflink issues, fs online
 scrub/check, etc
Message-ID: <20200122082155.GA9317@dread.disaster.area>
References: <20160210191715.GB6339@birch.djwong.org>
 <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
 <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
 <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
 <20200121161840.GA8236@magnolia>
 <20200121220112.GB14467@bombadil.infradead.org>
 <CAPcyv4iPX4fDZGFwCkJxMDc-+1DjOMVZYVqnE=XTZpis6ZLFww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iPX4fDZGFwCkJxMDc-+1DjOMVZYVqnE=XTZpis6ZLFww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=TU0PeEMO9XNyODJ+pEfdLw==:117 a=TU0PeEMO9XNyODJ+pEfdLw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=7YfXLusrAAAA:8 a=7-415B0cAAAA:8 a=S4ei3vxw9mJ_NyWoTJ0A:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=SLz71HocmBbuEhFRYD3r:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:47:27PM -0800, Dan Williams wrote:
> On Tue, Jan 21, 2020 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jan 21, 2020 at 08:18:40AM -0800, Darrick J. Wong wrote:
> > > On Tue, Jan 21, 2020 at 09:35:22AM +0200, Amir Goldstein wrote:
> > > > On Tue, Jan 21, 2020 at 3:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > > >
> > > > > Didn't see the original mail, so reply here.
> > > >
> > > > Heh! Original email was from 2016, but most of Darrick's wish list is
> > > > still relevant in 2020 :)
> > >
> > > Grumble grumble stable behavior of clonerange/deduperange ioctls across
> > > filesystems grumble grumble.
> > >
> > > > I for one would be very interested in getting an update on the
> > > > progress of pagecache
> > > > page sharing if there is anyone working on it.
> > >
> > > Me too.  I guess it's the 21st, I should really send in a proposal for
> > > *this year's* LSFMMBPFLOLBBQ.
> >
> > I still have Strong Opinions on how pagecache page sharing should be done
> > ... and half a dozen more important projects ahead of it in my queue.
> > So I have no update on this.
> 
> We should plan to huddle on this especially if I don't get an RFC for
> dax-reflink support out before the summit.

It would be a good idea to share your ideas about how you plan to
solve this problem earlier rather than later so you don't waste time
going down a path that is incompatible with what the filesystems
need to/want to/can do.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
