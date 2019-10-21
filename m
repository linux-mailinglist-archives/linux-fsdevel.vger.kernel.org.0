Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF4DF470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfJURk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 13:40:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:38681 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJURk2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:40:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="200508215"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2019 10:40:26 -0700
Date:   Mon, 21 Oct 2019 10:40:26 -0700
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
Subject: Re: [PATCH 2/5] fs/xfs: Isolate the physical DAX flag from effective
Message-ID: <20191021174025.GA23024@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-3-ira.weiny@intel.com>
 <20191021002621.GC8015@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021002621.GC8015@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:26:21AM +1100, Dave Chinner wrote:
> On Sun, Oct 20, 2019 at 08:59:32AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_ioctl_setattr_dax_invalidate() currently checks if the DAX flag is
> > changing as a quick check.
> > 
> > But the implementation mixes the physical (XFS_DIFLAG2_DAX) and
> > effective (S_DAX) DAX flags.
> 
> More nuanced than that.
> 
> The idea was that if the mount option was set, clearing the
> per-inode flag would override the mount option. i.e. the mount
> option sets the S_DAX flag at inode instantiation, so using
> FSSETXATTR to ensure the FS_XFLAG_DAX is not set would override the
> mount option setting, giving applications a way of guranteeing they
> aren't using DAX to access the data.

At LSF/MM we discussed keeping the mount option as a global "chicken bit" as
described by Matt Wilcox[1].  This preserves the existing behavior of turning
it on no matter what but offers an alternative with the per-file flag.

To do what you describe above, it was suggested, by Ted I believe, that an
admin can set DAX on the root directory which will enable DAX by default
through inheritance but allow users to turn it off if they desire.

I'm concerned that all users who currently use '-o dax' will expect their
current file systems to be using DAX when those mounts occur.  Their physical
inode flag is going to be 0 which, if we implement the 'turn off DAX' as you
describe will mean they will not get the behavior they expect when booting on a
new kernel.

> 
> So if the mount option is going to live on, I suspect that we want
> to keep this code as it stands.

I don't think we can get rid of it soon but I would be in favor of working
toward deprecating it.  Regardless I think this keeps the semantics simple WRT
the interaction of the mount and per-file flags.

Ira

[1] https://lwn.net/Articles/787973/

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
