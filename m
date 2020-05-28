Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107F71E654A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbgE1PBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:01:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:2309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404025AbgE1PAP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:00:15 -0400
IronPort-SDR: 8iRVyiTdsf/S3mtZ/4Lh8ISMVC5lYOoeAJfpDY5eq76opl0gz+kUfLSlby8qaZddYIxQX7G4KY
 UZv8YeACIxkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:10 -0700
IronPort-SDR: A8j3Z7IoeQWpMt4y9Vhwt/NW1pH9moyOUNDJDzf5Lz4BniuKztolZ+9iQmQAuHFmnj6xEuoyB9
 B8B1uOkBG9ew==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="302502474"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:09 -0700
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
Subject: [PATCH V5 7/9] fs/ext4: Remove jflag variable
Date:   Thu, 28 May 2020 08:00:01 -0700
Message-Id: <20200528150003.828793-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528150003.828793-1-ira.weiny@intel.com>
References: <20200528150003.828793-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The jflag variable serves almost no purpose.  Remove it.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	New for this series.
---
 fs/ext4/ioctl.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ccf20b1488b..e8a5cdade59f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -300,7 +300,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	int err = -EPERM, migrate = 0;
 	struct ext4_iloc iloc;
 	unsigned int oldflags, mask, i;
-	unsigned int jflag;
 	struct super_block *sb = inode->i_sb;
 
 	/* Is it quota file? Do not allow user to mess with it */
@@ -309,9 +308,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
 
 	oldflags = ei->i_flags;
 
-	/* The JOURNAL_DATA flag is modifiable only by root */
-	jflag = flags & EXT4_JOURNAL_DATA_FL;
-
 	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
 	if (err)
 		goto flags_out;
@@ -320,7 +316,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	 * The JOURNAL_DATA flag can only be changed by
 	 * the relevant capability.
 	 */
-	if ((jflag ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
+	if ((flags ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
 		if (!capable(CAP_SYS_RESOURCE))
 			goto flags_out;
 	}
@@ -391,7 +387,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if (err)
 		goto flags_out;
 
-	if ((jflag ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
+	if ((flags ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
 		/*
 		 * Changes to the journaling mode can cause unsafe changes to
 		 * S_DAX if the inode is DAX
@@ -401,7 +397,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 			goto flags_out;
 		}
 
-		err = ext4_change_inode_journal_flag(inode, jflag);
+		err = ext4_change_inode_journal_flag(inode,
+						     flags & EXT4_JOURNAL_DATA_FL);
 		if (err)
 			goto flags_out;
 	}
-- 
2.25.1

