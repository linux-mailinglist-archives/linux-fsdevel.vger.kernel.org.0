Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F05149017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 22:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAXVZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 16:25:53 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45117 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgAXVZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:25:52 -0500
Received: from dread.disaster.area (pa49-195-162-125.pa.nsw.optusnet.com.au [49.195.162.125])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E7221820959;
        Sat, 25 Jan 2020 08:25:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iv6SY-0007Gt-DD; Sat, 25 Jan 2020 08:25:46 +1100
Date:   Sat, 25 Jan 2020 08:25:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200124212546.GC7216@dread.disaster.area>
References: <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader>
 <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area>
 <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=eqEhQ2W7mF93FbYHClaXRw==:117 a=eqEhQ2W7mF93FbYHClaXRw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Z3zTFTHKMSASxNrl138A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:47:30AM +0200, Amir Goldstein wrote:
> On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > >
> > > > > Sorry for not reading all the thread again, some API questions:
> > > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > >
> > > > I wasn't planning on having that restriction. It's not too much effort
> > > > for filesystems to support it for normal files, so I wouldn't want to
> > > > place an artificial restriction on a useful primitive.
> > >
> 
> I have too many gray hairs each one for implementing a "useful primitive"
> that nobody asked for and bare the consequences.
> Your introduction to AT_REPLACE uses O_TMPFILE.
> I see no other sane use of the interface.
> 
> > > I'm not sure; that's how we ended up with the unspeakable APIs like
> > > rename(2), after all...
> >
> > Yet it is just rename(2) with the serial numbers filed off -
> > complete with all the same data vs metadata ordering problems that
> > rename(2) comes along with. i.e. it needs fsync to guarantee data
> > integrity of the source file before the linkat() call is made.
> >
> > If we can forsee that users are going to complain that
> > linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> > leaves zero length files behind after a crash just like rename()
> > does, then we haven't really improved anything at all...
> >
> > And, really, I don't think anyone wants another API that requires
> > multiple fsync calls to use correctly for crash-safe file
> > replacement, let alone try to teach people who still cant rename a
> > file safely how to use it....
> >
> 
> Are you suggesting that AT_LINK_REPLACE should have some of
> the semantics I posted in this RFC  for AT_ATOMIC_xxx:
> https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/

Not directly.

All I'm pointing out is that data integrity guarantees of
AT_LINK_REPLACE are yet another aspect of this new feature that
has not yet been specified or documented at all.

And in pointing this out, I'm making an observation that the
rename(2) behaviour which everyone seems to be assuming this
function will replicate is a terrible model to copy/reinvent.

Addressing this problem is something for the people pushing for
AT_LINK_REPLACE to solve, not me....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
