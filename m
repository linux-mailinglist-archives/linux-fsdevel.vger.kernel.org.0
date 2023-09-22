Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEA7AB6FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjIVRPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjIVRPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACB1AC;
        Fri, 22 Sep 2023 10:14:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC254C43391;
        Fri, 22 Sep 2023 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402897;
        bh=+R/VqH2Y/BEqxszA0QoLfX//cyFS9olgivR+kesE1J4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iGdFCLfI45oIdGjAhse2hgGufxXf/0O9SoobCZ6Kp6qHR1lsFNhsfggdoO1vAEJvZ
         j0GX5+d9ed6zhcWBLoAl5hu3jSIRsO8inXCWlLV0lmUbmhiC9eCtC76g6Etga6E+Ie
         Nrf2E1UFJMh5ywRWYITq/jmTTOfrNOn5eQKSSD0NDEm5KOUmkp8tGQ0PFY2uSX/o90
         x+VDNzKOXIf0sA590jm77bZHd3kXVDR72243VI9CHIinaVCHFk6+Km85a7m3OmUXho
         K74Rhs19YyfibVFsrRX7Owth2bWG1g0PJfI77BB5GgROv30noUCzMzgaOT80BrnheI
         fFmak1i1pLV/A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 22 Sep 2023 13:14:44 -0400
Subject: [PATCH v8 5/5] xfs: switch to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-ctime-v8-5-45f0c236ede1@kernel.org>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+R/VqH2Y/BEqxszA0QoLfX//cyFS9olgivR+kesE1J4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGzq6LFTw1GidIFjabFRhWirpLN8lq0xa2T
 gnnQgk9RM6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 FfNoEACpYILGJNZCCiYdPFl9vpwrP0Gd3cZHvHbgH4D15ySNal9OtCw43Yy73I2bXKZswiSHYpw
 JOa3X5lqXVv1WBBqS6prbYRFyHwXFNiSVsaR0m2bqI4e1tDPXih3ZsGi4KXxOYlZ0ZpLYXH9NTG
 1IQropOz8tvmWj6k17+FkE8SxnJnObC4MQlqXNnf4CJazo0XbR/Qwrka5nJYSwChIinIFAm9u3D
 nhJgi4sqE3dFSgqRbwsijCHLwMjr32mOL+hMQflJcNmAvFheM6Dj2h3c3e6Zyjt1J58b3anm8io
 qYGmBD8mxoFehTM2MRdF/1qpy+kfOefCJUWSIeZq6TTI+4eWMaHA9PfKeEPyLAzMp5tn6rMOQ5R
 bOLyDLKlzLzGVJdJOUJmbxt0JBpxzPq2o5e5eDhvn0JYS5ddIY1uBzuM4/y98SvT1HIPCXrM+4a
 XYJMrnwA2ppdom2a6MyFjjFPDT5QbfUPDKV6zk/IJFH4+dLyV2054kvF2JfhE7agsvixgpLbSaD
 WbCGhhfbuRKVKhPXqWkYmx5lPrGxzwKVcXnBFtYMn5W7r0TCQ6g7mnPJ/hiecqTkfov5NGm/dWh
 XbL4Z2/MFMT2nwD37eOzM5dtLPlEgC3iCqDJZtAD8h2W/xBIlSxI8uCODGbBPj/klSDQZdM+Y2P
 DH6+jV6szK/A5XA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the internal ctime value whenever a file has been
written after being actively observed via getattr.

Anytime the mtime changes, the ctime must also change, and those are the
only two options for xfs_trans_ichgtime. Have that function
unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
always set.

In getattr, truncate the mtime and ctime at the number of nanoseconds
per jiffy, which should ensure that ordering is preserved. Use the fine
grained ctime to fake up a STATX_CHANGE_COOKIE if one was requested.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
 fs/xfs/xfs_iops.c               | 26 +++++++++++++++++++-------
 fs/xfs/xfs_super.c              |  2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 6b2296ff248a..ad22656376d3 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -62,12 +62,12 @@ xfs_trans_ichgtime(
 	ASSERT(tp);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 
-	tv = current_time(inode);
+	/* If the mtime changes, then ctime must also change */
+	ASSERT(flags & XFS_ICHGTIME_CHG);
 
+	tv = inode_set_ctime_current(inode);
 	if (flags & XFS_ICHGTIME_MOD)
 		inode->i_mtime = tv;
-	if (flags & XFS_ICHGTIME_CHG)
-		inode_set_ctime_to_ts(inode, tv);
 	if (flags & XFS_ICHGTIME_CREATE)
 		ip->i_crtime = tv;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..af4a54756113 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -559,6 +559,7 @@ xfs_vn_getattr(
 	struct xfs_mount	*mp = ip->i_mount;
 	vfsuid_t		vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid_t		vfsgid = i_gid_into_vfsgid(idmap, inode);
+	struct timespec64	ctime;
 
 	trace_xfs_getattr(ip);
 
@@ -573,8 +574,23 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
-	stat->ctime = inode_get_ctime(inode);
+	stat->mtime = timestamp_truncate_to_gran(inode->i_mtime, NSEC_PER_SEC/HZ);
+
+	/*
+	 * Don't bother flagging the inode for a fine-grained update unless
+	 * STATX_CHANGE_COOKIE is set, in which case, use the fine-grained
+	 * value to fake up a change_cookie.
+	 */
+	if (request_mask & STATX_CHANGE_COOKIE) {
+		ctime = inode_query_ctime(inode);
+		stat->change_cookie = time_to_chattr(&ctime);
+		stat->result_mask |= STATX_CHANGE_COOKIE;
+	} else {
+		ctime = inode_get_ctime(inode);
+	}
+
+	stat->ctime = timestamp_truncate_to_gran(ctime, NSEC_PER_SEC/HZ);
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -914,12 +930,8 @@ xfs_setattr_size(
 	 * these flags set.  For all other operations the VFS set these flags
 	 * explicitly if it wants a timestamp update.
 	 */
-	if (newsize != oldsize &&
-	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
-		iattr->ia_ctime = iattr->ia_mtime =
-			current_time(inode);
+	if (newsize != oldsize)
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
-	}
 
 	/*
 	 * The first thing we do is set the size to new_size permanently on
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b5c202f5d96c..1f77014c6e1a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2065,7 +2065,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("xfs");
 

-- 
2.41.0

