Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0322E1D0690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEMFna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:43:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:48154 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEMFn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:43:29 -0400
IronPort-SDR: a/xDlrz1Eka5xdLuonVeLLiMYVEoLpXO6SLZGFmurMX+AuLbqFGbjfGejYQ6RQIp7jmKPl4E0S
 zjCSWKjxu3cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:29 -0700
IronPort-SDR: w1DYE8OUIPfH7tS3pzTdHdDDocTZdB/eL7KMVsCO7j50Kc/lYK1D5/BTNEtKZcUZ+9sHzFEqGc
 Pux7gbFtsTOg==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="464010649"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:29 -0700
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
Subject: [PATCH 2/9] fs/ext4: Disallow verity if inode is DAX
Date:   Tue, 12 May 2020 22:43:17 -0700
Message-Id: <20200513054324.2138483-3-ira.weiny@intel.com>
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

