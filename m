Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1F600D30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJQK6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJQK52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0061B0E;
        Mon, 17 Oct 2022 03:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3FCEB812AC;
        Mon, 17 Oct 2022 10:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7664FC433C1;
        Mon, 17 Oct 2022 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666004242;
        bh=pekK2QX2KgEQVYMZRaffG2V7y/r770DCCIDCn7vh39M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3Ky4C9q3L69subjakIcY7GefggWpp4am8aahclTk9o5/rR2lV9HA6L8t1/sxry5+
         ZJ0se7Xs9NyKsNFZdGHo+8LrlfexywLrAEeOiRCTHHngmUUmRF/C4MR3ldr/WslKGc
         vO72WVCpmN1rI4m6TTd8nCdu6UF7R+/nmoDnhSBMcNwGGOTwgZVwa2Xx45WJoHuP08
         j0aCxtYUFeg4TIFVHmzBxwwCzwe8q5M6sIbD4+2lWzYdKXwESDj/UsxKMxrd2AZrcS
         F9KuS57VqwxPG0acFwpX4R9uC1YwgBlkg5Eu0+Qdzjm5s18tz2x0+AsK3SJ5PtGkpA
         mXF0mCfXaMaAQ==
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
Subject: [PATCH v7 4/9] nfs: report the inode version in getattr if requested
Date:   Mon, 17 Oct 2022 06:57:04 -0400
Message-Id: <20221017105709.10830-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017105709.10830-1-jlayton@kernel.org>
References: <20221017105709.10830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfs/inode.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bea7c005119c..7ed1b4c9260a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -830,6 +830,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		reply_mask |= STATX_VERSION;
 	return reply_mask;
 }
 
@@ -848,7 +850,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
+			STATX_VERSION;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		if (readdirplus_enabled)
@@ -856,8 +859,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		goto out_no_revalidate;
 	}
 
-	/* Flush out writes to the server in order to update c/mtime.  */
-	if ((request_mask & (STATX_CTIME | STATX_MTIME)) &&
+	/* Flush out writes to the server in order to update c/mtime/version.  */
+	if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_VERSION)) &&
 	    S_ISREG(inode->i_mode))
 		filemap_write_and_wait(inode->i_mapping);
 
@@ -877,7 +880,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS)))
+					STATX_SIZE|STATX_BLOCKS|STATX_VERSION)))
 		goto out_no_revalidate;
 
 	/* Check whether the cached attributes are stale */
@@ -915,6 +918,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->version = inode_peek_iversion_raw(inode);
+	stat->attributes_mask |= STATX_ATTR_VERSION_MONOTONIC;
+	if (server->change_attr_type != NFS4_CHANGE_TYPE_IS_UNDEFINED)
+		stat->attributes |= STATX_ATTR_VERSION_MONOTONIC;
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 out:
-- 
2.37.3

