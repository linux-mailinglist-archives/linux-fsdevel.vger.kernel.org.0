Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F3595D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiHPN2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiHPN2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88209100B;
        Tue, 16 Aug 2022 06:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1842261389;
        Tue, 16 Aug 2022 13:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1725C433D7;
        Tue, 16 Aug 2022 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656483;
        bh=cTr5A+pQEYd+LPQGgUFgls+hS7mB/Fi2JYqeZ2/L04E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7ZCBf8imhM0/fi+Bb6NfnLwMInuUNICHVhP9lUxDn6lB576or/Oh0WkgeJIjOMhR
         Qpihrx/Ab8JhsIeG8ZcCAIHVkRRrC+6mrhkTIL88iA+zQHJX74GZbTHHI/b7fu5xyr
         K6vZQqIaxkYKT+qPXYXU+np/4RJEN6NkViu3FneJ1P9mFF/NQpw2t6HK/6Or1nvZDL
         z9Aykd7jAwAdPWpULqjHi3zKtqx/M6x/G2ABx5+uejQzjjFdwAuHsx4nyVjBF0jx1K
         4B0f3+3Dfe9KLqn5SDJLMBLoetft6m6dO66gT58EobehZ0ED85j3AvAF+hGX6JBEZO
         MBxUydG8+1Dqw==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH 2/4] nfs: report the change attribute if requested
Date:   Tue, 16 Aug 2022 09:27:57 -0400
Message-Id: <20220816132759.43248-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816132759.43248-1-jlayton@kernel.org>
References: <20220816132759.43248-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow NFS to report the i_version in statx. Since the cost to fetch it
is relatively cheap, do it unconditionally and just set the flag if it
looks like it's valid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..43e23ec2a64d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -829,6 +829,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		reply_mask |= STATX_CHANGE_ATTR;
 	return reply_mask;
 }
 
@@ -847,7 +849,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_CHANGE_ATTR;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		if (readdirplus_enabled)
@@ -876,7 +878,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS)))
+					STATX_SIZE|STATX_BLOCKS|STATX_CHANGE_ATTR)))
 		goto out_no_revalidate;
 
 	/* Check whether the cached attributes are stale */
@@ -914,6 +916,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->change_attr = inode_peek_iversion_raw(inode);
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 out:
-- 
2.37.2

