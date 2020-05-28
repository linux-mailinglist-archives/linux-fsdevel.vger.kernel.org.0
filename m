Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04101E6527
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbgE1PAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:00:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:19225 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403761AbgE1PAH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:00:07 -0400
IronPort-SDR: dDQWGQ3nfTj0DShZwYYMM0pBff195/nJr9R7rD13LqoFIsaQ0nLbvs23HqiXaASgLLgZvZ0Wv4
 DeMclpEtwE0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:07 -0700
IronPort-SDR: akjpAeh3IlKKiqVT11n31OdwhJP6p5ERYRDOV0+U4clY9f42cnMhMDsgUnRzmW8/4Va6hxoQng
 7Gbe0SuZejxw==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="270875408"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:06 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/9] Enable ext4 support for per-file/directory DAX operations
Date:   Thu, 28 May 2020 07:59:54 -0700
Message-Id: <20200528150003.828793-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V4:
	Fix up DAX mutual exclusion with other flags.
	Add clean up patch (remove jflags)

Changes from V3:
	Change EXT4_DAX_FL to bit24
	Cache device DAX support in the super block and use that is
		ext4_should_use_dax()

Changes from V2:
	Rework DAX exclusivity with verity and encryption based on feedback
	from Eric

Enable the same per file DAX support in ext4 as was done for xfs.  This series
builds and depends on the V11 series for xfs.[1]

This passes the same xfstests test as XFS.

The only issue is that this modifies the old mount option parsing code rather
than waiting for the new parsing code to be finalized.

This series starts with 3 fixes which include making Verity and Encrypt truly
mutually exclusive from DAX.  I think these first 3 patches should be picked up
for 5.8 regardless of what is decided regarding the mount parsing.

[1] https://lore.kernel.org/lkml/20200428002142.404144-1-ira.weiny@intel.com/

To: linux-ext4@vger.kernel.org
To: Andreas Dilger <adilger.kernel@dilger.ca>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Ira Weiny (9):
  fs/ext4: Narrow scope of DAX check in setflags
  fs/ext4: Disallow verity if inode is DAX
  fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
  fs/ext4: Update ext4_should_use_dax()
  fs/ext4: Only change S_DAX on inode load
  fs/ext4: Make DAX mount option a tri-state
  fs/ext4: Remove jflag variable
  fs/ext4: Introduce DAX inode flag
  Documentation/dax: Update DAX enablement for ext4

 Documentation/filesystems/dax.txt         |  6 +-
 Documentation/filesystems/ext4/verity.rst |  3 +
 fs/ext4/ext4.h                            | 27 +++++--
 fs/ext4/ialloc.c                          |  2 +-
 fs/ext4/inode.c                           | 26 +++++--
 fs/ext4/ioctl.c                           | 65 ++++++++++++++---
 fs/ext4/super.c                           | 85 ++++++++++++++++++-----
 fs/ext4/verity.c                          |  5 +-
 include/uapi/linux/fs.h                   |  1 +
 9 files changed, 175 insertions(+), 45 deletions(-)

-- 
2.25.1

