Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C260779E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJUNGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJUNGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481426CDC5;
        Fri, 21 Oct 2022 06:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E96DEB82BCD;
        Fri, 21 Oct 2022 13:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA703C433D7;
        Fri, 21 Oct 2022 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357574;
        bh=UIL2cdGHjlT4RFj+Zgh2BsP14ice/GgwMMKCqzmvxBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsLE0fMHuJHPV6jz4Jziq/1iKtp4QV0jMIKjsH2Fz39fKLYKNvUrT4tAb7kgIxVeL
         SABL1AjbgKF5nDj3REqecr/dsLjjHRo8gDEioYaGR/moQ7nfQDH/YjJWZMu0nj1+su
         waaqxNgnmTafxvGCW4llU47U1OyTG5dfzyVWMGiF5c6GQ56/3f4ijCuSJL25jq4mSa
         VQnhkUyk+66LRvO82fjULKBIpFMFh9hN4rnI9S5bksB3mrMj5ogLbV5WWUyvsCXmiR
         djAuad9OAO2t+J1WicuSzVZPCDaa6r/NiswX76H/tpHQvsQ4t/EmXBB+Mh+VtWjURt
         3OsND8of17C1Q==
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
Subject: [PATCH v8 4/8] nfs: report the inode version in getattr if requested
Date:   Fri, 21 Oct 2022 09:05:58 -0400
Message-Id: <20221021130602.99099-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021130602.99099-1-jlayton@kernel.org>
References: <20221021130602.99099-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6b2cfa59a1a2..f70f11df1ee0 100644
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
2.37.3

