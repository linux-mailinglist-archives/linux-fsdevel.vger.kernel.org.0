Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284B815F926
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgBNV6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 16:58:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:36581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgBNV6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:58:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 13:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="433159510"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 13:58:00 -0800
Date:   Fri, 14 Feb 2020 13:58:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
References: <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
 <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
 <20200213195839.GG6870@magnolia>
 <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
 <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
 <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:23:19PM -0500, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > [disclaimer: the following assumes the underlying 'device' (superblock)
> > supports DAX]
> >
> > ... which results in S_DAX == false when the file is opened without the mount
> > option.  The key would be that all directories/files created under a root with
> > XFS_DIFLAG2_DAX == true would inherit their flag and be XFS_DIFLAG2_DAX == true
> > all the way down the tree.  Any file not wanting DAX would need to set
> > XFS_DIFLAG2_DAX == false.  And setting false could be used on a directory to
> > allow a user or group to not use dax on files in that sub-tree.
> >
> > Then without '-o dax' (XFS_MOUNT_DAX == false) all files when opened set S_DAX
> > equal to XFS_DIFLAG2_DAX value.  (Directories, as of V4, never get S_DAX set.)
> >
> > If '-o dax' (XFS_MOUNT_DAX == true) then S_DAX is set on all files.
> 
> One more clarifying question.  Let's say I set XFS_DIFLAG2_DAX on an
> inode.  I then open the file, and perform mmap/load/store/etc.  I close
> the file, and I unset XFS_DIFLAG2_DAX.  Will the next open treat the
> file as S_DAX or not?  My guess is the inode won't be evicted, and so
> S_DAX will remain set.

The inode will not be evicted, or even it happens to be xfs_io will reload it
to unset the XFS_DIFLAG2_DAX flag.  And the S_DAX flag changes _with_ the
XFS_DIFLAG2_DAX change when it can (when the underlying storage supports
S_DAX).

Trying to change XFS_DIFLAG2_DAX while the file is mmap'ed returns -EBUSY.

Ira

> 
> The reason I ask is I've had requests from application developers to do
> just this.  They want to be able to switch back and forth between dax
> modes.
> 
> Thanks,
> Jeff
> 
> > [1] I'm beginning to think that if I type dax one more time I'm going to go
> > crazy...  :-P
> 
> dax dax dax!
> 
