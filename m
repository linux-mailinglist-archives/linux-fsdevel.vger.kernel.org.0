Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DA67A2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjAXTa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjAXTam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1F4FC08;
        Tue, 24 Jan 2023 11:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B955B816BF;
        Tue, 24 Jan 2023 19:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12DC4339C;
        Tue, 24 Jan 2023 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588638;
        bh=yDVwbSk1G8DS4yHpQ7gC5EwIRzaFxGi8gk+oumcC//k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6zRsn2Tr6iCnqSH928m6R0lDRsD3DQyaplO0RptbM3aI2V1HNKQGGca5uYPTkJJQ
         q2VBCOoq/EQJwInWM0p0AOQqeWZ+4cT+sJ0WgRWzajpgQGsO/rA3HyNkX+O5+pSlPd
         MD6gi0QNNbae39amVCaOsJCeGjBxOpsxB4A2sXeuVfW1jDEXofXkH3nl0VoiO0Q1ev
         R3hWWmvuBXW3ppZHwAzMah1suxo8LPDe+yafIX/Zo5fnG3ZnrNPL5/huswno15uJ2F
         Q6g/SdeWVvJeQ3JZU4c+EKXnXRHZ9K1nvn9A5+8Nr+zajGWrHmcugS+neNRipm6ysx
         WSQBPIpAnE/Fw==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 RESEND 4/8] nfs: report the inode version in getattr if requested
Date:   Tue, 24 Jan 2023 14:30:21 -0500
Message-Id: <20230124193025.185781-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow NFS to report the i_version in getattr requests. Since the cost to
fetch it is relatively cheap, do it unconditionally and just set the
flag if it looks like it's valid. Also, conditionally enable the
MONOTONIC flag when the server reports its change attr type as such.

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e98ee7599eeb..756ad4fa6f2a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -825,6 +825,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		reply_mask |= STATX_CHANGE_COOKIE;
 	return reply_mask;
 }
 
@@ -843,7 +845,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
+			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		if (readdirplus_enabled)
@@ -851,8 +854,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		goto out_no_revalidate;
 	}
 
-	/* Flush out writes to the server in order to update c/mtime.  */
-	if ((request_mask & (STATX_CTIME | STATX_MTIME)) &&
+	/* Flush out writes to the server in order to update c/mtime/version.  */
+	if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANGE_COOKIE)) &&
 	    S_ISREG(inode->i_mode))
 		filemap_write_and_wait(inode->i_mapping);
 
@@ -872,7 +875,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS)))
+					STATX_SIZE|STATX_BLOCKS|
+					STATX_CHANGE_COOKIE)))
 		goto out_no_revalidate;
 
 	/* Check whether the cached attributes are stale */
@@ -910,6 +914,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->change_cookie = inode_peek_iversion_raw(inode);
+	stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
+	if (server->change_attr_type != NFS4_CHANGE_TYPE_IS_UNDEFINED)
+		stat->attributes |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 out:
-- 
2.39.1

