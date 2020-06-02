Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70851EC090
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFBQ6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 12:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBQ6x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:58:53 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835452068D;
        Tue,  2 Jun 2020 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591117132;
        bh=RQxLCdFPTOP083pc5DFpqNSDZGa6rjjYrzRRGuGc3zQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GUPXnfsHB9+bqVwuHbBBc04gDBCK0G0AMtbR1nUCzSaIRgYKRhVajThaxmHTSmuZL
         hBSSNoUk9AeMmqyYDsuaFx9LJHNs11/pq5CmZTOvR8gTnTXhWCczoWFR0qegRWhf7Q
         5MybUpXZPV/8sHQx9oVkdYZr2lJ+wzRgBQ3o6VUc=
Date:   Tue, 2 Jun 2020 09:58:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Subject: [GIT PULL] vfs: improve DAX behavior for 5.8, part 1
Message-ID: <20200602165852.GB8230@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

After many years of LKML-wrangling about how to enable programs to query
and influence the file data access mode (DAX) when a filesystem resides
on storage devices such as persistent memory, Ira Weiny has emerged with
a proposed set of standard behaviors that has not been shot down by
anyone!  We're more or less standardizing on the current XFS behavior
and adapting ext4 to do the same.

This pull request is the first of a handful that will make ext4 and XFS
present a consistent interface for user programs that care about DAX.
We add a statx attribute that programs can check to see if DAX is
enabled on a particular file.  Then, we update the DAX documentation to
spell out the user-visible behaviors that filesystems will guarantee
(until the next storage industry shakeup).  The on-disk inode flag has
been in XFS for a few years now.

Note that Stephen Rothwell reported a minor merge conflict[1] between
the first cleanup patch and a different change in the block layer.  The
resolution looks pretty straightforward, but let me know if you
encounter problems.

--D

[1] https://lore.kernel.org/linux-next/20200522145848.38cdcf54@canb.auug.org.au/

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-1

for you to fetch changes up to 83d9088659e8f113741bb197324bd9554d159657:

  Documentation/dax: Update Usage section (2020-05-04 08:49:39 -0700)

----------------------------------------------------------------
New code for 5.8:
- Clean up io_is_direct.
- Add a new statx flag to indicate when file data access is being done
  via DAX (as opposed to the page cache).
- Update the documentation for how system administrators and application
  programmers can take advantage of the (still experimental DAX) feature.

----------------------------------------------------------------
Ira Weiny (3):
      fs: Remove unneeded IS_DAX() check in io_is_direct()
      fs/stat: Define DAX statx attribute
      Documentation/dax: Update Usage section

 Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++++++++++-
 drivers/block/loop.c              |   6 +-
 fs/stat.c                         |   3 +
 include/linux/fs.h                |   7 +-
 include/uapi/linux/stat.h         |   1 +
 5 files changed, 147 insertions(+), 12 deletions(-)
