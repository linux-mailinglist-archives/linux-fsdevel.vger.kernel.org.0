Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C389E1D0689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEMFnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:43:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:41741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgEMFne (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:43:34 -0400
IronPort-SDR: WwZ8/YMf4NyEzbz6Dv+qE63Hi3LyDkmdkF9sZrfe+DX09D3Hjtoc4famEXxFJuV7xHV5WbF/bq
 0UUx+ckqjoAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:33 -0700
IronPort-SDR: L49tdu1J2MkvLD7l+fCbVJUHinpx4wvcKLkKuKvNIOzYX9yWxRHxz4jan/1lcvC9FvkG1F4Gkb
 YyYgY2YEZdtg==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="298259592"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:33 -0700
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
Subject: [PATCH 8/9] fs/ext4: Introduce DAX inode flag
Date:   Tue, 12 May 2020 22:43:23 -0700
Message-Id: <20200513054324.2138483-9-ira.weiny@intel.com>
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

Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.

Set the flag to be user visible and changeable.  Set the flag to be
inherited.  Allow applications to change the flag at any time.

Finally, on regular files, flag the inode to not be cached to facilitate
changing S_DAX on the next creation of the inode.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change from RFC:
	use new d_mark_dontcache()
	Allow caching if ALWAYS/NEVER is set
	Rebased to latest Linus master
	Change flag to unused 0x01000000
	update ext4_should_enable_dax()
---
 fs/ext4/ext4.h  | 13 +++++++++----
 fs/ext4/inode.c |  4 +++-
 fs/ext4/ioctl.c | 25 ++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 01d1de838896..715f8f2029b2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -415,13 +415,16 @@ struct flex_groups {
 #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
+
+#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
+
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
-#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
+#define EXT4_FL_USER_VISIBLE		0x715BDFFF /* User visible flags */
+#define EXT4_FL_USER_MODIFIABLE		0x614BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
 #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
@@ -429,14 +432,16 @@ struct flex_groups {
 					 EXT4_APPEND_FL | \
 					 EXT4_NODUMP_FL | \
 					 EXT4_NOATIME_FL | \
-					 EXT4_PROJINHERIT_FL)
+					 EXT4_PROJINHERIT_FL | \
+					 EXT4_DAX_FL)
 
 /* Flags that should be inherited by new inodes from their parent. */
 #define EXT4_FL_INHERITED (EXT4_SECRM_FL | EXT4_UNRM_FL | EXT4_COMPR_FL |\
 			   EXT4_SYNC_FL | EXT4_NODUMP_FL | EXT4_NOATIME_FL |\
 			   EXT4_NOCOMPR_FL | EXT4_JOURNAL_DATA_FL |\
 			   EXT4_NOTAIL_FL | EXT4_DIRSYNC_FL |\
-			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
+			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL |\
+			   EXT4_DAX_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
 #define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 140b1930e2f4..105cf04f7940 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4400,6 +4400,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 
 static bool ext4_should_enable_dax(struct inode *inode)
 {
+	unsigned int flags = EXT4_I(inode)->i_flags;
+
 	if (test_opt2(inode->i_sb, DAX_NEVER))
 		return false;
 	if (!S_ISREG(inode->i_mode))
@@ -4418,7 +4420,7 @@ static bool ext4_should_enable_dax(struct inode *inode)
 	if (test_opt(inode->i_sb, DAX_ALWAYS))
 		return true;
 
-	return false;
+	return flags & EXT4_DAX_FL;
 }
 
 void ext4_set_inode_flags(struct inode *inode, bool init)
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 145083e8cd1e..6996a5c3e101 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -528,12 +528,15 @@ static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
 		xflags |= FS_XFLAG_NOATIME;
 	if (iflags & EXT4_PROJINHERIT_FL)
 		xflags |= FS_XFLAG_PROJINHERIT;
+	if (iflags & EXT4_DAX_FL)
+		xflags |= FS_XFLAG_DAX;
 	return xflags;
 }
 
 #define EXT4_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
 				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
-				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
+				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT | \
+				  FS_XFLAG_DAX)
 
 /* Transfer xflags flags to internal */
 static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
@@ -552,6 +555,8 @@ static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
 		iflags |= EXT4_NOATIME_FL;
 	if (xflags & FS_XFLAG_PROJINHERIT)
 		iflags |= EXT4_PROJINHERIT_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= EXT4_DAX_FL;
 
 	return iflags;
 }
@@ -802,6 +807,21 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (S_ISDIR(inode->i_mode))
+		return;
+
+	if (test_opt2(inode->i_sb, DAX_NEVER) ||
+	    test_opt(inode->i_sb, DAX_ALWAYS))
+		return;
+
+	if (((ei->i_flags ^ flags) & EXT4_DAX_FL) == EXT4_DAX_FL)
+		d_mark_dontcache(inode);
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1267,6 +1287,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return err;
 
 		inode_lock(inode);
+
+		ext4_dax_dontcache(inode, flags);
+
 		ext4_fill_fsxattr(inode, &old_fa);
 		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
-- 
2.25.1

