Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3E15F76E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 21:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbgBNUGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 15:06:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:1060 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbgBNUGJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:06:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 12:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="407100179"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2020 12:06:07 -0800
Date:   Fri, 14 Feb 2020 12:06:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
 <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
 <20200213195839.GG6870@magnolia>
 <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:16:17PM -0800, Dan Williams wrote:
> On Thu, Feb 13, 2020 at 3:29 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Thu, Feb 13, 2020 at 11:58:39AM -0800, Darrick J. Wong wrote:
> > > On Thu, Feb 13, 2020 at 11:05:13AM -0800, Ira Weiny wrote:
> > > > On Thu, Feb 13, 2020 at 11:01:57AM -0800, 'Ira Weiny' wrote:
> > > > > On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> > > > > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > > >
> > > >
> > > > [snip]
> > > >
> > > > > > Given that we document the dax mount
> > > > > > option as "the way to get dax," it may be a good idea to allow for a
> > > > > > user to selectively disable dax, even when -o dax is specified.  Is that
> > > > > > possible?
> > > > >
> > > > > Not with this patch set.  And I'm not sure how that would work.  The idea was
> > > > > that -o dax was simply an override for users who were used to having their
> > > > > entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
> > > > > individual settings are saved so I don't think it makes sense to ignore the -o
> > > > > dax in favor of those settings.  Basically that would IMO make the -o dax
> > > > > useless.
> > > >
> > > > Oh and I forgot to mention that setting 'dax' on the root of the FS basically
> > > > provides '-o dax' functionality by default with the ability to "turn it off"
> > > > for files.
> > >
> > > Please don't further confuse FS_XFLAG_DAX and S_DAX.
> >
> > Yes...  the above text is wrong WRT statx.  But setting the physical
> > XFS_DIFLAG2_DAX flag on the root directory will by default cause all files and
> > directories created there to be XFS_DIFLAG2_DAX and so forth on down the tree
> > unless explicitly changed.  This will be the same as mounting with '-o dax' but
> > with the ability to turn off dax for individual files.  Which I think is the
> > functionality Jeff is wanting.
> 
> To be clear you mean turn off XFS_DIFLAG2_DAX, not mask S_DAX when you
> say "turn off dax", right?

Yes.

[disclaimer: the following assumes the underlying 'device' (superblock)
supports DAX]

... which results in S_DAX == false when the file is opened without the mount
option.  The key would be that all directories/files created under a root with
XFS_DIFLAG2_DAX == true would inherit their flag and be XFS_DIFLAG2_DAX == true
all the way down the tree.  Any file not wanting DAX would need to set
XFS_DIFLAG2_DAX == false.  And setting false could be used on a directory to
allow a user or group to not use dax on files in that sub-tree.

Then without '-o dax' (XFS_MOUNT_DAX == false) all files when opened set S_DAX
equal to XFS_DIFLAG2_DAX value.  (Directories, as of V4, never get S_DAX set.)

If '-o dax' (XFS_MOUNT_DAX == true) then S_DAX is set on all files.


[IF the underlying 'device' (superblock) does _not_ support DAX]

... S_DAX is _never_ set but the underlying XFS_DIFLAG2_DAX flags can be
toggled and will be inherited as above.  Because S_DAX is never set access to
that file will be restricted to "not dax"...[1]

I could go into that level of detail in the doc if needed?  I feel like we need
a more general name for XFS_DIFLAG2_DAX if I do.[2]

> 
> The mount option simply forces "S_DAX" on all regular files as long as
> the underlying device (or soon to be superblock for virtiofs) supports
> it. There is no method to mask S_DAX when the filesystem was mounted
> with -o dax. Otherwise we would seem to need yet another physical flag
> to "always disable" dax.

Exactly.  I don't think we want to support that.  From this thread alone it
seems we have enough complexity and that would be another layer...

;-)

Ira

[1] I'm beginning to think that if I type dax one more time I'm going to go
crazy...  :-P

[2] I have patches in the wings to introduce EXT4_DAX_FL as an ext4 on disk bit
which would be equivalent to XFS_DIFLAG2_DAX.  If anyone wants a better name
let me know.

