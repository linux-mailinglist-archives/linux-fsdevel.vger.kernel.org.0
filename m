Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022362F25E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbhALByH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:54:07 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:42952 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728970AbhALByH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:54:07 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id AB0DB822743;
        Tue, 12 Jan 2021 12:53:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8rs-005XE3-NQ; Tue, 12 Jan 2021 12:53:08 +1100
Date:   Tue, 12 Jan 2021 12:53:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 1/6] iomap: convert iomap_dio_rw() to an args structure
Message-ID: <20210112015308.GR331610@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-2-david@fromorbit.com>
 <20210112014023.GN1164246@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112014023.GN1164246@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=6QHMontGZzSAw98rcsMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:40:23PM -0800, Darrick J. Wong wrote:
> On Tue, Jan 12, 2021 at 12:07:41PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Adding yet another parameter to the iomap_dio_rw() interface means
> > changing lots of filesystems to add the parameter. Convert this
> > interface to an args structure so in future we don't need to modify
> > every caller to add a new parameter.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/btrfs/file.c       | 21 ++++++++++++++++-----
> >  fs/ext4/file.c        | 24 ++++++++++++++++++------
> >  fs/gfs2/file.c        | 19 ++++++++++++++-----
> >  fs/iomap/direct-io.c  | 30 ++++++++++++++----------------
> >  fs/xfs/xfs_file.c     | 30 +++++++++++++++++++++---------
> >  fs/zonefs/super.c     | 21 +++++++++++++++++----
> >  include/linux/iomap.h | 16 ++++++++++------
> >  7 files changed, 110 insertions(+), 51 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 0e41459b8de6..a49d9fa918d1 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1907,6 +1907,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	ssize_t err;
> >  	unsigned int ilock_flags = 0;
> >  	struct iomap_dio *dio = NULL;
> > +	struct iomap_dio_rw_args args = {
> > +		.iocb			= iocb,
> > +		.iter			= from,
> > +		.ops			= &btrfs_dio_iomap_ops,
> > +		.dops			= &btrfs_dio_ops,
> 
> /me wonders if it would make sense to move all the iomap_dio_ops fields
> into iomap_dio_rw_args to reduce pointer dereferencing when making the
> indirect call?

Perhaps so - there are only two ops defined in that structure so
there's not a whole lot of gain/loss there either way.  Trivial to
do, though, with them encapsulated in this structure...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
