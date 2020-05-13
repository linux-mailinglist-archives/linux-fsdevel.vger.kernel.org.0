Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C31D068F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgEMFne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:43:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:12649 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgEMFnc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:43:32 -0400
IronPort-SDR: 9DzJvz15vmmGQ1y2ZW6dPqLy63XHc9Acc2c2SlzHBHcHHTodhPetilDdYsLULvpCBxvKKancEn
 4tcWc/RGwr2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:32 -0700
IronPort-SDR: QfxkYo4zwnuMogo2fCMzvUmopRKFineXUbiWeReeij6rUJuy8UhOkp2D+8ZIjVbdEhHqXBrR3A
 sKoeVD9gmiGQ==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="280386428"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:31 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] fs/ext4: Update ext4_should_use_dax()
Date:   Tue, 12 May 2020 22:43:20 -0700
Message-Id: <20200513054324.2138483-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513054324.2138483-1-ira.weiny@intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

S_DAX should only be enabled when the underlying block device supports
dax.

Change ext4_should_use_dax() to check for device support prior to the
over riding mount option.

While we are at it change the function to ext4_should_enable_dax() as
this better reflects the ask as well as matches xfs.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC
	Change function name to 'should enable'
	Clean up bool conversion
	Reorder this for better bisect-ability
---
 fs/ext4/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a10ff12194db..d3a4c2ed7a1c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4398,10 +4398,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
 }
 
-static bool ext4_should_use_dax(struct inode *inode)
+static bool ext4_should_enable_dax(struct inode *inode)
 {
-	if (!test_opt(inode->i_sb, DAX_ALWAYS))
-		return false;
 	if (!S_ISREG(inode->i_mode))
 		return false;
 	if (ext4_should_journal_data(inode))
@@ -4412,7 +4410,13 @@ static bool ext4_should_use_dax(struct inode *inode)
 		return false;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
 		return false;
-	return true;
+	if (!bdev_dax_supported(inode->i_sb->s_bdev,
+				inode->i_sb->s_blocksize))
+		return false;
+	if (test_opt(inode->i_sb, DAX_ALWAYS))
+		return true;
+
+	return false;
 }
 
 void ext4_set_inode_flags(struct inode *inode)
@@ -4430,7 +4434,7 @@ void ext4_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & EXT4_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
-	if (ext4_should_use_dax(inode))
+	if (ext4_should_enable_dax(inode))
 		new_fl |= S_DAX;
 	if (flags & EXT4_ENCRYPT_FL)
 		new_fl |= S_ENCRYPTED;
-- 
2.25.1

