Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25581A721B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDNEA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:00:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:37182 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDNEAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:52 -0400
IronPort-SDR: cHEbihgZ+Ty2KFlfTsJy4kq1FsiwwACnYDkThUVqctBDwog/2TbJ6TS+PDsRqNKWfKxP8XehI9
 mQhAFeKtVJHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:51 -0700
IronPort-SDR: a6EYxe7pLy+VgJqH3HoxkqokuL0Zgh/t1VNeCYkbSnANVr6Y9TaeJmQ3HAPgTRnLqkCtpJcYxK
 ImEYNJS2ZNaA==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="288089345"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:50 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 6/8] fs/ext4: Update ext4_should_use_dax()
Date:   Mon, 13 Apr 2020 21:00:28 -0700
Message-Id: <20200414040030.1802884-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414040030.1802884-1-ira.weiny@intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Change the logic of ext4_should_use_dax() to support using the inode dax
flag OR the overriding tri-state mount option.

While we are at it change the function to ext4_enable_dax() as this
better reflects the ask.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/inode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..e9d582e516bc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4383,9 +4383,11 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
 }
 
-static bool ext4_should_use_dax(struct inode *inode)
+static bool ext4_enable_dax(struct inode *inode)
 {
-	if (!test_opt(inode->i_sb, DAX))
+	unsigned int flags = EXT4_I(inode)->i_flags;
+
+	if (test_opt2(inode->i_sb, NODAX))
 		return false;
 	if (!S_ISREG(inode->i_mode))
 		return false;
@@ -4397,7 +4399,13 @@ static bool ext4_should_use_dax(struct inode *inode)
 		return false;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
 		return false;
-	return true;
+	if (!bdev_dax_supported(inode->i_sb->s_bdev,
+				inode->i_sb->s_blocksize))
+		return false;
+	if (test_opt(inode->i_sb, DAX))
+		return true;
+
+	return (flags & EXT4_DAX_FL) == EXT4_DAX_FL;
 }
 
 void ext4_set_inode_flags(struct inode *inode)
@@ -4415,7 +4423,7 @@ void ext4_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & EXT4_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
-	if (ext4_should_use_dax(inode))
+	if (ext4_enable_dax(inode))
 		new_fl |= S_DAX;
 	if (flags & EXT4_ENCRYPT_FL)
 		new_fl |= S_ENCRYPTED;
-- 
2.25.1

