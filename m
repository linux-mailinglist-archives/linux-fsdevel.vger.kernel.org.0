Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB4339BC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhCMElA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:00 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33562 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhCMEkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:35 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2i-005Nza-RL; Sat, 13 Mar 2021 04:38:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 03/15] ceph: don't allow type or device number to change on non-I_NEW inodes
Date:   Sat, 13 Mar 2021 04:38:12 +0000
Message-Id: <20210313043824.1283821-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
 <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Al pointed out that a malicious or broken MDS could change the type or
device number of a given inode number. It may also be possible for the
MDS to reuse an old inode number.

Ensure that we never allow fill_inode to change the type part of the
i_mode or the i_rdev unless I_NEW is set. Throw warnings if the MDS ever
changes these on us mid-stream, and return an error.

Don't set i_rdev directly, and rely on init_special_inode to do it.
Also, fix up error handling in the callers of ceph_get_inode.

In handle_cap_grant, check for and warn if the inode type changes, and
only overwrite the mode if it didn't.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/caps.c  |  8 +++++++-
 fs/ceph/inode.c | 27 +++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 570731c4d019..3c03fa37cac4 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3358,7 +3358,13 @@ static void handle_cap_grant(struct inode *inode,
 
 	if ((newcaps & CEPH_CAP_AUTH_SHARED) &&
 	    (extra_info->issued & CEPH_CAP_AUTH_EXCL) == 0) {
-		inode->i_mode = le32_to_cpu(grant->mode);
+		umode_t mode = le32_to_cpu(grant->mode);
+
+		if (inode_wrong_type(inode, mode))
+			pr_warn_once("inode type changed! (ino %llx.%llx is 0%o, mds says 0%o)\n",
+				     ceph_vinop(inode), inode->i_mode, mode);
+		else
+			inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5db7bf4c6a26..689e3ffd29d7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -769,11 +769,32 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	bool queue_trunc = false;
 	bool new_version = false;
 	bool fill_inline = false;
+	umode_t mode = le32_to_cpu(info->mode);
+	dev_t rdev = le32_to_cpu(info->rdev);
 
 	dout("%s %p ino %llx.%llx v %llu had %llu\n", __func__,
 	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
 	     ci->i_version);
 
+	/* Once I_NEW is cleared, we can't change type or dev numbers */
+	if (inode->i_state & I_NEW) {
+		inode->i_mode = mode;
+	} else {
+		if (inode_wrong_type(inode, mode)) {
+			pr_warn_once("inode type changed! (ino %llx.%llx is 0%o, mds says 0%o)\n",
+				     ceph_vinop(inode), inode->i_mode, mode);
+			return -ESTALE;
+		}
+
+		if ((S_ISCHR(mode) || S_ISBLK(mode)) && inode->i_rdev != rdev) {
+			pr_warn_once("dev inode rdev changed! (ino %llx.%llx is %u:%u, mds says %u:%u)\n",
+				     ceph_vinop(inode), MAJOR(inode->i_rdev),
+				     MINOR(inode->i_rdev), MAJOR(rdev),
+				     MINOR(rdev));
+			return -ESTALE;
+		}
+	}
+
 	info_caps = le32_to_cpu(info->cap.caps);
 
 	/* prealloc new cap struct */
@@ -827,8 +848,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	issued |= __ceph_caps_dirty(ci);
 	new_issued = ~issued & info_caps;
 
-	/* update inode */
-	inode->i_rdev = le32_to_cpu(info->rdev);
 	/* directories have fl_stripe_unit set to zero */
 	if (le32_to_cpu(info->layout.fl_stripe_unit))
 		inode->i_blkbits =
@@ -840,7 +859,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
 	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
-		inode->i_mode = le32_to_cpu(info->mode);
+		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
 		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
@@ -938,7 +957,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	case S_IFCHR:
 	case S_IFSOCK:
 		inode->i_blkbits = PAGE_SHIFT;
-		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		init_special_inode(inode, inode->i_mode, rdev);
 		inode->i_op = &ceph_file_iops;
 		break;
 	case S_IFREG:
-- 
2.11.0

