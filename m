Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D161D2853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgENGx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:53:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:24100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgENGxV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:53:21 -0400
IronPort-SDR: umbg94bAomxyBiYfb35fxpqDOJQRiU/MfLwnxlZ4tzWB3hv3XAH8OpLyq1+0GOIFykn30lvQF2
 pegeQ6uUWYDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:20 -0700
IronPort-SDR: CoA/uy7sbXze7imXWR7ydgQ0P4Is3UOhFPWglk63t2c+7NwhmPaBBESk82Mk2xQUBWg3U7Ad1v
 u4OeNWSqJGag==
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="298613492"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:20 -0700
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
Subject: [PATCH V1 2/9] fs/ext4: Disallow verity if inode is DAX
Date:   Wed, 13 May 2020 23:53:08 -0700
Message-Id: <20200514065316.2500078-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514065316.2500078-1-ira.weiny@intel.com>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Verity and DAX are incompatible.  Changing the DAX mode due to a verity
flag change is wrong without a corresponding address_space_operations
update.

Make the 2 options mutually exclusive by returning an error if DAX was
set first.

(Setting DAX is already disabled if Verity is set first.)

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
	remove WARN_ON_ONCE
	Add documentation for DAX/Verity exclusivity
---
 Documentation/filesystems/ext4/verity.rst | 7 +++++++
 fs/ext4/verity.c                          | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
index 3e4c0ee0e068..51ab1aa17e59 100644
--- a/Documentation/filesystems/ext4/verity.rst
+++ b/Documentation/filesystems/ext4/verity.rst
@@ -39,3 +39,10 @@ is encrypted as well as the data itself.
 
 Verity files cannot have blocks allocated past the end of the verity
 metadata.
+
+Verity and DAX
+--------------
+
+Verity and DAX are not compatible and attempts to set both of these flags on a
+file will fail.
+
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..f05a09fb2ae4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
 	handle_t *handle;
 	int err;
 
+	if (IS_DAX(inode))
+		return -EINVAL;
+
 	if (ext4_verity_in_progress(inode))
 		return -EBUSY;
 
-- 
2.25.1

