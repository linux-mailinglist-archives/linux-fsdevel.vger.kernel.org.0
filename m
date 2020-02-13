Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE615CEA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 00:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBMX3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 18:29:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:62149 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBMX3Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:29:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 15:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="227412724"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2020 15:29:24 -0800
Date:   Thu, 13 Feb 2020 15:29:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
 <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
 <20200213195839.GG6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213195839.GG6870@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:58:39AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 11:05:13AM -0800, Ira Weiny wrote:
> > On Thu, Feb 13, 2020 at 11:01:57AM -0800, 'Ira Weiny' wrote:
> > > On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> > > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > 
> >  
> > [snip]
> > 
> > > > Given that we document the dax mount
> > > > option as "the way to get dax," it may be a good idea to allow for a
> > > > user to selectively disable dax, even when -o dax is specified.  Is that
> > > > possible?
> > > 
> > > Not with this patch set.  And I'm not sure how that would work.  The idea was
> > > that -o dax was simply an override for users who were used to having their
> > > entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
> > > individual settings are saved so I don't think it makes sense to ignore the -o
> > > dax in favor of those settings.  Basically that would IMO make the -o dax
> > > useless.
> > 
> > Oh and I forgot to mention that setting 'dax' on the root of the FS basically
> > provides '-o dax' functionality by default with the ability to "turn it off"
> > for files.
> 
> Please don't further confuse FS_XFLAG_DAX and S_DAX.

Yes...  the above text is wrong WRT statx.  But setting the physical
XFS_DIFLAG2_DAX flag on the root directory will by default cause all files and
directories created there to be XFS_DIFLAG2_DAX and so forth on down the tree
unless explicitly changed.  This will be the same as mounting with '-o dax' but
with the ability to turn off dax for individual files.  Which I think is the
functionality Jeff is wanting.

>
> They are two
> separate flags with two separate behaviors:
> 
> FS_XFLAG_DAX is a filesystem inode metadata flag.
> 
> Setting FS_XFLAG_DAX on a directory causes all files and directories
> created within that directory to inherit FS_XFLAG_DAX.
> 
> Mounting with -o dax causes all files and directories created to have
> FS_XFLAG_DAX set regardless of the parent's status.

I don't believe this is true, either before _or_ after this patch set.

'-o dax' only causes XFS_MOUNT_DAX to be set which then cause S_DAX to be set.
It does not affect FS_XFLAG_DAX.  This is important because we don't want '-o
dax' to suddenly convert all files to DAX if '-o dax' is not used.

> 
> The FS_XFLAG_DAX can be get and set via the fs[g]etxattr ioctl.

Right statx was the wrong tool...

fs[g|s]etattr via the xfs_io -c 'chatttr|lsattr' is the correct tool.

> 
> -------
> 
> S_DAX is the flag that controls the IO path in the kernel for a given
> inode.
> 
> Loading a file inode into the kernel (via _iget) with FS_XFLAG_DAX set
> or creating a file inode that inherits FS_XFLAG_DAX causes the incore
> inode to have the S_DAX flag set if the storage device supports it.

Yes after reworking "Clean up DAX support check" I believe I've got it correct
now.  Soon to be in V4.

> 
> Files with S_DAX set use the dax IO paths through the kernel.
> 
> The S_DAX flag can be queried via statx.

Yes as a verification that the file is at that moment operating as dax.  It
will not return true for a directory ever.  My bad for saying that.  Sorry I
got my tools flags mixed up...

Ira

