Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A9339BC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhCMEk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:58 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33570 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005Nzr-6z; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 07/15] ocfs2_inode_lock_update(): make sure we don't change the type bits of i_mode
Date:   Sat, 13 Mar 2021 04:38:16 +0000
Message-Id: <20210313043824.1283821-7-viro@zeniv.linux.org.uk>
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

... even if another node has gone insane.  Fail with -ESTALE if it detects
an attempt to change the type bits.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dlmglue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 8e3a369086db..0fbe8bf7190f 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2204,7 +2204,7 @@ static void ocfs2_unpack_timespec(struct timespec64 *spec,
 	spec->tv_nsec = packed_time & OCFS2_NSEC_MASK;
 }
 
-static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
+static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 {
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
@@ -2213,6 +2213,8 @@ static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	mlog_meta_lvb(0, lockres);
 
 	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
+	if (inode_wrong_type(inode, be16_to_cpu(lvb->lvb_imode)))
+		return -ESTALE;
 
 	/* We're safe here without the lockres lock... */
 	spin_lock(&oi->ip_lock);
@@ -2240,6 +2242,7 @@ static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	ocfs2_unpack_timespec(&inode->i_ctime,
 			      be64_to_cpu(lvb->lvb_ictime_packed));
 	spin_unlock(&oi->ip_lock);
+	return 0;
 }
 
 static inline int ocfs2_meta_lvb_is_trustable(struct inode *inode,
@@ -2342,7 +2345,8 @@ static int ocfs2_inode_lock_update(struct inode *inode,
 	if (ocfs2_meta_lvb_is_trustable(inode, lockres)) {
 		mlog(0, "Trusting LVB on inode %llu\n",
 		     (unsigned long long)oi->ip_blkno);
-		ocfs2_refresh_inode_from_lvb(inode);
+		status = ocfs2_refresh_inode_from_lvb(inode);
+		goto bail_refresh;
 	} else {
 		/* Boo, we have to go to disk. */
 		/* read bh, cast, ocfs2_refresh_inode */
@@ -2352,6 +2356,10 @@ static int ocfs2_inode_lock_update(struct inode *inode,
 			goto bail_refresh;
 		}
 		fe = (struct ocfs2_dinode *) (*bh)->b_data;
+		if (inode_wrong_type(inode, le16_to_cpu(fe->i_mode))) {
+			status = -ESTALE;
+			goto bail_refresh;
+		}
 
 		/* This is a good chance to make sure we're not
 		 * locking an invalid object.  ocfs2_read_inode_block()
-- 
2.11.0

