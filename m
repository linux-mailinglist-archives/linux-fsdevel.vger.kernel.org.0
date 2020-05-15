Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA701D44CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOEl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:41:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:46444 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgEOEl1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:41:27 -0400
IronPort-SDR: 0SmBIov2NxAmNDKhdMJOqfAIDKt5wO10huoLm2GyAufP+S5cL6z3boGf+VisCpRq2CYf4FcDdz
 Bgq50buSTFpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:41:26 -0700
IronPort-SDR: 0BU4ANufiLExyu2M7di/wCmCwHV5UzjQLwN0p8XOiOouAKC1W3bjRfKBlQQ4Ky9C5wIy7SGyoN
 4Vg4vxJnfNbg==
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="372574772"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:41:26 -0700
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
Subject: [PATCH v2 1/9] fs/ext4: Narrow scope of DAX check in setflags
Date:   Thu, 14 May 2020 21:41:13 -0700
Message-Id: <20200515044121.2987940-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200515044121.2987940-1-ira.weiny@intel.com>
References: <20200515044121.2987940-1-ira.weiny@intel.com>
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

