Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809F1D2833
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgENGxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:53:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:43897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgENGxU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:53:20 -0400
IronPort-SDR: 0mKsgizaAJBsC+Hh6bnuFMUdXQ5JuvE69941voollJVW8B6lMj2Y4Gu/IlkBT1rm6vvTUuq+FV
 KKruyyBCgk0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:19 -0700
IronPort-SDR: xQA7GUCRkzw8iPfjj8bl4+ul4+nvOn1axPrDtT4pLTz1uuf5Ocze0gFCculivz2DSNuPh7Aswf
 ksmXH2yGcmhg==
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="280757800"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:18 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V1 0/9] Enable ext4 support for per-file/directory DAX operations
Date:   Wed, 13 May 2020 23:53:06 -0700
Message-Id: <20200514065316.2500078-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Enable the same per file DAX support in ext4 as was done for xfs.  This series
builds and depends on the V11 series for xfs.[1]

This passes the same xfstests test as XFS.

The only issue is that this modifies the old mount option parsing code rather
than waiting for the new parsing code to be finalized.

This series starts with 3 fixes which include making Verity and Encrypt truly
mutually exclusive from DAX.  I think these first 3 patches should be picked up
for 5.8 regardless of what is decided regarding the mount parsing.

[1] https://lore.kernel.org/lkml/20200428002142.404144-1-ira.weiny@intel.com/

Changes from V0:
	Collect reviews
	Fix up setting don't cache in ioctl code
	Add FS_DAX_FL flag for consistency


To: linux-ext4@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org


Ira Weiny (9):
  fs/ext4: Narrow scope of DAX check in setflags
  fs/ext4: Disallow verity if inode is DAX
  fs/ext4: Disallow encryption if inode is DAX
  fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
  fs/ext4: Update ext4_should_use_dax()
  fs/ext4: Only change S_DAX on inode load
  fs/ext4: Make DAX mount option a tri-state
  fs/ext4: Introduce DAX inode flag
  Documentation/dax: Update DAX enablement for ext4

 Documentation/filesystems/dax.txt         |  6 +-
 Documentation/filesystems/ext4/verity.rst |  7 +++
 Documentation/filesystems/fscrypt.rst     |  4 +-
 fs/ext4/ext4.h                            | 20 ++++---
 fs/ext4/ialloc.c                          |  2 +-
 fs/ext4/inode.c                           | 27 +++++++--
 fs/ext4/ioctl.c                           | 31 +++++++++--
 fs/ext4/super.c                           | 67 +++++++++++++++--------
 fs/ext4/verity.c                          |  5 +-
 include/uapi/linux/fs.h                   |  1 +
 10 files changed, 125 insertions(+), 45 deletions(-)

-- 
2.25.1

