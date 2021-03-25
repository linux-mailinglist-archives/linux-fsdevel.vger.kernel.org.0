Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E88349CA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 00:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCYXD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 19:03:28 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:37604 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhCYXDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:03:18 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 37A0F2AE6;
        Fri, 26 Mar 2021 10:03:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lPZ0S-006l4K-1N; Fri, 26 Mar 2021 10:03:12 +1100
Date:   Fri, 26 Mar 2021 10:03:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <20210325230312.GN63242@dread.disaster.area>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area>
 <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area>
 <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
 <20210324074318.GA2646094@infradead.org>
 <CAOQ4uxgOi9hxDaL7Rk8OU3O-S+YuvDZPtpN7PggXfL=COyrc0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgOi9hxDaL7Rk8OU3O-S+YuvDZPtpN7PggXfL=COyrc0Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=axe3pCkCbSIAKNk3-JAA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=fCgQI5UlmZDRPDxm0A3o:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:18:36AM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 9:43 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Mar 24, 2021 at 08:53:25AM +0200, Amir Goldstein wrote:
> > > > This also means that userspace can be entirely filesystem agnostic
> > > > and it doesn't need to rely on parsing proc files to translate
> > > > ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
> > > > stable enough that it doesn't get the destination wrong.  It also
> > > > means that fanotify UAPI probably no longer needs to supply a
> > > > f_fsid with the filehandle because it is built into the
> > > > filehandle....
> > > >
> > >
> > > That is one option. Let's call it the "bullet proof" option.
> > >
> > > Another option, let's call it the "pragmatic" options, is that you accept
> > > that my patch shouldn't break anything and agree to apply it.
> >
> > Your patch may very well break something.  Most Linux file systems do
> > store the dev_t in the fsid and userspace may for whatever silly
> > reasons depend on it.
> >
> 
> I acknowledge that.
> I do not claim that my change carries zero risk of breakage.
> However, if such userspace dependency exists, it would break on ext4,
> btrfs, ocsf2, ceph and many more fs, so it would have to be a
> dependency that is tightly coupled with a specific fs.
> The probability of that is rather low IMO.
> 
> I propose an opt-in mount option "-o fixed_fsid" for this behavior to make
> everyone sleep better.

Layering hacks on top of hacks to avoid fixing the fanotify UAPI
limitations isn't a very palatable option. Especially those that
require adding mount options we'll have to support forever more...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
