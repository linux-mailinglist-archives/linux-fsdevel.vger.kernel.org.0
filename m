Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867D5171058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgB0Fc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:32:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:17728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgB0Fcr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:46 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="261320404"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:46 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V5 12/12] Documentation/dax: Update Usage section
Date:   Wed, 26 Feb 2020 21:24:42 -0800
Message-Id: <20200227052442.22524-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200227052442.22524-1-ira.weiny@intel.com>
References: <20200227052442.22524-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Update the Usage section to reflect the new individual dax selection
functionality.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/filesystems/dax.txt | 84 ++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 679729442fd2..32e37c550f76 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -20,8 +20,88 @@ Usage
 If you have a block device which supports DAX, you can make a filesystem
 on it as usual.  The DAX code currently only supports files with a block
 size equal to your kernel's PAGE_SIZE, so you may need to specify a block
-size when creating the filesystem.  When mounting it, use the "-o dax"
-option on the command line or add 'dax' to the options in /etc/fstab.
+size when creating the filesystem.
+
+Enabling DAX on an individual file basis (XFS)
+----------------------------------------------
+
+There are 2 per file dax flags.  One is a physical configuration setting and
+the other a currently enabled state.
+
+The physical configuration setting is maintained on individual file and
+directory inodes.  It is preserved within the file system.  This 'physical'
+config setting can be set using an ioctl and/or an application such as "xfs_io
+-c 'chattr [-+]x'".  Files and directories automatically inherit their physical
+dax setting from their parent directory when created.  Therefore, setting the
+physical dax setting at directory creation time can be used to set a default
+behavior for that sub-tree.  Doing so on the root directory acts to set a
+default for the entire file system.
+
+To clarify inheritance here are 3 examples:
+
+Example A:
+
+mkdir -p a/b/c
+xfs_io 'chattr +x' a
+mkdir a/b/c/d
+mkdir a/e
+
+	dax: a,e
+	no dax: b,c,d
+
+Example B:
+
+mkdir a
+xfs_io 'chattr +x' a
+mkdir -p a/b/c/d
+
+	dax: a,b,c,d
+	no dax:
+
+Example C:
+
+mkdir -p a/b/c
+xfs_io 'chattr +x' c
+mkdir a/b/c/d
+
+	dax: c,d
+	no dax: a,b
+
+
+The current inode enabled state is set when a file inode is loaded and it is
+determined that the underlying media supports dax.
+
+statx can be used to query the file's current enabled state.  NOTE that a
+directory will never be operating in a dax state.  Therefore, the dax config
+state must be queried to see what config state a file or sub-directory will
+inherit from a directory.
+
+NOTE: Setting a file or directory's config state with xfs_io is possible even
+if the underlying media does not support dax.
+
+
+Enabling dax on a file system wide basis ('-o dax' mount option)
+----------------------------------------------------------------
+
+The physical dax configuration of all files can be overridden using a mount
+option.  In summary:
+
+	(physical flag || mount option) && capable device == dax in effect
+	(  <xfs_io>    ||  <'-o dax'> ) && capable device == <statx dax true>
+
+To enable the mount override, use "-o dax" on the command line or add
+'dax' to the options in /etc/fstab
+
+Using the mount option does not change the physical configured state of
+individual files.  Therefore, remounting _without_ the mount option will allow
+the file system to set file's enabled state directly based on their config
+setting.
+
+NOTE: Setting a file or directory's physical config state is possible while the
+file system is mounted with the dax override.  However, the file's enabled
+state will continue to be overridden and "dax enabled" until the mount option
+is removed and a remount performed.  At that point the file's physical config
+state dictates the enabled state.
 
 
 Implementation Tips for Block Driver Writers
-- 
2.21.0

