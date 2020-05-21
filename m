Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0691DD6DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 21:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEUTNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 15:13:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:24227 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgEUTNS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 15:13:18 -0400
IronPort-SDR: GgWb7EKBN1nGREGGP0E0D3EtyeV9Wh+Uhi7Jr3yKRNCkpsOJY6o9MoHB23XifJ/tcmVthj8oB2
 wXiIKK6en60g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:13:17 -0700
IronPort-SDR: DGByqBAOvVYaTWjhITMljJQC89/XXiifYg1qrkINopV3Yy6vC+PtM5AIMGe9HBg4x9gbcy7i0Z
 vleL0Co3lDKA==
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="466911668"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:13:17 -0700
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
Subject: [PATCH V4 1/8] fs/ext4: Narrow scope of DAX check in setflags
Date:   Thu, 21 May 2020 12:13:06 -0700
Message-Id: <20200521191313.261929-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521191313.261929-1-ira.weiny@intel.com>
References: <20200521191313.261929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When preventing DAX and journaling on an inode.  Use the effective DAX
check rather than the mount option.

This will be required to support per inode DAX flags.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cb..5813e5e73eab 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -393,9 +393,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if ((jflag ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
 		/*
 		 * Changes to the journaling mode can cause unsafe changes to
-		 * S_DAX if we are using the DAX mount option.
+		 * S_DAX if the inode is DAX
 		 */
-		if (test_opt(inode->i_sb, DAX)) {
+		if (IS_DAX(inode)) {
 			err = -EBUSY;
 			goto flags_out;
 		}
-- 
2.25.1

