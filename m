Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE015853A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 22:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBJVrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 16:47:13 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54828 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgBJVrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:47:13 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id ECB3F7EB6F4;
        Tue, 11 Feb 2020 08:46:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1GtN-0003Dl-H9; Tue, 11 Feb 2020 08:46:57 +1100
Date:   Tue, 11 Feb 2020 08:46:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200210214657.GA10776@dread.disaster.area>
References: <20200207170423.377931-1-jlayton@kernel.org>
 <20200207205243.GP20628@dread.disaster.area>
 <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=s3qtZW705j5wTvdfxYMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:20:12PM -0800, Andres Freund wrote:
> Hi,
> 
> On 2020-02-08 07:52:43 +1100, Dave Chinner wrote:
> > On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> > > You're probably wondering -- Where are v1 and v2 sets?
> 
> > > The basic idea is to track writeback errors at the superblock level,
> > > so that we can quickly and easily check whether something bad happened
> > > without having to fsync each file individually. syncfs is then changed
> > > to reliably report writeback errors, and a new ioctl is added to allow
> > > userland to get at the current errseq_t value w/o having to sync out
> > > anything.
> > 
> > So what, exactly, can userspace do with this error? It has no idea
> > at all what file the writeback failure occurred on or even
> > what files syncfs() even acted on so there's no obvious error
> > recovery that it could perform on reception of such an error.
> 
> Depends on the application.  For e.g. postgres it'd to be to reset
> in-memory contents and perform WAL replay from the last checkpoint.

What happens if a user runs 'sync -f /path/to/postgres/data' instead
of postgres? All the writeback errors are consumed at that point by
reporting them to the process that ran syncfs()...

> Due
> to various reasons* it's very hard for us (without major performance
> and/or reliability impact) to fully guarantee that by the time we fsync
> specific files we do so on an old enough fd to guarantee that we'd see
> the an error triggered by background writeback.  But keeping track of
> all potential filesystems data resides on (with one fd open permanently
> for each) and then syncfs()ing them at checkpoint time is quite doable.

Oh, you have to keep an fd permanently open to every superblock that
application holds data on so that errors detected by other users of
that filesystem are also reported to the application?

This seems like a fairly important requirement for applications to
ensure this error reporting is "reliable" and that certainly wasn't
apparent from the patches or their description.  i.e. the API has an
explicit userspace application behaviour requirement for reliable
functioning, and that was not documented.  "we suck at APIs" and all
that..

It also seems to me as useful only to applications that have a
"rollback and replay" error recovery mechanism. If the application
doesn't have the ability to go back in time to before the
"unfindable" writeback error occurred, then this error is largely
useless to those applications because they can't do anything with
it, and so....

> > > - This adds a new generic fs ioctl to allow userland to scrape
> > > the current superblock's errseq_t value. It may be best to
> > > present this to userland via fsinfo() instead (once that's
> > > merged). I'm fine with dropping the last patch for now and
> > > reworking it for fsinfo if so.
> > 
> > What, exactly, is this useful for? Why would we consider
> > exposing an internal implementation detail to userspace like
> > this?
> 
> There is, as far as I can tell, so far no way but scraping the
> kernel log to figure out if there have been data loss errors on a
> machine/fs.

.... most applications will still require users to scrape their
logs to find out what error actually occurred. IOWs, we haven't
really changed the status quo with this new mechanism.

FWIW, explicit userspace error notifications for data loss events is
one of the features that David Howell's generic filesystem
notification mechanism is intended to provide.  Hence I'm not sure
that there's a huge amount of value in providing a partial solution
that only certain applications can use when there's a fully generic
mechanism for error notification just around the corner.

> Even besides app specific reactions like outlined above,
> just generally being able to alert whenever there error count
> increases seems extremely useful.

Yup, a generic filesystem notification mechanism is perfect for
that, plus it can provide more explicit details of where the error
actually occurred rather than jsut a handwavy "some error occurred
some where" report....

> I'm not sure it makes sense to
> expose the errseq_t bits straight though - seems like it'd
> enshrine them in userspace ABI too much?

Even a little is way too much. Userspace ABI needs to be completely
independent of the kernel internal structures and implementation.
This is basic "we suck at APIs 101" stuff...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
