Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252341E6534
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbgE1PAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:00:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:1158 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404071AbgE1PAi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:00:38 -0400
IronPort-SDR: Y8uViMIethO0MkCEhvR9VOaQo4rCdZoPZZ16WvrbxaOWarbL+YXwAXtwlHt9kIvhqGctihczQk
 1FBmHsC2QDeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:07 -0700
IronPort-SDR: 6N8dWPAxPrX53sMbbv5wZaIXtDwBwCLk1QRpyPK+kZDPuERC+bTR72rxhkzT99XkN5JxmD/M61
 07sOm4tAgWOg==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267242300"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:06 -0700
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
Subject: [PATCH V5 1/9] fs/ext4: Narrow scope of DAX check in setflags
Date:   Thu, 28 May 2020 07:59:55 -0700
Message-Id: <20200528150003.828793-2-ira.weiny@intel.com>
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

When preventing DAX and journaling on an inode.  Use the effective DAX
check rather than the mount option.

This will be required to support per inode DAX flags.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0746532ba463..f23168387deb 100644
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

