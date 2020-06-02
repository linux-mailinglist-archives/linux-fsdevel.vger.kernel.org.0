Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB11EC5F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 01:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFBXxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 19:53:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:39746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgFBXxG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:53:06 -0400
IronPort-SDR: 7pjoj0cj35/NaofwcrKVBE2fBmelzHAFVEgDiJ8cl6I5MsEB2nyJmoukJZqm9j3kZHlA9MHEzi
 nV/4PWozqlHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:53:05 -0700
IronPort-SDR: Fjosrr6vpGK5zwtIgnd84lq7g7jGjKCKBVDcWW2Xd9/i/a+bCVJiomnAZSEIQRGn0f9UiyeC0t
 kX8qGrZdgA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="470925223"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2020 16:53:05 -0700
Date:   Tue, 2 Jun 2020 16:53:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 1
Message-ID: <20200602235305.GI1505637@iweiny-DESK2.sc.intel.com>
References: <20200602165852.GB8230@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602165852.GB8230@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:58:52AM -0700, Darrick J. Wong wrote:
> Hi Linus,
> 
> After many years of LKML-wrangling about how to enable programs to query
> and influence the file data access mode (DAX) when a filesystem resides
> on storage devices such as persistent memory, Ira Weiny has emerged with
> a proposed set of standard behaviors that has not been shot down by
> anyone!  We're more or less standardizing on the current XFS behavior
> and adapting ext4 to do the same.

Also, for those interested: The corresponding man page change mentioned in the
commit has been submitted here:

https://lore.kernel.org/lkml/20200505002016.1085071-1-ira.weiny@intel.com/

Ira

> 
> This pull request is the first of a handful that will make ext4 and XFS
> present a consistent interface for user programs that care about DAX.
> We add a statx attribute that programs can check to see if DAX is
> enabled on a particular file.  Then, we update the DAX documentation to
> spell out the user-visible behaviors that filesystems will guarantee
> (until the next storage industry shakeup).  The on-disk inode flag has
> been in XFS for a few years now.
> 
> Note that Stephen Rothwell reported a minor merge conflict[1] between
> the first cleanup patch and a different change in the block layer.  The
> resolution looks pretty straightforward, but let me know if you
> encounter problems.
> 
> --D
> 
> [1] https://lore.kernel.org/linux-next/20200522145848.38cdcf54@canb.auug.org.au/
> 
> The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:
> 
>   Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-1
> 
> for you to fetch changes up to 83d9088659e8f113741bb197324bd9554d159657:
> 
>   Documentation/dax: Update Usage section (2020-05-04 08:49:39 -0700)
> 
> ----------------------------------------------------------------
> New code for 5.8:
> - Clean up io_is_direct.
> - Add a new statx flag to indicate when file data access is being done
>   via DAX (as opposed to the page cache).
> - Update the documentation for how system administrators and application
>   programmers can take advantage of the (still experimental DAX) feature.
> 
> ----------------------------------------------------------------
> Ira Weiny (3):
>       fs: Remove unneeded IS_DAX() check in io_is_direct()
>       fs/stat: Define DAX statx attribute
>       Documentation/dax: Update Usage section
> 
>  Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++++++++++-
>  drivers/block/loop.c              |   6 +-
>  fs/stat.c                         |   3 +
>  include/linux/fs.h                |   7 +-
>  include/uapi/linux/stat.h         |   1 +
>  5 files changed, 147 insertions(+), 12 deletions(-)
