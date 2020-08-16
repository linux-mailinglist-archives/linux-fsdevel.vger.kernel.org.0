Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E002459F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHPW4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Aug 2020 18:56:35 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56746 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgHPW4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:56:34 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 0BE371A9F4F;
        Mon, 17 Aug 2020 08:56:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k7RZc-0007fV-AP; Mon, 17 Aug 2020 08:56:20 +1000
Date:   Mon, 17 Aug 2020 08:56:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200816225620.GA28218@dread.disaster.area>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27541158.PQPtYaGs59@silver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=8pif782wAAAA:8 a=7-415B0cAAAA:8
        a=Cr2eSUj7GmzywrZnyUcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:01:36AM +0200, Christian Schoenebeck wrote:
> On Mittwoch, 12. August 2020 16:33:23 CEST Dr. David Alan Gilbert wrote:
> > > On macOS there was (or actually still is) even a quite complex API which
> > > separated forks into "resource forks" and "data forks", where resource
> > > forks were typically used as components of an application binary (e.g.
> > > menu structure, icons, executable binary modules, text and translations).
> > > So resource forks not only had names, they also had predefined 16-bit
> > > type identifiers:
> > > https://en.wikipedia.org/wiki/Resource_fork
> > 
> > Yeh, lots of different ways.
> > 
> > In a way, if you had a way to drop the 64kiB limit on xattr, then you
> > could have one type of object, but then add new ways of accessing them
> > as forks.
> 
> That's yet another question: should xattrs and forks share the same data- and 
> namespace, or rather be orthogonal to each other.

Completely orthogonal. Alternate data streams are not xattrs, and
xattrs are not ADS....

Indeed, most filesystems will not be able to implement ADS as
xattrs. xattrs are implemented as atomicly journalled metadata on
most filesytems, they cannot be used like a seekable file by
userspace at all. If you want ADS to masquerade as an xattr, then
you have to graft the entire file IO path onto filesytsem xattrs,
and that just ain't gonna work without a -lot- of development in
every filesystem that wants to support ADS.

We've already got a perfectly good presentation layer for user data
files that are accessed by file descriptors (i.e. directories
containing files), so that should be the presentation layer you seek
to extend.

IOWs, trying to use abuse xattrs for ADS support is a non-starter.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
