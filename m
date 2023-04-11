Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6426DDDDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDKO2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDKO1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D35BB6;
        Tue, 11 Apr 2023 07:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B67C962799;
        Tue, 11 Apr 2023 14:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C100C433D2;
        Tue, 11 Apr 2023 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223234;
        bh=6y1YeGPH/VDzbluu556WvHbrgod71MAnILEUbvu4oy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IymI7Pv0rtcsh15nq7onOJEP+gWsO4qna8uXbEuQwaEVOvwsKzPwh2hcFyUaF4Lrx
         XdYZai9OWXt7UKRbAg3BTWw/42rJ4yWtC+dwFzLLGNkVahk09bUFcduCvRM1PtXiLw
         m002LBg/IFOgaiQgOCspNScOrKbSzHygYmekp4HClAirdjNF3Mjta7Br3SMRvZ1Rs8
         HM61/lARWL0KAgsdQWzwTlXzaSZNHX9lmToIXAubJkrWLNqd+vMAe3mM1m2rG32YBI
         zDM8U6NpOEBIgE7Bl5vD5FaLjbFdKLB2ciLTdgD7mHHnnRJDt6pdJ3S+AA+P2K6IHv
         ChJgZLWcjeELQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH 3/3] xfs: mark the inode for high-res timestamp update in getattr
Date:   Tue, 11 Apr 2023 10:27:08 -0400
Message-Id: <20230411142708.62475-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411142708.62475-1-jlayton@kernel.org>
References: <20230411142708.62475-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the mtime or ctime is being queried via getattr, ensure that we
mark the inode for a high-res timestamp update on the next pass. Also,
switch to current_cmtime for other c/mtime updates.

With this change, we're better off having the NFS server just ignore
the i_version field and have it use the ctime instead, so clear the
STATX_CHANGE_COOKIE flag in the result mask in ->getattr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_acl.c                |  2 +-
 fs/xfs/xfs_inode.c              |  2 +-
 fs/xfs/xfs_iops.c               | 15 ++++++++++++---
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 8b5547073379..9ad7c229c617 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -63,7 +63,7 @@ xfs_trans_ichgtime(
 	ASSERT(tp);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 
-	tv = current_time(inode);
+	tv = current_cmtime(inode);
 
 	if (flags & XFS_ICHGTIME_MOD)
 		inode->i_mtime = tv;
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 791db7d9c849..461adc58cf8c 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -233,7 +233,7 @@ xfs_acl_set_mode(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	inode->i_mode = mode;
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_cmtime(inode);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	if (xfs_has_wsync(mp))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5808abab786c..80f9d731e261 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -843,7 +843,7 @@ xfs_init_new_inode(
 	ip->i_df.if_nextents = 0;
 	ASSERT(ip->i_nblocks == 0);
 
-	tv = current_time(inode);
+	tv = current_cmtime(inode);
 	inode->i_mtime = tv;
 	inode->i_atime = tv;
 	inode->i_ctime = tv;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 24718adb3c16..a0b07f90e16c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -565,6 +565,15 @@ xfs_vn_getattr(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	/*
+	 * XFS uses the i_version infrastructure to track any change to
+	 * the inode, including atime updates. This means that the i_version
+	 * returned by getattr doesn't conform to what the callers expect.
+	 * Clear it here so that nfsd will fake up a change cookie from the
+	 * ctime instead.
+	 */
+	stat->result_mask &= ~STATX_CHANGE_COOKIE;
+
 	stat->size = XFS_ISIZE(ip);
 	stat->dev = inode->i_sb->s_dev;
 	stat->mode = inode->i_mode;
@@ -573,8 +582,8 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	if (request_mask & (STATX_CTIME|STATX_MTIME))
+		fill_cmtime_and_mark(inode, stat);
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -917,7 +926,7 @@ xfs_setattr_size(
 	if (newsize != oldsize &&
 	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
 		iattr->ia_ctime = iattr->ia_mtime =
-			current_time(inode);
+			current_cmtime(inode);
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
 	}
 
-- 
2.39.2

