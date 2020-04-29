Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFAE1BD3C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 06:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgD2Edc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 00:33:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:18221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgD2Edb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:33:31 -0400
IronPort-SDR: TlPUM3AHyX2zWqC4wOOJURR66gAhVzodzXV1h/ducmomjyjmXAXJe6a2+9dRx7TqIINaMPK/jZ
 yYRLr+Az/yXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 21:33:31 -0700
IronPort-SDR: 85dDf45wB06mg376sxTfHU6qK6/V1dAHwoSAhO4D0ws9EY3D06AJzT5SwSM3lvNpoEJvSs9Ask
 C1ovlIcIZVNA==
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="246725444"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 21:33:30 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH V11.2] Documentation/dax: Update Usage section
Date:   Tue, 28 Apr 2020 21:33:28 -0700
Message-Id: <20200429043328.411431-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428222145.409961-1-ira.weiny@intel.com>
References: <20200428222145.409961-1-ira.weiny@intel.com>
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
Changes from V11.1:
	Make filesystem/file system consistently filesystem
	grammatical fixes

Changes from V11:
	Minor changes from Darrick

Changes from V10:
	Clarifications from Dave
	Add '-c' to xfs_io examples

Changes from V9:
	Fix missing ')'
	Fix trailing '"' (fixed this!)

Changes from V8:
	Updates from Darrick

Changes from V7:
	Cleanups/clarifications from Darrick and Dan

Changes from V6:
	Update to allow setting FS_XFLAG_DAX any time.
	Update with list of behaviors from Darrick
	https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/

Changes from V5:
	Update to reflect the agreed upon semantics
	https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
---
 Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 679729442fd2..735fb4b54117 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -20,8 +20,144 @@ Usage
 If you have a block device which supports DAX, you can make a filesystem
 on it as usual.  The DAX code currently only supports files with a block
 size equal to your kernel's PAGE_SIZE, so you may need to specify a block
-size when creating the filesystem.  When mounting it, use the "-o dax"
-option on the command line or add 'dax' to the options in /etc/fstab.
+size when creating the filesystem.
+
+Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them
+is different.
+
+Enabling DAX on ext4 and ext2
+-----------------------------
+
+When mounting the filesystem, use the "-o dax" option on the command line or
+add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
+within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
+
+
+Enabling DAX on xfs
+-------------------
+
+Summary
+-------
+
+ 1. There exists an in-kernel file access mode flag S_DAX that corresponds to
+    the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
+    about this access mode.
+
+ 2. There exists a persistent flag FS_XFLAG_DAX that can be applied to regular
+    files and directories. This advisory flag can be set or cleared at any
+    time, but doing so does not immediately affect the S_DAX state.
+
+ 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this flag will
+    be inherited by all regular files and subdirectories that are subsequently
+    created in this directory. Files and subdirectories that exist at the time
+    this flag is set or cleared on the parent directory are not modified by
+    this modification of the parent directory.
+
+ 4. There exist dax mount options which can override FS_XFLAG_DAX in the
+    setting of the S_DAX flag.  Given underlying storage which supports DAX the
+    following hold:
+
+    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
+
+    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
+
+    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
+
+    "-o dax"        is a legacy option which is an alias for "dax=always".
+		    This may be removed in the future so "-o dax=always" is
+		    the preferred method for specifying this behavior.
+
+    NOTE: Modifications to and the inheritance behavior of FS_XFLAG_DAX remain
+    the same even when the filesystem is mounted with a dax option.  However,
+    in-core inode state (S_DAX) will be overridden until the filesystem is
+    remounted with dax=inode and the inode is evicted from kernel memory.
+
+ 5. The S_DAX policy can be changed via:
+
+    a) Setting the parent directory FS_XFLAG_DAX as needed before files are
+       created
+
+    b) Setting the appropriate dax="foo" mount option
+
+    c) Changing the FS_XFLAG_DAX flag on existing regular files and
+       directories.  This has runtime constraints and limitations that are
+       described in 6) below.
+
+ 6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
+    the change in behaviour for existing regular files may not occur
+    immediately.  If the change must take effect immediately, the administrator
+    needs to:
+
+    a) stop the application so there are no active references to the data set
+       the policy change will affect
+
+    b) evict the data set from kernel caches so it will be re-instantiated when
+       the application is restarted. This can be achieved by:
+
+       i. drop-caches
+       ii. a filesystem unmount and mount cycle
+       iii. a system reboot
+
+
+Details
+-------
+
+There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
+and the other is a volatile flag indicating the active state of the feature
+(S_DAX).
+
+FS_XFLAG_DAX is preserved within the filesystem.  This persistent config
+setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
+(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
+
+New files and directories automatically inherit FS_XFLAG_DAX from
+their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
+directory creation time can be used to set a default behavior for an entire
+sub-tree.
+
+To clarify inheritance, here are 3 examples:
+
+Example A:
+
+mkdir -p a/b/c
+xfs_io -c 'chattr +x' a
+mkdir a/b/c/d
+mkdir a/e
+
+	dax: a,e
+	no dax: b,c,d
+
+Example B:
+
+mkdir a
+xfs_io -c 'chattr +x' a
+mkdir -p a/b/c/d
+
+	dax: a,b,c,d
+	no dax:
+
+Example C:
+
+mkdir -p a/b/c
+xfs_io -c 'chattr +x' c
+mkdir a/b/c/d
+
+	dax: c,d
+	no dax: a,b
+
+
+The current enabled state (S_DAX) is set when a file inode is instantiated in
+memory by the kernel.  It is set based on the underlying media support, the
+value of FS_XFLAG_DAX and the filesystem's dax mount option.
+
+statx can be used to query S_DAX.  NOTE that only regular files will ever have
+S_DAX set and therefore statx will never indicate that S_DAX is set on
+directories.
+
+Setting the FS_XFLAG_DAX flag (specifically or through inheritance) occurs even
+if the underlying media does not support dax and/or the filesystem is
+overridden with a mount option.
+
 
 
 Implementation Tips for Block Driver Writers
@@ -94,7 +230,7 @@ sysadmins have an option to restore the lost data from a prior backup/inbuilt
 redundancy in the following ways:
 
 1. Delete the affected file, and restore from a backup (sysadmin route):
-   This will free the file system blocks that were being used by the file,
+   This will free the filesystem blocks that were being used by the file,
    and the next time they're allocated, they will be zeroed first, which
    happens through the driver, and will clear bad sectors.
 
-- 
2.25.1

