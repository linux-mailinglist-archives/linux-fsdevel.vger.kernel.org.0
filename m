Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54AF1DAA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 07:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETF55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 01:57:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:55135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgETF54 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 01:57:56 -0400
IronPort-SDR: NRerxWQn3JZ7nq7XxrX2N7tNIF8Naa7WPiGXdeAqmWR7qH/KGvNDR58AUKkmFbPorwwJltnAMW
 J1FhFcaIjXLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:57:56 -0700
IronPort-SDR: yWLipC+hmd5lakfByb0Vq9XwPzKj4cmS+tJjAAirb7gYf7UDH2V+4CWg/XOL3iIIoJ5yVrN8Pw
 rF1mqJUHJbcg==
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="282570629"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:57:55 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/8] Enable ext4 support for per-file/directory DAX operations
Date:   Tue, 19 May 2020 22:57:45 -0700
Message-Id: <20200520055753.3733520-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

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

To: linux-kernel@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org


Ira Weiny (8):
  fs/ext4: Narrow scope of DAX check in setflags
  fs/ext4: Disallow verity if inode is DAX
  fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
  fs/ext4: Update ext4_should_use_dax()
  fs/ext4: Only change S_DAX on inode load
  fs/ext4: Make DAX mount option a tri-state
  fs/ext4: Introduce DAX inode flag
  Documentation/dax: Update DAX enablement for ext4

 Documentation/filesystems/dax.txt         |  6 +-
 Documentation/filesystems/ext4/verity.rst |  3 +
 fs/ext4/ext4.h                            | 22 +++++--
 fs/ext4/ialloc.c                          |  2 +-
 fs/ext4/inode.c                           | 25 +++++--
 fs/ext4/ioctl.c                           | 41 ++++++++++--
 fs/ext4/super.c                           | 80 ++++++++++++++++++-----
 fs/ext4/verity.c                          |  5 +-
 include/uapi/linux/fs.h                   |  1 +
 9 files changed, 148 insertions(+), 37 deletions(-)

-- 
2.25.1

