Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4481D44C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgEOElk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:41:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:55320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgEOElb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:41:31 -0400
IronPort-SDR: qyli1L3umJNaw1Vuj7EcE5JNX+xhPChTiwRgGdfUJylEuAMFQDwOWiNk5+k5EGjDEGZk0+AAN+
 IKsF8tFsuSag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:41:30 -0700
IronPort-SDR: O14//86Ild9tYIpbQj4E+bY3f305Z0Zl+QiNx090OymcirMPp6R6mOF5w+dO30ucX+6WiKNVYI
 hn/NBryxuIxg==
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="263070095"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:41:29 -0700
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
Subject: [PATCH v2 8/9] fs/ext4: Introduce DAX inode flag
Date:   Thu, 14 May 2020 21:41:20 -0700
Message-Id: <20200515044121.2987940-9-ira.weiny@intel.com>
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

Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.

Set the flag to be user visible and changeable.  Set the flag to be
inherited.  Allow applications to change the flag at any time.

Finally, on regular files, flag the inode to not be cached to facilitate
changing S_DAX on the next creation of the inode.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change from V0:
	Add FS_DAX_FL to include/uapi/linux/fs.h
		to be consistent
	Move ext4_dax_dontcache() to ext4_ioctl_setflags()
		This ensures that it is only set when the flags are going to be
		set and not if there is an error
		Also this sets don't cache in the FS_IOC_SETFLAGS case

Change from RFC:
	use new d_mark_dontcache()
	Allow caching if ALWAYS/NEVER is set
	Rebased to latest Linus master
	Change flag to unused 0x01000000
	update ext4_should_enable_dax()
---
 fs/ext4/ext4.h          | 13 +++++++++----
 fs/ext4/inode.c         |  4 +++-
 fs/ext4/ioctl.c         | 24 +++++++++++++++++++++++-
 include/uapi/linux/fs.h |  1 +
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6235440e4c39..e8fce4fc50c4 100644
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
index 145083e8cd1e..d6d018ea8e94 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -292,6 +292,21 @@ static int ext4_ioctl_check_immutable(struct inode *inode, __u32 new_projid,
 	return 0;
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
+	if ((ei->i_flags ^ flags) & EXT4_DAX_FL)
+		d_mark_dontcache(inode);
+}
+
 static int ext4_ioctl_setflags(struct inode *inode,
 			       unsigned int flags)
 {
@@ -369,6 +384,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if (err)
 		goto flags_err;
 
+	ext4_dax_dontcache(inode, flags);
+
 	for (i = 0, mask = 1; i < 32; i++, mask <<= 1) {
 		if (!(mask & EXT4_FL_USER_MODIFIABLE))
 			continue;
@@ -528,12 +545,15 @@ static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
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
@@ -552,6 +572,8 @@ static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
 		iflags |= EXT4_NOATIME_FL;
 	if (xflags & FS_XFLAG_PROJINHERIT)
 		iflags |= EXT4_PROJINHERIT_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= EXT4_DAX_FL;
 
 	return iflags;
 }
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..7c5f6eb51e2d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -262,6 +262,7 @@ struct fsxattr {
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
+#define FS_DAX_FL			0x01000000 /* Inode is DAX */
 #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
 #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
-- 
2.25.1

