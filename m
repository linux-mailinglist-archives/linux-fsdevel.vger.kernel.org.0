Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E500C1594EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgBKQ2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 11:28:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:50955 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbgBKQ2c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:28:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="233501271"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2020 08:28:30 -0800
Date:   Tue, 11 Feb 2020 08:28:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] fs/xfs: Clean up DAX support check
Message-ID: <20200211162830.GB12866@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-5-ira.weiny@intel.com>
 <20200211055745.GG10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211055745.GG10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:57:45PM +1100, Dave Chinner wrote:
> On Sat, Feb 08, 2020 at 11:34:37AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Rather than open coding xfs_inode_supports_dax() in
> > xfs_ioctl_setattr_dax_invalidate() export xfs_inode_supports_dax() and
> > call it in preparation for swapping dax flags.
> > 
> > This also means updating xfs_inode_supports_dax() to return true for a
> > directory.
> 
> That's not correct. This now means S_DAX gets set on directory inodes
> because both xfs_inode_supports_dax() and the on-disk inode flag
> checks return true in xfs_diflags_to_iflags(). Hence when we
> instantiate a directory inode with a DAX inherit hint set on it
> we'll set S_DAX on the inode and so IS_DAX() will return true for
> directory inodes...

I'm not following.  Don't we want S_DAX to get set on directory inodes?

IIRC what we wanted was something like this where IS_DAX is the current state
and "dax" is the inode flag:

/ <IS_DAX=0 dax=0>
	dir1 <IS_DAX=0 dax=0>
		f0 <IS_DAX=0 dax=0>
		f1 <IS_DAX=1 dax=1>
	dir2 <IS_DAX=1 dax=1>
		f2 <IS_DAX=1 dax=1>
		f3 <IS_DAX=0 dax=0>
		dir3 <IS_DAX=1 dax=1>
			f4 <IS_DAX=1 dax=1>
		dir4 <IS_DAX=0 dax=0>
			f5 <IS_DAX=0 dax=0>
		f6 <IS_DAX=1 dax=1>

Where f1, dir2, f3, and dir4 required explicit state changes when they were
created.  Because they inherited their dax state from the parent.  All the
other creations happened based on the DAX state of the parent directory.  So we
need to store and know the state of the directories.  What am I missing?

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
