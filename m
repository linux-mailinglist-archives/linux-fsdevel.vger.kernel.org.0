Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAE2E78D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE2Vly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:41:54 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:41277 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbfE2Vly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:41:54 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 282863DB93C;
        Thu, 30 May 2019 07:41:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hW6KP-0007gQ-KE; Thu, 30 May 2019 07:41:45 +1000
Date:   Thu, 30 May 2019 07:41:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] vfs: introduce file_modified() helper
Message-ID: <20190529214145.GC29573@dread.disaster.area>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-7-amir73il@gmail.com>
 <20190529182748.GF5231@magnolia>
 <CAOQ4uxgsMLTPtYaQwwNHo3NrzXz9u=YGc2v6Pg8TSo7-xFrqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgsMLTPtYaQwwNHo3NrzXz9u=YGc2v6Pg8TSo7-xFrqQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=uk_6IFGgYTW1qpM8YJcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 10:08:44PM +0300, Amir Goldstein wrote:
> On Wed, May 29, 2019 at 9:27 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Wed, May 29, 2019 at 08:43:10PM +0300, Amir Goldstein wrote:
> > > The combination of file_remove_privs() and file_update_mtime() is
> > > quite common in filesystem ->write_iter() methods.
> > >
> > > Modelled after the helper file_accessed(), introduce file_modified()
> > > and use it from generic_remap_file_range_prep().
> > >
> > > Note that the order of calling file_remove_privs() before
> > > file_update_mtime() in the helper was matched to the more common order by
> > > filesystems and not the current order in generic_remap_file_range_prep().
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/inode.c         | 20 ++++++++++++++++++++
> > >  fs/read_write.c    | 21 +++------------------
> > >  include/linux/fs.h |  2 ++
> > >  3 files changed, 25 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index df6542ec3b88..2885f2f2c7a5 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1899,6 +1899,26 @@ int file_update_time(struct file *file)
> > >  }
> > >  EXPORT_SYMBOL(file_update_time);
> > >
> > > +/* Caller must hold the file's inode lock */
> > > +int file_modified(struct file *file)
> > > +{
> > > +     int err;
> > > +
> > > +     /*
> > > +      * Clear the security bits if the process is not being run by root.
> > > +      * This keeps people from modifying setuid and setgid binaries.
> > > +      */
> > > +     err = file_remove_privs(file);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     if (likely(file->f_mode & FMODE_NOCMTIME))
> >
> > I would not have thought NOCMTIME is likely?
> >
> > Maybe it is for io requests coming from overlayfs, but for regular uses
> > I don't think that's true.
> 
> Nope that's a typo. Good spotting.
> Overlayfs doesn't set FMODE_NOCMTIME (yet). Only xfs does from
> XFS_IOC_OPEN_BY_HANDLE, but I think Dave said that is a deprecated
> API. so should have been very_unlikely().

It is most definitely not a deprecated API. I don't know where you
got that idea from. It's used explicitly by the xfs utilities to
perform invisible IO. Anyone who runs xfs_fsr or xfsdump or has an
application that links to libhandle is using XFS_IOC_OPEN_BY_HANDLE
and FMODE_NOCMTIME....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
