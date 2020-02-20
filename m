Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E659166374
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBTQuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:50:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:1257 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBTQuC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:50:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 08:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="236298537"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2020 08:49:57 -0800
Date:   Thu, 20 Feb 2020 08:49:57 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200220164957.GB20772@iweiny-DESK2.sc.intel.com>
References: <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
 <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
 <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
 <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
 <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
 <20200218023535.GA14509@iweiny-DESK2.sc.intel.com>
 <x49zhdgasal.fsf@segfault.boston.devel.redhat.com>
 <20200218235429.GB14509@iweiny-DESK2.sc.intel.com>
 <20200220162027.GA20772@iweiny-DESK2.sc.intel.com>
 <20200220163024.GV9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220163024.GV9506@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:30:24AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 20, 2020 at 08:20:28AM -0800, Ira Weiny wrote:
> > On Tue, Feb 18, 2020 at 03:54:30PM -0800, 'Ira Weiny' wrote:
> > > On Tue, Feb 18, 2020 at 09:22:58AM -0500, Jeff Moyer wrote:
> > > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > > If my disassembly of read_pages is correct it looks like readpage is null which
> > > > > makes sense because all files should be IS_DAX() == true due to the mount option...
> > > > >
> > > > > But tracing code indicates that the patch:
> > > > >
> > > > > 	fs: remove unneeded IS_DAX() check
> > > > >
> > > > > ... may be the culprit and the following fix may work...
> > > > >
> > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > index 3a7863ba51b9..7eaf74a2a39b 100644
> > > > > --- a/mm/filemap.c
> > > > > +++ b/mm/filemap.c
> > > > > @@ -2257,7 +2257,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > > > >         if (!count)
> > > > >                 goto out; /* skip atime */
> > > > >  
> > > > > -       if (iocb->ki_flags & IOCB_DIRECT) {
> > > > > +       if (iocb->ki_flags & IOCB_DIRECT || IS_DAX(inode)) {
> > > > >                 struct file *file = iocb->ki_filp;
> > > > >                 struct address_space *mapping = file->f_mapping;
> > > > >                 struct inode *inode = mapping->host;
> > > > 
> > > > Well, you'll have to up-level the inode variable instantiation,
> > > > obviously.  That solves this particular issue.
> > > 
> > > Well...  This seems to be a random issue.  I've had BMC issues with
> > > my server most of the day...  But even with this patch I still get the failure
> > > in read_pages().  :-/
> > > 
> > > And I have gotten it to both succeed and fail with qemu...  :-/
> > 
> > ... here is the fix.  I made the change in xfs_diflags_to_linux() early on with
> > out factoring in the flag logic changes we have agreed upon...
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index 62d9f622bad1..d592949ad396 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1123,11 +1123,11 @@ xfs_diflags_to_linux(
> >                 inode->i_flags |= S_NOATIME;
> >         else
> >                 inode->i_flags &= ~S_NOATIME;
> > -       if (xflags & FS_XFLAG_DAX)
> > +
> > +       if (xfs_inode_enable_dax(ip))
> >                 inode->i_flags |= S_DAX;
> >         else
> >                 inode->i_flags &= ~S_DAX;
> > -
> >  }
> > 
> > But the one thing which tripped me up, and concerns me, is we have 2 functions
> > which set the inode flags.
> > 
> > xfs_diflags_to_iflags()
> > xfs_diflags_to_linux()
> > 
> > xfs_diflags_to_iflags() is geared toward initialization but logically they do
> > the same thing.  I see no reason to keep them separate.  Does anyone?
> > 
> > Based on this find, the discussion on behavior in this thread, and the comments
> > from Dave I'm reworking the series because the flag check/set functions have
> > all changed and I really want to be as clear as possible with both the patches
> > and the resulting code.[*]  So v4 should be out today including attempting to
> > document what we have discussed here and being as clear as possible on the
> > behavior.  :-D
> > 
> > Thanks so much for testing this!
> > 
> > Ira
> > 
> > [*] I will probably throw in a patch to remove xfs_diflags_to_iflags() as I
> > really don't see a reason to keep it.
> > 
> 
> I prefer you keep the one in xfs_iops.c since ioctls are a higher level
> function than general inode operations.

Makes sense.  Do you prefer the xfs_diflags_to_iflags() name as well?

Ira

> 
> --D
