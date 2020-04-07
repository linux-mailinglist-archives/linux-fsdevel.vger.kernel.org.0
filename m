Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEE1A13A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDGSan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:60147 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgDGSah (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:37 -0400
IronPort-SDR: 6Az7K4hsn4ap01ZCWKsHK7hfjgc9LkXTAjjiFV4ofLYslvXjJAQQxd7G3E9I7+ZpLyAFnTQ2Jx
 nBGtWFJeJXEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:36 -0700
IronPort-SDR: fOz7VX96+8SYFwmfOpMAPO9gL2srNCtndIiprKfwKQtJkSjHuBt2/7zQF+frsSNgc44re4rk/3
 wJuq4rc8KqNw==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="240039465"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:36 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 8/8] Documentation/dax: Update Usage section
Date:   Tue,  7 Apr 2020 11:29:58 -0700
Message-Id: <20200407182958.568475-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407182958.568475-1-ira.weiny@intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
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
Changes from V5:
	Update to reflect the agreed upon semantics
	https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
---
 Documentation/filesystems/dax.txt | 94 ++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 679729442fd2..d84e8101cf8a 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -17,11 +17,99 @@ For file mappings, the storage device is mapped directly into userspace.
 Usage
 -----
 
-If you have a block device which supports DAX, you can make a filesystem
+If you have a block device which supports DAX, you can make a file system
 on it as usual.  The DAX code currently only supports files with a block
 size equal to your kernel's PAGE_SIZE, so you may need to specify a block
-size when creating the filesystem.  When mounting it, use the "-o dax"
-option on the command line or add 'dax' to the options in /etc/fstab.
+size when creating the file system.
+
+Enabling DAX on an individual file basis (XFS)
+----------------------------------------------
+
+There are 2 per file dax flags.  One is a physical inode setting (FS_XFLAG_DAX) and
+the other a currently enabled state (S_DAX).
+
+FS_XFLAG_DAX is maintained on individual file and directory inodes.  It is
+preserved within the file system.  This 'physical' config setting can be set on
+directories using an ioctl and/or an application such as "xfs_io -c 'chattr
+[-+]x'".  Files and directories automatically inherit FS_XFLAG_DAX from their
+parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
+directory creation time can be used to set a default behavior for an entire
+sub-tree.  (Doing so on the root directory acts to set a default for the entire
+file system.)
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
+The current enabled state (S_DAX) is set when a file inode is loaded based on
+the underlying media support and the file systems dax mount option setting.  See
+below.
+
+statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
+set and therefore statx will always return false.  FS_XFLAG_DAX can be queried
+with ioctl or xfs_io on directories.
+
+NOTE: Setting FS_XFLAG_DAX on a directory is possible even if the underlying
+media does not support dax.  Furthermore, files and directories will continue
+to inherit FS_XLFAG_DAX even if the underlying media does not support dax.
+
+
+overriding FS_XFLAG_DAX (the dax= mount option)
+-----------------------------------------------
+
+The dax mount option is a tri-state option (never, always, iflag):
+
+   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
+   "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
+        "-o dax" by itself means "dax=always" to remain compatible with older
+	         kernels
+   "-o dax=iflag" means "follow FS_XFLAG_DAX"
+
+The default state is 'iflag'.  The following algorithm is used to determine the
+effective mode of the file S_DAX on a capable device.
+
+	S_DAX &= FS_XFLAG_DAX;
+
+	if (dax_mount == "always")
+		S_DAX = true;
+	else if (dax_mount == "off"
+		S_DAX = false;
+
+Using the mount option does not change the physical configured state of
+individual files.
+
+NOTE: Setting FS_XFLAG_DAX on a directory is possible while the file system is
+mounted with the dax override.  In addition, files and directories will inherit
+FS_XFLAG_DAX as normal while the file system is overriden.  However, the file's
+enabled state will continue to be the mount option until remounted with
+dax=iflag.
 
 
 Implementation Tips for Block Driver Writers
-- 
2.25.1

